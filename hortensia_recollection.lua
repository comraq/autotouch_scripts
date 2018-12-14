require("utils/lib_loader")

LOG_ENABLED = true
STAGE_NUM = 3
ALLOWED_AP_OPTIONS = {
  "AP10",
  "AP30",
  "AP50",
  "APMAX"
}
ALLOWED_BP_OPTIONS = {}
ALLOWED_TICKET_OPTIONS = {
  --"ADELHEID",
  "CHARLOT",
  "MARYUS",
  "MAURICE",
  "DEFROT"
}

FINAL_WAVE_SKILL = true
MUS_PAUSE = 0.1
MUS_HOLD = 0
MUSA_PAUSE = 5
MUSA_HOLD = 0.3
REC_PATHS_LOAD_PAUSE = 7
REC_HOME_LOAD_PAUSE = 10


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

local special_mission_complete = function()
  return mission_complete(mission_complete_special_complete)
end

local treasure_chance_complete = function()
  return recollection_treasure_chance_complete() or mission_complete_battle_complete_friend_request()
end

function exec_mission(k)
  -- Special Mission
  retry(battle_helper_select_tap_first_helper)()
  retry(battle_party_select_tap_confirm)()

  return in_battle_daemon(special_mission_complete)(function()

    mission_complete_proceed_to_rewards_confirm(REC_PATHS_LOAD_PAUSE)
    if mission_complete_battle_complete_friend_request() then
      if LOG_ENABLED then
        log("battle_complete, got friend request prompt, tap_discard")
      end
      retry(mission_complete_friend_request_tap_discard)(REC_PATHS_LOAD_PAUSE)
    end

    if mission_complete_rank_up() then
      if LOG_ENABLED then
        log("battle_complete, rank_up_tap_confirm")
      end
      retry(mission_complete_rank_up_tap_confirm)()
    end

    if recollection_treasure_chance() then
      if LOG_ENABLED then
        log("encountered treasure chance!")
      end
      return recollection_treasure_chance_battle(ALLOWED_TICKET_OPTIONS)(function()
        retry(battle_helper_select_tap_first_helper)()
        retry(battle_party_select_tap_confirm)()

        return in_battle_daemon(treasure_chance_complete)(function()
          if mission_complete_battle_complete_friend_request() then
            if LOG_ENABLED then
              log("treasure chance battle complete, got friend request prompt")
            end
            retry(mission_complete_friend_request_tap_discard)()
          end

          sleep_sec(5) -- For stability, treasure_chance_complete animation may take some time
          retry(recollection_treasure_chance_complete_tap_confirm)(REC_PATHS_LOAD_PAUSE)
          return k()
        end)
      end, k)
    end

    act_once(mission_complete_special_tap_confirm)(REC_PATHS_LOAD_PAUSE)
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
      retry(missions_dropdown_tap_event(1))(REC_HOME_LOAD_PAUSE) -- Loading event may take time

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
