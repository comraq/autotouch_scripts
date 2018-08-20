functionsImport = io.open('/var/mobile/Library/AutoTouch/Scripts/lib/list.txt', "r")

-- Import files --

package.path = package.path .. ";/var/mobile/Library/AutoTouch/Scripts/lib/?.lua"

for line in functionsImport:lines() do
  require(line)
end
