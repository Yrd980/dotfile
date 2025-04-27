return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  init = function(plugin)
    require("lazy.core.loader").add_to_rtp(plugin)
    require "nvim-treesitter.query_predicates"
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "luckasRanarison/tree-sitter-hyprlang",
  },
  config = function()
    require("nvim-treesitter.configs").setup {
      highlight = {
        enable = true,
        use_languagetree = true,
      },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "css",
        "dockerfile",
        "gitignore",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "latex",
        "lua",
        "luadoc",
        "luap",
        "python",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vue",
        "vim",
        "vimdoc",
        "yaml",
        "markdown",
        "markdown_inline",
        "java",
        "c",
        "cpp",
        "objc",
        "cuda",
        "proto",
        "hyprlang", -- hyprland parser
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          node_decremental = "<BS>",
          scope_incremental = false,
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ai"] = "@conditional.outer",
            ["ii"] = "@conditional.inner",
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
            ["ab"] = "@block.outer",
            ["ib"] = "@block.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true, 
          goto_next_start = {
            ["]m"] = "@function.outer",      
            ["]i"] = "@conditional.outer",  
            ["]l"] = "@loop.outer",        
            ["]b"] = "@block.outer",      
          },
          goto_next_end = {
            ["]M"] = "@function.outer",     
            ["]I"] = "@conditional.outer",  
            ["]L"] = "@loop.outer",        
            ["]B"] = "@block.outer",      
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",   
            ["[i"] = "@conditional.outer",
            ["[l"] = "@loop.outer",      
            ["[b"] = "@block.outer",    
          },
          goto_previous_end = {
            ["[M"] = "@function.outer", 
            ["[I"] = "@conditional.outer",
            ["[L"] = "@loop.outer",      
            ["[B"] = "@block.outer",    
          },
        },
      }
    }
  end,
}
