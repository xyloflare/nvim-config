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

			-- vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			-- vim.keymap.set("n", "<leader>mn", vim.lsp.buf.definition, {})
			-- vim.keymap.set("n", "<leader>rf", vim.lsp.buf.references, {})
			-- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Buffer local mappings
					local opts = { buffer = ev.buf, silent = true }

					-- Keymaps
					opts.desc = "Show LSP references"
					vim.keymap.set("n", "rf", "<cmd>Telescope lsp_references<CR>", opts)

					opts.desc = "Go to declaration"
					vim.keymap.set("n", "Gd", vim.lsp.buf.declaration, opts)

					opts.desc = "Show LSP definitions"
					vim.keymap.set("n", "mn", "<cmd>Telescope lsp_definitions<CR>", opts)

					opts.desc = "Show LSP implementations"
					vim.keymap.set("n", "Gi", "<cmd>Telescope lsp_implementations<CR>", opts)

					opts.desc = "Show LSP type definitions"
					vim.keymap.set("n", "Gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

					opts.desc = "See available code actions"
					vim.keymap.set({ "n", "v" }, "<leader>ca", function()
						vim.lsp.buf.code_action()
					end, opts)

					opts.desc = "Smart rename"
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

					opts.desc = "Show buffer diagnostics"
					vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

					opts.desc = "Show line diagnostics"
					vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

					opts.desc = "Show documentation for what is under cursor"
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

					opts.desc = "Restart LSP"
					vim.keymap.set("n", "<leader>rs", ":lsp restart<CR>", opts)

					vim.keymap.set("i", "<C-h>", function()
						vim.lsp.buf.signature_help()
					end, opts)
				end,
			})

			local signs = {
				[vim.diagnostic.severity.ERROR] = " ",
				[vim.diagnostic.severity.WARN] = " ",
				[vim.diagnostic.severity.HINT] = "󰠠 ",
				[vim.diagnostic.severity.INFO] = " ",
			}

			-- update diagnostic config function
			vim.diagnostic.config({
				signs = { text = signs },
				virtual_text = true,
				underline = true, -- Always on
				update_in_insert = true,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = true,
				},
			})

			vim.lsp.config("astro", {
				filetypes = { "astro" },

				init_options = {
					typescript = {
						tsdk = vim.fn.stdpath("data")
							.. "/mason/packages/typescript-language-server/node_modules/typescript/lib",
					},
				},
			})
			vim.lsp.config("tailwindcss", {
				filetypes = {
					"html",
					"css",
					"javascript",
					"typescript",
					"javascriptreact",
					"typescriptreact",
					"svelte",
					"vue",
					"astro",
				},
				init_options = {
					userLanguages = {
						astro = "html",
					},
				},
			})
			vim.lsp.config("gopls", {
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
						gofumpt = true,
					},
				},
			})
			vim.lsp.config("cssls", {
				filetypes = { "css", "scss", "less" },
				init_options = { provideFormatter = true },
				single_file_support = true,
				settings = {
					css = {
						lint = {
							unknownAtRules = "ignore",
						},
						validate = true,
					},
					scss = {
						lint = {
							unknownAtRules = "ignore",
						},
						validate = true,
					},
					less = {
						lint = {
							unknownAtRules = "ignore",
						},
						validate = true,
					},
				},
			})
			vim.lsp.config("ts_ls", {
				filetypes = {
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
				},
				single_file_support = true,
				init_options = {
					preferences = {
						includeCompletionsForModuleExports = true,
						includeCompletionsForImportStatements = true,
					},
				},
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayVariableTypeHints = true,
							includeInlayFunctionParameterTypeHints = true,
						},
					},
					javascript = {
						validate = {
							enable = true,
						},
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayVariableTypeHints = true,
						},
					},
				},
			})
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						completion = {
							callSnippet = "Replace",
						},
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
						},
					},
				},
			})
		end,
	},
	-- {
	-- 	"williamboman/mason-lspconfig.nvim",
	-- 	opts = {
	-- 		-- list of servers for mason to install
	-- 		ensure_installed = {
	-- 			"ts_ls",
	-- 			"html",
	-- 			"cssls",
	-- 			"tailwindcss",
	-- 			"lua_ls",
	-- 			"eslint",
	-- 		},
	-- 	},
	-- 	dependencies = {
	-- 		{
	-- 			"williamboman/mason.nvim",
	-- 			opts = {
	-- 				ui = {
	-- 					icons = {
	-- 						package_installed = "✓",
	-- 						package_pending = "➜",
	-- 						package_uninstalled = "✗",
	-- 					},
	-- 				},
	-- 			},
	-- 		},
	-- 		"neovim/nvim-lspconfig",
	-- 	},
	-- },
	-- {
	-- 	"WhoIsSethDaniel/mason-tool-installer.nvim",
	-- 	opts = {
	-- 		ensure_installed = {
	-- 			"prettier",
	-- 			"stylua",
	-- 			--"isort", -- python formatter
	-- 			--"black", -- python formatter
	-- 			--"pylint",
	-- 			"eslint_d",
	-- 		},
	-- 	},
	-- 	dependencies = {
	-- 		"williamboman/mason.nvim",
	-- 	},
	-- },
	{
		"mason-org/mason.nvim",
		lazy = false,
		dependencies = {
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"neovim/nvim-lspconfig",
		},
		config = function()
			-- import mason and mason_lspconfig
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")
			local mason_tool_installer = require("mason-tool-installer")

			-- enable mason and configure icons
			mason.setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})

			mason_lspconfig.setup({
				-- automatic_enable = false,
				-- servers for mason to install
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"html",
					"cssls",
					"tailwindcss",
					"gopls",
					"astro",
				},
			})

			mason_tool_installer.setup({
				ensure_installed = {
					"prettier",
					"stylua",
					"eslint_d",
				},
			})
		end,
	},
}
