local plugin = require("traap.core.plugin")

vim.g.mkdp_filetypes = { "markdown" }
vim.g.mkdp_theme = "dark"

plugin.load("markdown-preview.nvim")
