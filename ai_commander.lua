---@diagnostic disable-next-line: assign-type-mismatch
local wezterm = require 'wezterm' ---@type Wezterm

local constants = require('constants')

local ai_plugin = wezterm.plugin.require('https://github.com/dimao/ai-commander.wezterm')

---@param config Config
---@param cmdpicker table
return function(config, cmdpicker)
  ai_plugin.apply_to_config(config, {
    provider = 'anthropic',
    api_key = {
      anthropic = constants.ANTHROPIC_API_KEY,
      openai = constants.OPENAI_API_KEY,
    },
    model = {
      anthropic = 'claude-3-5-sonnet-20241022',
      openai = 'gpt-4o'
    },
    api_url = {
      anthropic = constants.ANTHROPIC_API_URL,
      openai = constants.OPENAI_API_URL
    },
    max_tokens = 4000,
    temperature = 0.1,
    command_count = 5,
    max_history = 100
  })

  cmdpicker.add_keys(config, {
    {
      key = 'Backspace',
      mods = 'ALT',
      action = wezterm.action.SendKey { key = 'w', mods = 'CTRL' },
      desc = 'AI Commander: Word Deletion',
    },
    {
      key = 'H',
      mods = 'ALT|SHIFT',
      action = wezterm.action_callback(function(window, pane)
        ai_plugin.show_history(window, pane)
      end),
      desc = 'AI Commander: Show history',
    },
    {
      key = 'X',
      mods = 'ALT|SHIFT',
      action = wezterm.action_callback(function(window, pane)
        ai_plugin.show_prompt(window, pane)
      end),
      desc = 'AI Commander: Generate commands',
    },
  })
end
