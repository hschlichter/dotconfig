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
local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
    sources = {
        {name = 'path'},
        {name = 'nvim_lsp'},
        {name = 'nvim_lua'},
    },
    formatting = lsp_zero.cmp_format(),
    mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
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
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-t>"] = cmp.mapping.complete(),
    }),
});
