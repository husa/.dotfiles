local M = {}

---Deep extend
---@param a table
---@param b table
M.deep_extend = function(a, b)
  local res = vim.deepcopy(a or {})
  for k, v in pairs(b) do
    if type(v) == "table" then
      if vim.islist(v) then
        res[k] = vim.list_extend(vim.deepcopy(a[k] or {}), v)
      else
        res[k] = M.deep_extend(a[k] or {}, v)
      end
    else
      res[k] = v
    end
  end
  return res
end

return M
