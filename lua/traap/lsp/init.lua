local M = {}
local servers = require("traap.lsp.servers")
local states = {}
local registry_ready = false
local registry_refreshing = false
local pending = {}

local capabilities
do
  local ok, blink = pcall(require, "blink.cmp")
  if ok and type(blink.get_lsp_capabilities) == "function" then
    capabilities = blink.get_lsp_capabilities({
      experimental = { ghostText = true },
    })
  end
end

local formatting_group = vim.api.nvim_create_augroup("traap_lsp_formatting", { clear = true })

local function on_attach(client, bufnr)
  if not client:supports_method("textDocument/formatting") then
    return
  end

  vim.api.nvim_clear_autocmds({ group = formatting_group, buffer = bufnr })
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = formatting_group,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format({ async = false, bufnr = bufnr })
    end,
  })
end

local function activate(definition)
  local name = definition.name
  if states[name] == "enabled" then
    return
  end

  local opts = vim.tbl_deep_extend("force", {
    capabilities = capabilities,
    on_attach = on_attach,
  }, servers.options(definition))

  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
  states[name] = "enabled"

  -- A server installed after FileType has already fired needs the native LSP
  -- activation callback replayed for matching, existing buffers.
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if
        vim.api.nvim_buf_is_loaded(bufnr)
        and vim.tbl_contains(definition.filetypes, vim.bo[bufnr].filetype)
    then
      pcall(vim.api.nvim_exec_autocmds, "FileType", {
        buffer = bufnr,
        group = "nvim.lsp.enable",
        modeline = false,
      })
    end
  end
end

local function install_and_activate(definition)
  local name = definition.name
  local registry = require("mason-registry")
  local mappings = require("mason-lspconfig").get_mappings().lspconfig_to_package
  local package_name = definition.package or mappings[name]

  if not package_name then
    states[name] = nil
    vim.notify("No Mason package mapping for LSP server: " .. name, vim.log.levels.ERROR)
    return
  end

  local package = registry.get_package(package_name)
  if package:is_installed() then
    activate(definition)
    return
  end

  vim.notify("Installing LSP server " .. name .. " (" .. package_name .. ")")
  package:install({}, function(success, err)
    vim.schedule(function()
      if success then
        activate(definition)
        vim.notify("Installed LSP server: " .. name)
      else
        states[name] = nil
        vim.notify(
          "Failed to install LSP server " .. name .. ": " .. tostring(err),
          vim.log.levels.ERROR
        )
      end
    end)
  end)
end

function M.ensure(definition)
  if not definition or states[definition.name] then
    return
  end

  if definition.mason == false then
    activate(definition)
    return
  end

  states[definition.name] = "installing"
  pending[definition.name] = definition

  if registry_ready then
    pending[definition.name] = nil
    install_and_activate(definition)
    return
  end

  if registry_refreshing then
    return
  end

  registry_refreshing = true
  require("mason-registry").refresh(function(success, err)
    vim.schedule(function()
      registry_refreshing = false
      if success then
        registry_ready = true
        local queued = pending
        pending = {}
        for _, queued_definition in pairs(queued) do
          install_and_activate(queued_definition)
        end
      else
        for name in pairs(pending) do
          states[name] = nil
        end
        pending = {}
        vim.notify("Failed to refresh Mason registry: " .. tostring(err), vim.log.levels.ERROR)
      end
    end)
  end)
end

function M.restart(names, force)
  for _, name in ipairs(names) do
    vim.lsp.enable(name, false)
    states[name] = nil
    if force then
      for _, client in ipairs(vim.lsp.get_clients({ name = name })) do
        client:stop(true)
      end
    end
  end

  vim.defer_fn(function()
    for _, name in ipairs(names) do
      M.ensure(servers.for_name(name))
    end
  end, 500)
end

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("traap_lsp_install", { clear = true }),
  pattern = servers.filetypes(),
  callback = function(event)
    M.ensure(servers.for_filetype(event.match))
  end,
})

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
  virtual_lines = { current_line = true },
})

local function current_or_args(args)
  if #args > 0 then
    return args
  end
  local definition = servers.for_filetype(vim.bo.filetype)
  return definition and { definition.name } or {}
end

vim.api.nvim_create_user_command("LspLog", function()
  vim.cmd.tabnew(vim.lsp.log.get_filename())
end, { desc = "Open the Neovim LSP log" })

vim.api.nvim_create_user_command("LspStart", function(info)
  for _, name in ipairs(current_or_args(info.fargs)) do
    M.ensure(servers.for_name(name))
  end
end, { complete = function() return servers.names(true) end, nargs = "*" })

vim.api.nvim_create_user_command("LspRestart", function(info)
  local names = #info.fargs > 0 and info.fargs or vim
      .iter(vim.lsp.get_clients())
      :map(function(client) return client.name end)
      :totable()
  M.restart(names, info.bang)
end, { bang = true, complete = function() return servers.names(true) end, nargs = "*" })

vim.api.nvim_create_user_command("LspStop", function(info)
  local names = #info.fargs > 0 and info.fargs or vim
      .iter(vim.lsp.get_clients())
      :map(function(client) return client.name end)
      :totable()
  for _, name in ipairs(names) do
    vim.lsp.enable(name, false)
    states[name] = nil
    if info.bang then
      for _, client in ipairs(vim.lsp.get_clients({ name = name })) do
        client:stop(true)
      end
    end
  end
end, { bang = true, complete = function() return servers.names(true) end, nargs = "*" })

return M
