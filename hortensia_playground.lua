require("utils/lib_loader")

LOG_ENABLED = true
ALLOWED_AP_OPTIONS = {
  "AP50",
  "APMAX"
}
ALLOWED_TICKET_OPTIONS = {
  "CHARLOT",
  "MARYUS",
  "DEFROT",
  "MAURICE"
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

get_recollection_treasure_chance_colors()
local res = findImage("screenshots/recollection_next.bmp", 1, 0.4, nil, { 1250, 900, 300, 200 })
local count = 0
for i, v in pairs(res) do
  alert(string.format("Found rect at: x:%f, y:%f", v[1], v[2]));
  count = count + 1
end
alert(string.format("count of table is [%d]", count))

local color = 1776411

local x1,y1 = 442, 1223
log(string.format("x[%f], y[%f], c[%d]", x1, y1, getColor(x1, y1)))

local loc1 = HORTENSIA.RECOLLECTION.PATHS[3][2]
local loc2 = HORTENSIA.RECOLLECTION.PATHS[3][3]
log(string.format("matching color at path2[%s], path3[%s]", tostring(match_color(color, loc1.x, loc1.y)),
                                                            tostring(match_color(color, loc2.x, loc2.y))))
log(string.format("mission_complete_special_complete [%s]", tostring(mission_complete_special_complete())))

log(string.format("dsn[%s], orientation[%s]", getSN(), getOrientation()))
log(string.format("ipad_air()[%s]", tostring(ipad_air())))
--]]

log(string.format("mission_complete_battle_complete [%s]", tostring(mission_complete_battle_complete())))

get_mission_complete_colors()
