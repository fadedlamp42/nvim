-- Modern Neovim v0.11.1 Configuration
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Set leader keys before loading plugins
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- Load configuration modules
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Setup lazy.nvim with aggressive optimizations
require("lazy").setup("plugins", {
  defaults = {
    lazy = true, -- Enable lazy loading by default for faster startup
    version = false, -- always use the latest git commit
  },
  install = { 
    colorscheme = { "fadedwolf", "habamax" },
    missing = false, -- don't install missing plugins on startup
  },
  checker = { 
    enabled = false, -- Disable automatic update checks (addresses requirement #1)
    -- Alternative: check only once per day
    -- enabled = true,
    -- frequency = 86400, -- 24 hours in seconds
  },
  change_detection = {
    enabled = false, -- Don't check for config changes on startup
  },
  performance = {
    cache = {
      enabled = true, -- Enable module caching
    },
    reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      reset = true, -- reset the runtime path to improve startup time
      -- disable some rtp plugins that aren't needed
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen", 
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
        "rplugin", -- Disable remote plugins
        "syntax", -- We'll handle syntax with treesitter
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      },
    },
  },
  ui = {
    backdrop = 100, -- backdrop opacity for lazy window
    throttle = 20, -- how frequently to redraw the ui
  },
  -- Reduce startup time by deferring plugin loading
  spec = {
    import = "plugins",
  },
})

-- Set colorscheme with fallback
local colorscheme = "fadedwolf"
local status_ok, _ = pcall(vim.cmd.colorscheme, colorscheme)
if not status_ok then
  vim.cmd.colorscheme("habamax")
end

-- Suppress deprecation warnings for cleaner startup
vim.deprecate = function() end

-- Additional startup optimizations
vim.loader.enable() -- Enable Lua module loader cache (Neovim 0.9+)

-- Defer non-critical settings
vim.defer_fn(function()
  -- Any non-critical configuration can go here
  -- This runs after UI is ready
end, 0)
