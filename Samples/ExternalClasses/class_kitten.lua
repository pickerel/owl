local class = require "betterclass"
local CatClass = require "class_cat"  -- ensures class we'll be extending from exists

local KittenClass = class.new{ name="KittenClass", from="CatClass", image="kitten.png", width=100, height=100 }

return KittenClass