# vim.pack
Neovim setup using builtin package manager.

This is a work-in-progress.

https://gpanders.com/blog/whats-new-in-neovim-0-11/

TODO  I'd like each lsp/server-name.lua file to follow a patter similar to the
one below.
```lua
return {
  local servers = require("traap.config.lsp_servers")
  local server = servers.name["yaml"]
  cmd = server.cmd,
  root_markers = server.root_markers,
  filetypes = server.filetypes
}
```
Traap - 2025-07-28
