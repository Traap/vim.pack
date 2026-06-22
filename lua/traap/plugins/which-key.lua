local plugin = require("traap.core.plugin")

vim.o.timeout = true
vim.o.timeoutlen = 300

plugin.setup("which-key.nvim", "which-key", {
  plugins = { spelling = true },
  preset = "modern",
})
