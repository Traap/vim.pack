local plugin = require("traap.core.plugin")

plugin.load("mason.nvim")
require("mason").setup({})

plugin.load("nvim-lspconfig")
plugin.load("mason-lspconfig.nvim")
require("mason-lspconfig").setup({
  ensure_installed = {},
  automatic_enable = false,
})
