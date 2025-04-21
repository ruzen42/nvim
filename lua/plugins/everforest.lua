return {
  {
    "neanias/everforest-nvim",
    version = false, -- Use the latest commit
    lazy = false, -- Load immediately to ensure colorscheme is applied
    priority = 1000, -- Load before other plugins to avoid highlight conflicts
    config = function()
      require("everforest").setup({
        -- Optional configuration options
        background = "medium", -- Options: "soft", "medium", "hard"
        transparent_background_level = 0, -- 0 for opaque, 2 for more transparency
        italics = true, -- Enable italics for keywords
        disable_italic_comments = false, -- Keep italic comments
        sign_column_background = "none", -- "none" or "grey"
        inlay_hints_background = "none", -- "none" or "dimmed"
        -- Example: Override specific highlight groups
        on_highlights = function(hl, palette)
          hl.DiagnosticError = { fg = palette.none, bg = palette.none, sp = palette.red }
          hl.TSBoolean = { fg = palette.purple, bg = palette.none, bold = true }
        end,
        -- Example: Override palette colors
        colours_override = function(palette)
          palette.red = "#b86466" -- Darker red for dark background
        end,
      })
      vim.cmd([[colorscheme everforest]]) -- Apply the colorscheme
    end,
  },
}
