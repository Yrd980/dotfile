return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<Leader>ll",
      function()
        require("conform").format { async = true, lsp_format = "fallback" }
      end,
      mode = "", -- optional: set to "n" for normal mode
      desc = "[F]ormat buffer",
    },
  },
  config = function()
    require("conform").setup {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        markdown = { "markdownlint" },
        svelte = { "prettier" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        vue = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        less = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        graphql = { "prettier" },
        handlebars = { "prettier" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        go = { "gofmt" },       -- or "goimports"
        rust = { "rustfmt" },
        java = { "google-java-format" }, -- or "clang-format" for generic
        c = { "clang-format" },
        cpp = { "clang-format" },
        -- toml = { "taplo" },
      },
      -- Optional: enable auto-format on save
      -- format_on_save = {
      --   timeout_ms = 500,
      --   lsp_format = "fallback",
      -- },
    }

    require("conform").formatters.shfmt = { prepend_args = { "-i", "2" } }

    -- Optional: additional formatter configs
    -- require("conform").formatters["clang-format"] = { prepend_args = { "-style=Google" } }
    -- require("conform").formatters["google-java-format"] = {
    --   command = "google-java-format",
    --   args = { "-" },
    --   stdin = true,
    -- }
  end,
}

