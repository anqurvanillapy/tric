local _M = {}
local mt = { __index = _M }

function _M.new(ast)
  local optcodes = {}

  local self  = {
    ast       = ast,
  }

  return setmetatable(self, mt)
end

return _M
