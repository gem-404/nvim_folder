
local indent = 4


-- miscellaneous
vim.opt.termguicolors = true
vim.cmd([[filetype plugin indent on ]])
vim.opt.backspace = {'eol', 'start', 'indent'}
vim.opt.clipboard = 'unnamedplus'
vim.opt.encoding = 'utf-8'
vim.opt.matchpairs = { '(:)', '{:}', '[:]', '<:>' }
vim.opt.syntax = 'enable'

vim.opt.wildignore = {
    ".DS_Store", ".git", ".svn", ".hg",
    "*.a", "*.o", "*.obj", "*.out", "*.so",
    "*.dll", "*.exe", "*.bin", "*~", "*.swp",
    "*.bmp", "*.gif", "*.ico", "*.jpg", "*.jpeg",
    "*.png", "__pycache__", "*.pyc", "*pycache*",
    "*.tar", "*.gz", "*.bz2", "*.zstd", "*.xz", "*.zip",
    "*.ttf", "*.otf", "*.woff", "*.woff2", "*.eot",
}

-- indentation
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = indent
vim.opt.smartindent = true
vim.opt.softtabstop = indent
vim.opt.tabstop = indent

-- user interface
vim.opt.number = true
vim.opt.rnu = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.ignorecase = true
-- vim.opt.spell = true

-- autocomplete
vim.opt.complete = vim.opt.complete + 'kspell'
vim.opt.completeopt = {'menuone', 'noinsert', 'noselect', 'preview'}
vim.opt.shortmess = vim.opt.shortmess + { c = true }
-- vim.opt.completion_enable_auto_popup = 0
-- vim.opt.completion_enable_snippet = 'Ultisnips'
-- vim.opt.completion_sorting = "length"

-- neoformatter for python
-- let g:neoformat_python_autopep8 = {}
-- let g:neoformat_enabled_python = ['autopep8', 'yapf', 'docformatter']

require 'nvim-tree'.setup{}

require ('nvim_comment').setup()

-- require('feline').setup()

require('nvim-autopairs').setup{}

-- require('galaxyline').section.left[1]= {
--   FileSize = {
--     provider = 'FileSize',
--     condition = function()
--       if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
--         return true
--       end
--       return false
--       end,
--     icon = '   ',
--     -- highlight = {colors.green,colors.purple},
--     separator = '',
--     -- separator_highlight = {colors.purple,colors.darkblue},
--   }
-- }

require("bufferline").setup{}

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

--
--
require('telescope').load_extension('lazygit')

local ok, telescope = pcall(require, "telescope")
if not ok then return end

telescope.setup({
    defaults = {
        vimgrep_arguments = {
            "rg", "--color=never", "--no-heading", "--with-filename",
            "--line-number", "--column", "--smart-case"
        },
        prompt_prefix = "  ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "flex",
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = {"absolute"},
        winblend = 0,
        border = {},
        borderchars = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
        color_devicons = true,
        use_less = true,
        set_env = {["COLORTERM"] = "truecolor"}, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = false, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case" -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
    }
})



-- local saga = require 'lspsaga'
-- local floaterm = require('lspsaga.floaterm')
--
-- local implement = require('lspsaga.implement')
--
-- saga.init_lsp_saga()

-- setup nvim-cmp
local cmp = require 'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      { name = 'luasnip' }, -- For luasnip users.
      { name = 'ultisnips' }, -- For ultisnips users.
      { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
})

require('nvim-treesitter').setup {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
--
-- nvim cmp
local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
  -- Load snippet support
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

-- Completion settings
  completion = {

    completeopt = 'menuone', 'noinsert', 'noselect', 'preview',
    keyword_length = 1
    },

  -- Key mapping
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },

    -- Tab mapping
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end
  },

  -- Load sources, see: https://github.com/topics/nvim-cmp
    sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
}



  -- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require'lspconfig'.pylsp.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.gopls.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.html.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.eslint.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.pyright.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.jdtls.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.tsserver.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.jedi_language_server.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.golangci_lint_ls.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.emmet_ls.setup{on_attach=require'completion'.on_attach}


-- require'lspconfig'.bashls.setup{on_attach=require'completion'.on_attach}
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.

-- vim.cmd("autocmd BufEnter * lua require'completion'.on_attach()")
-- Above is the newly added line.

-- -- Newly added pyls lines
-- nvim-lsp-installer setup
require("nvim-lsp-installer").setup {}
--
require('onedark').setup {
    style = 'darker',
    colors = { fg = '#b2bbcc' },
}
-- require('onedark').load()

require('rose-pine').setup {
    style = 'darker',
}


local M = {}

-- Theme: OneDark
--- See: https://github.com/navarasu/onedark.nvim/blob/master/lua/onedark/colors.lua
M.onedark = {
  bg = '#282c34',
  fg = '#abb2bf',
  pink = '#c678dd',
  green = '#98c379',
  cyan = '#56b6c2',
  yellow = '#e5c07b',
  orange = '#d19a66',
  purple = '#8a3fa0',
  red = '#e86671',
}

-- Theme: Monokai (classic)
--- See: https://github.com/tanvirtin/monokai.nvim/blob/master/lua/monokai.lua
M.monokai = {
  bg = '#202328', --default: #272a30
  fg = '#f8f8f0',
  pink = '#f92672',
  green = '#a6e22e',
  cyan = '#66d9ef',
  yellow = '#e6db74',
  orange = '#fd971f',
  purple = '#ae81ff',
  red = '#e95678',
}

-- Theme: Rosé Pine (main)
--- See: https://github.com/rose-pine/neovim/blob/main/lua/rose-pine/palette.lua
--- color names are adapted to the format above
M.rose_pine = {
  bg = '#111019', --default: #191724
  fg = '#e0def4',
  gray = '#908caa',
  pink = '#eb6f92',
  green = '#9ccfd8',
  cyan = '#31748f',
  yellow = '#f6c177',
  orange = '#2a2837',
  purple = '#c4a7e7',
  red = '#ebbcba',
}


-- autocmd BufEnter * lua require'completion'.on_attach()

-- define an chain complete list
local chain_complete_list = {
  default = {
    {complete_items = {'lsp', 'snippet'}},
    {complete_items = {'path'}, triggered_only = {'/'}},
    {complete_items = {'buffers'}},
  },
  string = {
    {complete_items = {'path'}, triggered_only = {'/'}},
  },
  comment = {},
}

local on_attach = function()
  require'diagnostic'.on_attach()
  -- passing in a table with on_attach function
  require'completion'.on_attach({
      sorting = 'alphabet',
      matching_strategy_list = {'exact', 'fuzzy'},
      chain_complete_list = chain_complete_list,
    })
    end

local nvim_lsp = require 'lspconfig'

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  },
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Highlighting references
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> silent! lua vim.lsp.buf.document_highlight()
        autocmd CursorHold * silent! checktime
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches.
-- Add your language server below:
local servers = { 'pyright', 'clangd', 'html', 'tsserver', "gopls", "pylsp", "jdtls", "eslint","emmet_ls", "golangci_lint_ls", "rome", "jedi_language_server" }

-- Call setup
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

require 'lspconfig'.pyright.setup {
	{
		python = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "workspace",
				useLibraryCodeForTypes = true
			}
		}
	}
}


require("indent_blankline").setup({
  -- U+2502 may also be a good choice, it will be on the middle of cursor.
  -- U+250A is also a good choice
  char = "▏",
  show_end_of_line = false,
  disable_with_nolist = true,
  buftype_exclude = { "terminal" },
  filetype_exclude = { "help", "git", "markdown", "snippets", "text", "gitconfig", "alpha" },
})

vim.cmd([[
function! Should_activate_indentblankline() abort
  if index(g:indent_blankline_filetype_exclude, &filetype) == -1
    IndentBlanklineEnable
  endif
endfunction

augroup indent_blankline
  autocmd!
  autocmd InsertEnter * IndentBlanklineDisable
  autocmd InsertLeave * call Should_activate_indentblankline()
augroup END
]])

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
    luasnip = true;
  };
}

-- require("neotest").setup({
  -- adapters = {
  --   require("neotest-python")({
  --     dap = { justMyCode = false },
  --   }),
  --   require("neotest-plenary"),
  --   require("neotest-vim-test")({
  --     ignore_file_types = { "python", "vim", "lua" },
  --   }),
  -- },
-- })

-- require('autolist').setup({
--     generic = {
--
--             enabled = true,
--
--             -- for if you have something else that you want to map when press return
--             -- with the create enter being false, you must create your own mapping
--             create_enter_mapping = true,
--
--             -- the mapping to invert the list type e.g ol -> ul, ul -> ol
--             -- set this to empty ("") to disable
--             invert_mapping = "<c-r>",
--
--             -- invert mapping in normal mode
--             invert_normal_mapping = "",
--
--             -- when pressing the relist mapping and current marker is ordered list,
--             -- change to invert_ul_marker.
--             invert_ul_marker = "-",
--
--             -- This just allows the relisting function to use the current list
--             -- formatting to search for the right list type.
--             -- Important: if your markdown ordered lists are badly formatted e.g a one
--             -- followed by a three, the relist cant find the right list. most of the
--             -- time you'll have the correct formatting, and its not a big deal if you
--             -- dont, the program wont throw an error, you just wont get a relist.
--             context_optimisaton = true,
--
--             -- when key o pressed, new list entry. Enables fo_o. see :h fo-table
--             new_entry_on_o = true,
--
--             -- if you use any of the override options, you must remove any definitions
--             -- of the overrided formatoptions, or you can define the options before
--             -- sourcing the require setup for this plugin, so it can override it.
--             -- see README#configuration
--
--             -- if you don't use fo_r (or if you disable it), set this to true.
--             -- it will disable fo_r for all filetypes except for enabled types.
--             -- perhaps grep for "formatoptions-=r" and "fo-=r"
--             override_fo_r = true,
--
--             -- if you don't use fo_o (or if you disable it), set this to true
--             -- it will disable fo_o for all filetypes except for enabled types.
--             -- perhaps grep for "formatoptions-=o" and "fo-=o"
--             override_fo_o = true,
--
--             -- filetypes that this plugin is enabled for.
--             -- must put file name, not the extension.
--             -- if you are not sure, just run :echo &filetype. or :set filetype?
--             enabled_filetypes = { "markdown", "text" },
--         },
-- })

-- local lib = require("neotest.lib")

local true_zen = require("true-zen")

-- for persistent breakpoints in code
-- require('persistent-breakpoints').setup{}



-- vim.g.lushwal_configuration = {
-- 	compile_to_vimscript = true,
-- 	color_overrides = nil,
-- 	addons = {
-- 		ale = false,
-- 		barbar = false,
-- 		bufferline_nvim = true, -- false
-- 		coc_nvim = false,
-- 		dashboard_nvim = false,
-- 		fern_vim = false,
-- 		gina = false,
-- 		gitsigns_nvim = false,
-- 		hop_nvim = false,
-- 		hydra_nvim = false,
-- 		indent_blankline_nvim = false,
-- 		lightspeed_nvim = false,
-- 		lspsaga_nvim = false,
-- 		lsp_trouble_nvim = false,
-- 		lualine = true, -- false
-- 		markdown = false,
-- 		native_lsp = true,
-- 		neogit = false,
-- 		neomake = false,
-- 		nerdtree = false,
-- 		nvim_cmp = false,
-- 		nvim_tree_lua = true, -- false
-- 		nvim_ts_rainbow = false,
-- 		semshi = false,
-- 		telescope_nvim = true, -- false
-- 		treesitter = true,
-- 		vim_dirvish = false,
-- 		vim_gitgutter = false,
-- 		vim_signify = false,
-- 		vim_sneak = false,
-- 		which_key_nvim = false,
-- 	}
-- }

-- local null_ls = require("null-ls")
--
-- null_ls.setup({
--   on_attach = function(client, bufnr)
--     if client.server_capabilities.documentFormattingProvider then
--       vim.cmd("nnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.formatting()<CR>")
--
--       -- format on save
--       vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()")
--     end
--
--     if client.server_capabilities.documentRangeFormattingProvider then
--       vim.cmd("xnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.range_formatting({})<CR>")
--     end
--   end,
-- })
--
-- local prettier = require("prettier")
--
-- prettier.setup({
--   bin = 'prettier', -- or `prettierd`
--   filetypes = {
--     "css",
--     "graphql",
--     "html",
--     "javascript",
--     "javascriptreact",
--     "json",
--     "less",
--     "markdown",
--     "scss",
--     "typescript",
--     "typescriptreact",
--     "yaml",
--   },
-- })
--
-- prettier.setup({
--   ["null-ls"] = {
--     runtime_condition = function(params)
--       -- return false to skip running prettier
--       return true
--     end,
--     timeout = 5000,
--   }
-- })

return M
