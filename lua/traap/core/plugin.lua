local M = {}

function M.load(name)
  return pcall(vim.pack.load, name)
end

function M.require(module_name)
  local ok, module = pcall(require, module_name)
  if ok then
    return module
  end

  return nil
end

function M.setup(name, module_name, opts)
  M.load(name)

  local module = M.require(module_name)
  if module and type(module.setup) == "function" then
    module.setup(opts or {})
  end

  return module
end

return M
