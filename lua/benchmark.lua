-- Neovim startup benchmark utilities
-- Usage: :lua require('benchmark').startup_info()
--        :lua require('benchmark').lazy_stats()

local M = {}

-- Display startup information
function M.startup_info()
  local stats = vim.loader.enabled and vim.loader.stats() or {}
  local startup_time = vim.fn.reltime(vim.g.start_time or vim.fn.reltime())
  local startup_ms = vim.fn.reltimestr(startup_time) * 1000
  
  print("🚀 Neovim Startup Information")
  print("==============================")
  print(string.format("Startup time: %.2fms", startup_ms))
  
  if vim.loader.enabled then
    print(string.format("Lua modules cached: %d", stats.find.cache or 0))
    print(string.format("Lua modules loaded: %d", stats.find.total or 0))
  else
    print("Lua loader cache: disabled")
  end
  
  -- Memory usage
  local mem_kb = vim.fn.luaeval("collectgarbage('count')")
  print(string.format("Lua memory usage: %.2f KB", mem_kb))
  
  -- Plugin count
  if pcall(require, "lazy") then
    local lazy = require("lazy")
    local plugins = lazy.plugins()
    local loaded_count = 0
    local total_count = 0
    
    for _, plugin in pairs(plugins) do
      total_count = total_count + 1
      if plugin.loaded then
        loaded_count = loaded_count + 1
      end
    end
    
    print(string.format("Plugins loaded: %d/%d", loaded_count, total_count))
  end
end

-- Display lazy.nvim statistics
function M.lazy_stats()
  if not pcall(require, "lazy") then
    print("❌ lazy.nvim not available")
    return
  end
  
  local lazy = require("lazy")
  local plugins = lazy.plugins()
  local stats = {
    total = 0,
    loaded = 0,
    startup = 0,
    lazy_loaded = 0,
    failed = 0,
  }
  
  print("🔌 Lazy.nvim Plugin Statistics")
  print("===============================")
  
  for _, plugin in pairs(plugins) do
    stats.total = stats.total + 1
    
    if plugin.loaded then
      stats.loaded = stats.loaded + 1
    end
    
    if not plugin.lazy then
      stats.startup = stats.startup + 1
      print(string.format("  📦 %s (startup)", plugin.name))
    else
      stats.lazy_loaded = stats.lazy_loaded + 1
    end
    
    if plugin._.loaded == false then
      stats.failed = stats.failed + 1
    end
  end
  
  print("")
  print("Summary:")
  print(string.format("  Total plugins:      %d", stats.total))
  print(string.format("  Currently loaded:   %d", stats.loaded))
  print(string.format("  Startup plugins:    %d", stats.startup))
  print(string.format("  Lazy plugins:       %d", stats.lazy_loaded))
  print(string.format("  Lazy loading ratio: %.1f%%", stats.lazy_loaded / stats.total * 100))
  
  if stats.startup > 5 then
    print("")
    print("⚠️  Consider making more plugins lazy-loaded for faster startup")
  elseif stats.startup <= 2 then
    print("")
    print("✅ Excellent lazy loading configuration!")
  end
end

-- Benchmark function loading times
function M.benchmark_functions()
  print("🔬 Function Loading Benchmark")
  print("=============================")
  
  local functions_to_test = {
    { name = "require('lazy')", func = function() require('lazy') end },
    { name = "require('telescope')", func = function() pcall(require, 'telescope') end },
    { name = "require('nvim-treesitter')", func = function() pcall(require, 'nvim-treesitter') end },
    { name = "vim.cmd.colorscheme", func = function() vim.cmd.colorscheme() end },
  }
  
  for _, test in ipairs(functions_to_test) do
    local start_time = vim.loop.hrtime()
    test.func()
    local end_time = vim.loop.hrtime()
    local duration_ms = (end_time - start_time) / 1000000
    
    print(string.format("  %-25s %.2fms", test.name, duration_ms))
  end
end

-- Create user commands
vim.api.nvim_create_user_command('StartupInfo', function()
  M.startup_info()
end, { desc = 'Show startup information' })

vim.api.nvim_create_user_command('LazyStats', function()
  M.lazy_stats()
end, { desc = 'Show lazy.nvim statistics' })

vim.api.nvim_create_user_command('BenchmarkFunctions', function()
  M.benchmark_functions()
end, { desc = 'Benchmark function loading times' })

return M
