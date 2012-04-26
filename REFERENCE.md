Reference
=========
## owl.lua

----------

## Library Functions

### owl.class{ name *[, from, image, baseDir, width, height, custom, private ]* }

Creates and returns a new class object. Before you can have objects (known as instances), you must first create a class object which can be thought of as a "model" for all object instances created from the class. If you're creating a display object class (for use with Corona SDK projects), although you're specifying the display object's details in the class (image, etc.), no display object is actually created until you create a new object instance from the class (using owl.instance()).

Below is a listing of all valid parameters for owl.class():

#### name
This is a **required** string that represents a _unique_ name for the class. Ex.

	local BaboonClass = owl.class{ name="Baboon" }

#### from 
This is an optional string (or class object, as returned from owl.class) that is the parent class that this class should be sub-classed from. If this parameter is not specified, the class will be a top-level class.
	
	local AnimalClass = owl.class{ name="Animal" }
	local BaboonClass = owl.class{ name="Baboon", from="Animal" }
	-- or
	local BaboonClass = owl.class{ name="Baboon", from=AnimalClass }

#### image
**Corona SDK (optional)**. This represents the image (relative to baseDir parameter or system.ResourceDirectory) that a display object should be created from. If no width and height parameter is specified, display.newImage() will be used. Otherwise, display.newImageRect() (which supports dynamic content scaling) will be used instead.

#### baseDir
**Corona SDK (optional)**. If an image is specified, this will be the base directory at which the image file is located. Default is system.ResourceDirectory.

#### width
**Corona SDK (optional)**. This is the width of the image (if specified) that corresponds to the 'width' argument in display.newImageRect().

#### height
**Corona SDK/optional**. This is the height of the image (if specified) that corresponds to the 'height' argument in display.newImageRect().

#### custom
**Corona SDK (optional)**. If you want this to be a display object class but do not want to use a static image (as returned from display.newImage() and display.newImageRect()), this should be a reference to a function that **returns the display object you want to represent this class** (it is very important the function you specify returns a display object if you use this parameter!). This is useful if you need the class to produce a sprite, rect, circle, text, etc. display objects. If this parameter is used, you should not specify image, baseDir, width, or height parameters.

	local function create_rect_object()
		local rect = display.newRect( 0, 0, 250, 250 )
		rect:setFillColor( 255 )

		return rect
	end

	local SquareClass = owl.class{ name="Square", custom=create_rect_object }

#### private
This is an optional table or variable that you want to be automatically included in the class's private table. Once the class object is created, you can always add things to the class object's private table later. The private table of a class is accessible (and inherited by) sub-classes but NOT object instances created from classes.

	local AnimalClass = owl.class{ name="Animal", private={ var1="sample" } }

	-- is the same as --

	local AnimalClass = owl.class{ name="Animal" }
	AnimalClass.private.var1 = "sample"


----------

### owl.instance{ from *[, id, init, params ]* }

#### from
This is a **required** string (or class object, as returned from owl.class) that represents the "model" that will be used to construct the actual object instance. This is the class that the object will be based on (the "class_name" of the object).

	local BaboonClass = owl.class{ name="Baboon", image="baboon.png" }
	local baboon_obj = owl.instance{ from=BaboonClass }
	baboon_obj:translate( 100, 100 )

#### id
This is an optional string that is a convenience if you need to identify the object. It can be read/write later on via the .id property of the object.

#### init
This is an optional reference to a function that will serve as the "constructor" for this particular object instance that will be called immediately after the object has been created. If this parameter is not specified, the class constructor (Class:init()) will be called instead (if it exists).

	local function custom_constructor( params )
	    print( "The object was created!" )
	end

	local baboon_obj = owl.instance{ from="Baboon", init=custom_constructor }

#### params
This is an optional table that will be passed to the constructor (either the function specified in the init parameter, or the class constructor if it exists). It can contain anything you want.

	local function custom_init( params )
	    print( params.msg )
	end

	local baboon_obj = owl.instance{ from="Baboon", init=custom_init, params={ msg="Hello world." } }

----------

## Constructors

You may have per-class constructors, per-instance constructors, or both. A constructor is simply a function that is called whenever an object instance is created. You can pass whatever custom parameters you want to the constructor function. Please see the **Constructors** sample to get a better understanding of how to use constructors in a real project.

## Defined in the Class

Constructors are most commonly defined by adding an init() method to the class object. Whenever an object instance is created from the class, the init() function will be called. When you define a class constructor, all object instances created from the class will use the class constructor by default (unless it is overrided on a per-instance basis).

Here's an example of a constructor that's defined in the class object:

	local AnimalClass = owl.class{ name="Animal" }

	-- constructor (called by default every time a new "Animal" instance is created)
	function AnimalClass:init( params )
	    local params = params or {}

	    local name = self.id or "Unnamed"  -- 'self' is a reference to the instance object

	    print( "New instance of Animal created: " .. name )
	    print( "Here's a variable passed through params: " .. tostring(params.var1) )
	end

	local cat = owl.instance{ from="Animal", id="Mufasa", params={ var1="sample" } }

	-- OUTPUT: New instance of Animal created: Mufasa

## Defined Per-Instance

A constructor can also be defined on a per-instance basis. If an instance constructor exists, it will be called. If not, the class constructor will be called instead (if it has been defined).

You can specify a per-instance constructor when you create the instance (via an init parameter):

	local function instance_constructor( params )
	    local name = self.id or "Unnamed"

	    print( "New instance created: " .. name )
	end

	local cat = owl.instance{ from="Animal", id="Mufasa", params={ var1="sample" } }

----------

## Methods

The following methods can be called on both class objects, as well as object instances of class objects.

### is_a( class_or_class_name )

This method will check if an object is of class **class_or_class_name** (which can be a string or an actual class object as returned from owl.class()) and return true or false. All levels of inheritance are checked, so for example, if you have a Mammal class, and an Animal class that is sub-classed from Mammal, and then you create a "bird" object. If you were to call bird_obj:is_a( "Mammal" ) it would return true.

	local MammalClass = owl.class{ name="Mammal" }
	local AnimalClass = owl.class{ name="Animal", from=MammalClass }

	local bird = owl.class{ from="Animal" }
	bird:is_a( MammalClass )  -- true
	bird:is_a( "Mammal" )  -- true
	bird:is_a( "Animal" )  -- true

	AnimalClass:is_a( "Mammal" )  -- true

### kind_of( class_or_class_name )

This is the same as the is_a(), but is available for convenience.

### instance_of( class_or_class_name )

This function is similar to is_a()/kind_of() but it only checks the actual class of the object (super classes are not checked).

	local MammalClass = owl.class{ name="Mammal" }
	local AnimalClass = owl.class{ name="Animal", from=MammalClass }

	local bird = owl.class{ from="Animal" }
	bird:instance_of( MammalClass )  -- false
	bird:instance_of( AnimalClass )  -- true

### add_property_callback( property_name, listener )
### remove_property_callback( property_name )

These two methods make it easy to have basic "metamethod" functionality which can intercept property updates of instance objects. Please see the **EasyMetamethods** sample for usage and other information (pay close attention to the notes in the comments as well).

----------

### by [Jonathan Beebe (http://jonbeebe.net)](http://jonbeebe.net)