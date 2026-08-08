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
- Node.js and Yarn to build markdown-preview.nvim after installation or update
- A Nerd Font for the configured icons
- `rg` for project grep and todo searches; `fd` is recommended for file picking

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
:Lazy
```

`:Lazy` is a compatibility command for `vim.pack.update()`. Review the update
buffer and write it with `:write` to apply the selected revisions.

The custom package helpers use `:packadd` to activate optional packages on
demand. The Snacks dashboard reports the active and installed package counts,
along with the elapsed configuration startup time.

## Plugin Customizations

Plugin sources are registered in `lua/traap/core/pack.lua`. Configuration
modules under `lua/traap/plugins/` use the small helper in
`lua/traap/core/plugin.lua` to activate optional packages with `:packadd`,
require their Lua module, and run `setup()` where applicable.

### Snacks

Snacks provides the dashboard, explorer, pickers, notifications, scratch
buffers, status column, Git browsing, and reference navigation. The dashboard
replaces Snacks' lazy.nvim-specific startup section with native `vim.pack`
statistics: active packages, registered packages, and elapsed configuration
time.

The explorer opens on the right. Notifications rise from the bottom and expire
after three seconds. Picker windows receive buffer-local `<C-h>`, `<C-j>`,
`<C-k>`, and `<C-l>` mappings so navigation continues through
vim-tmux-navigator.

Useful picker and toggle mappings include:

| Mapping | Action |
| --- | --- |
| `<leader>e` | Open the file explorer |
| `<leader>ff` / `<leader>fg` | Find files / Git files |
| `<leader>sg` / `<leader>sw` | Grep the project / current word or selection |
| `<leader>sd` / `<leader>sD` | Project / buffer diagnostics |
| `<leader>gB` | Open the current Git object in a browser |
| `<leader>.` / `<leader>S` | Open / select a scratch buffer |
| `<leader>ud` | Toggle diagnostics |
| `yoh`, `yoi`, `yon`, `yor` | Toggle inlay hints, indent guides, numbers, and relative numbers |

### Blink and LazyDev

Blink supplies completion and LSP client capabilities. Its sources are LSP,
filesystem paths, snippets, and buffer words. Fuzzy matching uses the Lua
implementation, completion documentation does not open automatically, and the
default Blink keymap preset is retained. LazyDev augments Lua development for
the Neovim runtime.

### Harpoon

Harpoon 2 is initialized during startup so its list is synchronized on buffer
leave and exit. The semicolon mappings avoid terminal and tmux Alt-key
ambiguities:

| Mapping | Action |
| --- | --- |
| `;1` … `;4` | Select Harpoon entries 1–4 |
| `;5` / `;6` | Select the next / previous entry |
| `;7` | Toggle the quick menu |
| `;8` | Add the current file |

### Markdown preview

markdown-preview.nvim is loaded before Markdown `FileType` events so its
buffer-local commands are available reliably. It recognizes the `markdown`
filetype and uses its dark browser theme.

`vim.pack` has no plugin build field, so a `PackChanged` hook runs
`yarn install` in the plugin's `app/` directory after installation and every
update.

| Mapping | Action |
| --- | --- |
| `<leader>mt` | Toggle the preview |
| `<leader>mp` | Start the preview |
| `<leader>ms` | Stop the preview |

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

### Tokyo Night and interface plugins

Tokyo Night uses the `night` style with a transparent background, transparent
sidebars and floating windows, italic comments and keywords, and purple
`#bb9af7` borders. Autocommands apply matching borders and highlights to
Neovim, Noice, Snacks, which-key, completion menus, diagnostics, and folds.

Which-key uses its modern preset and a 300 ms mapping timeout. Noice and Nui
provide the command-line and popup interface. Trouble supplies diagnostic
views. The configured Mini modules provide comments, pairs, surrounds, icons,
the statusline, and an immediate, non-animated indent scope drawn with `│`.

### Editing and project tools

- Fugitive status opens below the current buffer with `<leader>gs`; Gitsigns
  supplies signs and hunk integration, and Rhubarb adds GitHub support.
- Grug Far opens project-wide search and replace with `<leader>sr`.
- nvim-toggler uses `<leader>tn`, retains its standard inverses, and adds
  `>`/`<` plus `>=`/`<=` pairs.
- img-clip saves and inserts an image with `<leader>pi`.
- vim-easy-align retains `ga`; `|` aligns a paragraph on pipes and `<leader>0`
  aligns it on commas while temporarily suspending Noice.
- vim-dadbod-ui toggles with `<leader>db`.
- VimTeX actions live under `<leader>l`, including compile (`<leader>ll`),
  view (`<leader>lv`), errors (`<leader>le`), and table of contents
  (`<leader>lt`).
- wiki.vim mappings use `WIKIHOME`, `WORKHOME`, and `YOUTUBEHOME` only when
  those environment variables are present.

## Configuration overview

- `init.lua` adds the checkout to `runtimepath` and loads options, packages,
  plugin configuration, LSP, autocommands, keymaps, and commands.
- `lua/traap/core/pack.lua` is the package manifest.
- `lua/traap/plugins/` contains one configuration module per plugin.
- `lua/traap/config/` contains editor options, autocommands, keymaps, and user
  commands.
- `lua/traap/lsp/servers.lua` is the filetype and language-server registry.
- `lua/traap/lsp/init.lua` installs, configures, enables, and controls servers.
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

### Installation lifecycle

The LSP stack uses three packages with separate responsibilities:

- nvim-lspconfig contributes current native `lsp/<server>.lua` definitions.
- mason.nvim owns downloaded language-server executables.
- mason-lspconfig translates native server names into Mason package names.

No complete server list is passed to Mason at startup. Instead:

1. A `FileType` autocmd looks up the buffer in `servers.lua`.
2. Already enabled or currently installing servers are ignored.
3. The first managed request refreshes Mason's registry. Requests arriving
   during that refresh are queued, so only one registry operation runs.
4. The native server name is translated to its Mason package. An absent package
   is installed asynchronously; an existing package proceeds immediately.
5. Production options are merged with Blink capabilities and the shared
   `on_attach` callback using `vim.lsp.config()`.
6. `vim.lsp.enable()` activates the server. If installation completed after the
   original `FileType` event, native LSP activation is replayed for matching
   loaded buffers so the first buffer attaches without being reopened.

Mason stores its packages below `stdpath("data")/mason`. Consequently, each
machine installs only the servers required by filetypes actually opened there.
Mason setup prepends its `bin/` directory to Neovim's `PATH`.

Solargraph is deliberately excluded from Mason and starts as:

```sh
mise exec ruby@4.0.0 -- solargraph stdio
```

`nixd` is also external because the current Mason registry does not provide a
`nixd` package.

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

The production registry includes server-specific customization where needed:

- clangd enables background indexing, clang-tidy, detailed completion, and
  disables automatic header insertion.
- lua_ls recognizes `vim` and `Snacks`, adds the complete Neovim runtime to its
  workspace library, and disables third-party workspace prompts.
- Solargraph uses the external `mise` command shown above.

### Adding or changing a server

Add a definition to `lua/traap/lsp/servers.lua`:

```lua
example = {
  name = "example_ls",
  filetypes = { "example" },
  mason = true, -- default; set false for an externally installed executable
  opts = {
    settings = {},
  },
}
```

`opts` may also be a function when configuration must be computed at startup.
Use an explicit `package` field only when the Mason package name cannot be
obtained from mason-lspconfig.

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

### Commands

| Command | Purpose |
| --- | --- |
| `:Mason` | Inspect installed and available Mason packages |
| `:LspInfo` | Open `:checkhealth vim.lsp` |
| `:LspLog` | Open the native LSP log in a new tab |
| `:LspStart [server…]` | Install if needed, then enable the named or current-buffer server |
| `:LspRestart[!] [server…]` | Disable and re-enable clients; `!` force-stops them first |
| `:LspStop[!] [server…]` | Disable clients; `!` force-stops them |

Without explicit names, start uses the current filetype and restart/stop use
the currently active clients. Use `:checkhealth vim.lsp` when a configured
server does not attach and `:MasonLog` when installation fails.
