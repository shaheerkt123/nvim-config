return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},

		config = function()
			local cmp = require("cmp")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Setup nvim-cmp (auto-completion enabled by default)
			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
			})

			-- Keymaps to run when LSP attaches to a buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("gd", vim.lsp.buf.definition, "Goto Definition")
					map("gr", vim.lsp.buf.references, "Goto References")
					map("K", vim.lsp.buf.hover, "Hover Documentation")
					map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
					map("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
					map("[d", function() vim.diagnostic.jump({ count = -1 }) end, "Previous Diagnostic")
					map("]d", function() vim.diagnostic.jump({ count = 1 }) end, "Next Diagnostic")
				end,
			})

			-- LSP Servers
			local servers = {
                lua_ls = {},
				gopls = {},
				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							cargo = { allTargets = true },
							check = { command = "clippy" },
						},
					},
				},
			}

			for server, config in pairs(servers) do
				config.capabilities = capabilities
				vim.lsp.config(server, config)
				vim.lsp.enable(server)
			end
		end,
	},
}


