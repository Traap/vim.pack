# vim.pack

Personal Neovim configuration built around Neovim's native `vim.pack` package
manager and LSP client. Plugins are declared in Lua and pinned by
`nvim-pack-lock.json`; no external plugin manager is required.

## Requirements

- A Neovim build that provides `vim.pack`, `vim.lsp.config()`, and
  `vim.lsp.enable()`
- Git, for installing packages
- The language-server executables you want to use (see [LSP](#lsp))
- A Nerd Font for the configured icons
- Optional command-line tools such as `rg` and `fd` for the best Snacks picker
  experience

## Running the configuration

The checkout can be used directly without installing or symlinking it:

```sh
nvim -u /path/to/vim.pack/init.lua
```

The more traditional `NVIM_APPNAME` form also works when the checkout directory
is named `vim.pack`:

```sh
XDG_CONFIG_HOME=/path/to/parent NVIM_APPNAME=vim.pack nvim
```

On the first launch, `vim.pack` installs the packages declared in
`lua/traap/core/pack.lua`. Package revisions are recorded in
`nvim-pack-lock.json`.

## Configuration overview

- `init.lua` adds the checkout to `runtimepath` and loads options, packages,
  plugin configuration, LSP, autocommands, keymaps, and commands.
- `lua/traap/core/pack.lua` is the package manifest.
- `lua/traap/plugins/` contains one configuration module per plugin.
- `lua/traap/config/` contains editor options, autocommands, keymaps, commands,
  and the enabled language-server list.
- `lsp/` contains native Neovim LSP configurations.

The setup uses Tokyo Night, Snacks for its explorer and pickers, Blink for
completion, Treesitter for highlighting and indentation, Fugitive/Gitsigns for
Git workflows, Trouble for diagnostics, and a collection of Mini modules for
editing utilities and the statusline. Which-key exposes the leader mappings;
both the leader and local leader are `<Space>`.

Useful mappings include:

| Mapping | Action |
| --- | --- |
| `<leader>e` | Open the Snacks file explorer |
| `<leader>ff` | Find files |
| `<leader>fg` | Find Git files |
| `<leader>sg` | Grep the project |
| `<leader>sr` | Open Grug Far search and replace |
| `<leader>gs` | Open Fugitive status |
| `<leader>ud` | Toggle diagnostics |
| `<leader>i` | Toggle invisible characters |

## LSP

`lua/traap/config/lsp_servers.lua` enables the following server names through
Neovim's native LSP API:

| Language or domain | Server name |
| --- | --- |
| Shell | `bashls` |
| BitBake | `bitbake-language-server` |
| C/C++ | `clangd` |
| C# | `csharp-ls` |
| CSS | `cssls` |
| Emmet | `emmetls` |
| Go | `gopls` |
| JSON | `jsonls` |
| Lua | `lua_ls` |
| Python | `pyright` |
| Ruby | `solargraph` |
| Rust | `rust_analyzer` |
| SQL | `sqlls` |
| TeX | `texlab` |
| Typst | `tinymist` |
| TypeScript | `tsserver` |
| YAML | `yamlls` |

Install the corresponding executables separately and ensure they are available
on `PATH`. Blink capabilities are added to every server when Blink is available,
and diagnostics use virtual lines for the current line.

Native server definitions live in `lsp/<server-name>.lua` and return the
command, root markers, filetypes, and optional settings, for example:

```lua
return {
  cmd = { "yaml-language-server", "--stdio" },
  root_markers = { ".git" },
  filetypes = { "yaml" },
}
```
