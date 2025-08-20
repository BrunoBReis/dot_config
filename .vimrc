" =============================================================================
"  Meu Arquivo de Configuração Pessoal para Vim/Neovim
" =============================================================================
"  Autor: BrunoBReis
"  Última Atualização: 18 de Agosto de 2025
" =============================================================================


" -----------------------------------------------------------------------------
" | SETUP INICIAL E COMPATIBILIDADE                                           |
" -----------------------------------------------------------------------------

" A opção 'nocompatible' é essencial. Deve ser uma das primeiras linhas para
" garantir que o Vim use suas próprias melhorias em vez do modo antigo do Vi.
set nocompatible

" Carrega as configurações padrão do Vim. É uma boa base para começar.
source $VIMRUNTIME/defaults.vim

" Define o histórico de comandos para 1000 entradas.
set history=1000


" -----------------------------------------------------------------------------
" | INTERFACE E APARÊNCIA (UI/UX)                                             |
" -----------------------------------------------------------------------------

" --- Cores e Destaques ---
syntax on               " Ativa o syntax highlighting (cores no código).
set background=dark     " Informa ao Vim que o fundo do terminal é escuro.

" Tenta carregar o colorscheme. O bloco try/catch evita erros se o tema não
" estiver instalado.
try
  colorscheme habamax
catch
endtry

" --- Elementos da Interface ---
set number              " Mostra o número das linhas na lateral esquerda.
set ruler               " Mostra a posição do cursor (linha e coluna) no canto inferior direito.
set showcmd             " Mostra comandos parciais na parte inferior da tela.
set cmdheight=1         " Define a altura da linha de comando para 1 linha.
set laststatus=2        " Sempre mostra a barra de status.
set wildmenu            " Ativa um menu de autocompletar para comandos.
set showmode            " Mostra o modo atual (INSERT, VISUAL, etc.).

" --- Comportamento do Cursor ---
set cursorline          " Destaca a linha horizontal onde o cursor está.
set cursorcolumn        " Destaca a coluna vertical onde o cursor está.
set showmatch           " Mostra o par correspondente de parênteses, chaves, etc.
set so=7                " (scrolloff) Mantém 7 linhas de contexto acima e abaixo do cursor.
set foldcolumn=1        " Cria uma pequena margem à esquerda para indicadores de dobra (folding).


" -----------------------------------------------------------------------------
" | COMPORTAMENTO DE TEXTO E EDIÇÃO                                           |
" -----------------------------------------------------------------------------

" --- Tabs e Indentação ---
set expandtab           " Usa espaços em vez de caracteres de tabulação.
set tabstop=2           " Um TAB no arquivo conta como 2 espaços.
set shiftwidth=2        " Operações de indentação (com >> ou <<) usarão 2 espaços.
set smarttab            " Comportamento inteligente para a tecla TAB.
set autoindent          " (ai) Copia a indentação da linha anterior ao criar uma nova.
set smartindent         " (si) Indentação inteligente para linguagens de programação.

" --- Quebra de Linha (Wrapping) ---
set nowrap              " Não quebra linhas longas automaticamente. Elas continuarão em uma única linha.
set lbr                 " (linebreak) Quebra a linha em palavras, se 'wrap' estiver ativo.
set tw=500              " (textwidth) Largura máxima do texto, se 'wrap' estiver ativo.
set whichwrap+=<,>,h,l  " Permite que as setas e backspace naveguem para a linha anterior/seguinte.

" --- Backspace ---
set backspace=indent,eol,start " Configuração de backspace mais intuitiva.

" --- Configurações de Arquivo ---
set encoding=utf8       " Define a codificação de caracteres padrão para UTF-8.
filetype on             " Detecta o tipo de arquivo.
filetype plugin on      " Carrega plugins específicos para o tipo de arquivo.
filetype indent on      " Carrega regras de indentação para o tipo de arquivo.


" -----------------------------------------------------------------------------
" | BUSCA (SEARCH)                                                            |
" -----------------------------------------------------------------------------

set hlsearch            " Destaca todas as ocorrências da busca atual.
set incsearch           " Mostra os resultados da busca enquanto você digita.
set ignorecase          " Ignora maiúsculas/minúsculas ao buscar.
set smartcase           " Torna a busca sensível a maiúsculas se você usar uma letra maiúscula.
set magic               " Habilita o uso de caracteres especiais (regex) na busca.


" -----------------------------------------------------------------------------
" | OUTRAS CONFIGURAÇÕES                                                      |
" -----------------------------------------------------------------------------

" Define a língua para o menu (útil em gVim).
let $LANG='en'
set langmenu=en

" Ignora certos arquivos e diretórios ao usar autocompletar ou wildcards.
set wildignore=*.o,*~,*.pyc,*/.git/*

" Usa o motor de Regex mais moderno e rápido do Vim.
set regexpengine=0


" -----------------------------------------------------------------------------
" | ATALHOS DE TECLADO (MAPPINGS)                                             |
" -----------------------------------------------------------------------------

" Usa a barra de espaço para iniciar uma busca para frente (/).
map <space> /
" Usa Ctrl + Espaço para iniciar uma busca para trás (?).
map <C-space> ?

" Limpa o destaque da busca (highlight) ao pressionar <leader> + Enter.
" A tecla <leader> por padrão é '\'.
map <silent> <leader><cr> :noh<cr>

" Permite que, ao selecionar um texto no modo visual, as teclas * e #
" busquem por esse texto no arquivo (para frente e para trás).

vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" -----------------------------------------------------------------------------
" | FUNÇÕES AUXILIARES (HELPER FUNCTIONS)                                     |
" -----------------------------------------------------------------------------

" Função para verificar se o modo 'paste' está ativo. Usada na Statusline.
function! HasPaste()
  if &paste
    return 'PASTE MODE '
  endif
  return ''
endfunction

" Esta função é chamada pelos atalhos acima. Ela copia a seleção visual
" para o registro de busca (@/).
function! VisualSelection(direction, extra_flags)
  let l:saved_reg = @"
  execute "normal! vgvy"
  let l:pattern = escape(@", '\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'gv'
    call execute('normal! ' . a:direction)
  endif

  if a:extra_flags == 'n'
    execute "normal! " . len(l:pattern) . "l"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

" -----------------------------------------------------------------------------
" | BARRA DE STATUS (STATUSLINE)                                              |
" -----------------------------------------------------------------------------

" Uma statusline personalizada para mostrar informações úteis.
set statusline=
set statusline+=\ %{HasPaste()} " Mostra 'PASTE MODE' se ativo
set statusline+=%F              " Caminho completo do arquivo
set statusline+=%m              " Flag de arquivo modificado [+]
set statusline+=%r              " Flag de arquivo read-only
set statusline+=%h              " Flag de ajuda
set statusline+=%w              " Flag de preview
set statusline+=\ \ CWD:\ %r%{getcwd()}%h " Diretório de trabalho atual
set statusline+=%=              " Alinha o conteúdo seguinte à direita
set statusline+=\ Line:\ %l      " Número da linha atual
set statusline+=\ Col:\ %c       " Número da coluna atual
set statusline+=\ \ %P           " Posição no arquivo em porcentagem

" ======================== FIM DA CONFIGURAÇÃO ================================
