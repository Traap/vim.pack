local plugin = require("traap.core.plugin")

plugin.setup("which-key.nvim", "which-key", {
  vim.o.timeout = true
  vim.o.timeoutlen = 300
  plugins = { spelling = true }
  preset = "modern"
})
