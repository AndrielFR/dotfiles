-- Enable ALE completion
vim.g.ale_completion_enabled = 1

-- Initialize plugins
require 'paq' {
	'savq/paq-nvim';

	'tpope/vim-git';
	'tpope/vim-fugitive';
	'tpope/vim-sleuth';
	'tpope/vim-unimpaired';
	-- 'tpope/vim-markdown';
	'tpope/vim-abolish';
	'tomtom/tcomment_vim';
	'HallerPatrick/nvim_todo.vim';
	'rbong/vim-flog';

	'nvim-lua/plenary.nvim';
	'lewis6991/gitsigns.nvim';
	'nvim-telescope/telescope.nvim';

	'prabirshrestha/asyncomplete.vim';
	'prabirshrestha/asyncomplete-neosnippet.vim';
	'prabirshrestha/asyncomplete-buffer.vim';
	'prabirshrestha/asyncomplete-file.vim';
	'andreypopp/asyncomplete-ale.vim';
	'laixintao/asyncomplete-gitcommit';
	'dense-analysis/ale';
	'Shougo/neosnippet.vim';
	'honza/vim-snippets';
	{'rrethy/vim-hexokinase', run = 'make hexokinase'};
	'sheerun/vim-polyglot';

	'AndrewRadev/sideways.vim';
	'FooSoft/vim-argwrap';
	'ntpeters/vim-better-whitespace';
	'ZhiyuanLck/smart-pairs';
	'lukas-reineke/indent-blankline.nvim';
	'ethanholz/nvim-lastplace';
	'nacro90/numb.nvim';
	'haya14busa/incsearch.vim';
	'ray-x/lsp_signature.nvim';
	'valloric/MatchTagAlways';
	'alvan/vim-closetag';
	'terryma/vim-expand-region';
	'andrewradev/splitjoin.vim';
	'pbrisbin/vim-mkdir';
	'matze/vim-move';
	'arzg/vim-colors-xcode';
	'akinsho/toggleterm.nvim';
	'nvim-lualine/lualine.nvim';
};

-- nvim_todo
require 'config.todo'

-- vim-flog
require 'config.flog'

-- gitsigns
require 'config.gitsigns'

-- telescope.nvim
require 'config.telescope'

-- coc.nvim
require 'config.asyncomplete'

-- vim-hexokinase
require 'config.hexokinase'

-- sideways.vim
require 'config.sideways'

-- vim-argwrap
require 'config.argwrap'

-- vim-better-whitespace
require 'config.better_whitespace'

-- smart-pairs
require 'config.smart_pairs'

-- indent-blankline.nvim
require 'config.indent_blankline'

-- nvim-lastplace
require 'config.lastplace'

-- numb.nvim
require 'config.numb'

-- lsp_signature.nvim
require 'config.lsp_signature'

-- vim-expand-region
require 'config.expand_region'

-- splitjoin.vim
require 'config.splitjoin'

-- vim-move
require 'config.move'

-- vim-colors-xcode
require 'config.colors_xcode'

-- toggleterm.nvim
require 'config.toggleterm'

-- lualine.nvim
require 'config.lualine'
