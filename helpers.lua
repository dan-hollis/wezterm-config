local wezterm = require('wezterm')

local M = {}

---@param window Window
---@param id string
function M.set_tab_title(window, _, id)
  local mux_window = window:mux_window()
  local existing_tabs = {}
  for _, tab in ipairs(mux_window:tabs()) do
    existing_tabs[tab:tab_id()] = true
  end

  local attempts = 0
  local function apply_to_new_tab()
    for _, tab in ipairs(mux_window:tabs()) do
      if not existing_tabs[tab:tab_id()] then
        tab:set_title(id)
        return
      end
    end
    attempts = attempts + 1
    if attempts < 50 then
      wezterm.time.call_after(0.1, apply_to_new_tab)
    end
  end
  wezterm.time.call_after(0.1, apply_to_new_tab)
end

---@param window Window
---@param pane Pane
function M.copy_last_output(window, pane)
  local zones = pane:get_semantic_zones('Output')
  if not zones or #zones == 0 then
    return
  end

  for i = #zones, 1, -1 do
    local text = pane:get_text_from_semantic_zone(zones[i])
    if text and text ~= '' and text:match('%S') then
      window:copy_to_clipboard(text, 'ClipboardAndPrimarySelection')
      return
    end
  end
end

return M
