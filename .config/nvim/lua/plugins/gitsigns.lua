return {
  {
    "lewis6991/gitsigns.nvim",
    event = "VimEnter",
    config = function()
      require("gitsigns").setup({
        on_attach = function(bufnr)
          local gitsigns = require("gitsigns")

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              vim.cmd.normal({ "]c", bang = true })
            else
              gitsigns.nav_hunk("next")
            end
          end, { desc = "Next Hunk" })

          map("n", "[c", function()
            if vim.wo.diff then
              vim.cmd.normal({ "[c", bang = true })
            else
              gitsigns.nav_hunk("prev")
            end
          end, { desc = "Prev Hunk" })

          -- Actions
          map("n", "[git]hs", gitsigns.stage_hunk, { desc = "Stage Hunk" })
          map("n", "[git]hr", gitsigns.reset_hunk, { desc = "Reset Hunk" })

          map("v", "[git]hs", function()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Stage Hunk" })

          map("v", "[git]hr", function()
            gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Reset Hunk" })

          map("n", "[git]hS", gitsigns.stage_buffer, { desc = "Stage Buffer" })
          map("n", "[git]hR", gitsigns.reset_buffer, { desc = "Reset Buffer" })
          map("n", "[git]hp", gitsigns.preview_hunk, { desc = "Preview Hunk" })
          map("n", "[git]hi", gitsigns.preview_hunk_inline, { desc = "Preview Hunk Inline" })

          map("n", "[git]hb", function()
            gitsigns.blame_line({ full = true })
          end, { desc = "Blame Line" })

          map("n", "[git]hd", gitsigns.diffthis, { desc = "Diff This" })

          map("n", "[git]hD", function()
            gitsigns.diffthis("~")
          end, { desc = "Diff This ~" })

          map("n", "[git]hQ", function() gitsigns.setqflist("all") end, { desc = "Set All QF List" })
          map("n", "[git]hq", gitsigns.setqflist, { desc = "Set QF List" })

          -- Toggles
          map("n", "[git]tb", gitsigns.toggle_current_line_blame, { desc = "Toggle Current Line Blame" })
          map("n", "[git]tw", gitsigns.toggle_word_diff, { desc = "Toggle Word Diff" })

          -- Text object
          map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Select Hunk" })
        end,
      })
    end,
  },
}
