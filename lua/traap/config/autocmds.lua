-- Load typst on demand.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "typst",
  callback = function()
    vim.pack.load("typst-preview.nvim")
    require("typst-preview").setup()
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- LSP Attach.
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
      vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
      vim.keymap.set('i', '<C-Space>', function() vim.lsp.completion.get() end)
      vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { buffer = ev.buf })
    end
  end,
})

-- Automagically close command-line window.  I don't use it.
vim.api.nvim_create_autocmd({ "CmdWinEnter"}, {
  callback = function()
    vim.cmd "quit"
  end,
})

-- Color tweaks
vim.api.nvim_create_autocmd({"BufWinEnter", "ColorScheme" }, {
  pattern = {"*"},
  callback = function()

    -- NOTE: RGB values found in Tokyonight-night colors.

    -- Better Quick Fix
    vim.api.nvim_set_hl(0, "BqfPreviewBorder", { fg="#3b4261"})
    vim.api.nvim_set_hl(0, "BqfPrevieTitle", { fg="#3b4261"})
    vim.api.nvim_set_hl(0, "BqfPrevieThumb", { fg="#3b4261"})
    vim.cmd([[ hi link BqfPreviewRange Search ]])

    -- Cmp
    vim.api.nvim_set_hl(0, "CmpDocumentationBorder", { fg="#3b4261"})

    -- Harpoon
    vim.api.nvim_set_hl(0, "HarpoonBorder", { fg="#3b4261"})

    -- LspSaga
    vim.api.nvim_set_hl(0, "LspSagaSignatureHelpBorder", { fg="#3b4261"})
    vim.api.nvim_set_hl(0, "LspSagaCodeActionBorder", { fg="#3b4261"})
    vim.api.nvim_set_hl(0, "LspSagaDefPreviewBorder", { fg="#3b4261"})
    vim.api.nvim_set_hl(0, "LspSagaRenameBorder", { fg="#3b4261"})
    vim.api.nvim_set_hl(0, "LspSagaHoverBorder", { fg="#3b4261"})
    vim.api.nvim_set_hl(0, "LspSagaBorderTitle", { fg="#3b4261"})

    -- NeoTest
    vim.api.nvim_set_hl(0, "NeoTestBorder", { fg="#3b4261"})

    -- Folds
    vim.api.nvim_set_hl(0, "Folded", {fg="#6a79b3"})

    -- Line numbers
    vim.api.nvim_set_hl(0, "LineNr",      {fg="#e0af68"})
    vim.api.nvim_set_hl(0, "ColorColumn", {bg="#3b4261"})
    vim.api.nvim_set_hl(0, "LineNrAbove", {fg="#3b4261"})
    vim.api.nvim_set_hl(0, "LineNrBelow", {fg="#3b4261"})

    -- Telescope
    vim.api.nvim_set_hl(0, "TelescopeBorder",        { fg="#3b4261"})
    vim.api.nvim_set_hl(0, "TelescopePromptBorder",  { fg="#3b4261"})
    vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg="#3b4261"})
    vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg="#3b4261"})

    -- Lsp
    vim.api.nvim_set_hl(0, "LspInfoBorder",     { fg="#3b4261"})
    vim.api.nvim_set_hl(0, "LspFloatWinBorder", { fg="#3b4261"})

    -- Neovim
    vim.api.nvim_set_hl(0, "FloatBorder", { fg="#3b4261"})

    -- Noice
    vim.api.nvim_set_hl(0, "NoiceCmdlinePopup",                 { fg="#3b4261"})
    vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder",           { fg="#3b4261"})
    vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderCalculator", { fg="#3b4261"})
    vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderCmdline",    { fg="#3b4261"})
    vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderFilter",     { fg="#3b4261"})
    vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderHelp",       { fg="#3b4261"})
    vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderLua",        { fg="#3b4261"})
    vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderInput",      { fg="#3b4261"})
    vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderIncRename",  { fg="#3b4261"})
    vim.api.nvim_set_hl(0, "NoiceConfirmBorder",                { fg="#3b4261"})
    vim.api.nvim_set_hl(0, "NoicePopupBorder",                  { fg="#3b4261"})
    vim.api.nvim_set_hl(0, "NoicePopupmenuBorder",              { fg="#3b4261"})
    vim.api.nvim_set_hl(0, "NoiceSplitBorder",                  { fg="#3b4261"})

    -- Notify
    vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { fg="#3b4261"})
    vim.api.nvim_set_hl(0, "NotifyERRORBorder", { fg="#ff0000"})
    vim.api.nvim_set_hl(0, "NotifyINFOBorder",  { fg="#3b4261"})
    vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { fg="#3b4261"})
    vim.api.nvim_set_hl(0, "NotifyWARNBorder",  { fg="#e0af68"})

    -- Pmenu
    vim.api.nvim_set_hl(0, "Pmenu", { blend=100 } )
    vim.api.nvim_set_hl(0, "PmenuSel",      { fg="#e0af68", bg="#3b4261" } )
    vim.api.nvim_set_hl(0, "PmenuKindSel",  { fg="#e0af68", bg="#3b4261" } )
    vim.api.nvim_set_hl(0, "PmenuEstraSel", { fg="#e0af68", bg="#3b4261" } )

    -- WhichKey
    vim.api.nvim_set_hl(0, "WhichKeyBorder", { fg="#3b4261"})
  end,
})
