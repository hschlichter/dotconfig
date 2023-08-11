local wrap = function(fn, ...)
    local args = { ... };
    return function()
        fn(unpack(args));
    end
end

vim.g.mapleader= " ";

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv");
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv");

vim.keymap.set("n", "<leader>p", "\"+p<cr>");
vim.keymap.set("n", "<leader>y", "\"+y");

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]);

local nvimtree = require("nvim-tree.api");
vim.keymap.set("n", "<leader>e", nvimtree.tree.toggle);

local tmux = require("tmux");
vim.keymap.set("n", "<C-h>", tmux.move_left);
vim.keymap.set("n", "<C-j>", tmux.move_bottom);
vim.keymap.set("n", "<C-k>", tmux.move_top);
vim.keymap.set("n", "<C-l>", tmux.move_right);
vim.keymap.set("n", "<C-left>", tmux.resize_left);
vim.keymap.set("n", "<C-down>", tmux.resize_bottom);
vim.keymap.set("n", "<C-up>", tmux.resize_top);
vim.keymap.set("n", "<C-right>", tmux.resize_right);

local telescope = require("telescope.builtin");
vim.keymap.set("n", "<C-p>", telescope.find_files);
vim.keymap.set("n", "<C-b>", wrap(telescope.buffers, { sort_lastused = true }));
vim.keymap.set("n", "<C-t>", telescope.lsp_document_symbols);
vim.keymap.set("n", "<leader>ff", telescope.live_grep);
vim.keymap.set("n", "<leader>fs", telescope.grep_string);
vim.keymap.set("n", "<leader>fb", telescope.current_buffer_fuzzy_find);
vim.keymap.set("n", "<leader>ft", telescope.lsp_dynamic_workspace_symbols);

vim.keymap.set("n", "<leader>o", ":ClangdSwitchSourceHeader<cr>");

local dap = require("dap");
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint);
vim.keymap.set("n", "<leader>dc", dap.continue);
vim.keymap.set("n", "<leader>dn", dap.step_over);
vim.keymap.set("n", "<leader>ds", dap.step_into);
vim.keymap.set("n", "<leader>do", dap.step_out);
vim.keymap.set("n", "<leader>dx", dap.terminate);
vim.keymap.set("n", "<leader>dl", dap.run_last);

local dapui = require("dapui");
vim.keymap.set("n", "<leader>dt", dapui.toggle);

vim.keymap.set("n", "<leader>dwb", wrap(dapui.float_element, "breakpoints", { width=100, height=10, enter=true, position="center" }));
vim.keymap.set("n", "<leader>dww", wrap(dapui.float_element, "watches", { width=100, height=20, enter=true, position="center" }));
vim.keymap.set("n", "<leader>dws", wrap(dapui.float_element, "scopes", { enter=true }));
vim.keymap.set("n", "<leader>dwr", wrap(dapui.float_element, "repl", { enter=true }));
vim.keymap.set("n", "<leader>dwc", wrap(dapui.float_element, "console", { enter=true, width=160, height=80, position="center" }));

vim.keymap.set("n", "<leader>k", dapui.eval);

