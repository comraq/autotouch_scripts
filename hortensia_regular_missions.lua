require("utils/lib_loader")

LOG_ENABLED = false
ALLOWED_AP_OPTIONS = {
  --"AP10",
  --"AP30",
  --"AP50",
  --"APMAX",
  --"APSTONE"
}

if LOG_ENABLED then
  log("\n\n\nbegin script logging:")
end


-------------------------------
-- Options for Battle Select --
-------------------------------

local missions_daily = function()
  return retry(missions_daily_tap_mission("FIRST"))(10)
end
local missions_sixth_battle = function()
  -- Scrolling Down 3 times and selecting the third battle in screen
  -- ie: the 6th battle in the current battle select interface
  local scroll_iter = 3

  for i = 1, scroll_iter, 1 do
    missions_battle_select_scroll_down_once()
  end
  return retry(missions_three_battles_tap_battle("THIRD"))(10)
end


---------------------------------
-- Options for Battle Complete --
---------------------------------

local battle_complete_saved_mission = function()
  mission_complete_proceed_to_rewards_confirm()
  retry(mission_complete_tap_saved_mission)()
end
local battle_complete_daily_missions = function()
  mission_complete_proceed_to_rewards_confirm()
  retry(mission_complete_rewards_tap_confirm)()
end


function execute_with(mission_sel, on_battle_complete)
  return function(k)

    return with_insufficient_ap_check(mission_sel, ALLOWED_AP_OPTIONS)(function()
      retry(battle_helper_select_tap_first_helper)()
      retry(battle_party_select_tap_confirm)()

      return in_battle_daemon()(function()
        on_battle_complete()
        return k()
      end)
    end)
  end
end

local execute = execute_with(missions_sixth_battle, battle_complete_saved_mission)
local function main()
  return execute(main)
end

main()
