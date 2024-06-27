return {
    {
        "numToStr/Comment.nvim",
        config = function ()
            require('Comment').setup({});
        end
    },
    {
        "zbirenbaum/copilot-cmp",
        config = function ()
            require("copilot_cmp").setup()
        end
    },
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/nvim-cmp",
            "L3MON4D3/LuaSnip",
            "zbirenbaum/copilot-cmp",
        },
        config = function ()
            local lsp_zero = require('lsp-zero');

            lsp_zero.on_attach(function(client, bufnr)
                local bufopts = { noremap = false, silent = true, buffer = bufnr }
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts);
                vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts);
                vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, bufopts);
                vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, bufopts);
                vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, bufopts);
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts);
                vim.keymap.set("n", "<leader>rs", ":LspRestart<cr>", bufopts);

                local telescope = require("telescope.builtin");
                local telescope_opt = require('telescope.themes').get_ivy {
                    previewer = false,
                };

                local wrap = function(fn, ...)
                    local args = { ... };
                    return function()
                        fn(unpack(args));
                    end
                end

                vim.keymap.set("n", "gd", wrap(telescope.lsp_definitions, bufopts));
                vim.keymap.set("n", "gr", wrap(telescope.lsp_references, bufopts));
                vim.keymap.set("n", "gt", wrap(telescope.lsp_type_definitions, bufopts));
                vim.keymap.set("n", "gi", wrap(telescope.lsp_implementations, bufopts));
                vim.keymap.set("n", "<leader>D", wrap(telescope.diagnostics, telescope_opt));
            end);

            lsp_zero.set_sign_icons({
              error = '✘',
              warn = '▲',
              hint = '⚑',
              info = '»'
            });

            require('mason').setup({});
            require('mason-lspconfig').setup({
                ensure_installed = {
                    "rust_analyzer",
                    "clangd",
                },
                handlers = {
                    lsp_zero.default_setup,
                    lua_ls = function()
                        local lua_opts = lsp_zero.nvim_lua_ls();
                        require('lspconfig').lua_ls.setup(lua_opts);
                    end,
                },
            });

            local cmp = require('cmp')
            cmp.setup({
                sources = {
                    -- Copilot Source
                    -- { name = "copilot", group_index = 1 },
                    -- Other Sources
                    { name = "nvim_lsp", group_index = 1 },
                    { name = "luasnip", group_index = 1 },
                    { name = "path", group_index = 2 },
                },
                preselect = cmp.PreselectMode.None,
                completion = {
                    completeopt = 'menu,menuone,noselect,noinsert'
                },
                formatting = lsp_zero.cmp_format(),
                window = {
                    completion = cmp.config.window.bordered({
                        border = "none",
                        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
                    }),
                    documentation = cmp.config.window.bordered({
                        border = "none",
                        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
                    }),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<C-u>"] = cmp.mapping.scroll_docs(-5),
                    ["<C-d>"] = cmp.mapping.scroll_docs(5),
                    ['<C-g>'] = function()
                        if cmp.visible_docs() then
                            cmp.close_docs()
                        else
                            cmp.open_docs()
                        end
                    end,
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                    ["<C-t>"] = cmp.mapping.complete(),
                }),
                experimental = {
                    ghost_text = true,
                },
            });
        end
    },
}
