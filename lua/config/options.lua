-- Modern Neovim options for v0.11.1
local opt = vim.opt

-- Visual settings
opt.scrolloff = 10
opt.termguicolors = true
opt.number = true
opt.relativenumber = true -- Modern relative line numbers
opt.cursorline = true
opt.showmatch = true
-- opt.lazyredraw = true
opt.linebreak = true
opt.wrap = false -- Better for code
opt.colorcolumn = "100"
opt.signcolumn = "yes" -- Always show signcolumn to avoid layout shifts
opt.conceallevel = 0 -- Make `` visible in markdown files

-- Functional settings
opt.hidden = true
opt.completeopt = "menu,menuone,noselect"
opt.mouse = "a"
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevelstart = 99
opt.foldenable = false -- Start with folds open

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Backup and swap
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- Performance
opt.updatetime = 250
opt.timeoutlen = 500
opt.redrawtime = 10000

-- Split behavior
opt.splitbelow = true
opt.splitright = true

-- Clipboard (use system clipboard only for explicit yanks)
-- opt.clipboard = "unnamedplus"

-- Command line
opt.cmdheight = 1
opt.showmode = false -- Mode shown in statusline

-- Filetype settings
vim.filetype.add({
	extension = {
		conf = "dosini",
	},
})

-- Python provider
vim.g.python3_host_prog = vim.fn.system("which python3"):gsub("\n", "")
