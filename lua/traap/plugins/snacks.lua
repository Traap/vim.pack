-- config/snacks/init.lua
local plugin = require("traap.core.plugin")

local snacks = plugin.setup("snacks.nvim", "snacks", {
  bigfile = { enabled = true },
  dashboard = { enabled = false },
  explorer = { enabled = true },
  git = { enabled = true },
  gitbrowse = { enabled = true },
  indent = { enabled = false },
  input = { enabled = true },
  image = { enabled = (vim.uv.os_uname().sysname ~= "Windows_NT") },
  notifier = {
    enabled = true,
    timeout = 3000,
    top_down = false,
    title_pos = "left",
  },
  picker = {
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
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = false },
  statuscolumn = { enabled = true },
  styles = {
    notification = {
      -- wo = { wrap = true }
    },
  },
  toggle = {
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
  words = { enabled = true },
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
