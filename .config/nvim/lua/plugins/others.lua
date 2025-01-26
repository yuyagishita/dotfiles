return {
--------------------------------------------------------------
	-- Library

	--------------------------------
	-- Lua Library
	{ "nvim-lua/popup.nvim" },
	{ "nvim-lua/plenary.nvim" },
	{ "tami5/sqlite.lua", module = "sqlite" },
	{ "MunifTanjim/nui.nvim" },

	--------------------------------
	-- Font
	{ "kyazdani42/nvim-web-devicons" },

	--------------------------------
	-- Notify
	{ "rcarriga/nvim-notify", event = "VimEnter" },

	--------------------------------
	-- ColorScheme
	local colorscheme = "nightfox.nvim"
	{
		"EdenEast/nightfox.nvim",
		config = function()
			vim.cmd("colorscheme nordfox")
		end,
	},

	------------------------------------------------------------
	-- Standard Feature Enhancement
  --
	--------------------------------
	-- Commandline
  {
		"hrsh7th/cmp-cmdline",
		event = "VimEnter"
	},
	{
		"dmitmel/cmp-cmdline-history",
		event = "VimEnter"
	},

	--------------------------------------------------------------
	-- Coding
	--------------------------------
	-- Snippet
	{
		"L3MON4D3/LuaSnip",
	},

	--------------------------------
	-- Snippet Pack
	{ 
    "rafamadriz/friendly-snippets", 
    event = "VimEnter" 
  },

  --------------------------------
  -- Git
  {
		"akinsho/git-conflict.nvim",
		config = function()
		  require('git-conflict').setup()
		end,
  },
 	--------------------------------------------------------------
	-- Programming Languages

	--------------------------------
	-- C++
  {
    "p00f/clangd_extensions.nvim"
  },

	--------------------------------
	-- Rust
	{
		"mrcjkb/rustaceanvim",
	},

	--------------------------------
	-- Markdown
  { 
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" }, 
    run = ":call mkdp#util#install()"
  },

  --------------------------------
  -- Carbon
  { "carbon-language/vim-carbon-lang" },

  --------------------------------
  -- Haskell
  {
    'mrcjkb/haskell-tools.nvim',
		dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim', -- optional
    },
    branch = '1.x.x', -- recommended
  },

  --------------------------------
	-- Neovim Lua development
  use({ "folke/lua-dev.nvim", module = "lua-dev" })
}
