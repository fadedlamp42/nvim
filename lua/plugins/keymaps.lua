-- Keymap extraction utility
-- Create a comprehensive mapping printout
return {
  -- Enhanced which-key with mapping export
  {
    "folke/which-key.nvim",
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
      {
        "<leader><leader>?",
        "<cmd>WhichKey<cr>",
        desc = "All Keymaps (which-key)",
      },
      {
        "<leader>km",
        function()
          -- Create a comprehensive keymap export
          local function export_keymaps()
            local keymaps = {}
            
            -- Get all key mappings
            for _, mode in ipairs({ "n", "i", "v", "x", "s", "o", "t", "c" }) do
              local maps = vim.api.nvim_get_keymap(mode)
              for _, map in ipairs(maps) do
                table.insert(keymaps, {
                  mode = mode,
                  lhs = map.lhs,
                  rhs = map.rhs or map.callback and "<function>" or "",
                  desc = map.desc or "",
                  buffer = false,
                })
              end
              
              -- Get buffer-local mappings
              local buf_maps = vim.api.nvim_buf_get_keymap(0, mode)
              for _, map in ipairs(buf_maps) do
                table.insert(keymaps, {
                  mode = mode,
                  lhs = map.lhs,
                  rhs = map.rhs or map.callback and "<function>" or "",
                  desc = map.desc or "",
                  buffer = true,
                })
              end
            end
            
            -- Sort by mode then by key
            table.sort(keymaps, function(a, b)
              if a.mode ~= b.mode then
                return a.mode < b.mode
              end
              return a.lhs < b.lhs
            end)
            
            -- Create output
            local lines = {
              "# Neovim Keymap Reference",
              "Generated: " .. os.date("%Y-%m-%d %H:%M:%S"),
              "",
              "## Mode Legend",
              "- `n` = Normal mode",
              "- `i` = Insert mode", 
              "- `v` = Visual mode",
              "- `x` = Visual block mode",
              "- `s` = Select mode",
              "- `o` = Operator-pending mode",
              "- `t` = Terminal mode",
              "- `c` = Command-line mode",
              "",
            }
            
            local current_mode = ""
            for _, map in ipairs(keymaps) do
              if map.mode ~= current_mode then
                current_mode = map.mode
                table.insert(lines, "## " .. string.upper(current_mode) .. " Mode")
                table.insert(lines, "")
              end
              
              local buffer_indicator = map.buffer and " [buf]" or ""
              local desc = map.desc ~= "" and " - " .. map.desc or ""
              local rhs = map.rhs ~= "" and " → `" .. map.rhs .. "`" or ""
              
              table.insert(lines, string.format("`%s`%s%s%s", 
                map.lhs, buffer_indicator, rhs, desc))
            end
            
            -- Write to temporary file
            local tmp_file = vim.fn.tempname() .. "_keymaps.md"
            vim.fn.writefile(lines, tmp_file)
            
            -- Open in new buffer
            vim.cmd("vnew " .. tmp_file)
            vim.bo.filetype = "markdown"
            vim.bo.buftype = "nofile"
            vim.bo.bufhidden = "wipe"
            
            vim.notify("Keymap reference exported! Use :w to save to a permanent location.")
          end
          
          export_keymaps()
        end,
        desc = "Export All Keymaps to Markdown",
      },
      {
        "<leader>kp",
        function()
          -- Print current buffer keymaps to quickfix
          local function print_buffer_keymaps()
            local qf_list = {}
            
            for _, mode in ipairs({ "n", "i", "v", "x" }) do
              local maps = vim.api.nvim_buf_get_keymap(0, mode)
              for _, map in ipairs(maps) do
                local desc = map.desc or ""
                local rhs = map.rhs or (map.callback and "<function>") or ""
                table.insert(qf_list, {
                  text = string.format("[%s] %s → %s %s", mode, map.lhs, rhs, desc),
                  type = "I",
                })
              end
            end
            
            vim.fn.setqflist(qf_list, "r")
            vim.cmd("copen")
            vim.notify("Buffer keymaps loaded in quickfix list")
          end
          
          print_buffer_keymaps()
        end,
        desc = "Print Buffer Keymaps to Quickfix",
      },
      {
        "<leader>kl",
        function()
          -- List all LSP keymaps for current buffer
          local clients = vim.lsp.get_clients({ bufnr = 0 })
          if #clients == 0 then
            vim.notify("No LSP clients attached to current buffer")
            return
          end
          
          local lsp_keymaps = {
            "# LSP Keymaps for Current Buffer",
            "",
            "## Attached LSP Clients:",
          }
          
          for _, client in ipairs(clients) do
            table.insert(lsp_keymaps, "- " .. client.name)
          end
          
          table.insert(lsp_keymaps, "")
          table.insert(lsp_keymaps, "## LSP Keymaps:")
          
          local lsp_maps = {
            { "gD", "vim.lsp.buf.declaration()", "Go to declaration" },
            { "gd", "vim.lsp.buf.definition()", "Go to definition" },
            { "K", "vim.lsp.buf.hover()", "Hover documentation" },
            { "gi", "vim.lsp.buf.implementation()", "Go to implementation" },
            { "<C-k>", "vim.lsp.buf.signature_help()", "Signature help" },
            { "<leader>wa", "vim.lsp.buf.add_workspace_folder()", "Add workspace folder" },
            { "<leader>wr", "vim.lsp.buf.remove_workspace_folder()", "Remove workspace folder" },
            { "<leader>wl", "vim.lsp.buf.list_workspace_folders()", "List workspace folders" },
            { "<leader>D", "vim.lsp.buf.type_definition()", "Type definition" },
            { "<leader>rn", "vim.lsp.buf.rename()", "Rename symbol" },
            { "<leader>ca", "vim.lsp.buf.code_action()", "Code action" },
            { "gr", "vim.lsp.buf.references()", "Go to references" },
            { "<leader>f", "vim.lsp.buf.format()", "Format buffer" },
            { "[d", "vim.diagnostic.goto_prev()", "Previous diagnostic" },
            { "]d", "vim.diagnostic.goto_next()", "Next diagnostic" },
            { "<leader>e", "vim.diagnostic.open_float()", "Show line diagnostics" },
            { "<leader>q", "vim.diagnostic.setloclist()", "Set loclist" },
          }
          
          for _, map in ipairs(lsp_maps) do
            table.insert(lsp_keymaps, string.format("- `%s` → %s - %s", map[1], map[2], map[3]))
          end
          
          -- Create new buffer with LSP keymaps
          local buf = vim.api.nvim_create_buf(false, true)
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, lsp_keymaps)
          vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
          vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
          vim.cmd("vsplit")
          vim.api.nvim_win_set_buf(0, buf)
        end,
        desc = "List LSP Keymaps",
      },
    },
  },
  
  -- Telescope keymap search
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Search Keymaps" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Search Help" },
      { "<leader>sc", "<cmd>Telescope commands<cr>", desc = "Search Commands" },
    },
  },
}
