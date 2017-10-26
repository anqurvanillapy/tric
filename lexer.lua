local _M = {}
local mt = { __index = _M }

function _M.new(filename)
  local f   = assert(io.open(filename, "r"))
  local src = f:read("*all")

  local keywords = {}

  local self  = {
    filename  = filename,
    src       = src,
    loc       = 1,
    offset    = 1,
    keywords  = keywords,
  }

  f:close()
  return setmetatable(self, mt)
end

return _M
