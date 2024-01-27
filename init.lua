local utils = require('utils')

require('config')

-- we don't use plugins as root
if not utils.is_root() then
  require('plugins')
end
