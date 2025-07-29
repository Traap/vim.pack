local treesitter_parsers = {
	"bash", "c", "c_sharp", "cpp", "css", "dockerfile", "go", "html",
	"jscript", "javascript", "json", "jsonc", "lua", "markdown", "markdown_inline",
	"python", "query", "regex", "ruby", "sql", "toml", "tex", "tsx",
}

require "nvim-treesitter.configs".setup({
	ensure_installed = treesitter_parsers,
	highlight = { enable = true }
})
