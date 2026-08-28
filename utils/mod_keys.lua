local platform = require('utils.platform')

local mod = {}

if platform.is_mac then
  mod.SUPER = 'SUPER'
  mod.SUPER_REV = 'SUPER|CTRL'
elseif platform.is_win or platform.is_linux then
  mod.SUPER = 'ALT' -- to not conflict with Windows key shortcuts
  mod.SUPER_REV = 'ALT|CTRL'
end

return mod
