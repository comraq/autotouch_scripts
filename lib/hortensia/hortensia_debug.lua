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
    {{600,801}, {1400,801}}
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
