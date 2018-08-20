local WIDTH = 1536
local HEIGHT = 2048
local DEFAULT_SLEEP_SEC = 5
local DEFAULT_TAP_DUR_SEC = 1
local DEFAULT_BATTLE_DAEMON_INTERVAL_SEC = 5
local DEFAULT_SWIPE_LENGTH_RES = 500
local DEFAULT_SWIPE_BEGIN_SEC = 0.5
local DEFAULT_SWIPE_END_SEC = 0.5
local DEFAULT_SWIPE_DUR_SEC = 0.1

function fif(cond, a, b)
  if cond then
    return a()
  else
    return b()
  end
end

function mytap(x, y, dur)
  touchDown(0, x, y)
  sleep_sec(fif(dur, thunk(dur), thunk(DEFAULT_TAP_DUR_SEC)))
  touchUp(0, x, y)
end

function tap_and_pause(x, y, pause, hold)
  mytap(x, y, hold)
  sleep_sec(fif(pause, thunk(pause), thunk(DEFAULT_SLEEP_SEC)))
end

function adjust_coords(x, y)
  return WIDTH-y, x
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
      end)
    end
  end
end

function swipe(cx, cy, cx_end, cy_end)
  local x,y = adjust_coords(cx, cy)
  local x_end,y_end = adjust_coords(cx_end, cy_end)

  touchDown(0, x, y)
  sleep_sec(DEFAULT_SWIPE_BEGIN_SEC)

  touchMove(0, x_end, y_end)
  sleep_sec(DEFAULT_SWIPE_DUR_SEC)

  touchUp(0, x_end, y_end)
  sleep_sec(DEFAULT_SWIPE_END_SEC)
end



------------------------------------------------
-- Coordinates for buttons in various screens --
------------------------------------------------

local HOME = {
  MISSIONS = {
    x = 1545,
    y = 1287
  },

  STATUS_BAR = {
    x = 521,
    y = 257
  }
}

local MISSIONS = {
  HOME_OR_BACK = {
    x = 1708,
    y = 264
  },

  DAILY = {
    x = 1414,
    y = 1268,
    FIRST = {
      x = 1134,
      y = 1139
    },
    SECOND = {
      x = 1134,
      y = 901
    },
    THIRD = {
      x = 1134,
      y = 666
    },
    FOURTH = {
      x = 1134,
      y = 429
    }
  },

  INSUFFICIENT_AP = {
    COLORS = {
      {x = 330, y = 330, color = 14998208},
      {x = 430, y = 330, color = 7363130},
      {x = 530, y = 330, color = 7363130},
      {x = 630, y = 330, color = 7363130},
      {x = 730, y = 330, color = 7363130},
      {x = 830, y = 330, color = 7363130},
      {x = 930, y = 330, color = 13880514},
      {x = 1030, y = 330, color = 7363130},
      {x = 1130, y = 330, color = 7363130},
      {x = 1230, y = 330, color = 7363130},
      {x = 1330, y = 330, color = 7363130},
      {x = 1430, y = 330, color = 7363130},
      {x = 1530, y = 330, color = 9205328},
      {x = 1630, y = 330, color = 7363130},
      {x = 1730, y = 330, color = 12761501},
      {x = 1100, y = 1000, color = 2091022},
      {x = 1200, y = 1000, color = 15325591},
      {x = 1300, y = 1000, color = 1427719},
      {x = 1400, y = 1000, color = 9288586},
      {x = 1500, y = 1000, color = 16777215},
      {x = 1600, y = 1000, color = 2288398},
      {x = 770, y = 1160, color = 15130049},
      {x = 870, y = 1160, color = 2936565},
      {x = 970, y = 1160, color = 669282},
      {x = 1070, y = 1160, color = 1737700},
      {x = 1170, y = 1160, color = 2936565},
      {x = 1270, y = 1160, color = 15327428},
    },

    AP10 = {
      x = 655,
      y = 590,
      COLOR = { AVAILABLE = 1292043 }
    },

    AP30 = {
      x = 1310,
      y = 590,
      COLOR = { AVAILABLE = 962568 }
    },

    AP50 = {
      x = 655,
      y = 795,
      COLOR = { AVAILABLE = 1293321 }
    },

    APMAX = {
      x = 1310,
      y = 795,
      COLOR = { AVAILABLE = 1161480 }
    },

    APSTONE = {
      x = 655,
      y = 1000,
      COLOR = { AVAILABLE = 1427719 }
    },

    CONSUME_CONFIRM = {
      x = 1180,
      y = 948
    },

    CONSUMED_STILL_INSUFFICIENT = {
      COLORS = {
        {x = 560, y = 515, color = 14932669},
        {x = 660, y = 515, color = 15458758},
        {x = 760, y = 515, color = 15195586},
        {x = 860, y = 515, color = 15195586},
        {x = 960, y = 515, color = 14208694},
        {x = 1060, y = 515, color = 5722449},
        {x = 1160, y = 515, color = 15064000},
        {x = 1260, y = 515, color = 15129536},
        {x = 1360, y = 515, color = 15195842},
        {x = 1460, y = 515, color = 14998207},
        {x = 804, y = 683, color = 15458757},
        {x = 904, y = 683, color = 15063999},
        {x = 1004, y = 683, color = 5722449},
        {x = 1104, y = 683, color = 15195585},
        {x = 1204, y = 683, color = 15195585},
        {x = 508, y = 970, color = 13024671},
        {x = 608, y = 970, color = 14998206},
        {x = 708, y = 970, color = 14866620},
        {x = 808, y = 970, color = 15393221},
        {x = 908, y = 970, color = 1209309},
        {x = 1008, y = 970, color = 547798},
        {x = 1108, y = 970, color = 480468},
        {x = 1208, y = 970, color = 2438218},
        {x = 1308, y = 970, color = 15195842},
        {x = 1408, y = 970, color = 15064000},
        {x = 1508, y = 970, color = 15129792},
      },

      CONFIRM = {
        x = 1080,
        y = 964
      }
    }
  }
}

local BATTLE = {
  HELPER_SELECT = {
    FIRST = {
      x = 1858,
      y = 509
    }
  },

  PARTY_SELECT = {
    CONFIRM = {
      x = 875,
      y = 1133
    }
  },

  COMPLETE = {
    COLORS = {
      {x = 100, y = 939, color = 14788123},
      {x = 200, y = 939, color = 16502123},
      {x = 300, y = 939, color = 16637264},
      {x = 400, y = 939, color = 14860167},
      {x = 500, y = 939, color = 14789656},
      {x = 600, y = 939, color = 12230263},
      {x = 700, y = 939, color = 16494651},
      {x = 800, y = 939, color = 16642200},
      {x = 900, y = 939, color = 16572325},
      {x = 1000, y = 939, color = 5979653},
      {x = 1100, y = 939, color = 14264162},
      {x = 1600, y = 1243, color = 9664855},
      {x = 1700, y = 1243, color = 2236962},
      {x = 1800, y = 1243, color = 13290186},
      {x = 1900, y = 1243, color = 13421772},
      {x = 2000, y = 1243, color = 2236962}
    },

    CONFIRM = {
      x = 1343,
      y = 1238
    },

    SAVED_MISSION = {
      x = 1697,
      y = 1246,
      COLOR = {
        UNAVAILABLE = 1710618,
        AVAILBLE = 38830
      }
    }
  }
}

local IN_BATTLE = {
  COLORS = {
    SKILLBAR = {
      FULL = 13803008,
      NOT_FULL = 131072
    }
  },

  MEMBERS = {
    FIRST = {
      x = 1900,
      y = 479,
      SKILLBAR = {
        TOP = {
          x = 1739,
          y = 377
        }
      }
    },

    SECOND = {
      x = 1900,
      y = 671,
      SKILLBAR = {
        TOP = {
          x = 1739,
          y = 569
        }
      }
    },

    THIRD = {
      x = 1900,
      y = 863,
      SKILLBAR = {
        TOP = {
          x = 1739,
          y = 761
        }
      }
    },

    FOURTH = {
      x = 1900,
      y = 1055,
      SKILLBAR = {
        TOP = {
          x = 1739,
          y = 953
        }
      }
    },

    FIFTH = {
      x = 1900,
      y = 1247,
      SKILLBAR = {
        TOP = {
          x = 1739,
          y = 1145
        }
      }
    },
  }
}

local OATH = {
  HOME = {
    MISSIONS = {
      x = 637,
      y = 1100
    },

    SAVED_MISSION = {
      x = 800,
      y = 1100
    }
  },

  ENCOUNTERED = {
    COLORS = {
      {x = 100, y = 1245, color = 41725},
      {x = 200, y = 1245, color = 37093},
      {x = 300, y = 1245, color = 37093},
      {x = 400, y = 1245, color = 153254},
      {x = 500, y = 1245, color = 7709647},
      {x = 600, y = 1245, color = 16777215},
      {x = 700, y = 1245, color = 27843},
      {x = 800, y = 1245, color = 37093},
      {x = 900, y = 1245, color = 39665},
      {x = 1048, y = 1245, color = 16639634},
      {x = 1148, y = 1245, color = 12265216},
      {x = 1248, y = 1245, color = 16399616},
      {x = 1348, y = 1245, color = 9969408},
      {x = 1448, y = 1245, color = 16777215},
      {x = 1548, y = 1245, color = 9969408},
      {x = 1648, y = 1245, color = 9969408},
      {x = 1748, y = 1245, color = 16399616},
      {x = 1848, y = 1245, color = 16268032},
      {x = 1948, y = 1245, color = 2498837}
    },

    PROCEED = {
      x = 1348,
      y = 1251
    }
  },

  BATTLE = {
    PREP = {
      PROCEED = {
        x = 1356,
        y = 819
      },
    },

    PARTY_SELECT = {
      RP_SELECT = {
        RP1 = { x = 787, y = 840 },
        RP2 = { x = 1007, y = 840 },
        RP3 = { x = 1227, y = 840 }
      }
    },

    COMPLETE = {
      COLORS = {
        {x = 657, y = 357, color = 4074267},
        {x = 757, y = 357, color = 3351574},
        {x = 857, y = 357, color = 658179},
        {x = 957, y = 357, color = 658179},
        {x = 1057, y = 357, color = 658179},
        {x = 1157, y = 357, color = 658179},
        {x = 1257, y = 357, color = 658179},
        {x = 1357, y = 357, color = 4074267},
        {x = 1107, y = 720, color = 7222581},
        {x = 1207, y = 720, color = 7222581},
        {x = 1307, y = 720, color = 7222581},
        {x = 1407, y = 720, color = 7222581},
        {x = 1507, y = 720, color = 7222581},
        {x = 1607, y = 720, color = 7222581},
        {x = 1707, y = 720, color = 7222581},
        {x = 1807, y = 720, color = 7222581},
        {x = 1907, y = 720, color = 7222581},
        {x = 1100, y = 843, color = 2143986},
        {x = 1200, y = 843, color = 16777215},
        {x = 1300, y = 843, color = 16777215},
        {x = 1400, y = 843, color = 16777215},
        {x = 1600, y = 842, color = 15421520},
        {x = 1700, y = 842, color = 13316144},
        {x = 1800, y = 842, color = 11676202},
        {x = 1900, y = 842, color = 13185072},
      },

      BOSS = {
        x = 527,
        y = 670
      },

      OATH_HOME = {
        x = 1288,
        y = 836
      },

      SAVED_MISSION = {
        x = 1757,
        y = 836
      }
    }
  },
}

local BATTLE_MEMBERS_LIST = {"FIRST", "SECOND", "THIRD", "FOURTH", "FIFTH"}

local AP_POTIONS_LIST = {
  MISSIONS.INSUFFICIENT_AP.AP10,
  MISSIONS.INSUFFICIENT_AP.AP30,
  MISSIONS.INSUFFICIENT_AP.AP50,
  MISSIONS.INSUFFICIENT_AP.APMAX
}


-----------------------------------------
-- Taps for buttons in various screens --
-----------------------------------------

home_tap_missions = generate_tap_function("home_tap_missions", HOME.MISSIONS.x, HOME.MISSIONS.y)
home_tap_status_bar = generate_tap_function("home_tap_status_bar", HOME.STATUS_BAR.x, HOME.STATUS_BAR.y)

missions_tap_home_or_back = generate_tap_function("missions_tap_home_or_back", MISSIONS.HOME_OR_BACK.x, MISSIONS.HOME_OR_BACK.y)
missions_tap_daily_missions = generate_tap_function("missions_tap_daily_missions", MISSIONS.DAILY.x, MISSIONS.DAILY.y)
missions_daily_tap_mission = function(mission_name)
  local name = "missions_daily_tap_mission_" .. mission_name
  return generate_tap_function(name, MISSIONS.DAILY[mission_name].x, MISSIONS.DAILY[mission_name].y)
end


battle_helper_select_tap_first_helper = generate_tap_function("battle_helper_select_tap_first_helper", BATTLE.HELPER_SELECT.FIRST.x, BATTLE.HELPER_SELECT.FIRST.y)
battle_party_select_tap_confirm = generate_tap_function("battle_helper_select_tap_confirm", BATTLE.PARTY_SELECT.CONFIRM.x, BATTLE.PARTY_SELECT.CONFIRM.y)


mission_complete_rewards_tap_confirm = generate_tap_function("mission_complete_rewards_tap_confirm", BATTLE.COMPLETE.CONFIRM.x, BATTLE.COMPLETE.CONFIRM.y)
mission_complete_EP_tap_confirm = generate_tap_function("mission_complete_EP_tap_confirm", BATTLE.COMPLETE.CONFIRM.x, BATTLE.COMPLETE.CONFIRM.y)


insufficient_ap_tap_potion = function(potion_name)
  local name = "insufficient_ap_tap_potion_" .. potion_name
  return generate_tap_function(name, MISSIONS.INSUFFICIENT_AP[potion_name].x, MISSIONS.INSUFFICIENT_AP[potion_name].y)
end
insufficient_ap_tap_consume_confirm = generate_tap_function("insufficient_ap_tap_consume_confirm",
							    MISSIONS.INSUFFICIENT_AP.CONSUME_CONFIRM.x,
							    MISSIONS.INSUFFICIENT_AP.CONSUME_CONFIRM.y)
insufficient_ap_tap_consumed_still_insufficient_confirm = generate_tap_function("insufficient_ap_tap_consumed_still_insufficient_confirm",
										MISSIONS.INSUFFICIENT_AP.CONSUMED_STILL_INSUFFICIENT.CONFIRM.x,
										MISSIONS.INSUFFICIENT_AP.CONSUMED_STILL_INSUFFICIENT.CONFIRM.y)

oath_encountered_tap_proceed = generate_tap_function("oath_encountered_tap_proceed",
                                                     OATH.ENCOUNTERED.PROCEED.x,
                                                     OATH.ENCOUNTERED.PROCEED.y)
oath_battle_prep_tap_proceed = generate_tap_function("oath_battle_prep_tap_proceed",
                                                     OATH.BATTLE.PREP.PROCEED.x,
                                                     OATH.BATTLE.PREP.PROCEED.y)
oath_battle_party_select_rp_select_tap_rp = function(rp)
  local name = "oath_battle_party_select_rp_select_tap_rp_" .. rp
  return generate_tap_function(name, OATH.BATTLE.PARTY_SELECT.RP_SELECT[rp].x, OATH.BATTLE.PARTY_SELECT.RP_SELECT[rp].y)
end

oath_battle_complete_tap_boss = generate_tap_function("oath_battle_complete_tap_boss",
                                                      OATH.BATTLE.COMPLETE.BOSS.x,
                                                      OATH.BATTLE.COMPLETE.BOSS.y)
oath_battle_complete_tap_oath_home = generate_tap_function("oath_battle_complete_tap_oath_home",
                                                           OATH.BATTLE.COMPLETE.OATH_HOME.x,
                                                           OATH.BATTLE.COMPLETE.OATH_HOME.y)
oath_home_tap_missions = generate_tap_function("oath_home_tap_missions",
                                               OATH.HOME.MISSIONS.x,
                                               OATH.HOME.MISSIONS.y)


----------------------
-- In Battle Daemon --
----------------------

function in_battle_daemon(battle_complete, interval)
  local thunk_interval = thunk(interval)
  local thunk_default_interval = thunk(DEFAULT_BATTLE_DAEMON_INTERVAL_SEC)
  local thunk_battle_complete = thunk(battle_complete)
  local thunk_mission_complete = thunk(mission_complete)

  while (not fif(battle_complete, thunk_battle_complete, thunk_mission_complete)())
  do
    if LOG_ENABLED then
      log("not mission complete")
    end

    LIST.fmap(activate_skill, BATTLE_MEMBERS_LIST)
    sleep_sec(fif(interval, thunk_interval, thunk_default_interval))
  end

  if LOG_ENABLED then
    log("mission complete!")
  end
end

function activate_skill(member)
  local cx,cy = IN_BATTLE.MEMBERS[member].SKILLBAR.TOP.x, IN_BATTLE.MEMBERS[member].SKILLBAR.TOP.y

  local skillbar_color = getColor(cx,cy)
  if skillbar_color ~= IN_BATTLE.COLORS.SKILLBAR.FULL then
    if LOG_ENABLED then
      log(string.format("skillbar not full for member[%s], with skillbar_color[%d]", member, skillbar_color))
    end
    return
  end

  if LOG_ENABLED then
    log(string.format("activating skill for member[%s]", member))
  end

  return swipe(cx, cy, cx-DEFAULT_SWIPE_LENGTH_RES, cy)
end

function mission_complete()
  return LIST.foldl(function(e, loc)
    return e and (loc.color == getColor(loc.x, loc.y))
  end, true, BATTLE.COMPLETE.COLORS)
end


----------
-- Oath --
----------

function encountered_oath()
  return LIST.foldl(function(e, loc)
    return e and (loc.color == getColor(loc.x, loc.y))
  end, true, OATH.ENCOUNTERED.COLORS)
end

function oath_battle_complete()
  local act = act_once(oath_battle_complete_tap_boss)
  act(2)

  return LIST.foldl(function(e, loc)
    return e and (loc.color == getColor(loc.x, loc.y))
  end, true, OATH.BATTLE.COMPLETE.COLORS)
end


----------------------------
-- Insufficient AP Checks --
----------------------------

function with_insufficient_ap_check(action, allow_potions, allow_stone)
  local function f(k)
    if LOG_ENABLED then
      log(string.format("with_insufficient_ap_check executing action with allow_potions[%s] and allow_stone[%s]", tostring(allow_potions), tostring(allow_stone)))
    end
    action()

    if (not insufficient_ap()) then
      return k()
    end

    if not allow_potions then
      return alert("insufficent ap!")
    end

    if ap_potions_available() then
      consume_ap_potion()

      if ap_consumed_still_insufficient() then
        if LOG_ENABLED then
          log("ap consumed but still insufficient!")
        end
        retry(insufficient_ap_tap_consumed_still_insufficient_confirm)()
        return f(k)
      else
        return k()
      end

    elseif not allow_stone then
      return alert("insufficent ap!")

    elseif ap_stone_available() then
      consume_ap_stone()

      if ap_consumed_still_insufficient() then
        if LOG_ENABLED then
          log("ap consumed but still insufficient!")
        end
        retry(insufficient_ap_tap_consumed_still_insufficient_confirm)()
        return f(k)
      else
        return k()
      end

    else
      return alert("insufficient ap!")
    end
  end

  return f
end

function insufficient_ap()
  return LIST.foldl(function(e, loc)
    return e and (loc.color == getColor(loc.x, loc.y))
  end, true, MISSIONS.INSUFFICIENT_AP.COLORS)
end

function ap_option_available(loc)
  return loc.COLOR.AVAILABLE == getColor(loc.x, loc.y)
end

function ap_potions_available()
  return LIST.foldl(function(e, loc)
    return e or ap_option_available(loc)
  end, false, AP_POTIONS_LIST)
end

function ap_stone_available()
  return ap_option_available(MISSIONS.INSUFFICIENT_AP.APSTONE)
end

function consume_ap_option(name)
  local loc = MISSIONS.INSUFFICIENT_AP[name]

  return function(k)
    if ap_option_available(loc) then
      if LOG_ENABLED then
        log(string.format("consume_ap_option for option[%s]", name))
      end

      retry(insufficient_ap_tap_potion(name))()
      retry(insufficient_ap_tap_consume_confirm)()
      return
    end

    return k()
  end
end

function consume_ap_potion()
  return consume_ap_option("AP10")(function()
    return consume_ap_option("AP30")(function()
      return consume_ap_option("AP50")(function()
        return consume_ap_option("APMAX")(function() end)
      end)
    end)
  end)
end

function consume_ap_stone()
  return consume_ap_option("APSTONE")(function() end)
end

function ap_consumed_still_insufficient()
  return LIST.foldl(function(e, loc)
    return e and (loc.color == getColor(loc.x, loc.y))
  end, true, MISSIONS.INSUFFICIENT_AP.CONSUMED_STILL_INSUFFICIENT.COLORS)
end


---------------------
-- Debug Functions --
---------------------

function skillbar_top_color(member)
  local cx,cy = IN_BATTLE.MEMBERS[member].SKILLBAR.TOP.x, IN_BATTLE.MEMBERS[member].SKILLBAR.TOP.y

  return getColor(cx,cy)
end

function get_mission_complete_colors()
  local init_x1, cy1 = 100, 939
  local final_x1 = 1100
  for cx1 = init_x1, final_x1, 100
  do
    log(string.format("{x = %d, y = %d, color = %d},", cx1, cy1, getColor(cx1, cy1)))
  end

  local init_x1, cy1 = 1600, 1243
  local final_x1 = 2000
  for cx1 = init_x1, final_x1, 100
  do
    log(string.format("{x = %d, y = %d, color = %d},", cx1, cy1, getColor(cx1, cy1)))
  end
end

function get_insufficient_ap_colors()
  local init_x1, cy1 = 330, 330
  local final_x1 = 1730
  for cx1 = init_x1, final_x1, 100
  do
    log(string.format("{x = %d, y = %d, color = %d},", cx1, cy1, getColor(cx1, cy1)))
  end

  local init_x1, cy1 = 1100, 1000
  local final_x1 = 1600
  for cx1 = init_x1, final_x1, 100
  do
    log(string.format("{x = %d, y = %d, color = %d},", cx1, cy1, getColor(cx1, cy1)))
  end

  local init_x1, cy1 = 770, 1160
  local final_x1 = 1270
  for cx1 = init_x1, final_x1, 100
  do
    log(string.format("{x = %d, y = %d, color = %d},", cx1, cy1, getColor(cx1, cy1)))
  end
end

function get_ap_option_consumed_still_insufficient_colors()
  local init_x1, cy1 = 560, 515
  local final_x1 = 1460
  for cx1 = init_x1, final_x1, 100
  do
    log(string.format("{x = %d, y = %d, color = %d},", cx1, cy1, getColor(cx1, cy1)))
  end

  local init_x1, cy1 = 804, 683
  local final_x1 = 1204
  for cx1 = init_x1, final_x1, 100
  do
    log(string.format("{x = %d, y = %d, color = %d},", cx1, cy1, getColor(cx1, cy1)))
  end

  local init_x1, cy1 = 508, 970
  local final_x1 = 1508
  for cx1 = init_x1, final_x1, 100
  do
    log(string.format("{x = %d, y = %d, color = %d},", cx1, cy1, getColor(cx1, cy1)))
  end
end

function get_oath_boss_encountered_colors()
  local init_x1, cy1 = 100, 1245
  local final_x1 = 900
  for cx1 = init_x1, final_x1, 100
  do
    log(string.format("{x = %d, y = %d, color = %d},", cx1, cy1, getColor(cx1, cy1)))
  end

  local init_x1, cy1 = 1048, 1245
  local final_x1 = 1948
  for cx1 = init_x1, final_x1, 100
  do
    log(string.format("{x = %d, y = %d, color = %d},", cx1, cy1, getColor(cx1, cy1)))
  end
end

function get_oath_battle_complete_colors()
  local coords_list = {
    {{657,357}, {1357,357}},
    {{1107,720}, {1907,720}},
    {{1100,843}, {1400,843}},
    {{1600,842}, {1900,842}}
  }

  LIST.fmap(function(coords)
    local init_x1, cy1 = coords[1][1], coords[1][2]
    local final_x1 = coords[2][1]
    for cx1 = init_x1, final_x1, 100
    do
      log(string.format("{x = %d, y = %d, color = %d},", cx1, cy1, getColor(cx1, cy1)))
    end
  end, coords_list)
end
