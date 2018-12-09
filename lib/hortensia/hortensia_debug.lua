---------------------
-- Debug Functions --
---------------------

function skillbar_top_color(member)
  local cx,cy = HORTENSIA.IN_BATTLE.MEMBERS[member].SKILLBAR.TOP.x, HORTENSIA.IN_BATTLE.MEMBERS[member].SKILLBAR.TOP.y

  return getColor(cx,cy)
end

function get_mission_complete_colors()
  local init_x1, cy1 = 100, 939
  local final_x1 = 1100
  for cx1 = init_x1, final_x1, 100
  do
    log(string.format("{x = %d, y = %d, color = %d},", cx1, cy1, getColor(cx1, cy1)))
  end

  local init_x1, cy1 = 1700, 1243
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

  local init_x1, cy1 = 1148, 1245
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

function get_oath_battle_party_select_insufficient_rp_consume_colors()
  local coords_list = {
    {{608,508}, {1408,508}},
    {{608,643}, {1408,643}},
    {{608,892}, {1408,892}}
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

function get_oath_battle_party_select_insufficient_rp_purchase_colors()
  local coords_list = {
    {{608,500}, {1408,500}},
    {{608,690}, {1408,690}},
    {{900,801}, {1400,801}}
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

function get_quest_failed_colors()
  local coords_list = {
    {{530,630}, {1530,630}},
    {{530,1050}, {1530,1050}},
    {{660,700}, {740,700}},
    {{660,750}, {740,750}}
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

function get_loading_running_colors()
  local cs = {
    {926,852},
    {926,861},
    {936,873},
    {967,856},
    {948,869},
    {947,863},
    {988,850},
    {990,854},
    {988,863},
    {992,861},
    {993,866},
    {995,870},
    {1009,850},
    {1024,857},
    {1025,862},
    {1024,868},
    {1021,872},
    {1007,860},
    {1036,850},
    {1036,855},
    {1036,869},
    {1050,858},
    {1055,852},
    {1064,861},
    {1067,861},
    {1077,858},
    {1078,865},
    {1096,867},
    {1096,867},
    {1096,861},
  }

  LIST.fmap(function(p)
    local x,y = p[1], p[2]
    log(string.format("{x = %d, y = %d, color = %d},", x, y, getColor(x, y)))
  end, cs)
end

function get_rank_up_colors()
  local cs = {
    {621,357},
    {623,421},
    {622,476},
    {691,368},
    {673,417},
    {704,479},
    {749,399},
    {760,440},
    {817,452},
    {750,483},
    {824,489},
    {878,406},
    {876,476},
    {917,397},
    {948,421},
    {951,483},

    {1010,357},
    {1014,473},
    {1073,395},
    {1062,436},
    {1084,479},

    {1210,361},
    {1210,447},
    {1260,489},
    {1304,459},
    {1302,371},

    {1364,360},
    {1429,370},
    {1357,420},
    {1395,416},
    {1360,484}
  }

  LIST.fmap(function(p)
    local x,y = p[1], p[2]
    log(string.format("{x = %d, y = %d, color = %d},", x, y, getColor(x, y)))
  end, cs)
end

function get_ep_up_story_unlock_colors()
  local hcs = {
    {{1160,232}, {1960,232}},

    {{1210,995}, {1910,995}},

    {{1159,1182}, {1959,1182}}
  }

  local vcs = {
    {{1115,301}, {1115,1101}},

    {{2009,260}, {2009,1160}},
  }

  log("horizontal list colors")
  LIST.fmap(function(p)
    local xi, yi = p[1][1], p[1][2]
    local xe = p[2][1]
    for cx = xi, xe, 100
    do
      log(string.format("{x = %d, y = %d, color = %d},", cx, yi, getColor(cx, yi)))
    end
  end, hcs)

  log("vertical list colors")
  LIST.fmap(function(p)
    local xi, yi = p[1][1], p[1][2]
    local ye = p[2][2]
    for cy = yi, ye, 100
    do
      log(string.format("{x = %d, y = %d, color = %d},", xi, cy, getColor(xi, cy)))
    end
  end, vcs)
end

function get_ep_up_awakening_unlock_colors()
  local hcs = {
    {{1160,232}, {1960,232}},

    {{1159,1081}, {1959,1081}}
  }

  local vcs = {
    {{1115,301}, {1115,1001}},

    {{2009,260}, {2009,1060}},
  }

  log("horizontal list colors")
  LIST.fmap(function(p)
    local xi, yi = p[1][1], p[1][2]
    local xe = p[2][1]
    for cx = xi, xe, 100
    do
      log(string.format("{x = %d, y = %d, color = %d},", cx, yi, getColor(cx, yi)))
    end
  end, hcs)

  log("vertical list colors")
  LIST.fmap(function(p)
    local xi, yi = p[1][1], p[1][2]
    local ye = p[2][2]
    for cy = yi, ye, 100
    do
      log(string.format("{x = %d, y = %d, color = %d},", xi, cy, getColor(xi, cy)))
    end
  end, vcs)
end

function get_not_greeted_dialog_colors()
  local cs = {
    {431,472},
    {482,463},
    {535,472},
    {483,493},
    {432,526},
    {548,557},
    {971,531},
    {1654,512},
    {450,783},
    {684,770},
    {889,772},
    {1026,772},
    {1161,775},
    {1405,767},
    {1612,772}
  }

  LIST.fmap(function(p)
    local x,y = p[1], p[2]
    log(string.format("{x = %d, y = %d, color = %d},", x, y, getColor(x, y)))
  end, cs)
end

function get_greeted_dialog_colors()
  local cs = {
    {392,396},
    {447,529},
    {535,472},
    {504,554},
    {535,600},
    {553,617},
    {978,601},
    {1587,366},
    {685,797},
    {917,814},
    {1160,806},
    {1532,805},
  }

  LIST.fmap(function(p)
    local x,y = p[1], p[2]
    log(string.format("{x = %d, y = %d, color = %d},", x, y, getColor(x, y)))
  end, cs)
end

function get_final_wave_colors()
  local cs = {
    {25,1133},
    {56,1140},
    {72,1139},
    {79,1126},
    {92,1135},
    {129,1135},
    {166,1150},

    {243,1140},
    {256,1144},
    {278,1139},
    {280,1154},
    {291,1143},
    {311,1143}
  }

  LIST.fmap(function(p)
    local x,y = p[1], p[2]
    log(string.format("{x = %d, y = %d, color = %d},", x, y, getColor(x, y)))
  end, cs)
end

function get_magonia_battle_complete_colors()
  local cs = {
    {1100,400},
    {1200,400},
    {1300,400},
    {1400,400},
    {1500,400},
    {1600,400},
    {1700,400},
    {1800,400},
    {1900,400},
  }

  LIST.fmap(function(p)
    local x,y = p[1], p[2]
    log(string.format("{x = %d, y = %d, color = %d},", x, y, getColor(x, y)))
  end, cs)
end

function get_magonia_battle_unit_select_colors()
  local cs = {
    {1292,1249},
    {383,1269},
    {592,1269},
    {103,1269},
    {1328,1125},
    {1255,307},
    {1106,251}
  }

  LIST.fmap(function(p)
    local x,y = p[1], p[2]
    log(string.format("{x = %d, y = %d, color = %d},", x, y, getColor(x, y)))
  end, cs)
end

function get_magonia_aid_requests_battle_finished_colors()
  local cs = {
    {950,964},
    {1101,966},
    {1543,465},
    {1024,1035},
    {1872,1233},
    {204,332},
  }

  LIST.fmap(function(p)
    local x,y = p[1], p[2]
    log(string.format("{x = %d, y = %d, color = %d},", x, y, getColor(x, y)))
  end, cs)
end

function get_magonia_boss_already_defeated_colors()
  local cs = {
    {1033,1046},
    {957,973},
    {1093,972},
    {1541,467},
  }

  LIST.fmap(function(p)
    local x,y = p[1], p[2]
    log(string.format("{x = %d, y = %d, color = %d},", x, y, getColor(x, y)))
  end, cs)
end

function get_magonia_boss_unit_select_bp_insufficient_colors()
  local cs = {
    {947,970},
    {1096,970},
    {1035,1037},
    {1538,462},
  }

  LIST.fmap(function(p)
    local x,y = p[1], p[2]
    log(string.format("{x = %d, y = %d, color = %d},", x, y, getColor(x, y)))
  end, cs)
end

function get_magonia_boss_already_defeated_bp_not_consumed_colors()
  local cs = {
    {947,970},
    {1096,970},
    {1035,1037},
    {1538,462},
    {214,349},
    {1750,1199}
  }

  LIST.fmap(function(p)
    local x,y = p[1], p[2]
    log(string.format("{x = %d, y = %d, color = %d},", x, y, getColor(x, y)))
  end, cs)
end

function get_mission_special_complete_colors()
  local init_x1, cy1 = 100, 935
  local final_x1 = 1100
  for cx1 = init_x1, final_x1, 100
  do
    log(string.format("{x = %d, y = %d, color = %d},", cx1, cy1, getColor(cx1, cy1)))
  end
end

function get_recollection_treasure_chance_colors()
  local init_x1, cy1 = 168, 640
  local final_x1 = 1068
  for cx1 = init_x1, final_x1, 100
  do
    log(string.format("{x = %d, y = %d, color = %d},", cx1, cy1, getColor(cx1, cy1)))
  end
end

function get_recollection_treasure_chance_complete_colors()
  local init_x1, cy1 = 223, 1060
  local final_x1 = 1823
  for cx1 = init_x1, final_x1, 100
  do
    log(string.format("{x = %d, y = %d, color = %d},", cx1, cy1, getColor(cx1, cy1)))
  end
end

function get_recollection_boss_encountered_colors()
  local cs = {
    {1197,735},
    {1192,836},
    {1864,737},
    {1918,773},
    {1973,815}
  }

  LIST.fmap(function(p)
    local x,y = p[1], p[2]
    log(string.format("{x = %d, y = %d, color = %d},", x, y, getColor(x, y)))
  end, cs)
end

function get_recollection_paths_ap_insufficient_colors()
  local cs = {
    {1029,940},
    {726,972},
    {1339,975},
    {1021,1038}
  }

  LIST.fmap(function(p)
    local x,y = p[1], p[2]
    log(string.format("{x = %d, y = %d, color = %d},", x, y, getColor(x, y)))
  end, cs)
end

function get_recollection_boss_defeated_colors()
  local cs = {
    {224,1271},
    {1149,1176},
    {1539,1176},
    {1912,1176},
    {1578,1219}
  }

  LIST.fmap(function(p)
    local x,y = p[1], p[2]
    log(string.format("{x = %d, y = %d, color = %d},", x, y, getColor(x, y)))
  end, cs)
end
