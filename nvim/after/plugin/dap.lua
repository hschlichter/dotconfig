require("nvim-dap-virtual-text").setup({
    enabled = true,
    enabled_commands = true,
    highlight_changed_variables = true,
    highlight_new_as_changed = true,
    show_stop_reason = true,
    commented = false,
    only_first_definition = false,
    all_references = false,
    virt_text_pos = 'eol',
    all_frames = false,
    virt_lines = false,
    virt_text_win_col = nil,
});

local dapui = require("dapui");
dapui.setup({
    layouts = {
        {
            elements = {
        --         {
        --             id = "repl",
        --             size = 0.3
        --         },
                {
                    id = "watches",
                    size = 0.4
                },
                {
                    id = "stacks",
                    size = 0.6
                }
            },
            position = "left",
            size = 0.2,
        },
        {
            elements = {
                {
                    id = "console",
                    size = 0.5
                },
                {
                    id = "scopes",
                    size = 0.5
                }
            },
            position = "bottom",
            size = 0.3
        }
    }
});

local dap = require("dap");
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#31353f" })
vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })

vim.fn.sign_define("DapBreakpoint", { text="", texthl="DapBreakpoint", linehl="DapBreakpoint", numhl="DapBreakpoint" })
vim.fn.sign_define("DapBreakpointCondition", { text="ﳁ", texthl="DapBreakpoint", linehl="DapBreakpoint", numhl="DapBreakpoint" })
vim.fn.sign_define("DapBreakpointRejected", { text="", texthl="DapBreakpoint", linehl="DapBreakpoint", numhl= "DapBreakpoint" })
vim.fn.sign_define("DapLogPoint", { text="", texthl="DapLogPoint", linehl="DapLogPoint", numhl= "DapLogPoint" })
vim.fn.sign_define("DapStopped", { text="", texthl="DapStopped", linehl="DapStopped", numhl= "DapStopped" })

dap.defaults.fallback.exception_breakpoints = {};
dap.defaults.auto_continue_if_many_stopped = false;
