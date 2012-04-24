local class = require "betterclass"
local DogClass = require "class_dog"  -- ensures class we'll be extending from exists

local PuppyClass = class.new{ name="PuppyClass", from="DogClass", image="puppy.png", width=100, height=100 }

-- public properties
PuppyClass.name = "New Puppy"
PuppyClass.age = 6  -- human months (since this is a puppy)

-- public methods
function PuppyClass:ageInDogYears()
	return (self.age/12) * PuppyClass.private.ageMultiplier	-- private property inherited from DogClass
end

return PuppyClass