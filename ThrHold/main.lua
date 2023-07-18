-- A simple throttle hold indicator
-- Steve Bernard
-- Date: 2023
-- ver: 0.1
-- This script intended for the title bar area; font size does not change

local options = {
  { "TextColor", COLOR, YELLOW },
  { "Source", SOURCE, 0},
  { "Invert", BOOL, 0},
}

local function log(s)
  return;
  --print("thrhold: " .. s)
end

local function create(zone, options)
  local wgt = { zone = zone, options = options }
  return wgt
end

local function update(wgt, options)
  if (wgt == nil) then return end
  wgt.options = options
  --log("src:" .. options.Source)
end

local function background(wgt)
  return
end

------------------------------------------------------------


local function refresh(wgt, event, touchState)
    if (wgt == nil)               then log("refresh(nil)")                   return end
    if (wgt.options == nil)       then log("refresh(wgt.options=nil)")       return end

    local font_size = MIDSIZE
    local hold_str
    local text_color = wgt.options.TextColor
    local val = getValue(wgt.options.Source)
    if wgt.options.Invert == 1 then
        val = val * -1
    end
    --log("src:val" .. val)
    if val < 0 then
        hold_str = "ACTV"
    elseif val > 0 then
        hold_str = "TCUT"
    else
        hold_str = "???"
    end
    -- draw throttle hold status
    lcd.drawText(wgt.zone.x, wgt.zone.y, hold_str, font_size + text_color)

end

return { name="ThrHold", options=options, create=create, update=update, background=background, refresh=refresh }
