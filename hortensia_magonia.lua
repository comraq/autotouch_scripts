require("utils/lib_loader")

LOG_ENABLED = false
ALLOWED_AP_OPTIONS = {
  "AP10",
  "AP30",
  "AP50",
  "APMAX"
}
ALLOWED_BP_OPTIONS = {
  "EVENT_BP50",
  "EVENT_BPMAX"
}
FINAL_WAVE_SKILL = true
MUS_PAUSE = 0.1
MUS_HOLD = 0.1
MUSA_PAUSE = 5
MUSA_HOLD = 0.3


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

local unit_sel_attack = function()
  act_once(magonia_boss_unit_select_tap_unit(1))(MUS_PAUSE, MUS_HOLD)
  act_once(magonia_boss_unit_select_tap_attack)(MUSA_PAUSE, MUSA_HOLD)
  return magonia_execute_boss_battle()
end
local function unit_sel_attack1()
  act_once(magonia_boss_unit_select_tap_unit(2))(MUS_PAUSE, MUS_HOLD)
  return magonia_boss_unit_select_with_insufficient_bp_check(ALLOWED_BP_OPTIONS, unit_sel_attack1, magonia_execute_boss_battle)(function()
    act_once(magonia_boss_unit_select_tap_unit(3))(MUS_PAUSE, MUS_HOLD)
    return magonia_boss_unit_select_with_insufficient_bp_check(ALLOWED_BP_OPTIONS, unit_sel_attack1, magonia_execute_boss_battle)(function()
      act_once(magonia_boss_unit_select_tap_unit(4))(MUS_PAUSE, MUS_HOLD)
      return magonia_boss_unit_select_with_insufficient_bp_check(ALLOWED_BP_OPTIONS, unit_sel_attack1, magonia_execute_boss_battle)(function()
        act_once(magonia_boss_unit_select_tap_attack)(MUSA_PAUSE, MUSA_HOLD)
        return magonia_execute_boss_battle()
      end)
    end)
  end)
end
local function unit_sel_attack2()
  act_once(magonia_boss_unit_select_tap_unit(3))(MUS_PAUSE, MUS_HOLD)
  return magonia_boss_unit_select_with_insufficient_bp_check(ALLOWED_BP_OPTIONS, unit_sel_attack2, magonia_execute_boss_battle)(function()
    act_once(magonia_boss_unit_select_tap_unit(4))(MUS_PAUSE, MUS_HOLD)
    return magonia_boss_unit_select_with_insufficient_bp_check(ALLOWED_BP_OPTIONS, unit_sel_attack2, magonia_execute_boss_battle)(function()
      act_once(magonia_boss_unit_select_tap_unit(5))(MUS_PAUSE, MUS_HOLD)
      return magonia_boss_unit_select_with_insufficient_bp_check(ALLOWED_BP_OPTIONS, unit_sel_attack2, magonia_execute_boss_battle)(function()
        act_once(magonia_boss_unit_select_tap_attack)(MUSA_PAUSE, MUSA_HOLD)
        return magonia_execute_boss_battle()
      end)
    end)
  end)
end
local function unit_sel_attack3()
  act_once(magonia_boss_unit_select_tap_unit(3))(MUS_PAUSE, MUS_HOLD)
  return magonia_boss_unit_select_with_insufficient_bp_check(ALLOWED_BP_OPTIONS, unit_sel_attack3, magonia_execute_boss_battle)(function()
    act_once(magonia_boss_unit_select_tap_unit(4))(MUS_PAUSE, MUS_HOLD)
    return magonia_boss_unit_select_with_insufficient_bp_check(ALLOWED_BP_OPTIONS, unit_sel_attack3, magonia_execute_boss_battle)(function()
      act_once(magonia_boss_unit_select_tap_unit(6))(MUS_PAUSE, MUS_HOLD)
      return magonia_boss_unit_select_with_insufficient_bp_check(ALLOWED_BP_OPTIONS, unit_sel_attack3, magonia_execute_boss_battle)(function()
        act_once(magonia_boss_unit_select_tap_attack)(MUSA_PAUSE, MUSA_HOLD)
        return magonia_execute_boss_battle()
      end)
    end)
  end)
end

--local exec_battle = unit_sel_attack
local exec_battle = function()
  unit_sel_attack1()
  if magonia_boss_unit_select() then
    unit_sel_attack2()
    if magonia_boss_unit_select() then
      unit_sel_attack3()
    end
  end
end

local request_aid = function()
  retry(magonia_boss_unit_select_tap_aid_request)(1)
  retry(magonia_boss_unit_select_aid_request_tap_all)()
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
          if mission_complete_battle_complete_friend_request() then
            if LOG_ENABLED then
              log("battle complete, got friend request prompt")
            end
            retry(mission_complete_friend_request_tap_discard)()
          end

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

    return magonia_conduct_boss_battle(exec_battle, request_aid)(function()
      magonia_boss_battle_complete_confirm_rewards()
      return k()
    end)
  end
end


local execute = execute_with(mission_sel)
local function main()
  return execute(main)
end

main()
