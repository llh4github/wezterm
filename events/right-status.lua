local wezterm = require('wezterm')
local Cells = require('utils.cells')

local nf = wezterm.nerdfonts
local attr = Cells.attr

local M = {}

local ICON_DATE = nf.fa_calendar

---@type table<string, Cells.SegmentColors>
-- stylua: ignore
local colors = {
   date = { fg = '#fab387', bg = 'rgba(0, 0, 0, 0.4)' },
}

local cells = Cells:new()

cells
   :add_segment('date_icon', ICON_DATE .. '  ', colors.date, attr(attr.intensity('Bold')))
   :add_segment('date_text', '', colors.date, attr(attr.intensity('Bold')))

M.setup = function()
   wezterm.on('update-right-status', function(window, _pane)
      cells
         :update_segment_text('date_text', wezterm.strftime('%Y-%m-%d'))

      window:set_right_status(
         wezterm.format(
            cells:render({ 'date_icon', 'date_text' })
         )
      )
   end)
end

return M
