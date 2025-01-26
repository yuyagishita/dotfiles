local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

local M = {}

---@param opts LazyConfig
function M.load(opts)
  opts = vim.tbl_deep_extend("force", {
    spec = {
      { import = "plugins" },
    },
    defaults = { lazy = true },
    dev = {
      patterns = { "yuyagishita" },
      fallback = jit.os:find("Windows") or jit.os:find("OSX"),
    },
    install = { colorscheme = { "tokyonight", "habamax" } },
    checker = {
      enabled = true,
      notify = false,
    },
    diff = {
      cmd = "terminal_git",
    },
    rocks = { hererocks = true },
    performance = {
      cache = {
        enabled = true,
        -- disable_events = {},
      },
      rtp = {
        disabled_plugins = {
          "gzip",
          -- "matchit",
          -- "matchparen",
          -- "netrwPlugin",
          "rplugin",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      },
    },
    debug = false,
  }, opts or {})
  require("lazy").setup(opts)
end

return M
