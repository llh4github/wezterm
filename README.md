<h2 align="center">My WezTerm 配置</h2>

<p align="center">
  <a href="https://github.com/KevinSilvester/wezterm-config/stargazers">
    <img alt="Stargazers" src="https://img.shields.io/github/stars/KevinSilvester/wezterm-config?style=for-the-badge&logo=starship&color=C9CBFF&logoColor=D9E0EE&labelColor=302D41">
  </a>
  <a href="https://github.com/KevinSilvester/wezterm-config/issues">
    <img alt="Issues" src="https://img.shields.io/github/issues/KevinSilvester/wezterm-config?style=for-the-badge&logo=gitbook&color=B5E8E0&logoColor=D9E0EE&labelColor=302D41">
  </a>
  <a href="https://github.com/KevinSilvester/wezterm-config/actions/workflows/lint.yml">
    <img alt="Build" src="https://img.shields.io/github/actions/workflow/status/KevinSilvester/wezterm-config/lint.yml?&style=for-the-badge&logo=githubactions&label=CI&color=A6E3A1&logoColor=D9E0EE&labelColor=302D41">
  </a>
</p>

![screenshot](./.github/screenshots/wezterm.gif)

---

### 功能特性

- [**背景图片选择器**](https://github.com/KevinSilvester/wezterm-config/blob/master/utils/backdrops.lua)：

  - 循环切换图片
  - 模糊搜索图片
  - 切换背景图片显示/隐藏

  > 详见：[快捷键绑定](#背景图片)

- [**GPU 适配器选择器**](https://github.com/KevinSilvester/wezterm-config/blob/master/utils/gpu_adapter.lua)：

  > :bulb: 仅当 [`front_end`](https://github.com/KevinSilvester/wezterm-config/blob/master/config/appearance.lua#L8) 选项设置为 `WebGpu` 时生效。

  一个小工具，用于选择适合你机器的最佳 GPU + 适配器（图形 API）组合。

  GPU + 适配器组合根据以下标准选择：

  1.  <details>
      <summary>可用的最佳 GPU</summary>

      `Discrete` > `Integrated` > `Other`（针对 `wgpu` 在独立 GPU 上的 OpenGl 实现）> `Cpu`
      </details>

  2.  <details>
      <summary>可用的最佳图形 API（基于我非常科学的在 Neovim 中滚动大日志文件的测试 😁）</summary>

      > :bulb:<br>
      > 可用的图形 API 选项因操作系统而异。<br>
      > 这些选项对应于 `wgpu` crate（在 `WebGpu` 模式下驱动 WezTerm GUI）<br>
      > 当前已实现支持的 API。<br>
      > 详见：<https://github.com/gfx-rs/wgpu#supported-platforms>

      - Windows：`Dx12` > `Vulkan` > `OpenGl`
      - Linux：`Vulkan` > `OpenGl`
      - Mac：`Metal`

      </details>

---

### 快速开始

- ##### 系统要求：

  - <details>
      <summary><b>WezTerm</b></summary>

    最低版本：`20240127-113634-bbcac864`<br>
    推荐版本：[`Nightly`](https://github.com/wez/wezterm/releases/nightly)

    [官方安装页面](https://wezfurlong.org/wezterm/installation.html)

    **Windows**

    - <details>
      <summary>安装稳定版</summary>

      - 使用 Scoop 安装（非便携版）

        ```sh
        scoop bucket add extras
        scoop install wezterm
        ```

      - 使用 Scoop 安装（便携版）

        ```sh
        scoop bucket add k https://github.com/KevinSilvester/scoop-bucket
        scoop install k/wezterm
        ```

      - 使用 winget 安装

        ```sh
        winget install wez.wezterm
        ```

      - 使用 choco 安装

        ```sh
        choco install wezterm -y
        ```
      </details>

    - <details>
      <summary>安装 Nightly 版</summary>

      - 使用 Scoop 安装（非便携版）

        ```sh
        scoop bucket add versions
        scoop install wezterm-nightly
        ```

      - 使用 Scoop 安装（便携版）

        ```sh
        scoop bucket add k https://github.com/KevinSilvester/scoop-bucket
        scoop install k/wezterm-nightly
        ```
      </details>

    > :bulb:<br>
    > 非便携版安装中 Toast 通知无法使用。<br>
    > 详见 <https://github.com/wez/wezterm/issues/5166>

    ---

    **MacOS**

    - <details>
      <summary>安装稳定版</summary>

      - 使用 Homebrew 安装

        ```sh
        brew install --cask wezterm
        ```

      - 使用 MacPort 安装

        ```sh
        sudo port selfupdate
        sudo port install wezterm
        ```
      </details>

    - <details>
      <summary>安装 Nightly 版</summary>

      - 使用 Homebrew 安装

        ```sh
        brew install --cask wezterm@nightly
        ```

      - 使用 Homebrew 升级

        ```sh
        brew install --cask wezterm@nightly --no-quarantine --greedy-latest
        ```
      </details>

    ---

    **Linux**

    请参考 Linux 安装页面。<br>
    <https://wezfurlong.org/wezterm/install/linux.html>

    </details>

  - <details>
    <summary>JetBrainsMono Nerd Font</summary>

    在 MacOS 上使用 Homebrew 安装：

    ```sh
    brew tap homebrew/cask-fonts
    brew install font-jetbrains-mono-nerd-font
    ```

    在 Windows 上使用 Scoop 安装：

    ```sh
    scoop bucket add nerd-fonts
    scoop install JetBrainsMono-NF
    ```

    > 更多信息：
    >
    > - <https://www.nerdfonts.com/#home>
    > - <https://github.com/ryanoasis/nerd-fonts?#font-installation>
    </details>

&nbsp;

- ##### 安装步骤：

  ```sh
      # 在 Unix 系统上
      git clone https://github.com/llh4github/wezterm-config.git ~/.config/wezterm

      # 在 Windows 系统上
      git clone https://github.com/llh4github/wezterm-config.git %USERPROFILE%\.config\wezterm
  ```

&nbsp;

- ##### 你可能想要修改的配置：

  - [./config/domains.lua](./config/domains.lua) 用于自定义 SSH/WSL 域
  - [./config/launch.lua](./config/launch.lua) 用于设置首选 Shell 及其路径

---

### 所有快捷键绑定

大多数快捷键围绕 <kbd>SUPER</kbd> 和 <kbd>SUPER_REV</kbd>（Super 反转）键设计。<br>

- 在 MacOS 上：
  - <kbd>SUPER</kbd> ⇨ <kbd>Super</kbd>
  - <kbd>SUPER_REV</kbd> ⇨ <kbd>Super</kbd>+<kbd>Ctrl</kbd>
- 在 Windows 和 Linux 上
  - <kbd>SUPER</kbd> ⇨ <kbd>Alt</kbd>
  - <kbd>SUPER_REV</kbd> ⇨ <kbd>Alt</kbd>+<kbd>Ctrl</kbd>

> 为了避免在不同操作系统之间切换时产生混淆，以及与操作系统内置快捷键冲突。

- 在所有平台上：<kbd>LEADER</kbd> ⇨ <kbd>SUPER_REV</kbd>+<kbd>Space</kbd>

#### 杂项/实用

| 快捷键                              | 动作                                      |
| ----------------------------------- | ----------------------------------------- |
| <kbd>SUPER_REV</kbd>  + <kbd>c</kbd>                     | `ActivateCopyMode`（激活复制模式）                          |
| <kbd>SUPER</kbd>  + <kbd>p</kbd>                    | `ActivateCommandPalette`（激活命令面板）                    |
| <kbd>SUPER</kbd>  + <kbd>s</kbd>                    | `ShowLauncher`（显示启动器）                              |
| <kbd>F4</kbd>                     | `ShowLauncher` <sub>(仅标签页)</sub>       |
| <kbd>F5</kbd>                     | `ShowLauncher` <sub>(仅工作区)</sub> |
| <kbd>F11</kbd>                    | `ToggleFullScreen`（切换全屏）                          |
| <kbd>F12</kbd>                    | `ShowDebugOverlay`（显示调试覆盖层）                          |
| <kbd>SUPER</kbd>+<kbd>f</kbd>     | 搜索文本                                 |
| <kbd>SUPER_REV</kbd>+<kbd>u</kbd> | 打开 URL                                    |

&nbsp;

#### 复制+粘贴

| 快捷键                                          | 动作               |
| --------------------------------------------- | -------------------- |
| <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>c</kbd> | 复制到剪贴板    |
| <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>v</kbd> | 从剪贴板粘贴 |

&nbsp;

#### 光标移动

| 快捷键                                   | 动作                                                     |
| -------------------------------------- | ---------------------------------------------------------- |
| <kbd>SUPER</kbd>+<kbd>LeftArrow</kbd>  | 移动光标到行首                                  |
| <kbd>SUPER</kbd>+<kbd>RightArrow</kbd> | 移动光标到行尾                                    |
| <kbd>SUPER</kbd>+<kbd>Backspace</kbd>  | 清空当前行 <sub>(在 PowerShell 或 cmd 中无效)</sub> |

&nbsp;

#### 标签页

##### 标签页：新建+关闭

| 快捷键                              | 动作                                |
| --------------------------------- | ------------------------------------- |
| <kbd>SUPER</kbd>+<kbd>t</kbd>     | `SpawnTab` <sub>(默认域)</sub> |
| <kbd>SUPER_REV</kbd>+<kbd>f</kbd> | `SpawnTab` <sub>(WSL:Ubuntu)</sub>    |
| <kbd>SUPER_REV</kbd>+<kbd>w</kbd> | `CloseCurrentTab`（关闭当前标签页）                     |

##### 标签页：导航

| 快捷键                              | 动作         |
| --------------------------------- | -------------- |
| <kbd>SUPER</kbd>+<kbd>[</kbd>     | 下一个标签页       |
| <kbd>SUPER</kbd>+<kbd>]</kbd>     | 上一个标签页   |
| <kbd>SUPER_REV</kbd>+<kbd>[</kbd> | 标签页左移  |
| <kbd>SUPER_REV</kbd>+<kbd>]</kbd> | 标签页右移 |

##### 标签页：标题

| 快捷键                          | 动作         |
| ----------------------------- | -------------- |
| <kbd>SUPER</kbd>+<kbd>9</kbd> | 切换标签栏显示 |

##### 标签页：重命名

| 快捷键                              | 动作             |
| --------------------------------- | ------------------ |
| <kbd>SUPER</kbd>+<kbd>0</kbd>     | 重命名当前标签页 |
| <kbd>SUPER_REV</kbd>+<kbd>0</kbd> | 撤销重命名        |

&nbsp;

#### 窗口

| 快捷键                          | 动作               |
| ----------------------------- | -------------------- |
| <kbd>SUPER</kbd>+<kbd>n</kbd> | `SpawnWindow`（新建窗口）        |
| <kbd>SUPER</kbd>+<kbd>=</kbd> | 增大窗口尺寸 |
| <kbd>SUPER</kbd>+<kbd>-</kbd> | 减小窗口尺寸 |

&nbsp;

#### 面板

##### 面板：拆分面板

| 快捷键                               | 动作                                           |
| ---------------------------------- | ------------------------------------------------ |
| <kbd>SUPER</kbd>+<kbd>\\</kbd>     | `SplitVertical` <sub>(当前面板域)</sub>   |
| <kbd>SUPER_REV</kbd>+<kbd>\\</kbd> | `SplitHorizontal` <sub>(当前面板域)</sub> |

##### 面板：缩放+关闭面板

| 快捷键                              | 动作                |
| --------------------------------- | --------------------- |
| <kbd>SUPER</kbd>+<kbd>Enter</kbd> | `TogglePaneZoomState`（切换面板缩放状态） |
| <kbd>SUPER</kbd>+<kbd>w</kbd>     | `CloseCurrentPane`（关闭当前面板）    |

##### 面板：导航

| 快捷键                              | 动作                  |
| --------------------------------- | ----------------------- |
| <kbd>SUPER_REV</kbd>+<kbd>k</kbd> | 移动到面板（上）       |
| <kbd>SUPER_REV</kbd>+<kbd>j</kbd> | 移动到面板（下）     |
| <kbd>SUPER_REV</kbd>+<kbd>h</kbd> | 移动到面板（左）     |
| <kbd>SUPER_REV</kbd>+<kbd>l</kbd> | 移动到面板（右）    |
| <kbd>SUPER_REV</kbd>+<kbd>p</kbd> | 与选中面板交换位置 |

##### 面板：滚动

| 快捷键                          | 动作                               |
| ----------------------------- | ------------------------------------ |
| <kbd>SUPER</kbd>+<kbd>u</kbd> | 向上滚动 <sub>5 行</sub>   |
| <kbd>SUPER</kbd>+<kbd>d</kbd> | 向下滚动 <sub>5 行</sub> |
| <kbd>PageUp</kbd>             | 向上翻页                       |
| <kbd>PageDown</kbd>           | 向下翻页                     |

&nbsp;

#### 背景图片

| 快捷键                              | 动作                       |
| --------------------------------- | ---------------------------- |
| <kbd>SUPER</kbd>+<kbd>/</kbd>     | 随机选择图片          |
| <kbd>SUPER</kbd>+<kbd>,</kbd>     | 切换到下一张图片          |
| <kbd>SUPER</kbd>+<kbd>.</kbd>     | 切换到上一张图片      |
| <kbd>SUPER_REV</kbd>+<kbd>/</kbd> | 模糊搜索图片           |
| <kbd>SUPER</kbd>+<kbd>b</kbd>     | 切换背景聚焦模式 |

&nbsp;

#### 工作区

| 快捷键                              | 动作                       |
| --------------------------------- | ---------------------------- |
| <kbd>LEADER</kbd>+<kbd>o</kbd>     | 切换到 `openmrcp` 工作区          |
| <kbd>F5</kbd>                     | 工作区启动器 <sub>(模糊搜索)</sub> |

&nbsp;

#### 快捷键表

> 详见：<https://wezfurlong.org/wezterm/config/key-tables.html>

| 快捷键                           | 动作        |
| ------------------------------ | ------------- |
| <kbd>LEADER</kbd>+<kbd>f</kbd> | `resize_font`（调整字体大小） |
| <kbd>LEADER</kbd>+<kbd>p</kbd> | `resize_pane`（调整面板大小） |

##### 快捷键表：`resize_font`

| 快捷键           | 动作                          |
| -------------- | ------------------------------- |
| <kbd>k</kbd>   | `IncreaseFontSize`（增大字体）              |
| <kbd>j</kbd>   | `DecreaseFontSize`（减小字体）                 |
| <kbd>r</kbd>   | `ResetFontSize`（重置字体大小）                 |
| <kbd>q</kbd>   | `PopKeyTable` <sub>(退出)</sub> |
| <kbd>Esc</kbd> | `PopKeyTable` <sub>(退出)</sub> |

##### 快捷键表：`resize_pane`

| 快捷键           | 动作                                         |
| -------------- | ---------------------------------------------- |
| <kbd>k</kbd>   | `AdjustPaneSize` <sub>(方向：上)</sub>    |
| <kbd>j</kbd>   | `AdjustPaneSize` <sub>(方向：下)</sub>  |
| <kbd>h</kbd>   | `AdjustPaneSize` <sub>(方向：左)</sub>  |
| <kbd>l</kbd>   | `AdjustPaneSize` <sub>(方向：右)</sub> |
| <kbd>q</kbd>   | `PopKeyTable` <sub>(退出)</sub>                |
| <kbd>Esc</kbd> | `PopKeyTable` <sub>(退出)</sub>                |

---

### 参考/灵感来源

- <https://github.com/rxi/lume>
- <https://github.com/catppuccin/wezterm>
- <https://github.com/wez/wezterm/discussions/628#discussioncomment-1874614>
- <https://github.com/wez/wezterm/discussions/628#discussioncomment-5942139>
