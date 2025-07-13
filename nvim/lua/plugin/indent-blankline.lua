return {
  { "HiPhish/rainbow-delimiters.nvim" },
  {
    "lukas-reineke/indent-blankline.nvim",
    dependencies = { "HiPhish/rainbow-delimiters.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("ibl").setup {
        indent = {
          char = "│",
        },
        scope = {
          char = "│",
          show_start = false,
          show_end = false,
        },
        exclude = {
          filetypes = {
            "startify",
            "aerial",
            "alpha",
            "dashboard",
            "lazy",
            "neogitstatus",
            "NvimTree",
            "neo-tree",
            "Trouble",
          },
        },
      }
    end,
  },
}
