-- convenience mapping function (stolen from https://github.com/siduck76/NvChad/blob/main/init.lua)
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- leader
vim.g.mapleader = ','

-- tab completion
map('i', '<TAB>', 'pumvisible() ? "<C-n>" : "<TAB>"', {expr = true}) 	 -- tab advances
map('i', '<S-TAB>', 'pumvisible() ? "<C-p>" : "<C-h>"', {expr = true}) 	 -- shift+tab reverts
map('i', '<CR>', 'pumvisible() ? "<C-y>" : "<C-g>u<CR>"', {expr = true}) -- enter confirms

-- jk to exit interactive/terminal mode
map('i', 'jk', '<esc>')
map('t', 'jk', '<C-\\><C-n>')

-- <leader>f to open netrw in vertical split
map('n', '<leader>f', ':Vexplore<CR>')

-- <leader>F to open netrw in current window
map('n', '<leader>F', ':Explore<CR>')

-- <leader>s to split horizontally
map('n', '<leader>s', ':split<CR>')

-- <leader>S to vertical split
map('n', '<leader>S', ':vsplit<CR>')

-- J/K to flip buffers
map('n', 'J', ':bprev<CR>')
map('n', 'K', ':bnext<CR>')

-- <leader>W to close buffer
map('n', '<leader>W', ':bp <BAR> bd! #<CR>')

-- <leader>V to edit init.lua
map('n', '<leader>V', ':e ~/.config/nvim/init.lua<CR>')

-- clear search highlight after search and fix paste insert mode
map('n', '<leader><space>', ':nohlsearch<CR>:set nopaste<CR>')

--[[ useful if tagbar is reinstalled
--map leader return to toggle tag sidebar
nnoremap <silent> <leader><CR> :TagbarToggle<CR>
nnoremap <silent> <leader>b :BuffergatorOpen<CR>
nnoremap <silent> <leader>B :BuffergatorClose<CR>
]]

-- j and k to move visually on wrapped lines
map('n', 'j', 'gj')
map('n', 'k', 'gk')

-- <C-k> and <C-j> to cycle windows
map('n', '<C-k>', '<C-w><C-W>')
map('n', '<C-j>', '<C-w><S-w>')

-- <C-hyil> to resize windows
map('n', '<C-h>', ':vertical res -3<CR>')
map('n', '<C-l>', ':vertical res +3<CR>')
map('n', '<C-y>', ':res +3<CR>')
map('n', '<C-i>', ':res -3<CR>')
