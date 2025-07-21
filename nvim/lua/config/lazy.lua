-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ','
vim.g.maplocalleader = '\\'

vim.opt.number=true

vim.opt.shiftwidth=2
vim.opt.tabstop=2
vim.opt.softtabstop=2
vim.opt.expandtab=true

vim.opt.showcmd=true
vim.opt.showmatch=true
vim.opt.cmdheight=1

vim.api.nvim_create_autocmd('FileType', {
  pattern = {'cpp', 'python', 'c'},
  callback = function()
    vim.opt.colorcolumn='81'
  end,
})

-- global key mapping.
vim.keymap.set('n', '<leader>ev', ':vsplit<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<space>', 'viw', { noremap = true, silent = true })

-- Setup lazy.nvim
require('lazy').setup({
  {
    'tpope/vim-fugitive'
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function() 
      local configs = require('nvim-treesitter.configs')

      configs.setup({
          ensure_installed = { 'cpp', 'c', 'lua', 'vim', 'vimdoc', 'query', 'html' },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },  
        })
    end
  },
  {
    'bling/vim-airline',
    config = function()
      vim.g['airline#extensions#tabline#enabled'] = 1
      vim.g['airline#extensions#gitbranch#enabled'] = 1
      vim.g['airline_left_sep'] = '>'
      vim.g['airline_right_sep'] = '<'
    end
  },
  {
    'folke/tokyonight.nvim',
    -- 'morhetz/gruvbox',
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
       vim.cmd('colorscheme tokyonight')
       -- vim.cmd('colorscheme gruvbox')
    end
  },
  {
    'ycm-core/YouCompleteMe',
    lazy = false,
    keys = {
      { '<C-G>', ':YcmCompleter Format<CR>', mode = {'n', 'v'}, noremap = true, silent = true },
      { '<C-G>', '<C-O>:YcmCompleter Format<CR>', mode = 'i', noremap = true, silent = true },
      { '<leader>jd', ':YcmCompleter GoTo<CR>', mode = 'n', noremap = true, silent = true },
      { '<leader>gd', ':YcmCompleter GetDoc<CR>', mode = 'n', noremap = true, silent = true },
      { '<leader>fi', ':YcmCompleter FixIt<CR>', mode = 'n', noremap = true, silent = true },
      { '<leader>jr', ':YcmCompleter GoToReferences<CR>', mode = 'n', noremap = true, silent = true },
      { '<leader>rn', ':YcmCompleter RefactorRename <C-R>=input("New name: ")<CR><CR>', mode = 'n', noremap = true, silent = true },
    },
  },
  {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
  }
}
})

