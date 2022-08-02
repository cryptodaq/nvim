-- plugins
require('packer').startup(function()
use 'wbthomason/packer.nvim'
use 'preservim/nerdtree'
  -- vim-prettier
  use 'prettier/vim-prettier'

end)

local set = vim.opt
-- Set the behavior of tab
set.hidden = true
-- vim.opt.syntax = true
set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.expandtab = true
set.splitright = true
set.number = true
set.mouse = 'a'
set.relativenumber = true

-- leader mappings
-- options
vim.g.mapleader = " "



vim.o.guicursor = 'n-v-c:block,i-ci-vem:ver25,r-cr-o:hor20,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor'
-- keymaps
local keymap = vim.api.nvim_set_keymap
-- window navigation
keymap('n', '<C-j>', '<C-w>j', { noremap = true})
keymap('n', '<C-k>', '<C-w>k', { noremap = true})
keymap('n', '<C-h>', '<C-w>h', { noremap = true})
keymap('n', '<C-l>', '<C-w>l', { noremap = true}) 

keymap('n', '<Leader><Leader>h', ':set hlsearch!<CR>', { noremap = true, silent= true })
--keymap('n', '<Leader>w', ':w!<CR>', { noremap = true})
keymap('n', '<Leader>%', ':source %<CR>', { noremap = true})
--keymap('i', 'jj', '<ESC>', { noremap = true})

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

-- resize windows
keymap('n', '<M-j>', ':resize -2<CR>', { noremap = true})
keymap('n', '<M-k>', ':resize +2<CR>', { noremap = true})
keymap('n', '<M-h>', ':vertical resize -2<CR>', { noremap = true})
keymap('n', '<M-;>', ':vertical resize +2<CR>', { noremap = true}) -- todo l not working - why?

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

-- vim emmet
-- keymap('i', '<C-e>,' '<C-y>,', { noremap = true})

-- sessions
keymap('n', '<C-s>',':SSave! app<CR>', { noremap = true})

-- telescope
keymap('n','<leader>ff', '<cmd>lua require(\'telescope.builtin\').find_files()<cr>', { noremap = true})
keymap('n','<leader>fg', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>', { noremap = true})
keymap('n','<leader>fb', '<cmd>lua require(\'telescope.builtin\').buffers()<cr>', { noremap = true})
keymap('n','<leader>fh', '<cmd>lua require(\'telescope.builtin\').help_tags()<cr>', { noremap = true})
keymap(
  "n",
  "<leader>fi",
  ":Telescope file_browser<cr>",
  { noremap = true }
)
