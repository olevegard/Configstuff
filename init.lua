-- =====================================================================================================================================
-- Ask to install packer if not present
-- =====================================================================================================================================
--Install packer :
--  git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
packer_bootstrap = false

-- Check if packer is installed
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  -- Ask user before installing for security reasons
  ans = vim.fn.input("Download packer from github.com/wbthomason/packer.nvim (y/n)")

  -- Download plugin and add
  if ( ans == 'y') then
    packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    -- This line might not be nexessary
    -- vim.cmd [[packadd packer.nvim]]
  end

  -- User said no, give a command to download packer instead
  if ( ans == 'n') then
    -- Force a new line
    print("-")
    print("Install by running (in terminal)")
    print("git clone --depth 1 https://github.com/wbthomason/packer.nvim " .. install_path)
    print("Then run ( in nvim)")
    print("Then run :PackerSync");
  end
end

-- =====================================================================================================================================
-- Plugins
-- =====================================================================================================================================
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'        -- Package manager
  use 'neovim/nvim-lspconfig'         -- Configurations for Nvim LSP
  use 'hrsh7th/nvim-cmp'              -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'          -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip'      -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip'              -- Snippets plugin
  use 'rafi/awesome-vim-colorschemes' -- Colorschemes ( including jellybeans )
  use 'preservim/nerdtree'            -- Tree view

  use 'tpope/vim-surround' -- Change surronding brackets/quotes/tabs++
  -- use 'tpope/fugitive' -- Git support
  use 'tpope/vim-commentary' -- Commentary helpers

  use {
    'nvim-treesitter/nvim-treesitter',
     run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }

  use 'nvim-treesitter/nvim-treesitter-context'

  if packer_bootstrap then
    require('packer').sync()
  end
end)


-- Install any new plugins
require("packer").install()

-- =====================================================================================================================================
-- Langauge support
-- =====================================================================================================================================
require'lspconfig'.dartls.setup{} -- Enable LSP for Dart

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)

  vim.keymap.set('n', 'gd'        , vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- Autocomplete
-- =====================================================================================================================================
-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'dartls' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

-- luasnip setup
-- local luasnip = require 'luasnip'

-- Autocompletion
local cmp = require 'cmp'
cmp.setup {
-- snippet = {
--   expand = function(args)
--     luasnip.lsp_expand(args.body)
--   end,
-- },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
 --    elseif luasnip.expand_or_jumpable() then
 --      luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
  --   elseif luasnip.jumpable(-1) then
  --     luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    -- { name = 'luasnip' },
  },
}

-- Tree sitter
-- =====================================================================================================================================
require'treesitter-context'.setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
        -- For all filetypes
        -- Note that setting an entry here replaces all other patterns for this entry.
        -- By setting the 'default' entry below, you can control which nodes you want to
        -- appear in the context window.
        default = {
            'class',
            'function',
            'method',
            'for',
            'while',
            'if',
            'switch',
            'case',
        },
        -- Patterns for specific filetypes
        -- If a pattern is missing, *open a PR* so everyone can benefit.
        tex = {
            'chapter',
            'section',
            'subsection',
            'subsubsection',
        },
        rust = {
            'impl_item',
            'struct',
            'enum',
        },
        scala = {
            'object_definition',
        },
        vhdl = {
            'process_statement',
            'architecture_body',
            'entity_declaration',
        },
        markdown = {
            'section',
        },
        elixir = {
            'anonymous_function',
            'arguments',
            'block',
            'do_block',
            'list',
            'map',
            'tuple',
            'quoted_content',
        },
        json = {
            'pair',
        },
        yaml = {
            'block_mapping_pair',
        },
    },
    exact_patterns = {
        -- Example for a specific filetype with Lua patterns
        -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
        -- exactly match "impl_item" only)
        -- rust = true,
    },

    -- [!] The options below are exposed but shouldn't require your attention,
    --     you can safely ignore them.

    zindex = 20, -- The Z-index of the context window
    mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
    -- Separator between context and content. Should be a single character string, like '-'.
    -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    separator = '-',
}

-- Language servers
-- =====================================================================================================================================
require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

require('lspconfig')['dartls'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

require('lspconfig')['tsserver'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

require('lspconfig')['rust_analyzer'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
      ["rust-analyzer"] = {}
    }
}

-- =====================================================================================================================================
-- Colorscheme
-- =====================================================================================================================================
vim.cmd('colorscheme jellybeans')

-- =====================================================================================================================================
-- Vim Shortcuts
-- =====================================================================================================================================
-- Use \opn to open path in new buffer ( glitchy, maybe there is a better lua way? '
vim.keymap.set('n', '<Leader>opn', ':wincmd F <CR> <bar> :wincmd L <CR>')

-- =====================================================================================================================================
-- LSP shortcuts
-- =====================================================================================================================================
vim.keymap.set('n', '<Leader>lim', vim.lsp.buf.hover, bufopts)                      -- List all implementations
vim.keymap.set('n', '<Leader>hov', vim.lsp.buf.hover, bufopts)                      -- Show info about the symbol under the cursor
vim.keymap.set('n', '<Leader>fix', vim.lsp.buf.code_action, bufopts)                -- Show suggested fixes
vim.keymap.set('n', '<Leader>jed', vim.lsp.buf.definition, bufopts)                 -- Jump to definition in the same buffer
vim.keymap.set('n', '<Leader>jen', "vert sb | lua vim.lsp.buf.definition()<CR>")    -- Jump to definition in a new buffer

vim.keymap.set('n', '<Leader>ref', vim.lsp.buf.references, bufopts) -- Show references
vim.keymap.set('n', '<Leader>ren', vim.lsp.buf.rename, bufopts)     -- Rename symbol

vim.keymap.set('n', '<Leader>pe', vim.diagnostic.goto_prev, bufopts)   -- Go to previous error
vim.keymap.set('n', '<Leader>ne', vim.diagnostic.goto_next, bufopts)   -- Go to next error

vim.keymap.set('n', '<Leader>hlp', vim.lsp.buf.signature_help, bufopts)


-- =====================================================================================================================================
-- NetdTree shortcuts
-- =====================================================================================================================================
vim.keymap.set('n', '<Leader>nto', ':NERDTree<CR>')         -- Open nerd tree
vim.keymap.set('n', '<Leader>ntfo', ':NERDTreeFocus<CR>')   -- Focus Nerd tree
vim.keymap.set('n', '<Leader>ntfi', ':NERDTreeFind<CR>')
vim.keymap.set('n', '<Leader>nttt', ':NERDTreeToggle<CR>')
-- nnoremap <leader>n :NERDTreeFocus<CR>
-- nnoremap <C-n> :NERDTree<CR>
-- nnoremap <C-t> :NERDTreeToggle<CR>
-- nnoremap <C-f> :NERDTreeFind<CR>

-- =====================================================================================================================================
-- Language shortcuts
-- =====================================================================================================================================
-- Go
vim.keymap.set('n', '<Leader>gfmt', ':! go fmt %<CR>')
vim.keymap.set('n', '<Leader>gbd', ':! go build %<CR>')
vim.keymap.set('n', '<Leader>gor', 'go run %<CR>')

-- Dart + Flutter
vim.keymap.set('n', '<Leader>', ':! flutter format --line-length 120 % <CR>')
vim.keymap.set('n', '<Leader>dtest', ':! flutter test % <CR>')
vim.keymap.set('n', '<Leader>pget ', ':! flutter pub get <CR>')
vim.keymap.set('n', '<Leader>prun', ':! flutter pub run build_runner build --delete-conflicting-outputs <CR>')
vim.keymap.set('n', '<Leader>json', ':! dart lib/localization/json_to_dart.dart <CR>')
vim.keymap.set('n', '<Leader>anal', ':! flutter analyze <CR>')
vim.keymap.set('n', '<Leader>frun', ':! flutter run  <CR>')
vim.keymap.set('n', '<Leader>drun', ':! dart % <CR>')

-- =====================================================================================================================================
-- Indentation and whitespaces
-- =====================================================================================================================================
vim.opt.tabstop = 2 		-- one tab character = 2 spaces
vim.opt.shiftwidth = 4 	 	-- one level of indentation = 2 spaces
vim.opt.expandtab = true  	-- tabs keypresses will be expanded into spaces
vim.opt.softtabstop = 2 	-- how many columns of whitespace is a tab keypress or a backspace keypress worth?

vim.opt.list = true  -- enables the use of listchar
vim.opt.listchars = {		-- how various whitespaces should look
	eol = '$',        -- end of line
	tab = '>-',       -- tab
	trail = '~',      -- trailing spaces
	lead = '~',       -- leading spaces
	multispace = '~',	-- multiple spaces
	extends = '>',		-- character to in the last column on each line when wrapping long pieces of text
	precedes = '<'		-- character to in the first column on a new line when wrapping long pieces of text
}

vim.cmd('filetype plugin indent on')    -- Automatic indentation based on file type

vim.keymap.set('n', '<Tab>', '>>')      -- Shift tab decrease indentation in insert mode
vim.keymap.set('n', '<S-Tab>', '<<')    -- Shift tab decrease indentation in command mode
vim.keymap.set('i', '<S-Tab>', '<C-d>') -- Shift tab increase indentation in command mode

-- =====================================================================================================================================
-- Line numbering
-- =====================================================================================================================================
vim.opt.cursorline = true       -- Highlight current line
vim.opt.scrolloff = 100         -- Always center cursor
vim.opt.number = true           -- Line numbers
vim.opt.relativenumber= true    -- Relative line numbers

-- =====================================================================================================================================
-- Search and highlight
-- =====================================================================================================================================
vim.opt.ignorecase = true   -- Searches ignore case
vim.optsmartcase = true     -- Make searches case-sensitive only if they containing upper-case letters
vim.opt.incsearch = true    -- Do incremental searching
vim.opt.hlsearch = true     -- Highlight search matches

-- =====================================================================================================================================
-- Misc
-- =====================================================================================================================================
vim.opt.confirm = true -- Some operations that would normally fail because unsaved changes ( like ":e" ) will now give a prompt instead
vim.opt.wrap = false  -- Disable implicit line breaks

-- =====================================================================================================================================
-- File system
-- =====================================================================================================================================
vim.opt.backup = true     -- Keep a backup file
vim.opt.swapfile = false  -- No swap file
vim.opt.autoread = true   -- Automatically reload

vim.cmd('autocmd TextChanged,TextChangedI <buffer> silent write')   -- Automatically save when a buffer changes
-- vim.cmd('autocmd User YcmQuickFixOpened <buffer> silent write')     -- Automatically save when quickfix opens a window
