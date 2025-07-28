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
