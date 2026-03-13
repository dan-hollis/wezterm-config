local M = {}

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
