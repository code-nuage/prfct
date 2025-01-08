unpack = table.unpack or unpack

Area = {}
Area.__index = Area

function Area:new()
    local instance = setmetatable({}, Area)

    instance:set_mode("normal")
    instance:set_align("start")
    instance:set_direction("horizontal")
    instance.items = {}

    return instance
end

--[[
    SETTERS
]]
function Area:add_item(item)
    table.insert(self.items, item)
    if self:get_mode() == "normal" then
        item:set_position(self.x, self.y + self.items[#self.items].h or self.y)
    elseif self:get_mode() == "space-between" then
        self:update_items()
    end
    return self
end

function Area:update_items()
    local available_length = self.w
    local item_count = #self.items

    if item_count < 2 then
        -- Si 0 ou 1 item, aucun espacement nécessaire
        for _, item in ipairs(self.items) do
            item:set_position(self.x, self.y)
        end
        return
    end

    -- Calculer la largeur totale occupée par les objets
    for _, item in ipairs(self.items) do
        available_length = available_length - item.w
    end

    -- Calculer l'espace entre les objets
    local gap = available_length / (item_count - 1)

    -- Positionner les objets
    local current_x = self.x
    for i, item in ipairs(self.items) do
        item:set_position(current_x, self.y) -- Positionner l'élément
        current_x = current_x + item.w + gap -- Avancer à la position suivante
    end
end

function Area:set_mode(mode)
    if mode == "normal" or mode == "space-between" or mode == "space-around" then
        self.mode = mode
    else
        error(mode .. " mode is not an area mode in prfct.")
    end
    return self
end

function Area:set_align(align)
    if align == "start" or align == "center" or align == "end" then
        self.align = align
    else
        error(align .. " align is not an area align in prfct.")
    end
    return self
end

function Area:set_direction(direction)
    if direction == "normal" or "space-between" or "space-around" then
        self.mode = direction
    else
        error(direction .. " is not an area direction in prfct.")
    end
    return self
end

--[[
    GETTERS
]]
function Area:get_mode()
    return self.mode
end

function Area:draw()
    love.graphics.rectangle("line", self.x, self.y, self.w, self.h)

    for _, item in ipairs(self.items) do
        item:draw()
    end
end

return Area