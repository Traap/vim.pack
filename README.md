# vim.pack

Personal Neovim configuration built around Neovim's native `vim.pack` package
manager and LSP client. It uses Lua throughout and does not require an external
plugin manager.

## Requirements

- A recent Neovim build with `vim.pack`, `vim.lsp.config()`, and
  `vim.lsp.enable()`
- Git, for installing packages
- `mise` and Solargraph for Ruby LSP support, plus `nixd` for Nix; Mason
  installs the other language servers on demand
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

On first launch, `vim.pack` installs the packages declared in
`lua/traap/core/pack.lua`. The checked-in `nvim-pack-lock.json` keeps their
revisions reproducible.

## Package management

Inspect the packages registered in the current session:

```vim
:lua vim.print(vim.pack.get(nil, { info = false }))
```

Open Neovim's package update view with:

```vim
:lua vim.pack.update()
```

The custom package helpers use `:packadd` to activate optional packages on
demand. The Snacks dashboard reports the active and installed package counts,
along with the elapsed configuration startup time.

## Plugin Customizations

### todo-comments.nvim

Two custom todo categories are merged with the plugin defaults. Matching is
case-sensitive, so each accepted spelling is configured explicitly:

```text
YouTube: canonical YouTube marker
Youtube: alternate YouTube marker
youtube: lowercase YouTube marker
URL: canonical URL marker
Url: alternate URL marker
url: lowercase URL marker
```

These markers use custom Nerd Font icons and colors: red (`#ff0000`) for
YouTube and purple (`#7711FF`) for URL. Highlighting is enabled in ordinary
text as well as syntax comments, allowing markers in Markdown documents such
as this README. `<leader>fy` searches the project for all six spellings and
opens the results in the quickfix list.

Default categories such as `TODO:`, `BUG:`, and `FIX:` remain available.

## Configuration overview

- `init.lua` adds the checkout to `runtimepath` and loads options, packages,
  plugin configuration, LSP, autocommands, keymaps, and commands.
- `lua/traap/core/pack.lua` is the package manifest.
- `lua/traap/plugins/` contains one configuration module per plugin.
- `lua/traap/config/` contains editor options, autocommands, keymaps, commands,
  and the enabled language-server list.
- `lsp/` contains native Neovim LSP configurations.

The setup uses Tokyo Night; Snacks for the dashboard, explorer, and pickers;
Blink for completion; Treesitter for highlighting and indentation;
Fugitive/Gitsigns for Git workflows; and Trouble for diagnostics. Mini modules
provide comments, pairs, surrounds, indentation guides, icons, and the
statusline. Which-key exposes the leader mappings. Both the leader and local
leader are `<Space>`.

Useful mappings include:

| Mapping | Action |
| --- | --- |
| `<leader>e` | Open the Snacks file explorer |
| `<leader>ff` | Find files |
| `<leader>fg` | Find Git files |
| `<leader>sg` | Grep the project |
| `<leader>sr` | Open Grug Far search and replace |
| `<leader>gs` | Open Fugitive status |
| `;1` … `;4` | Select a Harpoon file |
| `<leader>ud` | Toggle diagnostics |
| `<leader>i` | Toggle invisible characters |

## LSP

`lua/traap/lsp/servers.lua` maps filetypes to 26 language servers. When a
configured filetype is opened for the first time, Mason installs its server if
needed; the configuration then enables the server through Neovim's native LSP
API and attaches it to matching buffers. Solargraph and `nixd` are managed
externally; Solargraph runs through `mise`.

| Language or domain | Server name |
| --- | --- |
| Shell | `bashls` |
| C/C++ | `clangd` |
| C# | `csharp_ls` |
| CSS | `cssls` |
| Go | `gopls` |
| HTML | `html` |
| Java | `jdtls` |
| JSON | `jsonls` |
| Julia | `julials` |
| LaTeX prose | `ltex` |
| Lua | `lua_ls` |
| Markdown | `marksman` |
| Nix | `nixd` |
| Python | `pyright` |
| QML | `qmlls` |
| Ruby | `solargraph` |
| Rust | `rust_analyzer` |
| SQL | `sqls` |
| Svelte | `svelte` |
| TeX | `texlab` |
| TOML | `taplo` |
| TypeScript/JavaScript | `ts_ls` |
| Vimscript | `vimls` |
| XML | `lemminx` |
| YAML | `yamlls` |
| Zig | `zls` |

Blink capabilities are added to every server. Servers that support formatting
format synchronously before a buffer is written, and diagnostics use signs plus
virtual lines on the current line.

Custom native server definitions in `lsp/` return the command, root markers,
filetypes, and optional settings. Definitions whose filenames match an enabled
server name extend or replace Neovim's built-in configuration. For example:

```lua
return {
  cmd = { "yaml-language-server", "--stdio" },
  root_markers = { ".git" },
  filetypes = { "yaml" },
}
```

Use `:Mason` to inspect installed server packages. `:LspInfo`, `:LspLog`,
`:LspStart`, `:LspRestart[!]`, and `:LspStop[!]` inspect and control native LSP
clients.
