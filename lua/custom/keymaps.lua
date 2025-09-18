-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- save
vim.keymap.set({ 'n', 'i', 'v' }, '<C-s>', '<cmd>w<CR>', { desc = 'Save' })

-- insert blank lines
-- Use ]<Space> and [<Space> instead of these!
-- vim.keymap.set('n', '<CR>', 'o<Esc>k', { desc = 'Insert blank line below' })
-- vim.keymap.set('n', '<A-CR>', 'O<Esc>j', { desc = 'Insert blank line above' })

-- preferred redo key
vim.keymap.set('n', 'U', '<C-r>', { desc = 'Redo' })

-- move highlighted blocks up and down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move up' })

-- join and keep cursor in place
vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Join lines' })

-- search keeps cursor in the middle
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result (down)' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Next search result (up)' })

-- yank customizations
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d', { desc = 'Delete without yanking' })
vim.keymap.set({ 'n', 'v' }, '<C-y>', '"+y', { desc = 'Copy to system clipboard' })

vim.keymap.set('n', '<leader>pd', 'Ofrom pprint import pprint as pp; import ipdb; ipdb.set_trace()<esc>:w<CR>', { desc = '[D]ebug breakpoint with ipdb' })
vim.keymap.set(
  'n',
  '<leader>pc',
  'Ofrom pprint import pprint as pp; from celery.contrib import rdb; rdb.set_trace()<esc>:w<CR>',
  { desc = '[D]ebug breakpoint for [C]elery' }
)

-- buffers
vim.keymap.set('n', '<leader>bn', ':bnext<CR>', { desc = '[N]ext [B]uffer' })
vim.keymap.set('n', '<leader>bl', ':blast<CR>', { desc = '[L]ast [B]uffer' })
vim.keymap.set('n', '<leader>bd', function()
  require('mini.bufremove').delete()
end, { desc = '[D]elete [B]uffer' })

vim.keymap.set('n', '<leader>bD', function()
  local bufnrs = vim.tbl_filter(function(bufnr)
    if 1 ~= vim.fn.buflisted(bufnr) then
      return false
    end
    if not vim.api.nvim_buf_is_loaded(bufnr) then
      return false
    end

    return true
  end, vim.api.nvim_list_bufs())

  for _, bufnr in ipairs(bufnrs) do
    require('mini.bufremove').delete(bufnr)
  end
end, { desc = '[D]elete all [B]uffers' })
