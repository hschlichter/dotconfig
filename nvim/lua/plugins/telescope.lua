
return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = function ()
            local wrap = function(fn, ...)
                local args = { ... };
                return function()
                    fn(unpack(args));
                end
            end

            local telescope_opt = require('telescope.themes').get_ivy {
                previewer = false,
            };

            local builtin = require("telescope.builtin");
            vim.keymap.set("n", "<C-p>", wrap(builtin.find_files, telescope_opt));
            vim.keymap.set("n", "<C-b>", wrap(builtin.buffers, { sort_lastused = true }));
            vim.keymap.set("n", "<C-t>", builtin.lsp_document_symbols);
            vim.keymap.set("n", "<leader>ff", builtin.live_grep);
            vim.keymap.set("n", "<leader>fs", builtin.grep_string);
            vim.keymap.set("n", "<leader>fb", builtin.current_buffer_fuzzy_find);
            vim.keymap.set("n", "<leader>ft", builtin.lsp_type_definitions);
        end,
        config = function ()
            local telescope = require("telescope");
            telescope.setup({
                defaults = {
                    layout_config = {
                        vertical = { width = 0.8 },
                    }
                },
                pickers = {
                    find_files = {
                        find_command = {"rg", "--files"},
                        previewer = false,
                        theme = "ivy",
                    },
                    buffers = {
                        previewer = false,
                        theme = "ivy",
                    },
                    live_grep = {
                        theme = "ivy",
                    },
                    grep_string = {
                        theme = "ivy",
                    },
                    lsp_document_symbols = {
                        symbol_width = 75,
                        theme = "ivy",
                    },
                    lsp_dynamic_workspace_symbols = {
                        symbol_width = 75,
                        theme = "ivy",
                    },
                    current_buffer_fuzzy_find = {
                        theme = "ivy",
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    }
                }
            })
        end
    }
}

