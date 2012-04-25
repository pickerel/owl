display.setStatusBar( display.HiddenStatusBar )
display.setDefault( "background", 255 )

-----------------------------------------------------------------------------------------

local owl = require "owl"

-- create a new class
local Dog = owl.class{ name="DogClass", image="dog.png", width="100", height="100" }

Dog.name = "THIS IS THE DOG'S NAME"

-- create a new instance of "DogClass"
local black_dog = owl.instance{ from=Dog }
black_dog:translate( display.contentCenterX, display.contentCenterY )

-- set up property callback listener function
local function on_fur_color_change( self, event )
	
	-- 
	-- self = plain object (no inheritance)
	-- event.name = "propertyUpdate"
	-- event.target = class object instance
	-- event.key = the key that was changed (fur_color)
	-- event.value = the new value
	--

	print( "Changing the color of the fur to: " .. event.value )

	-- 'self' is just the plain object, no inheritance
	print( self.name )  -- will be nil because it is not defined and plain object does not inherit from class

	-- 'event.target' should be used for actual instance of class
	print( event.target.name )  -- inheritance will kick in

	-- the following line is the only time you should 'self' in property callback listener
	self[event.key] = event.value
end

-- assign above listener function as a "property callback" for the 'fur_color' property
black_dog:add_property_callback( "fur_color", on_fur_color_change )

-- now, whenever we change the 'fur_color' property on black_dog, the on_fur_color_change() is called.
black_dog.fur_color = "brown"

-- we can also remove the property callback (reverts to old behavior)
black_dog:remove_property_callback( "fur_color" )

black_dog.fur_color = "black"
print()
print( black_dog.fur_color )