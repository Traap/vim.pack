local plugin = require("traap.plugins.util")

plugin.load("nvim-treesitter")

local configs = plugin.require("nvim-treesitter.configs")
if not configs then
  return
end

configs.setup({
  auto_install = false,
  highlight = { enable = true },
  indent = { enable = true },
})
