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
    },
    install = { colorscheme = { "gruvbox" } },
    checker = { enabled = true },
})

-- Keybindings
vim.keymap.set('n', '<Leader>y', '"+y')
vim.keymap.set('n', '<Leader>Y', '"+Y')
vim.keymap.set('n', '<Leader>p', '"+p')
vim.keymap.set('n', '<Leader>P', '"+P')
vim.keymap.set('v', '<Leader>y', '"+y')
vim.keymap.set('v', '<Leader>Y', '"+Y')
vim.keymap.set('v', '<Leader>p', '"+p')
vim.keymap.set('v', '<Leader>P', '"+P')

-- Visuals
vim.cmd('colorscheme gruvbox')
vim.opt.background = "dark"
vim.opt.cursorline = true
--vim.opt.cursorcolumn = true
vim.opt.colorcolumn = "100"

-- Functionality
--vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg=233, bg="#222222" })
vim.cmd('filetype plugin on')

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.wrap = false
vim.opt.breakindent = true

vim.opt.scrolloff = 8

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.undofile = true

vim.opt.mouse = 'a'

vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 250
--vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.inccommand = 'split'
