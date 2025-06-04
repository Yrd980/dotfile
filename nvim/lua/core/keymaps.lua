local map = require("core.utils").map

-- basic
map("n", "<Leader>w", ":w!<CR>", { desc = "[W]rite" })
map("n", "<Leader>q", ":wq<CR>", { desc = "save and quit" })

-- quick change to esc
map("i", "jk", "<ESC>", { desc = "toggle esc" })

-- clear highlights
map("n", "<Esc>", "<CMD>noh<CR>", { desc = "Clear Highlights" })

-- Line operation
map({ "x", "v" }, "<", "<gv", { desc = "Indent Line" })
map({ "x", "v" }, ">", ">gv", { desc = "Indent Line" })
