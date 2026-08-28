local wezterm = require('wezterm')
local Cells = require('utils.cells')

local nf = wezterm.nerdfonts
local attr = Cells.attr

local M = {}

local ICON_DATE = nf.fa_calendar
local ICON_WORKSPACE = nf.fa_desktop

---@type table<string, Cells.SegmentColors>
-- stylua: ignore
local colors = {
   date = { fg = '#fab387', bg = 'rgba(0, 0, 0, 0.4)' },
   workspace = { fg = '#a6e3a1', bg = 'rgba(0, 0, 0, 0.4)' },
}

local cells = Cells:new()

cells
   :add_segment('workspace_icon', '', colors.workspace, attr(attr.intensity('Bold')))
   :add_segment('workspace_text', '', colors.workspace, attr(attr.intensity('Bold')))
   :add_segment('date_icon', '  ' .. ICON_DATE .. '  ', colors.date, attr(attr.intensity('Bold')))
   :add_segment('date_text', '', colors.date, attr(attr.intensity('Bold')))

M.setup = function()
   wezterm.on('update-right-status', function(window, _pane)
      local workspace = window:active_workspace()

      if workspace == 'default' then
         cells
            :update_segment_text('workspace_icon', '')
            :update_segment_text('workspace_text', '')
      else
         cells
            :update_segment_text('workspace_icon', ICON_WORKSPACE .. ' ')
            :update_segment_text('workspace_text', workspace)
      end

      cells
         :update_segment_text('date_text', wezterm.strftime('%Y-%m-%d'))

      window:set_right_status(
         wezterm.format(
            cells:render({ 'workspace_icon', 'workspace_text', 'date_icon', 'date_text' })
         )
      )
   end)
end

return M
