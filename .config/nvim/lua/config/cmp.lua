local snippy = require("snippy")

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local kind_icons = {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
	Copilot = "",
	Supermaven = "",
}

local cmp = require("cmp")
cmp.setup({
	window = {
		completion = {
			border = "double",
		},
		documentation = {
			border = "double",
		},
	},
	formatting = {
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind

			-- Source
			vim_item.menu = ({
				buffer = "[Buffer]",
				cmp_yanky = "[Yank]",
				crates = "[Crates]",
			})[entry.source.name]
			return vim_item
		end,
	},
	enabled = function()
		-- disable autocompletion in prompt (wasn't playing good with telescope)
		local buftype = vim.api.nvim_buf_get_option(0, "buftype")

		if buftype == "prompt" then
			return false
		end

		-- disable autocompletion in comments
		local context = require("cmp.config.context")

		-- keep command mode completion enabled when cursor is in a comment
		if vim.api.nvim_get_mode().mode == "c" then
			return true
		else
			return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
		end
	end,
	snippet = {
		expand = function(args)
			snippy.expand_snippet(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-e>"] = cmp.mapping.close(),
		["<C-j>"] = cmp.mapping.scroll_docs(4),
		["<C-k>"] = cmp.mapping.scroll_docs(-4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() and has_words_before() then
				cmp.select_next_item()
			elseif snippy.can_expand_or_advance() then
				snippy.expand_or_advance()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif snippy.can_jump(-1) then
				snippy.previous()
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "async_path" },
		{ name = "tmux" },
		{ name = "supermaven" },
		{ name = "copilot" },
		{ name = "nvim_lsp" },
		{ name = "snippy" },
		{ name = "buffer" },
		{ name = "neorg" },
		{ name = "cmp_yanky" },
		{ name = "fish" },
		{ name = "crates" },
	},
	sorting = {
		comparators = {
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.sort_text,
			cmp.config.compare.score,
			cmp.config.compare.recently_used,
			cmp.config.compare.kind,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "async_path" },
		{ name = "cmdline" },
	},
})

cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

cmp.setup.filetype("gitcommit", {
	sources = {
		{ name = "git" },
		{ name = "buffer" },
	},
})

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
vim.api.nvim_set_hl(0, "CmpItemKindSupermaven", { fg = "#6CC644" })
