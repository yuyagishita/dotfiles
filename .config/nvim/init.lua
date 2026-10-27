require('config.base')
require('config.options')
require('config.display')
require('config.keymaps')
require("config.lazy").load({
  profiling = {
    loader = false,
    require = false,
  },
})
