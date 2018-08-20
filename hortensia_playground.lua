require("utils/lib_loader")

LOG_ENABLED = false
ALLOW_AP_POTIONS = false
ALLOW_AP_STONE = false

if LOG_ENABLED then
  log("\n\n\nbegin script logging:")
end



--[[
alert(string.format("skillbar colors: first[%d], second[%d], third[%d], fourth[%d], fifth[%d]",
skillbar_top_color("FIRST"),
skillbar_top_color("SECOND"),
skillbar_top_color("THIRD"),
skillbar_top_color("FOURTH"),
skillbar_top_color("FIFTH")))
--]]

--[[
activate_skill("FIRST")
activate_skill("SECOND")
activate_skill("THIRD")
activate_skill("FOURTH")
activate_skill("FIFTH")
--]]


--with_insufficient_ap_check(function() end)(function() alert("continuation called") end)


---[[
function execute_mission(k)
  local action = retry(missions_daily_tap_mission("FOURTH"))

  return with_insufficient_ap_check(action, ALLOW_AP_POTIONS, ALLOW_AP_STONE)(function()
    retry(battle_helper_select_tap_first_helper)()
    retry(battle_party_select_tap_confirm)()

    in_battle_daemon()

    mission_complete_EP_tap_confirm()
    retry(mission_complete_rewards_tap_confirm)()

    return k()
  end)
end

local function main()
  return execute_mission(main)
end

main()

--]]
