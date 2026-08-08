local plugin = require("traap.core.plugin")

plugin.setup("todo-comments.nvim", "todo-comments", {
  merge_keywords = true,
  keywords = {
    YouTube = { icon = " ", color = "#ff0000", alt = { "youtube", "Youtube" } },
    URL = { icon = " ", color = "#7711FF", alt = { "Url", "url" } },
  },
})
