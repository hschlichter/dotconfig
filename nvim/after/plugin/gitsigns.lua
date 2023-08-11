require("gitsigns").setup({
    signcolumn = true,
    numhl = false,
    linehl = false,
    current_line_blame = true,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 1000,
        ignore_whitespace = false,
    },
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil,
    max_file_length = 40000,
    preview_config = {
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1
    },
    on_attach = function(bufnr)
        local gitsigns = package.loaded.gitsigns;
        local opts = { buffer = bufnr };
        vim.keymap.set("n", "<leader>hp", gitsigns.prev_hunk, opts);
        vim.keymap.set("n", "<leader>hn", gitsigns.next_hunk, opts);
        vim.keymap.set("n", "<leader>hP", gitsigns.preview_hunk, opts);
        vim.keymap.set({"n", "v"}, "<leader>hs", gitsigns.stage_hunk, opts);
        vim.keymap.set({"n", "v"}, "<leader>hr", gitsigns.reset_hunk, opts);
        vim.keymap.set("n", "<leader>hu", gitsigns.undo_stage_hunk, opts);
        vim.keymap.set("n", "<leader>hS", gitsigns.stage_buffer, opts);
        vim.keymap.set("n", "<leader>hR", gitsigns.reset_buffer, opts);
        vim.keymap.set("n", "<leader>hb", function() gitsigns.blame_line{full=true} end, opts);
        vim.keymap.set("n", "<leader>hd", gitsigns.diffthis, opts);
        vim.keymap.set("n", "<leader>hv", gitsigns.toggle_current_line_blame, opts);
    end
});

