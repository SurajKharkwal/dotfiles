-- Set 2-space indentation for all cpp files
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.expandtab = true

-- Practice directory path
local practice_dir = vim.fn.expand "~/Practice/"

-- Check if the file is inside ~/Practice (including subdirectories)
if vim.fn.expand("%:p"):find(practice_dir, 1, true) == 1 then
  -- Disable cmp only for these files
  -- vim.b.cmp_enabled = false
  -- require("cmp").setup.buffer { enabled = vim.b.cmp_enabled }

  -- Auto-insert template if the file is NEW
  if vim.fn.line "$" == 1 and vim.fn.getline(1) == "" then
    local template = {
      "#include <bits/stdc++.h>",
      "using namespace std;",
      "",
      "int main() {",
      "  ",
      "  return 0;",
      "}",
    }
    vim.api.nvim_buf_set_lines(0, 0, -1, false, template)
    vim.api.nvim_win_set_cursor(0, { 5, 3 })
  end
end
