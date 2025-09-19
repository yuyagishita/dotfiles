return {
  {
   	"neovim/nvim-lspconfig",
		event = "VimEnter",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function()
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
      	local hl = "DiagnosticSign" .. type
      	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      -- Common on_attach function
      local on_attach = function(client, bufnr)
        print('LSP attached to buffer ' .. bufnr)
        local function buf_set_keymap(...)
          vim.api.nvim_buf_set_keymap(bufnr, ...)
        end
        local function buf_set_option(...)
          vim.api.nvim_buf_set_option(bufnr, ...)
        end
        -- Enable completion triggered by <c-x><c-o>
        buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
        -- Mappings.
        local opts = { noremap = true, silent = true }
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
        buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
        buf_set_keymap("n", "?", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
        buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
        buf_set_keymap("n", "g?", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
        buf_set_keymap("n", "[lsp]wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
        buf_set_keymap("n", "[lsp]wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
        buf_set_keymap("n", "[lsp]wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
        buf_set_keymap("n", "[lsp]D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
        buf_set_keymap("n", "[lsp]a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
        buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
        buf_set_keymap("n", "[lsp]e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
        buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
        buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
        buf_set_keymap("n", "[lsp]q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
        buf_set_keymap("n", "[lsp]f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
      end

      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- List of servers to set up with default settings
      local servers = { "zls", "docker-language-server" }

      if os.getenv('WORK_ENV') ~= 'true' then
        table.insert(servers, "hls")
      end

      for _, server_name in ipairs(servers) do
        vim.lsp.config(server_name, {
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end

      -- Custom setups for specific servers
      vim.lsp.config("lua_ls", {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })

      -- clangd with clangd_extensions
      require("clangd_extensions").setup({
        server = {
          capabilities = capabilities,
          on_attach = on_attach,
        },
      })

      -- metals
      -- Suppress deprecation warning for metals setup
      local original_notify = vim.notify
      vim.notify = function(msg, level, opts)
        if type(msg) == "string" and msg:match("framework") and msg:match("deprecated") then
          return
        end
        original_notify(msg, level, opts)
      end

      lspconfig.metals.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { "metals" },
        -- cmd = { "/Users/yu.yagishita/Library/Application Support/Coursier/bin/metals" },
        filetypes = { "scala", "sbt" },
        root_dir = lspconfig.util.root_pattern("build.sbt", "build.sc", "build.gradle", ".git"),
      })

      -- Restore original vim.notify
      vim.notify = original_notify

		end,
  },
}
