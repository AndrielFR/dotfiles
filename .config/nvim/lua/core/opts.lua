local opts = {
	-- tabs
	tabstop = 4,
	shiftwidth = 4,
	expandtab = true,

	-- numbers
	number = true,
	relativenumber = true,

	-- folding
	foldlevel = 99,
	foldlevelstart = 99,
	foldenable = true,

	-- misc
	list = true,
	wrap = false,
	confirm = true,
	swapfile = false,
	shortmess = "I",
	scrolloff = 8,
	cursorline = true,
	inccommand = "split",
	clipboard = "unnamedplus",
	termguicolors = true,
	fillchars = { eob = " " },
}

for k, v in pairs(opts) do
	vim.opt[k] = v
end

-- remove the "How-to disable mouse"
vim.cmd.aunmenu("PopUp.How-to\\ disable\\ mouse")
vim.cmd.aunmenu("PopUp.-1-")

-- enable inlay hints
if vim.lsp.inlay_hint then
	vim.lsp.inlay_hint.enable(true, { 0 })
end
