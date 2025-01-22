local Button = {}

--[[
    PUBLIC METHODS
]]
function Button:is_hovered()
    local mx, my = love.mouse.getPosition()
    if mx > self.x and self.x + self.w > mx then
        if my > self.y and self.y + self.h > my then
            return true
        end
    end
end

function Button:is_clicked(button)
    if self:is_hovered() then
        if love.mouse.isDown(button or 1) then
            return true
        end
    end
end

return Button