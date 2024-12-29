local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        -- formatters
        null_ls.builtins.formatting.yapf,
        null_ls.builtins.formatting.zprint,
        null_ls.builtins.formatting.stylua,

        -- code actions
        null_ls.builtins.code_actions.gitsigns,
        require("none-ls-shellcheck.code_actions"),

        -- diagnostics
        require("none-ls.diagnostics.ruff"),
        null_ls.builtins.diagnostics.fish,
        null_ls.builtins.diagnostics.clj_kondo,
        require("none-ls-shellcheck.diagnostics"),
        require("none-ls.diagnostics.cpplint"),

        -- hover
        null_ls.builtins.hover.dictionary,
    },
})
