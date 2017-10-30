local _M = {}

function _M.str2bool(s)
  local ret = nil

  if s == "false" then
    ret = false
  elseif s == "true" then
    ret = true
  end

  return ret
end

return _M
