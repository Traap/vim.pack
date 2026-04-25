local M = {}

function M.setup()
  local plugin = require("traap.plugins.util")

  plugin.setup("typst-preview.nvim", "typst-preview", {})
end

return M
