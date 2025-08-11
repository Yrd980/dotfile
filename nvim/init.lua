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
spec "plugin.blink"
spec "plugin.luasnip"
spec "plugin.nvim-treesitter-content"
spec "plugin.nvim-lspconfig"
spec "plugin.nvim-ts-autotag"

---------------------
-- EDITOR
---------------------
spec "plugin.vim-tmux-navigator"
spec "plugin.carbon-now" -- screenshot code
-- spec "plugin.pangu" -- auto format to add a space between cjk and english letters
spec "plugin.snacks"
spec "plugin.bullets"
spec "plugin.vimtex"
spec "plugin.indent-blankline"
spec "plugin.kd_translate"
spec "plugin.clipboard-image"
spec "plugin.conform"
spec "plugin.nvim-autopair"
spec "plugin.flutter-tool"
spec "plugin.dirdiff"
spec "plugin.diffview"
spec "plugin.flash"

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

require "core.lazy"

vim.keymap.set("n", "gb", function()
  local word = vim.fn.expand "<cfile>"
  if not word:match "^https?://" then
    -- not a real URL, search it
    word = "https://www.google.com/search?q=" .. vim.fn.escape(word, " ")
  end
  vim.fn.jobstart({ "xdg-open", word }, { detach = true })
end, { noremap = true, silent = true })

local _select = vim.ui.select
function vim.ui.select(items, opts, on_choice)
  if
    opts
    and opts.prompt
    and type(opts.prompt) == "string"
    and string.match(opts.prompt, [[^You've reached.*limit.*Upgrade.*$]]) -- ...
  then
    vim.notify("Copilot: " .. opts.prompt, vim.log.levels.ERROR) --you can also delete this notify
    vim.cmd "Copilot disable"
  else
    return _select(items, opts, on_choice)
  end
end

-- Define the project where you want diagnostics disabled
local disabled_projects = {
  "/home/yrd/documents/git_clone_code/etc/LogChat",
  "/home/yrd/documents/git_clone_code/etc/ZcChat",
}

-- Check if current working directory matches any in the list
local function diagnostics_disabled_here()
  local cwd = vim.fn.getcwd()
  for _, path in ipairs(disabled_projects) do
    if cwd:find(vim.fn.expand(path), 1, true) == 1 then return true end
  end
  return false
end

-- Disable diagnostics for matching projects when LSP attaches
local function custom_on_attach(client, bufnr)
  if diagnostics_disabled_here() then
    vim.diagnostic.disable(bufnr)
    vim.schedule(function() vim.notify("🚫 Diagnostics disabled for LogChat project", vim.log.levels.WARN) end)
  end
end

--  vim.api.nvim_create_autocmd("FileType", {
--      pattern = { "c", "cpp", "objc", "objcpp" },
--      callback = function()
--        vim.opt_local.tabstop = 4 -- actual spaces for a <Tab>
--        vim.opt_local.shiftwidth = 4 -- spaces for each indent level
--        vim.opt_local.softtabstop = 4 -- spaces inserted when pressing <Tab> in insert mode
--        vim.opt_local.expandtab = false -- use real tabs instead of spaces
--      end,
--  }),

-- vim.api.nvim_create_user_command("RunShell", function(opts)
--   vim.fn.jobstart({ "fish", "-c", opts.args }, {
--     stdout_buffered = true,
--     on_stdout = function(_, data)
--       if data then print(table.concat(data, "\n")) end
--     end,
--   })
-- end, {
--   nargs = 1,
-- })

-- Attach this to a specific LSP (e.g., clangd or any you're using)
require("lspconfig").clangd.setup {
  on_attach = custom_on_attach,
}

-- (Optional) Apply to all servers globally:
-- local lspconfig = require("lspconfig")
-- for _, server in ipairs({ "clangd", "pyright", "lua_ls", "tsserver" }) do
--   lspconfig[server].setup({
--     on_attach = custom_on_attach,
--   })
-- end
