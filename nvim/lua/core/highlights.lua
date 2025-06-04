local M = {}

local c = require "core.colors"

M.mini = {
  MiniFilesTitleFocused = { fg = c.yellow, bold = true },
  MiniFilesCursorLine = { fg = c.mantle, bg = c.green, bold = true },
  MiniPickIconFile = {},
  MiniPickIconDirectory = {},
}

M.lsp = {
  LspBorder = { fg = c.crust, bg = c.crust },
  LspInfoBorder = { fg = c.crust, bg = c.crust },
}

M.render_markdown = {
  -- background
  RenderMarkdownH1Bg = { fg = c.red, bg = c.base, bold = true, italic = true },
  RenderMarkdownH2Bg = { fg = c.peach, bg = c.base, bold = true, italic = true },
  RenderMarkdownH3Bg = { fg = c.yellow, bg = c.base, bold = true, italic = true },
  RenderMarkdownH4Bg = { fg = c.green, bg = c.base, bold = true, italic = true },
  RenderMarkdownH5Bg = { fg = c.blue, bg = c.base, bold = true, italic = true },
  RenderMarkdownH6Bg = { fg = c.cyan, bg = c.base, bold = true, italic = true },
  RenderMarkdownCode = { bg = c.mantle },
  RenderMarkdownCodeInline = { bg = c.mantle },
}

M.blink = {
  BlinkCmpMenu = { fg = c.lavender, bg = c.crust },
  BlinkCmpMenuBorder = { fg = c.crust, bg = c.crust },
  BlinkCmpMenuSelection = { fg = c.mantle, bg = c.green },
  -- BlinkCmpScrollBarThumb = {fg = , bg = ,},
  -- BlinkCmpScrollBarGutter = {fg = , bg = ,},
  BlinkCmpLabel = { fg = c.lavender },
  -- BlinkCmpLabelDeprecated = {fg = , bg = ,},
  -- BlinkCmpLabelMatch = {fg = , bg = ,},
  -- BlinkCmpLabelDetail = {fg = , bg = ,},
  -- BlinkCmpLabelDescription = {fg = , bg = ,},
  -- BlinkCmpKind = {fg = , bg = ,},
  BlinkCmpSource = { fg = c.pink },
  -- BlinkCmpGhostText = {fg = , bg = ,},
  BlinkCmpDoc = { fg = c.lavender, bg = c.mantle },
  BlinkCmpDocBorder = { fg = c.surface1, bg = c.mantle },
  BlinkCmpDocSeparator = { fg = c.surface1, bg = c.mantle },
  -- BlinkCmpDocCursorLine = {fg = , bg = ,},
  BlinkCmpSignatureHelp = { fg = c.lavender, bg = c.mantle },
  BlinkCmpSignatureHelpBorder = { fg = c.mantle, bg = c.mantle },
  -- BlinkCmpSignatureHelpActiveParameter = {fg = , bg = ,},
}

M.snacks = {

}

for _, definitions in pairs(M) do
  for highlight_name, highlight_attrs in pairs(definitions) do
    vim.api.nvim_set_hl(0, highlight_name, highlight_attrs)
  end
end

return M
