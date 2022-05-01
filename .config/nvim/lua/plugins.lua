local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)

	-- ------------------------------------------------------------
	-- Library

	--------------------------------
	-- Lua Library
	use({ "nvim-lua/plenary.nvim" })
	use({ "tami5/sqlite.lua", module = "sqlite" })
	use({ "MunifTanjim/nui.nvim" })

	--------------------------------
	-- Font
	use({ "kyazdani42/nvim-web-devicons" })

	--------------------------------
	-- Notify
	use({ "rcarriga/nvim-notify", event = "VimEnter" })

	--------------------------------
	-- ColorScheme
	local colorscheme = "nightfox.nvim"
	use({
		"EdenEast/nightfox.nvim",
		config = function()
			vim.cmd("colorscheme nordfox")
		end,
	})

	--------------------------------------------------------------
	-- LSP & completion

	--------------------------------
	-- Auto Completion
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			{ "L3MON4D3/LuaSnip", opt = true, event = "VimEnter" },
			{ "windwp/nvim-autopairs", opt = true, event = "VimEnter" },
		},
		after = { "lspkind-nvim", "LuaSnip", "nvim-autopairs" },
		config = function()
			require("pluginconfig/nvim-cmp")
		end,
	})
	use({
		"onsails/lspkind-nvim",
		event = "VimEnter",
		config = function()
			require("pluginconfig/lspkind-nvim")
		end,
	})
	use({ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lsp-document-symbol", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-path", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-omni", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-emoji", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-calc", after = "nvim-cmp" })
	use({ "f3fora/cmp-spell", after = "nvim-cmp" })
	use({ "yutkat/cmp-mocword", after = "nvim-cmp" })
	use({ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" })
	use({
		"tzachar/cmp-tabnine",
		run = "./install.sh",
		after = "nvim-cmp",
	})
	use({ "ray-x/cmp-treesitter", after = "nvim-cmp" })

	--------------------------------
	-- Language Server Protocol(LSP)
	use({
		"neovim/nvim-lspconfig",
		after = { "cmp-nvim-lsp" },
		config = function()
			require("pluginconfig/nvim-lspconfig")
		end,
	})
	use({
		"williamboman/nvim-lsp-installer",
		requires = { { "RRethy/vim-illuminate", opt = true } },
		after = { "nvim-lspconfig", "vim-illuminate", "nlsp-settings.nvim", "rust-tools.nvim" },
		config = function()
			require("pluginconfig/nvim-lsp-installer")
		end,
	})
	use({
		"tamago324/nlsp-settings.nvim",
		after = { "nvim-lspconfig" },
		config = function()
			require("pluginconfig/nlsp-settings")
		end,
	})
	use({ "weilbith/nvim-lsp-smag", after = "nvim-lspconfig" })

	--------------------------------
	-- LSP's UI
	use({
		"tami5/lspsaga.nvim",
		after = "nvim-lsp-installer",
		config = function()
			require("pluginconfig/lspsaga")
		end,
	})
	use({
		"folke/lsp-colors.nvim",
		event = "VimEnter",
	})
	use({
		"folke/trouble.nvim",
		after = { "nvim-lsp-installer", "lsp-colors.nvim" },
		config = function()
			require("pluginconfig/trouble")
		end,
	})
	use({
		"EthanJWright/toolwindow.nvim",
		requires = { { "akinsho/toggleterm.nvim", opt = true, event = "VimEnter" } },
		after = { "trouble.nvim", "toggleterm.nvim" },
		config = function()
			require("pluginconfig/toolwindow")
		end,
	})
	use({
		"j-hui/fidget.nvim",
		after = "nvim-lsp-installer",
		config = function()
			require("pluginconfig/fidget")
		end,
	})

	--------------------------------------------------------------
	-- FuzzyFinders

	--------------------------------
	-- telescope.nvim
	use({
		"nvim-telescope/telescope.nvim",
		-- requires = { { "nvim-lua/plenary.nvim", opt = true } },
		event = "VimEnter",
		config = function()
			require("pluginconfig/telescope")
		end,
	})
	use({
		"nvim-telescope/telescope-frecency.nvim",
		after = { "telescope.nvim" },
		config = function()
			require("telescope").load_extension("frecency")
		end,
	})
	use({
		"nvim-telescope/telescope-packer.nvim",
		after = { "telescope.nvim" },
		config = function()
			require("telescope").load_extension("packer")
		end,
	})

	--------------------------------
	-- Manual
	use({
		"folke/which-key.nvim",
		event = "VimEnter",
		config = function()
			require("pluginconfig/which-key")
		end,
	})

	--------------------------------
	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		event = "VimEnter",
		run = ":TSUpdate",
		config = function()
			require("pluginconfig/nvim-treesitter")
		end,
	})

	--------------------------------
	-- Treesitter UI customize
	use({
		"romgrk/nvim-treesitter-context",
		cmd = { "TSContextEnable" },
	})

	--------------------------------------------------------------
	-- Appearance

	--------------------------------
	-- Statusline
	use({
		"nvim-lualine/lualine.nvim",
		after = colorscheme,
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("pluginconfig/lualine")
		end,
	})

	--------------------------------
	-- Bufferline
	use({
		'akinsho/bufferline.nvim',
		tag = "*",
		requires = 'kyazdani42/nvim-web-devicons'
	})

	----------------------------------------------------------------
	---- Syntax

	--------------------------------
	-- Highlight
	use({
		"RRethy/vim-illuminate",
		event = "VimEnter",
		config = function()
			require("pluginconfig/vim-illuminate")
		end,
	})

	--------------------------------
	-- Filer
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		event = "VimEnter",
		config = function()
			require("pluginconfig/neo-tree")
		end,
	})

	--------------------------------
	-- Help

	--------------------------------
	-- Commandline
	use({ "hrsh7th/cmp-cmdline", after = "nvim-cmp" })

	--------------------------------------------------------------
	-- Coding

	--------------------------------
	-- Brackets
	use({
		"andymass/vim-matchup",
		after = { "nvim-treesitter" },
	})
	use({
		"windwp/nvim-autopairs",
		event = "VimEnter",
	})

	--------------------------------
	-- Snippet
	use({
		"L3MON4D3/LuaSnip",
		after = { "friendly-snippets" },
	})

	--------------------------------
	-- Snippet Pack
	use({ "rafamadriz/friendly-snippets", event = "VimEnter" })

	--------------------------------
	-- Comment out
	use({
		"numToStr/Comment.nvim",
		event = "VimEnter",
		config = function()
			-- require("pluginconfig/Comment")
			require("Comment").setup()
		end,
	})

	--------------------------------------------------------------
	-- Programming Languages

	--------------------------------
	-- Rust
	use({
		"simrat39/rust-tools.nvim",
		after = { "nvim-lspconfig" },
	})

  if packer_bootstrap then
    require('packer').sync()
  end
end)
