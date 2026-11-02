-- Entry point for the test runner. See "Testing" in README.md.
local commit = "a9e23fd2033ada30a53a32d1c73629351c2750f3" -- mini.test v0.9.0
local path = vim.fn.stdpath("data") .. "/e2e/mini.test"

if not vim.uv.fs_stat(path) then
  vim.fn.mkdir(vim.fs.dirname(path), "p")
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/nvim-mini/mini.test.git", path })
  vim.fn.system({ "git", "-C", path, "checkout", "--quiet", commit })
  assert(vim.trim(vim.fn.system({ "git", "-C", path, "rev-parse", "HEAD" })) == commit, "failed to install mini.test")
end
vim.opt.runtimepath:prepend(path)

local tests_dir = vim.fs.dirname(debug.getinfo(1, "S").source:sub(2))
require("mini.test").setup({
  collect = {
    find_files = function()
      return vim.fn.globpath(tests_dir, "test_*.lua", true, true)
    end,
  },
})
