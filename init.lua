
vim.cmd [[
  hi Search cterm=NONE ctermfg=yellow ctermbg=blue
  hi TabLineFill term=bold cterm=bold ctermbg=0
  hi StatusLine ctermbg=gray ctermfg=black
  hi Pmenu ctermbg=black ctermfg=magenta
  hi FloatBorder guifg=cyan guibg=#1f2335
  hi NormalFloat guifg=cyan guibg=blue
  hi MatchParen cterm=none ctermbg=black ctermfg=blue
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


  use 'glepnir/lspsaga.nvim'
  use 'williamboman/nvim-lsp-installer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-copilot'
  use 'saadparwaiz1/cmp_luasnip'
  use 'onsails/lspkind-nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use {
    'neovim/nvim-lspconfig',
    config = function() 
      local servers = { 'tsserver', 'diagnosticls', 'tailwindcss', 'prismals' }
      for _, lsp in pairs(servers) do
        require('lspconfig')[lsp].setup {
        on_attach = on_attach,
        flags = {
          debounce_text_changes = 1250,
        }
      }
      end
    end
  }
  use {
    'phaazon/hop.nvim',
    config = function() require('hop').setup() end
  }
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

require('hop').setup()

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


-- setup lsp
local servers = { 'tsserver', 'diagnosticls', 'tailwindcss', 'prismals' }
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 1250,
    }
  }
end

vim.o.updatetime = 250
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

local on_attach = function(client, bufnr)
vim.api.nvim_create_autocmd("CursorHold", {
  buffer = bufnr,
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = 'rounded',
      source = 'always',
      prefix = ' ',
      scope = 'cursor',
    }
    vim.diagnostic.open_float(nil, opts)
  end
})
end

vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	float = {
		border = "single",
		format = function(diagnostic)
			return string.format(
				"%s (%s) [%s]",
				diagnostic.message,
				diagnostic.source,
				diagnostic.code or diagnostic.user_data.lsp.code
			)
		end,
	},
})

-- setup nvim_cmp

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local lspkind = require('lspkind')
local cmp = require'cmp'

  cmp.setup({

    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },

    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-o'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, 
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select=false  }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    },

    formatting = {
      format = lspkind.cmp_format({
        with_text = true,
        mode = 'text',
         menu = ({
           luasnip = "[LuaSnip]",
           copilot = "[Copilot]",
           buffer = "[Buffer]",
           nvim_lsp = "[LSP]",
           cmp_tabnine = "[TabNine]",
           nvim_lua = "[Lua]",
           latex_symbols = "[Latex]",
         })
      }),
    },

    sources = cmp.config.sources({
      { name = 'luasnip' },
      { name = 'copilot' },
      { name = 'cmp_tabnine' },
      { name = 'nvim_lsp' },
    }, {
      { name = 'buffer' },
    }
    )
  })

  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

