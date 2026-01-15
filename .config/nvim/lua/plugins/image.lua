return {
  -- image.nvim
  {
    "3rd/image.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "markdown" }, -- Markdownファイルでのみロード
    config = function()
      require("image").setup({
        backend = "kitty", -- wezterm用
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = true, -- カーソル位置のみ
          },
        },
        max_width = 100,
        max_height = 12,
        max_width_window_percentage = nil,
        max_height_window_percentage = 50,
        window_overlap_clear_enabled = true,
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      })
    end,
  },
}
