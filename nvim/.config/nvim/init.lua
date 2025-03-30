if tonumber(vim.fn.expand('$UID')) >= 1000 then
    require("config.lazy")
else
    print('Consider `sudoedit`.')
end

require("config.general")
require("config.mappings")

