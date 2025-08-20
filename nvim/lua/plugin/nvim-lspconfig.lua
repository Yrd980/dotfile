return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "smjonas/inc-rename.nvim", -- LSP renaming with immediate visual feedback
    "b0o/schemastore.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "saghen/blink.cmp",
  },
  keys = {
    {
      "<Leader>r",
      function() return ":IncRename " .. vim.fn.expand "<cword>" end,
      desc = "Inc-[R]ename",
      expr = true,
    },
  },
  config = function()
    require("mason").setup()
    require("inc_rename").setup()

    -- LSP Servers (curated, avoids overlap)
    local servers = {
      "bashls",
      "clangd",
      "csharp_ls",
      "cssls",
      "dartls",
      "dockerls",
      "docker_compose_language_service",
      "gopls",
      "graphql",
      "html",
      "jdtls",
      "jsonls",
      "kotlin_language_server",
      "lua_ls",
      "marksman",
      "pyright",
      "rust_analyzer",
      "vtsls",
      "volar",
      "yamlls",
      "texlab",
      "taplo",
    }

    local formatters = {
      "prettier", -- HTML, CSS, JS, TS, JSON, Markdown
      "stylua", -- Lua
      "shfmt", -- Shell
      "clang-format",
      "ruff", -- Python lint + code actions
    }

    -- Linters (via nvim-lint or null-ls)
    local linters = {
      "eslint_d",
      "markdownlint",
      "ruff", -- Python lint
      "shellcheck",
      "yamllint",
      "hadolint", -- Dockerfile
    }

    local ensure_installed = {}
    vim.list_extend(ensure_installed, servers)
    vim.list_extend(ensure_installed, formatters)
    vim.list_extend(ensure_installed, linters)

    require("mason-tool-installer").setup {
      ensure_installed = ensure_installed,
    }
    vim.cmd "MasonToolsInstall"

    -- Diagnostics
    local lsp = require("core.icons").lsp
    local border = require("core.utils").straight_boarder "LspBorder"
    local signs = {
      ERROR = lsp.DiagnosticError,
      WARN = lsp.DiagnosticWarn,
      INFO = lsp.DiagnosticInfo,
      HINT = lsp.DiagnosticHint,
    }
    local diagnostic_signs = {}
    for type, icon in pairs(signs) do
      diagnostic_signs[vim.diagnostic.severity[type]] = icon
    end
    vim.diagnostic.config {
      signs = { text = diagnostic_signs },
      virtual_text = false,
      update_in_insert = false,
      underline = true,
      severity_sort = true,
      float = {
        focusable = true,
        border = border,
        source = true,
        header = "",
      },
    }
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
      callback = function() vim.diagnostic.open_float(nil, { focus = false }) end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "c", "cpp", "objc", "objcpp" },
      callback = function()
        vim.opt_local.tabstop = 4 -- actual spaces for a <Tab>
        vim.opt_local.shiftwidth = 4 -- spaces for each indent level
        vim.opt_local.softtabstop = 4 -- spaces inserted when pressing <Tab> in insert mode
        vim.opt_local.expandtab = false -- use real tabs instead of spaces
      end,
    })

    -- Attach
    local on_attach = require("core.utils").on_attach
    local capabilities = vim.tbl_deep_extend(
      "force",
      vim.lsp.protocol.make_client_capabilities(),
      require("blink.cmp").get_lsp_capabilities()
    )

    -- markdown_oxide dynamic registration support
    capabilities.workspace = {
      didChangeWatchedFiles = { dynamicRegistration = true },
    }

    -- Per-server setup
    local lspconfig = require "lspconfig"

    for _, server in ipairs(servers) do
      local opts = { on_attach = on_attach, capabilities = capabilities }

      -- JSON/YAML schemastore
      if server == "jsonls" then
        local ok, schemastore = pcall(require, "schemastore")
        if ok then opts.settings = { json = { schemas = schemastore.json.schemas(), validate = { enable = true } } } end
      elseif server == "yamlls" then
        local ok, schemastore = pcall(require, "schemastore")
        if ok then
          opts.settings = {
            yaml = {
              schemaStore = { enable = false, url = "" },
              schemas = schemastore.yaml.schemas(),
              keyOrdering = false,
            },
          }
        end
      elseif server == "ruff_lsp" then
        opts.on_attach = function(client, bufnr)
          -- disable formatting, handled by conform
          client.server_capabilities.documentFormattingProvider = false
          on_attach(client, bufnr)
        end
      end

      local require_ok, settings = pcall(require, "lspsettings." .. server)
      if require_ok then opts = vim.tbl_deep_extend("force", settings, opts) end
      lspconfig[server].setup(opts)
    end
  end,
}
