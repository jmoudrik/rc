-- JM: open terminal here
vim.keymap.set('n', '<leader>th', function() io.popen("th") end)

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require("nvim-tree").setup {
	renderer = {
		highlight_opened_files = "all",
		highlight_git = true
	},
	update_focused_file = {
		enable = false,
		update_root = true,
		ignore_list = {},
	},
	git = {
		ignore = false
	}
}
vim.cmd [[ highlight NvimTreeOpenedFile gui=underline ]]
vim.keymap.set('n', '<leader>tf', function()
	vim.cmd [[ NvimTreeFindFile ]]
end, {})


-- hlslens
-- vyhledavani - matches
require('hlslens').setup()
local kopts = { noremap = true, silent = true }

vim.api.nvim_set_keymap('n', 'n',
	[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
	kopts)
vim.api.nvim_set_keymap('n', 'N',
	[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
	kopts)
vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

vim.api.nvim_set_keymap('n', '<Leader>l', '<Cmd>noh<CR>', kopts)

--

require("nvim-autopairs").setup {}

require('gitsigns').setup()
require("scrollbar").setup()
require("scrollbar.handlers.gitsigns").setup()
require("scrollbar.handlers.search").setup({})

require('lualine').setup({
	sections = {
		lualine_c = {
			{ 'filename', path = 1, }
		}
	}
})

require('tabby').setup()


--require('diffview').setup()
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗"
		}
	}
})
require("mason-lspconfig").setup()


local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.autopep8,
		null_ls.builtins.formatting.eslint,
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.code_actions.eslint,
		--null_ls.builtins.completion.spell,
	},
})

local util = require 'lspconfig.util'
require("eslint").setup({
	bin = 'eslint',
	code_actions = {
		enable = true,
		apply_on_save = {
			enable = true,
			types = { "directive", "problem", "suggestion", "layout" },
		},
		disable_rule_comment = {
			enable = true,
			location = "separate_line", -- or `same_line`
		},
	},
	diagnostics = {
		enable = true,
		report_unused_disable_directives = false,
		run_on = "type", -- or `save`
	},
	-- Copied from nvim-lspconfig/lua/lspconfig/server_conigurations/eslint.js
	root_dir = util.root_pattern
	--		JM nejak sem posral syntax
	--		'.eslintrc',
	--		'.eslintrc.js',
	--		'.eslintrc.cjs',
	--		'.eslintrc.yaml',
	--		'.eslintrc.yml',
	--		'.eslintrc.json'
	--	-- Disabled to prevent "No ESLint configuration found" exceptions
	--	-- 'package.json',
	--	)
})



-- Set up nvim-cmp.
local cmp = require 'cmp'

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	window = {
		--completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		-- JM to jsem mel predtim; idea-like tab completion
		--		["<Tab>"] = cmp.mapping(function(fallback)
		--			-- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
		--			if cmp.visible() then
		--				local entry = cmp.get_selected_entry()
		--				if not entry then
		--					cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
		--				else
		--					cmp.confirm()
		--				end
		--			else
		--				fallback()
		--			end
		--		end, { "i", "s", "c", }),
			["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif vim.fn["vsnip#available"](1) == 1 then
				feedkey("<Plug>(vsnip-expand-or-jump)", "")
			elseif has_words_before() then
				cmp.complete()
			else
				fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
			end
		end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
			elseif vim.fn["vsnip#jumpable"](-1) == 1 then
				feedkey("<Plug>(vsnip-jump-prev)", "")
			end
		end, { "i", "s" }),
		--['<C-b>'] = cmp.mapping.scroll_docs(-4),
		--['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-Space>'] = cmp.mapping.complete(),
			['<C-e>'] = cmp.mapping.abort(),
		-- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			['<CR>'] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' }, -- For vsnip users.
		-- { name = 'luasnip' }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
	}, {
		{ name = 'buffer' },
	})
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = { { name = 'buffer' } }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})

require("telescope").load_extension("live_grep_args")
local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, {})
--vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, {})
vim.keymap.set('n', '<leader>rg', require('telescope').extensions.live_grep_args.live_grep_args, {})
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, {})

-- Common LSP On Attach function
local on_attach = function(_, bufnr)
	local opts = { buffer = bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
	--vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
	vim.keymap.set('n', 'gd', telescope_builtin.lsp_definitions, opts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
	--vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
	vim.keymap.set('n', 'gi', telescope_builtin.lsp_implementations, opts)
	vim.keymap.set('n', '<leader>sh', vim.lsp.buf.signature_help, opts)
	vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
	vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
	vim.keymap.set('n', '<leader>wl', function() vim.inspect(vim.lsp.buf.list_workspace_folders()) end, opts)
	vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
	--vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
	vim.keymap.set('n', 'gr', telescope_builtin.lsp_references, opts)
	vim.keymap.set('n', '<M-Enter>', vim.lsp.buf.code_action, opts)
	vim.keymap.set('n', '<leader>so', telescope_builtin.lsp_document_symbols, opts)
	vim.keymap.set('n', '<C-M-l>', function() vim.lsp.buf.format { async = true } end, opts)
end

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig').tsserver.setup { on_attach = on_attach, capabilities = capabilities }
require('lspconfig').pylsp.setup { on_attach = on_attach, capabilities = capabilities }
require('lspconfig').html.setup { on_attach = on_attach, capabilities = capabilities }
require('lspconfig').cssls.setup { on_attach = on_attach, capabilities = capabilities }
require('lspconfig').jsonls.setup { on_attach = on_attach, capabilities = capabilities }
require('lspconfig').marksman.setup { on_attach = on_attach, capabilities = capabilities }
require('lspconfig').bashls.setup { on_attach = on_attach, capabilities = capabilities }
require('lspconfig').awk_ls.setup { on_attach = on_attach, capabilities = capabilities }
require('lspconfig').svelte.setup { on_attach = on_attach, capabilities = capabilities }
require('lspconfig').lua_ls.setup { on_attach = on_attach, capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
		},
	},
}

require("trouble").setup {
	mode = "document_diagnostics"
}

-- JM: show diag in floating wins
-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.o.updatetime = 250
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
vim.api.nvim_set_keymap("n", "<F3>", "<cmd>TroubleToggle<cr>",
	{ silent = true, noremap = true, }
)

vim.api.nvim_create_autocmd("CursorHold", {
  buffer = bufnr,
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = 'rounded',
      source = 'always',
      prefix = ' ',
      scope = 'cursor',
    }
    vim.diagnostic.open_float(nil, opts)
  end
})

-- JM toggling
require('toggle_lsp_diagnostics').init({vim.diagnostic.config()})
vim.api.nvim_set_keymap("n", "<F4>", "<Plug>(toggle-lsp-diag-vtext)",
	{ silent = true, noremap = true, }
)


require("nightfox").setup {}

-- JM s novym jazykem je potreba
-- nainstalovat parser, pomoci :TSInstall bash
-- tohle vypise currently installled langs
-- : checkhealth nvim-treesitter
-- seznam podporovanych je tady
-- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
--
require 'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true,
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = true,
	},
	rainbow = {
		enable = true,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	}
}

require('nvim-ts-autotag').setup()

--require('hlargs').setup()

require("nvim-surround").setup()

-- nahovno
--require("twilight").setup { dimming = { alpha = 0.75 } }

-- ted jsem to zakomentil protoze to stejne ukazuje statusline & Trouble
-- a navic to prekryva W / E v levem sloupecku
--require('nvim-lightbulb').setup({autocmd = {enabled = true}})
