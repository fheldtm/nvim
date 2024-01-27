local utils = require('utils')

require('config')
require('plugins')

-- we don't use plugins as root
if not utils.is_root() then
  require("lazy")
end
