return {
  {
    "williamboman/mason-lspconfig.nvim",
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

      require("mason-lspconfig").setup({
        ensure_installed = servers
      })
    end,
  },
}
