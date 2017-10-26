local _M = {}

function _M.S(x, y, z)
  local xz, yz

  if type(x) ~= "function" then
    return nil, error("x is not applicable")
  end

  xz = x(z)

  if type(y) ~= "function" then
    return nil, error("y is not applicable")
  end

  yz = y(z)

  if type(xz) ~= "function" then
    return nil, error("x(z) is not applicable")
  end

  return xz(yz)
end

function _M.K(x, y)
  return x
end

function _M.I(x)
  return x
end

return _M
