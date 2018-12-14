require("utils/lib_loader")

LOG_ENABLED = false
ALLOWED_AP_OPTIONS = {
  "AP30",
  "AP50",
  "APMAX"
}
ALLOW_RP_POTIONS = true
FINAL_WAVE_SKILL = true

if LOG_ENABLED then
  log("\n\n\nbegin script logging:")
end

local rp_amount = 1
local rp_sel = retry(oath_battle_party_select_rp_select_tap_rp("RP"..tostring(rp_amount)))

-------------------------------
-- Options for Battle Select --
-------------------------------

local missions_first_battle = function()
  return retry(missions_three_battles_tap_battle("FIRST"))(10)
end
local missions_daily_fourth = function()
  return retry(missions_daily_tap_mission("FOURTH"))(10)
end

---------------------------------
-- Options for Battle Complete --
---------------------------------

local oath_complete_saved_mission = retry(oath_battle_complete_tap_saved_mission)
local oath_complete_daily_missions = function()
  retry(oath_battle_complete_tap_oath_home)()
  retry(oath_home_tap_missions)()
  retry(missions_tap_daily_missions)()
end

--------------------------------------
-- Options for Oath Not Encountered --
--------------------------------------
local oath_not_encountered_third_knight_quest = retry(missions_knights_quest_tap_quest("THIRD"))
local oath_not_encountered_noop = FUNCTIONS.id



function execute_with(mission_sel, on_oath_complete, oath_not_encountered)
  return function(k)
    return with_insufficient_ap_check(mission_sel, ALLOWED_AP_OPTIONS)(function()
      -- Regular Mission
      retry(battle_helper_select_tap_first_helper)()
      retry(battle_party_select_tap_confirm)()

      return in_battle_daemon()(function()

        mission_complete_proceed_to_rewards_confirm()
        mission_complete_rewards_confirm(10)

        if (not encountered_oath()) then
          oath_not_encountered()
          return k()
        end

        local function enter_oath_battle()
          retry(oath_battle_prep_tap_proceed)(10)
          retry(battle_helper_select_tap_first_helper)()
          retry(battle_party_select_tap_confirm)()

          return with_insufficient_rp_check(rp_sel, 1, ALLOW_RP_POTIONS)(function()

            return in_battle_daemon(oath_battle_complete)(function()
              on_oath_complete()
              return k()
            end, function()
              retry(battle_failed_tap_retreat)(10)
              return enter_oath_battle()
            end)
          end)
        end

        -- Oath Battle
        retry(oath_encountered_tap_proceed)()
        retry(oath_battle_prep_tap_proceed)(10)
        retry(battle_helper_select_tap_first_helper)()
        retry(battle_party_select_tap_confirm)()

        return with_insufficient_rp_check(rp_sel, rp_amount, ALLOW_RP_POTIONS)(function()

          return in_battle_daemon(oath_battle_complete, battle_interval)(function()
            on_oath_complete()
            return k()
          end, function()
            retry(battle_failed_tap_retreat)(10)
            return enter_oath_battle()
          end)
        end)
      end)
    end)
  end
end


local execute = execute_with(missions_first_battle, oath_complete_saved_mission, oath_not_encountered_third_knight_quest)
local function main()
  return execute(main)
end

main()
