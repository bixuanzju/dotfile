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
grid.GRIDWIDTH = 2
grid.GRIDHEIGHT = 2

local goleft = {x = 0, y = 0, w = 1, h = 2}
local goright = {x = 1, y = 0, w = 1, h = 2}

hotkey.bind(mashshift, 'I', grid.maximizeWindow)
hotkey.bind(mashshift, 'H', gridset(goleft))
hotkey.bind(mashshift, 'L', gridset(goright))
hotkey.bind(mashshift, 'N', grid.pushWindowNextScreen)
-- hotkey.bind(mashshift, 'J', gridset(0, 0, 1.2, 2))


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
   setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end

hotkey.bind(mash, 'S', caffeineToggle)
