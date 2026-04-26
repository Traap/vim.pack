local plugin = require("traap.core.plugin")

vim.g.virtcolumn_char = "│"
vim.g.virtcolumn_priority = 10

plugin.load("virtcolumn.nvim")

vim.api.nvim_set_hl(0, "VirtColumn", { link = "ColorColumn" })
