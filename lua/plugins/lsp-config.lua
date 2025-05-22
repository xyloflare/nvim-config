return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")
			local util = require("lspconfig/util")
			lspconfig.rust_analyzer.setup({
				filetypes = { "rust" },
				root_dir = util.root_pattern("Cargo.toml"),
				--on_attach = function(client, bufnr)
				--vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
				--vim.api.nvim_buf_set_option("n", "<leader>ca", vim.lsp.buf.code_action, {})
				--end,
				capabilities = capabilities,
				settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
						},
					},
				},
			})
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.html.setup({
				capabilities = capabilities,
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.clangd.setup({
				capabilities = capabilities,
			})
      lspconfig.astro.setup({
        capabilities = capabilities
      })
      lspconfig.gopls.setup({})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>mn", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>rf", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
	{
		"rust-lang/rust.vim",
		config = function()
			vim.g.rustfmt_autosave = 1
		end,
	},
  {
    "wuelnerdotexe/vim-astro",
  },
	--  {
	--    "sigmasd/deno-nvim",
	--    config = function ()
	--      local util = require("lspconfig/util")
	--      require('deno-nvim').setup(
	--        {
	--          root_dir = util.root_pattern("mod.ts", "mod.js"),
	--        });
	--    end
	--  },
	--[[
  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    lazy = false,
    config = function()
      --local rustaceanvim = require('rustaceanvim')
      local bufnr = vim.api.nvim_get_current_buf()
      vim.keymap.set("n", "<leader>a", function()
        --vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
        vim.lsp.buf.codeAction() --if you don't want grouping.
      end, { silent = true, buffer = bufnr })

      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {
          hover_actions = {
            replace_builtin_hover = false
          },
          code_actions = {}
        },
        -- LSP configuration
        server = {
          on_attach = function(client, buf)
            -- you can also put keymaps in here
          end,
          default_settings = {
            -- rust-analyzer language server configuration
            ["rust-analyzer"] = {},
          },
        },
        -- DAP configuration
        dap = {},
      }
    end,
  },
  ]]
	--
}
