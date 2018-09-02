---------------------------
-- Dimensions and Timing --
---------------------------

local WAIT_LOADING = true
local DEFAULT_TAP_PAUSE_SEC = 5
local DEFAULT_TAP_DUR_SEC = 1
local DEFAULT_BATTLE_DAEMON_INTERVAL_SEC = 5
local DEFAULT_SWIPE_LENGTH_RES = 500
local DEFAULT_SWIPE_BEGIN_SEC = 0.5
local DEFAULT_SWIPE_END_SEC = 0.5
local DEFAULT_SWIPE_DUR_SEC = 0.1
local DEFAULT_GIFTBOX_PAUSE_DUR_SEC = 10


function fif(cond, a, b)
  if cond then
    return a()
  else
    return b()
  end
end

function mytap(x, y, dur)
  ctouchDown(0, x, y)
  sleep_sec(fif(dur, thunk(dur), thunk(DEFAULT_TAP_DUR_SEC)))
  ctouchUp(0, x, y)
end

function tap_and_pause(x, y, pause, hold)
  mytap(x, y, hold)
  sleep_sec(fif(pause, thunk(pause), thunk(DEFAULT_TAP_PAUSE_SEC)))
end

function generate_tap_function(name, cx, cy)
  local x,y = adjust_coords(cx, cy)

  return function(pause, hold)
    return function(k)
      return k(cx, cy, function()
        if LOG_ENABLED then
          log(string.format("%s, x:%d, y:%d", name, x, y))
          log(name .. ", pause:" .. (pause or "false/nil") .. ", hold:" .. (hold or "false/nil"))
        end

        tap_and_pause(x, y, pause, hold)
        wait_network_loading()
      end)
    end
  end
end

function swipe(cx, cy, cx_end, cy_end)
  local x,y = adjust_coords(cx, cy)
  local x_end,y_end = adjust_coords(cx_end, cy_end)

  ctouchDown(0, x, y)
  sleep_sec(DEFAULT_SWIPE_BEGIN_SEC)

  ctouchMove(0, x_end, y_end)
  sleep_sec(DEFAULT_SWIPE_DUR_SEC)

  ctouchUp(0, x_end, y_end)
  sleep_sec(DEFAULT_SWIPE_END_SEC)
end

function match_all_colors(cs)
  return LIST.foldl(function(e, loc)
    return e and match_color(loc.color, loc.x, loc.y)
  end, true, cs)
end

function match_any_colors(cs)
  return LIST.foldl(function(e, loc)
    return e or match_color(loc.color, loc.x, loc.y)
  end, false, cs)
end



-----------------------------------------
-- Taps for buttons in various screens --
-----------------------------------------

home_tap_missions = generate_tap_function("home_tap_missions",
                                          HORTENSIA.HOME.MISSIONS.x,
                                          HORTENSIA.HOME.MISSIONS.y)
home_tap_status_bar = generate_tap_function("home_tap_status_bar",
                                            HORTENSIA.HOME.STATUS_BAR.x,
                                            HORTENSIA.HOME.STATUS_BAR.y)


missions_tap_home_or_back = generate_tap_function("missions_tap_home_or_back",
                                                  HORTENSIA.MISSIONS.HOME_OR_BACK.x,
                                                  HORTENSIA.MISSIONS.HOME_OR_BACK.y)
missions_tap_daily_missions = generate_tap_function("missions_tap_daily_missions",
                                                    HORTENSIA.MISSIONS.DAILY.x,
                                                    HORTENSIA.MISSIONS.DAILY.y)
missions_daily_tap_mission = function(mission_name)
  local name = "missions_daily_tap_mission_" .. mission_name
  return generate_tap_function(name,
                               HORTENSIA.MISSIONS.DAILY[mission_name].x,
                               HORTENSIA.MISSIONS.DAILY[mission_name].y)
end
missions_three_battles_tap_battle = function(number)
  local name = "missions_three_battles_tap_battle_" .. number
  return generate_tap_function("missions_tap_daily_missions",
                               HORTENSIA.MISSIONS.THREE_BATTLES[number].x,
                               HORTENSIA.MISSIONS.THREE_BATTLES[number].y)
end
missions_tap_dropdown = generate_tap_function("missions_tap_dropdown",
                                              HORTENSIA.MISSIONS.DROPDOWN.x,
                                              HORTENSIA.MISSIONS.DROPDOWN.y)
missions_dropdown_tap_giftbox = generate_tap_function("missions_dropdown_tap_giftbox",
                                                      HORTENSIA.MISSIONS.DROPDOWN.GIFTBOX.x,
                                                      HORTENSIA.MISSIONS.DROPDOWN.GIFTBOX.y)
missions_tap_boss = generate_tap_function("missions_tap_boss",
                                          HORTENSIA.MISSIONS.BOSS.x,
                                          HORTENSIA.MISSIONS.BOSS.y)


giftbox_tap_items = generate_tap_function("giftbox_tap_items",
                                          HORTENSIA.GIFTBOX.ITEMS.x,
                                          HORTENSIA.GIFTBOX.ITEMS.y)
giftbox_tap_cards = generate_tap_function("giftbox_tap_cards",
                                          HORTENSIA.GIFTBOX.CARDS.x,
                                          HORTENSIA.GIFTBOX.CARDS.y)
giftbox_tap_accept_once = generate_tap_function("giftbox_tap_accept_once",
                                                HORTENSIA.GIFTBOX.ACCEPT_ONCE.x,
                                                HORTENSIA.GIFTBOX.ACCEPT_ONCE.y)
giftbox_accepted_tap_confirm = generate_tap_function("giftbox_accepted_tap_confirm",
                                                     HORTENSIA.GIFTBOX.ACCEPT_CONFIRMATION.x,
                                                     HORTENSIA.GIFTBOX.ACCEPT_CONFIRMATION.y)


battle_helper_select_tap_first_helper = generate_tap_function("battle_helper_select_tap_first_helper",
                                                              HORTENSIA.BATTLE.HELPER_SELECT.FIRST.x,
                                                              HORTENSIA.BATTLE.HELPER_SELECT.FIRST.y)
battle_party_select_tap_confirm = generate_tap_function("battle_helper_select_tap_confirm",
                                                        HORTENSIA.BATTLE.PARTY_SELECT.CONFIRM.x,
                                                        HORTENSIA.BATTLE.PARTY_SELECT.CONFIRM.y)
battle_party_select_tap_close = generate_tap_function("battle_helper_select_tap_close",
                                                      HORTENSIA.BATTLE.PARTY_SELECT.CLOSE.x,
                                                      HORTENSIA.BATTLE.PARTY_SELECT.CLOSE.y)
battle_failed_tap_stone_resume = generate_tap_function("battle_failed_tap_stone_resume",
                                                       HORTENSIA.BATTLE.FAILED.STONE_RESUME.x,
                                                       HORTENSIA.BATTLE.FAILED.STONE_RESUME.y)
battle_failed_tap_retreat = generate_tap_function("battle_failed_tap_retreat",
                                                  HORTENSIA.BATTLE.FAILED.RETREAT.x,
                                                  HORTENSIA.BATTLE.FAILED.RETREAT.y)


mission_complete_rewards_tap_confirm = generate_tap_function("mission_complete_rewards_tap_confirm",
                                                             HORTENSIA.BATTLE.COMPLETE.CONFIRM.x,
                                                             HORTENSIA.BATTLE.COMPLETE.CONFIRM.y)
mission_complete_EP_tap_confirm = generate_tap_function("mission_complete_EP_tap_confirm",
                                                        HORTENSIA.BATTLE.COMPLETE.CONFIRM.x,
                                                        HORTENSIA.BATTLE.COMPLETE.CONFIRM.y)


insufficient_ap_tap_potion = function(potion_name)
  local name = "insufficient_ap_tap_potion_" .. potion_name
  return generate_tap_function(name,
                               HORTENSIA.MISSIONS.INSUFFICIENT_AP[potion_name].x,
                               HORTENSIA.MISSIONS.INSUFFICIENT_AP[potion_name].y)
end
insufficient_ap_tap_consume_confirm = generate_tap_function("insufficient_ap_tap_consume_confirm",
							                                              HORTENSIA.MISSIONS.INSUFFICIENT_AP.CONSUME_CONFIRM.x,
                                                            HORTENSIA.MISSIONS.INSUFFICIENT_AP.CONSUME_CONFIRM.y)
insufficient_ap_tap_consumed_still_insufficient_confirm = generate_tap_function("insufficient_ap_tap_consumed_still_insufficient_confirm",
                                                            										HORTENSIA.MISSIONS.INSUFFICIENT_AP.CONSUMED_STILL_INSUFFICIENT.CONFIRM.x,
                                                            										HORTENSIA.MISSIONS.INSUFFICIENT_AP.CONSUMED_STILL_INSUFFICIENT.CONFIRM.y)


oath_encountered_tap_proceed = generate_tap_function("oath_encountered_tap_proceed",
                                                     HORTENSIA.OATH.ENCOUNTERED.PROCEED.x,
                                                     HORTENSIA.OATH.ENCOUNTERED.PROCEED.y)
oath_battle_prep_tap_proceed = generate_tap_function("oath_battle_prep_tap_proceed",
                                                     HORTENSIA.OATH.BATTLE.PREP.PROCEED.x,
                                                     HORTENSIA.OATH.BATTLE.PREP.PROCEED.y)
oath_battle_party_select_rp_select_tap_rp = function(rp)
  local name = "oath_battle_party_select_rp_select_tap_rp_" .. rp
  return generate_tap_function(name,
                               HORTENSIA.OATH.BATTLE.PARTY_SELECT.RP_SELECT[rp].x,
                               HORTENSIA.OATH.BATTLE.PARTY_SELECT.RP_SELECT[rp].y)
end
oath_battle_complete_tap_boss = generate_tap_function("oath_battle_complete_tap_boss",
                                                      HORTENSIA.OATH.BATTLE.COMPLETE.BOSS.x,
                                                      HORTENSIA.OATH.BATTLE.COMPLETE.BOSS.y)
oath_battle_complete_tap_oath_home = generate_tap_function("oath_battle_complete_tap_oath_home",
                                                           HORTENSIA.OATH.BATTLE.COMPLETE.OATH_HOME.x,
                                                           HORTENSIA.OATH.BATTLE.COMPLETE.OATH_HOME.y)
oath_battle_complete_tap_saved_mission = generate_tap_function("oath_battle_complete_tap_saved_mission",
                                                               HORTENSIA.OATH.BATTLE.COMPLETE.SAVED_MISSION.x,
                                                               HORTENSIA.OATH.BATTLE.COMPLETE.SAVED_MISSION.y)
oath_home_tap_missions = generate_tap_function("oath_home_tap_missions",
                                               HORTENSIA.OATH.HOME.MISSIONS.x,
                                               HORTENSIA.OATH.HOME.MISSIONS.y)
oath_home_tap_battle = generate_tap_function("oath_home_tap_battle",
                                             HORTENSIA.OATH.HOME.BATTLE.x,
                                             HORTENSIA.OATH.HOME.BATTLE.y)
oath_battle_party_select_consume_rp_tap_confirm = generate_tap_function("oath_battle_party_select_consume_rp",
                                                                        HORTENSIA.OATH.BATTLE.PARTY_SELECT.INSUFFICIENT_RP.CONSUME.CONFIRM.x,
                                                                        HORTENSIA.OATH.BATTLE.PARTY_SELECT.INSUFFICIENT_RP.CONSUME.CONFIRM.y)
oath_battle_party_select_rp_consumed_tap_proceed = generate_tap_function("oath_battle_party_select_rp_consumed_tap_proceed",
                                                                         HORTENSIA.OATH.BATTLE.PARTY_SELECT.INSUFFICIENT_RP.CONSUME.CONFIRM.x,
                                                                         HORTENSIA.OATH.BATTLE.PARTY_SELECT.INSUFFICIENT_RP.CONSUME.CONFIRM.y)
oath_battle_party_select_rp_purchase_tap_close = generate_tap_function("oath_battle_party_select_consume_rp",
                                                                       HORTENSIA.OATH.BATTLE.PARTY_SELECT.INSUFFICIENT_RP.PURCHASE.CLOSE.x,
                                                                       HORTENSIA.OATH.BATTLE.PARTY_SELECT.INSUFFICIENT_RP.PURCHASE.CLOSE.y)



----------------------
-- In Battle Daemon --
----------------------

function in_battle_daemon(battle_complete, interval)
  local thunk_interval = thunk(interval)
  local thunk_default_interval = thunk(DEFAULT_BATTLE_DAEMON_INTERVAL_SEC)
  local thunk_battle_complete = thunk(battle_complete)
  local thunk_mission_complete = thunk(mission_complete)

  local function f(succ_k, fail_k)
    if fif(battle_complete, thunk_battle_complete, thunk_mission_complete)() then
      if LOG_ENABLED then
        log("battle complete!")
      end
      return succ_k()
    end

    if mission_failed() then
      if LOG_ENABLED then
        log("battle failed!")
      end

      if not fail_k then
        return alert("battle failed, no continuation for battle failure!");

      else
        return fail_k()
      end
    end

    if LOG_ENABLED then
      log("battle not complete")
    end

    LIST.fmap(activate_skill, HORTENSIA.BATTLE_MEMBERS_LIST)
    sleep_sec(fif(interval, thunk_interval, thunk_default_interval))

    return f(succ_k, fail_k)
  end

  return f
end

function activate_skill(member)
  local cx,cy = HORTENSIA.IN_BATTLE.MEMBERS[member].SKILLBAR.TOP.x, HORTENSIA.IN_BATTLE.MEMBERS[member].SKILLBAR.TOP.y

  if not match_color(HORTENSIA.IN_BATTLE.COLORS.SKILLBAR.FULL, cx, cy) then
    if LOG_ENABLED then
      log(string.format("skillbar not full for member[%s], with skillbar_color[%d]", member, cgetColor(cx, cy)))
    end
    return
  end

  if LOG_ENABLED then
    log(string.format("activating skill for member[%s]", member))
  end

  return swipe(cx, cy, cx-DEFAULT_SWIPE_LENGTH_RES, cy)
end

function mission_complete()
  return match_all_colors(HORTENSIA.BATTLE.COMPLETE.COLORS)
end

function mission_failed()
  return match_all_colors(HORTENSIA.BATTLE.FAILED.COLORS)
end



----------
-- Oath --
----------

function encountered_oath()
  return match_all_colors(HORTENSIA.OATH.ENCOUNTERED.COLORS)
end

function oath_battle_complete()
  act_once(oath_battle_complete_tap_boss)(2)

  local function f()
    return match_all_colors(HORTENSIA.OATH.BATTLE.COMPLETE.COLORS)
  end

  if f() then
    sleep_sec(2)
    return f()
  end

  return false
end

function insufficient_rp_consume()
  return match_all_colors(HORTENSIA.OATH.BATTLE.PARTY_SELECT.INSUFFICIENT_RP.CONSUME.COLORS)
end

function insufficient_rp_purchase()
  return match_all_colors(HORTENSIA.OATH.BATTLE.PARTY_SELECT.INSUFFICIENT_RP.PURCHASE.COLORS)
end

function with_insufficient_rp_check(action, rp_amount, allow_potions)
  local function f(k)
    if LOG_ENABLED then
      log(string.format("with_insufficient_rp_check executing action with allow_potions[%s]", tostring(allow_potions)))
    end
    action()

    local rp_consume = insufficient_rp_consume()
    local rp_purchase = insufficient_rp_purchase()
    if (not rp_consume) and (not rp_purchase) then
      return k()
    end

    if rp_consume and allow_potions then
      act_once(oath_battle_party_select_consume_rp_tap_confirm)()
      retry(oath_battle_party_select_rp_consumed_tap_proceed)()
      return k()
    end

    if rp_purchase or (not allow_potions) then
      retry(oath_battle_party_select_rp_purchase_tap_close)()
      retry(battle_party_select_tap_close)()

      if LOG_ENABLED then
        log("Insufficient rp, accepting items from giftbox")
      end
      giftbox_accept_items()
      retry(missions_tap_dropdown)()
      retry(home_tap_missions)()

      if in_mission_boss_unavailable() then
        return alert("boss not available, cannot proceed")
      end
      retry(missions_tap_boss)()

      if LOG_ENABLED then
        log(string.format("Insufficient rp, sleeping for [%d*10] minutes", rp_amount))
      end
      sleep_sec(rp_amount * 60 * 10)
      if LOG_ENABLED then
        log(string.format("Woken after [%d*10] minutes, resuming", rp_amount))
      end

      retry(oath_battle_prep_tap_proceed)()
      retry(battle_helper_select_tap_first_helper)()
      retry(battle_party_select_tap_confirm)()

      return f(k)
    end
  end

  return f
end

function in_mission_boss_unavailable()
  local cx,cy = HORTENSIA.MISSIONS.BOSS.x,HORTENSIA.MISSIONS.BOSS.y
  return match_color(HORTENSIA.MISSIONS.BOSS.COLOR.UNAVAILABLE, cx, cy)
end


--------------
-- Gift Box --
--------------

function giftbox_accept_items(pause, hold)
  retry(missions_tap_dropdown)(pause, hold)

  -- GiftBox loading may take a long time, pause for extended duration
  retry(missions_dropdown_tap_giftbox)(DEFAULT_GIFTBOX_PAUSE_DUR_SEC, hold)

  if not in_giftbox_items() then
    retry(giftbox_tap_items)(DEFAULT_GIFTBOX_PAUSE_DUR_SEC, hold)
  end

  if giftbox_accept_once_available() then
    if LOG_ENABLED then
      log("accepting once from giftbox items")
    end

    retry(giftbox_tap_accept_once)(pause, hold)
    retry(giftbox_accepted_tap_confirm)(pause, hold)

  else
    if LOG_ENABLED then
      log("nothing to accept in giftbox items")
    end
  end

  return
end

function giftbox_accept_once_available()
  local cx,cy = HORTENSIA.GIFTBOX.ACCEPT_ONCE.x,HORTENSIA.GIFTBOX.ACCEPT_ONCE.y
  return match_color(HORTENSIA.GIFTBOX.ACCEPT_ONCE.COLOR.AVAILABLE, cx, cy)
end

function in_giftbox_items()
  local cx,cy = HORTENSIA.GIFTBOX.ITEMS.x,HORTENSIA.GIFTBOX.ITEMS.y
  return match_color(HORTENSIA.GIFTBOX.ITEMS.COLOR.HIGHLIGHTED, cx, cy)
end

function in_giftbox_cards()
  local cx,cy = HORTENSIA.GIFTBOX.CARDS.x,HORTENSIA.GIFTBOX.CARDS.y
  return match_color(HORTENSIA.GIFTBOX.CARDS.COLOR.HIGHLIGHTED, cx, cy)
end


----------------------------
-- Insufficient AP Checks --
----------------------------

function with_insufficient_ap_check(action, ap_options)
  local function f(k)
    if LOG_ENABLED then
      log(string.format("with_insufficient_ap_check executing action with ap_options[%s]", tostring(ap_options)))
    end
    action()

    if (not insufficient_ap()) then
      return k()
    end

    local ap_consumed = LIST.foldl(function(consumed, ap_option)
      if consumed then
        return true
      end

      if not ap_option_available(ap_option) then
        return false
      end

      consume_ap_option(ap_option.name)
      return true

    end, false, LIST.fmap(function(ap_option)
      return HORTENSIA.MISSIONS.INSUFFICIENT_AP[ap_option]
    end, ap_options))

    if not ap_consumed then
      return alert("insufficient ap!")
    end

    if ap_consumed_still_insufficient() then
      if LOG_ENABLED then
        log("ap consumed but still insufficient!")
      end
      retry(insufficient_ap_tap_consumed_still_insufficient_confirm)()
      return f(k)
    else
      return k()
    end
  end

  return f
end

function insufficient_ap()
  return match_all_colors(HORTENSIA.MISSIONS.INSUFFICIENT_AP.COLORS)
end

function ap_option_available(loc)
  return match_color(loc.COLOR.AVAILABLE, loc.x, loc.y)
end

function consume_ap_option(name)
  if LOG_ENABLED then
    log(string.format("consume_ap_option for option[%s]", name))
  end

  retry(insufficient_ap_tap_potion(name))()
  retry(insufficient_ap_tap_consume_confirm)()
end

function ap_consumed_still_insufficient()
  return match_all_colors(HORTENSIA.MISSIONS.INSUFFICIENT_AP.CONSUMED_STILL_INSUFFICIENT.COLORS)
end


-----------------------
-- Loading Detection --
-----------------------

-- Deprecated due to loading image changed
function deprecated_wait_network_loading()
  if WAIT_LOADING then
    local ccs = LIST.fmap(function(c)
      return {
        x = HORTENSIA.LOADING.CIRCLE.CENTER.x,
        y = HORTENSIA.LOADING.CIRCLE.CENTER.y,
        color = c
      }
    end, HORTENSIA.LOADING.CIRCLE.CENTER.COLORS)

    while match_any_colors(ccs) do
      if LOG_ENABLED then
        log("waiting for network loading")
      end
      sleep_sec(1)
    end
  end
end

function wait_network_loading()
  if WAIT_LOADING then
    while match_all_colors(HORTENSIA.LOADING.RUNNING.COLORS) do
      if LOG_ENABLED then
        log("waiting for network loading")
      end
      sleep_sec(1)
    end
  end
end
