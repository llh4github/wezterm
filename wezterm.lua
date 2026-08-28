local Config = require('config')
local wezterm = require('wezterm')
local act = wezterm.action

require('utils.backdrops')
   :set_files()
   -- :set_focus('#000000')
   :random()

require('events.right-status').setup()
require('events.left-status').setup()
require('events.tab-title').setup()
require('events.new-tab-button').setup()

local mux = wezterm.mux

wezterm.on('gui-startup', function(cmd)
  local _, _, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

local config = Config:init()
   :append(require('config.appearance'))
   :append(require('config.bindings'))
   :append(require('config.fonts'))
   :append(require('config.general'))
   :append(require('config.launch'))

-- 动态加载本地覆盖文件（不存在也不报错）
local local_config = {}
local ok, loaded = pcall(dofile, wezterm.config_dir .. '/workspace_local.lua')
if ok and loaded then
  local_config = loaded
end

-- 动态加载启动本地覆盖文件（不存在也不报错）
local ok2, loaded2 = pcall(dofile, wezterm.config_dir .. '/launch_local.lua')
if ok2 and loaded2 then
  for k, v in pairs(loaded2) do
    local_config[k] = v
  end
end

local options = config.options

-- 从本地覆盖中提取工作区定义（不是合法 Config 字段，不能合并进 options）
local local_workspaces = local_config.workspaces or {}

-- 把本地覆盖合回最终配置
local append_fields = { launch_menu = true, keys = true }
for k, v in pairs(local_config) do
  if k == 'workspaces' then
    -- 跳过，单独处理
  elseif type(options[k]) == 'table' and type(v) == 'table' then
    if append_fields[k] then
      for _, nv in ipairs(v) do
        table.insert(options[k], nv)
      end
    else
      for nk, nv in pairs(v) do
        options[k][nk] = nv
      end
    end
  else
    options[k] = v
  end
end

for _, ws in ipairs(local_workspaces) do
  table.insert(options.keys, {
    key = ws.key,
    mods = 'LEADER',
    action = act.SwitchToWorkspace {
      name = ws.name,
      spawn = { cwd = ws.cwd },
    },
  })
end

return options
