-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------
local wk = require('which-key')

local function map(mode, lhs, rhs, opts) local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Change leader to a space
vim.g.mapleader = ' '

-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------

-- Map Esc to jk in insert 
map('i', 'jk', '<Esc>')

-- Scroll wheel shortcuts
map('', '<ScrollWheelUp>', '<C-Y>')
map('', '<ScrollWheelDown>', '<C-E>')
map('', '<S-ScrollWheelUp>', '5zl')
map('', '<S-ScrollWheelDown>', '5zh')

-- Move line/block up or down
map('n', '<A-j>', '<cmd>m .+1<CR>==')
map('n', '<A-k>', '<cmd>m .-2<CR>==')
map('i', '<A-j>', '<Esc><cmd>m .+1<CR>==gi')
map('i', '<A-k>', '<Esc><cmd>m .-2<CR>==gi')

-- Visiual mode indenting
map('v', '>', '>gv')
map('v', '<', '<gv')

wk.register({
    ['<Leader>w'] = {
        name='Window',
        v = {"<cmd>vsplit<cr>", "Split vertically"},
        w = {"<cmd>split<cr>", "Split horizontally"},
        h = {"<cmd>wincmd h<cr>", "Focus left"},
        j = {"<cmd>wincmd j<cr>", "Focus down"},
        k = {"<cmd>wincmd k<cr>", "Focus up"},
        l = {"<cmd>wincmd l<cr>", "Focus right"},
        H = {"<cmd>wincmd H<cr>", "Swap left"},
        J = {"<cmd>wincmd J<cr>", "Swap down"},
        K = {"<cmd>wincmd K<cr>", "Swap up"},
        L = {"<cmd>wincmd L<cr>", "Swap right"},
        p = {"<cmd>bprevious<cr>", "Open previous"},
    }
})

-----------------------------------------------------------
-- Plugin shortcuts
-----------------------------------------------------------

-- telescope
local telescope = require('telescope.builtin')
wk.register({
    ['<space>f'] = {
        name = "Find",
        f = {telescope.find_files, "Find files"},
        g = {telescope.live_grep, "Workdir grep"},
        b = {telescope.buffers, "Previous files"},
        s = {telescope.lsp_document_symbols, "Document symbols"},
        S = {telescope.lsp_workspace_symbols, "Workspace symbols"},
        j = {telescope.jumplist, "Jump list"},
        p = {require("telescope").extensions.neoclip.default, "Clipboard"},
    }
})

-- LSP (see also plugins/lspconfig.lua for language-specific options)
wk.register({
    ['<space>e'] = { vim.diagnostic.open_float, "Open Float" },
    ['[d'] = { vim.diagnostic.goto_prev, "Previous diagnostic" },
    [']d'] = { vim.diagnostic.goto_next, "Next diagnostic" },
    ['<space>q'] = { vim.diagnostic.setloclist, "Set Loclist"} 
})

-- comments
vim.keymap.set('n', '<C-/>', ':CommentToggle<cr>')
vim.keymap.set('v', '<C-/>', ":<C-u>call CommentOperator(visualmode())<CR>")

-- Basic braces matching [now covered by plugin]
-- vim.keymap.set("i", "{<CR>", "{<CR>}<ESC>O")
-- vim.keymap.set("i", "(<CR>", "(<CR>)<ESC>O")
-- vim.keymap.set("i", "[<CR>", "[<CR>]<ESC>O")

-- treesitter shortcuts
-- [Node selection handled under plugins/tree-sitter.lua]
wk.register({
    -- Remap old ['gf']
    ['go'] = {'gf', 'Goto file under cursor'},
    -- Motions
    ['gf'] = {'<cmd>TSTextobjectGotoNextStart @function.outer<CR>', "Next function"},
    ['gF'] = {'<cmd>TSTextobjectGotoPreviousStart @function.outer<CR>', "Prev function"},
    ['ga'] = {'<cmd>TSTextobjectGotoNextStart @parameter.inner<CR>', "Next argument"},
    ['gA'] = {'<cmd>TSTextobjectGotoPreviousStart @parameter.inner<CR>', "Prev argument"},
    -- Swaps
    ['<space>a'] = {'<cmd>TSTextobjectSwapNext @parameter.inner<CR>', "Swap next argument"},
    ['<space>A'] = {'<cmd>TSTextobjectSwapPrevious @parameter.inner<CR>', "Swap previous argument"},
})

