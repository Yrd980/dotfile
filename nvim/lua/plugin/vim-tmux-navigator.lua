return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
  },
  keys = {
    { "<C-h>", "<CMD><C-U>TmuxNavigateLeft<CR>" },
    { "<C-j>", "<CMD><C-U>TmuxNavigateDown<CR>" },
    { "<C-k>", "<CMD><C-U>TmuxNavigateUp<CR>" },
    { "<C-l>", "<CMD><C-U>TmuxNavigateRight<CR>" },
  },
}
