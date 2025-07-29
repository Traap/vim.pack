-- config/snacks/init.lua
local snacks = require("snacks")
snacks.setup({
  bigfile = { enabled = true },
  dashboard = { enabled = false },
  explorer = { enabled = true },
  indent = { enabled = false },
  input = { enabled = true },
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
        win = {
          input = {
            keys = {
              ["<c-h>"] = {
                mode = { "i", "n" },
                function()
                  require("nvim-tmux-navigation").NvimTmuxNavigateLeft()
                end,
              },
              ["<c-j>"] = {
                mode = { "i", "n" },
                function()
                  require("nvim-tmux-navigation").NvimTmuxNavigateDown()
                end,
              },
              ["<c-k>"] = {
                mode = { "i", "n" },
                function()
                  require("nvim-tmux-navigation").NvimTmuxNavigateUp()
                end,
              },
              ["<c-l>"] = {
                mode = { "i", "n" },
                function()
                  require("nvim-tmux-navigation").NvimTmuxNavigateRight()
                end,
              },
            },
          },
          list = {
            keys = {
              ["<c-h>"] = {
                mode = { "i", "n" },
                function()
                  require("nvim-tmux-navigation").NvimTmuxNavigateLeft()
                end,
              },
              ["<c-j>"] = {
                mode = { "i", "n" },
                function()
                  require("nvim-tmux-navigation").NvimTmuxNavigateDown()
                end,
              },
              ["<c-k>"] = {
                mode = { "i", "n" },
                function()
                  require("nvim-tmux-navigation").NvimTmuxNavigateUp()
                end,
              },
              ["<c-l>"] = {
                mode = { "i", "n" },
                function()
                  require("nvim-tmux-navigation").NvimTmuxNavigateRight()
                end,
              },
            },
          },
        },
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

