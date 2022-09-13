# nvim-config
Neovim configuration files

## Setup
- [Packer](https://github.com/wbthomason/packer.nvim) plugin management
- [which-key](https://github.com/folke/which-key.nvim) shortcut help popup
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) Highlighting, movement, and swap commands
  - [treesitter playground](https://github.com/nvim-treesitter/playground) for help debugging treesitter
- [iron.nvim](https://github.com/hkupty/iron.nvim) REPL plugin
  - Use [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) to have
    send-current-statement to REPL, with auto whitespace stripping for Python.
      - For now, a [custom fork](https://github.com/bnprks/nvim-treesitter-textobjects) to add statement queries to R and Python
  - Also support send visual highlight to REPL
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) fuzzy picker interface for files, ripgrep, symbols, jumplist, and clipboard history
  - [neoclip](https://github.com/AckslD/nvim-neoclip.lua) for clipboard history with telescope
- [nvim-comment](https://github.com/terrortylor/nvim-comment) for comment toggle
- [auto-pairs](https://github.com/jiangmiao/auto-pairs) for bracket auto-pairing
- Theming
  - [VS Code Theme](https://github.com/Mofiqul/vscode.nvim)
  - [Indentation Guides](https://github.com/lukas-reineke/indent-blankline.nvim)
