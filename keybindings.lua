---@type Wezterm
local wezterm = require('wezterm')
local act = wezterm.action

local smart_ssh = wezterm.plugin.require("https://github.com/DavidRR-F/smart_ssh.wezterm")

local helpers = require('helpers')

local wez_tmux_keys = {
  -- Workspaces
  { key = '$',          mods = 'LEADER|SHIFT', desc = 'Rename current workspace' },
  { key = 's',          mods = 'LEADER|ALT',   desc = 'Interactive workspace switcher' },
  { key = '(',          mods = 'LEADER|SHIFT', desc = 'Switch to previous workspace' },
  { key = ')',          mods = 'LEADER|SHIFT', desc = 'Switch to next workspace' },
  -- Tabs
  { key = 'c',          mods = 'LEADER',       desc = 'Create new tab' },
  { key = '&',          mods = 'LEADER|SHIFT', desc = 'Close current tab' },
  { key = 'p',          mods = 'LEADER',       desc = 'Switch to previous tab' },
  { key = 'n',          mods = 'LEADER',       desc = 'Switch to next tab' },
  { key = 'l',          mods = 'LEADER',       desc = 'Switch to last active tab' },
  -- Panes
  { key = '%',          mods = 'LEADER|SHIFT', desc = 'Split pane horizontally' },
  { key = '"',          mods = 'LEADER|SHIFT', desc = 'Split pane vertically' },
  { key = '{',          mods = 'LEADER|SHIFT', desc = 'Rotate panes counter-clockwise' },
  { key = '}',          mods = 'LEADER|SHIFT', desc = 'Rotate panes clockwise' },
  { key = 'LeftArrow',  mods = 'LEADER',       desc = 'Navigate to left pane' },
  { key = 'DownArrow',  mods = 'LEADER',       desc = 'Navigate to pane below' },
  { key = 'UpArrow',    mods = 'LEADER',       desc = 'Navigate to pane above' },
  { key = 'RightArrow', mods = 'LEADER',       desc = 'Navigate to right pane' },
  { key = 'q',          mods = 'LEADER',       desc = 'Interactive pane selector' },
  { key = 'z',          mods = 'LEADER',       desc = 'Zoom/unzoom current pane' },
  { key = '!',          mods = 'LEADER|SHIFT', desc = 'Move pane to new tab' },
  { key = 'LeftArrow',  mods = 'LEADER|CTRL',  desc = 'Resize pane left' },
  { key = 'DownArrow',  mods = 'LEADER|CTRL',  desc = 'Resize pane down' },
  { key = 'UpArrow',    mods = 'LEADER|CTRL',  desc = 'Resize pane up' },
  { key = 'RightArrow', mods = 'LEADER|CTRL',  desc = 'Resize pane right' },
  { key = 'x',          mods = 'LEADER',       desc = 'Close current pane' },
  { key = ' ',          mods = 'LEADER',       desc = 'Quick select' },
  -- Copy mode & misc
  { key = '[',          mods = 'LEADER',       desc = 'Enter copy mode' },
  { key = ',',          mods = 'LEADER',       desc = 'Rename current tab' },
}

local smart_ssh_keys = {
  { key = 's', mods = 'LEADER|SHIFT', action = smart_ssh.tab(),    desc = 'Spawn ssh session in new tab' },
  { key = '5', mods = 'LEADER',       action = smart_ssh.hsplit(), desc = 'Spawn ssh session in horizontal window' },
  { key = '"', mods = 'LEADER',       action = smart_ssh.vsplit(), desc = 'Spawn ssh session in vertical window' },
}

local global_keys = {
  -- Clipboard
  { key = 'c',         mods = 'CTRL|SHIFT', action = act.CopyTo('Clipboard'),                              desc = 'Copy to clipboard' },
  { key = 'v',         mods = 'CTRL|SHIFT', action = act.PasteFrom('Clipboard'),                           desc = 'Paste from clipboard' },
  { key = 'Y',         mods = 'CTRL|SHIFT', action = wezterm.action_callback(helpers.copy_last_output),    desc = 'Copy last command output' },

  -- Tabs
  { key = 't',         mods = 'CTRL|SHIFT', action = act.SpawnCommandInNewTab { cwd = wezterm.home_dir, }, desc = 'New tab in home dir' },
  { key = 'g',         mods = 'CTRL|SHIFT', action = act.SpawnTab('CurrentPaneDomain'),                    desc = 'New tab in current dir' },
  { key = 'w',         mods = 'CTRL|SHIFT', action = act.CloseCurrentTab { confirm = true },               desc = 'Close current tab' },
  { key = 'w',         mods = 'SUPER',      action = act.CloseCurrentTab { confirm = true },               desc = 'Close current tab' },
  {
    key = 'E',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, _, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
    desc = 'Rename tab'
  },

  -- Tab switching (Super+N)
  { key = '1',         mods = 'SUPER',      action = act.ActivateTab(0),                                   desc = 'Switch to tab 1' },
  { key = '2',         mods = 'SUPER',      action = act.ActivateTab(1),                                   desc = 'Switch to tab 2' },
  { key = '3',         mods = 'SUPER',      action = act.ActivateTab(2),                                   desc = 'Switch to tab 3' },
  { key = '4',         mods = 'SUPER',      action = act.ActivateTab(3),                                   desc = 'Switch to tab 4' },
  { key = '5',         mods = 'SUPER',      action = act.ActivateTab(4),                                   desc = 'Switch to tab 5' },
  { key = '6',         mods = 'SUPER',      action = act.ActivateTab(5),                                   desc = 'Switch to tab 6' },
  { key = '7',         mods = 'SUPER',      action = act.ActivateTab(6),                                   desc = 'Switch to tab 7' },
  { key = '8',         mods = 'SUPER',      action = act.ActivateTab(7),                                   desc = 'Switch to tab 8' },
  { key = '9',         mods = 'SUPER',      action = act.ActivateTab(-1),                                  desc = 'Switch to last tab' },

  -- Scrollback
  { key = 'UpArrow',   mods = 'SHIFT',      action = act.ScrollToPrompt(-1),                               desc = 'Scroll to previous prompt' },
  { key = 'DownArrow', mods = 'SHIFT',      action = act.ScrollToPrompt(1),                                desc = 'Scroll to next prompt' },

  -- Font size
  { key = '=',         mods = 'CTRL',       action = act.IncreaseFontSize,                                 desc = 'Increase font size' },
  { key = '-',         mods = 'CTRL',       action = act.DecreaseFontSize,                                 desc = 'Decrease font size' },
  { key = '0',         mods = 'CTRL',       action = act.ResetFontSize,                                    desc = 'Reset font size' },

  -- Misc
  { key = 'r',         mods = 'SUPER',      action = act.ReloadConfiguration,                              desc = 'Reload configuration' },
  { key = 'P',         mods = 'CTRL|SHIFT', action = act.ActivateCommandPalette,                           desc = 'Activate command palette' },
  { key = 'L',         mods = 'CTRL|SHIFT', action = act.ShowDebugOverlay,                                 desc = 'Show debug overlay' },
}

---@param config Config
---@param cmdpicker CmdPicker
return function(config, cmdpicker)
  cmdpicker.register(wez_tmux_keys)
  cmdpicker.register({
    { key = config.leader.key, mods = 'LEADER|' .. config.leader.mods, desc = 'Send leader key' },
  })
  cmdpicker.add_keys(config, smart_ssh_keys)
  cmdpicker.add_keys(config, global_keys)
end