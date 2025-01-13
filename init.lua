local base = (...):gsub("%.[^%.]+$", "")

local prfct = {}

prfct.core = require(base .. ".core")

return prfct