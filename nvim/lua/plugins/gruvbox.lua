return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    require("gruvbox").setup({
      contrast = "hard",  -- make background darker (options: soft/medium/hard)
      transparent_mode = false,  -- disable transparency
      overrides = {
        Normal = { bg = "#000000" },  -- pure black background
        NonText = { bg = "#000000" }, -- pure black for non-text areas
        LineNr = { bg = "#000000" },  -- line numbers background
      }
    })
    vim.o.background = "dark"
    vim.cmd([[colorscheme gruvbox]])
  end
}
