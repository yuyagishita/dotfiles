local wezterm = require 'wezterm'

return {
  keys = {
    {
      key = "A", -- 割り当てたいキー（ここではA）
      mods = "CTRL|SHIFT", -- 修飾キー
      action = wezterm.action.QuickSelect, -- QuickSelectモードを起動
    },
  },
}

