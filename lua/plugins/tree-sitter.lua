require('nvim-treesitter.configs').setup {
	-- A list of parser names, or "all"
	ensure_installed = {"r", "python", "rust", "lua"},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	auto_install = true,

	highlight = {
		enable = true,
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<space>n",
            node_incremental = "gn",
            scope_incremental = "gs",
            node_decremental = "gm",
        },
    },
}

function bp_select_current_statement()
    local ts_util = require("nvim-treesitter.ts_utils")

    -- Get current cursor position and node
    local node = ts_util.get_node_at_cursor()
    local row = vim.api.nvim_win_get_cursor(0)[1] - 1
    
    -- Get first and last non-whitespace columns in current line
    local cur_col = vim.api.nvim_win_get_cursor(0)[2]
    vim.api.nvim_feedkeys("^", "n", true) 
    local first_col = vim.api.nvim_win_get_cursor(0)[2]
    vim.api.nvim_feedkeys("g_", "n", true)
    local last_col = vim.api.nvim_win_get_cursor(0)[2]

    local start_row, start_col, end_row, end_col
    print(row, first_col, last_col)
    -- Repeatedly expand to parent node until the current line is fully
    -- covered
    while true do
        start_row, start_col = node:start()
        end_row, end_col = node:end_()
        if ((start_row < row or (start_row == row and start_col <= first_col)) and 
            (end_row > row or (end_row == row and end_col >= last_col))) then
            break
        end
        print(start_row, start_col, end_row, end_col)
        node = node:parent()
    end
    ts_util.update_selection(0, node)
end

local function map(mode, lhs, rhs, opts) local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

