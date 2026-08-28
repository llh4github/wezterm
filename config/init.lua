local wezterm = require('wezterm')

---@class Config
---@field options table
local Config = {}
Config.__index = Config

---Initialize Config
---@return Config
function Config:init()
   local config = setmetatable({ options = {} }, self)
   return config
end

---Append to `Config.options`
---@param new_options table new options to append
---@return Config
function Config:append(new_options)
  for k, v in pairs(new_options) do
     local existing = self.options[k]
     if existing ~= nil then
        if type(existing) == 'table' and type(v) == 'table' then
           local merged = {}
           for ek, ev in pairs(existing) do
              merged[ek] = ev
           end
           for nk, nv in pairs(v) do
              merged[nk] = nv
           end
           self.options[k] = merged
        else
           wezterm.log_warn(
              'Duplicate config option detected; keeping original: ',
              { key = k }
           )
        end
     else
        self.options[k] = v
     end
  end
  return self
end

return Config
