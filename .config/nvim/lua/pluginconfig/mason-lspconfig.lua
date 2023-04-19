require("mason-lspconfig").setup()

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
-- selene: allow(unused_variable)
---@diagnostic disable-next-line: unused-local
local on_attach = function(client, bufnr)
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
	-- buf_set_keymap("n", "[lsp]rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "[lsp]a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "[lsp]e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "[lsp]q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	buf_set_keymap("n", "[lsp]f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

	-- require("lsp_signature").on_attach()
	-- require("illuminate").on_attach(client)
	-- require("nvim-navic").attach(client, bufnr)
end

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- setup_handlers内にいれても正常に動作しないので、手動実行
-- setup_handlersを使うとhls以外「0 client(s) attached to this buffer」になるケースがほとんど
require("clangd_extensions").setup({ server = { capabilities = capabilities, on_attach = on_attach } })
require("rust-tools").setup({ server = { capabilities = capabilities, on_attach = on_attach } })
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
 		  diagnostics = {
 			  globals = { "vim" },
 		  },
 	  },
  },
})

require("mason-lspconfig").setup_handlers({
	function(server_name)
		lspconfig[server_name].setup({ capabilities = capabilities, on_attach = on_attach })
	end,
  -- ["clangd"] = function()
  --   local has_clangd_extensions, clangd_extensions = pcall(require, "clangd_extensions")
  --   if has_clangd_extensions then
  --     capabilities.offsetEncoding = { "utf-16" }
  --     clangd_extensions.setup({ server = { capabilities = capabilities, on_attach = on_attach } })
  --   else
  --     lspconfig.clangd.setup({ capabilities = capabilities, on_attach = on_attach })
  --   end
  -- end,
  -- haskellだけsetup_handlers内に入れても動く。
  ["hls"] = function()
    local has_haskell_tools, haskell_tools = pcall(require, "haskell-tools")
    if has_haskell_tools then
      haskell_tools.setup({ server = { capabilities = capabilities, on_attach = on_attach } })
    else
      lspconfig.hls.setup({ { capabilities = capabilities, on_attach = on_attach } })
    end
  end,
	-- ["rust_analyzer"] = function()
	-- 	local has_rust_tools, rust_tools = pcall(require, "rust-tools")
	-- 	if has_rust_tools then
	-- 		rust_tools.setup({ server = { capabilities = capabilities, on_attach = on_attach } })
	-- 	else
	-- 		lspconfig.rust_analyzer.setup({ capabilities = capabilities, on_attach = on_attach })
	-- 	end
	-- end,
	-- ["lua_ls"] = function()
 --    lspconfig.lua_ls.setup({
 --      capabilities = capabilities,
 --      on_attach = on_attach,
	-- 	  settings = {
 --        Lua = {
	-- 	 		  diagnostics = {
	-- 	 			  globals = { "vim" },
	-- 	 		  },
	-- 	 	  },
	-- 	  },
 --    })
	-- end,
})
