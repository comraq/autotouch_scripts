--------------------------------
-- Enum for Motion Directions --
--------------------------------

DIRECTION = {
  UP = {
    value = "UP",
    get_coords = function(x,y)
      return x,y-1
    end
  },

  DOWN = {
    value = "DOWN",
    get_coords = function(x,y)
      return x,y+1
    end
  },

  LEFT = {
    value = "LEFT",
    get_coords = function(x,y)
      return x-1,y
    end
  },

  RIGHT = {
    value = "RIGHT",
    get_coords = function(x,y)
      return x+1,y
    end
  },
}


------------------------------------------
-- Timing Parameters for Tuning Motions --
------------------------------------------

local DEFAULT_SLIDE_BEGIN_SEC = 0.5
local DEFAULT_SLIDE_END_SEC = 0.5
local DEFAULT_SLIDE_DUR_SEC = 0.001

function slide(dir, pred, x, y)
  local xt,yt = x,y
  local x1,y1 = adjust_coords(xt, yt)
  if LOG_ENABLED then
    log(string.format("Starting slide motion in dir[%s] from x1[%f], y1[%f]", dir, x1, y1))
  end
  ctouchDown(0, x1, y1)
  sleep_sec(DEFAULT_SLIDE_BEGIN_SEC)

  repeat
    xt,yt = adjust_coords_inverse(x1, y1)
    if out_of_bounds(xt, yt) then
      return alert(string.format("Sliding out of bounds with x[%f], y[%f]", xt, yt))
    end

    -- Multiply by -1 due to unadjusted y is calculated as a negative value when adjusted
    xt,yt = get_new_coords(dir, xt, -1 * yt)
    x1,y1 = adjust_coords(xt, -1 * yt)

    if x1 == nil or y1 == nil then
      return alert(string.format("No matching DIRECTION found for dir[%s]", dir))
    end

    if LOG_ENABLED then
      log(string.format("Slide not finished, moving to x1[%f], y1[%f]", x1, y1))
    end

    ctouchMove(0, x1, y1)
    sleep_sec(DEFAULT_SLIDE_DUR_SEC)
  until pred()

  ctouchUp(0, x1, y1)
  sleep_sec(DEFAULT_SLIDE_END_SEC)

  if LOG_ENABLED then
    log(string.format("Slide finished at x1[%f], y1[%f]", x1, y1))
  end
end

function get_new_coords(dir, x, y)
  if dir == DIRECTION.UP.value then
    return DIRECTION.DOWN.get_coords(x, y)

  elseif dir == DIRECTION.DOWN.value then
    return DIRECTION.UP.get_coords(x, y)

  elseif dir == DIRECTION.LEFT.value then
    return DIRECTION.LEFT.get_coords(x, y)

  elseif dir == DIRECTION.RIGHT.value then
    return DIRECTION.RIGHT.get_coords(x, y)

  end
end
