local utils = require "gale.utils"
local map = utils.glb_map

map("n", ";", ":", { desc = "Enter CMD mode" })
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })
map({ "n", "i" }, "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "Copy file content" })
map("n", "z-", "z^", { desc = "Remap z^ into z- to match z+" })
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear search highlights" })
map("n", "<leader>cs", "<cmd><CR>", { desc = "Clear statusline" })
map("n", "<leader>cm", "<cmd>mes clear<CR>", { desc = "Clear messages" })
-- https://github.com/neovim/neovim/issues/2048
map("i", "<A-BS>", "<C-w>", { desc = "Remove word" })
map("v", "y", "ygv<Esc>", { desc = "Yank preventing cursor from jumping back to where selection started" })
map("n", "<leader>ol", function()
  vim.ui.open(vim.fn.expand "%:p:h")
end, { desc = "Open file location in file explorer" })

-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
map("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
map("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
map("n", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
map("n", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })

-- Buffer motions
map("i", "<C-b>", "<ESC>^i", { desc = "Go to beginning of line" })
map("i", "<C-e>", "<End>", { desc = "Go to end of line" })
map("i", "<C-h>", "<Left>", { desc = "Go to left" })
map("i", "<C-l>", "<Right>", { desc = "Go to right" })
map("i", "<C-j>", "<Down>", { desc = "Go down" })
map("i", "<C-k>", "<Up>", { desc = "Go up" })
map("n", "<leader>gm", "<cmd>exe 'normal! ' . line('$')/2 . 'G'<CR>", { desc = "Go to middle of the file" })

-- Move lines up/down
map("n", "<A-j>", ":m .+1<CR>", { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>", { desc = "Move line up" })
map("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
map("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Switch buffers
map("n", "<C-h>", "<C-w>h", { desc = "Buffer switch left" })
map("n", "<C-l>", "<C-w>l", { desc = "Buffer switch right" })
map("n", "<C-j>", "<C-w>j", { desc = "Buffer switch down" })
map("n", "<C-k>", "<C-w>k", { desc = "Buffer switch up" })

-- Quick resize pane
map("n", "<C-A-h>", "5<C-w>>", { desc = "Window increase width by 5" })
map("n", "<C-A-l>", "5<C-w><", { desc = "Window decrease width by 5" })
map("n", "<C-A-k>", "5<C-w>+", { desc = "Window increase height by 5" })
map("n", "<C-A-j>", "5<C-w>-", { desc = "Window decrease height by 5" })

-- Togglers
map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "Toggle line number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "Toggle relative number" })
map("n", "<leader>ih", "<cmd>ToggleInlayHints<CR>", { desc = "Toggle inlay hints" })
map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "Toggle nvcheatsheet" })

-- Term
map("t", "<C-x>", "<C-\\><C-N>", { desc = "Term escape terminal mode" })

map({ "n", "t" }, "<C-\\>", function()
  local project_root = vim.fn.getcwd()
  require("nvchad.term").toggle {
    pos = "vsp",
    id = "vtoggleTermLoc",
    cmd = "cd " .. project_root,
  }
end, { desc = "Term toggle vertical split in buffer location" })

map({ "n", "t" }, "<C-]>", function()
  local project_root = vim.fn.getcwd()
  require("nvchad.term").toggle {
    pos = "sp",
    id = "htoggleTermLoc",
    cmd = "cd " .. project_root,
  }
end, { desc = "Term toggle horizontal split in project location" })

map({ "n", "t" }, "<C-f>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "Term toggle floating" })

map({ "n", "t" }, "<C-A-i>", function()
  require("nvchad.term").toggle {
    pos = "float",
    id = "floatTermLoc",
    cmd = "cd " .. vim.fn.expand "%:p:h",
  }
end, { desc = "Term toggle floating in buffer location" })

--[[ local mouseactions = {
  "<LeftMouse>",
  "<2-LeftMouse>",
  "<3-LeftMouse>",
  "<4-LeftMouse>",
}
map("t", mouseactions, "<nop>", { desc = "Prevent from entering NTERMINAL mode when clicking a term" }) ]]

-- TreeSitter
map({ "n", "v" }, "<leader>it", function()
  utils.toggle_inspect_tree()
end, { desc = "TreeSitter toggle inspect tree" })

map("n", "<leader>ii", "<cmd>Inspect<CR>", { desc = "TreeSitter inspect under cursor" })

-- Trouble
map("n", "<leader>cd", "<cmd>Trouble diagnostics<CR>", { desc = "Trouble diagnostics" })

-- LSP
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" })

-- Utils
map("n", "gh", function()
  utils.go_to_github_link()
end, { desc = "Go to GitHub link generated from string" })

--- Tabufline
local tabufline = require "nvchad.tabufline"

map("n", "<Tab>", function()
  tabufline.next()
end, { desc = "Buffer go to next" })

map("n", "<S-Tab>", function()
  tabufline.prev()
end, { desc = "Buffer go to prev" })

map("n", "<leader>bn", "<cmd>enew<CR>", { desc = "Buffer new" })

map("n", "<leader>x", function()
  tabufline.close_buffer()
end, { desc = "Buffer close" })
map("n", "S-q", function()
  tabufline.close_buffer()
end, { desc = "Buffer close" })

for i = 1, 9 do
  map("n", "<A-" .. i .. ">", i .. "gt", { desc = "Tab go to tab " .. i })
end

map("n", "<A-Left>", function()
  tabufline.move_buf(-1)
end)

map("n", "<A-Right>", function()
  tabufline.move_buf(1)
end)
