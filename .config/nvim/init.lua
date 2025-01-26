-- packer
-- require('base')
-- require('options')
-- require('display')
-- require('packer-plugins')
-- require('mappings')

-- lazy
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
