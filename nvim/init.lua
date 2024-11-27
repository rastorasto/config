vim.g.mapleader = ' '

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

vim.opt.clipboard = 'unnamedplus'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- nvim-tree binds 
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

-- Horizontal split
vim.api.nvim_set_keymap('n', '<leader>ss', ':split<CR>', { noremap = true, silent = true })  -- Horizontal split
-- Vertical split
vim.api.nvim_set_keymap('n', '<leader>sv', ':vsplit<CR>', { noremap = true, silent = true })  -- Vertical split

-- Open terminal in a horizontal split
vim.api.nvim_set_keymap('n', '<leader>tt', ':split | terminal<CR>', { noremap = true, silent = true })

-- Open terminal in a vertical split
vim.api.nvim_set_keymap('n', '<leader>tv', ':vsplit | terminal<CR>', { noremap = true, silent = true })

-- Close the current terminal window
vim.api.nvim_set_keymap('t', '<leader>q', [[<C-\><C-n>:q<CR>]], { noremap = true, silent = true })

-- Exit terminal mode to normal mode
vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })


-- nvim-ale config
--vim.cmd [[
 -- let g:ale_linters = {
  --    \ 'typescript': ['ts_ls'],
   --   \ 'typescriptreact': ['ts_ls'],
    --  \ }
 -- let g:ale_fixers = {
  --    \ 'typescript': ['prettier'],
   --   \ 'typescriptreact': ['prettier'],
    --  \ }
 -- let g:ale_fix_on_save = 1
--]]

-- telescope binds
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
