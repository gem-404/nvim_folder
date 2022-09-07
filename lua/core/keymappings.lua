
-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end



-- Change leader to a comma
vim.g.mapleader = ' '

-- telescope planets
map('n', '<leader>pp', ':lua require"telescope.builtin".planets{}<cr>')
map('n', 'ff', ':FZF<cr>')

-- Save breakpoints to file automatically.
map("n", "<leader><leader>b", "<cmd>lua require('persistent-breakpoints.api').toggle_breakpoint()<cr>", opts)

-- map("n", "<YourKey2>", "<cmd>lua require('persistent-breakpoints.api').set_conditional_breakpoint()<cr>", opts)

map("n", "<leader><leader>c", "<cmd>lua require('persistent-breakpoints.api').clear_all_breakpoints()<cr>", opts)

map('n', '<F12>', ':TZAtaraxis<cr>')

--lazygit configurations
map('n', '<leader>gg', ':LazyGit<cr>')

-- nvimranger configurations
map('n', '<leader>ra', ':RnvimrToggle<cr>')

-- quit! mapping
map('n', '<C-q>', ':q!<cr>')

-- Quickfix mappings
map('i', 'jj', '<esc>', { noremap = true, silent = true })
map('n', '<leader>ck', ':cexpr []<cr>')
map('n', '<leader>cc', ':cclose <cr>')
map('n', '<leader>co', ':copen <cr>')
map('n', '<leader>cf', ':cfdo %s/')
map('n', '<leader>cp', ':cprev<cr>zz')
map('n', '<leader>cn', ':cnext<cr>zz')

-- Yanking and copying whole files in neovim
map('n', '<f5>', ':%y<cr>')
map('n', '<f6>', 'ggVGp')
map('n', '<f4>', 'ggVG')
map('n', '<f8>', 'ggVGd')
map('n', '<f2>', 'Go<cr>')
map('n', '<f7>', 'dG')

-- Quick Colorscheme changings
map('n', 'tc', ':colorscheme rose-pine<cr>')
map('n', 'tm', ':colorscheme monokai_soda<cr>')

map('n', 'tv', ':colorscheme gruvbox<cr>')

map('n', 'td', ':colorscheme default<cr>')
map('n', 'ts', ':colorscheme synthwave84<cr>')
map('n', 'tz', ':colorscheme zellner<cr>')
map('n', 'tu', ':colorscheme murphy<cr>')
map('n', 'to', ':colorscheme onedark<cr>')
map('n', 'ty', ':colorscheme monokai_ristretto<cr>')
map('n', 'tk', ':colorscheme tokyonight<cr>')

-- buffer navigation
map('n', 'bp', ':bprev<cr>')
map('n', 'bn', ':bnext<cr>')
map('n', 'bd', ':bdelete<cr>')

-- resize with arrows
map('n', '<C-Up>', ':resize -2<CR>')
map('n', '<C-Down>', ':resize +2<CR>')
map('n', '<C-Left>', ':vertical resize -2<CR>')
map('n', '<C-Right>', ':vertical resize +2<CR>')

-- resize with arrows
map('n', '<C-Up>', ':resize -2<CR>')
map('n', '<C-Down>', ':resize +2<CR>')
map('n', '<C-Left>', ':vertical resize -2<CR>')
map('n', '<C-Right>', ':vertical resize +2<CR>')
map('n', 'J', '5j')
map('x', 'J', '5j')
map('n', 'K', '5k')
map('x', 'K', '5k')

map("n", "L", "g_")
map("n", "H", "^")
map("x", "L", "g_")
map("x", "H", "^")

map("n", "W", "5w")
map("n", "B", "5b")


map("n", "<", "<<")
map("n", ">", ">>")
map("x", "<", "<gv")
map("x", ">", ">gv")

-- map("n", ";d", ":Dispatch ", {noremap = true, silent = false})

map("n", "-", "N")
map("n", "=", "n")
-- map("n", ";", ":")
-- map("v", ";", ":")


-- map("n", ",", ":tabnext<CR>")

map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-r>", "<C-w>r")
map("n", "<C-t>", "<C-w>T")

map("", "<Space>", "<Nop>")

map("n", ";w", ":w<CR>")
map("n", ";q", ":q!<CR>")
-- map("n", ";x", ":x<cr>")

map("x", "<C-y>", [["+y]])
map("n", "<C-p>", [["+p]])
map("i", "<C-p>", [[<ESC>"+pa]])

map("n", "<ESC>", ":nohlsearch<CR>")

map("n", "<C-up>", ":res +5<CR>")
map("n", "<C-down>", ":res -5<CR>")
map("n", "<C-right>", ":vertical resize-5<CR>")
map("n", "<C-left>", ":vertical resize+5<CR>")

-- nvim-tree
map("n", "tt", ":NvimTreeToggle<CR>")
map("n", "tr", ":NvimTreeRefresh<CR>")

-- vsplit commands
map("n", "<C-b>", ":vsplit<CR>")
map("n", "<C-w>", ":split<CR>")

-- commentary
map("n", "<C-n>", ":CommentToggle<CR>")
map("v", "<C-n>", ":CommentToggle<CR>")

map("n", "tl", ":lua require('telescope.builtin').find_files{}<CR>")
map("n", "tg", "<cmd>Telescope live_grep<cr>")

map("n", "<LEADER>g", [[<CMD>Git<CR>]])
map("n", "<LEADER>l", [[<CMD>LazyGit<CR>]])

-- map("i", "<A-;>", "<ESC>")
map("i", "jj", "<ESC>")
map("i", "JJ", "<ESC>")
map("v", "aa", "<ESC>")
map("i", "jk", "<ESC>")

-- my own line for LExplore
-- map("n", "<LEADER>e", ":Lex 30<CR>")

-- my own line for moving normal texts up and down
-- map("n", "<A-j>", ":m .+1<CR>==gn")
-- map("n", "<A-k>", ":m .-2<CR>==gn")

-- for saving automatically,
-- map("n", ";", ":")
map("n", "<leader>w", ":w!<CR>")
map("n", "<leader>q", ":q!<CR>")

-- my own line for moving blocks of visual texts up and down
-- map("v", "<A-j>", ":m .+1<CR>==gn", opt)
-- map("v", "<A-k>", ":m .-2<CR>==gn", opt)


-- bufferline tab stuff
map("n", "<C-x>", ":BufferLinePickClose<CR>") -- close tab


-- move tabs
map("n", "<C-c>", [[<CMD>:BufferLinePick<CR>]])

map("n", "<leader>n", "<ESC>:tabnew<CR>")

map("n", "<LEADER>s", [[<ESC>:Startify<CR>]])

map("n", "tf", "<ESC>:FloatermToggle<CR>")

map("n", "<C-s>", ":wqa!<cr>")
map("i", "<C-s>", "<ESC>:wqa!<cr>")

map("i", "<C-Space>", ":compe#complete()")
map("i", "<CR>",      ":compe#confirm(lexima#expand('<LT>CR>', 'i'))")
map("i", "<C-e>",     ":compe#close('<C-e>')")
map("i", "<C-f>",     ":compe#scroll({ 'delta': +4 })")
map("i", "<C-d>",     ":compe#scroll({ 'delta': -4 })")

map("n", "<C-d>", ":only<CR>")

-- map("n", "<leader>ex", ":Ex<cr>")
map("n", ";d", ":bd<cr>")

-- Inspired by the PRIMEAGEN... Copied from the PRIMEAGEN's workflow
--
map('n', 'gd', ':lua vim.lsp.buf.definition()<cr>')
map('n', 'gD', ':lua vim.lsp.buf.declaration()<cr>')
map('n', 'gi', ':lua vim.lsp.buf.implementation()<cr>')
map('n', 'gsh', ':lua vim.lsp.buf.signature_help()<cr>')
map('n', 'gr', ':lua vim.lsp.buf.references()<cr>')
map('n', 'rn', ':lua vim.lsp.buf.rename()<cr>')

map('n', 'gt', ':lua vim.lsp.buf.type_definition()<cr>')

map('n', 'gw', ':lua vim.lsp.buf.workspace_symbol()<cr>')

map('n', 'gh', ':lua vim.lsp.buf.hover()<cr>')
map('n', 'ca', ':lua vim.lsp.buf.code_action()<cr>')
map('n', 'gsd', ':lua vim.lsp.diagnostic.show_line_diagnostics()<cr>')
map('n', 'gn', ':lua vim.lsp.diagnostic.goto_next()<cr>')
map('n', 'gll', ':call LspLocationList<cr>')

-- map('n', '<leader><F5>', ":lua require'dap'.continue()<CR>")
-- map('n', '<leader><F9>', ":lua require'dap'.toggle_breakpoint()<CR>")
-- map('n', '<leader><F10>', ":lua require'dap'.step_over()<CR>")
-- map('n', '<leader><F34>', ":lua require'dap'.step_into()<CR>")
-- map('n', '<leader><F7>', ":lua require'dap'.repl.open()<CR><C-w><C-w>i")
-- map('n', '<leader><F8>', ":lua require'dap'.repl.close()<CR>")
-- map('n', '<leader><F4>', ":lua require'dap'.disconnect()<CR>")
--
-- map('i', '<leader><F5>',  "<ESC>:lua require'dap'.continue()<CR>i")
-- map('i', '<leader><F9>',  "<ESC>:lua require'dap'.toggle_breakpoint()<CR>i")
-- map('i', '<leader><F10>', "<ESC>:lua require'dap'.step_over()<CR>i")
-- map('i', '<leader><F34>', "<ESC>:lua require'dap'.step_into()<CR>i")
-- map('i', '<leader><F7>',  "<ESC>:lua require'dap'.repl.open()<CR><C-w><C-w>i")
-- map('i', '<leader><F8>',  "<ESC>:lua require'dap'.repl.close()<CR>i")
-- map('i', '<leader><F4>', "<ESC>:lua require'dap'.disconnect()<CR>i")
--
-- map('n', '<leader>h', '<Cmd>lua require("dap.ui.widgets").hover()<CR>')

map('n', '<leader><F5>',  ":source ~/.config/nvim/init.lua<cr>")

map('n', '<leader>ff', ':SearchBoxIncSearch<cr>')
map('n', '<leader>fr', ':SearchBoxReplace<cr>')

map('x', '<leader>af', ':SearchBoxIncSearch visual_mode=true<cr>')
map('x', '<leader>ar', ':SearchBoxReplace exact=true visual_mode=true<cr>')
