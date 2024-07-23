return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })()
        end,
        config = function ()
            require('nvim-treesitter.configs').setup({
                ensure_installed = {
                    "c",
                    "cpp",
                    "lua",
                    "vim",
                    "javascript",
                    "typescript",
                    "rust",
                    "dockerfile",
                    "gitignore",
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
            });
        end
    }}
