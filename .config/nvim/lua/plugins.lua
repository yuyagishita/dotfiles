local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
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
		requires = { 
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		event = "VimEnter",
		config = function()
			require("pluginconfig/neo-tree")
		end,
	})


  if packer_bootstrap then
    require('packer').sync()
  end
end)
