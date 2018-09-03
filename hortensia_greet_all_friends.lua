require("utils/lib_loader")

LOG_ENABLED = false
NUM_FRIENDS = 60

if LOG_ENABLED then
  log("\n\n\nbegin script logging:")
end

local tap_third_sticker = retry(stickers_tap_sticker("THREE"))
local function select_eighths_sticker_coll()
  for i = 1, 8, 1 do
    greeting_dialog_sticker_list_scroll_right_once()
  end

  act_once(stickers_list_tap_coll("EIGHT"))()
end

local function greet(n, sticker_coll_selected, tap_sticker)
  if greeted_dialog() then
    retry(greeting_dialog_greeted_tap_close)()
    if LOG_ENABLED then
      log(string.format("Friend [%d] already greeted!", n))
    end
    return false

  elseif not_greeted_dialog() then
    retry(greeting_dialog_not_greeted_tap_stickers)()

    if not sticker_coll_selected then
      select_eighths_sticker_coll()
    end

    tap_sticker()
    return true

  else
    if LOG_ENABLED then
      log(string.format("Unknown greeting dialog for friend [%d]", n))
    end
    return false
  end
end

local function greet_all(n, sc_selected)
  local greeted

  if n >= NUM_FRIENDS then
    return alert(string.format("Greeted all [%d] friends", n))
  end
  retry(friends_list_tap_greet("FIRST"))()
  greeted = greet(n, sc_selected, tap_third_sticker)


  if n + 1 >= NUM_FRIENDS then
    return alert(string.format("Greeted all [%d] friends", n + 1))
  end
  retry(friends_list_tap_greet("SECOND"))()
  greeted = greet(n + 1, greeted or sc_selected, tap_third_sticker)


  if n + 2 >= NUM_FRIENDS then
    return alert(string.format("Greeted all [%d] friends", n + 2))
  end
  retry(friends_list_tap_greet("THIRD"))()
  greeted = greet(n + 2, greeted or sc_selected, tap_third_sticker)

  -- Scroll down 3 times
  for i = 1, 3, 1 do
    friends_list_scroll_down_once()
  end
  return greet_all(n + 3, greeted or sc_selected)
end


local function main()
  return greet_all(0, false)
end
main()
