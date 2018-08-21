functionsImport = io.open('/var/mobile/Library/AutoTouch/Scripts/utils/list.txt', "r")

local foldl = function(f, init, list)
  local acc = init
  for i,v in ipairs(list) do
    acc = f(acc, v)
  end

  return acc
end

-- Import files --

local scripts_paths = {
  "/var/mobile/Library/AutoTouch/Scripts/lib/?.lua",
  "/var/mobile/Library/AutoTouch/Scripts/lib/hortensia/?.lua"
}

package.path = foldl(function(pkg_path, path)
  return pkg_path .. ";" .. path
end, package.path, scripts_paths)

for line in functionsImport:lines() do
  require(line)
end
