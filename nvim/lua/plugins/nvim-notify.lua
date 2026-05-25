return {
    "rcarriga/nvim-notify",
    lazy = true,
    event = "VeryLazy",
    opts = {
        timeout = 3000,
        background_colour = "#000000",
        render = "compact",
        stages = "fade",
        top_down = true,
    },
    config = function(_, opts)
        local notify = require("notify")
        notify.setup(opts)

        vim.notify = notify
    end,
}
