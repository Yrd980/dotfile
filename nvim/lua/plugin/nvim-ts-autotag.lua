return {
  "windwp/nvim-ts-autotag",
  event = "VeryLazy", -- or "InsertEnter" for slightly earlier load
  ft = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte", "vue", "tsx", "jsx", "xml" },
  config = function()
    require("nvim-ts-autotag").setup()
  end,
}
