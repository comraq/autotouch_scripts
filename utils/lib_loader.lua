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


local fns = {
  -----------
  -- Model --
  -----------
  "hortensia_model",
  "hortensia_recollection_stages",


  --------------------------
  -- Generic Util Modules --
  --------------------------
  "device",
  "functions",
  "motions",


  ------------------------
  -- Hortensia Specific --
  ------------------------
  "hortensia_lib",
  "hortensia_debug"
}

for _,fn in ipairs(fns) do
  require(fn)
end
