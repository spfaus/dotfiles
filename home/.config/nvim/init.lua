vim.cmd [[colorscheme slate]]
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.colorcolumn = '80'
vim.opt.wrap = false
vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg = 238, bg = LightGrey })

local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
	pattern = "rust",
	callback = function()
		local root_dir = vim.fs.dirname(vim.fs.find({ 'Cargo.toml' }, { upward = true })[1])
		local client = vim.lsp.start({
			name = 'rust-analyzer',
			cmd = { 'rust-analyzer' },
			root_dir = root_dir,
		})
		vim.lsp.buf_attach_client(0, client)
	end
})

autocmd("FileType", {
	pattern = "lua",
	callback = function()
		local root_dir = vim.fs.dirname(vim.fs.find({ 'init.lua', 'init.vim', '.git' }, { upward = true })[1])
		local client = vim.lsp.start({
			name = 'lua-language-server',
			cmd = { 'lua-language-server' },
			root_dir = root_dir,
			settings = { Lua = { diagnostics = { globals = { 'vim', 'LightGrey' } } } },
		})
		vim.lsp.buf_attach_client(0, client)
	end
})

autocmd('LspAttach', {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client.server_capabilities.hoverProvider then
			vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
		end
	end,
})

autocmd("BufWritePre", {
	command = "lua vim.lsp.buf.format()"
})
