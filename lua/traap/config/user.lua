vim.api.nvim_create_user_command("PluginStatus", function()
  for name, _ in pairs(vim.pack.entries()) do
    print(name, vim.pack.is_loaded(name))
  end
end, {})
