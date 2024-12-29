vim.g.mapleader = ","
vim.g.maplocalleader = ","

local mappings = {
	-- my maps
	{ "n", "<C-s>", ":w<cr>" },
	{ "n", "<leader>s", ":%s/" },
	{ "v", "<leader>s", ":s/" },
	{ "n", "<leader><space>", ":nohlsearch<cr>" },
	{ "n", "<C-z>", "<nop>" }, -- disable suspend

	-- yanky
	{ { "n", "x" }, "y", "<Plug>(YankyYank)", { desc = "Yank" } },

	{ { "n", "x" }, "p", "<Plug>(YankyPutAfter)", { desc = "Yank after cursor" } },
	{ { "n", "x" }, "P", "<Plug>(YankyPutBefore)", { desc = "Yank before cursor" } },
	{ { "n", "x" }, "gp", "<Plug>(YankyGPutAfter)", { desc = "Yank after cursor and go to the next line" } },
	{ { "n", "x" }, "gP", "<Plug>(YankyGPutBefore)", { desc = "Yank before cursor and go to the next line" } },

	{ "n", "]p", "<Plug>(YankyPutIndentAfterLinewise)", { desc = "Yank after cursor and indent" } },
	{ "n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)", { desc = "Yank before cursor and indent" } },
	{ "n", "]P", "<Plug>(YankyPutIndentAfterLinewise)", { desc = "Yank after cursor and indent" } },
	{ "n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)", { desc = "Yank before cursor and indent" } },

	{ "n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)", { desc = "Yank after cursor and indent" } },
	{ "n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", { desc = "Yank after cursor and indent" } },
	{ "n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", { desc = "Yank before cursor and indent" } },
	{ "n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", { desc = "Yank before cursor and indent" } },

	{ "n", "=p", "<Plug>(YankyPutAfterFilter)", { desc = "Yank after cursor and filter" } },
	{ "n", "=P", "<Plug>(YankyPutBeforeFilter)", { desc = "Yank before cursor and filter" } },

	{ "n", "<C-p>", "<Plug>(YankyPreviousEntry)", { desc = "Yank previous entry" } },
	{ "n", "<C-n>", "<Plug>(YankyNextEntry)", { desc = "Yank next entry" } },

	{
		{ "o", "x" },
		"lp",
		function()
			require("yanky.textobj").last_put()
		end,
		{ desc = "Last put" },
	},

	-- move lines
	{ "n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" } },
	{ "n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" } },
	{ "i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" } },
	{ "i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" } },
	{ "v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" } },
	{ "v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" } },

	-- move to window using the <ctrl> hjkl keys
	{ "n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true } },
	{ "n", "<C-j>", "<C-w>k", { desc = "Go to lower window", remap = true } },
	{ "n", "<C-k>", "<C-w>j", { desc = "Go to upper window", remap = true } },
	{ "n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true } },

	-- resize window using <ctrl> arrow keys
	{ "n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" } },
	{ "n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" } },
	{ "n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" } },
	{ "n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" } },

	-- split windows
	{ "n", "<space>ws", "<cmd>split<cr>", { desc = "Split window horizontally" } },
	{ "n", "<space>wv", "<cmd>vsplit<cr>", { desc = "Split window vertically" } },

	-- telescope
	{ "n", "<leader>tt", ":Telescope<cr>", { desc = "Telescope" } },
	{ "n", "<leader>tf", ":Telescope find_files<cr>", { desc = "Find files" } },
	{ "n", "<leader>tg", ":Telescope live_grep<cr>", { desc = "Live grep" } },
	{ "n", "<leader>tb", ":Telescope buffers<cr>", { desc = "Buffers" } },
	{ "n", "<leader>th", ":Telescope help_tags<cr>", { desc = "Help tags" } },
	{ "n", "<leader>tu", ":Telescope undo<cr>", { desc = "Undo tree" } },
	{ "n", "<leader>tn", ":Telescope notify<cr>", { desc = "Notification history" } },
	{ "n", "<leader>tc", ":Telescope neoclip<cr>", { desc = "Open neoclip" } },

	-- toggleterm
	{ "t", "<esc><esc>", "<C-\\><C-N>", { desc = "Enter Normal Mode" } },
	{ "t", "<C-t>", "<C-\\><C-N> :ToggleTerm<cr>", { desc = "Close terminal" } },
	{ "n", "<C-t>", ":ToggleTerm size=20 direction=horizontal<cr>", { desc = "Open terminal horizontally" } },
	{ "n", "<S-t>", ":ToggleTerm direction=float<cr>", { desc = "Open terminal in a floating window" } },

	-- lsp
	{ "n", "gD", vim.lsp.buf.declaration, { desc = "Jumps to the declaration" } },
	{ "n", "gd", vim.lsp.buf.definition, { desc = "Jumps to the definition" } },
	{ "n", "gi", vim.lsp.buf.implementation, { desc = "Lists all the implementations" } },
	{ "n", "<space>h", vim.lsp.buf.hover, { desc = "Displays hover information" } },
	{ "n", "<space>D", vim.lsp.buf.type_definition, { desc = "Jumps to the definition of the type" } },
	{ "n", "<space>rn", vim.lsp.buf.rename, { desc = "Renames all references" } },
	{ "n", "<space>ca", vim.lsp.buf.code_action, { desc = "Code actions" } },
	{ "n", "gr", vim.lsp.buf.references, { desc = "Lists all the references" } },
	{ "n", "<space>f", vim.lsp.buf.format, { desc = "Formats a buffer" } },
	{ "n", "<space>e", vim.diagnostic.open_float, { desc = "Show diagnostics in a floating window" } },
	{ "n", "[d", vim.diagnostic.goto_prev, { desc = "Move to the previous diagnostic" } },
	{ "n", "]d", vim.diagnostic.goto_next, { desc = "Move to the next diagnostic" } },
	{ "n", "<space>q", vim.diagnostic.setloclist, { desc = "Add buffer diagnostics to the location list" } },

	-- neogit
	{ "n", "<space>g", ":Neogit<cr>", { desc = "Open Neogit" } },

	-- trouble
	{ "n", "<space>t", ":Trouble<cr>", { desc = "Open Trouble" } },

	-- lazy
	{ "n", "<leader>ll", ":Lazy<cr>", { desc = "Lazy home" } },
	{ "n", "<leader>ls", ":Lazy sync<cr>", { desc = "Lazy sync" } },
	{ "n", "<leader>lc", ":Lazy clear<cr>", { desc = "Lazy clear" } },
	{ "n", "<leader>lu", ":Lazy update<cr>", { desc = "Lazy update" } },
	{ "n", "<leader>lp", ":Lazy profile<cr>", { desc = "Lazy profile" } },
	{ "n", "<leader>li", ":Lazy install<cr>", { desc = "Lazy install" } },

	-- gitsigns
	{ "n", "<leader>gsa", ":Gitsigns attach<cr>", { desc = "Attach" } },
	{ "n", "<leader>gsd", ":Gitsigns detach<cr>", { desc = "Detach" } },
	{ "n", "<leader>gsb", ":Gitsigns blame_line<cr>", { desc = "Blame line" } },
	{ "n", "<leader>gst", ":Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle current line blame" } },

	-- ai
	{ "n", "<leader>ac", ":CopilotChatToggle<cr>", { desc = "Toggle chat" } },
	{
		"n",
		"<leader>ai",
		function()
			local input = vim.fn.input("Ask: ")

			if input ~= "" then
				vim.cmd("CopilotChat " .. input)
			end
		end,
		{ desc = "Ask input" },
	},

	{ "n", "<leader>ab", ":CopilotChatBetterNamings<cr>", { desc = "Better namings" } },
	{ "n", "<leader>ad", ":CopilotChatDebugInfo<cr>", { desc = "Debug info" } },
	{ "n", "<leader>ae", ":CopilotChatExplain<cr>", { desc = "Explain code" } },
	{ { "n", "x" }, "<leader>af", ":CopilotChatFixCode<cr>", { desc = "Fix code" } },
	{ "n", "<leader>aF", ":CopilotChatFixDiagnostic<cr>", { desc = "Fix diagnostic" } },
	{ "n", "<leader>am", ":CopilotChatCommit<cr>", { desc = "Generate commit message" } },
	{ "n", "<leader>aR", ":CopilotChatRefactor<cr>", { desc = "Refactor code" } },
	{ "n", "<leader>ar", ":CopilotChatReview<cr>", { desc = "Review code" } },
	{ "n", "<leader>at", ":CopilotChatTests<cr>", { desc = "Generate tests code" } },

	-- dial
	{
		"n",
		"<C-a>",
		function()
			return require("dial.map").inc_normal()
		end,
		{ expr = true },
	},
	{
		"n",
		"<C-x>",
		function()
			return require("dial.map").dec_normal()
		end,
		{ expr = true },
	},
	{
		"v",
		"<C-a>",
		function()
			return require("dial.map").inc_visual()
		end,
		{ expr = true },
	},
	{
		"v",
		"<C-x>",
		function()
			return require("dial.map").dec_visual()
		end,
		{ expr = true },
	},

	-- cokeline
	{ "n", "<A-,>", "<Plug>(cokeline-focus-prev)", { desc = "Previous buffer", silent = true } },
	{ "n", "<A-.>", "<Plug>(cokeline-focus-next)", { desc = "Next buffer", silent = true } },
	{ "n", "<A-S-,>", "<Plug>(cokeline-switch-prev)", { desc = "Move buffer to left", silent = true } },
	{ "n", "<A-S-.>", "<Plug>(cokeline-switch-next)", { desc = "Move buffer to right", silent = true } },

	-- buffers
	{ "n", "<leader>bd", ":bdelete<cr>", { desc = "Delete buffer" } },
	{ "n", "<leader>bn", ":bnext<cr>", { desc = "Next buffer" } },
	{ "n", "<leader>bp", ":bprevious<cr>", { desc = "Previous buffer" } },
}

-- Which key registers
local wk = require("which-key")
wk.add({
	{ "<leader>a", group = "AI" },
	{ "<leader>b", group = "Buffers" },
	{ "<leader>g", group = "Gitsigns" },
	{ "<leader>l", group = "Lazy" },
	{ "<leader>t", group = "Telescope" },
	{ "<space>w", group = "Windows" },
})

local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }

	if opts then
		options = vim.tbl_extend("force", options, opts)
	end

	vim.keymap.set(mode, lhs, rhs, options)
end

-- cokeline
for i = 1, 9 do
	map(
		"n",
		("<A-%s>"):format(i),
		("<Plug>(cokeline-focus-%s)"):format(i),
		{ desc = ("Focus buffer %s"):format(i), silent = true }
	)
	map(
		"n",
		("<A-S-%s>"):format(i),
		("<Plug>(cokeline-switch-%s)"):format(i),
		{ desc = ("Move buffer to %s"):format(i), silent = true }
	)
end

for _, maps in pairs(mappings) do
	map(unpack(maps))
end
