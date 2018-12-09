require("utils/lib_loader")

LOG_ENABLED = false
ALLOWED_BP_OPTIONS = {
  "EVENT_BP50",
  "EVENT_BPMAX"
}
FINAL_WAVE_SKILL = true
MUS_PAUSE = 0.1
MUS_HOLD = 0
MUSA_PAUSE = 5
MUSA_HOLD = 0.3


if LOG_ENABLED then
  log("\n\n\nbegin script logging:")
end

-------------------------------
-- Options for Aid Request Select --
-------------------------------

local aid_request_sel = function()
  return retry(magonia_aid_requests_tap_request(1))(0)
end

-------------------------------
-- Options for Unit Select --
-------------------------------

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

local exec_battle = function()
  unit_sel_attack1()
  if magonia_boss_unit_select() then
    unit_sel_attack2()
    if magonia_boss_unit_select() then
      unit_sel_attack3()
    end
  end
end

function execute_with(aid_request_sel)
  return function(k)
    retry(magonia_home_tap_aid_requests)(2)
    if not magonia_aid_requests_available() then
      retry(magonia_aid_requests_tap_home)(1)
      return k()
    end

    local function k2()
      aid_request_sel()

      while not magonia_boss_unit_select() do
        if magonia_aid_requests_battle_finished() then
          retry(magonia_aid_requests_battle_finished_tap_confirm)(2)
          return k2()
        end

        if LOG_ENABLED then
          log("tapped aid request but not yet magonia_boss_unit_select")
        end
      end

      return magonia_conduct_boss_battle(exec_battle)(function()
        magonia_boss_battle_complete_confirm_rewards()
        return k()
      end)
    end
    return k2()

  end
end

local execute = execute_with(aid_request_sel)
local function main()
  return execute(main)
end

main()
