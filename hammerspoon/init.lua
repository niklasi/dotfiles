KEYBOARD_SWE = 'Swedish'
KEYBOARD_ENG = 'ABC'

-- These constants are used in the code below to allow hotkeys to be
-- assigned using side-specific modifier keys.
ORDERED_KEY_CODES = { 58, 61, 55, 54, 59, 62, 56, 60 }
KEY_CODE_TO_KEY_STR = {
  -- [37] = 'leftArrow',
  -- [38] = 'upArrow',
  -- [39] = 'rightArrow',
  -- [40] = 'downArrow',
  [58] = 'leftAlt',
  [61] = 'rightAlt',
  [55] = 'leftCmd',
  [54] = 'rightCmd',
  [59] = 'leftCtrl',
  [62] = 'rightCtrl',
  [56] = 'leftShift',
  [60] = 'rightShift',
}
KEY_CODE_TO_MOD_TYPE = {
  [58] = 'alt',
  [61] = 'alt',
  [55] = 'cmd',
  [54] = 'cmd',
  [59] = 'ctrl',
  [62] = 'ctrl',
  [56] = 'shift',
  [60] = 'shift',
}
KEY_CODE_TO_SIBLING_KEY_CODE = {
  [58] = 61,
  [61] = 58,
  [55] = 54,
  [54] = 55,
  [59] = 62,
  [62] = 59,
  [56] = 60,
  [60] = 56,
}
-- Global appWatcher to prevent gc
appWatcher = hs.application.watcher
  .new(function(appName, eventType, appInstance)
    if eventType == hs.application.watcher.activated then
      -- use english keyboard as default
      hs.keycodes.setLayout(KEYBOARD_ENG)
      if appName == 'Messages' then
        hs.keycodes.setLayout(KEYBOARD_SWE)
      end
      if appName == 'Slack' then
        local title = appInstance:mainWindow():title()
        if string.find(title, 'NWT') then
          hs.keycodes.setLayout(KEYBOARD_ENG)
        else
          hs.keycodes.setLayout(KEYBOARD_SWE)
        end
      end
    end
  end)
  :start()

local hyper = { 'leftCmd', 'leftAlt', 'leftCtrl', 'leftShift' }
-- local yabai = hs.execute('which yabai', true)
-- yabai = string.gsub(yabai, '\n', '')
local yabai = '/opt/homebrew/bin/yabai'

local moveActiveWindowToSpace = function(spaceName)
  hs.execute(yabai .. ' -m window --space ' .. spaceName, false)
end

local focusSpace = function(spaceName)
  hs.execute(yabai .. ' -m space --focus ' .. spaceName, false)
end

local windowMapping = {}
windowMapping['1'] = 'misc'
windowMapping['2'] = 'terminal'
windowMapping['3'] = 'slack'
windowMapping['4'] = 'browser-work'
windowMapping['5'] = 'browser-private'
windowMapping['6'] = 'six'
windowMapping['9'] = 'remote-desktop'

hs.hotkey.bind(hyper, 'Left', function()
  -- hs.execute(yabai .. ' -m window --space prev', false)
  hs.execute(yabai .. ' -m space --focus prev', false)
end)

hs.hotkey.bind(hyper, 'Right', function()
  -- hs.execute(yabai .. ' -m window --space next', false)
  hs.execute(yabai .. ' -m space --focus next', false)
end)

for k, v in pairs(windowMapping) do
  hs.hotkey.bind(hyper, k, nil, function()
    focusSpace(v)
  end, function()
    moveActiveWindowToSpace(v)
    focusSpace(v)
  end)
end

hs.hotkey.bind(hyper, 'v', function()
  local str = hs.execute(yabai .. ' -m query --displays')
  local info = hs.json.decode(str)

  for _, value in pairs(info) do
    hs.alert(value.index .. ' ' .. hs.inspect(value.spaces))
  end
end)

hs.hotkey.bind(hyper, '=', function()
  hs.execute(yabai .. ' -m space --balance', false)
end)

hs.hotkey.bind(hyper, 'a', function()
  hs.execute(yabai .. ' -m window --grid 1:2:0:0:1:1', false)
end)

hs.hotkey.bind(hyper, 's', function()
  hs.execute(yabai .. ' -m window --grid 1:2:1:1:0:0', false)
end)

hs.hotkey.bind(hyper, 'd', function()
  hs.execute(yabai .. ' -m window --toggle zoom-parent', false)
end)

-- hs.hotkey.bin(hyper, "d", function()
--   hs.execute(yabai.." -m window --focus recent", false)
-- end)

-- Fullscreen
hs.hotkey.bind(hyper, 'f', function()
  hs.execute(yabai .. ' -m window --toggle zoom-fullscreen', false)
end)

hs.hotkey.bind(hyper, 'r', function()
  hs.execute(yabai .. ' -m space --rotate 90', false)
end)
hs.hotkey.bind(hyper, 'w', function()
  hs.execute(yabai .. ' -m space --mirror y-axis', false)
end)
-- hs.hotkey.bind(hyper, "s", function()
--   hs.execute(yabai.." -m display --focus next", false)
-- end)

hs.hotkey.bind(hyper, 'b', function() end)
-- Move window
hs.hotkey.bind({ 'ctrl', 'cmd' }, 'j', function()
  hs.execute(yabai .. ' -m window --focus south', false)
end)
hs.hotkey.bind({ 'ctrl', 'cmd' }, 'k', function()
  hs.execute(yabai .. ' -m window --focus north', false)
end)
hs.hotkey.bind({ 'ctrl', 'cmd' }, 'h', function()
  hs.execute(yabai .. ' -m window --focus west', false)
end)
hs.hotkey.bind({ 'ctrl', 'cmd' }, 'l', function()
  hs.execute(yabai .. ' -m window --focus east', false)
end)
