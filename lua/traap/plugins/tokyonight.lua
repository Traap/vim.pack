local plugin = require("traap.core.plugin")

plugin.setup("tokyonight.nvim", "tokyonight", {
  style = "night",
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    sidebars = "transparent",
    floats = "transparent",
    hide_inactive_statusline = true,
    lualine_bold = true,
  },
  transparent = true,
  on_colors = function(colors)
    colors.border = "#bb9af7"
  end
})
