-- config/snacks/init.lua
local plugin = require("traap.core.plugin")

local function startup_stats()
  local plugins = vim.pack.get(nil, { info = false })
  local active = vim.tbl_count(vim.tbl_filter(function(entry)
    return entry.active
  end, plugins))
  local elapsed_ms = (vim.uv.hrtime() - vim.g.traap_start_time) / 1e6

  return {
    align = "center",
    text = ("⚡ Neovim loaded %d/%d plugins in %.2f ms")
        :format(active, #plugins, elapsed_ms),
  }
end

local snacks = plugin.setup("snacks.nvim", "snacks", {
  bigfile      = { enabled = true },
  dashboard    = {
    enabled = true,
    preset = { header = [[Configured by Traap and powered by vim.pack.]] },
    sections = {
      { section = "header" },
      { section = "keys", gap = 1, padding = 1 },
      startup_stats,
    },
  },
  dim          = { enabled = false },
  gh           = { enabled = false },
  explorer     = { enabled = true },
  git          = { enabled = true },
  gitbrowse    = { enabled = true },
  image        = { enabled = (vim.uv.os_uname().sysname ~= "Windows_NT") },
  indent       = { enabled = false },
  input        = { enabled = true },
  notifier     = {
    enabled = true,
    timeout = 3000,
    top_down = false,
    title_pos = "left",
  },
  picker       = {
    enabled = true,
    sources = {
      explorer = {
        layout = {
          layout = {
            position = "right",
          },
        },
      },
    },
  },
  quickfile    = { enabled = true },
  rename       = { enabled = true },
  scope        = { enabled = true },
  scratchfile  = { enabled = false },
  scroll       = { enabled = false },
  statuscolumn = { enabled = true },
  styles       = {
    notification = {
      -- wo = { wrap = true }
    },
  },
  terminal     = { enabled = false },
  toggle       = {
    map = vim.keymap.set,
    which_key = true,
    notify = true,
    icon = {
      enabled = " ",
      disabled = " ",
    },
    color = {
      enabled = "green",
      disabled = "yellow",
    },
    wk_desc = {
      enabled = "Disable ",
      disabled = "Enable ",
    },
  },
  util         = { enabled = false },
  win          = { enabled = false },
  words        = { enabled = true },
  zen          = { enabled = true },
})

if not snacks then
  return
end

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    snacks.toggle.inlay_hints():map("yoh")
    snacks.toggle.indent():map("yoi")
    snacks.toggle.line_number():map("yon")
    snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("yor")
    snacks.toggle.option("spell", { name = "Spelling" }):map("yos")
    snacks.toggle.treesitter():map("yot")
    snacks.toggle.option("wrap", { name = "Wrap" }):map("yow")

    snacks.toggle.diagnostics():map("<leader>ud")
    snacks.toggle.option("conceallevel", {
      off = 0,
      on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2,
    }):map("<leader>uc")
    snacks.toggle.option("background", {
      off = "light",
      on = "dark",
      name = "Dark Background",
    }):map("<leader>ub")
    snacks.toggle.dim():map("<leader>uD")
  end,
})
