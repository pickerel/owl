display.setStatusBar( display.HiddenStatusBar )
display.setDefault( "background", 255 )

-----------------------------------------------------------------------------------------

local class = require "betterclass"
require "class_puppy"

local puppy = class.instance{ from="PuppyClass" }
puppy:translate( display.contentCenterX*0.5, display.contentCenterY*0.5 )

-- modify puppy properties
puppy.name = "Spot"

-- print out the age of the puppy (default PuppyClass age is 6 months)
print( puppy.name .. " (" .. puppy.className .. ") is about " ..
	puppy:ageInDogYears() .. " years old in dog (" ..
		puppy.superClass.className .. ") years." )

