return {
    {
        "aserowy/tmux.nvim",
        keys = {
            { "<C-h>", function() require("tmux").move_left() end, mode = "n", desc = "Move to left pane" },
            { "<C-j>", function() require("tmux").move_bottom() end, mode = "n", desc = "Move to bottom pane" },
            { "<C-k>", function() require("tmux").move_top() end, mode = "n", desc = "Move to top pane" },
            { "<C-l>", function() require("tmux").move_right() end, mode = "n", desc = "Move to right pane" },
            { "<C-left>", function() require("tmux").resize_left() end, mode = "n", desc = "Resize left" },
            { "<C-down>", function() require("tmux").resize_bottom() end, mode = "n", desc = "Resize down" },
            { "<C-up>", function() require("tmux").resize_top() end, mode = "n", desc = "Resize up" },
            { "<C-right>", function() require("tmux").resize_right() end, mode = "n", desc = "Resize right" },
        },
        config = function ()
            local tmux = require("tmux");
            tmux.setup({
                copy_sync = {
                    enable = true,
                    ignore_buffers = { empty = false },
                    redirect_to_clipboard = false,
                    register_offset = 0,
                    sync_clipboard = true,
                    sync_registers = true,
                    sync_deletes = true,
                    sync_unnamed = true,
                },
                navigation = {
                    cycle_navigation = false,
                    enable_default_keybindings = false,
                    persist_zoom = false,
                },
                resize = {
                    enable_default_keybindings = false,
                    resize_step_x = 5,
                    resize_step_y = 5,
                }
            });
        end
    }
}
