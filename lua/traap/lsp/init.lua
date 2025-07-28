-- Enable LSP

local filetype_to_server = {
  biome = {
    name = 'biome',
    filetypes = { 'javascript', 'typescript', 'json' },
  },
  cpp = {
    name = 'clangd',
    filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
  },
  csharp = {
    name = 'omnisharp',
    filetypes = { 'cs', 'vb' },
  },
  css = {
    name = 'cssls',
    filetypes = { 'css', 'less', 'scss' },
  },
  emmet = {
    name = 'emmetls',
    filetypes = {
      "astro", "css", "eruby", "html", "htmlangular", "htmldjango",
      "javascriptreact", "less", "pug", "sass", "scss",
      "svelte", "typescriptreact", "vue",
    },
  },
  python = {
    name = 'pyright',
    filetypes = { 'python' },
  },
  go = {
    name = 'gopls',
    filetypes = { 'go', 'gomod' },
  },
  json = {
    name = 'jsonls',
    filetypes = { 'json', 'jsonc' },
  },
  lua = {
    name = 'lua_ls',
    filetypes = { 'lua' },
  },
  ruby = {
    name = 'solargraph',
    filetypes = { 'ruby' },
  },
  rust = {
    name = 'rust_analyzer',
    filetypes = { 'rust' },
  },
  sh = {
    name = 'bashls',
    filetypes = { 'sh', 'bash', 'zsh' },
  },
  tinymist = {
    name = 'tinymist',
    filetypes = { 'typst' },
  },
  sql = {
    name = 'sqlls',
    filetypes = { 'sql' },
  },
  tex = {
    name = 'texlab',
    filetypes = { 'bib', 'latex', 'tex' },
  },
  typescript = {
    name = 'tsserver',
    filetypes = {
      'javascript', 'javascriptreact',
      'typescript', 'typescriptreact',
    },
  },
  yaml = {
    name = 'yamlls',
    filetypes = { 'yaml', 'yml' },
  },
}

-- Collect server names
local enabled_servers = {}
local seen = {}

for _, entry in pairs(filetype_to_server) do
  if entry.name and not seen[entry.name] then
    table.insert(enabled_servers, entry.name)
    seen[entry.name] = true
  end
end

vim.lsp.enable(enabled_servers)

-- Diagnostics
vim.diagnostic.config({ virtual_lines = { current_line = true } })

