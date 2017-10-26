local _M = {}
local mt = { __index = _M }

function _M.new(ast)
  local self  = {
    ast       = ast,
    sb        = {},
  }

  return setmetatable(self, mt)
end

return _M
