require("obsidian").setup({
  workspaces = {
    {
      name = "obsidian",
      path = "~/ghq/github.com/yuyagishita/obsidian",
    },
  },
  
  daily_notes = {
    -- Optional, if you keep daily notes in a separate directory.
    folder = "daily-notes",
    -- Optional, if you want to change the date format for the ID of daily notes.
    date_format = "%Y-%m-%d",
    -- Optional, if you want to change the date format of the default alias of daily notes.
    -- alias_format = "%B %-d, %Y",
    -- Optional, default tags to add to each new daily note created.
    -- default_tags = { "daily-notes" },
    -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
    template = "Daily Notes.md"
  },

  templates = {
    folder = "templates",
  },
  
  ui = {
    enable = false
  },

  completion = {
    -- Set to false to disable completion.
    nvim_cmp = true,
    -- Trigger completion at 2 chars.
    min_chars = 2,
  },
  -- see below for full list of options 👇
})

