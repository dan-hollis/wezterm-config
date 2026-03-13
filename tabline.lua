---@type Wezterm
local wezterm = require('wezterm')

---@type TablineWez
local tabline = wezterm.plugin.require('https://github.com/michaelbrusegard/tabline.wez')

local helpers = require('helpers')

tabline.setup({
  options = {
    icons_enabled = true,
    theme = 'Nightfly (Gogh)',
    tabs_enabled = true,
    theme_overrides = {
      tab = {
        inactive_hover = { fg = '#858D99', bg = '#3B3B3B' }
      }
    },
    section_separators = {
      left = wezterm.nerdfonts.pl_left_hard_divider,
      right = wezterm.nerdfonts.pl_right_hard_divider,
    },
    component_separators = {
      left = wezterm.nerdfonts.pl_left_soft_divider,
      right = wezterm.nerdfonts.pl_right_soft_divider,
    },
    tab_separators = {
      left = wezterm.nerdfonts.pl_left_hard_divider,
      right = wezterm.nerdfonts.pl_right_hard_divider,
    },
  },
  sections = {
    tabline_a = { 'cpu' },
    tabline_b = { 'ram' },
    tabline_c = { ' ' },

    tab_active = {
      { 'index', padding = { left = 1, right = 1 } },
      { 'tab',   padding = { left = 0, right = 1 } },
    },

    tab_inactive = {
      { 'index', padding = { left = 1, right = 1 } },
      { 'tab',   padding = { left = 0, right = 1 } },
    },

    tabline_x = {},
    tabline_y = {},
    tabline_z = {},
  },
  extensions = {
    {
      'smart_ssh',
      events = {
        show = 'smart_ssh.fuzzy_selector.selected',
        callback = helpers.set_tab_title
      }
    }
  }
})
