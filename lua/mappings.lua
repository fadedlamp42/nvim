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
map('i', '<TAB>', 'pumvisible() ? "<C-n>" : "<TAB>"', {expr = true}) 	 	-- tab advances
map('i', '<S-TAB>', 'pumvisible() ? "<C-p>" : "<C-h>"', {expr = true}) 	 	-- shift+tab reverts
map('i', '<CR>', 'pumvisible() ? "<C-g>u" : "<CR>"', {expr = true}) 	-- enter confirms

-- jk to exit interactive/terminal mode
map('i', 'jk', '<esc>')
map('t', 'jk', '<C-\\><C-n>')

-- <leader>f to open netrw in vertical split
map('n', '<leader>f', '<cmd>Vexplore<CR>')

-- <leader>F to open netrw in current window
map('n', '<leader>F', '<cmd>Explore<CR>')

-- <leader>s to split horizontally
map('n', '<leader>s', '<cmd>split<CR>')

-- <leader>S to vertical split
map('n', '<leader>S', '<cmd>vsplit<CR>')

-- J/K to flip buffers
map('n', 'J', '<cmd>bprev<CR>')
map('n', 'K', '<cmd>bnext<CR>')

-- <leader>W to close buffer
map('n', '<leader>W', '<cmd>bp <BAR> bd! #<CR>')

-- <leader>V to edit init.lua
map('n', '<leader>V', '<cmd>e ~/.config/nvim/init.lua<CR>')

-- clear search highlight after search and fix paste insert mode
map('n', '<leader><space>', '<cmd>nohlsearch<CR>:set nopaste<CR>')

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
map('n', '<C-h>', '<cmd>vertical res -3<CR>')
map('n', '<C-l>', '<cmd>vertical res +3<CR>')
map('n', '<C-y>', '<cmd>res +3<CR>')
map('n', '<C-i>', '<cmd>res -3<CR>')

-- lsp actions
map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
map('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
map('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
map('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
map('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
map('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
map('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
map('n', '<leader>?', '<Cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
map('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
