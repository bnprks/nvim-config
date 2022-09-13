local wk = require('which-key')

local iron = require("iron.core")
local view = require("iron.view")
iron.setup {
  config = {
    -- Whether a repl should be discarded or not
    scratch_repl = true,
    -- Your repl definitions come here
    repl_definition = {
    },
    -- How the repl window will be displayed
    -- See below for more information
    repl_open_cmd = view.split.botrigh("40%"),
  }
 }

-- REPL

local function strip_leading_spaces(data, startcol)
    local _, ws_end = string.find(data[1], "^ *") 
    startcol = startcol + ws_end
    data[1] = string.gsub(data[1], "^ +", "")
    local sub = "^" .. string.rep(" ", startcol) 
    for i = 2, #data do
        if string.len(data[i]) == 0 then
            data[i] = nil
        else
            data[i] = string.gsub(data[i], sub, "")
        end
    end
    return data
end

local function send_query(query)
    local ft = vim.api.nvim_buf_get_option(0, "filetype")
    local shared = require("nvim-treesitter.textobjects.shared")
    local bufnr, textobj = shared.textobject_at_point(query)
    local data = vim.api.nvim_buf_get_text(
        bufnr,
        textobj[1],
        textobj[2],
        textobj[3],
        textobj[4],
        {}
    )
    data = strip_leading_spaces(data, textobj[2])
    require("iron.core").send(ft, data)
end

local function send_selection()
    local data = require("iron.core").mark_visual()
    local start_col = require("iron.marks").get().from_col
    data = strip_leading_spaces(data, start_col)
    require("iron.core").send(ft, data)
end

wk.register({
    ['<space>s'] = {
        name = "Send to REPL",
        s = {function() send_query("@statement.outer") end, "statement"},
    },
    ['<C-CR>'] = {send_selection, "Send visual selection", mode="v"}
})

