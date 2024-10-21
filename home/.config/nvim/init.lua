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

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set('n', '<Leader>y', '"+y')
vim.keymap.set('n', '<Leader>p', '"+p')

vim.cmd('colorscheme habamax')
vim.cmd('filetype plugin on')
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.undofile = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.colorcolumn = "80"
vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg=233, bg="#222222" })

-- TODO: Complete first useful PHP LSP or other integration
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'php',
    callback = function(ev)
        vim.lsp.start({
            name = 'phpactor',
            cmd = {'phpactor', 'language-server'},
            root_dir = vim.fs.root(ev.buf, {'.env', '.env.local.php', '.env.local', '.env.test'}),
        })
    end,
})

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
      { 'echasnovski/mini.pairs', version = '*', opts = {} },
  },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})
