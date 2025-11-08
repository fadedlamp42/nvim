-- macdict.nvim - simple dictionary lookup using macOS Dictionary.app
local M = {}

local function get_word_under_cursor()
    local word = vim.fn.expand("<cword>")
    if word == "" then
        return nil
    end
    return word
end

local function format_definition(definition)
    -- add line breaks for better readability
    local formatted = definition

    -- split numbered definitions (1, 2, 3, etc.)
    formatted = formatted:gsub(" (%d) ", "\n\n%1 ")

    -- split bulleted items
    formatted = formatted:gsub(" • ", "\n  • ")

    -- add space before common sections
    formatted = formatted:gsub(" (DERIVATIVES)", "\n\n%1")
    formatted = formatted:gsub(" (ORIGIN)", "\n\n%1")
    formatted = formatted:gsub(" (PHRASES)", "\n\n%1")

    -- add space after pronunciation (before first pipe or definition)
    formatted = formatted:gsub("(%| [^|]+%|) (%a)", "%1\n\n%2")

    return formatted
end

local function show_definition(word, definition)
    -- create or reuse buffer
    if not M.buf or not vim.api.nvim_buf_is_valid(M.buf) then
        M.buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_set_option_value("buftype", "nofile", { buf = M.buf })
        vim.api.nvim_set_option_value("bufhidden", "hide", { buf = M.buf })
        vim.api.nvim_set_option_value("swapfile", false, { buf = M.buf })

        -- keybindings for the dictionary window
        vim.keymap.set("n", "q", ":quit<CR>", { silent = true, buffer = M.buf })
        vim.keymap.set("n", "<Esc>", ":quit<CR>", { silent = true, buffer = M.buf })
    end

    -- format and set buffer content
    local formatted = format_definition(definition)
    local lines = vim.split(formatted, "\n")
    vim.api.nvim_buf_set_lines(M.buf, 0, -1, true, lines)

    -- calculate window dimensions - 60% width, 95% height, right-floating, vertically centered
    local width = math.floor(vim.o.columns * 0.6)
    local height = math.floor(vim.o.lines * 0.95)
    local col = vim.o.columns - width
    local row = math.floor((vim.o.lines - height) / 2)

    -- open floating window
    local win_opts = {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        style = "minimal",
        border = "rounded",
        title = " " .. word .. " ",
        title_pos = "center",
    }

    M.win = vim.api.nvim_open_win(M.buf, true, win_opts)

    -- set window-local options after creating the window
    vim.api.nvim_set_option_value("wrap", true, { win = M.win })
    vim.api.nvim_set_option_value("linebreak", true, { win = M.win })

    vim.api.nvim_win_set_cursor(M.win, { 1, 0 })
end

function M.lookup(word)
    word = word or get_word_under_cursor()

    if not word then
        vim.notify("No word under cursor", vim.log.levels.WARN)
        return
    end

    -- run macdict command
    local handle = io.popen("macdict '" .. word .. "' 2>&1")
    if not handle then
        vim.notify("Failed to run macdict command", vim.log.levels.ERROR)
        return
    end

    local result = handle:read("*a")
    handle:close()

    if result == "" or result:match("not found") then
        vim.notify("No definition found for: " .. word, vim.log.levels.WARN)
        return
    end

    show_definition(word, result)
end

return M
