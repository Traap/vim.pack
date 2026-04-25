local plugin = require("traap.plugins.util")

local blink_path = vim.fs.joinpath(vim.fn.stdpath("data"), "site", "pack", "core", "opt", "blink.cmp")
if vim.fn.isdirectory(blink_path) == 0 then
  return
end

if not vim.o.runtimepath:find(vim.pesc(blink_path), 1, true) then
  vim.opt.runtimepath:append(blink_path)
end

local blink = plugin.require("blink.cmp")
if not blink or type(blink.setup) ~= "function" then
  return
end

blink.setup({
  appearance = {
    nerd_font_variant = "mono",
  },
  keymap = { preset = "default" },
  completion = {
    documentation = { auto_show = false },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  fuzzy = {
    implementation = "lua",
  },
})
