--- Aliases
local o = vim.o
local g = vim.g
local wo = vim.wo
local set = vim.opt

-- Disable filetype checking
vim.cmd 'filetype off'

-- Enable plugins and load plugin for the detected file type
vim.cmd 'filetype plugin on'

-- Load an indent file for the detected file type
vim.cmd 'filetype indent on'

-- Turn syntax highlighting on
vim.cmd 'syntax enable'

-- Turn on autoindent
o.autoindent = true

-- Ignore capital letters during search
o.ignorecase = true

-- Override the ignorecase option if searching for capital letters
-- This will allow you to search specifically for capital letters
o.smartcase = true

-- Show partial command you type in the last line of the screen
o.showcmd = true

-- Show the mode you are on the last line
o.showmode = true

-- Show matching words during a search
o.showmatch = true

-- Use highlighting when doing a search
o.hlsearch = true

-- Set the commands to save in history default number is 20
o.history = 150

-- Use utf-8
o.encoding = 'utf-8'

-- TextEdit might fail if hidden is not set
o.hidden = true

-- Give more space for displaying messages
o.cmdheight = 3

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience
o.updatetime = 100

-- Enable colors on term
set.termguicolors = true

-- Set the error format
set.errorformat:prepend('%f|%l col %c|%m')

-- Ignore these paths
set.wildignore = '*/cache/*,*/tmp/*'

-- Other
set.completeopt = 'menu,menuone,noselect'
