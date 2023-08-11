local lsp = require("lsp-zero");
lsp.preset("recommended");
lsp.ensure_installed({
    "tsserver",
    "eslint",
    "clangd",
    "gopls",
    "pyright",
    "rust_analyzer",
    "omnisharp",
});

local cmp = require("cmp");
local cmp_select = { behavior = cmp.SelectBehavior.Select };
lsp.setup_nvim_cmp({
    mapping = lsp.defaults.cmp_mappings({
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-u>"] = cmp.mapping.scroll_docs(-5),
        ["<C-d>"] = cmp.mapping.scroll_docs(5),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-t>"] = cmp.mapping.complete(),
    })
});

lsp.set_preferences({
    suggest_lsp_servers = false
});
lsp.configure("clangd", {});
lsp.configure("gopls", {});
lsp.configure("pyright", {});
lsp.configure("rust_analyzer", {});
lsp.configure("tsserver", {});
lsp.configure("omnisharp", {});
lsp.on_attach(function(_, bufnr)
    local bufopts = { noremap = false, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts);
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts);
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts);
    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts);
    vim.keymap.set("n", "ga", vim.lsp.buf.code_action, bufopts);
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts);
    -- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts);
end);
lsp.nvim_workspace();
lsp.set_sign_icons({
  error = '✘',
  warn = '▲',
  hint = '⚑',
  info = '»'
});
lsp.setup();

vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
});

vim.keymap.set("n", "J", vim.diagnostic.open_float);

