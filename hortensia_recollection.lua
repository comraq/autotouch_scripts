require("utils/lib_loader")

LOG_ENABLED = true
STAGE_NUM = 87
ALLOWED_AP_OPTIONS = {
  "AP10",
  "AP30",
  "AP50",
  "APMAX"
}
ALLOWED_BP_OPTIONS = {}

FINAL_WAVE_SKILL = true
MUS_PAUSE = 0.1
MUS_HOLD = 0
MUSA_PAUSE = 5
MUSA_HOLD = 0.3


if LOG_ENABLED then
  log("\n\n\nbegin script logging:")
end

local recollection_home_proceed = function()
  return retry(recollection_home_tap_proceed)()
end

-------------------------------
-- Options for Unit Select --
-------------------------------
local sk = function()
  return alert("no sk defined for recollection")
end

local ek = function()
  return alert("this should not happen, no ek defined for recollection")
end

local exec_battle = function()
  act_once(magonia_boss_unit_select_tap_unit(6))(MUS_PAUSE, MUS_HOLD)
  return magonia_boss_unit_select_with_insufficient_bp_check(ALLOWED_BP_OPTIONS, sk, ek)(function()
    act_once(magonia_boss_unit_select_tap_unit(7))(MUS_PAUSE, MUS_HOLD)
    return magonia_boss_unit_select_with_insufficient_bp_check(ALLOWED_BP_OPTIONS, sk, ek)(function()
      act_once(magonia_boss_unit_select_tap_unit(8))(MUS_PAUSE, MUS_HOLD)
      return magonia_boss_unit_select_with_insufficient_bp_check(ALLOWED_BP_OPTIONS, sk, ek)(function()
        act_once(magonia_boss_unit_select_tap_unit(9))(MUS_PAUSE, MUS_HOLD)
        return magonia_boss_unit_select_with_insufficient_bp_check(ALLOWED_BP_OPTIONS, sk, ek)(function()
          act_once(magonia_boss_unit_select_tap_unit(10))(MUS_PAUSE, MUS_HOLD)
          return magonia_boss_unit_select_with_insufficient_bp_check(ALLOWED_BP_OPTIONS, sk, ek)(function()
            act_once(magonia_boss_unit_select_tap_attack)(MUSA_PAUSE, MUSA_HOLD)
            return recollection_execute_boss_battle()
          end)
        end)
      end)
    end)
  end)
end

function get_stage(n)
  return HORTENSIA_RECOLLECTION[n]
end

function get_paths(stage)
  return HORTENSIA.RECOLLECTION.PATHS[stage.total]
end

function get_next_stage_num(n)
  if n >= 100 then
    return 1
  else
    return n + 1
  end
end

function exec_mission(k)
  -- Special Mission
  retry(battle_helper_select_tap_first_helper)()
  retry(battle_party_select_tap_confirm)()

  return in_battle_daemon(mission_complete_special_complete)(function()

    act_once(mission_complete_special_tap_confirm)(7)
    if recollection_treasure_chance() then
      return alert("treasure chance encountered!")
    end

    act_once(mission_complete_special_tap_confirm)()
    return k()
  end)
end

function execute_with(n, k)
  local stage = get_stage(n)
  local paths = get_paths(stage)

  if stage.lamp then
    return alert("encountered lamp path!")
  end

  if LOG_ENABLED then
    log(string.format("recollection proceeding with stage[%d]", n))
  end

  local tap_path = recollection_paths_tap_path(stage.total)
  local function f(i)
    if i > stage.total then
      local next_stage = get_next_stage_num(n)
      if LOG_ENABLED then
        log(string.format("exhausted all paths on stage[%d], proceeding with next_stage[%d]", n, next_stage))
      end
      return k(next_stage)
    end

    if recollection_path_taken(paths[i]) then
      if LOG_ENABLED then
        log(string.format("already taken current path[%d], moving onto next path", i))
      end
      return f(i + 1)
    end

    retry(tap_path(i))()
    retry(tap_screen_center)()

    if recollection_boss_encountered() then
      if LOG_ENABLED then
        log("recollection_boss_encountered, tapping screen center")
      end

      retry(tap_screen_center)()
      exec_battle()

      retry(recollection_boss_defeated_tap_items_confirm)()
      retry(recollection_boss_defeated_tap_proceed)(10)
      retry(tap_screen_center)()

      if LOG_ENABLED then
        log("recollection boss defeated")
      end

      return with_insufficient_ap_check(recollection_home_proceed, ALLOWED_AP_OPTIONS)(function()
        return exec_mission(function()
          local next_stage = get_next_stage_num(n)
          if LOG_ENABLED then
            log(string.format("proceeding with next_stage[%d]", next_stage))
          end
          return k(next_stage)
        end)
      end)
    end

    if recollection_paths_ap_insufficient() then
      if LOG_ENABLED then
        log("recollection_paths_ap_insufficient")
      end

      retry(recollection_paths_ap_insufficient_tap_confirm)()
      return with_insufficient_ap_check(recollection_home_proceed, ALLOWED_AP_OPTIONS)(function()
        return exec_mission(function()
          if not recollection_path_taken(paths[i]) then
            local next_stage = get_next_stage_num(n)
            if LOG_ENABLED then
              log(string.format("path just taken is available once again, moving onto next_stage[%d]", next_stage))
            end
            return k(next_stage)
          end
          return f(i + 1)
        end)
      end)
    end

    if LOG_ENABLED then
      log("recollection proceed with path")
    end
    return exec_mission(function()
      if not recollection_path_taken(paths[i]) then
        local next_stage = get_next_stage_num(n)
        if LOG_ENABLED then
          log(string.format("path just taken is available once again, moving onto next_stage[%d]", next_stage))
        end
        return k(next_stage)
      end
      return f(i + 1)
    end)
  end

  return f(1)
end

local function main(n)
  return execute_with(n, main)
end

main(STAGE_NUM)
