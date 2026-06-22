-- Make direct `nvim -u /path/to/init.lua` invocations resolve local modules.
local config_file = debug.getinfo(1, "S").source:sub(2)
vim.opt.runtimepath:prepend(vim.fn.fnamemodify(config_file, ":p:h"))

-- Take control of my leader keys.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load configuration.
require("traap.config.options")
require("traap.plugins")
require("traap.lsp")
require("traap.config.autocmds")
require("traap.config.keymaps")
require("traap.config.cmd")
