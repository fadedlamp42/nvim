# My neovim configuration

A general purpose nvim configuration geared towards programming. 

## Setup

Clone into `$HOME/.config`, relies on `python3-pynvim` and `node`.

## Mappings

### Base vim

- Leader key: `,`
- Exit normal mode: `jk`
- Split window and browse for file: `<leader>f`
- Browse for file in current window: `<leader>F`
- Split window horizontally: `<leader>s`
- Split window vertically: `<leader>S`
- Create new tab and browse for file: `<leader>t`
- Create new tab with current buffer: `<leader>T`
- Cycle tabs: `<leader>q` and `<leader>w`
- Cycle windows: `<c-j>` and `<c-k>`
- Cycle buffers: `<leader>J` and `<leader>K`
- Close buffer (forcefully): `<leader>W`
- Edit init.vim: `<leader>V`
- Edit coc-settings.json: `<leader>C`
- Cycle completions: `<tab>` and `<c-tab>`
- Resize window: `<c-h>` and `<c-l>` for width, `<c-y>` and `<c-i>` for height

### Plugins

- Toggle focused mode: `<leader>g`
- Toggle spotlight: `<leader>l`
- Go to definition: `gD`
- Go to type definition: `gt`
- Go to implementation: `gi`
- Go to references: `gr`
- Show documentation: `gd`
- Rename: `<leader>r`
- Align text: `ga`
- Open tag bar: `<leader><return>`
- Insert emoji: `<c-x><c-e>`
- Trigger emmet: `<c-e>,

# Lua Porting Resources
[the switch to init.lua](https://oroques.dev/notes/neovim-init/)
[switching from init.vim to init.lua](https://icyphox.sh/blog/nvim-lua/)
[official lsp instructions](https://github.com/neovim/nvim-lspconfig)
[compe repo](https://github.com/hrsh7th/nvim-compe)
[NvChad init.lua example](https://github.com/siduck76/NvChad/blob/main/init.lua)
[current init.vim](https://github.com/fadedlamp42/nvim/blob/master/init.vim)
