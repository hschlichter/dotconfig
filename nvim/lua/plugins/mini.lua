return {
    {
        "echasnovski/mini.files",
        version = false,
        keys = {
            { "<leader>o", function () MiniFiles.open() end },
            { "<leader>O", function () MiniFiles.open(vim.api.nvim_buf_get_name(0)) end },
        },
        config = function ()
            require("mini.files").setup({
                content = {
                    filter = nil,
                    prefix = nil,
                    sort = nil,
                },
                mappings = {
                    close       = "q",
                    go_in       = "l",
                    go_in_plus  = "L",
                    go_out      = "h",
                    go_out_plus = "H",
                    mark_goto   = "'",
                    mark_set    = "m",
                    reset       = "<BS>",
                    reveal_cwd  = "@",
                    show_help   = "g?",
                    synchronize = "=",
                    trim_left   = "<",
                    trim_right  = ">",
                },
                options = {
                    permanent_delete = true,
                    use_as_default_explorer = true,
                },
                windows = {
                    max_number = math.huge,
                    preview = false,
                    width_focus = 50,
                    width_nofocus = 15,
                    width_preview = 25,
                },
            })
        end
    },
    {
        "echasnovski/mini.ai",
        version = false,
        config = function ()
            require("mini.ai").setup({
                {
                    custom_textobjects = nil,
                    mappings = {
                        around = "a",
                        inside = "i",
                        around_next = "an",
                        inside_next = "in",
                        around_last = "al",
                        inside_last = "il",
                        goto_left = "g[",
                        goto_right = "g]",
                    },
                    n_lines = 50,
                    search_method = "cover_or_next",
                    silent = false,
                }
            })
        end
    },
    {
        "echasnovski/mini.surround",
        version = false,
        config = function ()
            require("mini.surround").setup({
                custom_surroundings = nil,
                highlight_duration = 500,
                mappings = {
                    add = "sa",
                    delete = "sd",
                    find = "sf",
                    find_left = "sF",
                    highlight = "sh",
                    replace = "sr",
                    update_n_lines = "sn",
                    suffix_last = "l",
                    suffix_next = "n",
                },
                n_lines = 20,
                respect_selection_type = false,
                search_method = "cover",
                silent = false,
            })
        end
    },
    {
        "echasnovski/mini.jump",
        version = false,
        config = function ()
            require("mini.jump").setup({
                mappings = {
                    forward = 'f',
                    backward = 'F',
                    forward_till = 't',
                    backward_till = 'T',
                    repeat_jump = ';',
                },
                delay = {
                    highlight = 250,
                    idle_stop = 10000000,
                }
            })
        end
    }
}
