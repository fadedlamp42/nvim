-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/hdd/home/regular/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/hdd/home/regular/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/hdd/home/regular/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/hdd/home/regular/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/hdd/home/regular/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  colorizer = {
    loaded = true,
    path = "/hdd/home/regular/.local/share/nvim/site/pack/packer/start/colorizer"
  },
  ["galaxyline.nvim"] = {
    config = { "\27LJ\2\n*\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\15statusline\frequire\0" },
    loaded = true,
    path = "/hdd/home/regular/.local/share/nvim/site/pack/packer/start/galaxyline.nvim"
  },
  ["indent-blankline.nvim"] = {
    loaded = true,
    path = "/hdd/home/regular/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim"
  },
  ["limelight.vim"] = {
    loaded = true,
    path = "/hdd/home/regular/.local/share/nvim/site/pack/packer/start/limelight.vim"
  },
  nerdcommenter = {
    loaded = true,
    path = "/hdd/home/regular/.local/share/nvim/site/pack/packer/start/nerdcommenter"
  },
  ["nvim-bufferline.lua"] = {
    loaded = true,
    path = "/hdd/home/regular/.local/share/nvim/site/pack/packer/start/nvim-bufferline.lua"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/hdd/home/regular/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/hdd/home/regular/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspinstall"] = {
    loaded = true,
    path = "/hdd/home/regular/.local/share/nvim/site/pack/packer/start/nvim-lspinstall"
  },
  ["nvim-nonicons"] = {
    loaded = true,
    path = "/hdd/home/regular/.local/share/nvim/site/pack/packer/start/nvim-nonicons"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/hdd/home/regular/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/hdd/home/regular/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  snap = {
    loaded = true,
    path = "/hdd/home/regular/.local/share/nvim/site/pack/packer/start/snap"
  },
  ["vim-easy-align"] = {
    loaded = true,
    path = "/hdd/home/regular/.local/share/nvim/site/pack/packer/start/vim-easy-align"
  },
  ["vim-fubitive"] = {
    loaded = true,
    path = "/hdd/home/regular/.local/share/nvim/site/pack/packer/start/vim-fubitive"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/hdd/home/regular/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-gitgutter"] = {
    loaded = true,
    path = "/hdd/home/regular/.local/share/nvim/site/pack/packer/start/vim-gitgutter"
  },
  ["vim-go"] = {
    loaded = true,
    path = "/hdd/home/regular/.local/share/nvim/site/pack/packer/start/vim-go"
  },
  ["vim-highlightedyank"] = {
    loaded = true,
    path = "/hdd/home/regular/.local/share/nvim/site/pack/packer/start/vim-highlightedyank"
  },
  ["vim-illuminate"] = {
    loaded = true,
    path = "/hdd/home/regular/.local/share/nvim/site/pack/packer/start/vim-illuminate"
  },
  ["vim-jsx-pretty"] = {
    loaded = true,
    path = "/hdd/home/regular/.local/share/nvim/site/pack/packer/start/vim-jsx-pretty"
  },
  ["vim-polyglot"] = {
    loaded = true,
    path = "/hdd/home/regular/.local/share/nvim/site/pack/packer/start/vim-polyglot"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/hdd/home/regular/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-smoothie"] = {
    loaded = true,
    path = "/hdd/home/regular/.local/share/nvim/site/pack/packer/start/vim-smoothie"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/hdd/home/regular/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\n�\5\0\0\5\0#\0'6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\3=\3\t\0025\3\n\0=\3\v\0024\3\0\0=\3\f\0025\3\r\0=\3\14\0025\3\15\0005\4\16\0=\4\17\0035\4\18\0=\4\19\3=\3\20\0025\3\22\0005\4\21\0=\4\23\0035\4\24\0=\4\25\3=\3\26\0025\3\27\0=\3\28\0025\3\30\0005\4\29\0=\4\31\0035\4 \0=\4!\3=\3\"\2B\0\2\1K\0\1\0\23triggers_blacklist\6v\1\3\0\0\6j\6k\6i\1\0\0\1\3\0\0\6j\6k\vhidden\1\t\0\0\r<silent>\n<cmd>\n<Cmd>\t<CR>\tcall\blua\a^:\a^ \vlayout\nwidth\1\0\2\bmax\0032\bmin\3\20\vheight\1\0\2\fspacing\3\3\nalign\tleft\1\0\2\bmax\3\25\bmin\3\4\vwindow\fpadding\1\5\0\0\3\2\3\2\3\2\3\2\vmargin\1\5\0\0\3\1\3\0\3\1\3\0\1\0\2\vborder\vdouble\rposition\vbottom\nicons\1\0\3\ngroup\6+\14separator\b➜\15breadcrumb\a»\15key_labels\14operators\1\0\1\agc\rComments\fplugins\1\0\3\19ignore_missing\1\rtriggers\tauto\14show_help\2\fpresets\1\0\a\fmotions\2\14operators\2\6g\2\6z\2\bnav\2\fwindows\2\17text_objects\2\rspelling\1\0\2\fenabled\1\16suggestions\0032\1\0\2\14registers\2\nmarks\2\nsetup\14which-key\frequire\0" },
    loaded = true,
    path = "/hdd/home/regular/.local/share/nvim/site/pack/packer/start/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\2\n�\5\0\0\5\0#\0'6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\3=\3\t\0025\3\n\0=\3\v\0024\3\0\0=\3\f\0025\3\r\0=\3\14\0025\3\15\0005\4\16\0=\4\17\0035\4\18\0=\4\19\3=\3\20\0025\3\22\0005\4\21\0=\4\23\0035\4\24\0=\4\25\3=\3\26\0025\3\27\0=\3\28\0025\3\30\0005\4\29\0=\4\31\0035\4 \0=\4!\3=\3\"\2B\0\2\1K\0\1\0\23triggers_blacklist\6v\1\3\0\0\6j\6k\6i\1\0\0\1\3\0\0\6j\6k\vhidden\1\t\0\0\r<silent>\n<cmd>\n<Cmd>\t<CR>\tcall\blua\a^:\a^ \vlayout\nwidth\1\0\2\bmax\0032\bmin\3\20\vheight\1\0\2\fspacing\3\3\nalign\tleft\1\0\2\bmax\3\25\bmin\3\4\vwindow\fpadding\1\5\0\0\3\2\3\2\3\2\3\2\vmargin\1\5\0\0\3\1\3\0\3\1\3\0\1\0\2\vborder\vdouble\rposition\vbottom\nicons\1\0\3\ngroup\6+\14separator\b➜\15breadcrumb\a»\15key_labels\14operators\1\0\1\agc\rComments\fplugins\1\0\3\19ignore_missing\1\rtriggers\tauto\14show_help\2\fpresets\1\0\a\fmotions\2\14operators\2\6g\2\6z\2\bnav\2\fwindows\2\17text_objects\2\rspelling\1\0\2\fenabled\1\16suggestions\0032\1\0\2\14registers\2\nmarks\2\nsetup\14which-key\frequire\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
-- Config for: galaxyline.nvim
time([[Config for galaxyline.nvim]], true)
try_loadstring("\27LJ\2\n*\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\15statusline\frequire\0", "config", "galaxyline.nvim")
time([[Config for galaxyline.nvim]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
