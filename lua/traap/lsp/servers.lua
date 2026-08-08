local M = {}

M.definitions = {
  bash = { name = "bashls", filetypes = { "sh", "bash", "zsh" } },
  csharp = { name = "csharp_ls", filetypes = { "cs", "vb", "c_sharp" } },
  cpp = {
    name = "clangd",
    filetypes = { "c", "cpp", "objc", "objcpp" },
    opts = {
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed",
        "--header-insertion=never",
      },
    },
  },
  css = { name = "cssls", filetypes = { "css", "less", "scss" } },
  go = { name = "gopls", filetypes = { "go", "gomod" } },
  html = { name = "html", filetypes = { "html" } },
  java = { name = "jdtls", filetypes = { "java" } },
  json = { name = "jsonls", filetypes = { "json", "jsonc" } },
  julia = { name = "julials", filetypes = { "julia" } },
  latex = { name = "ltex", filetypes = { "latex" } },
  lua = {
    name = "lua_ls",
    filetypes = { "lua" },
    opts = function()
      return {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim", "Snacks" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
          },
        },
      }
    end,
  },
  markdown = { name = "marksman", filetypes = { "markdown" } },
  nix = { name = "nixd", filetypes = { "nix" }, mason = false },
  python = { name = "pyright", filetypes = { "python" } },
  qml = { name = "qmlls", filetypes = { "qml", "qmljs" } },
  ruby = {
    name = "solargraph",
    filetypes = { "ruby" },
    mason = false,
    opts = {
      cmd = { "mise", "exec", "ruby@4.0.0", "--", "solargraph", "stdio" },
    },
  },
  rust = { name = "rust_analyzer", filetypes = { "rust" } },
  sql = { name = "sqls", filetypes = { "sql" } },
  svelte = { name = "svelte", filetypes = { "svelte" } },
  tex = { name = "texlab", filetypes = { "bib", "tex" } },
  toml = { name = "taplo", filetypes = { "toml" } },
  typescript = {
    name = "ts_ls",
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  },
  vim = { name = "vimls", filetypes = { "vim" } },
  xml = { name = "lemminx", filetypes = { "xml" } },
  yaml = { name = "yamlls", filetypes = { "yaml", "yml" } },
  zig = { name = "zls", filetypes = { "zig" } },
}

function M.filetypes()
  local result = {}
  for _, definition in pairs(M.definitions) do
    vim.list_extend(result, definition.filetypes)
  end
  return result
end

function M.for_filetype(filetype)
  for _, definition in pairs(M.definitions) do
    if vim.tbl_contains(definition.filetypes, filetype) then
      return definition
    end
  end
end

function M.for_name(name)
  for _, definition in pairs(M.definitions) do
    if definition.name == name then
      return definition
    end
  end
end

function M.names(include_external)
  local result = {}
  for _, definition in pairs(M.definitions) do
    if include_external or definition.mason ~= false then
      result[#result + 1] = definition.name
    end
  end
  table.sort(result)
  return result
end

function M.options(definition)
  return type(definition.opts) == "function" and definition.opts() or definition.opts or {}
end

return M
