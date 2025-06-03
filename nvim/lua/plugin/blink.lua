return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    cmd = "Copilot",
    build = ":Copilot auth",
    config = function()
      require("copilot").setup {
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = {
          java = true,
          python = true,
          zsh = true,
          toml = true,
          yaml = true,
          markdown = true,
          help = true,
          gitcommit = true,
          gitrebase = true,
          sh = function()
            if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
              -- disable for .env files
              return false
            end
            return true
          end,
        },
      }
    end,
  },


  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "giuxtaposition/blink-cmp-copilot",
      "saghen/blink.compat",
    },
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("blink.cmp").setup {
        keymap = {
          preset = "none",
          ["<C-w>"] = { "show", "hide", "fallback" },
          ["<C-y>"] = { "select_and_accept", "fallback" },
          ["<CR>"] = { "accept", "fallback" },

          ["<Down>"] = { "select_next", "fallback" },
          ["<Up>"] = { "select_prev", "fallback" },
          ["<C-j>"] = { "select_next", "fallback" },
          ["<C-k>"] = { "select_prev", "fallback" },
          ["<Tab>"] = { "select_next", "fallback" },
          ["<S-Tab>"] = { "select_prev", "fallback" },

          ["<C-n>"] = { "snippet_forward", "fallback" },
          ["<C-p>"] = { "snippet_backward", "fallback" },

          ["<C-u>"] = { "scroll_documentation_up", "fallback" },
          ["<C-d>"] = { "scroll_documentation_down", "fallback" },
        },

        appearance = {
          nerd_font_variant = "mono",
          kind_icons = {
            Copilot = "",
          },
        },

        sources = {
          default = {
            "lsp",
            "snippets",
            "copilot",
            "path",
            "buffer",
            "markdown",
          },
          providers = {
            lsp = {
              name = "Lsp",
              module = "blink.cmp.sources.lsp",
              score_offset = 100,
            },
            snippets = {
              name = "Snip",
              module = "blink.cmp.sources.snippets",
              score_offset = 90,
            },
            copilot = {
              name = "Cop",
              module = "blink-cmp-copilot",
              score_offset = 80,
              async = true,
              min_keyword_length = 2,
              transform_items = function(_, items)
                local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
                local kind_idx = #CompletionItemKind + 1
                CompletionItemKind[kind_idx] = "Copilot"
                for _, item in ipairs(items) do
                  item.kind = kind_idx
                end
                return items
              end,
            },
            path = {
              name = "Path",
              module = "blink.cmp.sources.path",
              score_offset = 70,
            },
            buffer = {
              name = "Buff",
              module = "blink.cmp.sources.buffer",
              score_offset = 60,
            },
            cmdline = {
              min_keyword_length = 3,
            },
            markdown = {
              name = "RenderMarkdown",
              module = "render-markdown.integ.blink",
              fallbacks = { "lsp" },
            },
          },
        },

        completion = {
          menu = {
            -- Don't show completion menu automatically when searching or in cmdline mode
            auto_show = function(ctx)
              return ctx.mode ~= "cmdline" or not vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
            end,
            border = "single",
            scrollbar = false,
            draw = {
              columns = {
                { "kind_icon" },
                { "label", "label_description", gap = 1 },
                { "source_name" },
              },
            },
          },
          documentation = {
            window = { border = "single" },
            auto_show_delay_ms = 250,
            auto_show = true,
          },
        },

        signature = { window = { border = "single" } },
      }
    end,
  },
}
