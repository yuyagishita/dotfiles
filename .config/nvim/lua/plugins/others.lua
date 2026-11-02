return {
  --------------------------------------------------------------
	-- Library

	--------------------------------
	-- Lua Library
	{ "nvim-lua/plenary.nvim" },
	{ "kkharji/sqlite.lua" },
	{ "MunifTanjim/nui.nvim" },

	--------------------------------
	-- Font
	{ "nvim-tree/nvim-web-devicons" },

	--------------------------------
	-- Notify
	{ "rcarriga/nvim-notify", event = "VimEnter" },

	--------------------------------
	-- ColorScheme
	{
		"EdenEast/nightfox.nvim",
	},

	--------------------------------
	-- Show my display-key
  {
    "NStefan002/screenkey.nvim",
    lazy = false,
    version = "*", -- or branch = "main", to use the latest commit
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
  -- {
  --   "iamcco/markdown-preview.nvim",
  --   ft = { "markdown" }, 
  --   run = ":call mkdp#util#install()"
  -- },

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
  { "folke/lazydev.nvim", ft = "lua", opts = {} },

 	--------------------------------------------------------------
	-- Markup Languages
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    opts = {},
  },
}
