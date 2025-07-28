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
