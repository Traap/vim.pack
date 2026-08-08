return {
  cmd = { "yaml-language-server", "--stdio" },
  root_markers = {
     ".git"
  },
  filetypes = {
    "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.helm-values"
  }
}
