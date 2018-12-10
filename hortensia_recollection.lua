require("utils/lib_loader")

LOG_ENABLED = true
STAGE_NUM = 50
ALLOWED_AP_OPTIONS = {
  "AP10",
  "AP30",
  "AP50",
  "APMAX"
}
ALLOWED_BP_OPTIONS = {}
ALLOWED_TICKET_OPTIONS = {
  "CHARLOT",
  "MARYUS",
  "DEFROT",
  "MAURICE"
}

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

function exec_mission(k)
  -- Special Mission
  retry(battle_helper_select_tap_first_helper)()
  retry(battle_party_select_tap_confirm)()

  return in_battle_daemon(mission_complete_special_complete)(function()

    act_once(mission_complete_special_tap_confirm)(7)
    if recollection_treasure_chance() then
      if LOG_ENABLED then
        log("encountered treasure chance!")
      end
      return recollection_treasure_chance_battle(ALLOWED_TICKET_OPTIONS)(function()
        retry(battle_helper_select_tap_first_helper)()
        retry(battle_party_select_tap_confirm)()

        return in_battle_daemon(recollection_treasure_chance_complete)(function()
          sleep_sec(5) -- For stability, treasure_chance_complete animation may take some time
          retry(recollection_treasure_chance_complete_tap_confirm)()
          return k()
        end)
      end, k)
    end

    act_once(mission_complete_special_tap_confirm)()
    return k()
  end)
end

function execute_with(n, k)
  local stage = recollection_get_stage(n)
  local paths = recollection_get_paths(stage)

  if stage.lamp and not recollection_paths_lamp_in_use() then
    recollection_paths_use_lamp()
  end

  if LOG_ENABLED then
    log(string.format("recollection proceeding with stage[%d]", n))
  end

  local tap_path = recollection_paths_tap_path(stage.total)
  local ps = recollection_get_path_indices(stage)
  local function f(ps)
    if LIST.length(ps) == 0 then
      return alert("number of paths remain is 0, this should not happen")
    end

    local i = ps[1]
    if recollection_path_taken(paths[i]) then
      if LOG_ENABLED then
        log(string.format("already taken current path[%d], moving onto next path", i))
      end
      return f(LIST.tail(ps))
    end

    retry(tap_path(i))()
    retry(tap_screen_center)()

    if recollection_boss_encountered() then
      recollection_conduct_boss_battle(exec_battle)
      giftbox_accept_items()
      retry(missions_tap_dropdown)()
      retry(missions_dropdown_tap_event(2))(10) -- Loading event may take time

      return with_insufficient_ap_check(recollection_home_proceed, ALLOWED_AP_OPTIONS)(function()
        return exec_mission(function()
          local next_stage = recollection_get_next_stage_num(n)
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
            local next_stage = recollection_get_next_stage_num(n)
            if LOG_ENABLED then
              log(string.format("path just taken is available once again, moving onto next_stage[%d]", next_stage))
            end
            return k(next_stage)
          end
          return f(LIST.tail(ps))
        end)
      end)
    end

    if LOG_ENABLED then
      log("recollection proceed with path")
    end
    return exec_mission(function()
      if not recollection_path_taken(paths[i]) then
        local next_stage = recollection_get_next_stage_num(n)
        if LOG_ENABLED then
          log(string.format("path just taken is available once again, moving onto next_stage[%d]", next_stage))
        end
        return k(next_stage)
      end
      return f(LIST.tail(ps))
    end)
  end

  return f(ps)
end

local function main(n)
  return execute_with(n, main)
end

main(STAGE_NUM)
