return {
  {
    "mason-org/mason.nvim",
    event = { "VeryLazy" },
    config = function()
      require("mason").setup()
    end,
  },
}
