local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim";
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    });
end
vim.opt.rtp:prepend(lazypath);

vim.g.loaded_netrw = 1;
vim.g.loaded_netrwPlugin = 1;

vim.g.mapleader = " ";

local modes = {"n", "i", "v", "x"}
for _, mode in ipairs(modes) do
    vim.api.nvim_set_keymap(mode, "<C-c>", "<Esc>", { noremap = true, silent = true });
end

vim.cmd("cnoremap <C-a> <Home>");
vim.cmd("cnoremap <C-e> <End>");
vim.cmd("cnoremap <C-f> <Right>");
vim.cmd("cnoremap <C-b> <Left>");

vim.keymap.set("n", "<C-b>", ":b#<CR>");
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv");
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv");
vim.keymap.set("n", "<C-d>", "<C-d>zz");
vim.keymap.set("n", "<C-u>", "<C-u>zz");

vim.keymap.set("n", "<leader>p", "\"+p");
vim.keymap.set("x", "<leader>p", "\"+p");
vim.keymap.set("n", "<leader>y", "\"+y");
vim.keymap.set("v", "<leader>y", "\"+y");

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]);
vim.keymap.set('n', '<leader>fx', function()
    local line = vim.api.nvim_win_get_cursor(0)[1]
    local file = vim.fn.expand('%:p')
    local cmd = {'xed', '--line', tostring(line), file}
    vim.fn.jobstart(cmd, { detach = true })
end, { noremap = true, silent = true })

vim.opt.list = true;
vim.opt.listchars:append "space:⋅";
vim.opt.listchars:append "eol:↴";

vim.opt.tabstop = 4;
vim.opt.shiftwidth = 4;
vim.opt.smartindent = true;
vim.opt.wrap = false;
vim.opt.expandtab = true;

vim.opt.hidden = true;
vim.opt.swapfile = false;
vim.opt.backup = false;
vim.opt.undodir = os.getenv("HOME") .. "/.vim//undodir";
vim.opt.undofile = true;

vim.opt.number = true;
vim.opt.relativenumber = true;
vim.opt.signcolumn = "yes";
vim.opt.cursorline = false;
vim.opt.visualbell = true;

vim.opt.hlsearch = true;
vim.opt.incsearch = true;
vim.opt.ignorecase = true;

vim.opt.termguicolors = true;

vim.opt.mouse = "a";

local local_config_path = vim.fn.getcwd() .. '/local.lua'
if vim.fn.filereadable(local_config_path) == 1 then
    dofile(local_config_path)
end

require("lazy").setup("plugins");
