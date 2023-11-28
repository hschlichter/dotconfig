vim.g.loaded_netrw = 1;
vim.g.loaded_netrwPlugin = 1;

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

        -- vim.keymap.set("n", "<leader>e", api.tree.toggle);
    end
});

local api = require("nvim-tree.api");
vim.keymap.set("n", "<leader>e", api.tree.toggle);

