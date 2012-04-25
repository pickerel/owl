API Reference for owl.lua
=========================

## Methods

### owl.class{ name [, from, image, baseDir, width, height, createFunction, private ] }

Creates a new class object. Before you can have objects (known as instances), you must first create a class which can be though of as sort of a "model" for all instances created from the class. If you're creating a display object class, although you're specifying the display object's details in the class (image, etc.), no display object is actually created until you go to create a new object instance from the class (using owl.instance()).

Below is a listing of all valid parameters for owl.class():

#### name
This is a **required** string that represents a _unique_ name for the class. Ex.

	local BaboonClass = owl.class{ name="Baboon" }

#### from 
This is an optional string (or class object, as returned from owl.class) that is the parent class that this class should be sub-classed from. If this parameter is not specified, the class will be a top-level class.
	
	local AnimalClass = owl.class{ name="Animal" }
	local BaboonClass = owl.class{ name="Baboon" from="Animal" }
	--or
	local BaboonClass = owl.class{ name="Baboon" from=AnimalClass }

#### image
**Corona SDK/optional**. This represents the image (relative to baseDir parameter or system.ResourceDirectory) that a display object should be created from. If no width and height parameter is specified, display.newImage() will be used. Otherwise, display.newImageRect() will be used.

#### baseDir
**Corona SDK/optional**. If an image is specified, this will be the base directory at which the image file is located. Default is system.ResourceDirectory.

#### width
**Corona SDK/optional**. This is the width of the image (if specified) that corresponds to the 'width' argument in display.newImageRect().

#### height
**Corona SDK/optional**. This is the height of the image (if specified) that corresponds to the 'height' argument in display.newImageRect().

#### createFunction
**Corona SDK/optional**. If you want this to be a display object class but do not want to use a static image (as returned from display.newImage() and display.newImageRect()), this should be a reference to a function that **returns the display object you want to represent this class** (it is very important the function you specify returns a display object if you use this parameter!). This is useful if you need the class to produce a sprite, rect, circle, text, etc. display objects. If this parameter is used, you should not specify image, baseDir, width, or height parameters.

	local function create_rect_object()
		local rect = display.newRect( 0, 0, 250, 250 )
		rect:setFillColor( 255 )

		return rect
	end

	local SquareClass = owl.class{ name="Square", createFunction=create_rect_object }

#### private
This is an optional table or variable that you want to be automatically included in the class's private table. Once the class object is created, you can always add things to the class object's private table later. The private table of a class is accessible (and inherited by) sub-classes but NOT object instances created from classes.

	local AnimalClass = owl.class{ name="Animal", private={ var1="sample" } }

	-- is the same as ...

	local AnimalClass = owl.class{ name="Animal" }
	AnimalClass.private.var1 = "sample"

