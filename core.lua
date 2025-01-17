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
local Image = require(base .. ".image")

function core.new_item(item_type)
    assert(type(item_type) == "string", item_type .. "is not an item type in prfct.")
    local instance

    if item_type == "area" then
        instance = Area:new()
    elseif item_type == "container" then
        instance = Area:new()
        inherit(instance, Container)
        inherit(instance, Button)
        instance:init_heritage()
    elseif item_type == "button" then
        instance = Area:new()
        inherit(instance, Button)
        inherit(instance, Container)
        instance:init_heritage()
    elseif item_type == "text" then
        instance = Area:new()
        inherit(instance, Text)
        instance:init_heritage()
    elseif item_type == "image" then
        instance = Area:new()
        inherit(instance, Image)
        inherit(instance, Container)
        instance:init_heritage()
    else
        error(item_type .. "is not an item type in prfct.")
    end

    return instance
end

function core.hex_to_rgb(hex)
    assert(#hex == 3 or #hex == 6 or #hex == 8, "Hexadecimal color must be 3, 6 or 8 characters long.")
    
    if #hex == 3 then
        local r = tonumber(hex:sub(1, 1) .. hex:sub(1, 1), 16) / 255
        local g = tonumber(hex:sub(2, 2) .. hex:sub(2, 2), 16) / 255
        local b = tonumber(hex:sub(3, 3) .. hex:sub(3, 3), 16) / 255
        return r, g, b
    elseif #hex == 6 then
        local r = tonumber(hex:sub(1, 2), 16) / 255
        local g = tonumber(hex:sub(3, 4), 16) / 255
        local b = tonumber(hex:sub(5, 6), 16) / 255
        return r, g, b
    elseif #hex == 8 then
        local r = tonumber(hex:sub(1, 2), 16) / 255
        local g = tonumber(hex:sub(3, 4), 16) / 255
        local b = tonumber(hex:sub(5, 6), 16) / 255
        local a = tonumber(hex:sub(7, 8), 16) / 255
        return r, g, b, a
    end
end

return core