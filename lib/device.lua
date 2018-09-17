function ipad_air()
  local s,e = string.find(getSN(), "FK10")
  return s == 9 and e == 12
end
