return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		branch = "main",
		config = function()
			local ts = require("nvim-treesitter")
			ts.install({ "astro", "javascript", "tsx", "jsx", "html", "css", "typescript", "json", "lua", "dockerfile", "bash", "markdown", "c" })
			ts.setup({ auto_install = true, highlight = { enable = true }, indent = { enable = true } })

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "*",
				callback = function(args)
					local buf = args.buf
					local ft = vim.bo[buf].filetype
					local lang = vim.treesitter.language.get_lang(ft)

					if not lang then
						return
					end

					-- load parser and start treesitter safely
					pcall(vim.treesitter.language.add, lang)
					pcall(vim.treesitter.start, buf, lang)

					-- enable indentation (skip yaml/markdown)
					if ft ~= "yaml" and ft ~= "markdown" then
						vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
						vim.bo[buf].smartindent = false
						vim.bo[buf].cindent = false
					end
				end,
			})

			-- local config = require("nvim-treesitter.configs")
			-- config.setup({
			--   auto_install = true,
			--   highlight = { enable = true },
			--   indent = { enable = true },
			-- })
		end,
	},
}
