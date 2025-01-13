Text = {}

--[[
    CONSTRUCTOR
]]
function Text:init_heritage()
    self:set_color(1, 1, 1, 1)
    self:set_text("Some text...")
    self:set_font(love.graphics.getFont())

    return self
end

--[[
    PUBLIC SETTERS
]]
function Text:set_color(r, g, b, a)
    self.color = {r = r, g = g, b = b, a = a or 1}
    return self
end

function Text:set_text(text)
    assert(type(text) == "string", "Text must be a string.")
    self.text = text
    self:set_dimensions(love.graphics.getFont():getWidth(text), love.graphics.getFont():getHeight(text))
    return self
end

function Text:set_font(font)
    self.font = font
    return self
end

--[[
    PUBLIC GETTERS
]]
function Text:get_text()
    return self.text
end

function Text:get_font()
    return self.font
end

function Text:get_color()
    return self.color.r, self.color.g, self.color.b, self.color.a
end

--[[
    LOVE DRAWING METHOD
]]
function Text:draw_heritage()
    local x, y = self:get_position()
    local font = love.graphics.getFont()

    local pr, pg, pb, pa = love.graphics.getColor()
    love.graphics.setColor(self:get_color())
    love.graphics.setFont(self:get_font())

    love.graphics.print(self.text, x, y)

    love.graphics.setColor(pr, pg, pb, pa)
    love.graphics.setFont(font)
end

return Text