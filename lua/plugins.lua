-- aliases
local execute = vim.api.nvim_command
local fn = vim.fn
local g = vim.g
local cmd = vim.cmd

-- utility functions
local function host_matches(host)
	return fn.system({'hostname'}) == host
end

-- ensure packer is installed
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then 							-- if packer doesn't exist
	fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path}) 	-- clone repo
	execute 'packadd packer.nvim' 								-- add package
end

-- package list
require('packer').startup(function()
	use{
		-- functional
		'camspiers/snap',												-- producer/consumer based finder
		-- 'fatih/vim-go', 												-- go language server and commands
		'junegunn/vim-easy-align', 							-- align text using ga
		'mattn/emmet-vim',											-- quick html/css editing
		'pechorin/any-jump.vim',								-- definition jumping
		'preservim/nerdcommenter', 							-- commenting with <leader>c<character>
		'sheerun/vim-polyglot',									-- syntax files for folding
		'tpope/vim-fugitive', 									-- git integration
		'tpope/vim-repeat',                 		-- allow plugins to map .
		'tpope/vim-surround',               		-- manipulate surrounding symbols
		'wbthomason/packer.nvim', 							-- packer manages itself
		-- 'wellle/context.vim',										-- display logical context TODO find option to make this break less window integrations (snap, any-jump, etc.)
		{
			"folke/trouble.nvim",
			requires = "kyazdani42/nvim-web-devicons",
			config = function()
				require("trouble").setup {
					-- see https://github.com/folke/trouble.nvim for configuration
				}
			end
		},
		{
			"folke/todo-comments.nvim",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("todo-comments").setup {
					-- see https://github.com/folke/todo-comments.nvim for configuration
				}
			end
		},

		-- completion/linting
		'hrsh7th/nvim-compe', 									-- completion
		'williamboman/nvim-lsp-installer', 			-- lsp installation helper
		'neovim/nvim-lspconfig', 								-- builtin lsp

		-- visual
		'RRethy/vim-illuminate',            		-- highlight other occurences
		'airblade/vim-gitgutter', 							-- git diff visualization
		'junegunn/limelight.vim',								-- paragraph highlighting
		'lilydjwg/colorizer',										-- colorize hex color codes
		'MaxMEllon/vim-jsx-pretty',							-- react syntax highlighting
		'machakann/vim-highlightedyank',				-- highlight yanked  text
		{																				-- blankline indent characters
			'lukas-reineke/indent-blankline.nvim',
			branch = 'master'
		},
		{ 																			-- buffer line
			'akinsho/nvim-bufferline.lua',
			requires = 'kyazdani42/nvim-web-devicons'
		},
		{ 																			-- status line
			'glepnir/galaxyline.nvim',
			branch = 'dsych:bugfix/diagnostics',
			config = function() require'statusline' end,
			requires = {'kyazdani42/nvim-web-devicons', opt = true}
		},
		{ 																			-- swap icons for nonicons.ttf
			'yamatsum/nvim-nonicons',
			requires = {'kyazdani42/nvim-web-devicons'}
		},
		'karb94/neoscroll.nvim', 								-- smooth scrolling
	}

	-- unnecessary plugins that should only be loaded on powerful machines
	if host_matches('debian-tower') then
		use {
		{
			"folke/which-key.nvim",
			config = function()
				require("which-key").setup {
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
					hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
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
				}

			end
		},
		'tommcdo/vim-fubitive', 								-- bitbucket remote extension for fugitive
		}
	end
end)

-- compe
require'compe'.setup {
	enabled = true;
	autocomplete = true;
	debug = false;
	min_length = 0;
	preselect = 'disable';
	throttle_time = 80;
	source_timeout = 200;
	resolve_timeout = 800;
	incomplete_delay = 400;
	max_abbr_width = 100;
	max_kind_width = 100;
	max_menu_width = 100;
	documentation = true;

	source = {
		path = true;
		buffer = true;
		calc = true;
		nvim_lsp = true;
		nvim_lua = true;
		vsnip = true;
		ultisnips = true;
	};
}

-- lsp-installer
require'lspconfig'.bashls.setup{}               -- npm i -g bash-language-server
require'lspconfig'.ccls.setup{}								  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ccls
require'lspconfig'.csharp_ls.setup{} 						-- dotnet tool install --global csharp-ls
require'lspconfig'.cssls.setup{}                -- npm i -g vscode-langservers-extracted
require'lspconfig'.dockerls.setup{}             -- npm install -g dockerfile-language-server-nodejs
require'lspconfig'.eslint.setup{}               -- npm i -g vscode-langservers-extracted
require'lspconfig'.gopls.setup{}                -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#gopls
require'lspconfig'.html.setup{}                 -- npm i -g vscode-langservers-extracted
require'lspconfig'.jedi_language_server.setup{} -- pip3 install jedi-language-server
require'lspconfig'.solargraph.setup{						-- gem install solargraph
	diagnostics = true;
	formatting = true;
}
require'lspconfig'.tailwindcss.setup{}          -- npm install -g @tailwindcss/language-server
require'lspconfig'.terraform_lsp.setup{}        -- https://github.com/juliosueiras/terraform-lsp/releases
require'lspconfig'.tsserver.setup{}             -- npm install -g typescript typescript-language-server
require'lspconfig'.vimls.setup{}                -- npm install -g vim-language-server
require'lspconfig'.yamlls.setup{}               -- yarn global add yaml-language-server
require'lspconfig'.zeta_note.setup{             -- https://github.com/artempyanykh/zeta-note/releases
	cmd = {'/usr/local/bin/zeta-note-linux'}
}


vim.g.markdown_fenced_languages = {
  "ts=typescript"
}

-- vim-smoothie
-- g.smoothie_update_interval = 3
-- g.smoothie_base_speed = 9
-- g.smoothie_break_on_reverse = 1

-- neoscroll
require('neoscroll').setup({
	hide_cursor = false,
	easing_function = 'sine',
})

-- bufferline
require"bufferline".setup{ options = {
	show_close_icon = false,
	diagnostics = "nvim_lsp",
	always_show_bufferline = false,
	show_buffer_icons = false,
}}


-- illuminate
cmd("hi link illuminatedWord Visual")
g.Illuminate_ftblacklist = {'', 'text'}

-- vim-go
g.go_imports_autosave = 0
g.go_doc_keywordprg_enabled = 0

-- emmet-vim
g.user_emmet_leader_key = '<c-e>'
