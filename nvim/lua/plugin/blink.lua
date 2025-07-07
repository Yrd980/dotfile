return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "saghen/blink.compat",
    },
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("blink.cmp").setup {
        keymap = {
          preset = "none",
          ["<cr>"] = { "accept", "fallback" },
          ["<tab>"] = { "select_next", "fallback" },
          ["<s-tab>"] = { "select_prev", "fallback" },
        },

        appearance = {
          nerd_font_variant = "mono",
        },

        sources = {
          default = {
            "lsp",
            "snippets",
            "path",
            "buffer",
            "markdown",
          },
          providers = {
            lsp = {
              name = "lsp",
              module = "blink.cmp.sources.lsp",
              score_offset = 100,
            },
            snippets = {
              name = "snip",
              module = "blink.cmp.sources.snippets",
              score_offset = 90,
            },
            path = {
              name = "path",
              module = "blink.cmp.sources.path",
              score_offset = 70,
            },
            buffer = {
              name = "buff",
              module = "blink.cmp.sources.buffer",
              score_offset = 60,
            },
            cmdline = {
              min_keyword_length = 3,
            },
            markdown = {
              name = "rendermarkdown",
              module = "render-markdown.integ.blink",
              fallbacks = { "lsp" },
            },
          },
        },

        completion = {
          menu = {
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
-- return {
--   {
--     "zbirenbaum/copilot.lua",
--     event = "insertenter",
--     cmd = "copilot",
--     build = ":copilot auth",
--     config = function()
--       require("copilot").setup {
--         suggestion = { enabled = false },
--         panel = { enabled = false },
--         filetypes = {
--           java = true,
--           python = true,
--           zsh = true,
--           toml = true,
--           yaml = true,
--           markdown = true,
--           help = true,
--           gitcommit = true,
--           gitrebase = true,
--           sh = function()
--             if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
--               -- disable for .env files
--               return false
--             end
--             return true
--           end,
--         },
--       }
--     end,
--   },
--
--
--   {
--     "saghen/blink.cmp",
--     dependencies = {
--       "rafamadriz/friendly-snippets",
--       "giuxtaposition/blink-cmp-copilot",
--       "saghen/blink.compat",
--     },
--     version = "*",
--     event = { "bufreadpre", "bufnewfile" },
--     config = function()
--       require("blink.cmp").setup {
--         keymap = {
--           preset = "none",
--           ["<c-w>"] = { "show", "hide", "fallback" },
--           ["<c-y>"] = { "select_and_accept", "fallback" },
--           ["<cr>"] = { "accept", "fallback" },
--
--           ["<down>"] = { "select_next", "fallback" },
--           ["<up>"] = { "select_prev", "fallback" },
--           ["<c-j>"] = { "select_next", "fallback" },
--           ["<c-k>"] = { "select_prev", "fallback" },
--           ["<tab>"] = { "select_next", "fallback" },
--           ["<s-tab>"] = { "select_prev", "fallback" },
--
--           ["<c-n>"] = { "snippet_forward", "fallback" },
--           ["<c-p>"] = { "snippet_backward", "fallback" },
--
--           ["<c-u>"] = { "scroll_documentation_up", "fallback" },
--           ["<c-d>"] = { "scroll_documentation_down", "fallback" },
--         },
--
--         appearance = {
--           nerd_font_variant = "mono",
--           kind_icons = {
--             copilot = "",
--           },
--         },
--
--         sources = {
--           default = {
--             "lsp",
--             "snippets",
--             "copilot",
--             "path",
--             "buffer",
--             "markdown",
--           },
--           providers = {
--             lsp = {
--               name = "lsp",
--               module = "blink.cmp.sources.lsp",
--               score_offset = 100,
--             },
--             snippets = {
--               name = "snip",
--               module = "blink.cmp.sources.snippets",
--               score_offset = 90,
--             },
--             copilot = {
--               name = "cop",
--               module = "blink-cmp-copilot",
--               score_offset = 80,
--               async = true,
--               min_keyword_length = 2,
--               transform_items = function(_, items)
--                 local completionitemkind = require("blink.cmp.types").completionitemkind
--                 local kind_idx = #completionitemkind + 1
--                 completionitemkind[kind_idx] = "copilot"
--                 for _, item in ipairs(items) do
--                   item.kind = kind_idx
--                 end
--                 return items
--               end,
--             },
--             path = {
--               name = "path",
--               module = "blink.cmp.sources.path",
--               score_offset = 70,
--             },
--             buffer = {
--               name = "buff",
--               module = "blink.cmp.sources.buffer",
--               score_offset = 60,
--             },
--             cmdline = {
--               min_keyword_length = 3,
--             },
--             markdown = {
--               name = "rendermarkdown",
--               module = "render-markdown.integ.blink",
--               fallbacks = { "lsp" },
--             },
--           },
--         },
--
--         completion = {
--           menu = {
--             -- don't show completion menu automatically when searching or in cmdline mode
--             auto_show = function(ctx)
--               return ctx.mode ~= "cmdline" or not vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
--             end,
--             border = "single",
--             scrollbar = false,
--             draw = {
--               columns = {
--                 { "kind_icon" },
--                 { "label", "label_description", gap = 1 },
--                 { "source_name" },
--               },
--             },
--           },
--           documentation = {
--             window = { border = "single" },
--             auto_show_delay_ms = 250,
--             auto_show = true,
--           },
--         },
--
--         signature = { window = { border = "single" } },
--       }
--     end,
--   },
-- }
