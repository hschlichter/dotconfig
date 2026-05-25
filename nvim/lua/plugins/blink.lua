-- return {
--     {
--         "saghen/blink.cmp",
--         dependencies = {
--             "saghen/blink.lib",
--         },
--         event = "InsertEnter",
--
--         opts = {
--             keymap = { preset = "default" },
--             sources = {
--                 default = { "lsp", "path" },
--             },
--         },
--     },
-- }

--
-- return {
--     {
--         "saghen/blink.cmp",
--         event = "InsertEnter",
--         build = function() require('blink.cmp').build():wait(60000) end,
--         opts = {
--             keymap = { preset = "default" },
--             sources = {
--                 default = { "lsp", "path" },
--             },
--         },
--     },
-- }


return {
    {
        "saghen/blink.cmp",
        dependencies = {
            "saghen/blink.lib",
        },
        event = "InsertEnter",
        build = function() require('blink.cmp').build():wait(60000) end,
        opts = {
            keymap = { preset = "default" },
            sources = {
                default = { "lsp", "path" },
            },
        },
    },
}
