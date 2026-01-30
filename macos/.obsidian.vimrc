set clipboard=unnamed
" Spaceをunmapしてleader keyとして使えるようにする
unmap <Space>

" ペイン間の移動（Ctrl+h/j/k/l）
exmap focusLeft obcommand editor:focus-left
nmap <C-h> :focusLeft<CR>

exmap focusRight obcommand editor:focus-right
nmap <C-l> :focusRight<CR>

exmap focusBottom obcommand editor:focus-bottom
nmap <C-j> :focusBottom<CR>

exmap focusTop obcommand editor:focus-top
nmap <C-k> :focusTop<CR>

" ペイン分割（Space+s v/h）
exmap splitVertical obcommand workspace:split-vertical
nmap <Space>sv :splitVertical<CR>

exmap splitHorizontal obcommand workspace:split-horizontal
nmap <Space>sh :splitHorizontal<CR>

" ペインを閉じる（Space+q）
exmap closePane obcommand workspace:close
nmap <Space>q :closePane<CR>

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
