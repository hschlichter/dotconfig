return {
    {
        "mfussenegger/nvim-dap",
        config = function ()
            local dap = require("dap");

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

            dap.adapters.codelldb = {
                type = "server",
                port = "${port}",
                executable = {
                    command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/codelldb",
                    args = {
                        "--port",
                        "${port}"
                    }
                }
            };

            dap.configurations.cpp = {
                {
                    name = "Launch",
                    type = "codelldb",
                    request = "launch",
                    expressions = "native",
                    program = function ()
                        return vim.fn.input("Exe: ", "", "file");
                    end,
                    args = function ()
                        local argv = vim.fn.input("Args: ");
                        local out = {};
                        for w in string.gmatch(argv, "%S+") do
                            table.insert(out, w);
                        end
                        return out;
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    console = "internalConsole",
                },
                {
                    name = "Attach",
                    type = "codelldb",
                    request = "attach",
                    args = {},
                    pid = require("dap.utils").pick_process,
                },
            };
            dap.configurations.c = dap.configurations.cpp;
            dap.configurations.rust = dap.configurations.cpp;
        end,
        keys = function ()
            local wrap = function(fn, ...)
                local args = { ... };
                return function()
                    fn(unpack(args));
                end
            end

            local dap = require("dap");
            vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint);
            vim.keymap.set("n", "<leader>dc", dap.continue);
            vim.keymap.set("n", "<leader>dn", dap.step_over);
            vim.keymap.set("n", "<leader>ds", dap.step_into);
            vim.keymap.set("n", "<leader>do", dap.step_out);
            vim.keymap.set("n", "<leader>dx", dap.terminate);
            vim.keymap.set("n", "<leader>dl", dap.run_last);
            vim.keymap.set("n", "<leader>dr", wrap(dap.repl.toggle, { height = 10 }));

            vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
                require('dap.ui.widgets').hover();
            end)
        end
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        config = function ()
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
                all_frames = true,
                virt_lines = false,
                virt_text_win_col = nil,
            });
        end
    },
}
