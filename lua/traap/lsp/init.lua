-- Enable LSP

local language_servers = {
  biome = { name = 'bitbake-language-server', },
  cpp = { name = 'clangd', },
  csharp = { name = 'csharp-ls', },
  css = { name = 'cssls', },
  emmet = { name = 'emmetls', },
  python = { name = 'pyright', },
  go = { name = 'gopls', },
  json = { name = 'jsonls', },
  lua = { name = 'lua_ls', },
  ruby = { name = 'solargraph', },
  rust = { name = 'rust_analyzer', },
  sh = { name = 'bashls', },
  tinymist = { name = 'tinymist', },
  sql = { name = 'sqlls', },
  tex = { name = 'texlab', },
  typescript = { name = 'tsserver', },
  yaml = { name = 'yamlls', },
}

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

