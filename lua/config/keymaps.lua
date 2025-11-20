-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Override gr to jump directly if only one reference
vim.keymap.set("n", "gr", function()
  local params = vim.lsp.util.make_position_params()
  vim.lsp.buf_request(0, "textDocument/references", params, function(err, result, ctx, config)
    if err or not result or #result == 0 then
      vim.notify("No references found", vim.log.levels.INFO)
      return
    end

    -- Filter out the current position
    local current_line = vim.api.nvim_win_get_cursor(0)[1]
    local current_file = vim.api.nvim_buf_get_name(0)
    local filtered = vim.tbl_filter(function(ref)
      local ref_file = vim.uri_to_fname(ref.uri)
      local ref_line = ref.range.start.line + 1
      return not (ref_file == current_file and ref_line == current_line)
    end, result)

    if #filtered == 1 then
      -- Jump directly to single reference
      vim.lsp.util.jump_to_location(filtered[1], "utf-8")
    else
      -- Show telescope picker for multiple references
      require("telescope.builtin").lsp_references({ include_current_line = false })
    end
  end)
end, { desc = "References" })

-- Search within LSP root (sub-project root)
vim.keymap.set("n", "<leader>fL", function()
  -- Get the LSP client's root directory
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    vim.notify("No LSP client attached", vim.log.levels.WARN)
    return
  end

  local root_dir = clients[1].config.root_dir
  if not root_dir then
    vim.notify("LSP client has no root directory", vim.log.levels.WARN)
    return
  end

  require("telescope.builtin").live_grep({ cwd = root_dir })
end, { desc = "Search in LSP root" })

vim.keymap.set("n", "<leader>fF", function()
  -- Get the LSP client's root directory
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    vim.notify("No LSP client attached", vim.log.levels.WARN)
    return
  end

  local root_dir = clients[1].config.root_dir
  if not root_dir then
    vim.notify("LSP client has no root directory", vim.log.levels.WARN)
    return
  end

  require("telescope.builtin").find_files({ cwd = root_dir })
end, { desc = "Find files in LSP root" })
