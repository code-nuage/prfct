Area = {}
Area.__index = Area

--[[
    PRIVATE FUNCTIONS
]]
local function draw_rounded_rectangle(x, y, w, h, radius)
    radius = math.min(radius, w / 2, h / 2)

    love.graphics.rectangle("fill", x + radius, y, w - 2 * radius, h)
    love.graphics.rectangle("fill", x, y + radius, w, h - 2 * radius)

    love.graphics.arc("fill", x + radius, y + radius, radius, math.rad(180), math.rad(270))
    love.graphics.arc("fill", x + w - radius, y + radius, radius, math.rad(270), math.rad(360))
    love.graphics.arc("fill", x + w - radius, y + h - radius, radius, math.rad(0), math.rad(90))
    love.graphics.arc("fill", x + radius, y + h - radius, radius, math.rad(90), math.rad(180))
end


--[[
    CONSTRUCTOR
]]
function Area:new()
    local instance = setmetatable({}, Area)

    self.px, self.py = 0, 0
    instance:set_position(0, 0)
    instance:set_dimensions(100, 100)
    instance:set_background_color(0, 0, 0, 0)
    instance:set_radius(0)

    return instance
end

--[[
    PUBLIC SETTERS
]]
function Area:set_position(x, y)
    assert(type(x) == "number" and type(y) == "number", "Position must be numbers.")
    self.x, self.y = x, y
    return self
end

function Area:set_dimensions(w, h)
    assert(type(w) == "number" and type(h) == "number", "Dimensions must be numbers.")
    self.w, self.h = w, h
    return self
end

function Area:set_background_color(r, g, b, a)
    self.background_color = {r = r, g = g, b = b, a = a or 1}
    return self
end

function Area:set_radius(radius)
    self.radius = radius
    return self
end

--[[
    PUBLIC GETTERS
]]
function Area:get_position()
    return self.x, self.y
end

function Area:get_dimensions()
    return self.w, self.h
end

function Area:get_background_color()
    return self.background_color.r, self.background_color.g, self.background_color.b, self.background_color.a
end

function Area:get_radius()
    return self.radius
end

--[[
    LOVE DRAWING METHOD
]]
function Area:draw()
    local x, y = self:get_position()
    local w, h = self:get_dimensions()
    local radius = self:get_radius()

    local pr, pg, pb, pa = love.graphics.getColor()
    love.graphics.setColor(self:get_background_color())

    draw_rounded_rectangle(x, y, w, h, radius)

    love.graphics.setColor(pr, pg, pb, pa)

    if self.draw_heritage then self:draw_heritage() end
    if self.draw_container then self:draw_container() end
end

return Area