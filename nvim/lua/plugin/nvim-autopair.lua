return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    check_ts = true,
    fast_wrap = {
      map = "<M-e>",
      chars = { "{", "[", "(", '"', "'" },
      pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
      offset = 0,
      end_key = "$",
      keys = "qwertyuiopzxcvbnmasdfghjkl",
      check_comma = true,
      highlight = "Search",
      highlight_grey = "Comment",
    },
  },
  config = function(_, opts)
    local npairs = require "nvim-autopairs"
    local Rule = require "nvim-autopairs.rule"

    npairs.setup(opts)

    -- Add custom rules
    npairs.add_rules {

      -- LaTeX/Markdown: pair $$ ... $$
      Rule("$$", "$$", { "tex", "markdown" })
        :with_move(function(opts) return opts.prev_char:match ".%$" ~= nil end)
        :with_pair(function(opts) return opts.line:sub(opts.col - 1, opts.col) ~= "$$" end)
        :use_key "$",

      -- Python: triple quotes """ ... """
      Rule('"""', '"""', "python")
        :with_pair(function(opts) return opts.line:sub(opts.col - 1, opts.col + 3):match '"""' == nil end)
        :with_move(function(opts) return opts.char == '"' end),

      -- Prevent autopairs in comments
      Rule("(", ")", "-"):with_pair(function(opts)
        local ts_utils = require "nvim-treesitter.ts_utils"
        local node = ts_utils.get_node_at_cursor()
        while node do
          if node:type():match "comment" then return false end
          node = node:parent()
        end
        return true
      end),
    }

    -- Integrate with nvim-cmp if available
    local cmp_status, cmp = pcall(require, "cmp")
    if cmp_status then
      local cmp_autopairs = require "nvim-autopairs.completion.cmp"
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end
  end,
}
