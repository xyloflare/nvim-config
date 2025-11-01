return {
	{
		"hrsh7th/cmp-nvim-lsp",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "antosha417/nvim-lsp-file-operations", config = true },
			{ "folke/lazydev.nvim", opts = {} },
		},
		config = function()
			-- import cmp-nvim-lsp plugin
			local cmp_nvim_lsp = require("cmp_nvim_lsp")

			-- used to enable autocompletion (assign to every lsp server config)
			local capabilities = cmp_nvim_lsp.default_capabilities()

			vim.lsp.config("*", {
				capabilities = capabilities,
			})

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>mn", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>rf", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			-- list of servers for mason to install
			ensure_installed = {
				"ts_ls",
				"html",
				"cssls",
				"tailwindcss",
				--"svelte",
				"lua_ls",
				--"graphql",
				--"emmet_ls",
				--"prismals",
				--"pyright",
				"eslint",
			},
		},
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = {
					ui = {
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗",
						},
					},
				},
			},
			"neovim/nvim-lspconfig",
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				--"isort", -- python formatter
				--"black", -- python formatter
				--"pylint",
				"eslint_d",
			},
		},
		dependencies = {
			"williamboman/mason.nvim",
		},
	},
}
