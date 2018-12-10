DEFAULT_WIDTH = 2048
DEFAULT_HEIGHT = 1536

local APPROX_COLOR_MATCH = true
local w_reg,h_reg = 20,14

local WIDTH,HEIGHT = getScreenResolution();
local w,h = WIDTH/DEFAULT_WIDTH,HEIGHT/DEFAULT_HEIGHT

function adjust_coords(x, y)
  return DEFAULT_HEIGHT-y, x
end

function adjust_coords_inverse(x, y)
  return y, -1 * (x - DEFAULT_HEIGHT)
end

function out_of_bounds(x, y)
  return x < 0 or x > DEFAULT_WIDTH or y < 0 or y > DEFAULT_HEIGHT
end

function run_with_approx_colors(ac, f)
  if LOG_ENABLED then
    log(string.format("Setting APPROX_COLOR_MATCH from [%s] to new value [%s]", tostring(APPROX_COLOR_MATCH), tostring(ac)))
  end
  local approx_before = APPROX_COLOR_MATCH
  APPROX_COLOR_MATCH = ac

  return f(function(v)
    if LOG_ENABLED then
      log(string.format("Restoring APPROX_COLOR_MATCH to [%s]", tostring(approx_before)))
    end
    APPROX_COLOR_MATCH = approx_before

    return v
  end)
end

--------------------------------------------------
-- Wrappers around device interaction functions --
--------------------------------------------------

function cgetColor(x, y)
  if ipad_air() then
    if LOG_ENABLED then
      -- log(string.format("ipad_air true, getColor(w[%f] * x[%f], h[%f] * y[%f])", w, x, h, y))
    end
    return getColor(w * x, h * y)
  else
    local x1,y1 = adjust_coords(x, y)
    if LOG_ENABLED then
      -- log(string.format("ipad_air false, getColor(h[%f] * x1[%f], w[%f] * y1[%f])", h, x1, w, y1))
    end
    return getColor(h * x1, w * y1)
  end
end

function ctouchDown(id, x, y)
  return touchDown(id, h * x, w * y)
end

function ctouchUp(id, x, y)
  return touchUp(id, h * x, w * y)
end

function ctouchMove(id, x, y)
  return touchMove(id, h * x, w * y)
end

-- The public function with additional logic to match color c at location x,y
function match_color(c, x, y)
  if LOG_ENABLED then
    log(string.format("matching c[%f], centered around x[%f], y[%f]", c, x, y))
  end
  if APPROX_COLOR_MATCH then
    local locs = findColor(c, 1, calc_reg(x, y))
    if #locs > 0 and LOG_ENABLED then
      for i,v in pairs(locs) do
        log(string.format("found x[%f], y[%f]", v[1], v[2]))
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


function retry(f, pred)

  return function(...)
    return f(function (cx, cy, action)
      local retry_pred = fif(pred, thunk(pred),
                                   function() return act_color_changed(cx, cy) end)

      local res
      repeat
        res = action()
      until retry_pred()

      return res

    end, ...)
  end
end

function act_once(f)
  return function(...)
    return f(function (_cx, _cy, action)
      if LOG_ENABLED then
        log("executing action once")
      end

      return action()
    end, ...)
  end
end

-- Retry predicate that returns true when the color before and after action has changed
function act_color_changed(cx, cy)
  local orig_color = cgetColor(cx, cy)
  if LOG_ENABLED then
    log(string.format("cx[%f], cy[%f], original color is [%d]", cx, cy, orig_color))
  end

  return function()
    local c = cgetColor(cx,cy)
    if LOG_ENABLED then
      log(string.format("cx[%f], cy[%f], color after executing action is [%d]", cx, cy, c))
    end

    return orig_color ~= c
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
  end,

  tail = function(xs)
    local ys = {}
    for i,v in ipairs(xs) do
      if i > 1 then
        ys[i - 1] = v
      end
    end

    return ys
  end,

  length = function(xs)
    local n = 0
    for i,v in pairs(xs) do
      n = n + 1
    end
    return n
  end
}

FUNCTIONS = {
  id = function(...)
    return ...
  end
}
