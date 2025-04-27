-- I'm just using lazyvim.org defaults here
-- This plugin comes installed by default, but it was removed one time, so just
-- leaving it here because I want to always have it installed
--
-- https://github.com/echasnovski/mini.surround

return {
  "echasnovski/mini.surround",
  opts = {
    mappings = {
      add = "gsa", -- Add surrounding in Normal and Visual modes
      delete = "gsd", -- Delete surrounding
      find = "gsf", -- Find surrounding (to the right)
      find_left = "gsF", -- Find surrounding (to the left)
      highlight = "gsh", -- Highlight surrounding
      replace = "gsr", -- Replace surrounding
      update_n_lines = "gsn", -- Update `n_lines`
    },
  },
  keys = {
    { "gsa", desc = "Add Surrounding", mode = { "n", "v" } },
    { "gsd", desc = "Delete Surrounding" },
    { "gsf", desc = "Find Right Surrounding" },
    { "gsF", desc = "Find Left Surrounding" },
    { "gsh", desc = "Highlight Surrounding" },
    { "gsr", desc = "Replace Surrounding" },
    { "gsn", desc = "Update n_lines" },
  },
}
