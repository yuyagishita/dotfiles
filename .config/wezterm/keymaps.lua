local wezterm = require 'wezterm'
local act = wezterm.action

local M = {}

M.leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 1000 }

M.keys = {
  -- 画面スプリット
  {
    key = '|',
    mods = 'LEADER|SHIFT',
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = '-',
    mods = 'LEADER',
    action = act.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  
  -- ペイン間の移動（vim風）
  {
    key = 'h',
    mods = 'LEADER',
    action = act.ActivatePaneDirection 'Left',
  },
  {
    key = 'l',
    mods = 'LEADER',
    action = act.ActivatePaneDirection 'Right',
  },
  {
    key = 'k',
    mods = 'LEADER',
    action = act.ActivatePaneDirection 'Up',
  },
  {
    key = 'j',
    mods = 'LEADER',
    action = act.ActivatePaneDirection 'Down',
  },
  
  -- ペインのリサイズ
  {
    key = 'H',
    mods = 'LEADER|SHIFT',
    action = act.AdjustPaneSize { 'Left', 5 },
  },
  {
    key = 'L',
    mods = 'LEADER|SHIFT',
    action = act.AdjustPaneSize { 'Right', 5 },
  },

  -- ペイン入れ替え（追加）
  {
    key = 'r',
    mods = 'LEADER',
    action = act.RotatePanes 'Clockwise',
  },
  {
    key = 'R',
    mods = 'LEADER|SHIFT',
    action = act.RotatePanes 'CounterClockwise',
  },
  {
    key = 'w',
    mods = 'LEADER',
    action = act.PaneSelect { mode = 'SwapWithActive' },
  },
  
  -- ペインズーム（追加・tmux的）
  {
    key = 'z',
    mods = 'LEADER',
    action = act.TogglePaneZoomState,
  },
  -- 検索
  {
    key = 'f',
    mods = 'LEADER',
    action = act.Search 'CurrentSelectionOrEmptyString',
  },
  
  -- Quick Select
  {
    key = 's',
    mods = 'LEADER',
    action = act.QuickSelect,
  },
  
  -- ペインを閉じる
  {
    key = 'x',
    mods = 'LEADER',
    action = act.CloseCurrentPane { confirm = true },
  },
}

return M
