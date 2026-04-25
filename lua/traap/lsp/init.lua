-- Enable LSP

local language_servers = require("traap.config.lsp_servers").language_servers
local capabilities

do
  local ok, blink = pcall(require, "blink.cmp")
  if ok and type(blink.get_lsp_capabilities) == "function" then
    capabilities = blink.get_lsp_capabilities()
  end
end

if capabilities then
  vim.lsp.config("*", {
    capabilities = capabilities,
  })
end

-- Collect server names
for _, entry in pairs(language_servers) do
  vim.lsp.enable(entry.name)
end

-- Diagnostics
vim.diagnostic.config({ virtual_lines = { current_line = true } })
