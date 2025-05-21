local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- カラースキームの設定
config.color_scheme = 'iceberg-dark'  -- または 'catppuccin-mocha' など

-- 背景の透明度設定（値を小さくするとより透明になります）
config.window_background_opacity = 0.85  -- 例：0.7は70%の不透明度

-- キーバインドの設定
config.keys = {
  {
    key = "A",
    mods = "CTRL|SHIFT",
    action = wezterm.action.QuickSelect,
  },
  -- 他の既存のキーバインドをここに記述
}

return config
