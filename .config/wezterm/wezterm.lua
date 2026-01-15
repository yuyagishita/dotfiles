local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local keymaps = require 'keymaps'

-- キーマップの読み込み
config.leader = keymaps.leader
config.keys = keymaps.keys

-- config.color_scheme = 'Gruvbox Dark'
-- 背景の透明度設定（値を小さくするとより透明になります）
config.window_background_opacity = 0.85  -- 例：0.7は70%の不透明度

-- フォントサイズを設定（デフォルトは通常12.0程度）
config.font_size = 15.0

return config
