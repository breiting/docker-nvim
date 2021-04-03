-- Customization goes into the options.lua file

-- Enable gruvbox colorscheme
vim.cmd('colo gruvbox')

-- Global
vim.o.background = 'dark'
vim.o.syntax = 'on'
vim.o.hidden = true
vim.o.swapfile = false
vim.o.backup = false
vim.o.clipboard = 'unnamedplus'
vim.o.ruler = true
vim.o.mouse = 'a'
vim.o.guicursor = ''
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.termguicolors = true
vim.o.scrolloff = 4
vim.o.listchars = 'tab:> ,trail:·'
vim.o.completeopt = 'menuone,noinsert,noselect'

-- Window specific
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.colorcolumn = '80'
vim.wo.cursorline = true
vim.wo.wrap = false
vim.wo.signcolumn = 'yes'
vim.wo.list = true

-- Buffer specific

vim.bo.textwidth = 80
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.shiftwidth = 4
vim.bo.expandtab = true
