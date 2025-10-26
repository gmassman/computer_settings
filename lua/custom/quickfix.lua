-- Create a directory to store quickfix lists
local qf_dir = vim.fn.stdpath 'data' .. '/quickfix'
vim.fn.mkdir(qf_dir, 'p')

-- Helper function to get a safe filename from project path
local function get_qf_filename()
  local cwd = vim.fn.getcwd()
  -- Replace path separators and special chars with underscores
  local safe_name = cwd:gsub('[/\\:]', '_'):gsub('^_', '')
  return qf_dir .. '/' .. safe_name .. '.json'
end

-- Save quickfix list with filenames
vim.api.nvim_create_user_command('QfSave', function(opts)
  local filename = opts.args ~= '' and opts.args or get_qf_filename()
  -- Get quickfix list with all details including filenames
  local qf_list = vim.fn.getqflist { all = true }

  -- Ensure each item has a filename instead of just bufnr
  for _, item in ipairs(qf_list.items) do
    if item.bufnr ~= 0 then
      item.filename = vim.fn.bufname(item.bufnr)
      item.bufnr = 0
    end
  end

  local json = vim.fn.json_encode(qf_list)
  vim.fn.writefile({ json }, filename)
  print('Quickfix list saved to ' .. filename)
end, { nargs = '?' })

-- Load quickfix list
vim.api.nvim_create_user_command('QfLoad', function(opts)
  local filename = opts.args ~= '' and opts.args or get_qf_filename()
  if vim.fn.filereadable(filename) == 0 then
    print('No saved quickfix list found at ' .. filename)
    return
  end
  local json = vim.fn.readfile(filename)
  local qf_list = vim.fn.json_decode(table.concat(json))

  vim.fn.setqflist({}, ' ', qf_list)
  vim.cmd 'copen'
  print('Quickfix list loaded from ' .. filename)
end, { nargs = '?' })

vim.api.nvim_create_user_command('QfDelete', function()
  -- Get the current quickfix list and index
  local qf_list = vim.fn.getqflist()
  local qf_idx = vim.fn.getqflist({ idx = 0 }).idx

  if qf_idx == 0 or #qf_list == 0 then
    print 'No quickfix entry selected'
    return
  end

  -- Remove the item at current index
  table.remove(qf_list, qf_idx)

  -- Update the quickfix list
  vim.fn.setqflist(qf_list, 'r')

  -- Adjust the index if we deleted the last item
  if qf_idx > #qf_list and #qf_list > 0 then
    vim.fn.setqflist({}, 'a', { idx = #qf_list })
  end

  print('Removed quickfix entry ' .. qf_idx)
end, {})
