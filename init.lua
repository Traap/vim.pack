-- {{{ Neovim global options.

vim.g.mapleader = " "

-- ------------------------------------------------------------------------- }}}
-- {{{ Neovim options are listed alphabetically.

vim.opt.clipboard = "unnamedplus"
vim.opt.foldlevel = 0
vim.opt.foldmethod = "marker"
vim.opt.number = true
vim.opt.relativenumber = true;
vim.opt.signcolumn = "yes"
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.winborder = "rounded"
vim.opt.wrap = false

-- ------------------------------------------------------------------------- }}}
-- {{{ Neovim plugins

vim.pack.add({
  { src = "https://github.com/chomosuke/typst-preview.nvim", lazy=true },
  { src = "https://github.com/neovim/nvim-lspconfig", lazy=true },
  { src = "https://github.com/nvim-neo-tree/neo-tree.nvim", lazy=true },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", lazy=true},
  { src = "https://github.com/MunifTanjim/nui.nvim", lazy=true },
  { src = "https://github.com/christoomey/vim-tmux-navigator", lazy=false},
  { src = "https://github.com/folke/tokyonight.nvim", lazy=false},
  { src = "https://github.com/nvim-lua/plenary.nvim", lazy=true },
  { src = "https://github.com/nvim-tree/nvim-web-devicons", lazy=true },
  { src = "https://github.com/vim-utils/vim-most-minimal-folds", lazy=false},
})

-- ------------------------------------------------------------------------- }}}
-- {{{ Configure plugins

require("nvim-web-devicons").setup()

require("neo-tree").setup({
  filesystem = {
    bind_to_cwd = false,
    follow_current_file = { enabled = true }
  },
  window = { position = "right" }
})


-- ------------------------------------------------------------------------- }}}
-- {{{ Enable LSP

local filetype_to_server = {
  biome = {
    name = 'biome',
    filetypes = { 'javascript', 'typescript', 'json' },
  },
  cpp = {
    name = 'clangd',
    filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
  },
  csharp = {
    name = 'omnisharp',
    filetypes = { 'cs', 'vb' },
  },
  css = {
    name = 'cssls',
    filetypes = { 'css', 'less', 'scss' },
  },
  emmet = {
    name = 'emmetls',
    filetypes = {
      "astro", "css", "eruby", "html", "htmlangular", "htmldjango",
      "javascriptreact", "less", "pug", "sass", "scss",
      "svelte", "typescriptreact", "vue",
    },
  },
  python = {
    name = 'pyright',
    filetypes = { 'python' },
  },
  go = {
    name = 'gopls',
    filetypes = { 'go', 'gomod' },
  },
  json = {
    name = 'jsonls',
    filetypes = { 'json', 'jsonc' },
  },
  lua = {
    name = 'lua_ls',
    filetypes = { 'lua' },
  },
  ruby = {
    name = 'solargraph',
    filetypes = { 'ruby' },
  },
  rust = {
    name = 'rust_analyzer',
    filetypes = { 'rust' },
  },
  sh = {
    name = 'bashls',
    filetypes = { 'sh', 'bash', 'zsh' },
  },
  tinymist = {
    name = 'tinymist',
    filetypes = { 'typst' },
  },
  sql = {
    name = 'sqlls',
    filetypes = { 'sql' },
  },
  tex = {
    name = 'texlab',
    filetypes = { 'bib', 'latex', 'tex' },
  },
  typescript = {
    name = 'tsserver',
    filetypes = {
      'javascript', 'javascriptreact',
      'typescript', 'typescriptreact',
    },
  },
  yaml = {
    name = 'yamlls',
    filetypes = { 'yaml', 'yml' },
  },
}
-- Collect server names
local enabled_servers = {}
local seen = {}

for _, entry in pairs(filetype_to_server) do
  if entry.name and not seen[entry.name] then
    table.insert(enabled_servers, entry.name)
    seen[entry.name] = true
  end
end

vim.lsp.enable(enabled_servers)

-- ------------------------------------------------------------------------- }}}
-- {{{ Treesitter

local treesitter_parsers = {
  "bash", "c", "c_sharp", "cpp", "dockerfile", "go", "html",
  "javascript", "json", "jsonc", "lua", "markdown",
  "markdown_inline", "python", "query", "regex", "ruby",
  "sql", "toml", "tsx", "typescript", "vim", "vimdoc", "xml",
  "yaml",
}

require "nvim-treesitter.configs".setup({
	ensure_installed = treesitter_parsers,
	highlight = { enable = true }
})

-- ------------------------------------------------------------------------- }}}
-- {{{ Autocommands

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
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
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

-- ------------------------------------------------------------------------- }}}
-- {{{ User commands

vim.api.nvim_create_user_command("PluginStatus", function()
  for name, _ in pairs(vim.pack.entries()) do
    print(name, vim.pack.is_loaded(name))
  end
end, {})

-- ------------------------------------------------------------------------- }}}
-- {{{ Keymaps

-- Toggler Noetree
vim.keymap.set("n", "<leader>e", ":Neotree toggle<cr>")

-- Delete the current line.
vim.keymap.set("n", "-", "dd")

-- Select (charwise) the contents of the current line, excluding indentation.
vim.keymap.set("n", "vv", "^vg_")

-- Select entire buffer
vim.keymap.set("n", "vaa", "ggvGg_", {desc = "Select buffer char mode"})
vim.keymap.set("n", "Vaa", "ggVG", {desc = "Select buffer line mode "})

-- Toggle [in]visible characters.
vim.keymap.set("n", "<leader>i", "<cmd>set list!<cr>")

-- Stay in indent mode.
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Close all fold except the current one.
vim.keymap.set("n", "zv", "zMzvzz", {desc='Close all folds except current'})

-- Close current fold when open. Always open next fold.
vim.keymap.set("n", "zj", "zcjzOzz")

-- Close current fold when open. Always open previous fold.
vim.keymap.set("n", "zk", "zckzOzz")

-- Keep the cursor in place while joining lines.
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<leader>J", "myvipJ`ygq<cr>")

-- File saving and sourcing.
vim.keymap.set("n", "<leader>q", ":quit<cr>")
vim.keymap.set("n", "<leader>s", ":update<cr> :.lua<cr> :echo 'Sourced ' . @%<cr>")
vim.keymap.set("n", "<leader>w", ":write<cr>")

-- Only this windows.
vim.keymap.set("n", "<leader>oo", ":only<cr>")

-- Yank and delete from unmamedplus buffer.
vim.keymap.set({"n", "v", "x"}, "<leader>d", '"+d')
vim.keymap.set({"n", "v", "x"}, "<leader>y", '"+y')

-- Execute the current line of text as a shell command.
vim.keymap.set("n", "<localleader>E",
  [[0mMvg_"ky :exec "r!" getreg("k")<cr>]]
)

vim.keymap.set("v", "<localleader>E",
  [["ky :exec "r!" getreg("k")<cr>]]
)

-- Clear highlited
vim.keymap.set("n", "<leader><space>", ":nohlsearch<cr>")

-- Delete buffer contents.
vim.keymap.set("n","<leader>G", "ggdG")

-- Linewise reselection of what you just pasted.
vim.keymap.set("n", "<leader>VV", "V`]")

-- Splits
vim.keymap.set("n", "<leader>sj", "<cmd>split<cr>")
vim.keymap.set("n", "<leader>sl", "<cmd>vsplit<cr>")

-- Remove Windoz line ending.
vim.keymap.set("n", "<leader>wr",
  [[mz<cmd>%s/\r//g<cr><cmd>let @/=''<cr>`z]]
)

-- Convert tab to 2 spaces.
vim.keymap.set("n", "<leader>wt",
  [[mz<cmd>%s/\t/  /g<cr><cmd>let @/=''<cr>`z]]
)

-- Remove line end and trailing white spaces.
vim.keymap.set("n", "<leader>ww",
  [[mz<cmd>%s/\s\+$//e<cr><cmd>let @/=''<cr>`z]]
)

-- Delete emplty lines
vim.keymap.set("n", "<leader>wl", "<cmd>g/^\\s*$/d<CR>")

-- Replace tab with pipe.
vim.keymap.set("n", "<leader>|", "<cmd>%s/\t/|/g<CR>")

-- Remove [ and ]
vim.keymap.set("n", "<leader>]", [[:%s/\[\|\]//g<CR>]]
)

-- ------------------------------------------------------------------------- }}}
-- {{{ Neovim commands.

vim.cmd("set completeopt+=noselect")
vim.cmd("hi statusline guibg=NONE")
vim.cmd("colorscheme tokyonight-night")

-- ------------------------------------------------------------------------- }}}
