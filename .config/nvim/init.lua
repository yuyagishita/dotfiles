if not vim.fn.exists('g:vscode') then
  -- execute 'source ~/.vimrc

  -- true color
  if vim.fn.exists("&termguicolors") && vim.fn.exists("&winblend") then
    let g:neosolarized_termtrans=1
    runtime ./colors/solarized_true.vim
    set termguicolors
    set winblend=0
    set wildoptions=pum
    set pumblend=5
  end

end
