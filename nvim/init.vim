" vscodeでneovimを使う際に破損とかを防ぐため
if !exists('g:vscode') 
  source ~/.vimrc

  " true color
  if exists("&termguicolors") && exists("&winblend")
    let g:neosolarized_termtrans=1
    runtime ./colors/solarized_true.vim
    set termguicolors
    set winblend=0
    set wildoptions=pum
    set pumblend=5
  endif

endif
