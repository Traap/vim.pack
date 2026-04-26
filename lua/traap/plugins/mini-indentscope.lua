local plugin = require("traap.core.plugin")

plugin.setup("mini.indentscope", "mini.indentscope", {
  draw = {
    animation = require('mini.indentscope').gen_animation.none(),
    delay = 0,
  },
  symbol = "│",
})
