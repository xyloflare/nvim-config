return {
	{
	  "catppuccin/nvim",
	  -- lazy = false,
	  name = "catppuccin",
	  -- priority = 1000,
	  -- config = function()
	    --vim.cmd.colorscheme "catppuccin-mocha"
	  -- end
	},
  {
    "https://github.com/nanotech/jellybeans.vim",
    name = "jellybeans"
  },
	{
		"rebelot/kanagawa.nvim",
		-- lazy = false,
		name = "kanagawa",
		-- priority = 1000,
		config = function()
			--vim.cmd.colorscheme("kanagawa-dragon") --dragon
		end,
	},
  {
    "EdenEast/nightfox.nvim",
    name = "nightfox",
    -- priority = 1000,
    -- lazy = false,
    -- config = function ()
      -- vim.cmd.colorscheme("carbonfox")
    -- end
  },
	{
	  "bluz71/vim-moonfly-colors",
	  lazy = false,
	  name = "moonfly",
	  priority = 1000,
	  config = function ()
	    vim.cmd.colorscheme "moonfly"
	  end
	},
  {
    "rose-pine/neovim",
    name = "rose-pine",
    -- lazy = false,
    -- priority = 1000,
    -- config = function ()
      --vim.cmd.colorscheme "rose-pine"
    -- end
  }
}
