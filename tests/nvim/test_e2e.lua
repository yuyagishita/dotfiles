-- End-to-end tests for the installed Neovim config (~/.config/nvim).
-- They run on both Arch Linux and macOS.
local new_set = MiniTest.new_set
local eq = MiniTest.expect.equality

local READY_TIMEOUT = 30000
local LSP_TIMEOUT = 20000
local config_dir = vim.fn.stdpath("config")
local data_dir = vim.fn.stdpath("data")

local child = MiniTest.new_child_neovim()
local work_dir

local function wait_until(predicate, timeout)
  return vim.wait(timeout or 5000, predicate, 50) == true
end

local function require_tool(tool)
  if vim.fn.executable(tool) == 0 and vim.fn.executable(data_dir .. "/mason/bin/" .. tool) == 0 then
    MiniTest.skip(tool .. " is not installed")
  end
end

local function write_file(name, content)
  local path = work_dir .. "/" .. name
  vim.fn.writefile(vim.split(content or "first", "\n"), path)
  return path
end

-- Runs the config in a child process with no terminal attached.
local function start_child()
  child.start({
    "--cmd", "set lines=40 columns=200",
    "--cmd", "set runtimepath^=" .. config_dir,
    "-u", config_dir .. "/init.lua",
  })
  local ready = wait_until(function()
    return child.lua_get("package.loaded['mason-lspconfig'] ~= nil")
  end, READY_TIMEOUT)
  assert(ready, "nvim did not finish starting")
  -- Keep test files out of the user's oldfiles.
  child.o.shadafile = "NONE"
  child.cmd("cd " .. work_dir)
end

-- Runs the config the way a person does: in a real pseudo terminal.
local function start_terminal(args)
  local socket = work_dir .. "/nvim.sock"
  local job = vim.fn.jobstart(vim.list_extend({ vim.v.progpath, "--listen", socket }, args or {}), {
    pty = true,
    width = 200,
    height = 40,
    cwd = work_dir,
    on_stdout = function() end,
  })
  assert(wait_until(function()
    return vim.uv.fs_stat(socket) ~= nil
  end, READY_TIMEOUT), "nvim did not open its socket")
  local rpc = vim.fn.sockconnect("pipe", socket, { rpc = true })
  local terminal = {
    type = function(keys)
      vim.fn.chansend(job, keys)
    end,
    eval = function(expr)
      return vim.fn.rpcrequest(rpc, "nvim_eval", expr)
    end,
    lua = function(code)
      return vim.fn.rpcrequest(rpc, "nvim_exec_lua", "return " .. code, {})
    end,
  }
  MiniTest.finally(function()
    pcall(terminal.lua, "vim.cmd('set shadafile=NONE')")
    pcall(vim.fn.chanclose, rpc)
    vim.fn.chansend(job, "\27:qa!\r")
    if vim.fn.jobwait({ job }, 5000)[1] == -1 then
      vim.fn.jobstop(job)
    end
  end)
  assert(wait_until(function()
    return terminal.lua("package.loaded['mason-lspconfig'] ~= nil")
  end, READY_TIMEOUT), "nvim did not finish starting")
  terminal.lua("vim.cmd('set shadafile=NONE')")
  return terminal
end

local function lsp_client_names()
  return "vim.tbl_map(function(c) return c.name end, vim.lsp.get_clients({ bufnr = 0 }))"
end

local T = new_set({
  hooks = {
    pre_case = function()
      vim.env.WORK_ENV = nil
      -- Not under /tmp: the config excludes it from backups by design.
      work_dir = vim.fn.stdpath("cache") .. "/nvim-e2e-" .. vim.fn.rand()
      vim.fn.mkdir(work_dir, "p")
    end,
    post_case = function()
      child.stop()
      local undo_name = (work_dir:gsub("/", "%%"))
      for _, path in ipairs(vim.fn.glob(data_dir .. "/undo/*", true, true)) do
        if vim.fs.basename(path):find(undo_name, 1, true) then
          vim.fn.delete(path)
        end
      end
      vim.fn.delete(work_dir, "rf")
    end,
  },
})

T["startup"] = new_set()

T["startup"]["has no errors"] = function()
  start_child()
  local messages = child.cmd_capture("messages")
  eq(messages:match("E%d+:.*"), nil)
  eq(messages:find("stack traceback", 1, true), nil)
end

T["startup"]["has no deprecated calls"] = function()
  start_child()
  child.cmd("checkhealth vim.deprecated")
  local report = table.concat(child.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
  eq(report:find("No deprecated functions detected", 1, true) ~= nil, true)
end

T["editing"] = new_set()

T["editing"]["saves typed text in a terminal"] = function()
  local path = write_file("typed.txt")
  local terminal = start_terminal({ "typed.txt" })
  terminal.type("ohello\27:write\r")
  eq(wait_until(function()
    return vim.fn.readfile(path)[2] == "hello"
  end), true)
end

T["editing"]["gcc toggles a comment in a terminal"] = new_set({
  parametrize = { { "toggle.lua", "local a = 1", "-- local a = 1" }, { "toggle.py", "x = 1", "# x = 1" } },
})
T["editing"]["gcc toggles a comment in a terminal"]["works"] = function(name, plain, commented)
  write_file(name, plain)
  local terminal = start_terminal({ name })
  local function first_line_is(expected)
    return wait_until(function()
      return terminal.eval("getline(1)") == expected
    end)
  end
  wait_until(function()
    return terminal.eval("maparg('gcc', 'n')") ~= ""
  end)
  terminal.type("gcc")
  eq(first_line_is(commented), true)
  terminal.type("gcc")
  eq(first_line_is(plain), true)
end

T["backups"] = new_set()

local function save_edit(name)
  child.cmd("edit " .. name)
  child.type_keys("onew<Esc>")
  child.cmd("write")
end

T["backups"]["keeps a backup and undo for a plain file"] = function()
  local name = "plain-" .. vim.fn.rand() .. ".txt"
  write_file(name)
  start_child()
  local backup = child.o.backupdir .. name .. "~"
  MiniTest.finally(function()
    vim.fn.delete(backup)
  end)
  save_edit(name)
  eq(vim.uv.fs_stat(backup) ~= nil, true)
  eq(child.bo.undofile, true)
end

T["backups"]["skips sensitive files"] = new_set({
  parametrize = {
    { ".env" }, { ".env.local" }, { "app.env" }, { "my_private" },
    { "server.pem" }, { "api_token.txt" }, { "hosts.yml" },
  },
})
T["backups"]["skips sensitive files"]["works"] = function(name)
  write_file(name)
  start_child()
  local backup = child.o.backupdir .. name .. "~"
  local before = vim.uv.fs_stat(backup)
  save_edit(name)
  local after = vim.uv.fs_stat(backup)
  eq(after and after.mtime.sec, before and before.mtime.sec)
  eq(child.bo.undofile, false)
end

T["backups"]["keeps backup and undo directories private"] = function()
  start_child()
  eq(vim.fn.getfperm(child.o.backupdir), "rwx------")
  eq(vim.fn.getfperm(child.o.undodir), "rwx------")
end

T["lsp"] = new_set()

local function wait_for_lua_ls(terminal)
  eq(wait_until(function()
    return vim.tbl_contains(terminal.lua(lsp_client_names()), "lua_ls")
  end, LSP_TIMEOUT), true)
end

local function has_on_attach_key(terminal)
  return wait_until(function()
    return terminal.eval("maparg('[d', 'n')"):find("vim.diagnostic.jump", 1, true) ~= nil
  end, 8000)
end

T["lsp"]["enables metals and dockerls"] = function()
  start_child()
  eq(child.lua_get("vim.lsp.is_enabled('metals')"), true)
  require_tool("docker-langserver")
  eq(child.lua_get("vim.lsp.is_enabled('dockerls')"), true)
end

T["lsp"]["sets on_attach keys for a file opened after startup"] = function()
  require_tool("lua-language-server")
  write_file("after.lua", "local a = 1")
  local terminal = start_terminal()
  terminal.type("\27:edit after.lua\r")
  wait_for_lua_ls(terminal)
  eq(has_on_attach_key(terminal), true)
end

-- Known bug: `nvim file.lua` attaches lua_ls without running on_attach.
-- This test fails once the bug is fixed. Change it to expect true then.
T["lsp"]["known bug: misses on_attach keys for a file opened from the command line"] = function()
  require_tool("lua-language-server")
  write_file("cli.lua", "local a = 1")
  local terminal = start_terminal({ "cli.lua" })
  wait_for_lua_ls(terminal)
  eq(has_on_attach_key(terminal), false)
end

T["copilot"] = new_set()

T["copilot"]["stays off outside work"] = function()
  write_file("app.env")
  start_child()
  child.cmd("edit app.env")
  eq(child.lua_get("vim.lsp.is_enabled('copilot')"), false)
  vim.wait(2000)
  eq(vim.tbl_contains(child.lua_get(lsp_client_names()), "copilot"), false)
end

T["copilot"]["stays on at work"] = function()
  require_tool("copilot-language-server")
  vim.env.WORK_ENV = "true"
  start_child()
  eq(child.lua_get("vim.lsp.is_enabled('copilot')"), true)
end

return T
