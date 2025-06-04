-- bootstrap plugin specs
LAZY_PLUGIN_SPEC = {}
function spec(item) table.insert(LAZY_PLUGIN_SPEC, { import = item }) end

-- set default options
require "core.options"

-- load mappings
require "core.keymaps"

---------------------
-- ESSENTIALS
---------------------
spec "plugin.nvim-treesitter"
spec "plugin.which-key"
spec "plugin.blink"
spec "plugin.nvim-treesitter-content"
spec "plugin.nvim-lspconfig"

---------------------
-- EDITOR
---------------------
spec "plugin.vim-tmux-navigator"
spec "plugin.carbon-now" -- screenshot code
spec "plugin.pangu" -- auto format to add a space between cjk and english letters
spec "plugin.nvim-autopairs"
spec "plugin.nvim-ts-autotag"
spec "plugin.snacks"
spec "plugin.bullets"
spec "plugin.image"
spec "plugin.flash"
spec "plugin.indent-blankline"
spec "plugin.kd_translate"
spec "plugin.clipboard-image"
spec "plugin.conform"

---------------------
-- UI
---------------------
spec "plugin.barbecue" -- VS Code like winbar
spec "plugin.lualine"
spec "plugin.render-markdown"
spec "plugin.todo-comments"
spec "plugin.catppuccin"
spec "plugin.smear-cursor"
spec "plugin.noice"
spec "plugin.stay-centered"

-- bootstrap lazy
require "core.lazy"

-- setup highlights
-- require "core.highlights"

vim.keymap.set("n", "gb", function()
  local word = vim.fn.expand("<cfile>") if not word:match("^https?://") then
    -- not a real URL, search it
    word = "https://www.google.com/search?q=" .. vim.fn.escape(word, " ")
  end
  vim.fn.jobstart({ "xdg-open", word }, { detach = true })
end, { noremap = true, silent = true })


