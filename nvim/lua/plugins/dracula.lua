return {
    {
        "Mofiqul/dracula.nvim",
        lazy = false,
        priority = 1000,
        config = function ()
            vim.opt.termguicolors = true;
            vim.cmd("colorscheme dracula");
            vim.api.nvim_set_hl(0, 'Visual', { bg = '#666666', fg = 'NONE' })
            vim.api.nvim_set_hl(0, 'Search', { bg = '#ffff00', fg = '#bbbb11', underline = false })
        end
    }
}
