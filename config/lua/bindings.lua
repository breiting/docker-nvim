-- All keybindings go into here
--
local opts = {noremap = true, silent = true}

vim.api.nvim_set_keymap('n', '<Leader>l', ':nohl<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>nn', ':e ~/.config/nvim/lua/init.lua<CR>', opts)

-- LSP
vim.api.nvim_set_keymap('n','<leader>vd',  '<cmd>lua vim.lsp.buf.definition()<CR>',opts)
vim.api.nvim_set_keymap('n','<leader>vi',  '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
vim.api.nvim_set_keymap('n','<leader>vR', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
vim.api.nvim_set_keymap('n','<leader>vr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
vim.api.nvim_set_keymap('n','<leader>vh',  '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
