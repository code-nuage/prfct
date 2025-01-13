local core = {}

local base  = (...):gsub("%.[^%.]+$", "")

local function inherit(instance, t)
    for k, v in pairs(t) do
        instance[k] = v
    end
end

local Area = require(base .. ".area")
local Container = require(base .. ".container")
local Button = require(base .. ".button")
local Text = require(base .. ".text")

function core.new_item(item_type)
    assert(type(item_type) == "string", item_type .. "is not an item type in prfct.")
    local instance

    if item_type == "area" then
        instance = Area:new()
    elseif item_type == "container" then
        instance = Area:new()
        inherit(instance, Container)
    elseif item_type == "button" then
        instance = Area:new()
        inherit(instance, Container)
        inherit(instance, Button)
    elseif item_type == "text" then
        instance = Area:new()
        inherit(instance, Text)
        instance:init_heritage()
    end

    return instance
end

return core