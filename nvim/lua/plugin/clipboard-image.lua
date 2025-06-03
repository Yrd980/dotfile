return {
  "dfendr/clipboard-image.nvim",
  ft = { "markdown" },
  config = function()
    require("clipboard-image").setup {
      default = {
        img_dir = "assets",
        img_dir_txt = "assets",
        img_name = function() return os.date("%Y-%m-%d-%H-%M-%S") end,
        affix = "![](%s)",
      },
    }

    -- Optional keymap for quick paste
    vim.keymap.set("n", "<leader>p", ":PasteImg<CR>", { desc = "Paste Clipboard Image" })
  end,
}

