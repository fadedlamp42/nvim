-- aliases
local g = vim.g
local cmd = vim.cmd

-- colorscheme
cmd 'colorscheme fadedwolf'

-- modules
require 'plugins' -- NOTE: install paq-nvim from https://github.com/savq/paq-nvim then run :PaqInstall
require 'mappings'
require 'options'

-- plugin configuration
g.indent_blankline_enabled = true 				
g.indent_blankline_char = "▏"
g.indent_blankline_show_first_indent_level = false
