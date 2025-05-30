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
vim.api.nvim_set_hl(0, "FadedSteel", { fg = "#3d5a7a" })     -- steel blue
vim.api.nvim_set_hl(0, "FadedAmber", { fg = "#8b5a2b" })     -- warm amber brown
vim.api.nvim_set_hl(0, "FadedIndigo", { fg = "#4a4a7a" })   -- muted indigo
vim.api.nvim_set_hl(0, "FadedCopper", { fg = "#a0522d" })   -- copper orange-brown
vim.api.nvim_set_hl(0, "FadedNavy", { fg = "#2d3d5f" })     -- deep navy
vim.api.nvim_set_hl(0, "FadedRust", { fg = "#8b4513" })     -- rust orange
vim.api.nvim_set_hl(0, "FadedPurple", { fg = "#5a3d6b" })   -- muted purple
local configure_indent = function()
	require("ibl").setup {
		indent = {
			highlight = {
				"FadedSteel",
				"FadedAmber",
				"FadedIndigo",
				"FadedCopper",
				"FadedNavy",
				"FadedRust",
				"FadedPurple"
			}
		}
		-- scope = {
			-- 	enabled = true,
			-- 	show_start = true,
			-- 	show_end = false,
			-- 	highlight = { "Function", "Label" },
			-- 	priority = 500,
		-- }
	}
end
-- https://codecompanion.olimorris.dev/getting-started.html#suggested-plugin-workflow
local configure_codecompanion = function()
	require("codecompanion").setup({
		opts = {
			system_prompt = function(opts)
				--[[ Default prompt
					return "
						You are an AI programming assistant named "CodeCompanion". You are currently plugged in to the Neovim text editor on a user's machine.

						Your core tasks include:
						- Answering general programming questions.
						- Explaining how the code in a Neovim buffer works.
						- Reviewing the selected code in a Neovim buffer.
						- Generating unit tests for the selected code.
						- Proposing fixes for problems in the selected code.
						- Scaffolding code for a new workspace.
						- Finding relevant code to the user's query.
						- Proposing fixes for test failures.
						- Answering questions about Neovim.
						- Running tools.

						You must:
						- Follow the user's requirements carefully and to the letter.
						- Keep your answers short and impersonal, especially if the user responds with context outside of your tasks.
						- Minimize other prose.
						- Use Markdown formatting in your answers.
						- Include the programming language name at the start of the Markdown code blocks.
						- Avoid including line numbers in code blocks.
						- Avoid wrapping the whole response in triple backticks.
						- Only return code that's relevant to the task at hand. You may not need to return all of the code that the user has shared.
						- Use actual line breaks instead of '\n' in your response to begin new lines.
						- Use '\n' only when you want a literal backslash followed by a character 'n'.
						- All non-code responses must be in %s.

						When given a task:
						1. Think step-by-step and describe your plan for what to build in pseudocode, written out in great detail, unless asked not to do so.
						2. Output the code in a single code block, being careful to only return relevant code.
						3. You should always generate short suggestions for the next user turns that are relevant to the conversation.
						4. You can only give one reply for each conversation turn.
					"
				end,
				]]
				--
				return "You're a programming assistant. Answer coding questions, explain code, review selections, generate tests, fix code issues, scaffold new code, find relevant code, fix test failures, answer Neovim questions, and run tools. Keep responses extremely brief—just one sentence unless specifically asked for more. Use proper Markdown with language indicators for code blocks, avoid line numbers, and don't wrap entire responses in backticks. Use actual line breaks instead of '\n' except when literal. Use blunt language, don't make extra suggestions, and use concise words."
			end,
		},
		adapters = {
			copilot = function()
				return require("codecompanion.adapters").extend("copilot", {
					schema = {
						model = {
							default = "claude-3.7-sonnet",
						},
					},
				})
			end,
			-- ollama = function()
			-- 	return require("codecompanion.adapters").extend("ollama", {
			-- 		schema = {
			-- 			model = {
			-- 				default = "gemma3:4b-it-qat",
			-- 			},
			-- 		},
			-- 	})
			-- end,
		},
		strategies = {
			-- TODO figure out tool calling with ollama
			-- chat = {
			-- 	adapter = "ollama",
			-- },
			-- inline = {
			-- 	adapter = "ollama",
			-- },
			-- cmd = {
			-- 	adapter = "ollama",
			-- },
			chat = {
				adapter = "copilot",
			},
			inline = {
				adapter = "copilot",
			},
			cmd = {
				adapter = "copilot",
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

-- mcphub
local configure_mcphub = function()
	require("mcphub").setup({
		config = vim.fn.expand("~/.config/nvim/mcp-servers.json"),

		auto_approve = true, -- Auto approve mcp tool calls (best for codecompanion integration)
		auto_toggle_mcp_servers = true, -- Let LLMs start and stop MCP servers automatically

		-- Extensions configuration
		-- extensions = {
		-- 	codecompanion = {
		-- 		show_result_in_chat = true,
		-- 		make_vars = true,
		-- 		make_slash_commands = true, -- make /slash commands from MCP server prompts
		-- 	},
		-- },

		-- Default window settings
		ui = {
			window = {
				width = 0.8, -- 0-1 (ratio); "50%" (percentage); 50 (raw number)
				height = 0.8, -- 0-1 (ratio); "50%" (percentage); 50 (raw number)
				relative = "editor",
				zindex = 50,
				border = "rounded", -- "none", "single", "double", "rounded", "solid", "shadow"
			},
			wo = { -- window-scoped options (vim.wo)
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
		{ "folke/which-key.nvim", requires = "echasnovski/mini.icons" }, -- keybinding helper
		{
			"glepnir/galaxyline.nvim",
			config = function()
				require("statusline")
			end,
			requires = { "nvim-tree/nvim-web-devicons", opt = true },
		}, -- status line
		{ "junegunn/fzf.vim", requires = "junegunn/fzf" }, -- fuzzy finder
		{ "kkoomen/vim-doge", run = ":call doge#install()" }, -- docstring generation
		{ "lukas-reineke/indent-blankline.nvim", branch = "master", config = configure_indent, requires = { "nvim-treesitter/nvim-treesitter" }}, -- blankline indent characters
		{ "napmn/react-extract.nvim", requires = { "nvim-treesitter/nvim-treesitter" } }, -- extract components
		{ "yamatsum/nvim-nonicons", requires = { "nvim-tree/nvim-web-devicons" } }, -- swap icons for nonicons.ttf
		{
			"olimorris/codecompanion.nvim",
			config = configure_codecompanion,
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-treesitter/nvim-treesitter", -- To fix yaml parser error, run :TSInstall yaml
				"ravitemer/mcphub.nvim",
				"echasnovski/mini.pick",
			},
		},
		{ "ravitemer/mcphub.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = configure_mcphub }, -- npm install -g mcp-hub@latest,
		{
			"CopilotC-Nvim/CopilotChat.nvim",
			requires = {
				{ "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
				{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
			},
			build = "make tiktoken", -- Only on MacOS or Linux
		},
		{
			"MeanderingProgrammer/render-markdown.nvim",
			after = { "nvim-treesitter" },
			requires = { "nvim-tree/nvim-web-devicons", opt = true }, -- if you prefer nvim-web-devicons
			config = function()
				require("render-markdown").setup({})
			end,
		},

		-- LSP and completion
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"petertriho/cmp-git",

		-- For vsnip users
		"hrsh7th/cmp-vsnip",
		"hrsh7th/vim-vsnip",

		-- always loaded last
		"ryanoasis/vim-devicons", -- font icons
	})
end)

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

-- nvim-cmp
local cmp = require("cmp")

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				if #cmp.get_entries() == 1 then
					cmp.confirm({ select = true })
				else
					cmp.select_next_item()
				end
			--[[ Replace with your snippet engine (see above sections on this page)
      elseif snippy.can_expand_or_advance() then
        snippy.expand_or_advance() ]]
			-- elseif has_words_before() then
			-- 	cmp.complete()
			-- 	if #cmp.get_entries() == 1 then
			-- 		cmp.confirm({ select = true })
			-- 	end
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "vsnip" }, -- For vsnip users.
	}, {
		{ name = "buffer" },
	}),
})

-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "git" },
	}, {
		{ name = "buffer" },
	}),
})
require("cmp_git").setup()

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
	matching = { disallow_symbol_nonprefix_matching = false },
})

-- Set up lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local c = { capabilities = capabilities }
local lsp = require("lspconfig")
lsp.bashls.setup(c)
lsp.ccls.setup(c)
lsp.csharp_ls.setup(c)
lsp.cssls.setup(c)
lsp.dockerls.setup(c)
lsp.eslint.setup(c)
lsp.gopls.setup(c)
lsp.html.setup(c)
lsp.kotlin_language_server.setup({
	kotlin = { languageServer = { path = "kotlin-language-server" } },
	capabilities = capabilities,
})
lsp.pyright.setup(c)
lsp.solargraph.setup({ diagnostics = true, formatting = true })
lsp.tailwindcss.setup(c)
lsp.terraformls.setup(c)
lsp.ts_ls.setup(c)
lsp.vimls.setup(c)
lsp.yamlls.setup(c)

g.markdown_fenced_languages = { "ts=typescript" }

-- codecompanion
g.codecompanion_auto_tool_mode = true
