require("neo-tree").setup({
  filesystem = {
    bind_to_cwd = false,
    follow_current_file = { enabled = true }
  },
  window = { position = "right" }
})
