---@diagnostic disable-next-line: assign-type-mismatch
local wezterm = require 'wezterm' ---@type Wezterm

-- Set tab name to SSH host when connecting via smart_ssh
wezterm.on('smart_ssh.fuzzy_selector.selected', function(window, pane, id)
  window:active_tab():set_title(id)
end)
