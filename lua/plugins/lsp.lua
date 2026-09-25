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

			-- Diagnostic Configuration (end-of-line text, icons, and popups)
			vim.diagnostic.config({
				virtual_text = {
					prefix = "■", -- Square indicator at end of line
					spacing = 4,
					source = "if_many",
				},
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚 ",
						[vim.diagnostic.severity.WARN]  = "󰀪 ",
						[vim.diagnostic.severity.HINT]  = "󰌶 ",
						[vim.diagnostic.severity.INFO]  = "󰋽 ",
					},
				},
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = {
					focusable = false,
					close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
					border = "rounded",
					source = true,
					header = "",
					prefix = " ",
				},
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
					map("<leader>e", vim.diagnostic.open_float, "Show Diagnostic Popup")
					map("[d", function() vim.diagnostic.jump({ count = -1 }) end, "Previous Diagnostic")
					map("]d", function() vim.diagnostic.jump({ count = 1 }) end, "Next Diagnostic")
				end,
			})

			-- LSP Servers
			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							runtime = {
								version = "LuaJIT",
							},
							diagnostics = {
								globals = { "vim" },
							},
							workspace = {
								checkThirdParty = false,
								library = {
									vim.env.VIMRUNTIME,
								},
							},
							telemetry = {
								enable = false,
							},
						},
					},
				},
				gopls = {},
				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							cargo = { allTargets = true },
							check = { command = "clippy" },
						},
					},
				},
                clangd = {
                    cmd = {
                        "clangd",
                        "--background-index",
                        "--clang-tidy",
                        "--header-insertion=iwyu",
                        "--completion-style=detailed",
                        "--function-arg-placeholders",
                        "--fallback-style=llvm",
                    },
                    init_options = {
                        usePlaceholders = true,
                        completeUnimported = true,
                        clangdFileStatus = true,
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


