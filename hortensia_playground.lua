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

--[[
while not match_all_colors(HORTENSIA.LOADING.RUNNING.COLORS) do
  log("loading image not detected")
  sleep_sec(0.1)
end

wait_network_loading()
alert("loading completed!")

for i = 1, 3, 1 do
  friends_list_scroll_down_once()
end
--]]

--[[
local x1,y1 = 1511, 867
log(string.format("x[%f], y[%f], c[%d]", x1, y1, getColor(x1, y1)))

local x2,y2 = 669, 1511
log(string.format("x[%f], y[%f], c[%d]", x2, y2, getColor(x2, y2)))

log(string.format("dsn[%s], orientation[%s]", getSN(), getOrientation()))
log(string.format("ipad_air()[%s]", tostring(ipad_air())))
--]]


retry(magonia_boss_unit_select_tap_unit(2))(0.1,0)
retry(magonia_boss_unit_select_tap_unit(3))(0.1,0)
retry(magonia_boss_unit_select_tap_unit(4))(0.1,0)
retry(magonia_boss_unit_select_tap_attack)(5,0.3)
