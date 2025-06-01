local o = vim.opt

-- visual
o.scrolloff = 10 -- 10 line buffer at top/bottom of buffer
o.termguicolors = true -- :help termguicolors
o.number = true -- line numbers
o.cursorline = true -- highlight current line
o.showmatch = true -- briefly jump to matching [{()}] on completion
o.lazyredraw = true -- don't update screen during macros
o.linebreak = true -- break on words instead of characters

-- functional
--o.autochdir = true 			-- working directory is always directory of current file
o.hidden = true -- don't close abandoned buffers (allows background persistence)
o.completeopt = "menuone,noselect" -- necessary for compe
o.mouse = "a" -- mouse support
o.foldmethod = "syntax" -- fold based on syntax files
o.foldlevelstart = 99 -- fold completely on file open (99 = infinite)
o.colorcolumn = "100"
