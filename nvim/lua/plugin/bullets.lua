return {
  "bullets-vim/bullets.vim",
  ft = { "markdown", "text", "gitcommit" }, -- Enable only for specific filetypes
  init = function()
    -- Set global variables BEFORE the plugin loads
    vim.g.bullets_delete_last_bullet_if_empty = 1
    vim.g.bullets_enable_in_empty_buffers = 0 -- Optional: Fix snacks.nvim issue
    -- vim.g.bullets_set_mappings = 1 -- Optional: if you want to control mappings
  end,
}

