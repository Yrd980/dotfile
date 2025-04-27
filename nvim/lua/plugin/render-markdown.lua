return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
  ft = { "markdown", "Avante" },
  config = function()
    require("render-markdown").setup {
      file_types = { "markdown", "Avante" },
      heading = {
        position = "inline",
        icons = { "󰼏 ", "󰼐 ", "󰼑 ", "󰼒 ", "󰼓 ", "󰼔 " },
      },
     code = {
        sign = false,
        style = 'full',
        disable_background = true,
        width = 'block',
        left_pad = 2,
        right_pad = 2,
        language_pad = 2,
        border = 'thick',
    },
     pipe_table = {
        preset = "double",
      },
    }
    vim.cmd [[
      hi RenderMarkdownCode guibg=NONE
      hi RenderMarkdownCodeInline guibg=NONE
      hi RenderMarkdownLanguage guibg=NONE
      hi RenderMarkdownBorder guibg=NONE
      hi RenderMarkdownSignColumn guibg=NONE
    ]]
  end,
}
