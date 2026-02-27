-- convenience mapping function (stolen from https://github.com/siduck76/NvChad/blob/main/init.lua)
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- leader
vim.g.mapleader = ","

-- jk to exit interactive/terminal mode
map("i", "jk", "<esc>")
map("t", "jk", "<C-\\><C-n>")

-- <leader>F to open netrw in current window
map("n", "<leader>F", "<cmd>Explore<CR>")

-- <leader>t to open chadtree
map("n", "<leader>t", "<cmd>CHADopen<CR>")

-- <leader>s to split horizontally
map("n", "<leader>s", "<cmd>split<CR>")

-- <leader>S to vertical split
map("n", "<leader>S", "<cmd>vsplit<CR>")

-- J/K to flip buffers
map("n", "J", "<cmd>bprev<CR>")
map("n", "K", "<cmd>bnext<CR>")

-- <Space>[1-9] to switch to Nth buffer (by bufferline visual order)
for i = 1, 9 do
    vim.keymap.set("n", "<Space>" .. i, function()
        require("bufferline").go_to(i, true)
    end, { noremap = true, silent = true })
end

-- <Space>h/<Space>l to move buffer left/right in bufferline
vim.keymap.set("n", "<Space>h", "<cmd>BufferLineMovePrev<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Space>l", "<cmd>BufferLineMoveNext<CR>", { noremap = true, silent = true })

-- closing buffer
map("n", "<M-C-w>", "<cmd>bp <BAR> bd! #<CR>")

-- <leader>V to edit init.lua
map("n", "<leader>V", "<cmd>e ~/.config/nvim/init.lua<CR>")

-- clear search highlight after search and fix paste insert mode
map("n", "<leader><space>", "<cmd>nohlsearch<CR>:set nopaste<CR>")

-- j and k to move visually on wrapped lines
map("n", "j", "gj")
map("n", "k", "gk")

-- <C-k> and <C-j> to cycle windows
map("n", "<C-k>", "<C-w><C-W>")
map("n", "<M-C-k>", "<C-w><C-W>")
map("n", "<C-j>", "<C-w><S-w>")
map("n", "<M-NL>", "<C-w><S-w>")

-- <C-hyil> to resize windows
map("n", "<C-h>", "<cmd>vertical res -3<CR>")
map("n", "<C-l>", "<cmd>vertical res +3<CR>")
map("n", "<C-y>", "<cmd>res +3<CR>")

-- <leader-p> to copy absolute path of current file
map("n", "<leader>p", "<cmd>let @+ = expand('%:p')<CR>:echo 'File path copied to clipboard: ' . expand('%:p')<CR>")

-- <leader-P> to copy relative path (relative to cwd) of current file
map("n", "<leader>P", "<cmd>let @+ = fnamemodify(expand('%:p'), ':.')<CR>:echo 'Relative path copied: ' . fnamemodify(expand('%:p'), ':.')<CR>")

-- <leader>cd to change to current directory
map("n", "<leader>cd", "<cmd>cd %:h<CR>")

-- <leader-R> to reload init.lua
map("n", "<leader>R", "<cmd>source ~/.config/nvim/init.lua<CR>:echo 'Reloaded init.lua'<CR>")

-- filetype / formatting
map("n", "<leader>f", "<cmd>set ft=markdown<CR>") -- enables snippets, spell, render-markdown in blank buffers
map("n", "<leader>q", "<cmd>%!sleek<CR>:set filetype=sql<CR>:set foldmethod=indent<CR>")

-- lsp actions
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
map("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>")
map("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>")
map("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
map("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
map("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
map("n", "<leader>?", "<Cmd>lua vim.lsp.buf.hover()<CR>")
map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")
map("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>")
map("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>")
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")

-- plugin mappings
-- > limelight
map("n", "<leader>l", "<cmd>Limelight!! 0.85<CR>") -- <leader>l to toggle limelight

-- > Trouble
map("n", "<leader>T", "<cmd>TodoTrouble<CR>") -- <leader>T to view TODOs with Trouble

-- > easy-align
vim.cmd("xmap ga <Plug>(EasyAlign)") -- EasyAlign visual mode
vim.cmd("nmap ga <Plug>(EasyAlign)") -- interactive EasyAlign for a motion/text object

-- > git-fugitive
map("n", "<leader>Ga", "<cmd>Git add %<CR>") -- <leader>Ga to add current file
map("n", "<leader>GA", "<cmd>Git add .<CR>") -- <leader>GA to add current directory
map("n", "<leader>Gb", "<cmd>Git blame<CR>") -- <leader>Gb for git blame
map("n", "<leader>Gc", "<cmd>Git commit<CR>") -- <leader>Gc to commit
map("n", "<leader>Gd", "<cmd>Git diff<CR>") -- <leader>Gd to diff unstaged files
map("n", "<leader>GD", "<cmd>Git diff --staged<CR>") -- <leader>GD to diff staged files
map("n", "<leader>Gi", "<cmd>Git init<CR>") -- <leader>Gi for git init
map("n", "<leader>Gs", "<cmd>Git status<CR>") -- <leader>Gs for git status
map("n", "<leader>GSp", "<cmd>Git stash pop<CR>") -- <leader>GSp to pop off of stack
map("n", "<leader>GSP", "<cmd>Git stash push<CR>") -- <leader>GSP to push onto stack
map("n", "<leader>Gl", "<cmd>Git log<CR>") -- <leader>Gl for git log
map("n", "<leader>Gp", "<cmd>Git pull<CR>") -- <leader>Gp for git pull
map("n", "<leader>GP", "<cmd>Git push<CR>") -- <leader>GP for git push
map("n", "<leader>Gr", "<cmd>Git reset<CR>") -- <leader>Gr for git reset

-- > Copilot
map("i", "<C-p>", "<cmd>Copilot panel<CR>") -- <C-p> in insert mode to open Copilot panel

-- fzf
map("n", "<C-g>", "<cmd>Rg<CR>")
map("n", "<C-p>", "<cmd>Files<CR>")
map("n", "<A-p>", "<cmd>GFiles<CR>")
map("n", "<C-s>", "<cmd>Snippets<CR>") -- browse and expand global vsnip snippets
map("i", "<C-s>", "<cmd>Snippets<CR>") -- same from insert mode

-- vim-doge
map("n", "<leader>D", "<cmd>DogeGenerate<CR>") -- :DogeGenerate on <leader>D

map("n", "<TAB>", "<Plug>(doge-comment-jump-forward)")
map("n", "<S-TAB>", "<Plug>(doge-comment-jump-backward)")

-- codecompanion
map("n", "<leader>a", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
map("v", "<leader>a", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
map("n", "<C-a>", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
map("v", "<C-a>", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
map("v", "a", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

vim.cmd([[cab cc CodeCompanion]]) -- 'cc'->'CodeCompanion' in command mode

-- vim-lexical spell check toggle
map("n", "<leader>L", "<cmd>set spell!<CR>", { noremap = true, silent = true })

-- aerial code outline (configured in plugins.lua on_attach, but also global binding)
map("n", "<leader>A", "<cmd>AerialToggle!<CR>", { noremap = true, silent = true })

-- macdict - macOS Dictionary.app lookup (offline)
map("n", "<leader>dd", "<cmd>lua require('macdict').lookup()<CR>", { noremap = true, silent = true })

-- nvim-dap debugging (gdb-style: c=continue, n=next, s=step, o=out, b=breakpoint)
map("n", "<leader>dc", "<cmd>lua require('dap').continue()<CR>", { noremap = true, silent = true })
map("n", "<leader>dn", "<cmd>lua require('dap').step_over()<CR>", { noremap = true, silent = true })
map("n", "<leader>ds", "<cmd>lua require('dap').step_into()<CR>", { noremap = true, silent = true })
map("n", "<leader>do", "<cmd>lua require('dap').step_out()<CR>", { noremap = true, silent = true })
map("n", "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<CR>", { noremap = true, silent = true })
map(
    "n",
    "<leader>dB",
    "<cmd>lua require('dap').set_breakpoint(vim.fn.input('condition: '))<CR>",
    { noremap = true, silent = true }
)
map("n", "<leader>dr", "<cmd>lua require('dap').repl.open()<CR>", { noremap = true, silent = true })
map("n", "<leader>dl", "<cmd>lua require('dap').run_last()<CR>", { noremap = true, silent = true })
map("n", "<leader>dx", "<cmd>lua require('dap').terminate()<CR>", { noremap = true, silent = true })
