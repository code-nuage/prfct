local unpack = table.unpack or unpack

local function rounded_rectangle(x, y, w, h, radius)
    love.graphics.rectangle("fill", x, y + radius, w, h - (radius * 2))
    love.graphics.rectangle("fill", x + radius, y, w - (radius * 2), h)

    love.graphics.circle("fill", x + radius, y + radius, radius)
    love.graphics.circle("fill", x + radius, y + h - radius, radius)
    love.graphics.circle("fill", x + w - radius, y + radius, radius)
    love.graphics.circle("fill", x + w - radius, y + h - radius, radius)
end

--[[
    CONSTRUCTOR
]]
local Button = {}
Button.__index = Button

function Button:new()
    local instance = setmetatable({}, Button)

    instance.text = "Text"
    instance.font = love.graphics.getFont()
    instance.text_color = {
        r = 1, g = 1, b = 1, a = 1
    }
    instance.background_color = {
        r = .5, g = .5, b = .5, a = 1
    }
    instance.border_radius = 0

    return instance
end

--[[
    STATEMENTS
]]
function Button:is_hovered()
    local mx, my = love.mouse.getPosition()
    if self.x < mx and mx < self.x + self.w then
        if self.y < my and my < self.y + self.h then
            return true
        end
    end
end

function Button:is_clicked()
    if self:is_hovered() then
        if love.mouse.isDown(1) then
            return true
        end
    end
end

--[[
    SETTERS
]]

function Button:set_text(text)
    self.text = text
    return self
end

function Button:set_font(font)
    self.font = font
    return self
end

function Button:set_text_color(r, g, b, a)
    self.text_color = {r = r, g = g, b = b, a = a or 1}
    return self
end

function Button:set_background_color(r, g, b, a)
    self.background_color = {r = r, g = g, b = b, a = a or 1}
    return self
end

function Button:set_border_radius(radius)
    self.border_radius = radius
    return self
end

--[[
    GETTERS
]]
function Button:get_text()
    return self.text
end

function Button:get_font()
    return self.font
end

function Button:get_text_color()
    return unpack(self.color)
end

function Button:get_background_color()
    return unpack(self.background_color)
end

--[[
    DRAW
]]
function Button:draw()
    local font = love.graphics.getFont()
    local r, g, b, a = love.graphics.getColor()

    love.graphics.setColor(self.background_color.r, self.background_color.g, self.background_color.b, self.background_color.a)
    rounded_rectangle(self.x, self.y, self.w, self.h, self.border_radius)

    love.graphics.setColor(self.text_color.r, self.text_color.g, self.text_color.b, self.text_color.a)
    love.graphics.setFont(self:get_font())
    love.graphics.print(
        self.text,
        self.x + self.w / 2 - self.font:getWidth(self.text) / 2,
        self.y + self.h / 2 - self.font:getHeight(self.text) / 2
    )

    love.graphics.setFont(font)
    love.graphics.setColor(r, g, b, a)
end

return Button