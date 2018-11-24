require("utils/lib_loader")

LOG_ENABLED = true
ALLOWED_BP_OPTIONS = {
  "EVENT_BP50",
  "EVENT_BPMAX"
}
FINAL_WAVE_SKILL = true
MAGONIA_UNIT_SELECT_PAUSE = 0.1
MAGONIA_UNIT_SELECT_HOLD = 0
MAGONIA_UNIT_SELECT_ATTACK_PAUSE = 5
MAGONIA_UNIT_SELECT_ATTACK_HOLD = 0.3


if LOG_ENABLED then
  log("\n\n\nbegin script logging:")
end

-------------------------------
-- Options for Aid Request Select --
-------------------------------

local aid_request_sel = function()
  return retry(magonia_aid_requests_tap_request(1))()
end

-------------------------------
-- Options for Unit Select --
-------------------------------

local unit_sel_attack = function()
  retry(magonia_boss_unit_select_tap_unit(2))(MAGONIA_UNIT_SELECT_PAUSE,
                                              MAGONIA_UNIT_SELECT_HOLD)
  retry(magonia_boss_unit_select_tap_unit(3))(MAGONIA_UNIT_SELECT_PAUSE,
                                              MAGONIA_UNIT_SELECT_HOLD)
  retry(magonia_boss_unit_select_tap_unit(4))(MAGONIA_UNIT_SELECT_PAUSE,
                                              MAGONIA_UNIT_SELECT_HOLD)
  return retry(magonia_boss_unit_select_tap_attack)(MAGONIA_UNIT_SELECT_ATTACK_PAUSE,
                                                    MAGONIA_UNIT_SELECT_ATTACK_HOLD)
end

function execute_with(aid_request_sel)
  return function(k)
    if not magonia_home_bp_full() then
      retry(magonia_home_tap_bp_recover)()
      magonia_home_consume_bp(ALLOWED_BP_OPTIONS)
    end

    local function k2()
      retry(magonia_home_tap_aid_requests)()
      if not magonia_aid_requests_available() then
        retry(magonia_aid_requests_tap_home)()
        return k2()
      end

      local function k3()
        aid_request_sel()
        if magonia_aid_requests_battle_finished() then
          retry(magonia_aid_requests_battle_finished_tap_confirm)()
          return k3()
        end

        while not magonia_boss_unit_select() do
          if LOG_ENABLED then
            log("[THIS SHOULD NOT HAPPEN] not yet magonia_boss_unit_select, sleeping 0.5 seconds")
          end
          sleep_sec(0.5)
        end

        magonia_conduct_boss_battle(unit_sel_attack)(magonia_boss_battle_complete_confirm_rewards)
        return k()

      end
      return k3()

    end
    return k2()
  end
end

local execute = execute_with(aid_request_sel)
local function main()
  return execute(main)
end

main()
