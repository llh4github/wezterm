# Repository Guidelines

## 项目概述

WezTerm 个人配置仓库。以 Lua 5.4/JIT 为运行时，通过 WezTerm 内嵌 Lua 配置系统实现模块化终端定制。核心能力：平台自适应键位/Shell/GPU 后端选择、背景图片切换、自定义左右状态栏、标签页标题渲染、工作区热加载。

**用中文回答**。

## 架构与数据流

```
wezterm.lua
  ├─ Config:init():append(config.*)        ← 分片式配置组装
  ├─ pcall(dofile, workspace_local.lua)    ← 工作区本地覆盖
  ├─ pcall(dofile, launch_local.lua)       ← 启动本地覆盖
  └─ return options                        ← WezTerm 消费

数据流：utils.platform → 平台检测 → config/launch 选择默认 shell
     → utils.gpu_adapter 选最优 GPU → colors.custom 注入配色
     → utils.backdrops 加载背景图 → events/* 注册 UI 事件
```

关键模式：
- **链式配置组装**：`Config:init():append(a):append(b)`，合并逻辑在 `config/init.lua:18`
- **平台适配**：`utils/platform.lua` 一次检测，各模块通过 `is_win/is_mac/is_linux` 分支
- **本地覆盖优先**：`workspace_local.lua` + `launch_local.lua` 通过 `pcall(dofile)` 无侵入热加载，缺失不报错
- **事件驱动 UI**：`events/*.setup()` 注册 `wezterm.on(...)`，状态栏/标签页标题/新标签按钮均由此驱动

## 关键目录

| 目录/文件 | 用途 |
|---|---|
| `wezterm.lua` | 总入口，组装配置并加载本地覆盖 |
| `config/init.lua` | `Config` 类，链式合并配置分片 |
| `config/general.lua` | 通用行为：自动重载、超链接规则、滚动条 |
| `config/appearance.lua` | GPU/WebGpu 后端、窗口装饰、标签栏、光标 |
| `config/bindings.lua` | 全部快捷键 + key tables + 鼠标绑定 |
| `config/fonts.lua` | 字体族/大小/Freetype 参数 |
| `config/launch.lua` | 平台相关默认 shell + 启动菜单 |
| `config/domains.lua` | SSH/WSL/Unix 域定义（目前为空，按需填充） |
| `utils/platform.lua` | 平台检测，导出 `is_win/is_mac/is_linux` |
| `utils/backdrops.lua` | 背景图片选择器/随机/循环/聚焦模式 |
| `utils/gpu_adapter.lua` | GPU 后端自动选择（Dx12/Vulkan/Metal/OpenGL 优先级） |
| `utils/cells.lua` | `wezterm.format` 片段构造器，链式 API |
| `utils/math.lua` | clamp/round 工具 |
| `colors/custom.lua` | Catppuccin Mocha 变体配色 + tab bar 配色 |
| `events/*.lua` | 左右状态栏、标签页标题、新标签按钮事件 |
| `backdrops/` | 背景图片资源 |

## 开发命令

此项目为 WezTerm Lua 配置，无构建/测试步骤。验证方式为启动 WezTerm 观察效果。

| 目的 | 命令 |
|---|---|
| 启动 WezTerm | `wezterm`（配置自动热重载） |
| 格式化 | `stylua .` |
| Lint | `luacheck .` |
| CI（lint） | 见 `.github/workflows/lint.yml` |
| 类型检查/LSP | 使用支持 Lua 的编辑器（Lua Language Server，参考 `.luarc.json`） |

> **注意**：`utils/backdrops.lua:44` 调用了 `wezterm.glob`，必须在 `wezterm.lua` 顶层调用，否则子进程 coroutine 会报错。

## 代码约定

- **Lua 版本**：LuaJIT / 5.4（WezTerm 内嵌），`.luarc.json` 声明 `runtime.version = "5.4"`
- **缩进**：StyLua  enforced — 空格 3 格，单行最大 150 字符
- **风格**：小写蛇形命名（`local function`, `local M = {}`）；模块导出统一为 `return M` 或 `return Class:init()`
- **OOP**：表 + `__index` 元表，链式方法返回 `self`（参考 `Config:append`、`BackDrops:cycle_forward`）
- **类型注解**：使用 `---@type` / `---@class` / `---@param`（Lua Language Server），关键数据结构均有注解
- **错误处理**：本地覆盖使用 `pcall(dofile, ...)` 容错；工具函数用 `assert`/`error` 做前置校验
- **平台分支**：统一在 `utils/platform.lua` 检测，各模块通过 `if platform.is_win then ...` 分支，不散落 `wezterm.target_triple` 检测
- **StyLua 忽略**：大型键位表/颜色表使用 `-- stylua: ignore` 块注释避免格式化破坏可读性

## 重要文件

| 文件 | 角色 |
|---|---|
| `wezterm.lua` | 总入口，唯一 WezTerm 消费点 |
| `config/init.lua` | 配置合并核心 |
| `config/bindings.lua` | 键位定义，含 key tables |
| `utils/backdrops.lua` | 背景图控制器，含 `set_files()` 生命周期约束 |
| `utils/gpu_adapter.lua` | GPU 选择策略，可手动/自动 |
| `utils/cells.lua` | 状态栏片段渲染引擎 |
| `.stylua.toml` | 格式化配置 |
| `.luacheckrc` | Lint 配置 |
| `.luarc.json` | LSP 配置 |
| `workspace_local.lua` | 本地工作区定义（gitignore 外，可个性化） |
| `launch_local.lua` | 本地启动配置（gitignore 外，可个性化） |

## 运行时与工具链偏好

- **运行时**：WezTerm 内嵌 LuaJIT/Lua 5.4，非独立 Node/Bun 项目
- **包管理**：N/A（无外部 Lua 依赖，仅 `require` 内置模块）
- **LSP**：Lua Language Server（sumneko/lua-language-server），参考 `.luarc.json`
- **格式化**：StyLua，版本约束见 `.stylua.toml`
- **Lint**：Luacheck，标准库白名单 + `files['utils/backdrops.lua']` 行长度忽略

## 测试与 QA

- 无单元测试框架，无 CI 测试步骤
- 唯一 CI 流水线为 lint：`.github/workflows/lint.yml`
- 验证方式：启动 WezTerm → 观察配置加载日志（`wezterm.show_debug_overlay`，F12）
- 本地覆盖文件缺失时静默跳过，不会中断配置加载
