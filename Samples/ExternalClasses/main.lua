display.setStatusBar( display.HiddenStatusBar )
display.setDefault( "background", 255 )

-----------------------------------------------------------------------------------------

local owl = require "owl"
require "class_puppy"

local puppy = owl.instance{ from="Puppy" }
puppy:translate( display.contentCenterX*0.5, display.contentCenterY*0.5 )

-- modify puppy properties
puppy.name = "Spot"

-- print out the age of the puppy (default PuppyClass age is 6 months)
print( puppy.name .. " is a " .. puppy.className .. ", which a kind of "..
	puppy.superClass.className .. ", is about " .. puppy:ageInDogYears() ..
		" years old in dog years." )

