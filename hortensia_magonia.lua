require("utils/lib_loader")

LOG_ENABLED = true
ALLOWED_AP_OPTIONS = {
  "AP10",
  "AP30",
  "AP50",
  "APMAX"
}
FINAL_WAVE_SKILL = true

if LOG_ENABLED then
  log("\n\n\nbegin script logging:")
end

-------------------------------
-- Options for Battle Select --
-------------------------------

local mission_sel = function()
  return retry(magonia_home_tap_mission("THIRD"))(10)
end

-------------------------------
-- Options for Unit Select --
-------------------------------

local unit_sel = function()
  return retry(magonia_boss_unit_select_tap_unit("FIRST"))()
end

function execute_with(mission_sel)
  return function(k)
    retry(magonia_home_tap_pots)()

    if not is_pot_available() then
      retry(missions_tap_home_or_back)()
      return with_insufficient_ap_check(mission_sel, ALLOWED_AP_OPTIONS)(function()
        -- Regular Mission
        retry(battle_helper_select_tap_first_helper)()
        retry(battle_party_select_tap_confirm)()

        return in_battle_daemon()(function()

          mission_complete_proceed_to_rewards_confirm()
          retry(mission_complete_rewards_tap_confirm)(10)
          return k()
        end)
      end)
    end

    retry(magonia_pots_first_tap_break)()
    retry(magonia_pots_first_break_tap_normal)()
    while not magonia_boss_unit_select() do
      retry(magonia_boss_appeared_tap_skip)()
    end

    magonia_conduct_boss_battle(unit_sel)(magonia_boss_battle_complete_confirm_rewards)
    return k()
  end
end


local execute = execute_with(mission_sel)
local function main()
  return execute(main)
end

main()
