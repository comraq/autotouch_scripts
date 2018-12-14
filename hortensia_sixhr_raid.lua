require("utils/lib_loader")

LOG_ENABLED = true
ALLOWED_AP_OPTIONS = {
  "AP10",
  "AP30",
}
ALLOW_RP_POTIONS = true

if LOG_ENABLED then
  log("\n\n\nbegin script logging:")
end

local rp_amount = 3
local rp_sel = retry(oath_battle_party_select_rp_select_tap_rp("RP"..tostring(rp_amount)))

-------------------------------
-- Options for Battle Select --
-------------------------------

local sixhr_home_sp_mission = function()
  return retry(sixhr_home_tap_sp_mission)(10)
end

---------------------------------
-- Options for Battle Complete --
---------------------------------

local sixhr_raid_complete_home = retry(sixhr_raid_complete_tap_home)


function execute_with(mission_sel, on_oath_complete)
  return function(k)
    return with_insufficient_ap_check(mission_sel, ALLOWED_AP_OPTIONS)(function()
      -- Regular Mission
      retry(battle_helper_select_tap_first_helper)()
      retry(battle_party_select_tap_confirm)()

      return in_battle_daemon()(function()

        mission_complete_proceed_to_rewards_confirm_loop()
        mission_complete_rewards_confirm(10)

        if (not encountered_sixhr_raid()) then
          return k()
        end

        local function enter_oath_battle()
          retry(oath_battle_prep_tap_proceed)(10)
          retry(battle_helper_select_tap_first_helper)()
          retry(battle_party_select_tap_confirm)()

          return with_insufficient_rp_check(rp_sel, 1, ALLOW_RP_POTIONS)(function()

            return in_battle_daemon(sixhr_raid_complete)(function()
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

          return in_battle_daemon(sixhr_raid_complete, battle_interval)(function()
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


local execute = execute_with(sixhr_home_sp_mission, sixhr_raid_complete_home)
local function main()
  return execute(main)
end

main()
