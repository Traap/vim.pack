-- Enable LSP

local language_servers = require("traap.config.lsp_servers").language_servers

-- Collect server names
for _, entry in pairs(language_servers) do
  vim.lsp.enable(entry.name)
end

-- Diagnostics
vim.diagnostic.config({ virtual_lines = { current_line = true } })
