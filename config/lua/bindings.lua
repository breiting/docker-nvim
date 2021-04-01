-- All keybindings go into here
--
local opts = {noremap = true, silent = true}

vim.api.nvim_set_keymap('n', '<Leader>l', ':nohl<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>nn', ':e ~/.config/nvim/lua/init.lua<CR>', opts)
