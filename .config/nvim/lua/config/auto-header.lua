local auto_header = require("auto-header")
auto_header.setup({
    create = true,
    update = true,
    languages = { "python", "rust" },
    templates = {
        {
            language = "*",
            prefix = "auto",
            block_length = 0,
            before = {},
            after = { "" },
            template = {
                "File: #file_relative_path",
                "------------------------------------------",
                "Modified by: #author_name",
                "Last modified: #date_now",
                "------------------------------------------",
                auto_header.licenses["gpl-3.0"],
            },
            track_change = {
                "File: ",
                "Last modified: ",
                "Modified by: ",
                "Copyright ",
            },
        },
        {
            language = "rust",
            prefix = "// ",
            block_length = 0,
            before = {},
            after = { "" },
            template = {
                "File: #file_relative_path",
                "------------------------------------------",
                "Modified by: #author_name",
                "Last modified: #date_now",
                "------------------------------------------",
                auto_header.licenses["gpl-3.0"],
            },
            track_change = {
                "File: ",
                "Modified by: ",
                "Last modified: ",
                "Copyright ",
            },
        },
    },
})
