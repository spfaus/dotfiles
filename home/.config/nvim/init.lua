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
        { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = {} },
    },
    install = { colorscheme = { "gruvbox" } },
    checker = { enabled = false },
})

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
vim.opt.scrolloff = 999
vim.opt.sidescrolloff = 999

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

-- Yank, paste, clipboard
vim.opt.clipboard = 'unnamedplus'
vim.keymap.set('n', '<Leader>p', '"0p', { noremap = true })
vim.keymap.set('n', '<Leader>P', '"0P', { noremap = true })
vim.keymap.set('x', '<Leader>p', '"0p', { noremap = true })
vim.keymap.set('x', '<Leader>P', '"0P', { noremap = true })
vim.keymap.set('n', '<Leader>gp', '"0gp', { noremap = true })
vim.keymap.set('n', '<Leader>gP', '"0gP', { noremap = true })
