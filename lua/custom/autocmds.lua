-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Use django style highlighting for jinja/html files
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = { '*.html.jinja', '*.html.j2', '*.html' },
  callback = function()
    vim.o.filetype = 'htmldjango'
  end,
})

-- Check if there's a [No Name] buffer and delete it if it's empty or just whitespace
-- I know this causes a bug with neo-tree whenever the first file is opened with telescope ...sigh
-- vim.api.nvim_create_autocmd('BufRead', {
--   callback = function()
--     for _, buf in ipairs(vim.api.nvim_list_bufs()) do
--       if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_name(buf) == '' then
--         local buf_lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
--         if #buf_lines == 1 and buf_lines[1] == '' then
--           vim.api.nvim_buf_delete(buf, { force = false })
--           break
--         end
--       end
--     end
--   end,
-- })
