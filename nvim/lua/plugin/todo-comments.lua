return {
  "folke/todo-comments.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo" },
    {
      "<leader>sT",
      function() Snacks.picker.todo_comments { keywords = { "TODO", "FIX", "FIXME" } } end,
      desc = "Todo/Fix/Fixme",
    },
  },
  config = function()
    local c = require "core.colors"
    require("todo-comments").setup {
      colors = {
        error = { "DiagnosticError", "ErrorMsg", c.red },
        warning = { "DiagnosticWarn", "WarningMsg", c.yellow },
        info = { "DiagnosticInfo", c.blue },
        hint = { "DiagnosticHint", c.green },
        default = { "Identifier", c.mauve },
        test = { "Identifier", c.peach },
      },
    }
  end,
}
