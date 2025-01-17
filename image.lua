Image = {}

function Image:set_image(image)
    self.image = image
    local scale = self.scale or 1
    self:set_dimensions(self.image:getWidth() * scale, self.image:getHeight() * scale)
    return self
end

function Image:set_scale(scale)
    self.scale = scale
    self:set_dimensions(self.image:getWidth() * self.scale, self.image:getHeight() * self.scale)
    return self
end

function Image:get_image()
    return self.image
end

function Image:get_scale()
    return self.scale
end

function Image:draw_heritage()
    local scale = self.scale or 1
    if self.image then
        love.graphics.draw(self.image, self.x, self.y, 0, scale)
    end
end

return Image