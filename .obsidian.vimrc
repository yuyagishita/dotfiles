" Spaceをunmapしてleader keyとして使えるようにする
unmap <Space>

" Ctrl+wをunmap（ウィンドウ操作のプレフィックスとして使う）
unmap <C-w>

" ペイン間の移動（Vimライク: Ctrl+w h/j/k/l）
exmap focusLeft obcommand editor:focus-left
nmap <C-w>h :focusLeft<CR>

exmap focusRight obcommand editor:focus-right
nmap <C-w>l :focusRight<CR>

exmap focusBottom obcommand editor:focus-bottom
nmap <C-w>j :focusBottom<CR>

exmap focusTop obcommand editor:focus-top
nmap <C-w>k :focusTop<CR>

" ペイン分割（Vimライク: Ctrl+w v/s）
exmap splitVertical obcommand workspace:split-vertical
nmap <C-w>v :splitVertical<CR>

exmap splitHorizontal obcommand workspace:split-horizontal
nmap <C-w>s :splitHorizontal<CR>

" ペインを閉じる（Vimライク: Ctrl+w q）
exmap closePane obcommand workspace:close
nmap <C-w>q :closePane<CR>
nmap <C-w>c :closePane<CR>

" タブ操作
exmap nextTab obcommand workspace:next-tab
nmap gt :nextTab<CR>

exmap prevTab obcommand workspace:previous-tab
nmap gT :prevTab<CR>

" タブを閉じる
nmap <Space>x :closePane<CR>

" ファイル操作
exmap quickSwitcher obcommand switcher:open
nmap <Space>f :quickSwitcher<CR>

exmap saveFile obcommand editor:save-file
nmap <Space>w :saveFile<CR>

" 検索
exmap globalSearch obcommand global-search:open
nmap <Space>/ :globalSearch<CR>
