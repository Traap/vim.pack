local plugin = require("traap.core.plugin")

local data_path = vim.fn.stdpath("data")
local blink_paths = {
  vim.fs.joinpath(data_path, "site", "pack", "core", "opt", "blink.cmp"),
  vim.fs.joinpath(data_path, "lazy", "blink.cmp"),
}

local blink_path
for _, path in ipairs(blink_paths) do
  if vim.fn.isdirectory(path) == 1 then
    blink_path = path
    break
  end
end

if not blink_path then
  return
end

local lua_path = table.concat({
  vim.fs.joinpath(blink_path, "lua", "?.lua"),
  vim.fs.joinpath(blink_path, "lua", "?", "init.lua"),
}, ";")

if not package.path:find(vim.pesc(lua_path), 1, true) then
  package.path = lua_path .. ";" .. package.path
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
