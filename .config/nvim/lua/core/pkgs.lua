return {
	-- lsp and completions
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("config.lsp")
		end,
		dependencies = {
			{
				"nvimtools/none-ls.nvim",
				config = function()
					require("config.null-ls")
				end,
			},
			"nvimtools/none-ls-extras.nvim",
			"gbprod/none-ls-shellcheck.nvim",
			{
				"j-hui/fidget.nvim",
				config = true,
			},
			"SmiteshP/nvim-navic",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			-- sources
			"FelipeLema/cmp-async-path",
			"andersevenrud/cmp-tmux",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-buffer",
			"mtoohey31/cmp-fish",
			"chrisgrieser/cmp_yanky",

			-- supermaven
			{
				"supermaven-inc/supermaven-nvim",
				config = function()
					require("supermaven-nvim").setup({
						log_level = "off",
						disable_keymaps = true,
						disable_inline_completion = true,
					})
				end,
			},

			-- copilot
			{
				"zbirenbaum/copilot-cmp",
				config = function()
					require("copilot_cmp").setup()
				end,
			},

			-- snippets
			{
				"dcampos/cmp-snippy",
				dependencies = {
					"honza/vim-snippets",
					"dcampos/nvim-snippy",
				},
			},

			-- rust
			{
				"saecki/crates.nvim",
				event = { "BufRead Cargo.toml" },
				config = function()
					require("crates").setup({
						completion = {
							crates = {
								enabled = true,
								max_results = 8,
								min_chars = 3,
							},
							cmp = {
								enabled = true,
							},
						},
						null_ls = {
							enabled = true,
						},
					})
				end,
			},
		},
		config = function()
			require("config.cmp")
		end,
	},
	{
		"folke/trouble.nvim",
		cmd = { "Trouble" },

		config = function()
			require("trouble").setup({
				fold_open = "",
				fold_closed = "",
				indent_lines = false,
				signs = {
					error = "",
					warning = "",
					hint = "",
					information = "",
					other = "﫠",
				},
			})
			vim.api.nvim_set_hl(0, "TroubleText", {})
			vim.api.nvim_set_hl(0, "TroubleIndent", {})
			vim.api.nvim_set_hl(0, "TroubleLocation", {})
			vim.api.nvim_set_hl(0, "TroubleFoldIcon", {})
		end,
	},

	-- visual
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("config.treesitter")
		end,
		build = function()
			vim.cmd.TSUpdate()
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup()
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		opts = require("config.devicons"),
	},
	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			filetypes = {
				"*",
				"!lazy",
			},
			user_default_options = {
				names = false,
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = require("config.lualine"),
	},
	{
		"stevearc/dressing.nvim",
		config = function()
			require("dressing").setup({
				input = {
					border = "double",
					-- 'editor' and 'win' will default to being centered
					relative = "win",
				},
			})
		end,
	},
	{
		"m-demare/hlargs.nvim",
		config = function()
			require("hlargs").setup()
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			cmdline = {
				view = "cmdline",
			},
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",

			{
				"rcarriga/nvim-notify",
				lazy = false,
				config = function()
					local notify = require("notify")
					notify.setup({
						stages = "fade",
						timeout = 5000,
						background_colour = "#1f2335",
						icons = {
							ERROR = "",
							WARN = "",
							INFO = "",
							DEBUG = "",
							TRACE = "﫠",
						},
					})

					vim.notify = notify
				end,
			},
		},
	},
	{
		"navarasu/onedark.nvim",
		priority = 1000,
		config = function()
			require("onedark").setup({
				style = "darker",
				transparent = true,
				lualine = {
					transparent = true,
				},
			})
			vim.cmd("colorscheme onedark")
		end,
	},
	{
		"lcheylus/overlength.nvim",
		config = function()
			require("overlength").setup({
				colors = {
					ctermfg = nil,
					ctermbg = "darkgrey",
					fg = "#ca8787",
					bg = "#1f2335",
				},
			})
		end,
	},
	{
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure({
				under_cursor = false,
				filetypes_denylist = {
					"netrw",
					"dirbuf",
					"dirvish",
					"fugitive",
					"startify",
				},
			})
		end,
	},
	{
		"mawkler/modicator.nvim",
		after = "onedark.nvim",
		config = function()
			require("modicator").setup()
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {},
	},

	-- git
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		opts = {
			trouble = false,
			current_line_blame = true,
			current_line_blame_opts = {
				virt_text = true,
				delay = 100,
			},
			preview_config = {
				border = "double",
			},
		},
	},
	{
		"TimUntersberger/neogit",
		cmd = "Neogit",
		config = function()
			require("neogit").setup({
				kind = "auto",
				mappings = {
					status = {
						["1"] = false,
						["2"] = false,
						["3"] = false,
						["4"] = false,

						["<space>1"] = "Depth1",
						["<space>2"] = "Depth2",
						["<space>3"] = "Depth3",
						["<space>4"] = "Depth4",
					},
				},
				integrations = {
					telescope = true,
				},
			})
		end,
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "NeogitPopup",
				callback = function()
					vim.opt_local.list = false
				end,
			})
		end,
	},

	-- life quality
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			"debugloop/telescope-undo.nvim",
			{
				"AckslD/nvim-neoclip.lua",
				config = function()
					require("neoclip").setup({
						default_register = "+",
					})
				end,
			},
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
		config = function()
			require("config.telescope")
		end,
	},
	{
		"willothy/nvim-cokeline",
		config = function()
			require("config.cokeline")
		end,
	},
	{ "mcauley-penney/tidy.nvim", event = "BufWritePre", config = true },
	{
		"akinsho/toggleterm.nvim",
		cmd = "ToggleTerm",
		opts = {
			shade_terminals = false,
			persist_mode = false,
			float_opts = {
				border = "double",
			},
		},
	},
	{
		"monaqa/dial.nvim",
		lazy = true,
		config = function()
			require("config.dial")
		end,
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		opts = {
			provider_selector = function(_, _, _)
				return { "treesitter", "indent" }
			end,
		},
	},
	{
		"numToStr/Comment.nvim",
		keys = {
			{ "gc", mode = { "n", "v" } },
			{ "gb", mode = { "n", "v" } },
		},
		config = true,
	},
	{ "folke/which-key.nvim", lazy = true, config = true }, -- required in keybinds.lua
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("config.autopairs")
		end,
	},
	{ "windwp/nvim-ts-autotag", config = true },
	{
		"folke/ts-comments.nvim",
		event = "VeryLazy",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
		opts = {},
	},
	{
		"Olical/conjure",
		init = function()
			-- conjure
			vim.g["conjure#filetype#scheme"] = "conjure.client.guile.socket"
			vim.g["conjure#client#guile#socket#pipename"] = ".guile-repl.socket"
			vim.api.nvim_create_autocmd("BufNewFile", {
				pattern = "conjure-log-*",
				callback = function()
					vim.diagnostic.disable(0)
				end,
			})
		end,
		ft = {
			"clojure",
			"scheme",
			"fennel",
			"lisp",
		},
	},
	{
		"Grafcube/suedit.nvim",
		opts = { cmd = "doas" },
	},
	{
		"ggandor/leap.nvim",
		dependencies = {
			"tpope/vim-repeat",
		},
		config = function()
			require("leap").create_default_mappings()
		end,
	},
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		cmd = "ConformInfo",
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "n",
				desc = "Format buffer",
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff" },
				rust = { "rustfmt" },
				toml = { "tomlq" },
				markdown = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				php = { "prettier" },
				go = { "gofmt" },
				sql = { "sqlformat" },
				dockerfile = { "dockerfilelint" },
				vim = { "vimfmt" },
			},
			format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
		},
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
	{
		"mhinz/vim-startify",
	},
	"mateuszwieloch/automkdir.nvim",
	{
		"rmagatti/auto-session",
		lazy = false,
		opts = {},
	},
	{
		"okuuva/auto-save.nvim",
		event = { "InsertLeave", "TextChanged" },
		opts = {},
	},
	{
		"gbprod/yanky.nvim",
		opts = {},
	},
	{
		"zongben/capsoff.nvim",
		build = ":CapsLockOffBuild",
		config = function()
			require("capsoff").setup()
		end,
	},

	-- documents
	{
		"vhyrro/luarocks.nvim",
		priority = 1000,
		config = true,
	},
	{
		"nvim-neorg/neorg",
		ft = "norg",
		lazy = false,
		dependencies = { "luarocks.nvim" },
		build = function()
			vim.cmd.Neorg("sync-parsers")
		end,
		config = true,
	},

	-- ai
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup()
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		build = "make tiktoken",
		opts = {
			question_header = "  User",
			answer_header = "  Copilot",
			prompts = {
				Explain = "Please explain how the following code works.",
				Review = "Please review the following code and provide suggestions for improvement.",
				Tests = "Please explain how the selected code works, then generate unit tests for it.",
				Refactor = "Please refactor the following code to improve its clarity and readability.",
				FixCode = "Please fix the following code to make it work as intended.",
				FixError = "Please explain the error in the following text and provide a solution.",
				BetterNamings = "Please provide better names for the following variables and functions.",
				Documentation = "Please provide documentation for the following code.",
				SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
				SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
				Summarize = "Please summarize the following text.",
				Spelling = "Please correct any grammar and spelling errors in the following text.",
				Wording = "Please improve the grammar and wording of the following text.",
				Concise = "Please rewrite the following text to make it more concise.",
			},
			mappings = {},
		},
	},

	-- deps
	{ "nvim-lua/plenary.nvim", lazy = true },
}
