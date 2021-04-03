-- Contains all required plugins

local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use 'gruvbox-community/gruvbox'
    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/completion-nvim'
    use 'tjdevries/nlua.nvim'
    use 'tjdevries/lsp_extensions.nvim'

end)
