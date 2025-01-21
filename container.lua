Container = {}
Container.align_modes = { -- DEFINES HOW THE CHILDREN ITEMS INTERACT WITH OTHERS CHILDREN
    "start",
    "center",
    "end"
}
Container.justify_modes = { -- DEFINES HOW THE CHILDREN ITEMS INTERACT WITH EACH OTHERS
    "start", -- Everything is anchored to the start of the Container
    "center", -- Everything is anchored to the center of the Container
    "end", -- Everything is anchored to the end of the Container
    "space-between", -- The space between each children is equal
    "space-around" -- The space around each children is equal
}
Container.direction_modes = {
    "vertical",
    "horizontal"
}

--[[
    CONTAINER
]]
function Container:init_heritage()
    self:set_align("start")
    self:set_justify("start")
    self:set_direction("vertical")

    self.items = {}
end

--[[
    PUBLIC SETTERS
]]
function Container:add_item(item)
    self.items[#self.items + 1] = item
	self:update_items()
    return self
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


function Container:update_items()
    local container_width, container_height = self:get_dimensions()
    local total_width, total_height = 0, 0

    for _, item in ipairs(self.items) do
        local item_width, item_height = item:get_dimensions()
		if self.direction == "vertical" then
			if item_width > total_width then
				total_width = item_width
			end
        	total_height = total_height + item_height
		elseif self.direction == "horizontal" then
        	total_width = total_width + item_width
			if item_height > total_height then
				total_height = item_height
			end
		end
    end

    local justify_space = 0
    local start_x, start_y = self:get_position()
	if self.justify == "center" then
		if self.direction == "horizontal" then
			start_x = start_x + (container_width / 2) - (total_width / 2)
		elseif self.direction == "vertical" then
			start_y = start_x + (container_height / 2) - (total_height / 2)
		end
	elseif self.justify == "space-between" then
        if self.direction == "horizontal" then
            justify_space = (#self.items > 1) and (container_width - total_width) / (#self.items - 1) or 0
        elseif self.direction == "vertical" then
            justify_space = (#self.items > 1) and (container_height - total_height) / (#self.items - 1) or 0
        end
    elseif self.justify == "space-around" then
        if self.direction == "horizontal" then
            justify_space = (#self.items > 0) and (container_width - total_width) / (#self.items * 2) or 0
        elseif self.direction == "vertical" then
            justify_space = (#self.items > 0) and (container_height - total_height) / (#self.items * 2) or 0
        end
    end

    if self.align == "center" then
        if self.direction == "horizontal" then
            start_y = start_y + container_height / 2 - total_height / 2
        elseif self.direction == "vertical" then
            start_x = start_x + container_width / 2 - total_width / 2
        end
    elseif self.align == "end" then
        if self.direction == "horizontal" then
            start_y = start_y + container_height - total_height
        elseif self.direction == "vertical" then
            start_x = start_x + container_width - total_width
        end
    end

    local current_x, current_y = start_x, start_y
    for _, item in ipairs(self.items) do
        item:set_position(current_x, current_y)
        local item_width, item_height = item:get_dimensions()

        if self.direction == "horizontal" then
            current_x = current_x + item_width + justify_space
        elseif self.direction == "vertical" then
            current_y = current_y + item_height + justify_space
        end
    end
end


--[[
    PUBLIC GETTERS
]]
function Container:get_align()
    return self.align
end

function Container:get_justify()
    return self.justify
end

function Container:get_direction()
    return self.direction
end

function Container:draw_container()
    for _, item in ipairs(self.items) do
        item:draw()
    end
end

return Container