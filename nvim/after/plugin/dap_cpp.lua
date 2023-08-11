local dap = require("dap");

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
