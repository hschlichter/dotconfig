return {
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            { "<leader>ff", ":lua require('fzf-lua').files({ winopts = { preview = { hidden = 'true' } } })<CR>", desc = "Find files" },
            { "<leader>fb", ":lua require('fzf-lua').buffers()<CR>", desc = "Find in buffers" },
            { "<leader>fl", ":lua require('fzf-lua').lines()<CR>", desc = "Find in open buffers lines" },
            { "<leader>fr", ":lua require('fzf-lua').resume()<CR>", desc = "Resume last" },
            { "<leader>gg", ":lua require('fzf-lua').grep()<CR>", desc = "Grep in files" },
            { "<leader>gw", ":lua require('fzf-lua').grep_cword()<CR>", desc = "Grep in files for word under cursor" },
            { "<leader>gl", ":lua require('fzf-lua').live_grep_glob()<CR>", desc = "Live grep in project" },
            { "<leader>gr", ":lua require('fzf-lua').live_grep_resume()<CR>", desc = "Resume last live grep" },
        },
        config = function()
            require("fzf-lua").setup({
                winopts = {
                    row = 1,
                    col = 0,
                    height = 0.5,
                    width = 1,
                    border = 'none',
                    preview = {
                        layout = 'horizontal', -- Layout of the preview window (can be 'vertical' or 'horizontal')
                        horizontal = 'right:40%', -- Adjust width when layout is 'horizontal'
                    },
                }
            })
        end
    }
}
