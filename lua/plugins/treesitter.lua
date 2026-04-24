return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    branch = 'main',
    config = function()
      local ts = require('nvim-treesitter')
      ts.install { 'astro', 'javascript' }
      ts.setup({ auto_install = true, highlight = {enable = true}, indent = {enable = true}})

      -- local config = require("nvim-treesitter.configs")
      -- config.setup({
      --   auto_install = true,
      --   highlight = { enable = true },
      --   indent = { enable = true },
      -- })
    end
  }
}
