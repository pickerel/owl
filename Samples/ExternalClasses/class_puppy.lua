local owl = require "owl"
local Dog = require "class_dog"  -- ensures class we'll be extending from exists

local Puppy = owl.new{ name="Puppy", from="Dog", image="puppy.png", width=100, height=100 }

-- public properties
Puppy.name = "New Puppy"
Puppy.age = 6  -- human months (since this is a puppy)

-- public methods
function Puppy:ageInDogYears()
	return (self.age/12) * Puppy.private.ageMultiplier	-- private property inherited from Dog
end

return Puppy