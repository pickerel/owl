local owl = require "owl"

local Dog = owl.new{ name="Dog", image="dog.png", width=100, height=100 }

-- private properties
Dog.private.ageMultiplier = 7

-- public properties
Dog.name = "Unnamed Dog"
Dog.age = 5	-- in human years

-- constructor
function Dog:init( params )
	print( "Dog instance, " .. self.id .. ", created with var: " .. params.var1 )
end

-- public methods
function Dog:ageInDogYears()
	return self.age * Dog.private.ageMultiplier
end

return Dog