-- vimscript still to migrate to lua

vim.cmd [[

  hi Search cterm=NONE ctermfg=yellow ctermbg=blue
  hi TabLineFill term=bold cterm=bold ctermbg=0
  hi StatusLine ctermbg=gray ctermfg=black
  hi Pmenu ctermbg=darkgrey ctermfg=black
  hi FloatBorder guifg=cyan guibg=#1f2335
  hi NormalFloat guifg=cyan guibg=darkgrey
  hi MatchParen cterm=none ctermbg=darkgrey ctermfg=blue
  hi LineNr ctermfg=darkgrey
  autocmd InsertEnter * :set norelativenumber
  autocmd InsertLeave * :set relativenumber

  if has('persistent_undo')      
    set undofile                 
    set undodir=$HOME/.vim/undo  
  endif

  let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
  
  filetype plugin on
  syntax on

  command! Diary VimwikiDiaryIndex
  augroup vimwikigroup
      autocmd!
      " automatically update links on read diary
      autocmd BufRead,BufNewFile diary.wiki VimwikiDiaryGenerateLinks
  augroup end

au! BufRead,BufNewFile *.astro set filetype=astro

let NERDTreeQuitOnOpen=1
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
]]


-- plugins
require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'lewis6991/impatient.nvim'
  use 'ElPiloto/telescope-vimwiki.nvim'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use 'preservim/nerdtree'
  use 'prettier/vim-prettier'
  use 'mattn/emmet-vim'
  use 'github/copilot.vim'
  use "rafamadriz/friendly-snippets"
  use 'BurntSushi/ripgrep'
  use 'mhinz/vim-startify'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'L3MON4D3/LuaSnip'
  use 'benfowler/telescope-luasnip.nvim'
  use 'vimwiki/vimwiki'
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

  use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
  use 'JoosepAlviste/nvim-ts-context-commentstring'

  use {
    'neovim/nvim-lspconfig',
    config = function() 
      local servers = { 'tsserver', 'diagnosticls', 'tailwindcss', 'prismals', 'astro' }
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
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end
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
    config = function() require('cmp_tabnine.config').setup({
      max_lines = 1000;
      max_num_results = 20;
      sort = true;
      run_on_every_keystroke = true;
      snippet_placeholder = '..';
    }) end
  } 

end)

require('impatient')

require('hop').setup()

require("luasnip.loaders.from_vscode").lazy_load()

require("nvim-lsp-installer").setup {}

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "typescript", "rust", "lua", "html", "css", "javascript", "json", "bash", "python", "graphql", "yaml", "toml", "regex", "tsx", "astro" },
  context_commentstring = {
    enable = true,
    config = {}
  },
  indent = {
    enable = true
  },
  highlight = {
    enable = true,
  }
}


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
set.compatible = false
set.swapfile = false
set.backup = true
set.writebackup = true
set.backupdir = '~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp '
set.backupskip = '/tmp/*,/private/tmp/* '
set.directory = '~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp '

vim.g.mapleader = " "
vim.g.airline_theme='minimalist'

local keymap = vim.api.nvim_set_keymap
local opts = { noremap=true, silent=true }

vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>gq', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gk', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
keymap('n', '<C-j>', '<C-w>j', { noremap = true})
keymap('n', '<C-k>', '<C-w>k', { noremap = true})
keymap('n', '<C-h>', '<C-w>h', { noremap = true})
keymap('n', '<C-l>', '<C-w>l', { noremap = true}) 

keymap('n', '<Leader>H', ':set hlsearch!<CR>', { noremap = true, silent= true })
keymap('n', '<Leader>%', ':source %<CR>', { noremap = true})

-- normal mode 
keymap('i', 'jj', '<ESC>', { noremap = true})

-- save
keymap('n', '<Leader>w', ':w<CR>', { noremap = true})

-- quit
keymap('n', '<Leader>q', ':q<CR>', { noremap = true})

-- nerdtree
keymap('n', '<C-n>', ':NERDTreeToggle<CR>', { noremap = true})

-- hop
keymap('n', '<Leader>h', ':HopWord<CR>', { noremap = true})

-- toggle buffers
keymap('n', '<Leader><Leader>', '<C-^>', { noremap = true})


-- window navigation
keymap('n', '<C-j>', '<C-w>j', { noremap = true})
keymap('n', '<C-k>', '<C-w>k', { noremap = true})
keymap('n', '<C-h>', '<C-w>h', { noremap = true})
keymap('n', '<C-l>', '<C-w>l', { noremap = true}) 

-- trouble
keymap("n", "<leader>tt", "<cmd>TroubleToggle<cr>",
  {silent = true, noremap = true}
)
keymap("n", "<leader>tw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
keymap("n", "<leader>td", "<cmd>TroubleToggle document_diagnostics<cr>",
  {silent = true, noremap = true}
)
keymap("n", "<leader>tl", "<cmd>TroubleToggle loclist<cr>",
  {silent = true, noremap = true}
)
keymap("n", "<leader>tq", "<cmd>TroubleToggle quickfix<cr>",
  {silent = true, noremap = true}
)
keymap("n", "<leader>tr", "<cmd>TroubleToggle lsp_references<cr>",
  {silent = true, noremap = true}
)

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
--keymap('n','<leader>ff', '<cmd>lua require(\'telescope.builtin\').find_files({ find_command = {\'rg\', \'--files\', \'--hidden\', \'-g\', \'!.git\' }})<cr>', { noremap = true})
keymap('n','<leader>ff', '<cmd>lua require(\'telescope.builtin\').find_files({ hidden = true, respect_gitignore = true})<cr>', { noremap = true})
keymap('n','<leader>fg', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>', { noremap = true})
keymap('n','<leader>fb', '<cmd>lua require(\'telescope.builtin\').buffers()<cr>', { noremap = true})
keymap('n','<leader>fh', '<cmd>lua require(\'telescope.builtin\').help_tags()<cr>', { noremap = true})
keymap('n','<leader>fd', '<cmd>lua require(\'telescope.builtin\').diagnostics()<cr>', { noremap = true})
-- setup vimwiki
require('telescope').load_extension('vw')

local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

local telescope = require("telescope")

telescope.setup {
  defaults = {
    mappings = {
      i = { ["<c-t>"] = trouble.open_with_trouble },
      n = { ["<c-t>"] = trouble.open_with_trouble },
    },
  },
}


-- setup lsp
local servers = { 'tsserver', 'diagnosticls', 'tailwindcss', 'prismals', 'astro' }
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

require('lspconfig')['astro'].setup{
  filetypes = { 'astro' },
        init_options = {
      configuration = {},
    },
    -- Server-specific settings...
    settings = {
    }
}

vim.lsp.set_log_level("debug")
vim.o.updatetime =1000 
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
           copilot = "[Copilot]",
           luasnip = "[LuaSnip]",
           buffer = "[Buffer]",
           nvim_lsp = "[LSP]",
           cmp_tabnine = "[TabNine]",
           nvim_lua = "[Lua]",
           latex_symbols = "[Latex]",
         })
      }),
    },

    sources = cmp.config.sources({
      { name = 'copilot' },
      { name = 'luasnip' },
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



