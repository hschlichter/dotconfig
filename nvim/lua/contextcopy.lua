-- Captures visual mode and line range, then copies formatted code block.
-- Mode is captured inside the keymap (before exiting visual mode) and passed
-- as opts.args so visualmode() is never called stale after the command runs.

-- Returns byte columns for '< and '>, or nil/nil if marks are not yet set.
local function get_visual_cols()
  local start_pos = vim.fn.getpos("'<")
  local end_pos   = vim.fn.getpos("'>")
  -- getpos returns {0,0,0,0} when the mark has never been set.
  if start_pos[2] == 0 then
    return nil, nil
  end
  return start_pos[3], end_pos[3]
end

local function copy_range_with_context(line1, line2, mode)
  -- 0 = current buffer (nvim_buf_get_lines convention)
  local bufnr = 0

  local filename = vim.fn.expand("%:.")
  -- Fall back to home-relative path when cwd is not an ancestor of the file
  -- (expand("%:.") returns a "../.." style path in that case).
  if filename:sub(1, 2) == ".." then
    filename = vim.fn.expand("%:~")
  end
  if filename == "" then
    filename = "[No Name]"
  end

  local ft = vim.bo.filetype ~= "" and vim.bo.filetype or "text"

  -- getpos() returns byte columns; used only for charwise and blockwise modes.
  -- '<  is always the earlier mark regardless of selection direction, so
  -- start_col <= end_col is guaranteed by Neovim for normal selections.
  local start_col, end_col = get_visual_cols()

  local lines = vim.api.nvim_buf_get_lines(bufnr, line1 - 1, line2, false)
  local body  = {}

  if mode == "V" then
    -- Linewise: columns are irrelevant.
    for i, line in ipairs(lines) do
      table.insert(body, string.format("%d | %s", line1 + i - 1, line))
    end

  elseif mode == "\22" then
    -- Blockwise: getpos() returns byte columns, so sub() is correct for ASCII.
    -- NOTE: multibyte characters (e.g. UTF-8 CJK, emoji) cause the visual
    -- block columns to misalign with byte offsets.  This is a known Neovim
    -- limitation and would require charwidth/strdisplaywidth logic to fix.
    for i, line in ipairs(lines) do
      local text
      if start_col then
        local sc = math.min(start_col, end_col)
        local ec = math.max(start_col, end_col)
        text = line:sub(sc, ec)
      else
        text = line
      end
      table.insert(body, string.format("%d | %s", line1 + i - 1, text))
    end

  else
    -- Charwise: Neovim always normalises '< / '> so that '< is the earlier
    -- position, meaning start_col <= end_col for any selection direction.
    for i, line in ipairs(lines) do
      local text
      if #lines == 1 then
        text = start_col and line:sub(start_col, end_col) or line
      elseif i == 1 then
        text = start_col and line:sub(start_col) or line
      elseif i == #lines then
        text = start_col and line:sub(1, end_col) or line
      else
        text = line
      end
      table.insert(body, string.format("%d | %s", line1 + i - 1, text))
    end
  end

  local block = table.concat({
    string.format("File: %s", filename),
    string.format("Lines: %d-%d", line1, line2),
    "```" .. ft,
    table.concat(body, "\n"),
    "```",
  }, "\n")

  vim.fn.setreg("+", block)
  vim.fn.setreg('"', block)
  vim.notify("Copied code block with context", vim.log.levels.INFO)
end

vim.api.nvim_create_user_command("ContextCopy", function(opts)
  -- opts.args carries the visual mode character forwarded by the keymap.
  -- Fallback to "V" (linewise) when invoked directly from the command line.
  local mode = opts.args ~= "" and opts.args or "V"
  copy_range_with_context(opts.line1, opts.line2, mode)
end, {
  range = true,
  nargs = "?",
  desc  = "Copy selected range with context",
})

vim.keymap.set("x", "<leader>cc", function()
  -- Capture mode NOW, while still in visual mode, before exiting it.
  local mode = vim.fn.visualmode()
  -- vim.schedule defers until after the current event completes, ensuring
  -- Neovim has committed '< and '> before getpos() reads them.
  vim.schedule(function()
    vim.cmd(string.format("'<,'>ContextCopy %s", mode))
  end)
end, {
  desc   = "Copy visual selection with context",
  silent = true,
})
