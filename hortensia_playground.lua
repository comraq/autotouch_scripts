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

--get_loading_running_colors()

--[[
while not match_all_colors(HORTENSIA.LOADING.RUNNING.COLORS) do
  log("loading image not detected")
  sleep_sec(0.1)
end

wait_network_loading()
alert("loading completed!")
--]]

--missions_battle_select_scroll_down_once()
get_mission_complete_colors()
