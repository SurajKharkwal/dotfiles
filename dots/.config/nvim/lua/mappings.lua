require "nvchad.mappings"

local map = vim.keymap.set
local nomap = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Disable mappings
nomap("i", "<C-k>")
nomap("n", "<C-k>")

--open find files
map("n", "<leader><leader>", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })

-- Move line down
map("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
map("i", "<A-j>", "<Esc><cmd>m .+1<CR>==gi", { desc = "Move line down" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move line down" })

-- Move line up
map("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
map("i", "<A-k>", "<Esc><cmd>m .-2<CR>==gi", { desc = "Move line up" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

map("n", "<leader>e", "<cmd> NvimTreeFindFileToggle <cr>", { desc = "Toogle tree"})

-- Oil
-- map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Tmux navigator
map("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", { desc = "Tmux Navigator Down" })
map("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", { desc = "Tmux Navigator Up" })
map("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", { desc = "Tmux Navigator Right" })
map("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "Tmux Navigator Left" })

-- Terminal
-- new terminals
map("n", "<A-h>h", function()
  require("nvchad.term").new { pos = "sp" }
end, { desc = "terminal new horizontal term" })

map("n", "<A-v>", function()
  require("nvchad.term").new { pos = "vsp" }
end, { desc = "terminal new vertical term" })
-- toggleable
map({ "n", "t" }, "<leader>v", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "terminal toggleable vertical term" })

map({ "n", "t" }, "<leader>h", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal toggleable horizontal term" })



map("n", "<leader>ch", "<cmd>e ~/.local/share/nvim/lazy/NvChad/lua/nvchad/mappings.lua <CR>", { desc = "toggle nvcheatsheet" })

