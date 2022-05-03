-- タブ周り
-- tabstopはTab文字を画面上で何文字分に展開するか
-- shiftwidthはcindentやautoindent時に挿入されるインデントの幅
-- softtabstopはTabキー押し下げ時の挿入される空白の量，0の場合はtabstopと同じ，BSにも影響する
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 0
vim.o.expandtab = true -- タブを空白文字に展開
-- vim.o.autoindent smartindent  -- 自動インデント，スマートインデント
vim.o.list = true
vim.o.listchars = "tab:»-"
