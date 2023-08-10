"======================= Plug ==========================

call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'schickling/vim-bufonly'
Plug 'Yggdroot/indentLine'

Plug 'storyn26383/emmet-vim'
Plug 'tpope/vim-surround'


Plug 'stephpy/vim-php-cs-fixer'
Plug 'StanAngeloff/php.vim'
" 用 CoC 取代
"Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' } 
"Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}

Plug 'jwalton512/vim-blade'

"Plug 'vim-vdebug/vdebug'
Plug 'puremourning/vimspector'
Plug 'vim-test/vim-test'

Plug 'benmills/vimux'

Plug 'digitaltoad/vim-pug'
Plug 'storyn26383/vim-vue'

Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'

Plug 'godlygeek/tabular'

Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'rhysd/vim-wasm'

Plug 'AndrewRadev/splitjoin.vim'
Plug 'github/copilot.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

"====================== Settings =======================
syntax on

set nu
set incsearch
set ignorecase
set autoread
set nocompatible
set nobackup " no *~ backup files
set noswapfile
set nowritebackup
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set tags+=~/.vim/tags,./tags,tags;
set hidden " leave buffer without save
set foldmethod=syntax
set foldlevelstart=99
set foldlevel=1

autocmd FileType make setlocal noexpandtab
"autocmd FileType php setlocal omnifunc=phpactor#Complete
autocmd FileType blade,js,vue,css,html,typescript,javascript,yaml setlocal sw=2 sts=2 ts=2

nmap <F2> :ctags -R<CR>
nmap <F4> :w<CR>:make<CR>
nmap <F5> :w<CR>
nmap <F6> :cl<CR>
nmap <F7> :! gdb <CR>
nmap <F8> :Tlist<CR>
nmap <Leader>i :IndentLinesToggle<CR>
nmap <Leader>s :LeadingSpaceToggle<CR>
nmap <Leader>l :IndentLinesToggle<CR>
nmap <Leader>b :Buffer<CR>
nmap <Leader>a :Ag<CR>
nmap <Leader>f :Files<CR>

map <C-n> :NERDTreeToggle<CR>

let g:vim_markdown_folding_disabled = 1

"===================== Ctags ===========================

function! UpdateTags()
  let tags = 'tags'

  if filereadable(tags)
    let file = substitute(expand('%:p'), getcwd() . '/', '', '')

    " remove tags of file and append tags
    call system('sed -ri "/\s+' . escape(file, './') . '/d"' . tags . ' && ctags -a "' . file . '" &')
  endif
endfunction

autocmd BufWritePost *.php,*.cpp,*.cc,*.h,*.c call UpdateTags()
autocmd BufWritePost *.php,*.cpp,*.cc,*.h,*.c %retab!

"======================= Air Line ==========================
let g:airline_theme="tomorrow"
let g:airline_powerline_fonts = 1
" set status line
set laststatus=2

let g:airline#extensions#tabline#enabled = 1
" set left separator
let g:airline#extensions#tabline#left_sep = ' '
" set left separator which are not editting
let g:airline#extensions#tabline#left_alt_sep = '|'
" show buffer number
let g:airline#extensions#tabline#buffer_nr_show = 1
" show coc
let g:airline#extensions#coc#enabled = 1

"========================== PHP ============================
"function! PhpSyntaxOverride()
"    " Put snippet overrides in this function.
"    hi! link phpDocTags phpDefine
"    hi! link phpDocParam phpType
"endfunction
"
"augroup phpSyntaxOverride
"    autocmd!
"    autocmd FileType php call PhpSyntaxOverride()
"augroup END

"=========================== php-cs-fixer ============================
let g:php_cs_fixer_rules = '@PSR12'
let g:php_cs_fixer_enable_default_mapping = 0

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_php_checkers = ['php', 'phpcs']
let g:syntastic_php_phpcs_args = '--standard=psr12'

autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()


"=========================== indentLine ============================

let g:indentLine_enabled = 0
let g:indentLine_leadingSpaceEnabled = 0
let g:indentLine_color_term = 239

let g:indentLine_leadingSpaceChar = '.'
autocmd FileType html,css,php,c,cpp,swift,python,ruby,dart,go :IndentLinesEnable

"=========================== indentLine ============================
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeGlyphReadOnly = "RO"

"========================== Flutter ==============================

let g:flutter_show_log_on_run = 0
nnoremap <leader>fa :FlutterRun<cr>
nnoremap <leader>fq :FlutterQuit<cr>
nnoremap <leader>fr :FlutterHotReload<cr>
nnoremap <leader>fR :FlutterHotRestart<cr>
nnoremap <leader>fD :FlutterVisualDebug<cr>

"========================== vdebug ==============================
"
"if !exists('g:vdebug_options')
"  let g:vdebug_options = {}
"endif
"let g:vdebug_options.port = 9003
"
"========================== vimtest =============================

let test#strategy = 'vimux'
let g:test#preserve_screen = 0
let test#php#phpunit#executable = 'XDEBUG_CONFIG="remote_enable=1" ./vendor/bin/phpunit'
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

"========================== CoC ==============================
" :CocInstall coc-phpls coc-tsserver coc-vetur

autocmd BufWritePre *.go *.php :call CocAction('runCommand', 'editor.action.organizeImport')

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" " delays and poor user experience.
set updatetime=300

" " Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.

"if has("nvim-0.5.0") || has("patch-8.1.1564")
"  " Recently vim can merge signcolumn and number column into one
"  set signcolumn=number
"else
"  set signcolumn=yes
"endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
"xmap <leader>a  <Plug>(coc-codeaction-selected)
"nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

"======================== CoC Vim ==============================

autocmd FileType scss setl iskeyword+=@-@
