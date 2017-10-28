local _M = {}
local mt = { __index = _M }

function _M.new(filename)
  local f   = assert(io.open(filename, "r"))
  local src = f:read("*all")

  local patterns  = {
    number        = "^[1-9]*%d*",
    float         = "^%d*%.%d+",
    identifier    = "^%a+w*",
    boolean       = "^(false|true)",
    string        = '^"%g*"',
  }

  local self  = {
    filename  = filename,
    src       = src,
    loc       = 1,
    offset    = 1,
    patterns  = patterns,
  }

  f:close()
  return setmetatable(self, mt)
end

function _M:_scan()
  local tokens = {}
  local i = 1
  for word in string.gmatch(self.src, "%S+") do
    tokens[i] = word
  end
  return tokens
end

function _M:get_tokens()
  local tokens = self:_scan()
  return tokens
end

return _M
