require('nvim-treesitter.configs').setup({
    ensure_installed = {
        "c",
        "cpp",
        "lua",
        "vim",
        "javascript",
        "typescript",
        "rust",
        "c_sharp",
        "dockerfile",
        "gitignore",
        "starlark",
    },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            node_decremental = "<BS>",
        }
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["aa"] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
                ["ia"] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
                ["la"] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
                ["ra"] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },
                ["ap"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
                ["ip"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },
                ["af"] = { query = "@function.outer", desc = "Select outer part of a function" },
                ["if"] = { query = "@function.inner", desc = "Select inner part of a function" },
                ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
                ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
                ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
                ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },
            },
            selection_modes = {
                ['@parameter.outer'] = 'v', -- charwise
                ['@function.outer'] = 'V', -- linewise
                ['@class.outer'] = '<c-v>', -- blockwise
            },
            include_surrounding_whitespace = true,
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["<leader>jf"] = { query = "@function.outer", desc = "Next method/function def start" },
                ["<leader>ji"] = { query = "@conditional.outer", desc = "Next conditional start" },
                ["<leader>jl"] = { query = "@loop.outer", desc = "Next loop start" },
            },
            goto_next_end = {
                ["<leader>jF"] = { query = "@function.outer", desc = "Next function call end" },
                ["<leader>jI"] = { query = "@conditional.outer", desc = "Next conditional end" },
                ["<leader>jL"] = { query = "@loop.outer", desc = "Next loop end" },
            },
            goto_previous_start = {
                ["<leader>kf"] = { query = "@function.outer", desc = "Prev function call start" },
                ["<leader>ki"] = { query = "@conditional.outer", desc = "Prev conditional start" },
                ["<leader>kl"] = { query = "@loop.outer", desc = "Prev loop start" },
            },
            goto_previous_end = {
                ["<leader>kF"] = { query = "@function.outer", desc = "Prev function call end" },
                ["<leader>kI"] = { query = "@conditional.outer", desc = "Prev conditional end" },
                ["<leader>kL"] = { query = "@loop.outer", desc = "Prev loop end" },
            },
        },
    },
});

local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next);
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous);
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f);
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F);
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t);
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T);
