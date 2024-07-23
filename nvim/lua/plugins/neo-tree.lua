return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        cmd = "Neotree",
        keys = {
            { "<leader>e", ":Neotree toggle<CR>" },
            { "<leader>o", ":Neotree position=current<CR>" },
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
        end,
    }
}

