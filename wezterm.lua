---@type Wezterm
local wezterm = require('wezterm')
---@type Config
local config = wezterm.config_builder()

---@type CmdPicker
local cmdpicker = wezterm.plugin.require('https://github.com/abidibo/wezterm-cmdpicker')
local smart_ssh = wezterm.plugin.require("https://github.com/DavidRR-F/smart_ssh.wezterm")
---@type WezTmux
local tmux = wezterm.plugin.require('https://github.com/sei40kr/wez-tmux')

-- Input bindings
config.mouse_bindings = require('mousebindings')
config.leader = { key = 'Space', mods = 'CTRL' }
require('keybindings')(config, cmdpicker)

-- Event handlers
--require('events')

-- Plugin setup
smart_ssh.apply_to_config(config)
tmux.apply_to_config(config, {})
require('tabline')
require('session')(config, cmdpicker)
local presentation = wezterm.plugin.require('https://gitlab.com/xarvex/presentation.wez') ---@type PresentationWez
presentation.apply_to_config(config)
--require('ai_commander')(config, cmdpicker)
--require('quota')(config)

-- Appearance
config.enable_scroll_bar = true
config.color_scheme = 'Nightfly (Gogh)'
config.window_background_opacity = 1.0
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = true
config.warn_about_missing_glyphs = false
config.hide_mouse_cursor_when_typing = false
config.audible_bell = 'Disabled'
config.disable_default_key_bindings = true

-- apply cmdpicker after all keybindings registered
cmdpicker.apply_to_config(config, {
  key = 'r',
  include_defaults = false,
})

return config
