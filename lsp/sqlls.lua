return {
  cmd = { "sql-language-server", "up", "--method", "stdio" },
  root_markers = {
    ".sqlsrc.json"
  },
  filetypes = { "sql", "mysql" }
}
