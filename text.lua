local unpack = table.unpack or unpack

--[[
    CONSTRUCTOR
]]
local Text = {}
Text.__index = Text

function Text:new()
    local instance = setmetatable({}, Text)

    instance.text = "Text"
    instance.font = love.graphics.getFont()
    instance.color = {
        r = 1, g = 1, b = 1, a = 1
    }

    return instance
end

--[[
    SETTERS
]]
function Text:set_text(text)
    self.text = text
    self:set_dimensions(self:get_font():getWidth(text), self:get_font():getHeight(text)) -- Set dimensions of the item again
    return self
end

function Text:set_font(font)
    self.font = font
    self:set_dimensions(font:getWidth(self:get_text()), font:getHeight(self:get_text())) -- Set dimensions of the item again
    return self
end

function Text:set_color(r, g, b, a)
    self.color = {r = r, g = g, b = b, a = a or 1}
    return self
end

--[[
    GETTERS
]]

function Text:get_text()
    return self.text
end

function Text:get_font()
    return self.font
end

function Text:get_color()
    local r, g, b, a = self.color.r, self.color.g, self.color.b, self.color.a
    return {r, g, b, a}
end

--[[
    DRAW
]]
function Text:draw()
    local font = love.graphics.getFont()
    local r, g, b, a = love.graphics.getColor()

    love.graphics.setFont(self:get_font())
    love.graphics.setColor(self.color.r, self.color.g, self.color.b, self.color.a)

    love.graphics.print(self.text, self.x, self.y)

    love.graphics.setFont(font)
    love.graphics.setColor(r, g, b, a)
end

return Text