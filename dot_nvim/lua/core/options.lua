local opt = vim.opt

-- aparencia
opt.number = true		          -- mostra numero de linhas 
opt.relativenumber = true	    -- number de linha relativos
opt.termguicolors = true	    -- habilita cores no termial
opt.laststatus = 3            -- deixa apenas uma barra para varias telas diferentes
opt.ruler = false             -- tira numeracao extra
opt.cursorline = true         -- mostra a linha atual
opt.title = true              -- automaticamente gera um window title bar

-- indentacao
opt.tabstop = 2			          -- tamanho do tab em espacos
opt.shiftwidth = 2		        -- tamanho da indetacao automatica
opt.expandtab = true		      -- usa espacos em vez de tabs
opt.autoindent = true		      -- indentacao automatica
opt.wrap = true               -- texto fica no modo wrap (preciso bindar alguma coisa para ajudar)
opt.cindent = true            -- identacao funcional para a lingaugem C

-- comportamento
opt.clipboard = "unnamedplus"	-- usa area de transferencia do sistema
opt.ignorecase = true		      -- ignora Mm na busca
opt.smartcase = true		      -- a menos que a busca contenha uma letra M
opt.wrap = false		          -- nao quebrar linhas longas
opt.mouse = "a"			          -- habilita o uso de mouse
opt.ttyfast = true            -- movimentos mais rapidos
opt.smoothscroll = true       -- 

-- extra
-- opt.showmode = false          -- desativa o modo de visualizacao (normal, insert, ...) plugin:LUALINE
-- opt.showcmd = false           -- desativa o comando no canto da tela plugin:which-key.nvim
opt.history = 100             -- linha de comando 
opt.swapfile = false          -- pode atrapalhar
opt.backup = false            -- nao gera backup de um arquivo
opt.undofile = true           -- undos sao salvos no arquivo
-- opt.foldmethod = "expr"       --
