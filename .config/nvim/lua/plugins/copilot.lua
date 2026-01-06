return {
  {
    "zbirenbaum/copilot.lua",
    enabled = false,
    cmd = "Copilot",
    event = "InsertEnter",
    cond = function()
      -- return vim.env.ENABLE_COPILOT == "1"
      return vim.env.WORK_ENV == "true"
    end,
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    enabled = false,
    event = { "InsertEnter", "LspAttach" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
