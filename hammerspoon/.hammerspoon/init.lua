-- auto reloading

function reloadConfig(files)
   doReload = false
   for _,file in pairs(files) do
      if file:sub(-4) == ".lua" then
         doReload = true
      end
   end
   if doReload then
      hs.reload()
   end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")


-- Load Extensions
local application = require "hs.application"
local window = require "hs.window"
local hotkey = require "hs.hotkey"
local keycodes = require "hs.keycodes"
local fnutils = require "hs.fnutils"
local alert = require "hs.alert"
local screen = require "hs.screen"
local grid = require "hs.grid"
local hints = require "hs.hints"

hs.window.animationDuration = 0;

local gridset = function(frame)
   return function()
      local win = window.focusedWindow()
      if win then
         grid.set(win, frame, win:screen())
      else
         alert.show("No focused window.")
      end
   end
end

-- Actual config =================================

local mash = { "ctrl", "shift", "alt"}
local mashshift = {"cmd", "ctrl", "shift"}

grid.MARGINX = 0
grid.MARGINY = 0
grid.GRIDWIDTH = 8
grid.GRIDHEIGHT = 8

local goleft = {x = 0, y = 0, w = 4, h = 8}
local goright = {x = 4, y = 0, w = 4, h = 8}
local goUpperRight = {x = 4, y = 0, w = 4, h = 4}
local goUpperLeft = {x = 0, y = 0, w = 4, h = 4}
local goDownLeft = {x = 0, y = 4, w = 4, h = 4}
local goDownRight = {x = 4, y = 4, w = 4, h = 4}

hotkey.bind(mashshift, 'I', grid.maximizeWindow)
hotkey.bind(mashshift, 'H', gridset(goleft))
hotkey.bind(mashshift, 'L', gridset(goright))
hotkey.bind(mashshift, 'O', gridset(goUpperRight))
hotkey.bind(mashshift, 'U', gridset(goUpperLeft))
hotkey.bind(mashshift, 'K', gridset(goDownRight))
hotkey.bind(mashshift, 'J', gridset(goDownLeft))
-- hotkey.bind(mashshift, 'J', grid.resizeWindowThinner)
-- hotkey.bind(mashshift, 'K', grid.resizeWindowWider)
hotkey.bind(mashshift, 'N', grid.pushWindowNextScreen)


-- Caffeine
local caffeine = hs.menubar.new()
function setCaffeineDisplay(state)
   if state then
      caffeine:setTitle("A")
   else
      caffeine:setTitle("S")
   end
end

function caffeineToggle()
   setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

if caffeine then
    caffeine:setClickCallback(caffeineToggle)
    setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end

hotkey.bind(mash, 'S', caffeineToggle)

-- Find me the mouse!

local mouseCircle = nil
local mouseCircleTimer = nil

function mouseHighlight()
    -- Delete an existing highlight if it exists
    if mouseCircle then
        mouseCircle:delete()
        if mouseCircleTimer then
            mouseCircleTimer:stop()
        end
    end
    -- Get the current co-ordinates of the mouse pointer
    mousepoint = hs.mouse.get()
    -- Prepare a big red circle around the mouse pointer
    mouseCircle = hs.drawing.circle(hs.geometry.rect(mousepoint.x-40, mousepoint.y-40, 80, 80))
    mouseCircle:setStrokeColor({["red"]=1,["blue"]=0,["green"]=0,["alpha"]=1})
    mouseCircle:setFill(false)
    mouseCircle:setStrokeWidth(5)
    mouseCircle:show()

    -- Set a timer to delete the circle after 3 seconds
    mouseCircleTimer = hs.timer.doAfter(2, function() mouseCircle:delete() end)
end
hotkey.bind(mashshift, "M", mouseHighlight)

-- Window hints

hs.hints.hintChars = {"A", "S", "D", "F", "G", "H", "J","K", "L"}
hs.hints.showTitleThresh = 3

hotkey.bind(mash, "J", hints.windowHints)
hs.hotkey.bind(mash, "K", function() hints.windowHints(window.focusedWindow():application():allWindows()) end)
