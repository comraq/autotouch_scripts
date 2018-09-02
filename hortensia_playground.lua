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

local a,b,c = mission_complete_rank_up(),mission_complete_ep_up_story_unlock(),mission_complete_ep_up_awakening_unlock()
log(string.format("rank_up[%s], story_unlock[%s], awakening_unlock[%s]", tostring(a), tostring(b), tostring(c)))

local mc = mission_complete()
log(string.format("mission_complete[%s]", tostring(mc)))

if mc then
  mission_complete_proceed_to_rewards_confirm()
  retry(mission_complete_rewards_tap_confirm)()
end
