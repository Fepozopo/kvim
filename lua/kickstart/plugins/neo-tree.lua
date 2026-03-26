-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

---@module 'lazy'
---@type LazySpec
return {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
        'MunifTanjim/nui.nvim',
    },
    lazy = false,
    keys = {
        { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    },
    ---@module 'neo-tree'
    ---@type neotree.Config
    opts = {
        filesystem = {
            hijack_netrw_behavior = "disabled", -- ensure it doesn't take directory buffers
            window = {
                mappings = {
                    ['\\'] = 'close_window',
                },
            },
            filtered_items = {
                visible = true,         -- Set to true to show hidden files
                hide_dotfiles = false,  -- Show dotfiles
                hide_gitignored = true, -- Show gitignored files
            },
        },
        open_at_startup = false,
    },
}
