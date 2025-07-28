-- Enable LSP

local language_servers = require("traap.config.lsp_servers").language_servers

-- Collect server names
local enabled_servers = {}
local seen = {}

for _, entry in pairs(language_servers) do
  if entry.name and not seen[entry.name] then
    table.insert(enabled_servers, entry.name)
    seen[entry.name] = true
  end
end

vim.lsp.enable(enabled_servers)

-- Diagnostics
vim.diagnostic.config({ virtual_lines = { current_line = true } })

