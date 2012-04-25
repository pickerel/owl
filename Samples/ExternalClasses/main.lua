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
print( puppy.name .. ", a " .. puppy.class_name .. " which comes from a "..
	puppy.super_class.class_name .. ", is about " .. puppy:age_in_dog_years() ..
		" years old in dog years." )
