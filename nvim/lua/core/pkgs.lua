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
			-- snippets
			"dcampos/nvim-snippy",

			-- sources
			"FelipeLema/cmp-async-path",
			"andersevenrud/cmp-tmux",
			{
				"zbirenbaum/copilot-cmp",
				config = function()
					require("copilot_cmp").setup()
				end,
			},
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-cmdline",
			"dcampos/cmp-snippy",
			"hrsh7th/cmp-buffer",
			"mtoohey31/cmp-fish",

			-- rust
			{
				"saecki/crates.nvim",
				event = { "BufRead Cargo.toml" },
				config = function()
					require("crates").setup({
						completion = {
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
		cmd = { "TroubleToggle" },

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
	--[[ {
		"Mofiqul/adwaita.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.adwaita_darker = true
			vim.g.adwaita_transparent = true
			vim.cmd("colorscheme adwaita")
		end,
	}, ]]
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
		"mhinz/vim-startify",
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

	-- deps
	{ "nvim-lua/plenary.nvim", lazy = true },
}
