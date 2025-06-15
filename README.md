# Modern Neovim v0.11.1 Configuration

This is a complete modern Neovim configuration built for maximum productivity with Python development in mind. The old configuration files have been backed up with `.bak` extensions.

## 🚀 What's New

This configuration leverages all the latest Neovim v0.11.1 features and the modern plugin ecosystem:

### Native LSP Configuration
- Uses the new `vim.lsp.config()` API where appropriate
- Comprehensive LSP setup with Mason for automatic tool management
- Enhanced diagnostic configuration with virtual text enabled

### Modern Python Development Stack
- **Pyright** for comprehensive type checking
- **Ruff LSP** for fast linting and formatting
- **conform.nvim** for reliable code formatting
- **nvim-lint** with mypy integration
- **Virtual environment selection** with venv-selector
- **REPL integration** with Iron.nvim
- **Debugging** with nvim-dap and dap-python

### Trending 2024-2025 Plugins
- **noice.nvim** - Complete UI overhaul for messages and popups
- **tiny-inline-diagnostic.nvim** - Modern inline diagnostic display
- **codecompanion.nvim** - Multi-model AI chat integration
- **oil.nvim** - Modern file explorer
- **trouble.nvim v3** - Enhanced diagnostic management

### Enhanced UI/UX
- **Lazy.nvim** plugin manager with fast startup
- **Lualine** with modern statusline
- **Bufferline** with LSP diagnostics integration
- **Dashboard** with custom ASCII art
- **Multiple colorschemes** with easy switching
- **Which-key** for keybinding discovery

## 📁 Configuration Structure

```
~/.config/nvim/
├── init.lua                 # Main entry point with lazy.nvim bootstrap
├── lua/
│   ├── config/             # Core configuration
│   │   ├── autocmds.lua    # Autocommands for enhanced functionality
│   │   ├── keymaps.lua     # Comprehensive keybinding setup
│   │   └── options.lua     # Modern Neovim options
│   └── plugins/            # Plugin configurations
│       ├── colorscheme.lua # Multiple colorscheme options
│       ├── completion.lua  # nvim-cmp + Copilot integration
│       ├── debug.lua       # DAP debugging configuration
│       ├── editor.lua      # Core editor functionality
│       ├── lsp.lua         # LSP configuration
│       ├── python.lua      # Python-specific tooling
│       ├── ui.lua          # UI enhancements
│       └── utils.lua       # Utility and productivity plugins
└── *.bak                   # Backup of original configuration
```

## 🔧 Key Features

### Python Development
- **Real-time linting** with Ruff and mypy
- **Automatic formatting** on save with Ruff
- **Type checking** with Pyright
- **Virtual environment management**
- **Debugging** with full DAP integration
- **Testing** with neotest framework
- **REPL integration** for interactive development

### Modern Workflow
- **Fuzzy finding** with Telescope
- **File management** with Oil.nvim
- **Git integration** with Gitsigns and Fugitive
- **Project management** with project.nvim
- **Session persistence** across restarts
- **Terminal integration** with ToggleTerm

### AI Integration
- **GitHub Copilot** with nvim-cmp integration
- **CopilotChat** for AI-powered code assistance
- **CodeCompanion** for multi-model AI interactions

### Error Navigation & Diagnostics
- **Trouble.nvim** for diagnostic management
- **Tiny-inline-diagnostic** for modern error display
- **Native LSP diagnostics** with enhanced configuration
- **Jump between errors** with `]d` and `[d`
- **Quickfix integration** for batch error handling

## ⌨️ Essential Keybindings

### Leader Key: `,`

#### File Operations
- `<leader>f` - Open Oil file explorer
- `<C-p>` - Find files (Telescope)
- `<C-g>` - Live grep (Telescope)
- `<leader>fr` - Recent files

#### Code Navigation
- `gd` - Go to definition
- `gr` - Go to references
- `K` - Hover documentation
- `<leader>ca` - Code actions
- `<leader>r` - Rename symbol

#### Diagnostics & Errors
- `]d` / `[d` - Next/previous diagnostic
- `<leader>xx` - Toggle Trouble diagnostics
- `<leader>e` - Show line diagnostic
- `<leader>q` - Open diagnostic loclist

#### Python Development
- `<leader>f` - Format code (Ruff)
- `<leader>ll` - Trigger linting
- `<leader>vs` - Select virtual environment
- `<leader>rs` - Toggle Python REPL

#### Git
- `<leader>gs` - Git status
- `<leader>gc` - Git commit
- `<leader>hs` - Stage hunk
- `<leader>hp` - Preview hunk

#### AI & Completion
- `<Tab>` - Accept completion/next item
- `<M-l>` - Accept Copilot suggestion
- `<leader>cc` - Toggle CopilotChat
- `<leader>a` - CodeCompanion actions

#### UI & Windows
- `<leader>z` - Zen mode
- `<leader>tw` - Twilight (focus mode)
- `J` / `K` - Previous/next buffer
- `<C-\>` - Toggle floating terminal

## 🎨 Colorschemes

Multiple modern colorschemes are included with easy switching:

- `<leader>uct` - Tokyo Night
- `<leader>ucc` - Catppuccin
- `<leader>ucr` - Rose Pine
- `<leader>uck` - Kanagawa
- `<leader>ucg` - GitHub Dark
- `<leader>uco` - OneDark
- `<leader>ucf` - FadedWolf (your original)

## 🔍 Python Linting & Error Navigation

The configuration provides comprehensive Python error detection and navigation:

### Linting Stack
1. **Ruff LSP** - Fast Python linting with auto-fixes
2. **Pyright** - Advanced type checking and analysis
3. **mypy** - Static type checking via nvim-lint
4. **Built-in LSP diagnostics** - Real-time error reporting

### Error Navigation Workflow
1. **Real-time feedback** - Errors appear as you type
2. **Visual indicators** - Signs in the gutter, virtual text inline
3. **Quick navigation** - `]d`/`[d` to jump between issues
4. **Batch viewing** - `<leader>xx` to see all diagnostics in Trouble
5. **Auto-fixing** - Many issues auto-fix on save

### Convenient Error Jumping
- `]d` - Next diagnostic (any severity)
- `[d` - Previous diagnostic
- `]e` - Next error (high severity only)
- `[e` - Previous error
- `<leader>xx` - Open Trouble diagnostics window
- `<leader>e` - Show diagnostic details in floating window

## 📦 Installation & First Run

1. **Backup existing config** (already done - files moved to `.bak`)
2. **Start Neovim** - Lazy.nvim will auto-install
3. **Install LSP servers**: `:Mason` then install:
   - pyright
   - ruff
   - mypy
   - lua_ls
4. **Install Python tools**: `pip install ruff mypy black`
5. **Install debugpy**: `pip install debugpy` (for debugging)

## 🔧 Customization

The configuration is modular and easy to customize:

- **Add/remove plugins** in `lua/plugins/*.lua`
- **Modify keybindings** in `lua/config/keymaps.lua`
- **Adjust options** in `lua/config/options.lua`
- **Configure LSP servers** in `lua/plugins/lsp.lua`

## 🐛 Troubleshooting

### Common Issues
1. **LSP not starting** - Run `:Mason` and ensure servers are installed
2. **Formatting not working** - Check that Ruff is installed: `pip install ruff`
3. **Copilot not working** - Run `:Copilot auth` to authenticate
4. **Treesitter errors** - Run `:TSUpdate` to update parsers

### Performance
- **Lazy loading** - Most plugins load only when needed
- **Native LSP** - Uses Neovim's built-in LSP for best performance
- **Optimized startup** - Disabled unnecessary default plugins

## 🆙 Migration from Old Config

Your old configuration has been preserved:
- `mappings.lua.bak` - Your original keybindings
- `options.lua.bak` - Your original options
- `plugins.lua.bak` - Your original plugin config
- `statusline.lua.bak` - Your original statusline

Key differences:
- **Plugin manager**: Packer → Lazy.nvim
- **File explorer**: Netrw → Oil.nvim
- **Completion**: nvim-cmp (enhanced with better sources)
- **Linting**: Your nvim-lint setup → Modern Ruff + Pyright + mypy
- **Formatting**: Neoformat → conform.nvim
- **Statusline**: Galaxyline → Lualine

This configuration maintains the productivity focus of your original setup while leveraging the latest Neovim developments for a more powerful and modern development experience.
