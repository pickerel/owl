local owl = require "owl"
local Dog = require "class_dog"  -- ensures class we'll be extending from exists

local Puppy = owl.class{ from="Dog", name="Puppy", image="puppy.png", width=100, height=100 }

-- private data that does not need access from sub-classes or instances
local months_in_year = 12

-- public properties
Puppy.name = "New Puppy"
Puppy.age = 6  -- human months (since this is a puppy)

-- public methods
function Puppy:age_in_dog_years()
	return (self.age/months_in_year) * Puppy.private.age_multiplier	-- private 'age_multiplier' property inherited from Dog
end

return Puppy