local _M = {}

function _M.succ(n)
  return n + 1
end

function _M.pred(n)
  return n - 1
end

function _M.concat(s1, s2)
  return s1 .. s2
end

function _M.substr(s, i, j)
  return string.sub(s, i, j)
end

function _M.booland(i, j)
  return i and j
end

function _M.boolor(i, j)
  return i or j
end

function _M.boolnot(i)
  return not i
end

return _M
