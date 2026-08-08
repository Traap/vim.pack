vim.cmd("set completeopt+=noselect")
vim.cmd("hi statusline guibg=NONE")
vim.cmd("colorscheme tokyonight-night")

vim.api.nvim_create_user_command("Lazy", function()
  vim.pack.update()
end, { desc = "Update plugins with vim.pack" })

vim.api.nvim_create_user_command("LspInfo", function()
  vim.cmd("checkhealth vim.lsp")
end, { desc = "Show native LSP health information" })
