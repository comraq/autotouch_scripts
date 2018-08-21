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


giftbox_accept_items()
retry(missions_tap_dropdown)()
retry(home_tap_missions)()

if in_mission_boss_unavailable() then
  return alert("boss not available, cannot proceed")
end
retry(missions_tap_boss)()

local rp_amount = 1
sleep_sec(rp_amount * 60 * 10)
if LOG_ENABLED then
  alert(string.format("Woken after [%d*10] minutes, resuming", rp_amount))
end
