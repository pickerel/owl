local class = require "betterclass"

local DogClass = class.new{ name="DogClass", image="dog.png", width=100, height=100 }

-- private properties
DogClass.private.ageMultiplier = 7

-- public properties
DogClass.name = "Unnamed Dog"
DogClass.age = 5	-- in human years

-- public methods
function DogClass:ageInDogYears()
	return self.age * DogClass.private.ageMultiplier
end

return DogClass