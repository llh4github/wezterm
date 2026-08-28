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

-- 从本地覆盖文件取工作区定义，没有就用空表
local workspace_defs = local_config.workspaces or {}

-- 动态注册工作区快捷键
local options = config.options
for _, ws in ipairs(workspace_defs) do
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
