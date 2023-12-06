return {
    {
        "nvim-tree/nvim-tree.lua",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        keys = function ()
            local api = require("nvim-tree.api");
            vim.keymap.set("n", "<leader>e", api.tree.toggle);
        end,
        config = function ()
            require("nvim-tree").setup({
                disable_netrw = true,
                hijack_netrw = true,
                update_focused_file = {
                    enable = true,
                    update_cwd = false,
                    ignore_list = {},
                },
                git = {
                    enable = false
                },
                actions = {
                    open_file = {
                        resize_window = false
                    }
                },
                on_attach = function (bufnr)
                    local api = require("nvim-tree.api");
                    api.config.mappings.default_on_attach(bufnr);
                end
            });
        end
    }
}

