return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function ()
            require("neo-tree").setup({
                close_if_last_window = true,
                window = {
                    mappings = {
                        ["<C-c>"] = "cancel",
                    }
                },
                filesystem = {
                    hijack_netrw_behavior = "open_current",
                    window = {
                        fuzzy_finder_mappings = {
                            ["<C-n>"] = "move_cursor_down",
                            ["<C-p>"] = "move_cursor_up",
                        },
                    }
                }
            });

            vim.api.nvim_set_keymap('n', '<leader>e', ':Neotree toggle<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<leader>o', ':Neotree position=current<CR>', { noremap = true, silent = true })
        end,
    }
}

