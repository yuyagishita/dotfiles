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
	use({
		"EdenEast/nightfox.nvim",
		config = function()
			vim.cmd("colorscheme nordfox")
		end,
	})


	--------------------------------
	-- Filer
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		-- requires = { 
		-- 	"nvim-lua/plenary.nvim",
		-- 	"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
		-- 	"MunifTanjim/nui.nvim",
		-- },
		event = "VimEnter",
		config = function()
			require("pluginconfig/neo-tree")
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


  if packer_bootstrap then
    require('packer').sync()
  end
end)
