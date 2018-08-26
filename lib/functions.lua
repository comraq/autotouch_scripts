DEFAULT_WIDTH = 2048
DEFAULT_HEIGHT = 1536

local APPROX_COLOR_MATCH = true
local w_reg,h_reg = 20,14

local WIDTH,HEIGHT = getScreenResolution();
local w,h = WIDTH/DEFAULT_WIDTH,HEIGHT/DEFAULT_HEIGHT

function adjust_coords(x, y)
  return DEFAULT_HEIGHT-y, x
end

function cgetColor(x, y)
  return getColor(w * x, h * y)
end

function ctouchDown(id, x, y)
  return touchDown(id, w * x, h * y)
end

function ctouchUp(id, x, y)
  return touchUp(id, w * x, h * y)
end

function ctouchMove(id, x, y)
  return touchMove(id, w * x, h * y)
end

function match_color(c, x, y)
  if APPROX_COLOR_MATCH then
    local locs = findColor(c, 1, calc_reg(x, y))
    if #locs > 0 and LOG_ENABLED then
      log(string.format("c[%f], x[%f], y[%f]", c, x, y))
      for i,v in pairs(locs) do
        log(string.format("x[%f], y[%f]", v[1], v[2]))
      end
    end
    if #locs > 1 and LOG_ENABLED then
      log(string.format("more than one match found for c[%f], at x[%f], y[%f]", c, x, y))
    end

    return #locs > 0
  else
    return c == cgetColor(x, y)
  end

end

function calc_reg(x, y)
  return {w * (x - w_reg/2), h * (y - h_reg/2), w * w_reg, h * h_reg}
end

-----------------------
-- Utility Functions --
-----------------------

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
      local orig_color = cgetColor(cx, cy)

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

          local c = cgetColor(cx,cy)
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
