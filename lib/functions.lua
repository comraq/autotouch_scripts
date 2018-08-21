function sleep_sec(sec)
  usleep(sec * 1000000)
end

function thunk(x)
  return function()
    return x
  end
end

function retry(f)
  return function(...)
    return f(...)(function (cx, cy, action)
      local orig_color = getColor(cx, cy)

      local function g(color)
        if orig_color ~= color then
          if LOG_ENABLED then
            log(string.format("color changed to:%d", color))
          end
          return
        else
          if LOG_ENABLED then
            log(string.format("orig_color is:%d", orig_color))
          end
          action()

          local c = getColor(cx,cy)
          if LOG_ENABLED then
            log(string.format("color after executing action is:%d", c))
          end

          return g(c)
        end
      end

      return g(orig_color)
    end)
  end
end

function act_once(f)
  return function(...)
    return f(...)(function (_cx, _cy, action)
      if LOG_ENABLED then
        log("executing action once")
      end

      return action()
    end)
  end
end

function awake_and_unlock_screen()
  unlockScreen()
  sleep_sec(1)

  keyDown(KEY_TYPE.HOME_BUTTON);
  sleep_sec(0.5)

  keyUp(KEY_TYPE.HOME_BUTTON)
end

LIST = {
  fmap = function(f, list)
    local new_list = {}
    for i,v in ipairs(list) do
      new_list[i] = f(v)
    end
    return new_list
  end,

  foldl = function(f, init, list)
    local acc = init
    for i,v in ipairs(list) do
      acc = f(acc, v)
    end

    return acc
  end
}
