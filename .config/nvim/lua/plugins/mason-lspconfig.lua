return {
  {
    "mason-org/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = {
      { "folke/neoconf.nvim" },
      { "weilbith/nvim-lsp-smag" },
    },
    config = function()
      local servers = {
        "lua_ls",
        "clangd",
        "zls",
        "dockerls",
      }

      if os.getenv('WORK_ENV') ~= 'true' then
        table.insert(servers, "hls")
      end

      -- 仕事用のMac以外ではCopilotのLSPを自動で有効にしない
      local automatic_enable = true
      if os.getenv('WORK_ENV') ~= 'true' then
        automatic_enable = { exclude = { "copilot" } }
      end

      require("mason-lspconfig").setup({
        ensure_installed = servers,
        automatic_enable = automatic_enable,
      })
    end,
  },
}
