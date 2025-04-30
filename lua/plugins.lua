-- aliases
local execute = vim.api.nvim_command
local fn = vim.fn
local g = vim.g
local cmd = vim.cmd

-- utility functions
local function host_matches(host)
	return fn.system({ "hostname" }) == host
end

-- ensure packer is installed
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then -- if packer doesn't exist
	fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path }) -- clone repo
	execute("packadd packer.nvim") -- add package
end

-- configuration functions to keep final plugin lines clean
local configure_which_key = function()
	require("which-key").setup({
		plugins = {
			marks = true, -- shows a list of your marks on ' and `
			registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
			spelling = {
				enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
				suggestions = 50, -- how many suggestions should be shown in the list? (default 20)
			},
			-- the presets plugin, adds help for a bunch of default keybindings in Neovim
			-- No actual key bindings are created
			presets = {
				operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
				motions = true, -- adds help for motions
				text_objects = true, -- help for text objects triggered after entering an operator
				windows = true, -- default bindings on <c-w>
				nav = true, -- misc bindings to work with windows
				z = true, -- bindings for folds, spelling and others prefixed with z
				g = true, -- bindings for prefixed with g
			},
		},
		-- add operators that will trigger motion and text object completion
		-- to enable all native operators, set the preset / operators plugin above
		operators = { gc = "Comments" },
		key_labels = {
			-- override the label used to display some keys. It doesn't effect WK in any other way.
			-- For example:
			-- ["<space>"] = "SPC",
			-- ["<cr>"] = "RET",
			-- ["<tab>"] = "TAB",
		},
		icons = {
			breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
			separator = "➜", -- symbol used between a key and it's label
			group = "+", -- symbol prepended to a group
		},
		window = {
			border = "double", -- none, single, double, shadow (default none)
			position = "bottom", -- bottom, top
			margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
			padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		},
		layout = {
			height = { min = 4, max = 25 }, -- min and max height of the columns
			width = { min = 20, max = 50 }, -- min and max width of the columns
			spacing = 3, -- spacing between columns
			align = "left", -- align columns left, center or right
		},
		ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
		hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
		show_help = true, -- show help message on the command line when the popup is visible
		triggers = "auto", -- automatically setup triggers
		-- triggers = {"<leader>"} -- or specify a list manually
		triggers_blacklist = {
			-- list of mode / prefixes that should never be hooked by WhichKey
			-- this is mostly relevant for key maps that start with a native binding
			-- most people should not need to change this
			i = { "j", "k" },
			v = { "j", "k" },
		},
	})
end

-- https://codecompanion.olimorris.dev/getting-started.html#suggested-plugin-workflow
local configure_codecompanion = function()
	require("codecompanion").setup({
		strategies = {
			chat = {
				adapter = "ollama",
			},
			inline = {
				adapter = "ollama",
			},
			cmd = {
				adapter = "ollama",
			},
		},
		extensions = {
			mcphub = {
				callback = "mcphub.extensions.codecompanion",
				opts = {
					make_vars = true,
					make_slash_commands = true,
					show_result_in_chat = true,
				},
			},
		},
	})
end

-- package list
require("packer").startup(function()
	use({
		"MaxMEllon/vim-jsx-pretty", -- react syntax highlighting
		"RRethy/vim-illuminate", -- highlight other occurences
		"airblade/vim-gitgutter", -- git diff visualization
		"chentoast/marks.nvim", -- mark manipulation and visualization
		"github/copilot.vim", -- GitHub Copilot
		"junegunn/limelight.vim", -- paragraph highlighting
		"junegunn/vim-easy-align", -- align text using ga
		"karb94/neoscroll.nvim", -- smooth scrolling
		"lilydjwg/colorizer", -- colorize hex color codes
		"machakann/vim-highlightedyank", -- highlight yanked  text
		"mattn/emmet-vim", -- quick html/css editing
		"mfussenegger/nvim-lint", -- linting to augment lsps
		"neovim/nvim-lspconfig", -- builtin lsp
		"pechorin/any-jump.vim", -- definition jumping
		"preservim/nerdcommenter", -- commenting with <leader>c<character>
		"ray-x/lsp_signature.nvim", -- signature help
		"sbdchd/neoformat", -- code formatting, best to not connect to automatic saves
		"sheerun/vim-polyglot", -- syntax files for folding
		"tpope/vim-fugitive", -- git integration
		"tpope/vim-repeat", -- allow plugins to map .
		"tpope/vim-surround", -- manipulate surrounding symbols
		"wbthomason/packer.nvim", -- packer manages itself
		"williamboman/nvim-lsp-installer", -- lsp installation helper
		{
			"folke/todo-comments.nvim",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("todo-comments").setup({})
			end,
		}, -- see https://github.com/folke/todo-comments.nvim for configuration
		{
			"folke/trouble.nvim",
			requires = "nvim-tree/nvim-web-devicons",
			config = function()
				require("trouble").setup({})
			end,
		}, -- see https://github.com/folke/trouble.nvim for configuration
		{ "akinsho/nvim-bufferline.lua", requires = "nvim-tree/nvim-web-devicons" }, -- buffer line
		{ "folke/which-key.nvim", requires = "echasnovski/mini.icons", config = configure_which_key }, -- keybinding helper
		{
			"glepnir/galaxyline.nvim",
			config = function()
				require("statusline")
			end,
			requires = { "nvim-tree/nvim-web-devicons", opt = true },
		}, -- status line
		{ "junegunn/fzf.vim", requires = "junegunn/fzf" }, -- fuzzy finder
		{ "kkoomen/vim-doge", run = ":call doge#install()" }, -- docstring generation
		{ "lukas-reineke/indent-blankline.nvim", branch = "master" }, -- blankline indent characters
		{ "napmn/react-extract.nvim", requires = { "nvim-treesitter/nvim-treesitter" } }, -- extract components
		{ "yamatsum/nvim-nonicons", requires = { "nvim-tree/nvim-web-devicons" } }, -- swap icons for nonicons.ttf
		{
			"olimorris/codecompanion.nvim",
			dependencies = {
				"ravitemer/mcphub.nvim",
			},
			config = configure_codecompanion,
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-treesitter/nvim-treesitter", -- To fix yaml parser error, run :TSInstall yaml
				"ravitemer/mcphub.nvim",
			},
		},

		-- always loaded last
		"ryanoasis/vim-devicons", -- font icons
	})
end)

-- lsp-installer
local lsp = require("lspconfig")
lsp.bashls.setup({}) -- npm i -g bash-language-server
lsp.ccls.setup({}) -- sudo apt install ccls
lsp.csharp_ls.setup({}) -- dotnet tool install --global csharp-ls
lsp.cssls.setup({}) -- npm i -g vscode-langservers-extracted
lsp.dockerls.setup({}) -- npm install -g dockerfile-language-server-nodejs
lsp.eslint.setup({}) -- npm i -g vscode-langservers-extracted
lsp.gopls.setup({}) -- go install golang.org/x/tools/gopls@latest
lsp.html.setup({}) -- npm i -g vscode-langservers-extracted
lsp.kotlin_language_server.setup({ kotlin = { languageServer = { path = "kotlin-language-server" } } }) -- https://www.andersevenrud.net/neovim.github.io/lsp/configurations/kotlin_language_server/
lsp.pyright.setup({}) -- npm i -g pyright
lsp.solargraph.setup({ diagnostics = true, formatting = true }) -- gem install solargraph
lsp.tailwindcss.setup({}) -- npm install -g @tailwindcss/language-server
lsp.terraformls.setup({}) -- https://github.com/hashicorp/terraform-ls
lsp.ts_ls.setup({}) -- npm install -g typescript typescript-language-server
lsp.vimls.setup({}) -- npm install -g vim-language-server
lsp.yamlls.setup({}) -- yarn global add yaml-language-server (npm install -g yaml-language-server)

g.markdown_fenced_languages = { "ts=typescript" }

-- neoscroll
require("neoscroll").setup({
	hide_cursor = false,
	easing_function = "sine",
})

-- bufferline
require("bufferline").setup({
	options = {
		show_close_icon = false,
		diagnostics = "nvim_lsp",
		always_show_bufferline = false,
		show_buffer_icons = false,
	},
})

-- illuminate
cmd("hi link illuminatedWord Visual")
g.Illuminate_ftblacklist = { "", "text" }

-- vim-go
g.go_imports_autosave = 0
g.go_doc_keywordprg_enabled = 0

-- emmet-vim
g.user_emmet_leader_key = "<c-e>"

-- neoformat: sudo npm install -g @johnnymorganz/stylua-bin prettier
g.neoformat_run_all_formatters = 1

-- lsp_signature
local signature_config = {
	doc_lines = 30, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);

	max_height = 30, -- max height of signature floating_window
	max_width = 100, -- max_width of signature floating_window

	floating_window = false, -- show hint in a floating window, set to false for virtual text only mode

	floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
	-- will set to true when fully tested, set to false will use whichever side has more space
	-- this setting will be helpful if you do not want the PUM and floating win overlap

	floating_window_off_x = 1, -- adjust float windows x position.
	-- can be either a number or function
	floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines
	-- can be either number or function, see examples

	close_timeout = 1000, -- close floating window after ms when laster parameter is entered
	fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
	hint_enable = true, -- virtual hint enable
	hint_prefix = "🐼 ", -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
	hint_scheme = "String",
	hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
	handler_opts = {
		border = "rounded", -- double, rounded, single, shadow, none, or a table of borders
	},

	always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

	auto_close_after = 1000, -- autoclose signature float win after x sec, disabled if nil.
	extra_trigger_chars = { "(", "," }, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
	zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

	padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc

	transparency = nil, -- disabled by default, allow floating win transparent value 1~100
	shadow_blend = 36, -- if you using shadow as border use this set the opacity
	shadow_guibg = "Black", -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
	timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
	toggle_key = "<C-/>", -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'

	select_signature_key = "<M-n>", -- cycle to next signature, e.g. '<M-n>' function overloading
	move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating
}
require("lsp_signature").setup(cfg)

-- marks
require("marks").setup({
	-- whether to map keybinds or not. default true
	default_mappings = true,

	-- which builtin marks to show. default {}
	builtin_marks = { ".", "<", ">", "^" },

	-- whether movements cycle back to the beginning/end of buffer. default true
	cyclic = true,

	-- whether the shada file is updated after modifying uppercase marks. default false
	force_write_shada = false,

	-- how often (in ms) to redraw signs/recompute mark positions.
	-- higher values will have better performance but may cause visual lag,
	-- while lower values may cause performance penalties. default 150.
	refresh_interval = 250,

	-- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
	-- marks, and bookmarks.
	-- can be either a table with all/none of the keys, or a single number, in which case
	-- the priority applies to all marks.
	-- default 10.
	sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },

	-- disables mark tracking for specific filetypes. default {}
	excluded_filetypes = {},

	-- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
	-- sign/virttext. Bookmarks can be used to group together positions and quickly move
	-- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
	-- default virt_text is "".
	--bookmark_0 = {
	--  sign = "⚑",
	--  virt_text = "hello world",
	--  -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
	--  -- defaults to false.
	--  annotate = false,
	--},
	mappings = {},
})

-- vim-pydocstring
g.doge_enable_mappings = 0
g.doge_buffer_mappings = 0
g.doge_doc_standard_python = "numpy"

-- copilot
g.copilot_filetypes = { ["*"] = true }

-- nvim-lint
local pylint = require("lint").linters.pylint
-- pylint.args = {
-- 	'--rcfile', '/home/regular/code/chartmetric/script/.pylintrc',
-- 	'-f', 'json'
-- }
require("lint").linters_by_ft = {
	python = { "pylint", "ruff" },
}

vim.cmd("au BufWritePost * lua require('lint').try_lint()")

-- darker (relies on darker in pyenv)
vim.cmd("set autoread")
vim.cmd("autocmd BufWritePost *.py silent :!darker %")

-- fzf
g.fzf_layout = {
	["window"] = {
		["width"] = 0.95,
		["height"] = 0.95,
	},
}
