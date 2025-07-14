return {
  "lervag/vimtex",
  ft = { "tex" },
  init = function()
    -- Viewer settings
    -- vim.g.vimtex_view_method = "zathura"
    -- vim.g.vimtex_context_pdf_viewer = "okular" -- External PDF viewer for the Vimtex menu
    vim.g.vimtex_view_method = "general"
    vim.g.vimtex_view_general_viewer = "okular"
    vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]

    -- Formatting settings
    -- vim.g.vimtex_format_enabled = true             -- Enable formatting with latexindent
    -- vim.g.vimtex_format_program = 'latexindent'

    -- Indentation settings
    vim.g.vimtex_indent_enabled = false -- Disable auto-indent from Vimtex
    vim.g.tex_indent_items = false -- Disable indent for enumerate
    vim.g.tex_indent_brace = false -- Disable brace indent

    -- Suppression settings
    vim.g.vimtex_quickfix_mode = 0 -- Suppress quickfix on save/build
    vim.g.vimtex_log_ignore = { -- Suppress specific log messages
      "Underfull",
      "Overfull",
      "specifier changed to",
      "Token not allowed in a PDF string",
    }

    -- Other settings
    vim.g.vimtex_mappings_enabled = false -- Disable default mappings
    vim.g.tex_flavor = "latex" -- Set file type for TeX files
  end,
}
