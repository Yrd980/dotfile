-- vim.cmd [[colorscheme catppuccin]]
return {
  "catppuccin/nvim",
  lazy = false,
  priority = 1000,
  name = "catppuccin",
  config = function()
    local c = require "core.colors"
    require("catppuccin").setup {
      flavour = "mocha",
      transparent_background = true,
      term_colors = true,

      -- NOTE: maintain a list of all the in-use plugins that deviate from default settings.
      integrations = {
        alpha = true,
        mason = true,
        treesitter_context = true,
        nvimtree = true,
        which_key = true,
        blink_cmp = true,
        snacks = true,
        render_markdown = true,
        telescope = true,
      },

      color_overrides = {
        mocha = require "core.colors",
      },
   }
    vim.cmd [[colorscheme catppuccin]]
  end,
}
