local base = (...):gsub("%.[^%.]+$", "")

local prfct = {}

prfct.core = require(base .. ".prfct.core")

return prfct