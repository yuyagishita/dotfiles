return {
  {
    "github/copilot.vim",
    cond = function()
      return vim.env.ENABLE_COPILOT == "1"
    end,
    config = function()
      require("copilot").setup({})
    end,
  }
}
