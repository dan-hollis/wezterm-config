---@diagnostic disable-next-line: assign-type-mismatch
local wezterm = require 'wezterm' ---@type Wezterm

local quota = wezterm.plugin.require('https://github.com/EdenGibson/wezterm-quota-limit')

---@param config Config
return function(config)
  quota.apply_to_config(config, {
    poll_interval_secs = 300,
    position = 'right',
    icons = {
      bolt = '⚡',
      week = '📅',
    },
  })
end
