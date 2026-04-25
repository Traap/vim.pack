local plugin = require("traap.plugins.util")

plugin.load("mini.indentscope")

local mini_indentscope = plugin.require("mini.indentscope")

if mini_indentscope then
  mini_indentscope.setup({
    draw = {
      animation = mini_indentscope.gen_animation.none(),
      delay = 0,
    },
    symbol = "│",
  })
end
