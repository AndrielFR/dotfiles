local lspconfig = require("lspconfig")
local navic = require("nvim-navic")

local servers = {
	"rust_analyzer",
	"basedpyright",
	"clojure_lsp",
	"superhtml",
	"ocamllsp",
	"clangd",
	"lua_ls",
	"gopls",
	"sqlls",
	"ts_ls",
	"ruff",
	"hls",
	"zls",
}

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- LSP settings (for overriding per client)
local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "double" }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "double" }),
}
vim.diagnostic.config({
	float = { border = "double" },
})

local on_attach = function(client, bufnr)
	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end
end

for _, lsp in ipairs(servers) do
	if lsp == "clangd" then
		lspconfig.clangd.setup({
			cmd = { "clangd", "--header-insertion-decorators=false" },
			capabilities = capabilities,
			handlers = handlers,
			on_attach = on_attach,
		})
	elseif lsp == "lua_ls" then
		lspconfig.lua_ls.setup({
			settings = {
				Lua = {
					format = {
						enable = false,
					},
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
			capabilities = capabilities,
			handlers = handlers,
			on_attach = on_attach,
		})
	elseif lsp == "rust_analyzer" then
		lspconfig.rust_analyzer.setup({
			settings = {
				["rust-analyzer"] = {
					cargo = {
						buildScripts = {
							enable = true,
						},
					},
					experimental = {
						procAttrMacros = true,
					},
					diagnostics = {
						experimental = {
							enable = true,
						},
					},
					procMacro = {
						enable = true,
					},
					styleLints = {
						enable = true,
					},
				},
			},
			capabilities = capabilities,
			handlers = handlers,
			on_attach = on_attach,
		})
	else
		lspconfig[lsp].setup({
			capabilities = capabilities,
			handlers = handlers,
			on_attach = on_attach,
		})
	end
end
