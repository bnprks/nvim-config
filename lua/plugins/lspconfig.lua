-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local wk = require('which-key')
local lspconfig = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    wk.register({
        ['gD'] = { vim.lsp.buf.declaration, "Declaration", buffer=bufnr },
        ['gd'] = { vim.lsp.buf.definition, "Definition", buffer=bufnr },
        ['gr'] = { vim.lsp.buf.references, "References", buffer=bufnr },
        ['gi'] = { vim.lsp.buf.implementation, "Implementation", buffer=bufnr },

        ['K'] = { vim.lsp.buf.hover, "Symbol Info", buffer=bufnr },
        ['<C-k>'] = { vim.lsp.buf.signature_help, "Signature Help", buffer=bufnr },

        ['<spaceW>'] = {
            name="Workspace",
            a = { vim.lsp.buf.add_workspace_folder, "Add workspace folder", buffer=bufnr },
            r = { vim.lsp.buf.remove_workspace_folder, "Remove workspace folder", buffer=bufnr },
            l = { function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, "Print workspace folders", buffer=bufnr }
        },
        ['<space>D'] = { vim.lsp.buf.type_definition, "Type definition", buffer=bufnr },

        ['<space>c'] = {
            name="Code",
            r = { vim.lsp.buf.rename, "Rename", buffer=bufnr },
            a = { vim.lsp.buf.code_action, "Code action", buffer=bufnr },
            f = { vim.lsp.buf.formatting, "Format buffer", buffer=bufnr }
        }
    })
end

lspconfig['rust_analyzer'].setup{
    on_attach = on_attach,
}

lspconfig['clangd'].setup{
    on_attach = on_attach,
}

lspconfig["r_language_server"].setup{
    on_attach = on_attach,
    settings = {
        r = {
            lsp = {
                diagnostics=false
            }
        }
    },
}
