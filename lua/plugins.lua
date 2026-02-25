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
vim.api.nvim_set_hl(0, "FadedSteel", { fg = "#3d5a7a" }) -- steel blue
vim.api.nvim_set_hl(0, "FadedAmber", { fg = "#8b5a2b" }) -- warm amber brown
vim.api.nvim_set_hl(0, "FadedIndigo", { fg = "#4a4a7a" }) -- muted indigo
vim.api.nvim_set_hl(0, "FadedCopper", { fg = "#a0522d" }) -- copper orange-brown
vim.api.nvim_set_hl(0, "FadedNavy", { fg = "#2d3d5f" }) -- deep navy
vim.api.nvim_set_hl(0, "FadedRust", { fg = "#8b4513" }) -- rust orange
vim.api.nvim_set_hl(0, "FadedPurple", { fg = "#5a3d6b" }) -- muted purple
local configure_indent = function()
    require("ibl").setup({
        indent = {
            highlight = {
                "FadedSteel",
                "FadedAmber",
                "FadedIndigo",
                "FadedCopper",
                "FadedNavy",
                "FadedRust",
                "FadedPurple",
            },
        },
        -- scope = {
        -- 	enabled = true,
        -- 	show_start = true,
        -- 	show_end = false,
        -- 	highlight = { "Function", "Label" },
        -- 	priority = 500,
        -- }
    })
end
-- disable polyglot for filetypes where treesitter handles highlighting
g.polyglot_disabled = { "markdown" }

-- package list
require("packer").startup(function()
    use({
        "prisma/vim-prisma", -- prisma syntax highlighting
        "MaxMEllon/vim-jsx-pretty", -- react syntax highlighting
        "RRethy/vim-illuminate", -- highlight other occurences
        "airblade/vim-gitgutter", -- git diff visualization
        "chentoast/marks.nvim", -- mark manipulation and visualization
        "github/copilot.vim", -- GitHub Copilot
        "junegunn/limelight.vim", -- paragraph highlighting
        "junegunn/vim-easy-align", -- align text using ga
        "karb94/neoscroll.nvim", -- smooth scrolling
        "lilydjwg/colorizer", -- colorize hex color codes

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
        "dhruvasagar/vim-table-mode", -- markdown table manipulation
        "wbthomason/packer.nvim", -- packer manages itself
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim", requires = { "williamboman/mason.nvim" } },
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
        {
            "lukas-reineke/indent-blankline.nvim",
            branch = "master",
            config = configure_indent,
            requires = { "nvim-treesitter/nvim-treesitter" },
        }, -- blankline indent characters
        {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            config = function()
                require("nvim-treesitter.configs").setup({
                    ensure_installed = { "markdown", "markdown_inline" },
                    highlight = { enable = true },
                })
            end,
        },
        { "napmn/react-extract.nvim", requires = { "nvim-treesitter/nvim-treesitter" } }, -- extract components
        { "yamatsum/nvim-nonicons", requires = { "nvim-tree/nvim-web-devicons" } }, -- swap icons for nonicons.ttf
        {
            "MeanderingProgrammer/render-markdown.nvim",
            after = { "nvim-treesitter" },
            requires = { "nvim-tree/nvim-web-devicons", opt = true }, -- if you prefer nvim-web-devicons
            config = function()
                require("render-markdown").setup({
                    heading = {
                        backgrounds = {
                            "FadedSteel",
                            "FadedAmber",
                            "FadedIndigo",
                            "FadedCopper",
                            "FadedNavy",
                            "FadedRust",
                        },
                        foregrounds = {
                            "FadedSteel",
                            "FadedAmber",
                            "FadedIndigo",
                            "FadedCopper",
                            "FadedNavy",
                            "FadedRust",
                        },
                    },
                })
            end,
        },
        {
            "ms-jpq/chadtree",
            branch = "chad",
        },
        {
            "stevearc/aerial.nvim",
            requires = {
                "nvim-treesitter/nvim-treesitter",
                "nvim-tree/nvim-web-devicons",
            },
            config = function()
                require("aerial").setup({
                    on_attach = function(bufnr)
                        vim.keymap.set("n", "<leader>A", "<cmd>AerialToggle!<CR>", { buffer = bufnr })
                    end,
                })
            end,
        },
        "powerman/vim-plugin-AnsiEsc",

        -- debugging
        "mfussenegger/nvim-dap",

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
require("lsp_signature").setup(signature_config)

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

-- vsnip: custom snippet directory (inside nvim config repo for version control)
-- global.json is loaded for all filetypes via the autocmd below
g.vsnip_snippet_dir = vim.fn.stdpath("config") .. "/snippets"
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        local ft = vim.bo.filetype
        if ft ~= "" then
            local filetypes = vim.g.vsnip_filetypes or {}
            if not filetypes[ft] then
                filetypes[ft] = { "global" }
                vim.g.vsnip_filetypes = filetypes
            end
        end
    end,
})

-- :Snippets command - browse and expand global snippets via fzf
vim.api.nvim_create_user_command("Snippets", function()
    local path = g.vsnip_snippet_dir .. "/global.json"
    local file = io.open(path, "r")
    if not file then
        vim.notify("no snippet file at " .. path, vim.log.levels.WARN)
        return
    end
    local snippets = vim.json.decode(file:read("*a"))
    file:close()

    -- build lookup table and fzf display lines
    local body_by_prefix = {}
    local lines = {}
    for name, snippet in pairs(snippets) do
        local prefix = snippet.prefix or name
        local desc = snippet.description or ""
        if #desc > 80 then
            desc = desc:sub(1, 77) .. "..."
        end
        body_by_prefix[prefix] = snippet.body
        table.insert(lines, prefix .. "  " .. desc)
    end
    table.sort(lines)

    vim.fn["fzf#run"](vim.fn["fzf#wrap"]({
        source = lines,
        options = { "--prompt", "snippet> " },
        sink = function(selected)
            local prefix = selected:match("^(%S+)")
            local body = body_by_prefix[prefix]
            if body then
                vim.fn["vsnip#anonymous"](table.concat(body, "\n"))
            end
        end,
    }))
end, {})

-- highlight yanked text (native replacement for vim-highlightedyank)
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
    end,
})

-- copilot
g.copilot_enabled = false

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
        ["width"] = 0.98,
        ["height"] = 0.98,
    },
}
g.fzf_vim = {
    ["grep_multi_line"] = 2, -- path on separate lines (https://github.com/junegunn/fzf.vim?tab=readme-ov-file#command-level-options)
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
        -- vsnip jump takes priority so Tab always advances through snippet tabstops
        -- ses_37be58172ffeLI93N9PSkf7ckc
        ["<Tab>"] = cmp.mapping(function(fallback)
            if vim.fn["vsnip#jumpable"](1) == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(vsnip-jump-next)", true, true, true), "")
            elseif cmp.visible() then
                if #cmp.get_entries() == 1 then
                    cmp.confirm({ select = true })
                else
                    cmp.select_next_item()
                end
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if vim.fn["vsnip#jumpable"](-1) == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(vsnip-jump-prev)", true, true, true), "")
            elseif cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
    }, {
        { name = "buffer" },
        { name = "path" },
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

-- mason: LSP server installer (replaces nvim-lsp-installer)
-- ensure mason can find toolchains regardless of how nvim was launched
local mason_path_extras = {
    vim.fn.expand("$HOME/.nvm/versions/node/v25.6.1/bin"),
    "/opt/homebrew/bin",
    "/opt/homebrew/opt/ruby/bin",
    "/opt/homebrew/lib/ruby/gems/4.0.0/bin",
}
vim.env.PATH = table.concat(mason_path_extras, ":") .. ":" .. vim.env.PATH

require("mason").setup()
require("mason-lspconfig").setup({
    -- NOTE: ccls not available in mason, install via system package manager (brew install ccls)
    ensure_installed = {
        "bashls",
        "csharp_ls",
        "cssls",
        "dockerls",
        "eslint",
        "gopls",
        "html",
        "kotlin_language_server",
        "pyright",
        "solargraph",
        "tailwindcss",
        "terraformls",
        "ts_ls",
        "vimls",
        "yamlls",
    },
})

-- lsp setup with native vim.lsp.config (nvim 0.11+)
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local c = { capabilities = capabilities }

vim.lsp.config("bashls", c)
vim.lsp.config("ccls", c)
vim.lsp.config("csharp_ls", c)
vim.lsp.config("cssls", c)
vim.lsp.config("dockerls", c)
vim.lsp.config("eslint", c)
vim.lsp.config("gopls", c)
vim.lsp.config("html", c)
vim.lsp.config("kotlin_language_server", {
    kotlin = { languageServer = { path = "kotlin-language-server" } },
    capabilities = capabilities,
})
vim.lsp.config("pyright", c)
vim.lsp.config("solargraph", { diagnostics = true, formatting = true })
vim.lsp.config("tailwindcss", c)
vim.lsp.config("terraformls", c)
vim.lsp.config("ts_ls", c)
vim.lsp.config("vimls", c)
vim.lsp.config("yamlls", c)

vim.lsp.enable({
    "bashls",
    "ccls",
    "csharp_ls",
    "cssls",
    "dockerls",
    "eslint",
    "gopls",
    "html",
    "kotlin_language_server",
    "pyright",
    "solargraph",
    "tailwindcss",
    "terraformls",
    "ts_ls",
    "vimls",
    "yamlls",
})

g.markdown_fenced_languages = { "ts=typescript" }

-- nvim-dap (node debugging via vscode-js-debug)
-- install: download js-debug-dap-*.tar.gz from https://github.com/microsoft/vscode-js-debug/releases
-- extract to ~/.local/share/nvim/js-debug/
local dap = require("dap")
local js_debug_path = vim.fn.stdpath("data") .. "/js-debug/src/dapDebugServer.js"

dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
        command = "node",
        args = { js_debug_path, "${port}" },
    },
}

-- shared config for js/ts
local js_config = {
    {
        type = "pwa-node",
        request = "launch",
        name = "launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
    },
    {
        type = "pwa-node",
        request = "attach",
        name = "attach",
        port = 9229,
        cwd = "${workspaceFolder}",
        sourceMaps = true,
        resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
        },
    },
}

dap.configurations.javascript = js_config
dap.configurations.typescript = js_config

-- native vim spell check and thesaurus
vim.opt.thesaurus:append(vim.fn.stdpath("config") .. "/thesaurus/mthesaur.txt")
vim.opt.dictionary:append("/usr/share/dict/words")
vim.opt.spellcapcheck = "" -- disable capitalization checking

-- enable spell check for markdown and text files
vim.cmd([[
	augroup prose_settings
		autocmd!
		autocmd FileType markdown,mkd,text setlocal spell
	augroup END
]])
