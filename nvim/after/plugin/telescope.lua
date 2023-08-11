require("telescope").setup({
    defaults = {
        layout_config = {
            vertical = { width = 0.8 }
        }
    },
    pickers = {
        find_files = {
            find_command = {"rg", "--files"},
            previewer = false,
            theme = "ivy"
        },
        buffers = {
            previewer = false,
            theme = "ivy"
        },
        live_grep = {
            theme = "ivy"
        },
        grep_string = {
            theme = "ivy"
        },
        lsp_document_symbols = {
            symbol_width = 75,
            theme = "ivy"
        },
        lsp_dynamic_workspace_symbols = {
            symbol_width = 75,
            theme = "ivy"
        },
        current_buffer_fuzzy_find = {
            theme = "ivy"
        }
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        }
    }
})

require("telescope").load_extension("fzf");
