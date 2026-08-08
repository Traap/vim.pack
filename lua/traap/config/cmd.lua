vim.cmd("set completeopt+=noselect")
vim.cmd("hi statusline guibg=NONE")
vim.cmd("colorscheme tokyonight-night")

vim.api.nvim_create_user_command("Lazy", function()
  vim.pack.update()
end, { desc = "Update plugins with vim.pack" })
