local application = require "mjolnir.application"
local window = require "mjolnir.window"
local hotkey = require "mjolnir.hotkey"
local fnutils = require "mjolnir.fnutils"
local geometry = require "mjolnir.geometry"
local alert = require "mjolnir.alert"
local spotify = require "mjolnir.lb.spotify"
local caffeinate = require "mjolnir.cmsj.caffeinate"

local grid = {}
grid.BORDER = 2

function toFullscreen()
   local win = window.focusedwindow()
   if not win then return
   end

   local screenframe = getScreenframe(win)
   alert.show("Fullscreen entered!")
   win:setframe(screenframe)
end

function toLefthalf()
   local win = window.focusedwindow()
   if not win then return end

   local screenframe = getScreenframe(win)
   local newframe = geometry.rect(
      screenframe.x,
      screenframe.y,
      screenframe.w / 2 - grid.BORDER,
      screenframe.h)

   win:setframe(newframe)
end

function toRighthalf()
   local win = window.focusedwindow()
   if not win then return end

   local screenframe = getScreenframe(win)
   local newframe = geometry.rect(
      screenframe.x + screenframe.w / 2 + grid.BORDER,
      screenframe.y,
      screenframe.w / 2 - grid.BORDER,
      screenframe.h)

   win:setframe(newframe)
end

function toMostRight()
   local win = window.focusedwindow()
   if not win then return end

   local screenframe = getScreenframe(win)
   local newframe = geometry.rect(
      screenframe.x + 2 * screenframe.w / 5,
      screenframe.y,
      3 * screenframe.w / 5,
      screenframe.h)

   win:setframe(newframe)
end

function toMostLeft()
   local win = window.focusedwindow()
   if not win then return end

   local screenframe = getScreenframe(win)
   local newframe = geometry.rect(
      screenframe.x,
      screenframe.y,
      3 * screenframe.w / 5,
      screenframe.h)

   win:setframe(newframe)
end

function getScreenframe(win)
   return win:screen():frame()
end

local mash = {"shift", "alt", "ctrl"}
local mashshift = {"cmd", "ctrl", "shift"}

hotkey.bind(mashshift, 'I', toFullscreen)
hotkey.bind(mashshift, 'H', toLefthalf)
hotkey.bind(mashshift, 'L', toRighthalf)
hotkey.bind(mashshift, 'J', toMostLeft)
hotkey.bind(mashshift, 'K', toMostRight)

-- For controlling Spotify
hotkey.bind(mashshift, 'S', spotify.displayCurrentTrack)
hotkey.bind(mashshift, 'P', spotify.pause)
hotkey.bind(mashshift, 'N', spotify.next)
hotkey.bind(mashshift, 'M', spotify.previous)

-- Caffeinate

function makeSleep()
   local flag = caffeinate.toggle("DisplayIdle")
   if flag then alert.show("Coffee on!")
   else alert.show("Coffee off")
   end
end

hotkey.bind(mash, 'S', makeSleep)
