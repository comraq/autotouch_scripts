require("utils/lib_loader")

LOG_ENABLED = false
ALLOW_AP_POTIONS = false
ALLOW_AP_STONE = false

if LOG_ENABLED then
  log("\n\n\nbegin script logging:")
end

function execute_mission(k)
  local action = retry(missions_daily_tap_mission("FIRST"))
  local rp_sel = retry(oath_battle_party_select_rp_select_tap_rp("RP1"))

  return with_insufficient_ap_check(action, ALLOW_AP_POTIONS, ALLOW_AP_STONE)(function()
    -- Daily Mission
    retry(battle_helper_select_tap_first_helper)()
    retry(battle_party_select_tap_confirm)()

    in_battle_daemon()

    mission_complete_EP_tap_confirm()
    retry(mission_complete_rewards_tap_confirm)()

    if (not encountered_oath()) then
      return k()
    end

    -- Oath Battle
    retry(oath_encountered_tap_proceed)()
    retry(oath_battle_prep_tap_proceed)()
    retry(battle_helper_select_tap_first_helper)()
    retry(battle_party_select_tap_confirm)()
    rp_sel()

    in_battle_daemon(oath_battle_complete)

    retry(oath_battle_complete_tap_oath_home)()
    retry(oath_home_tap_missions)()
    retry(missions_tap_daily_missions)()

    return k()
  end)
end

local function main()
  return execute_mission(main)
end

main()
