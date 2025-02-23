return {
  "github/copilot.vim",
  config = function()
    -- Disable default tab key mapping if it conflicts
    vim.g.copilot_no_tab_map = true

    -- Keybinding to accept Copilot suggestion
    vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

    -- Keybinding to toggle Copilot
    vim.api.nvim_set_keymap(
      "n", -- Normal mode
      "<leader>cp", -- Keybinding to toggle Copilot
      ':lua ToggleCopilot()<CR>',
      { noremap = true, silent = true }
    )

    -- Lua function to toggle Copilot
    function ToggleCopilot()
      if vim.g.copilot_enabled == 1 then
        vim.g.copilot_enabled = 0
        print("GitHub Copilot Disabled")
      else
        vim.g.copilot_enabled = 1
        print("GitHub Copilot Enabled")
      end
    end
  end,
}
