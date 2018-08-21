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
retry(battle_party_select_tap_confirm)()

local rp_sel = retry(oath_battle_party_select_rp_select_tap_rp("RP1"))
with_insufficient_rp_check(rp_sel, ALLOW_RP_POTIONS)(function()

  in_battle_daemon(oath_battle_complete)

  retry(oath_battle_complete_tap_oath_home)()
  retry(oath_home_tap_missions)()
  retry(missions_tap_daily_missions)()
end)
--]]
