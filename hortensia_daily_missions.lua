require("utils/lib_loader")

LOG_ENABLED = false
ALLOWED_AP_OPTIONS = {
  "AP30",
  "AP50",
  "APMAX"
}

if LOG_ENABLED then
  log("\n\n\nbegin script logging:")
end

local action = function()
  return retry(missions_daily_tap_mission("FOURTH"))(10)
end

function execute_mission(k)

  return with_insufficient_ap_check(action, ALLOWED_AP_OPTIONS)(function()
    retry(battle_helper_select_tap_first_helper)()
    retry(battle_party_select_tap_confirm)()

    in_battle_daemon()

    mission_complete_EP_tap_confirm()
    retry(mission_complete_rewards_tap_confirm)()

    return k()
  end)
end

local function main()
  return execute_mission(main)
end

main()
