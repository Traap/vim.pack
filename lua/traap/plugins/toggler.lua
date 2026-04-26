local plugin = require("traap.core.plugin")

plugin.setup("nvim-toggler", "nvim-toggler", {
  inverses = {
    [">="] = "<=",
    [">"] = "<",
  },
  remove_default_keybinds = true,
  remove_default_inverses = false,
})
