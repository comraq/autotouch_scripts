require("utils/lib_loader")

LOG_ENABLED = false
ALLOWED_AP_OPTIONS = {
  "AP30",
  "AP50",
  "APMAX"
}
ALLOW_RP_POTIONS = true

if LOG_ENABLED then
  log("\n\n\nbegin script logging:")
end

local rp_amount = 1
local rp_sel = retry(oath_battle_party_select_rp_select_tap_rp("RP"..tostring(rp_amount)))
local battle_interval = 3

function execute_with_daily_mission(k)
  local action = function()
    return retry(missions_daily_tap_mission("FIRST"))(10)
  end

  return with_insufficient_ap_check(action, ALLOWED_AP_OPTIONS)(function()
    -- Regular Mission
    retry(battle_helper_select_tap_first_helper)()
    retry(battle_party_select_tap_confirm)()

    in_battle_daemon()

    mission_complete_EP_tap_confirm()
    retry(mission_complete_rewards_tap_confirm)(10)

    if (not encountered_oath()) then
      return k()
    end

    -- Oath Battle
    retry(oath_encountered_tap_proceed)()
    retry(oath_battle_prep_tap_proceed)(10)
    retry(battle_helper_select_tap_first_helper)()
    retry(battle_party_select_tap_confirm)()

    return with_insufficient_rp_check(rp_sel, rp_amount, ALLOW_RP_POTIONS)(function()

      in_battle_daemon(oath_battle_complete, battle_interval)
      retry(oath_battle_complete_tap_oath_home)()
      retry(oath_home_tap_missions)()
      retry(missions_tap_daily_missions)()

      return k()
    end)
  end)
end

function execute_with_saved_mission(k)
  local action = function()
    return retry(missions_three_battles_tap_battle("THIRD"))(10)
  end

  return with_insufficient_ap_check(action, ALLOWED_AP_OPTIONS)(function()
    -- Regular Mission
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
    retry(oath_battle_prep_tap_proceed)(10)
    retry(battle_helper_select_tap_first_helper)()
    retry(battle_party_select_tap_confirm)()

    return with_insufficient_rp_check(rp_sel, rp_amount, ALLOW_RP_POTIONS)(function()

      in_battle_daemon(oath_battle_complete, battle_interval)
      retry(oath_battle_complete_tap_saved_mission)()

      return k()
    end)
  end)
end

local function main()
  return execute_with_saved_mission(main)
end

main()
