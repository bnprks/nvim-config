-- Bootstrap setup for packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
end

return require('packer').startup(function(use)
    -- My plugins here
    use 'wbthomason/packer.nvim'

    -- VS Code theme
    use {
        'Mofiqul/vscode.nvim',
        config = function() require('vscode').setup({}) end
    }

    -- Indentation guides
    use "lukas-reineke/indent-blankline.nvim"
    
    -- Popup key suggestions
    use {
        "folke/which-key.nvim",
        config = function() require('which-key').setup({}) end
    }

    -- LSP config (keybinding config in separate file)
    use 'neovim/nvim-lspconfig'

    -- Treesitter syntax highlighting / block selectiion
    use { 
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    }

    -- Treesitter support for textobjects (i.e. func, param, statement)
    use '~/github/nvim-treesitter/nvim-treesitter-textobjects'

    -- Visualization of treesitter parses
    use {
        'nvim-treesitter/playground',
		config = function() 
			require "nvim-treesitter.configs".setup {
				playground = {
					enable = true,
					disable = {},
					updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
					persist_queries = false, -- Whether the query persists across vim sessions
					keybindings = {
						toggle_query_editor = 'o',
						toggle_hl_groups = 'i',
						toggle_injected_languages = 't',
						toggle_anonymous_nodes = 'a',
						toggle_language_display = 'I',
						focus_language = 'f',
						unfocus_language = 'F',
						update = 'R',
						goto_node = '<cr>',
						show_help = '?',
					},
				}
			} 
		end
    }

    -- Send-to-repl plugin
    use {
        'hkupty/iron.nvim', 
    }


    -- Telescope fuzzy pickers
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} },
        config = function() require('telescope').setup({}) end
    }

    -- Clipboard history
    use {
        "AckslD/nvim-neoclip.lua",
        requires = {{'nvim-telescope/telescope.nvim'}},
        config = function() require('neoclip').setup{
            history=20,
        } end,
    }

    -- Comment toggle
    use {
        "terrortylor/nvim-comment",
        config = function() require('nvim_comment').setup{
            create_mappings = false,
        } end
    }
    -- Braces auto-pair
    use "jiangmiao/auto-pairs"

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
