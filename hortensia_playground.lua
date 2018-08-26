require("utils/lib_loader")

LOG_ENABLED = true
ALLOWED_AP_OPTIONS = {
  "AP50",
  "APMAX"
}
ALLOW_RP_POTIONS = true

if LOG_ENABLED then
  log("\n\n\nbegin script logging:")
end


local region = {-100, 50, 200, 200};
local result = findColor(0x00ddff, 1, region);
for i, v in pairs(result) do
  log(string.format("Found pixel: x:%f, y:%f", v[1], v[2]));
end
log(string.format("size of result: %d", #result))
