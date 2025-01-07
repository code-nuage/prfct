local core = {}

local base  = (...):gsub("%.[^%.]+$", "")
local button = require(base .. ".button")
local text = require(base .. ".text")

local function multiple_inheritance(...)
    local args = {...}
    local mt = {}
    function mt.__index(t, k)
        for _, arg in ipairs(args) do
            if arg[k] then
                return arg[k]
            end
        end
    end
    return mt
end

local View = {}
View.__index = View

local Item = {}
Item.__index = Item

--[[
    ITEM'S GLOBAL METHODS
]]
function Item:set_position(x, y)
    self.x, self.y = x, y
    return self
end

function Item:set_dimensions(w, h)
    self.w, self.h = w, h
    return self
end

function Item:get_position()
    return self.x, self.y
end

function Item:get_dimensions()
    return self.w, self.h
end

function core.new_view(x, y, w, h)
    local instance = setmetatable({}, View)

    instance.x, instance.y = x, y
    instance.px, instance.py = x, y
    instance.margin = 10
    instance.w, instance.h = w, h
    
    instance.items = {}

    return instance
end

function View:add_item(item)
    table.insert(self.items, item)
    item:set_position(self.px, self.py)
    self.px, self.py = self.px, self.py + item.h + self.margin
end

function View:update(dt)
    for _, item in ipairs(self.items) do
        item:update(dt)
    end
end

function View:draw()
    for _, item in ipairs(self.items) do
        item:draw()
    end
end

function core.new_item(type)
    local instance

    if type == "text" then
        instance = setmetatable(text:new(), multiple_inheritance(Item, text))
        instance:set_dimensions(instance.font:getWidth(instance.text), instance.font:getHeight(instance.text))
    elseif type == "button" then
        instance = setmetatable(button:new(), multiple_inheritance(Item, button))
        instance:set_dimensions(200, 30)
    else
        error(type .. " is not a type in prfct.")
    end

    return instance
end

return core