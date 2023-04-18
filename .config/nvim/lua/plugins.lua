local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)

  -- ------------------------------------------------------------
	-- Installer

	-- Plugin Manager
	use({ "wbthomason/packer.nvim", opt = true })

	-- External package Installer
	use({
		"williamboman/mason.nvim",
		event = "VimEnter",
		config = function()
			require("pluginconfig/mason")
		end,
	})

	-- ------------------------------------------------------------
	-- Library

	--------------------------------
	-- Lua Library
	use({ "nvim-lua/popup.nvim" })
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
	-- LSP & completion & DAP

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
		"williamboman/mason-lspconfig.nvim",
		after = { "mason.nvim", "nvim-lspconfig", "cmp-nvim-lsp", "nlsp-settings.nvim" },
		config = function()
			require("pluginconfig/mason-lspconfig")
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
		after = "mason.nvim",
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
		after = { "mason.nvim", "lsp-colors.nvim" },
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
		after = "mason.nvim",
		config = function()
			require("pluginconfig/fidget")
		end,
	})

	--------------------------------
	-- Debug Adapter Protocol(DAP)
  use({"mfussenegger/nvim-dap"})

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
  use({
    "nvim-telescope/telescope-ui-select.nvim",
		after = { "telescope.nvim" },
		config = function()
			require("telescope").load_extension("ui-select")
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
    after = { colorscheme },
		-- event = "VimEnter",
		run = ":TSUpdate",
		config = function()
			require("pluginconfig/nvim-treesitter")
		end,
	})
	use({ "JoosepAlviste/nvim-ts-context-commentstring", after = { "nvim-treesitter" } })

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
  use({
		"SmiteshP/nvim-navic",
		module = "nvim-navic",
		setup = function()
			require("pluginconfig/nvim-navic")
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
	-- Reading assistant
  use({
		"lukas-reineke/indent-blankline.nvim",
		event = "VimEnter",
		config = function()
			require("pluginconfig/indent-blankline")
		end,
	})

	--------------------------------
	-- Brackets
	use({
		"andymass/vim-matchup",
		after = { "nvim-treesitter" },
	})
	use({
		"windwp/nvim-autopairs",
		event = "VimEnter",
		config = function()
			require("pluginconfig/nvim-autopairs")
		end;
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
			require("pluginconfig/Comment")
			-- require("Comment").setup()
		end,
	})

  --------------------------------
  -- Git
  use({ 
    "TimUntersberger/neogit",
    event = "VimEnter",
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require("pluginconfig/neogit")
    end,
    })

	--------------------------------------------------------------
	-- Programming Languages

	--------------------------------
	-- C++
  use({
    "p00f/clangd_extensions.nvim"
  })

	--------------------------------
	-- Rust
	use({
		"simrat39/rust-tools.nvim",
		after = { "nvim-lspconfig" },
	})

	--------------------------------
	-- Markdown
  use({ "iamcco/markdown-preview.nvim", ft = { "markdown" }, run = ":call mkdp#util#install()" })

  --------------------------------
  -- Carbon
  use({ "carbon-language/vim-carbon-lang" })

  --------------------------------
  -- Haskell
  use({
    'mrcjkb/haskell-tools.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim', -- optional
    },
    branch = '1.x.x', -- recommended
  })

  --------------------------------
	-- Neovim Lua development
  use({ "folke/lua-dev.nvim", module = "lua-dev" })

  if packer_bootstrap then
    require('packer').sync()
  end

end)
