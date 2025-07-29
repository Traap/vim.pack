local M = {}
  M.language_servers = {
		biome =      { name = 'bitbake-language-server', },
		cpp =        { name = 'clangd', },
		csharp =     { name = 'csharp-ls', },
		css =        { name = 'cssls', },
		emmet =      { name = 'emmetls', },
		python =     { name = 'pyright', },
		go =         { name = 'gopls', },
		json =       { name = 'jsonls', },
		lua =        { name = 'lua_ls', },
		ruby =       { name = 'solargraph', },
		rust =       { name = 'rust_analyzer', },
		sh =         { name = 'bashls', },
		tinymist =   { name = 'tinymist', },
		sql =        { name = 'sqlls', },
		tex =        { name = 'texlab', },
		typescript = { name = 'tsserver', },
		yaml =       { name = 'yamlls', },
	}
return M
