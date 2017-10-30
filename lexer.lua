local utils = require "utils"

local _M = {}
local mt = { __index = _M }

function _M.new(filename)
  local f   = assert(io.open(filename, "r"))
  local src = f:read("*all")

  local patterns  = {
    nil_t         = "^nil",
    bool_t        = "^(false|true)",
    str_t         = '^"%g*"',
    id_t          = "^%a+w*",
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

function _M:_matchtk(w, p)
  local len = string.len(w)
  local s, e = string.find(w, p)

  if s ~= nil and e == len then
    self.offset = self.offset + e
    return true
  end

  return false
end

function _M:_scan()
  local ptn = self.patterns
  local tokens = {}
  local i = 1

  for line in string.gmatch(self.src, "[^\n]") do
    for word in string.gmatch(line, "%S+") do
      local tk = nil

      if tonumber(word) ~= nil then
        self.offset = self.offset + string.len(word)
        tk          = {
          tktype    = "number",
          val       = tonumber(word),
        }
      elseif self:_matchtk(word, ptn.nil_t) then
        tk        = {
          tktype  = "nil",
          val     = nil,
        }
      elseif self:_matchtk(word, ptn.bool_t) then
        tk        = {
          tktype  = "boolean",
          val     = utils.str2bool(word),
        }
      elseif self:_matchtk(word, ptn.str_t) then
        tk        = {
          tktype  = "string",
          val     = string.sub(word, 2, string.len(word) - 1)
        }
      elseif self:_matchtk(word, ptn.id_t) then
        tk        = {
          tktype  = "identifier",
          val     = word,
        }
      end

      tk.lit    = word
      tk.loc    = self.loc
      tk.offset = self.offset

      if tk == nil then error(tk) end

      tokens[i] = tk
      i         = i + 1
    end

    self.loc    = self.loc + 1
    self.offset = 1
  end

  return tokens
end

function _M:get_tokens()
  local ok, tk = pcall(self:_scan())
  local tokens

  if not ok then
    local errmsg = string.format('invalid token: "%s" at %d:%d\n',
      tk.loc, tk.offset)
    io.write(io.stderr, errmsg)
  end

  tokens = tk
  return tokens
end

return _M
