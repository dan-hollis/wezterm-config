---@type Wezterm
local wezterm = require('wezterm')

---@type SWS
local workspace_switcher = wezterm.plugin.require('https://github.com/MLFlexer/smart_workspace_switcher.wezterm')
---@type Resurrect
local resurrect = wezterm.plugin.require('https://github.com/MLFlexer/resurrect.wezterm')

resurrect.state_manager.periodic_save({
  interval_seconds = 15 * 60,
  save_workspaces = true,
  save_windows = true,
  save_tabs = true,
})

resurrect.state_manager.set_encryption({
  enable = true,
  method = 'age',
  private_key = wezterm.config_dir .. '/.age/key.txt',
  public_key = 'age14z9ke78gf97609xn4dc2h8z3nhd085gysnvgwdlm6rd3kesr754s4e3mh7',
})

-- Restore state when a workspace is created via the switcher
wezterm.on('smart_workspace_switcher.workspace_switcher.created', function(window, path, label)
  resurrect.workspace_state.restore_workspace(resurrect.state_manager.load_state(label, 'workspace'), {
    window = window,
    relative = true,
    restore_text = true,
    on_pane_restore = resurrect.tab_state.default_on_pane_restore,
  })
end)

-- Save state when a workspace is selected via the switcher
wezterm.on('smart_workspace_switcher.workspace_switcher.selected', function(window, path, label)
  resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
end)

---@param config Config
---@param cmdpicker CmdPicker
return function(config, cmdpicker)
  cmdpicker.add_keys(config, {
    { key = 'b', mods = 'LEADER|SHIFT', action = workspace_switcher.switch_workspace(),         desc = 'Switch workspace' },
    { key = 'B', mods = 'LEADER',       action = workspace_switcher.switch_to_prev_workspace(), desc = 'Switch to previous workspace' },
    {
      key = 'w',
      mods = 'ALT',
      action = wezterm.action_callback(function(win, pane)
        resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
      end),
      desc = 'Save workspace state',
    },
    {
      key = 'W',
      mods = 'ALT',
      action = resurrect.window_state.save_window_action(),
      desc = 'Save window state',
    },
    {
      key = 'T',
      mods = 'ALT',
      action = resurrect.tab_state.save_tab_action(),
      desc = 'Save tab state',
    },
    {
      key = 's',
      mods = 'ALT',
      action = wezterm.action_callback(function(win, pane)
        resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
        resurrect.window_state.save_window_action()
      end),
      desc = 'Save workspace and window state',
    },
    {
      key = 'r',
      mods = 'ALT',
      action = wezterm.action_callback(function(win, pane)
        resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id, label)
          local type = string.match(id, '^([^/]+)') -- match before '/'
          id = string.match(id, '([^/]+)$')         -- match after '/'
          id = string.match(id, '(.+)%..+$')        -- remove file extension
          local opts = {
            relative = true,
            restore_text = true,
            on_pane_restore = resurrect.tab_state.default_on_pane_restore,
          }
          if type == 'workspace' then
            local state = resurrect.state_manager.load_state(id, 'workspace')
            resurrect.workspace_state.restore_workspace(state, opts)
          elseif type == 'window' then
            local state = resurrect.state_manager.load_state(id, 'window')
            resurrect.window_state.restore_window(pane:window(), state, opts)
          elseif type == 'tab' then
            local state = resurrect.state_manager.load_state(id, 'tab')
            resurrect.tab_state.restore_tab(pane:tab(), state, opts)
          end
        end)
      end),
      desc = 'Restore saved state',
    },
  })
end
