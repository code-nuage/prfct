local core = {}

local base  = (...):gsub("%.[^%.]+$", "")
local button = require(base .. ".button")
local text = require(base .. ".text")

local View = {}
View.__index = View

local Item = {}
Item.__index = Item

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
    item.x, item.y = self.px, self.py
    self.px, self.py = self.px, self.py + item.h + self.margin
end

function View:set_margin(margin)
    self.margin = margin
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
        instance = setmetatable(text:new(), text)
    elseif type == "button" then
        instance = setmetatable(button:new(), button)
    else
        error(type .. "is not a type in prfct.")
    end
    return instance
end

return core