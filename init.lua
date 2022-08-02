
vim.cmd [[
  hi Search cterm=NONE ctermfg=yellow ctermbg=blue
  hi TabLineFill term=bold cterm=bold ctermbg=0
  hi StatusLine ctermbg=gray ctermfg=black
  hi LineNr ctermfg=darkgrey

  autocmd InsertEnter * :set norelativenumber
  autocmd InsertLeave * :set relativenumber

  if has('persistent_undo')      
    set undofile                 
    set undodir=$HOME/.vim/undo  
  endif
]]


-- plugins
require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'preservim/nerdtree'
  use 'prettier/vim-prettier'
  use 'mattn/emmet-vim'
  use 'github/copilot.vim'
  use 'BurntSushi/ripgrep'
  use 'mhinz/vim-startify'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'L3MON4D3/LuaSnip'
  use 'benfowler/telescope-luasnip.nvim'
  use 'neovim/nvim-lspconfig'
  use 'glepnir/lspsaga.nvim'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-copilot'
  use 'saadparwaiz1/cmp_luasnip'
  use 'nvim-treesitter/nvim-treesitter'
  use 'phaazon/hop.nvim'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
 
  use {
    'lewis6991/gitsigns.nvim', 
    requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('gitsigns').setup() end
  }

  use {
    'tzachar/cmp-tabnine', 
    run='./install.sh', 
    requires = {'hrsh7th/nvim-cmp'},
    config = function() require('gcmp_tabnine.config').setup({
      max_lines = 1000;
      max_num_results = 20;
      sort = true;
      run_on_every_keystroke = true;
      snippet_placeholder = '..';
    }) end
  } 
 end)


local set = vim.opt

set.hidden = true
set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.expandtab = true
set.splitright = true
set.number = true
set.mouse = 'a'
set.relativenumber = true

vim.g.mapleader = " "
vim.g.airline_theme='minimalist'

local keymap = vim.api.nvim_set_keymap

keymap('n', '<C-j>', '<C-w>j', { noremap = true})
keymap('n', '<C-k>', '<C-w>k', { noremap = true})
keymap('n', '<C-h>', '<C-w>h', { noremap = true})
keymap('n', '<C-l>', '<C-w>l', { noremap = true}) 

keymap('n', '<Leader><Leader>h', ':set hlsearch!<CR>', { noremap = true, silent= true })
keymap('n', '<Leader>%', ':source %<CR>', { noremap = true})

-- quit
keymap('n', '<Leader>q', ':q<CR>', { noremap = true})

-- nerdtree
keymap('n', '<C-n>', ':NERDTreeToggle<CR>', { noremap = true})

-- hop
keymap('n', '<Leader>h', ':HopWord<CR>', { noremap = true})

-- luasnips
keymap('n', '<Leader><Leader>s', '<cmd>source ~/.config/nvim/lua/snippets.lua<CR>', { noremap = true})

-- window navigation
keymap('n', '<C-j>', '<C-w>j', { noremap = true})
keymap('n', '<C-k>', '<C-w>k', { noremap = true})
keymap('n', '<C-h>', '<C-w>h', { noremap = true})
keymap('n', '<C-l>', '<C-w>l', { noremap = true}) 

-- easy caps
keymap('i', '<C-u>', '<ESC>viwUl', { noremap = true})
keymap('n', '<C-u>', 'viwU<Esc>', { noremap = true})

-- tab through buffers
keymap('n', '<Leader><TAB>', ':bnext<CR>', { noremap = true})
keymap('n', '<Leader><S-TAB>', ':bprevious<CR>', { noremap = true})

-- goto buffer (maybe redundant now with telescope?)
keymap('n', 'gb', ':buffers<CR>:buffer<Space>', { noremap = true})
keymap('n', 'gbs', ':buffers<CR>:vert belowright sb<Space>', { noremap = true})

-- better  indentation
keymap('v', '<TAB>', '>gv', { noremap = true})
keymap('v', '<S-TAB>', '<gv', { noremap = true})

-- telescope
keymap('n','<leader>ff', '<cmd>lua require(\'telescope.builtin\').find_files()<cr>', { noremap = true})
keymap('n','<leader>fg', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>', { noremap = true})
keymap('n','<leader>fb', '<cmd>lua require(\'telescope.builtin\').buffers()<cr>', { noremap = true})
keymap('n','<leader>fh', '<cmd>lua require(\'telescope.builtin\').help_tags()<cr>', { noremap = true})



