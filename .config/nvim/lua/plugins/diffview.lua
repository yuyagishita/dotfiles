return {
	{
		"sindrets/diffview.nvim",
		event = "VeryLazy",
		config = function()
      vim.api.nvim_set_keymap("n", "[git]d", "<Cmd>DiffviewOpen<CR>", { noremap = true, silent = true })
		end,
  },
}
