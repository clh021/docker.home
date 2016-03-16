set gfn=Monospace\ 9 " 字体设置
set nocompatible "关闭兼容模式"
syntax on " 打开语法高亮
set autoindent " 打开自动缩进
set nu " 显示行号
set showcmd " 显示命令
set lz " 当运行宏时，命令未执行完之前，不要重绘屏幕
set hid " 可以在没有保存得情况下切换buffer
set incsearch " 增量式搜索，边输入边搜索
set hlsearch " 高亮搜索
"set nobackup " 关闭备份
set ai " 自动缩进
set si " 智能缩进
set autoread " 文件外部更改时，自动读入
" 文件编码
set encoding=utf8
set fileencodings=utf8,gb2312,gb18030,ucs-bom,latin1
set laststatus=2 " 总是显示状态栏
"set statusline=%1*%-52F\ %2*\ %{&ff=='unix'?'\\n':(&ff=='mac'?'\\r':'\\r\\n')}\ %3*\ %{&fenc!=''?&fenc:&enc}\ %1*\ %Y\ %4*\ %04l/%03c\ %2*\ 0x%04.4B\ %1*\ %-16{strftime(\"%Y-%m-%d\ %H:%M\")}\ %5*\ %-3m\ 
"set statusline=%<%F%1*%m%*%r%y%=%b\ 0x%B\ \ [l,c]%l,%c%V\ %p%%\ 
"hi User1 term=inverse,bold cterm=inverse,bold ctermfg=red

set cc=81 " 81列处高亮
set wrap  " 自动换行
set list  " 把制表符显示为^I ,用$标示行尾（使用list分辨尾部的字符是tab还是>空格）
"set listchars=tab:>-,trail:-
set listchars=tab:>-,trail:·
set backspace=indent,eol,start   "设置backspace删除
"set ignorecase    " 搜索忽略大小写
"set noignorecase  " 搜索忽略不大小写
set mouse=a " 启用对鼠标的支持
hi Normal  ctermfg=252 ctermbg=none
