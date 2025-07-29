-- Take control of my leader keys.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load configuration.
require("traap.config.options")
require("traap.plugins")
require("traap.lsp")
require("traap.config.treesitter")
require("traap.config.autocmds")
require("traap.config.keymaps")
require("traap.config.cmd")
