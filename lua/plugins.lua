-- aliases
local execute = vim.api.nvim_command
local fn = vim.fn
local g = vim.g
local cmd = vim.cmd

-- utility functions
function install_servers()
	-- https://github.com/kabouzeid/nvim-lspinstall for full list
	for _, server in pairs({'bash',
		       		'css',
		       		'dockerfile',
		       		'go',
		       		'html',
		       		'json',
		       		'lua',
		       		'python',
		       		'vim',
		       		'vue',
		       		'yaml',
		       		'deno',
		       		'diagnosticls'}) do
		require'lspinstall'.install_server(server)
	end
end

local function setup_servers()
	require'lspinstall'.setup()

	local servers = require'lspinstall'.installed_servers()
	for _, server in pairs(servers) do
		if server ~= 'diagnosticls' then
			require'lspconfig'[server].setup{}
		end
	end
end

-- ensure packer is installed
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then 							-- if packer doesn't exist
	fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path}) 	-- clone repo
	execute 'packadd packer.nvim' 								-- add package
	install_servers() 										-- install lsp servers for first time
end

-- package list
require('packer').startup(function()
	use{
		-- functional
		'camspiers/snap',						-- producer/consumer based finder
		'junegunn/vim-easy-align', 					-- align text using ga
		'preservim/nerdcommenter', 					-- commenting with <leader>c<character>
		'tpope/vim-fugitive', 						-- git integration
		'tpope/vim-repeat',                            			-- allow plugins to map .
		'tpope/vim-surround',                          			-- manipulate surrounding symbols
		'wbthomason/packer.nvim', 					-- packer manages itself

		-- completion/linting
		'hrsh7th/nvim-compe', 						-- completion
		'kabouzeid/nvim-lspinstall', 					-- lsp installation helper
		'neovim/nvim-lspconfig', 					-- builtin lsp

		-- visual
		'RRethy/vim-illuminate',                       			-- highlight other occurences
		'airblade/vim-gitgutter', 					-- git diff visualization
		'junegunn/limelight.vim',					-- paragraph highlighting
		'karb94/neoscroll.nvim', 					-- smooth scrolling
		'lilydjwg/colorizer',						-- colorize hex color codes
		'machakann/vim-highlightedyank',				-- highlight yanked  text
		{'lukas-reineke/indent-blankline.nvim', branch = 'lua'}, 	-- blankline indent characters
		{ 								-- buffer line
			'akinsho/nvim-bufferline.lua',
			requires = 'kyazdani42/nvim-web-devicons'
		},
		{ 									-- status line
			'glepnir/galaxyline.nvim',
			branch = 'main',
			config = function() require'statusline' end,
			requires = {'kyazdani42/nvim-web-devicons', opt = true}
		},
		{ 								-- swap icons for nonicons.ttf
			'yamatsum/nvim-nonicons',
			requires = {'kyazdani42/nvim-web-devicons'}
		},
	}
end)

-- compe configuration
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

-- lspinstall configuration
setup_servers()

require'lspinstall'.post_install_hook = function()
	setup_servers() 	-- install new servers
	vim.cmd('bufdo e') 	-- reload buffer to trigger lsp startup
end

-- neoscroll configuration
require'neoscroll'.setup({
	-- enabled mappings
	mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
	hide_cursor = false,         	-- dont hide cursor while scrolling
	stop_eof = true,             	-- stop at <EOF> when scrolling downwards
	use_local_scrolloff = true,  	-- use local scrolloff instead of global
	respect_scrolloff = false,   	-- stop scrolling when the cursor reaches scrolloff margin of file
	cursor_scrolls_alone = true, 	-- cursor will keep scrolling even if window cannot scroll further
	easing_function = "quadratic"	-- easing function
})

-- bufferline configuration
require"bufferline".setup{ options = {
	show_close_icon = false,
	diagnostics = "nvim_lsp",
	always_show_bufferline = false,
	show_buffer_icons = false,
}}

-- illuminate configuration
cmd("hi link illuminatedWord Visual")
g.Illuminate_ftblacklist = {'', 'text'}
