local owl = require "owl"
local Cat = require "class_cat"  -- ensures class we'll be extending from exists

local Kitten = owl.class{ from="Cat", name="Kitten", image="kitten.png", width=100, height=100 }

return Kitten