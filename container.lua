Container = {}

--[[
    CONTAINER
]]
function Container:init_heritage()
    self:set_align("start")
    self:set_justify("start")
    self:set_direction("horizontal")
end

--[[
    PUBLIC SETTERS
]]
function Container:add_item(item)
    item:set_position(self.px, self.py)
    self.items[#self.items + 1] = item
    local nx, ny = item:get_dimensions()
    self.px, self.py = 0, ny
end

function Container:set_align(mode)
    for _, v in ipairs(self.align_modes) do
        if mode == v then
            self.align = mode
            return self
        end
    end
    error(mode .. " is not an align mode in prfct.")
end

function Container:set_justify(mode)
    for _, v in ipairs(self.justify_modes) do
        if mode == v then
            self.justify = mode
            return self
        end
    end
    error(mode .. " is not a justify mode in prfct.")
end

function Container:set_direction(mode)
    for _, v in ipairs(self.direction_modes) do
        if mode == v then
            self.direction = mode
            return self
        end
    end
    error(mode .. " is not a direction mode in prfct.")
end

--[[
    PUBLIC GETTERS
]]
function Area:get_align()
    return self.align
end

function Area:get_justify()
    return self.justify
end

function Area:get_direction()
    return self.direction
end

return Container