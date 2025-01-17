# prfct

## What is `prfct`
`prfct` is a Lua and LÖVE2D library inspired by HTML+CSS that handles menus in a natural way.

## How to install `prfct`
To install `prfct`, add it to your project by requiring the directory's path
```lua
local prfct = require("path/to/prfct")
```

## How to use `prfct` ?
`prfct` uses item types to create items. You can start by create a blank `Area` and set it's background color to red.
```lua
function love.load()
    AREA = prfct.core.new_item("area")
    AREA:set_background_color(1, 0, 0)
end

function love.draw()
    AREA:draw()
end
```