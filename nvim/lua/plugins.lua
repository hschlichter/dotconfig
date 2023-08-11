require("packer").startup(function(use)
    use("wbthomason/packer.nvim");
    use("EdenEast/nightfox.nvim");
    use("Mofiqul/dracula.nvim");
    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            {"nvim-lua/plenary.nvim"},
            {"nvim-telescope/telescope-fzf-native.nvim", run = "make"}
        }
    });
    use({"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"});
    use("tpope/vim-fugitive");
    use({
        "VonHeikemen/lsp-zero.nvim",
        requires = {
            {"neovim/nvim-lspconfig"},
            {"williamboman/mason.nvim"},
            {"williamboman/mason-lspconfig.nvim"},
            {"hrsh7th/nvim-cmp"},
            {"hrsh7th/cmp-buffer"},
            {"hrsh7th/cmp-path"},
            {"saadparwaiz1/cmp_luasnip"},
            {"hrsh7th/cmp-nvim-lsp"},
            {"hrsh7th/cmp-nvim-lua"},
            {"L3MON4D3/LuaSnip"},
            {"rafamadriz/friendly-snippets"},
        }
    });
    use("nvim-lualine/lualine.nvim");
    use("lukas-reineke/indent-blankline.nvim");
    use("numToStr/Comment.nvim");
    use({
        "nvim-tree/nvim-tree.lua",
        requires = {
            "nvim-tree/nvim-web-devicons",
        }
    });
    use("lewis6991/gitsigns.nvim");
    use("folke/which-key.nvim");
    use("aserowy/tmux.nvim");
    use("mfussenegger/nvim-dap");
    use("rcarriga/nvim-dap-ui");
    use("theHamsta/nvim-dap-virtual-text");
    use("github/copilot.vim");


    use("HampusHauffman/block.nvim");
    use("HampusHauffman/bionic.nvim");
end)

