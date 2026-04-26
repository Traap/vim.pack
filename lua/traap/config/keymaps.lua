-- Yank and delete from unmamedplus buffer.
vim.keymap.set({ "n", "v", "x" }, "<leader>d", '"+d')
vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y')


-- Fugitive


-- Find
vim.keymap.set("n", "<leader>fb", Snacks.picker.buffers, { desc = "Buffers" })

vim.keymap.set("n", "<leader>fc", function()
  Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Find Config File" })

vim.keymap.set("n", "<leader>ff", Snacks.picker.files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", Snacks.picker.git_files, { desc = "Find Git Files" })
vim.keymap.set("n", "<leader>fp", Snacks.picker.projects, { desc = "Projects" })
vim.keymap.set("n", "<leader>fr", Snacks.picker.recent, { desc = "Recent" })

-- Git
vim.keymap.set({ "n", "v" }, "<leader>gB", snacks.gitbrowse, { desc = "Git Browse" })
vim.keymap.set("n", "<leader>gL", Snacks.picker.git_log_line, { desc = "Git Log Line" })
vim.keymap.set("n", "<leader>gS", Snacks.picker.git_stash, { desc = "Git Stash" })
vim.keymap.set("n", "<leader>gb", Snacks.picker.git_branches, { desc = "Git Branches" })
vim.keymap.set("n", "<leader>gd", Snacks.picker.git_diff, { desc = "Git Diff (Hunks)" })
vim.keymap.set("n", "<leader>gf", Snacks.picker.git_log_file, { desc = "Git Log File" })
vim.keymap.set("n", "<leader>gl", Snacks.picker.git_log, { desc = "Git Log" })

-- Grep
vim.keymap.set("n", "<leader>sb", Snacks.picker.lines, { desc = "Buffer Lines" })
vim.keymap.set("n", "<leader>sB", Snacks.picker.grep_buffers, { desc = "Grep Open Buffers" })
vim.keymap.set("n", "<leader>sg", Snacks.picker.grep, { desc = "Grep" })
vim.keymap.set({ "n", "x" }, "<leader>sw", Snacks.picker.grep_word, { desc = "Visual Word or Selection" })

-- Search
vim.keymap.set("n", "<leader>sC", Snacks.picker.commands, { desc = "Commands" })
vim.keymap.set("n", "<leader>sD", Snacks.picker.diagnostics_buffer, { desc = "Buffer Diagnostics" })
vim.keymap.set("n", "<leader>sH", Snacks.picker.highlights, { desc = "Highlights" })
vim.keymap.set("n", "<leader>sM", Snacks.picker.man, { desc = "Man Pages" })
vim.keymap.set("n", "<leader>sR", Snacks.picker.resume, { desc = "Resume" })
vim.keymap.set("n", "<leader>sa", Snacks.picker.autocmds, { desc = "Autocmds" })
vim.keymap.set("n", "<leader>sd", Snacks.picker.diagnostics, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>sh", Snacks.picker.help, { desc = "Help Pages" })
vim.keymap.set("n", "<leader>si", Snacks.picker.icons, { desc = "Icons" })
vim.keymap.set("n", "<leader>sj", Snacks.picker.jumps, { desc = "Jumps" })
vim.keymap.set("n", "<leader>sk", Snacks.picker.keymaps, { desc = "Keymaps" })
vim.keymap.set("n", "<leader>sl", Snacks.picker.loclist, { desc = "Location List" })
vim.keymap.set("n", "<leader>sm", Snacks.picker.marks, { desc = "Marks" })
vim.keymap.set("n", "<leader>sp", Snacks.picker.lazy, { desc = "Plugin Specs" })
vim.keymap.set("n", "<leader>sq", Snacks.picker.qflist, { desc = "Quickfix List" })
vim.keymap.set("n", "<leader>su", Snacks.picker.undo, { desc = "Undo History" })
vim.keymap.set("n", "<leader>s/", Snacks.picker.search_history, { desc = "Search History" })
vim.keymap.set("n", "<leader>sr", Snacks.picker.registers, { desc = "Registers" })
vim.keymap.set("n", "<leader>uC", Snacks.picker.colorschemes, { desc = "Colorschemes" })

-- Utilities
vim.keymap.set("n", "<leader>.", Snacks.scratch.open, { desc = "Toggle Scratch Buffer" })
vim.keymap.set("n", "<leader>S", Snacks.scratch.select, { desc = "Select Scratch Buffer" })
-- vim.keymap.set("n", "<leader>bd", snacks.bufdelete, { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>cR", Snacks.rename.rename_file, { desc = "Rename File" })
vim.keymap.set("n", "<leader>un", Snacks.notifier.hide, { desc = "Dismiss All Notifications" })
vim.keymap.set({ "n", "t" }, "]]", function() Snacks.words.jump(vim.v.count1) end, { desc = "Next Reference" })
vim.keymap.set({ "n", "t" }, "[[", function() Snacks.words.jump(-vim.v.count1) end, { desc = "Prev Reference" })
