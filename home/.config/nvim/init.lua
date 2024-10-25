-- TODOS
-- php integration / lsp

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

-- Make sure to setup `mapleader` and `maplocalleader`
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        { "echasnovski/mini.pairs", version = '*', opts = {} },
        { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = {} },
        { "nvim-treesitter/nvim-treesitter", version = '*', opts = {}, build = ":TSUpdate" },
    },
    install = { colorscheme = { "gruvbox" } },
    checker = { enabled = false },
})

require'nvim-treesitter.configs'.setup {
    ensure_installed = {},
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        -- disable slow treesitter highlight for large files
        disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,

        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true
    }
}

-- Keybindings
vim.keymap.set('n', '<Leader>y', '"+y')
vim.keymap.set('n', '<Leader>Y', '"+Y')
vim.keymap.set('n', '<Leader>p', '"+p')
vim.keymap.set('n', '<Leader>P', '"+P')
vim.keymap.set('v', '<Leader>y', '"+y')
vim.keymap.set('v', '<Leader>Y', '"+Y')
vim.keymap.set('v', '<Leader>p', '"+p')
vim.keymap.set('v', '<Leader>P', '"+P')

vim.cmd('filetype plugin on')

-- Colors
vim.cmd('colorscheme gruvbox')
vim.opt.background = "dark"
vim.opt.cursorline = true
vim.opt.colorcolumn = "80"

-- Signcolumn
vim.opt.signcolumn = 'yes'
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation, whitespace, wrapping
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.wrap = false
vim.opt.breakindent = true

-- Buffer navigation, scrolling
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wildignorecase = true

-- History
vim.opt.undofile = true

-- Mouse
vim.opt.mouse = 'a'

-- Timings
vim.opt.updatetime = 250
--vim.opt.timeoutlen = 300

-- Splits and windows
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = 'split'
