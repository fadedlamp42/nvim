-- Modern keymaps for Neovim v0.11.1
local keymap = vim.keymap.set

-- Better defaults
keymap("i", "jk", "<esc>", { desc = "Exit insert mode" })
keymap("t", "jk", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Better movement on wrapped lines
keymap("n", "j", "gj", { desc = "Move down visually" })
keymap("n", "k", "gk", { desc = "Move up visually" })

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
keymap("n", "<M-C-k>", "<C-w><C-W>", { desc = "Cycle windows" })
keymap("n", "<M-NL>", "<C-w><S-w>", { desc = "Cycle windows reverse" })

-- Window splits
keymap("n", "<leader>s", "<cmd>split<cr>", { desc = "Split horizontal" })
keymap("n", "<leader>S", "<cmd>vsplit<cr>", { desc = "Split vertical" })

-- Window resizing
keymap("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
keymap("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
keymap("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
keymap("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
keymap("n", "<C-y>", "<cmd>res +3<cr>", { desc = "Increase window height" })

-- Buffer navigation
keymap("n", "J", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
keymap("n", "K", "<cmd>bnext<cr>", { desc = "Next buffer" })
keymap("n", "<M-C-w>", "<cmd>bp | bd! #<cr>", { desc = "Close buffer" })
keymap("n", "<leader>q", "<cmd>bp | bd #<cr>", { desc = "Close buffer" })

-- File navigation
keymap("n", "<leader>f", "<cmd>Oil<cr>", { desc = "Open file explorer" })
keymap("n", "<leader>F", "<cmd>Oil .<cr>", { desc = "Open file explorer in cwd" })

-- Utility
keymap("n", "<leader><space>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
keymap("n", "<leader>cd", "<cmd>cd %:h<cr>", { desc = "Change to file directory" })
keymap("n", "<leader>p", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("File path copied: " .. path)
end, { desc = "Copy file path" })

-- Config
keymap("n", "<leader>V", "<cmd>e ~/.config/nvim/init.lua<cr>", { desc = "Edit init.lua" })
keymap("n", "<leader>R", function()
  vim.cmd("source ~/.config/nvim/init.lua")
  vim.notify("Configuration reloaded!")
end, { desc = "Reload config" })

-- Better indenting
keymap("v", "<", "<gv", { desc = "Indent left" })
keymap("v", ">", ">gv", { desc = "Indent right" })

-- Move lines
keymap("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
keymap("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
keymap("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })
keymap("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })
keymap("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
keymap("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- Paste without overwriting register
keymap("x", "<leader>P", [["_dP]], { desc = "Paste without yanking" })

-- Delete without yanking
keymap({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })

-- Search and replace
keymap("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Search and replace word" })

-- LSP keymaps (will be enhanced by LSP plugin)
keymap("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
keymap("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
keymap("n", "gI", vim.lsp.buf.implementation, { desc = "Go to implementation" })
keymap("n", "gy", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
keymap("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
keymap("n", "<leader>?", vim.lsp.buf.hover, { desc = "Hover" })
keymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
keymap("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename" })
keymap("n", "<leader>f", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format" })

-- Diagnostics
keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
keymap("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic" })
keymap("n", "<leader>ql", vim.diagnostic.setloclist, { desc = "Diagnostic loclist" })

-- Quickfix
keymap("n", "<leader>qo", "<cmd>copen<cr>", { desc = "Open quickfix" })
keymap("n", "<leader>qc", "<cmd>cclose<cr>", { desc = "Close quickfix" })
keymap("n", "[q", "<cmd>cprev<cr>", { desc = "Previous quickfix" })
keymap("n", "]q", "<cmd>cnext<cr>", { desc = "Next quickfix" })

-- Location list
keymap("n", "<leader>lo", "<cmd>lopen<cr>", { desc = "Open loclist" })
keymap("n", "<leader>lc", "<cmd>lclose<cr>", { desc = "Close loclist" })
keymap("n", "[l", "<cmd>lprev<cr>", { desc = "Previous loclist" })
keymap("n", "]l", "<cmd>lnext<cr>", { desc = "Next loclist" })

-- Note: Smooth scrolling with <C-u>, <C-d>, <C-b>, <C-f> is handled by neoscroll.nvim

-- Better search navigation (center screen on jumps)
keymap("n", "n", "nzzzv", { desc = "Next search result (centered)" })
keymap("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
keymap("n", "*", "*zzzv", { desc = "Search word under cursor (centered)" })
keymap("n", "#", "#zzzv", { desc = "Search word under cursor backward (centered)" })

-- Git (Fugitive style)
keymap("n", "<leader>Ga", "<cmd>Git add %<cr>", { desc = "Git add current file" })
keymap("n", "<leader>GA", "<cmd>Git add .<cr>", { desc = "Git add all" })
keymap("n", "<leader>Gb", "<cmd>Git blame<cr>", { desc = "Git blame" })
keymap("n", "<leader>Gc", "<cmd>Git commit<cr>", { desc = "Git commit" })
keymap("n", "<leader>Gd", "<cmd>Git diff<cr>", { desc = "Git diff" })
keymap("n", "<leader>GD", "<cmd>Git diff --staged<cr>", { desc = "Git diff staged" })
keymap("n", "<leader>Gi", "<cmd>Git init<cr>", { desc = "Git init" })
keymap("n", "<leader>Gs", "<cmd>Git status<cr>", { desc = "Git status" })
keymap("n", "<leader>GSp", "<cmd>Git stash pop<cr>", { desc = "Git stash pop" })
keymap("n", "<leader>GSP", "<cmd>Git stash push<cr>", { desc = "Git stash push" })
keymap("n", "<leader>Gl", "<cmd>Git log<cr>", { desc = "Git log" })
keymap("n", "<leader>Gp", "<cmd>Git pull<cr>", { desc = "Git pull" })
keymap("n", "<leader>GP", "<cmd>Git push<cr>", { desc = "Git push" })
keymap("n", "<leader>Gr", "<cmd>Git reset<cr>", { desc = "Git reset" })

-- Additional mappings from old config
keymap("n", "<leader>l", "<cmd>Twilight<cr>", { desc = "Toggle Twilight (Limelight replacement)" })
keymap("n", "<leader>t", "<cmd>TroubleToggle<cr>", { desc = "Toggle Trouble" })
keymap("n", "<leader>T", "<cmd>TodoTrouble<cr>", { desc = "Todo Trouble" })
keymap("n", "<A-p>", "<cmd>Telescope git_files<cr>", { desc = "Git files" })
keymap("i", "<C-p>", "<cmd>Copilot panel<cr>", { desc = "Copilot panel" })

-- Command abbreviations
vim.cmd("cnoreabbrev W w")
vim.cmd("cnoreabbrev Q q")
vim.cmd("cnoreabbrev Wq wq")
vim.cmd("cnoreabbrev WQ wq")
vim.cmd("cnoreabbrev Qa qa")
vim.cmd("cnoreabbrev QA qa")
vim.cmd("cab cc CodeCompanion")
