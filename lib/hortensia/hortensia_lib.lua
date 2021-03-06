---------------------------
-- Dimensions and Timing --
---------------------------

local WAIT_LOADING = false -- Disabled due for stability
local DEFAULT_TAP_PAUSE_SEC = 5
local DEFAULT_TAP_DUR_SEC = 1
local DEFAULT_BATTLE_DAEMON_INTERVAL_SEC = 0
local DEFAULT_SWIPE_LENGTH_RES = 500
local DEFAULT_SWIPE_BEGIN_SEC = 0.5
local DEFAULT_SWIPE_END_SEC = 0.5
local DEFAULT_SWIPE_DUR_SEC = 0.1
local DEFAULT_GIFTBOX_PAUSE_DUR_SEC = 10
local DEFAULT_MISSION_COMPLETE_REAFFIRM_DELAY_SEC = 2

local NO_LOADING_TAP_PAUSE_SEC = 0
local MAGONIA_REC_TAP_DUR_SEC = 0.1
local MAGONIA_REC_TAP_PAUSE_SEC = 0.5
local MAGONIA_REC_CONFIRM_TAP_PAUSE_SEC = 2

local RECOLLECTION_NEXT_IMAGE_PATH = "screenshots/recollection_next.bmp"
local RECOLLECTION_NEXT_IMAGE_WIDTH = 300
local RECOLLECTION_NEXT_IMAGE_HEIGHT = 200
local FIND_IMAGE_FUZZY = 0.4


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

function generate_act_function(name, cx, cy)
  local x,y = adjust_coords(cx, cy)

  return function(k, pause, hold)
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

function color_available(loc)
  if loc.COLOR.AVAILABLE then
    return match_color(loc.COLOR.AVAILABLE, loc.x, loc.y)
  elseif loc.COLOR.UNAVAILABLE then
    return not match_color(loc.COLOR.UNAVAILABLE, loc.x, loc.y)
  else
    return alert(string.format("No color for available or unavailable at loc.x[%f], loc.y[%f]", loc.x, loc.y))
  end
end



-----------------------------------------
-- Taps for buttons in various screens --
-----------------------------------------
tap_screen_center = generate_act_function("tap_screen_center",
                                          DEFAULT_WIDTH / 2,
                                          DEFAULT_HEIGHT / 2)


home_tap_missions = generate_act_function("home_tap_missions",
                                          HORTENSIA.HOME.MISSIONS.x,
                                          HORTENSIA.HOME.MISSIONS.y)
home_tap_status_bar = generate_act_function("home_tap_status_bar",
                                            HORTENSIA.HOME.STATUS_BAR.x,
                                            HORTENSIA.HOME.STATUS_BAR.y)


missions_tap_home_or_back = generate_act_function("missions_tap_home_or_back",
                                                  HORTENSIA.MISSIONS.HOME_OR_BACK.x,
                                                  HORTENSIA.MISSIONS.HOME_OR_BACK.y)
missions_tap_daily_missions = generate_act_function("missions_tap_daily_missions",
                                                    HORTENSIA.MISSIONS.DAILY.x,
                                                    HORTENSIA.MISSIONS.DAILY.y)
missions_daily_tap_mission = function(mission_name)
  local name = "missions_daily_tap_mission_" .. mission_name
  return generate_act_function(name,
                               HORTENSIA.MISSIONS.DAILY[mission_name].x,
                               HORTENSIA.MISSIONS.DAILY[mission_name].y)
end
missions_three_battles_tap_battle = function(number)
  local name = "missions_three_battles_tap_battle_" .. number
  return generate_act_function(name,
                               HORTENSIA.MISSIONS.THREE_BATTLES[number].x,
                               HORTENSIA.MISSIONS.THREE_BATTLES[number].y)
end
poker_secret_room_tap = function(number)
  local name = "poker_secret_room_tap_" .. number
  return generate_act_function(name,
                               HORTENSIA.POKER.SECRET_ROOM[number].x,
                               HORTENSIA.POKER.SECRET_ROOM[number].y)
end
poker_secret_room_use_key_tap_confirm =
  generate_act_function("poker_secret_room_use_key_tap_confirm",
                        HORTENSIA.POKER.SECRET_ROOM.USE_KEY.CONFIRM.x,
                        HORTENSIA.POKER.SECRET_ROOM.USE_KEY.CONFIRM.y)
poker_secret_room_use_key_tap_cancel =
  generate_act_function("poker_secret_room_use_key_tap_cancel",
                        HORTENSIA.POKER.SECRET_ROOM.USE_KEY.CANCEL.x,
                        HORTENSIA.POKER.SECRET_ROOM.USE_KEY.CANCEL.y)

missions_tap_dropdown = generate_act_function("missions_tap_dropdown",
                                              HORTENSIA.MISSIONS.DROPDOWN.x,
                                              HORTENSIA.MISSIONS.DROPDOWN.y)
missions_dropdown_tap_giftbox = generate_act_function("missions_dropdown_tap_giftbox",
                                                      HORTENSIA.MISSIONS.DROPDOWN.GIFTBOX.x,
                                                      HORTENSIA.MISSIONS.DROPDOWN.GIFTBOX.y)
missions_dropdown_tap_event = function(n)
  local name = string.format("missions_dropdown_tap_event_[%d", n)
  return generate_act_function(name,
                               HORTENSIA.MISSIONS.DROPDOWN.EVENT[n].x,
                               HORTENSIA.MISSIONS.DROPDOWN.EVENT[n].y)
end
missions_tap_boss = generate_act_function("missions_tap_boss",
                                          HORTENSIA.MISSIONS.BOSS.x,
                                          HORTENSIA.MISSIONS.BOSS.y)

missions_tap_knights_quest_tab = generate_act_function("missions_tap_knights_quest_tab",
                                                       HORTENSIA.MISSIONS.KNIGHTS_QUEST.TAB.x,
                                                       HORTENSIA.MISSIONS.KNIGHTS_QUEST.TAB.y)


missions_knights_quest_tap_quest = function(number)
  local name = "missions_knights_quest_tap_quest_" .. number
  return generate_act_function(name,
                               HORTENSIA.MISSIONS.KNIGHTS_QUEST[number].x,
                               HORTENSIA.MISSIONS.KNIGHTS_QUEST[number].y)
end


giftbox_tap_items = generate_act_function("giftbox_tap_items",
                                          HORTENSIA.GIFTBOX.ITEMS.x,
                                          HORTENSIA.GIFTBOX.ITEMS.y)
giftbox_tap_cards = generate_act_function("giftbox_tap_cards",
                                          HORTENSIA.GIFTBOX.CARDS.x,
                                          HORTENSIA.GIFTBOX.CARDS.y)
giftbox_tap_accept_once = generate_act_function("giftbox_tap_accept_once",
                                                HORTENSIA.GIFTBOX.ACCEPT_ONCE.x,
                                                HORTENSIA.GIFTBOX.ACCEPT_ONCE.y)
giftbox_accepted_tap_confirm = generate_act_function("giftbox_accepted_tap_confirm",
                                                     HORTENSIA.GIFTBOX.ACCEPT_CONFIRMATION.x,
                                                     HORTENSIA.GIFTBOX.ACCEPT_CONFIRMATION.y)


battle_helper_select_tap_first_helper = generate_act_function("battle_helper_select_tap_first_helper",
                                                              HORTENSIA.BATTLE.HELPER_SELECT.FIRST.x,
                                                              HORTENSIA.BATTLE.HELPER_SELECT.FIRST.y)
battle_party_select_tap_confirm = generate_act_function("battle_helper_select_tap_confirm",
                                                        HORTENSIA.BATTLE.PARTY_SELECT.CONFIRM.x,
                                                        HORTENSIA.BATTLE.PARTY_SELECT.CONFIRM.y)
battle_party_select_tap_close = generate_act_function("battle_helper_select_tap_close",
                                                      HORTENSIA.BATTLE.PARTY_SELECT.CLOSE.x,
                                                      HORTENSIA.BATTLE.PARTY_SELECT.CLOSE.y)
battle_failed_tap_stone_resume = generate_act_function("battle_failed_tap_stone_resume",
                                                       HORTENSIA.BATTLE.FAILED.STONE_RESUME.x,
                                                       HORTENSIA.BATTLE.FAILED.STONE_RESUME.y)
battle_failed_tap_retreat = generate_act_function("battle_failed_tap_retreat",
                                                  HORTENSIA.BATTLE.FAILED.RETREAT.x,
                                                  HORTENSIA.BATTLE.FAILED.RETREAT.y)


mission_complete_friend_request_tap_send =
  generate_act_function("mission_complete_friend_request_tap_send",
                        HORTENSIA.BATTLE.COMPLETE.FRIEND_REQUEST.SEND.x,
                        HORTENSIA.BATTLE.COMPLETE.FRIEND_REQUEST.SEND.y)
mission_complete_friend_request_tap_discard =
  generate_act_function("mission_complete_friend_request_tap_discard",
                        HORTENSIA.BATTLE.COMPLETE.FRIEND_REQUEST.DISCARD.x,
                        HORTENSIA.BATTLE.COMPLETE.FRIEND_REQUEST.DISCARD.y)
mission_complete_special_tap_confirm = generate_act_function("mission_complete_special_tap_confirm",
                                                             HORTENSIA.BATTLE.SPECIAL_COMPLETE.CONFIRM.x,
                                                             HORTENSIA.BATTLE.SPECIAL_COMPLETE.CONFIRM.y)

-- Note: mission_complete_rewards_tap_confirm = mission_complete_EP_tap_confirm
mission_complete_rewards_tap_confirm = generate_act_function("mission_complete_rewards_tap_confirm",
                                                             HORTENSIA.BATTLE.COMPLETE.CONFIRM.x,
                                                             HORTENSIA.BATTLE.COMPLETE.CONFIRM.y)
mission_complete_EP_tap_confirm = generate_act_function("mission_complete_EP_tap_confirm",
                                                        HORTENSIA.BATTLE.COMPLETE.CONFIRM.x,
                                                        HORTENSIA.BATTLE.COMPLETE.CONFIRM.y)
mission_complete_tap_saved_mission = generate_act_function("mission_complete_tap_saved_mission",
                                                           HORTENSIA.BATTLE.COMPLETE.SAVED_MISSION.LOC.x,
                                                           HORTENSIA.BATTLE.COMPLETE.SAVED_MISSION.LOC.y)
mission_complete_rank_up_tap_confirm = generate_act_function("mission_complete_rank_up_tap_confirm",
                                                             HORTENSIA.BATTLE.COMPLETE.RANK_UP.CONFIRM.x,
                                                             HORTENSIA.BATTLE.COMPLETE.RANK_UP.CONFIRM.y)
mission_complete_ep_up_story_unlock_tap_confirm =
  generate_act_function("mission_complete_ep_up_story_unlock_tap_confirm",
                        HORTENSIA.BATTLE.COMPLETE.EP_UP.STORY_UNLOCK.CONFIRM.x,
                        HORTENSIA.BATTLE.COMPLETE.EP_UP.STORY_UNLOCK.CONFIRM.y)
mission_complete_ep_up_awakening_unlock_tap_confirm =
  generate_act_function("mission_complete_ep_up_awakening_unlock_tap_confirm",
                        HORTENSIA.BATTLE.COMPLETE.EP_UP.AWAKENING_UNLOCK.CONFIRM.x,
                        HORTENSIA.BATTLE.COMPLETE.EP_UP.AWAKENING_UNLOCK.CONFIRM.y)


insufficient_ap_tap_potion = function(potion_name)
  local name = "insufficient_ap_tap_potion_" .. potion_name
  return generate_act_function(name,
                               HORTENSIA.MISSIONS.INSUFFICIENT_AP[potion_name].LOC.x,
                               HORTENSIA.MISSIONS.INSUFFICIENT_AP[potion_name].LOC.y)
end
insufficient_ap_tap_consume_confirm = generate_act_function("insufficient_ap_tap_consume_confirm",
							                                              HORTENSIA.MISSIONS.INSUFFICIENT_AP.CONSUME_CONFIRM.x,
                                                            HORTENSIA.MISSIONS.INSUFFICIENT_AP.CONSUME_CONFIRM.y)
insufficient_ap_tap_consumed_still_insufficient_confirm = generate_act_function("insufficient_ap_tap_consumed_still_insufficient_confirm",
                                                            										HORTENSIA.MISSIONS.INSUFFICIENT_AP.CONSUMED_STILL_INSUFFICIENT.CONFIRM.x,
                                                            										HORTENSIA.MISSIONS.INSUFFICIENT_AP.CONSUMED_STILL_INSUFFICIENT.CONFIRM.y)


oath_encountered_tap_proceed = generate_act_function("oath_encountered_tap_proceed",
                                                     HORTENSIA.OATH.ENCOUNTERED.PROCEED.x,
                                                     HORTENSIA.OATH.ENCOUNTERED.PROCEED.y)
oath_battle_prep_tap_proceed = generate_act_function("oath_battle_prep_tap_proceed",
                                                     HORTENSIA.OATH.BATTLE.PREP.PROCEED.x,
                                                     HORTENSIA.OATH.BATTLE.PREP.PROCEED.y)
oath_battle_party_select_rp_select_tap_rp = function(rp)
  local name = "oath_battle_party_select_rp_select_tap_rp_" .. rp
  return generate_act_function(name,
                               HORTENSIA.OATH.BATTLE.PARTY_SELECT.RP_SELECT[rp].x,
                               HORTENSIA.OATH.BATTLE.PARTY_SELECT.RP_SELECT[rp].y)
end
oath_battle_complete_tap_boss = generate_act_function("oath_battle_complete_tap_boss",
                                                      HORTENSIA.OATH.BATTLE.COMPLETE.BOSS.x,
                                                      HORTENSIA.OATH.BATTLE.COMPLETE.BOSS.y)
oath_battle_complete_tap_oath_home = generate_act_function("oath_battle_complete_tap_oath_home",
                                                           HORTENSIA.OATH.BATTLE.COMPLETE.OATH_HOME.x,
                                                           HORTENSIA.OATH.BATTLE.COMPLETE.OATH_HOME.y)
oath_battle_complete_tap_saved_mission = generate_act_function("oath_battle_complete_tap_saved_mission",
                                                               HORTENSIA.OATH.BATTLE.COMPLETE.SAVED_MISSION.x,
                                                               HORTENSIA.OATH.BATTLE.COMPLETE.SAVED_MISSION.y)
oath_home_tap_missions = generate_act_function("oath_home_tap_missions",
                                               HORTENSIA.OATH.HOME.MISSIONS.x,
                                               HORTENSIA.OATH.HOME.MISSIONS.y)
oath_home_tap_battle = generate_act_function("oath_home_tap_battle",
                                             HORTENSIA.OATH.HOME.BATTLE.x,
                                             HORTENSIA.OATH.HOME.BATTLE.y)
oath_battle_party_select_consume_rp_tap_confirm = generate_act_function("oath_battle_party_select_consume_rp",
                                                                        HORTENSIA.OATH.BATTLE.PARTY_SELECT.INSUFFICIENT_RP.CONSUME.CONFIRM.x,
                                                                        HORTENSIA.OATH.BATTLE.PARTY_SELECT.INSUFFICIENT_RP.CONSUME.CONFIRM.y)
oath_battle_party_select_rp_consumed_tap_proceed = generate_act_function("oath_battle_party_select_rp_consumed_tap_proceed",
                                                                         HORTENSIA.OATH.BATTLE.PARTY_SELECT.INSUFFICIENT_RP.CONSUME.CONFIRM.x,
                                                                         HORTENSIA.OATH.BATTLE.PARTY_SELECT.INSUFFICIENT_RP.CONSUME.CONFIRM.y)
oath_battle_party_select_rp_purchase_tap_close = generate_act_function("oath_battle_party_select_consume_rp",
                                                                       HORTENSIA.OATH.BATTLE.PARTY_SELECT.INSUFFICIENT_RP.PURCHASE.CLOSE.x,
                                                                       HORTENSIA.OATH.BATTLE.PARTY_SELECT.INSUFFICIENT_RP.PURCHASE.CLOSE.y)

sixhr_home_tap_sp_mission = generate_act_function("sixhr_home_tap_sp_mission",
                                                  HORTENSIA.SIXHR.HOME.SP_MISSION.x,
                                                  HORTENSIA.SIXHR.HOME.SP_MISSION.y)
sixhr_raid_complete_tap_home = generate_act_function("sixhr_raid_complete_tap_home",
                                                     HORTENSIA.SIXHR.RAID.COMPLETE.HOME.x,
                                                     HORTENSIA.SIXHR.RAID.COMPLETE.HOME.y)

recollection_home_tap_proceed = generate_act_function("recollection_home_tap_proceed",
                                                      HORTENSIA.RECOLLECTION.HOME.PROCEED.x,
                                                      HORTENSIA.RECOLLECTION.HOME.PROCEED.y)
recollection_paths_ap_insufficient_tap_confirm = generate_act_function("recollection_paths_ap_insufficient_tap_confirm",
                                                                       HORTENSIA.RECOLLECTION.PATHS.AP_INSUFFICIENT.CONFIRM.x,
                                                                       HORTENSIA.RECOLLECTION.PATHS.AP_INSUFFICIENT.CONFIRM.y)
recollection_paths_tap_lamp = generate_act_function("recollection_paths_tap_lamp",
                                                    HORTENSIA.RECOLLECTION.PATHS.LAMP.x,
                                                    HORTENSIA.RECOLLECTION.PATHS.LAMP.y)
recollection_paths_lamp_tap_confirm = generate_act_function("recollection_paths_lamp_tap_confirm",
                                                            HORTENSIA.RECOLLECTION.PATHS.LAMP.CONFIRM.x,
                                                            HORTENSIA.RECOLLECTION.PATHS.LAMP.CONFIRM.y)
recollection_paths_tap_path = function(total)
  return function(n)
    local name = string.format("recollection_paths_tap_path_%d_%d", total, n)
    return generate_act_function(name,
                                 HORTENSIA.RECOLLECTION.PATHS[total][n].x,
                                 HORTENSIA.RECOLLECTION.PATHS[total][n].y)
  end
end
recollection_treasure_chance_complete_tap_confirm =
  generate_act_function("recollection_treasure_chance_complete_tap_confirm",
                        HORTENSIA.RECOLLECTION.TREASURE_CHANCE.COMPLETE.CONFIRM.x,
                        HORTENSIA.RECOLLECTION.TREASURE_CHANCE.COMPLETE.CONFIRM.y)
recollection_boss_defeated_tap_items_confirm = generate_act_function("recollection_boss_defeated_tap_items_confirm",
                                                                     HORTENSIA.RECOLLECTION.BOSS.DEFEATED.ITEMS_CONFIRM.x,
                                                                     HORTENSIA.RECOLLECTION.BOSS.DEFEATED.ITEMS_CONFIRM.y)
recollection_boss_defeated_tap_proceed = generate_act_function("recollection_boss_defeated_tap_proceed",
                                                               HORTENSIA.RECOLLECTION.BOSS.DEFEATED.PROCEED.x,
                                                               HORTENSIA.RECOLLECTION.BOSS.DEFEATED.PROCEED.y)

recollection_treasure_chance_tap_ticket = function(n)
  local name = "recollection_treasure_chance_tap_ticket_" .. n
  return generate_act_function(name,
                               HORTENSIA.RECOLLECTION.TREASURE_CHANCE.TICKET.OPTIONS[n].x,
                               HORTENSIA.RECOLLECTION.TREASURE_CHANCE.TICKET.OPTIONS[n].y)
end
recollection_treasure_chance_ticket_tap_confirm =
  generate_act_function("recollection_treasure_chance_ticket_tap_confirm",
                        HORTENSIA.RECOLLECTION.TREASURE_CHANCE.TICKET.CONFIRM.x,
                        HORTENSIA.RECOLLECTION.TREASURE_CHANCE.TICKET.CONFIRM.y)


friends_list_tap_greet = function(n)
  local name = "friends_list_tap_greet_" .. n
  return generate_act_function(name,
                               HORTENSIA.FRIENDS_LIST[n].GREET.x,
                               HORTENSIA.FRIENDS_LIST[n].GREET.y)
end

greeting_dialog_not_greeted_tap_stickers = generate_act_function("greeting_dialog_not_greeted_tap_stickers",
                                                                 HORTENSIA.GREETING.DIALOG.NOT_GREETED.STICKERS.x,
                                                                 HORTENSIA.GREETING.DIALOG.NOT_GREETED.STICKERS.y)
greeting_dialog_greeted_tap_close = generate_act_function("greeting_dialog_greeted_tap_close",
                                                          HORTENSIA.GREETING.DIALOG.GREETED.CLOSE.x,
                                                          HORTENSIA.GREETING.DIALOG.GREETED.CLOSE.y)

stickers_tap_sticker = function(n)
  local name = "stickers_tap_sticker_" .. n
  return generate_act_function(name,
                               HORTENSIA.GREETING.DIALOG.STICKER_SEL[n].x,
                               HORTENSIA.GREETING.DIALOG.STICKER_SEL[n].y)
end
stickers_list_tap_coll = function(n)
  local name = "stickers_list_tap_coll_" .. n
  return generate_act_function(name,
                               HORTENSIA.GREETING.DIALOG.STICKER_SEL.LIST[n].x,
                               HORTENSIA.GREETING.DIALOG.STICKER_SEL.LIST[n].y)
end

united_battle_home_tap_sp_mission = generate_act_function("united_battle_home_tap_sp_mission",
                                                          HORTENSIA.UNITED_BATTLE.HOME.SP_MISSION.x,
                                                          HORTENSIA.UNITED_BATTLE.HOME.SP_MISSION.y)
lessons_home_tap_mission = function(n)
  local name = "lessons_home_tap_mission" .. tostring(n)
  return generate_act_function(name,
                               HORTENSIA.LESSONS.MISSIONS[n].x,
                               HORTENSIA.LESSONS.MISSIONS[n].y)
end
lessons_mission_tap_confirm = generate_act_function("lessons_mission_tap_confirm",
                                                    HORTENSIA.LESSONS.MISSIONS.CONFIRM.x,
                                                    HORTENSIA.LESSONS.MISSIONS.CONFIRM.y)

magonia_home_tap_mission = function(n)
  local name = "magonia_home_tap_mission_" .. n
  return generate_act_function(name,
                               HORTENSIA.MAGONIA.HOME.MISSIONS[n].x,
                               HORTENSIA.MAGONIA.HOME.MISSIONS[n].y)
end
magonia_home_tap_pots = generate_act_function("magonia_home_tap_pots",
                                              HORTENSIA.MAGONIA.HOME.POTS.x,
                                              HORTENSIA.MAGONIA.HOME.POTS.y)
magonia_home_tap_bp_recover = generate_act_function("magonia_home_tap_bp_recover",
                                                    HORTENSIA.MAGONIA.HOME.BP_RECOVER.x,
                                                    HORTENSIA.MAGONIA.HOME.BP_RECOVER.y)
magonia_home_bp_recover_tap_option = function(n)
  local name = "magonia_home_bp_recover_tap_option_" .. n
  return generate_act_function(name,
                               HORTENSIA.MAGONIA.HOME.BP_RECOVER.OPTIONS[n].x,
                               HORTENSIA.MAGONIA.HOME.BP_RECOVER.OPTIONS[n].y)
end
magonia_home_bp_recover_tap_confirm =
  generate_act_function("magonia_home_bp_recover_tap_confirm",
                        HORTENSIA.MAGONIA.HOME.BP_RECOVER.CONFIRM.x,
                        HORTENSIA.MAGONIA.HOME.BP_RECOVER.CONFIRM.y)
magonia_home_tap_aid_requests = generate_act_function("magonia_home_tap_aid_requests",
                                                      HORTENSIA.MAGONIA.HOME.AID_REQUESTS.x,
                                                      HORTENSIA.MAGONIA.HOME.AID_REQUESTS.y)

magonia_pots_first_tap_break = generate_act_function("magonia_pots_first_tap_break",
                                                     HORTENSIA.MAGONIA.POTS.FIRST.BREAK.x,
                                                     HORTENSIA.MAGONIA.POTS.FIRST.BREAK.y)
magonia_pots_first_break_tap_normal = generate_act_function("magonia_pots_first_break_tap_normal",
                                                            HORTENSIA.MAGONIA.POTS.FIRST.BREAK.CONFIRM.NORMAL.x,
                                                            HORTENSIA.MAGONIA.POTS.FIRST.BREAK.CONFIRM.NORMAL.y)

magonia_aid_requests_tap_home =
  generate_act_function("magonia_aid_requests_tap_home",
                        HORTENSIA.MAGONIA.AID_REQUESTS.HOME.x,
                        HORTENSIA.MAGONIA.AID_REQUESTS.HOME.y)
magonia_aid_requests_battle_finished_tap_confirm =
  generate_act_function("magonia_aid_requests_battle_finished_tap_confirm",
                        HORTENSIA.MAGONIA.AID_REQUESTS.BATTLE_FINISHED.CONFIRM.x,
                        HORTENSIA.MAGONIA.AID_REQUESTS.BATTLE_FINISHED.CONFIRM.y)
magonia_aid_requests_tap_request = function(n)
  local name = "magonia_aid_requests_tap_request_" .. tostring(n)
  return generate_act_function(name,
                               HORTENSIA.MAGONIA.AID_REQUESTS.REQUEST[n].x,
                               HORTENSIA.MAGONIA.AID_REQUESTS.REQUEST[n].y)
end

magonia_boss_appeared_tap_skip = generate_act_function("magonia_boss_appeared_tap_skip",
                                                       HORTENSIA.MAGONIA.BOSS.APPEARED.SKIP.x,
                                                       HORTENSIA.MAGONIA.BOSS.APPEARED.SKIP.y)
magonia_boss_unit_select_tap_unit = function(n)
  local name = "magonia_boss_unit_select_tap_unit_" .. tostring(n)
  return generate_act_function(name,
                               HORTENSIA.MAGONIA.BOSS.UNIT_SELECT.UNITS[n].x,
                               HORTENSIA.MAGONIA.BOSS.UNIT_SELECT.UNITS[n].y)
end
magonia_boss_unit_select_tap_attack = generate_act_function("magonia_boss_unit_select_tap_attack",
                                                            HORTENSIA.MAGONIA.BOSS.UNIT_SELECT.ATTACK.x,
                                                            HORTENSIA.MAGONIA.BOSS.UNIT_SELECT.ATTACK.y)
magonia_boss_in_battle_tap_skip = generate_act_function("magonia_boss_in_battle_tap_skip",
                                                        HORTENSIA.MAGONIA.BOSS.IN_BATTLE.SKIP.x,
                                                        HORTENSIA.MAGONIA.BOSS.IN_BATTLE.SKIP.y)
magonia_boss_unit_select_tap_aid_request =
  generate_act_function("magonia_boss_unit_select_tap_aid_request",
                        HORTENSIA.MAGONIA.BOSS.UNIT_SELECT.AID_REQUEST.x,
                        HORTENSIA.MAGONIA.BOSS.UNIT_SELECT.AID_REQUEST.y)
magonia_boss_unit_select_aid_request_tap_all =
  generate_act_function("magonia_boss_unit_select_aid_request_tap_all",
                        HORTENSIA.MAGONIA.BOSS.UNIT_SELECT.AID_REQUEST.ALL.x,
                        HORTENSIA.MAGONIA.BOSS.UNIT_SELECT.AID_REQUEST.ALL.y)
magonia_boss_unit_select_tap_bp_recover =
  generate_act_function("magonia_boss_unit_select_tap_bp_recover",
                        HORTENSIA.MAGONIA.BOSS.UNIT_SELECT.BP_RECOVER.x,
                        HORTENSIA.MAGONIA.BOSS.UNIT_SELECT.BP_RECOVER.y)
magonia_boss_unit_select_bp_recover_tap_two_mins =
  generate_act_function("magonia_boss_unit_select_bp_recover_tap_two_mins",
                        HORTENSIA.MAGONIA.BOSS.UNIT_SELECT.BP_RECOVER.TWO_MINS.x,
                        HORTENSIA.MAGONIA.BOSS.UNIT_SELECT.BP_RECOVER.TWO_MINS.y)
magonia_boss_unit_select_bp_recover_tap_complete =
  generate_act_function("magonia_boss_unit_select_bp_recover_tap_complete",
                        HORTENSIA.MAGONIA.BOSS.UNIT_SELECT.BP_RECOVER.COMPLETE.x,
                        HORTENSIA.MAGONIA.BOSS.UNIT_SELECT.BP_RECOVER.COMPLETE.y)
magonia_boss_unit_select_tap_refresh =
  generate_act_function("magonia_boss_unit_select_tap_refresh",
                        HORTENSIA.MAGONIA.BOSS.UNIT_SELECT.REFRESH.x,
                        HORTENSIA.MAGONIA.BOSS.UNIT_SELECT.REFRESH.y)
magonia_boss_unit_select_insufficient_bp_tap_confirm =
  generate_act_function("magonia_boss_unit_select_insufficient_bp_tap_confirm",
                        HORTENSIA.MAGONIA.BOSS.UNIT_SELECT.INSUFFICIENT_BP.CONFIRM.x,
                        HORTENSIA.MAGONIA.BOSS.UNIT_SELECT.INSUFFICIENT_BP.CONFIRM.y)
magonia_boss_unit_select_bp_recover_tap_confirm =
  generate_act_function("magonia_boss_unit_select_bp_recover_tap_confirm",
                        HORTENSIA.MAGONIA.BOSS.UNIT_SELECT.BP_RECOVER.CONFIRM.x,
                        HORTENSIA.MAGONIA.BOSS.UNIT_SELECT.BP_RECOVER.CONFIRM.y)
magonia_boss_unit_select_bp_recover_tap_option = function(n)
  local name = "magonia_boss_unit_select_bp_recover_tap_option_" .. n
  return generate_act_function(name,
                               HORTENSIA.MAGONIA.BOSS.UNIT_SELECT.BP_RECOVER.OPTIONS[n].x,
                               HORTENSIA.MAGONIA.BOSS.UNIT_SELECT.BP_RECOVER.OPTIONS[n].y)
end
magonia_boss_unit_select_bp_recover_confirm_tap_bp50_amount = function(n)
  local name = "magonia_boss_unit_select_bp_recover_confirm_tap_bp50_amount_" .. n
  return generate_act_function(name,
                               HORTENSIA.MAGONIA.BOSS.UNIT_SELECT.BP_RECOVER.CONFIRM.BP50_AMOUNT[n].x,
                               HORTENSIA.MAGONIA.BOSS.UNIT_SELECT.BP_RECOVER.CONFIRM.BP50_AMOUNT[n].y)
end

magonia_boss_already_defeated_tap_confirm =
  generate_act_function("magonia_boss_already_defeated_tap_confirm",
                        HORTENSIA.MAGONIA.BOSS.ALREADY_DEFEATED.CONFIRM.x,
                        HORTENSIA.MAGONIA.BOSS.ALREADY_DEFEATED.CONFIRM.y)
magonia_boss_already_defeated_bp_not_consumed_tap_confirm =
  generate_act_function("magonia_boss_already_defeated_bp_not_consumed_tap_confirm",
                        HORTENSIA.MAGONIA.BOSS.ALREADY_DEFEATED.BP_NOT_CONSUMED.CONFIRM.x,
                        HORTENSIA.MAGONIA.BOSS.ALREADY_DEFEATED.BP_NOT_CONSUMED.CONFIRM.y)

magonia_boss_battle_complete_tap_rewards_confirm =
  generate_act_function("magonia_boss_battle_complete_tap_rewards_confirm",
                        HORTENSIA.MAGONIA.BOSS.BATTLE_COMPLETE.REWARDS_CONFIRM.x,
                        HORTENSIA.MAGONIA.BOSS.BATTLE_COMPLETE.REWARDS_CONFIRM.y)
magonia_boss_battle_complete_tap_magonia_home =
  generate_act_function("magonia_boss_battle_complete_tap_magonia_home",
                        HORTENSIA.MAGONIA.BOSS.BATTLE_COMPLETE.MAGONIA_HOME.x,
                        HORTENSIA.MAGONIA.BOSS.BATTLE_COMPLETE.MAGONIA_HOME.y)


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

    if not FINAL_WAVE_SKILL or is_final_wave() then
      LIST.fmap(activate_skill, HORTENSIA.BATTLE_MEMBERS_LIST)
    end
    sleep_sec(fif(interval, thunk_interval, thunk_default_interval))

    return f(succ_k, fail_k)
  end

  return f
end

function activate_skill(member)
  local cx,cy = HORTENSIA.IN_BATTLE.MEMBERS[member].SKILLBAR.TOP.x, HORTENSIA.IN_BATTLE.MEMBERS[member].SKILLBAR.TOP.y

  if not skill_bar_full(cx, cy) then
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

function skill_bar_full(x, y)
  return match_any_colors(LIST.fmap(function(c)
    return {
      x = x,
      y = y,
      color = c
    }
  end, HORTENSIA.IN_BATTLE.COLORS.SKILLBAR.FULL))
end

function mission_complete(battle_complete)
  local f = fif(battle_complete, thunk(battle_complete), thunk(mission_complete_battle_complete))
  if mission_complete_reaffirm(f, "battle_complete") then
    return true

  elseif mission_complete_reaffirm(mission_complete_ep_up_story_unlock, "ep_up_story_unlock") then
    return true

  elseif mission_complete_reaffirm(mission_complete_ep_up_awakening_unlock, "ep_up_awakening_unlock") then
    return true

  else
    return false
  end
end

function mission_complete_battle_complete()
  return match_all_colors(HORTENSIA.BATTLE.COMPLETE.COLORS)
end

function mission_complete_battle_complete_friend_request()
  return match_all_colors(HORTENSIA.BATTLE.COMPLETE.FRIEND_REQUEST.COLORS)
end

function mission_complete_reaffirm(pred, name)
  if pred() then
    sleep_sec(DEFAULT_MISSION_COMPLETE_REAFFIRM_DELAY_SEC)

    local res = pred()
    if LOG_ENABLED then
      log(string.format("Detected mission complete with [%s], checking again with result [%s]", name, tostring(res)))
    end
    return res
  end
end

function mission_complete_rank_up()
  return match_all_colors(HORTENSIA.BATTLE.COMPLETE.RANK_UP.COLORS)
end

function mission_complete_ep_up_story_unlock()
  return match_all_colors(HORTENSIA.BATTLE.COMPLETE.EP_UP.STORY_UNLOCK.COLORS)
end

function mission_complete_ep_up_awakening_unlock()
  return match_all_colors(HORTENSIA.BATTLE.COMPLETE.EP_UP.AWAKENING_UNLOCK.COLORS)
end

function mission_complete_proceed_to_rewards_confirm(pause, hold)
  if LOG_ENABLED then
    log("entering mission_complete_proceed_to_rewards_confirm")
  end

  while mission_complete_ep_up_story_unlock() or mission_complete_ep_up_awakening_unlock() do
    if mission_complete_ep_up_story_unlock() then
      if LOG_ENABLED then
        log("proceed_to_rewards_confirm, ep_up_story_unlock_tap_confirm")
      end
      retry(mission_complete_ep_up_story_unlock_tap_confirm)(pause, hold)

    elseif mission_complete_ep_up_awakening_unlock() then
      if LOG_ENABLED then
        log("proceed_to_rewards_confirm, ep_up_awakening_unlock_tap_confirm")
      end
      retry(mission_complete_ep_up_awakening_unlock_tap_confirm)(pause, hold)

    end
  end

  if mission_complete_battle_complete() then
    if LOG_ENABLED then
      log("proceed_to_rewards_confirm, EP_tap_confirm")
    end
    act_once(mission_complete_EP_tap_confirm, mission_complete_EP_confirmed)(pause, hold)

  elseif mission_complete_special_complete() then
    if LOG_ENABLED then
      log("proceed_to_rewards_confirm, special_tap_confirm")
    end
    act_once(mission_complete_special_tap_confirm)(pause, hold)
  end
end

--[[
 Currently does not work due to battle complete screen not available
--]]
function mission_complete_rewards_confirm(pause, hold)
  if LOG_ENABLED then
    log("entering mission_complete_rewards_confirm")
  end

  -- Friend request occurs before rank up
  if mission_complete_battle_complete_friend_request() then
    if LOG_ENABLED then
      log("rewards_confirm, got friend request prompt, tap_discard")
    end
    retry(mission_complete_friend_request_tap_discard)(pause, hold)
  end

  if mission_complete_rank_up() then
    if LOG_ENABLED then
      log("rewards_confirm, rank_up_tap_confirm")
    end
    retry(mission_complete_rank_up_tap_confirm)(pause, hold)
  end

  if mission_complete_battle_complete() then
    if LOG_ENABLED then
      log("rewards_confirm, EP_tap_confirm")
    end
    act_once(mission_complete_EP_tap_confirm, mission_complete_EP_confirmed)(pause, hold)

  elseif mission_complete_special_complete() then
    if LOG_ENABLED then
      log("rewards_confirm, special_tap_confirm")
    end
    act_once(mission_complete_special_tap_confirm)(pause, hold)

  end
end

function mission_failed()
  return match_all_colors(HORTENSIA.BATTLE.FAILED.COLORS)
end

function mission_complete_EP_confirmed()
  local c,x,y = HORTENSIA.BATTLE.COMPLETE.SAVED_MISSION.COLOR.AVAILBLE,
                HORTENSIA.BATTLE.COMPLETE.SAVED_MISSION.x,
                HORTENSIA.BATTLE.COMPLETE.SAVED_MISSION.y

  if LOG_ENABLED then
    log(string.format("mission_complete_EP_confirmed, trying to match c[%d] at x[%f], y[%f]", c, x, y))
  end

  return match_color(c, x, y)
end

function is_final_wave()
  return LIST.foldl(function(e, cs)
    return e or match_all_colors(cs)
  end, false, HORTENSIA.IN_BATTLE.WAVE.FINAL.COLORS)
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
      if LOG_ENABLED then
        log("RP sufficient, proceeding to battle")
      end
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
function battle_helper_select()
  return match_all_colors(HORTENSIA.BATTLE.HELPER_SELECT.COLORS)
end

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

    -- TODO: Recollection remains on Recollection home screen if ap option
    --       is consumed but still insufficient ap
    if not battle_helper_select() then
      -- Did not proceed to battle helper select, indicates ap consumed but
      -- ap still insufficient
      if LOG_ENABLED then
        log("ap consumed but did not proceed to battle helper select")
      end
      if ap_consumed_still_insufficient() then
        if LOG_ENABLED then
          log("ap consumed but still insufficient!")
        end
        retry(insufficient_ap_tap_consumed_still_insufficient_confirm)()
      end

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

-- TODO: Refactor to use findImage instead
function wait_network_loading()
  if WAIT_LOADING then
    while match_all_colors(HORTENSIA.LOADING.RUNNING.COLORS) do
      if LOG_ENABLED then
        log("waiting for network loading")
      end
      sleep_sec(0.5)
    end
  end
end


------------------------------
-- Missions - Battle Select --
------------------------------

function missions_battle_select_scroll_down_once()
  local bcs = missions_battle_select_get_border_color()

  if LOG_ENABLED then
    log("missions_battle_select_scroll_down_once, trying to match colors")
    LIST.fmap(function(loc)
      log(string.format("color[%d], x[%f], y[%f]", loc.color, loc.x, loc.y))
    end, bcs)
  end

  -- TODO: APPROX REGION COLOR MATCH is not supported with sliding
  return run_with_approx_colors(false, function(k)
    slide("UP",
          function() return match_all_colors(bcs) end,
          HORTENSIA.MISSIONS.THREE_BATTLES.THIRD.x,
          HORTENSIA.MISSIONS.THREE_BATTLES.THIRD.y)

    return k()
  end)
end

function missions_battle_select_get_border_color()
  return LIST.fmap(function(loc)
    return {x = loc.x, y = loc.y, color = cgetColor(loc.x, loc.y)}
  end, HORTENSIA.MISSIONS.BATTLE_SELECT.THIRD_BATTLE.BORDER)
end


--------------
-- 6HR Raid --
--------------

function encountered_sixhr_raid()
  return match_all_colors(HORTENSIA.SIXHR.RAID.ENCOUNTERED.COLORS)
end

function sixhr_raid_complete()
  for i = 1,10,1 do
    act_once(oath_battle_complete_tap_boss)(0.5, 0.5)
  end

  local function f()
    return match_all_colors(HORTENSIA.SIXHR.RAID.COMPLETE.COLORS)
  end

  if f() then
    sleep_sec(2)
    return f()
  end

  return false
end


--------------
-- Greeting --
--------------

function greeting_dialog_sticker_list_scroll_right_once()
  local bcs = greeting_dialog_sticker_sel_get_border_color()

  if LOG_ENABLED then
    log("greeting_dialog_sticker_list_scroll_right_once, trying to match colors")
    LIST.fmap(function(loc)
      log(string.format("color[%d], x[%f], y[%f]", loc.color, loc.x, loc.y))
    end, bcs)
  end

  -- TODO: APPROX REGION COLOR MATCH is not supported with sliding
  return run_with_approx_colors(false, function(k)
    slide("LEFT",
          function() return match_all_colors(bcs) end,
          HORTENSIA.GREETING.DIALOG.STICKER_SEL.LIST.FIVE.x,
          HORTENSIA.GREETING.DIALOG.STICKER_SEL.LIST.FIVE.y)

    return k()
  end)
end

function friends_list_scroll_down_once()
  local bcs = first_friend_rank_get_border_color()

  if LOG_ENABLED then
    log("friends_list_scroll_down_once, trying to match colors")
    LIST.fmap(function(loc)
      log(string.format("color[%d], x[%f], y[%f]", loc.color, loc.x, loc.y))
    end, bcs)
  end

  -- TODO: APPROX REGION COLOR MATCH is not supported with sliding
  return run_with_approx_colors(false, function(k)
    slide("UP",
          function() return match_all_colors(bcs) end,
          HORTENSIA.FRIENDS_LIST.THIRD.CENTER.x,
          HORTENSIA.FRIENDS_LIST.THIRD.CENTER.y)

    return k()
  end)
end

function greeting_dialog_sticker_sel_get_border_color()
  return LIST.fmap(function(loc)
    return {x = loc.x, y = loc.y, color = cgetColor(loc.x, loc.y)}
  end, HORTENSIA.GREETING.DIALOG.STICKER_SEL.LIST.TWO.BORDER)
end

function first_friend_rank_get_border_color()
  return LIST.fmap(function(loc)
    return {x = loc.x, y = loc.y, color = cgetColor(loc.x, loc.y)}
  end, HORTENSIA.FRIENDS_LIST.FIRST.RANK_BORDER)
end

function not_greeted_dialog()
  return match_all_colors(HORTENSIA.GREETING.DIALOG.NOT_GREETED.COLORS)
end

function greeted_dialog()
  return match_all_colors(HORTENSIA.GREETING.DIALOG.GREETED.COLORS)
end

---------------------
-- Magonia Related --
---------------------

function is_pot_available()
  local loc = HORTENSIA.MAGONIA.POTS.FIRST.BREAK
  return match_color(loc.COLOR.AVAILABLE, loc.x, loc.y)
end

function magonia_boss_unit_select()
  return match_all_colors(HORTENSIA.MAGONIA.BOSS.UNIT_SELECT.COLORS)
end

function magonia_boss_battle_complete()
  return match_all_colors(HORTENSIA.MAGONIA.BOSS.BATTLE_COMPLETE.COLORS)
end

function magonia_conduct_boss_battle(exec_battle, request_aid)
  return function(k)
    exec_battle()

    if magonia_boss_battle_complete() then
      return k()
    end

    fif(request_aid, thunk(request_aid), thunk(FUNCTIONS.id))()
    magonia_recover_and_refresh()

    while not magonia_boss_battle_complete() do
      if LOG_ENABLED then
        log("magonia_conduct_boss_battle, boss_battle_not_complete")
      end

      exec_battle()
      magonia_recover_and_refresh()
    end
    return k()
  end
end

function magonia_boss_battle_complete_confirm_rewards()
  act_once(magonia_boss_battle_complete_tap_rewards_confirm)(4)
  act_once(magonia_boss_battle_complete_tap_rewards_confirm)(2)

  retry(magonia_boss_battle_complete_tap_magonia_home)()
end

function magonia_execute_boss_battle()
  if LOG_ENABLED then
    log("magonia_execute_boss_battle called")
  end

  while not (magonia_boss_unit_select()
    or magonia_boss_battle_complete()
    or magonia_boss_already_defeated()) do
    if LOG_ENABLED then
      log("magonia_execute_boss_battle, in battle tapping skip")
    end
    retry(magonia_boss_in_battle_tap_skip)()
  end

  if magonia_boss_already_defeated() then
    retry(magonia_boss_already_defeated_tap_confirm)(1)
  end
end

function magonia_recover_and_refresh()
  if magonia_boss_battle_complete() then
    if LOG_ENABLED then
      log("magonia_recover_and_refresh, boss_battle_complete before attempting to recover")
    end
    return
  end
  retry(magonia_boss_unit_select_tap_bp_recover)(MAGONIA_REC_TAP_PAUSE_SEC,
                                                 MAGONIA_REC_TAP_DUR_SEC)

  if magonia_boss_battle_complete() then
    if LOG_ENABLED then
      log("magonia_recover_and_refresh, boss_battle_complete after tapping recover")
    end
    return
  end
  retry(magonia_boss_unit_select_bp_recover_tap_two_mins)()

  local function f()
    if magonia_recover_complete() then
      if LOG_ENABLED then
        log("magonia_recover_and_refresh, finished recovery, tapping recover complete")
      end
      return retry(magonia_boss_unit_select_bp_recover_tap_complete)()
    end

    if magonia_boss_battle_complete() then
      if LOG_ENABLED then
        log("magonia_recover_and_refresh, boss_battle_complete while recovering")
      end
      return
    end

    if LOG_ENABLED then
      log("magonia_recover_and_refresh, not boss_battle_complete tapping refresh")
    end
    act_once(magonia_boss_unit_select_tap_refresh)()

    return f()
  end

  return f()
end

function magonia_recover_complete()
  local loc = HORTENSIA.MAGONIA.BOSS.UNIT_SELECT.BP_RECOVER
  return match_color(loc.COLORS.RECOVER_COMPLETE, loc.x, loc.y)
end

function magonia_home_bp_full()
  return not color_available(HORTENSIA.MAGONIA.HOME.BP_RECOVER)
end

function magonia_home_consume_bp(allowed_options)
  return LIST.foldl(function(consumed, option)
    if consumed then
      return true
    end

    if not color_available(option) then
      return false
    end

    if LOG_ENABLED then
      log(string.format("magonia_home_consume_bp for option[%s]", option.name))
    end

    retry(magonia_home_bp_recover_tap_option(option.name))(1)
    retry(magonia_home_bp_recover_tap_confirm)()
    return true

  end, false, LIST.fmap(function(o)
    return HORTENSIA.MAGONIA.HOME.BP_RECOVER.OPTIONS[o]
  end, allowed_options))
end

function magonia_boss_unit_select_consume_bp(allowed_options)
  return LIST.foldl(function(consumed, option)
    if consumed then
      return true
    end

    if not color_available(option) then
      return false
    end

    if LOG_ENABLED then
      log(string.format("magonia_boss_unit_select_consume_bp for option[%s]", option.name))
    end

    retry(magonia_boss_unit_select_bp_recover_tap_option(option.name))(1)
    if option.amount ~= nil then
      log(string.format("bp confirm amount not nil [%d]", option.amount))
      for i = 1,option.amount - 1,1 do
        log(string.format("tapping consume bp50 amount increase, i=[%d]", i))
        act_once(magonia_boss_unit_select_bp_recover_confirm_tap_bp50_amount("INCREASE"))(0, 0.1)
      end
    end

    retry(magonia_boss_unit_select_bp_recover_tap_confirm)(MAGONIA_REC_CONFIRM_TAP_PAUSE_SEC)
    return true

  end, false, LIST.fmap(function(o)
    return HORTENSIA.MAGONIA.BOSS.UNIT_SELECT.BP_RECOVER.OPTIONS[o]
  end, allowed_options))
end

function magonia_aid_requests_available()
  return color_available(HORTENSIA.MAGONIA.AID_REQUESTS.REQUEST[1])
end

function magonia_aid_requests_battle_finished()
  return match_all_colors(HORTENSIA.MAGONIA.AID_REQUESTS.BATTLE_FINISHED.COLORS)
end

function magonia_boss_already_defeated()
  return match_all_colors(HORTENSIA.MAGONIA.BOSS.ALREADY_DEFEATED.COLORS)
end

function magonia_boss_unit_select_with_insufficient_bp_check(bp_options, sk, ek)
  local function f(k)
    if LOG_ENABLED then
      log(string.format("magonia_boss_unit_select_with_insufficient_bp_check, checking bp insufficient with options[%s]", tostring(bp_options)))
    end

    if magonia_boss_unit_select_insufficient_bp() then
      retry(magonia_boss_unit_select_insufficient_bp_tap_confirm)(NO_LOADING_TAP_PAUSE_SEC,
                                                                  MAGONIA_REC_TAP_DUR_SEC)
      retry(magonia_boss_unit_select_tap_bp_recover)(MAGONIA_REC_TAP_PAUSE_SEC,
                                                     MAGONIA_REC_TAP_DUR_SEC)

      local bp_consumed = magonia_boss_unit_select_consume_bp(bp_options)
      if magonia_boss_already_defeated_bp_not_consumed() then
        retry(magonia_boss_already_defeated_bp_not_consumed_tap_confirm)()
        return ek()
      end

      if LOG_ENABLED then
        log("bp insufficient, bp_consumed: " .. tostring(bp_consumed))
      end

      if not bp_consumed then
        return alert("insufficient bp!")
      end

      return sk()
    end

    return k()
  end

  return f
end

function magonia_boss_unit_select_insufficient_bp()
  return match_all_colors(HORTENSIA.MAGONIA.BOSS.UNIT_SELECT.INSUFFICIENT_BP.COLORS)
end

function magonia_boss_already_defeated_bp_not_consumed()
  return match_all_colors(HORTENSIA.MAGONIA.BOSS.ALREADY_DEFEATED.BP_NOT_CONSUMED.COLORS)
end

function mission_complete_special_complete()
  return match_all_colors(HORTENSIA.BATTLE.SPECIAL_COMPLETE.COLORS)
end

------------------
-- Recollection --
------------------

function recollection_treasure_chance()
  return match_all_colors(HORTENSIA.RECOLLECTION.MISSION.COMPLETE.TREASURE_CHANCE.COLORS)
end

function recollection_treasure_chance_complete()
  return match_all_colors(HORTENSIA.RECOLLECTION.TREASURE_CHANCE.COMPLETE.COLORS)
end

function recollection_paths_ap_insufficient()
  return match_all_colors(HORTENSIA.RECOLLECTION.PATHS.AP_INSUFFICIENT.COLORS)
end

function recollection_is_next_path(coords)
  if LOG_ENABLED then
    log(string.format("recollection_is_next_path finding image at coords x[%f], y[%f]", coords.x, coords.y))
  end

  local res = findImage(RECOLLECTION_NEXT_IMAGE_PATH, 1, FIND_IMAGE_FUZZY, nil, {
    coords.x,
    coords.y,
    RECOLLECTION_NEXT_IMAGE_WIDTH,
    RECOLLECTION_NEXT_IMAGE_HEIGHT
  })

  local count = 0
  for i, v in pairs(res) do
    if LOG_ENABLED then
      log(string.format("recollection_is_next_path found image at: x:%f, y:%f", v[1], v[2]));
    end
    count = count + 1
  end
  if LOG_ENABLED then
    log(string.format("recollection_is_next_path count of findImage result is [%d]", count))
  end
  return count > 0
end

function recollection_paths_lamp_available()
  return color_available(HORTENSIA.RECOLLECTION.PATHS.LAMP)
end

function recollection_boss_encountered()
  return match_all_colors(HORTENSIA.RECOLLECTION.BOSS.ENCOUNTERED.COLORS)
end

function recollection_boss_defeated()
  return match_all_colors(HORTENSIA.RECOLLECTION.BOSS.DEFEATED.COLORS)
end

function recollection_execute_boss_battle()
  if LOG_ENABLED then
    log("recollection_execute_boss_battle called")
  end

  while not recollection_boss_defeated() do
    if LOG_ENABLED then
      log("recollection_execute_boss_battle, in battle tapping skip")
    end
    act_once(magonia_boss_in_battle_tap_skip)()
  end

  return
end

function recollection_path_taken(path)
  if LOG_ENABLED then
    log(string.format("recollection_path_taken, trying to match color[%d] at x[%f], y[%f]",
                      HORTENSIA.RECOLLECTION.PATHS.TAKEN.COLOR, path.x, path.y))
  end

  return match_color(HORTENSIA.RECOLLECTION.PATHS.TAKEN.COLOR, path.x, path.y)
end

function recollection_treasure_chance_use_ticket(allowed_options)
  return LIST.foldl(function(consumed, option)
    if consumed then
      return true
    end

    if not color_available(option) then
      return false
    end

    if LOG_ENABLED then
      log(string.format("recollection_treasure_chance_use_ticket for option[%s]", option.name))
    end

    retry(recollection_treasure_chance_tap_ticket(option.name))()
    retry(recollection_treasure_chance_ticket_tap_confirm)()
    return true

  end, false, LIST.fmap(function(o)
    return HORTENSIA.RECOLLECTION.TREASURE_CHANCE.TICKET.OPTIONS[o]
  end, allowed_options))
end

function recollection_treasure_chance_failed()
  return match_all_colors(HORTENSIA.RECOLLECTION.TREASURE_CHANCE.FAILED.COLORS)
end

function recollection_treasure_chance_battle(ticket_options)
  return function(succ_k, fail_k)
    if LOG_ENABLED then
      log("attempting recollection_treasure_chance_battle")
    end

    retry(tap_screen_center)()
    local ticket_used = recollection_treasure_chance_use_ticket(ticket_options)
    if not ticket_used then
      return alert("no ticket used for treasure_chance")
    end

    sleep_sec(10) -- For stability, use ticket animation may take some time
    if recollection_treasure_chance_failed() then
      if LOG_ENABLED then
        log("treasure chance failed")
      end
      retry(tap_screen_center)()
      return fail_k()
    end

    retry(tap_screen_center)()
    return succ_k()
  end
end

function recollection_paths_use_lamp(k)
  if not recollection_paths_lamp_available() then
    return alert("Encountered lamp path but no lamps available!")
  end

  retry(recollection_paths_tap_lamp)()
  retry(recollection_paths_lamp_tap_confirm)()
end

function recollection_paths_lamp_in_use()
  local loc = HORTENSIA.RECOLLECTION.PATHS.LAMP
  return match_color(loc.COLOR.IN_USE, loc.x, loc.y)
end

function recollection_get_stage(n)
  return HORTENSIA_RECOLLECTION[n]
end

function recollection_get_paths(stage)
  return HORTENSIA.RECOLLECTION.PATHS[stage.total]
end

function recollection_get_next_stage_num(n)
  if n >= 100 then
    return 1
  else
    return n + 1
  end
end

function recollection_get_path_indices(stage)
  local ps = {}
  --[[
  if recollection_paths_lamp_in_use() then
    if LOG_ENABLED then
      log("building paths for stage with lamp in use")
    end
    --]]

    local last = nil
    local paths = recollection_get_paths(stage)
    for i,v in ipairs(paths) do
      if recollection_is_next_path(v.IMAGE) then
        last = i
        if LOG_ENABLED then
          log(string.format("found next path image at i[%d]", i))
        end
      else
        table.insert(ps, i)
      end
    end

    if last == nil then
      if LOG_ENABLED then
        log("Did not find next path image for stage! Built ascending order of indices.")
      end
    else
      table.insert(ps, last)
    end

    --[[
    return ps
  end

  for i = 1, stage.total, 1 do
    table.insert(ps, i)
  end
  --]]
  return ps
end

function recollection_conduct_boss_battle(exec_battle)
  if LOG_ENABLED then
    log("recollection_conduct_boss_battle, tapping screen center")
  end

  retry(tap_screen_center)()
  exec_battle()

  retry(recollection_boss_defeated_tap_items_confirm)()
  retry(recollection_boss_defeated_tap_proceed)(10) -- Long animation after boss defeated
  act_once(tap_screen_center)()

  if LOG_ENABLED then
    log("recollection boss defeated")
  end

  return
end


-----------
-- Poker --
-----------

function poker_use_key()
  return match_all_colors(HORTENSIA.POKER.SECRET_ROOM.USE_KEY.COLORS)
end
