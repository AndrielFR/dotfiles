local opts = {
    -- open and close
    mkdp_auto_start = 0,
    mkdp_auto_close = 1,

    -- browser
    mkdp_broser = "firefox",

    -- page title
    mkdp_page_title = "Markdown Preview: ${name}",
}

for k, v in pairs(opts) do
    vim.opt[k] = v
end
