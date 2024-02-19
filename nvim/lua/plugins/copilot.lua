return {
    {
        "zbirenbaum/copilot.lua",
        enabled = true,
        cmd = "Copilot",
        event = "InsertEnter",
        config = function ()
            require("copilot").setup({
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    debounce = 75,
                    keymap = {
                        accept = "<C-h>",
                        accept_word = false,
                        accept_line = false,
                        -- next = "<C-n>",
                        -- prev = "<C-p>",
                        -- dismiss = "<C-l>",
                    },
                },
            });

            vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#83a598" });
            vim.api.nvim_set_hl(0, "CopilotAnnotation", { fg = "#8398a5" });
        end
    }
}
