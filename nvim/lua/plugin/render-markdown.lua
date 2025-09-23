return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  ft = { "markdown", "quarto" },
  config = function()
    require("render-markdown").setup {
      file_types = { "markdown", "quarto" },

      anti_conceal = {
        enabled = true,
        ignore = {
          code_background = true, -- keep plugin from forcing a bg here
          sign = true,
        },
        above = 0,
        below = 0,
      },

      heading = {
        position = "inline",
        icons = { "󰼏 ", "󰼐 ", "󰼑 ", "󰼒 ", "󰼓 ", "󰼔 " },
      },

      code = {
        enabled = true,
        render_modes = false,
        sign = true,
        style = "full",
        position = "left",
        language_pad = 0,
        language_icon = true,
        language_name = true,
        language_info = true,
        disable_background = { "diff" },
        width = "full",
        left_margin = 0,
        left_pad = 0,
        right_pad = 0,
        min_width = 0,
        border = "hide",
        language_border = "",
        language_left = "",
        language_right = "",
        above = "",
        below = "",
        inline_left = "",
        inline_right = "",
        inline_pad = 0,
        highlight = "RenderMarkdownCode",
        highlight_info = "RenderMarkdownCodeInfo",
        highlight_language = nil,
        highlight_border = "RenderMarkdownCodeBorder",
        highlight_fallback = "RenderMarkdownCodeFallback",
        highlight_inline = "RenderMarkdownCodeInline",
      },

      pipe_table = {
        preset = "double",
      },
    }

    local function set_md_transparent()
      -- main fenced/inline code groups
      local groups = {
        "RenderMarkdownCode",
        "RenderMarkdownCodeBorder",
        "RenderMarkdownCodeInfo",
        "RenderMarkdownCodeFallback",
        "RenderMarkdownCodeInline",
      }
      -- per-level heading text + background fill
      for i = 1, 6 do
        table.insert(groups, ("RenderMarkdownH%d"):format(i))
        table.insert(groups, ("RenderMarkdownH%dBg"):format(i))
        table.insert(groups, ("RenderMarkdownH%dIcon"):format(i))
      end
      for _, g in ipairs(groups) do
        pcall(vim.api.nvim_set_hl, 0, g, { bg = "NONE", ctermbg = "NONE" })
      end
    end

    -- apply now (after setup) and reapply when the colorscheme changes
    set_md_transparent()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = set_md_transparent })
    -- also re-assert when opening md/quarto buffers (some themes tweak on BufEnter)
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = { "*.md", "*.markdown", "*.qmd", "*.quarto" },
      callback = set_md_transparent,
    })
  end,
}
