display.setStatusBar( display.HiddenStatusBar )
display.setDefault( "background", 255 )

-----------------------------------------------------------------------------------------

local owl = require "owl"

-- create a new class
local Dog = owl.class{ name="Dog", image="dog.png", width="100", height="100" }

-- private class variables (inherited by sub-classes, but NOT instances)
Dog.private.sample_var = "sample value"

-- public class properties (inherited by sub-classes AND instances)
Dog.hello_world = "Hello World!"

-- create an object instance from the "Dog" class
local black_dog = owl.instance{ from=Dog }	-- from accepts class object (table) or name (string)
black_dog:translate( display.contentCenterX, display.contentCenterY )

black_dog.private.instance_var = "[private instance data]"

-- See terminal for explanation of private vs. public class data, outlined below:
print( "\n" .. "Instances DO NOT inherit the private table from class:" )
	print( "\t" .. "CLASS:     Dog.private = " .. tostring(Dog.private) )
	print( "\t" .. "CLASS:     Dog.private.sample_var = \"" .. tostring(Dog.private.sample_var) .. "\"")
	
	print( "\n\t" .. "INSTANCE:  black_dog.private = " .. tostring(black_dog.private) )

print( "\n" .. "But they DO inherit public properties and methods:" )
	print( "\t" .. "CLASS:     Dog.hello_world = \"" .. Dog.hello_world .. "\"" )
	print( "\t" .. "INSTANCE:  black_dog.hello_world = \"" .. black_dog.hello_world .. "\"" )

print( "\n" .. "Instances can also have their own private data (separate from class):" )
	print( "\t" .. "INSTANCE: black_dog.private.instance_var = \"" .. black_dog.private.instance_var .. "\"" )

print( "\n" .. "...and override any class properties and methods:" )
	black_dog.hello_world = "is now different"
	print( "\t" .. "CLASS:     Dog.hello_world = \"" .. Dog.hello_world .. "\"" )
	print( "\t" .. "INSTANCE:  black_dog.hello_world = \"" .. black_dog.hello_world .. "\"" )
