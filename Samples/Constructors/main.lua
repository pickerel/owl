display.setStatusBar( display.HiddenStatusBar )
display.setDefault( "background", 255 )

-----------------------------------------------------------------------------------------

local owl = require "owl"

-- create a new class
local Cat = owl.class{ name="CatClass", image="cat.png", width="100", height="100" }

Cat.name = "An unnamed cat"

-- Constructor is defined by presence of init() function
function Cat:init( params )
	print( "\nCreated new instance of CatClass." )

	-- 'self' actually represents the object instance, not the class object
	self.name = params.name
	self.color = params.color
	self.size = params.size
end

--------------------

-- the follow params are passed to the constructor (Cat:init() above)
local cat_params =
{
	name = "Fuzzball",
	color = "black",
	size = "medium"
}

-- create an object instance of CatClass (by default, class constructor is used for every instance)
local black_cat1 = owl.instance{ from="CatClass", params=cat_params }
black_cat1:translate( display.contentCenterX, display.contentCenterY + 80 )

print( black_cat1.name )
print( black_cat1.color )
print( black_cat1.size .. "\n" )

--------------------
-- Next, we'll create an instance that has its own unique constructor...
--------------------

-- The following is a constructor is assigned to a specific instance via the 'init' parameter
-- If used, it will override the "default" class constructor -- Class:init()
local function instance_constructor( self, params )
	print( "Creating a separate instance of CatClass." )

	self.name = params.name
	self.color = params.color
	self.size = params.size
	self.eye_color = params.eye_color
end

-- these params will be passed to the constructor function for black_cat2 (not yet created)
local cat_params =
{
	name = "Felix",
	color = "black",
	size = "small",
	eye_color = "green"
}

-- Use the 'init' parameter in owl.instance{} to set a custom constructor
local black_cat2 = owl.instance{ from=Cat, init=instance_constructor, params=cat_params }
black_cat2:translate( display.contentCenterX, display.contentCenterY*0.25 + 80 )

print( black_cat2.name )
print( black_cat2.color )
print( black_cat2.size )
print( black_cat2.eye_color )