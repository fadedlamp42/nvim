#!/bin/bash

# Install npm packages globally
npm install -g bash-language-server
npm install -g vscode-langservers-extracted
npm install -g dockerfile-language-server-nodejs
npm install -g pyright
npm install -g @tailwindcss/language-server
npm install -g typescript typescript-language-server
npm install -g vim-language-server
npm install -g yaml-language-server
npm install -g @johnnymorganz/stylua-bin prettier
npm install -g mcp-hub@latest

# Install Go packages
go install golang.org/x/tools/gopls@latest

# Install Ruby gems
gem install solargraph

# System packages and other tools need manual installation:
echo "Please install these manually:"
echo "- ccls: sudo apt install ccls"
echo "- csharp-ls: dotnet tool install --global csharp-ls"
echo "- terraform-ls: follow https://github.com/hashicorp/terraform-ls"
echo "- kotlin-language-server: follow https://www.andersevenrud.net/neovim.github.io/lsp/configurations/kotlin_language_server/"
