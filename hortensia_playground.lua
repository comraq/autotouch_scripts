require("utils/lib_loader")

LOG_ENABLED = true
ALLOWED_AP_OPTIONS = {
  "AP50",
  "APMAX"
}
ALLOW_RP_POTIONS = true

if LOG_ENABLED then
  log("\n\n\nbegin script logging:")
end

--get_loading_running_colors()

---[[
while not match_all_colors(HORTENSIA.LOADING.RUNNING.COLORS) do
  log("loading image not detected")
  sleep_sec(0.1)
end

wait_network_loading()
alert("loading completed!")
--]]


--[[
log(string.format("border_top[%f], sword_tip[%f]",
    getColor(HORTENSIA.LOADING.CIRCLE.BORDER_TOP.x, HORTENSIA.LOADING.CIRCLE.BORDER_TOP.y),
    getColor(HORTENSIA.LOADING.CIRCLE.TOP_SWORD_TIP.x, HORTENSIA.LOADING.CIRCLE.TOP_SWORD_TIP.y)))
    --]]

