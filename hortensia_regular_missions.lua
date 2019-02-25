require("utils/lib_loader")

LOG_ENABLED = false
FINAL_WAVE_SKILL = true
ALLOWED_AP_OPTIONS = {
  --"AP10",
  --"AP30",
  "AP50",
  "APMAX",
  "APSTONE"
}

if LOG_ENABLED then
  log("\n\n\nbegin script logging:")
end


-------------------------------
-- Options for Battle Select --
-------------------------------

-- Daily
local missions_daily = function()
  return retry(missions_daily_tap_mission("THIRD"))(10)
end

-- First battle
local missions_battle = function()
  return retry(missions_three_battles_tap_battle("FIRST"))(10)
end

-- Sixth battle
local missions_sixth_battle = function()
  -- Scrolling Down 3 times and selecting the third battle in screen
  -- ie: the 6th battle in the current battle select interface
  local scroll_iter = 3

  for i = 1, scroll_iter, 1 do
    missions_battle_select_scroll_down_once()
  end
  return retry(missions_three_battles_tap_battle("THIRD"))(10)
end

-- United sp_mission
local united_sp_mission = function()
  return retry(united_battle_home_tap_sp_mission)(10)
end

-- Lessons event
local lessons_mission = function()
  retry(lessons_home_tap_mission(1))()

  -- the confirm here only responds to short taps
  return retry(lessons_mission_tap_confirm)(10, 0.1)
end

-- Poker secret room
local poker_secret_room = function()
  local act = function()
    return retry(poker_secret_room_tap("THIRD"))(10)
  end

  act()
  if poker_use_key() then
    -- Poker use key confirm only responds to short taps
    retry(poker_secret_room_use_key_tap_confirm)(5, 0.1)
    return act()
  end
end



---------------------------------
-- Options for Battle Complete --
---------------------------------

local battle_complete_saved_mission = function()
  return retry(mission_complete_tap_saved_mission)()
end
local battle_complete_confirm = function()
  return retry(mission_complete_rewards_tap_confirm)(10)
end


function execute_with(mission_sel, on_battle_complete)
  return function(k)

    return with_insufficient_ap_check(mission_sel, ALLOWED_AP_OPTIONS)(function()
      retry(battle_helper_select_tap_first_helper)(2)
      retry(battle_party_select_tap_confirm)()

      return in_battle_daemon()(function()
        mission_complete_proceed_to_rewards_confirm()
        if mission_complete_battle_complete_friend_request() then
          if LOG_ENABLED then
            log("battle_complete, got friend request prompt, tap_discard")
          end
          retry(mission_complete_friend_request_tap_discard)()
        end

        if mission_complete_rank_up() then
          if LOG_ENABLED then
            log("battle_complete, rank_up_tap_confirm")
          end
          retry(mission_complete_rank_up_tap_confirm)()
        end

        on_battle_complete()
        return k()
      end)
    end)
  end
end

local execute = execute_with(
                             --missions_battle
                             --missions_sixth_battle
                             --united_sp_mission
                             --missions_daily
                             --poker_secret_room
                             lessons_mission
                             ,

                             --battle_complete_saved_mission
                             battle_complete_confirm
                             )
local function main()
  return execute(main)
end

main()
