local capabilities = vim.lsp.protocol.make_client_capabilities()

local ok, blink = pcall(require, "blink.cmp")
if ok then
    capabilities = blink.get_lsp_capabilities(capabilities)
end

vim.lsp.config("lua_ls", {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
        },
    },
})

vim.lsp.config("rust_analyzer", {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_markers = { "Cargo.toml", ".git" },
    capabilities = capabilities,
})

vim.lsp.config("clangd", {
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_markers = { ".clangd", "compile_commands.json", "compile_flags.txt", ".git" },
    capabilities = capabilities,
})

vim.lsp.enable("lua_ls")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("clangd")

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local buf = args.buf
        local map = function(lhs, rhs) vim.keymap.set("n", lhs, rhs, { buffer = buf }) end
        map("gd", vim.lsp.buf.definition)
        map("gD", vim.lsp.buf.declaration)
        map("gi", vim.lsp.buf.implementation)
        map("gr", vim.lsp.buf.references)
        map("K",  vim.lsp.buf.hover)
        map("<leader>rn", vim.lsp.buf.rename)
        map("<leader>ca", vim.lsp.buf.code_action)
        map("[d", vim.diagnostic.goto_prev)
        map("]d", vim.diagnostic.goto_next)
    end,
})

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
})
