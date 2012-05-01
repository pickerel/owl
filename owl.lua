-----------------------------------------------------------------------------------------
--
-- owl.lua (Objects with Lua)
--
-- Version: 1.0.1
--
-- Copyright (C) Jonathan Beebe (http://jonbeebe.net)
--
-----------------------------------------------------------------------------------------

local class = {}
local registered = {}	-- stores all class definitions

-- for non-Corona SDK compatibility
local system = system
if not system then system = {}; end

--
--
-- PRIVATE FUNCTIONS
--
--

local function get_display_object( params )
	local params = params or {}
	local image = params.image
	local width = params.width
	local height = params.height
	local base_dir = params.baseDir or system.ResourceDirectory
	local create_object = params.custom  -- should be a function that returns a display object

	local obj
	if create_object and type(create_object) == "function" then
		obj = create_object()
	else
		if image and width and height then
			obj = display.newImageRect( image, base_dir, width, height )
		elseif image then
			obj = display.newImage( image, base_dir )
		end
	end
	return obj
end

local function extend_class( name, class )
	local class_mt = { __index = class }
	local private_mt = { __index = class.private }

	local c =
	{
		class_name=name,
		super_class=class,
		private=setmetatable( {}, private_mt )
	}

	if class.display_obj then
		local display_obj_mt = { __index = class.display_obj }
		c.display_obj = setmetatable( {}, display_obj_mt )
	end

	return setmetatable( c, class_mt )
end


--
--
-- CLASS METHODS
--
--

-- checks to see if object "is a" class (name or class object can be passed) -- super_classes are also checked
local function is_a( self, class_name )
	if not class_name then return false; end
	if type(class_name) == "table" then class_name = class_name.class_name; end
	local found_match

	while found_match == nil do
		if self.class_name == class_name then
			found_match = true
		elseif not self.super_class then
			found_match = false
		else
			found_match = is_a( self.super_class, class_name )
		end
	end
	return found_match
end

-- checks to see if object is an instance of specific class (super_classes are not checked)
local function instance_of( self, class_name )
	if not class_name then return false; end
	if type(class_name) == "table" then class_name = class_name.class_name; end
	return self.class_name == class_name
end

local function add_property_callback( self, property_name, callback )
	if not callback then return; end
	self.callback_properties[property_name] = callback
end

local function remove_property_callback( self, property_name )
	if not property_name then return; end
	self.callback_properties[property_name] = nil
end


--
--
-- PUBLIC FUNCTIONS
--
--

function class.class( params )
	-- required params: name, createFunction or image or (image and width and height)
	local params = params or {}

	-- valid parameters
	local name = params.name
	local image = params.image
	local width = params.width
	local height = params.height
	local base_dir = params.baseDir or system.ResourceDirectory
	local create_object = params.createFunction  -- should be a function or closure that returns a display object
	local parent_class = params.from  -- class object or string that corresponds to existing registered class
	local private = params.private or {} 	-- for private class data; can be anything (not accessible by instances)

	if type(parent_class) == "string" then
		parent_class = registered[parent_class]
	end

	-- throw warning and return if no class name is specified, or class name is already taken
	if not name then
		print( "WARNING: You must specify a name when creating a new class." )

	elseif registered[name] then
		print( "WARNING: The class name, " .. name .. ", is already in use. Class names must be unique." )
	end

	-- create brand new class or extend from base class (if specified)
	local c
	if parent_class then
		c = extend_class( name, parent_class )
		
		-- instances may optionally have different display object properties
		if image or (createFunction and type(createFunction) == "function") then
			c.display_obj =
			{
				image = image,
				width = width,
				height = height,
				base_dir = base_dir,
				createFunction = create_object
			}
		end
	else
		local proxy = {}
		c = {}
		c.class_name = name

		local c_mt = {
			__index = function(t,k)
				if k ~= "display_obj" then
					return proxy[k]
				end
			end,

			__newindex = function(t,k,v)
				proxy[k] = v
			end,
		}
		
		if image or create_object then
			-- holds data for associated display object
			c.display_obj =
			{
				image = image,
				width = width,
				height = height,
				base_dir = base_dir,
				createFunction = create_object
			}
		end

		-- optional private class data (accessible from sub-classes, but not instances)
		c.private = private
		setmetatable( c, c_mt )
	end

	-- assign methods
	c.is_a = is_a
	c.kind_of = is_a
	c.instance_of = instance_of
	c.add_property_callback = add_property_callback
	c.remove_property_callback = remove_property_callback

	-- register the class and return it
	registered[name] = c
	return c
end

-- will de-register/remove a class (it's user's responsibility to make sure no objects are using it!)
function class.remove( name )
	registered[name] = nil
end

-- creates a new instance of a specific class
function class.instance( params )
	local params = params or {}

	-- extract function params
	local id = params.id  -- an id can be optionally assigned to this object
	local base_class = params.from	-- the class this instance is derived from
	local constructor = params.init  -- optionally specify constructor function for this instance (or class constructor is used)
	local init_params = params.params  -- user-provided params passed to constructor (init) function

	-- throw a warning and return if base class is not specified or does not exist
	local no_base_warning = "WARNING: You must specify a base class when creating a new class instance."
	if not base_class then
		print( no_base_warning )
		return
	else
		if type(base_class) == "string" then
			base_class = registered[base_class]
		end
	end
	
	if not base_class then
		print( no_base_warning )
		return
	end

	-- create object instance from class' definition and copy class properties to instance
	local obj
	
	if base_class.display_obj then
		obj = get_display_object( base_class.display_obj )
	else
		obj = {}
	end

	-- set up object properties
	obj.id = id
	obj.callback_properties = {}  -- contains properties and corresponding callbacks (called on update)
	obj.private = {}

	-- proxy and metatable setup
	local _t = obj
	local t = {}
	t.raw = obj

	local mt =
	{
		__index = function(tb,k)
			if k == "display_obj" then return;
			elseif k == "private" then
				return rawget( _t, "private" )
			elseif k == "raw" then
				return rawget( t, "raw" )
			end

			if _t[k] then
				if type(_t[k]) == 'function' then
					return function(...) arg[1] = _t; _t[k](unpack(arg)) end
				else
					return _t[k]
				end
			else
				return base_class[k]
			end
		end,

		__newindex = function(tb,k,v)
			if k == "super_class" or k == "class_name" or k == "callback_properties" then return; end

			if _t.callback_properties[k] and type(_t.callback_properties[k]) == "function" then
				local event =
				{
					name="propertyUpdate",
					target=tb,
					key=k,
					value=v
				}
				local callback = _t.callback_properties[k]
				callback( _t, event )
			else
				_t[k] = v
			end
		end
	}
	setmetatable(t, mt)

	-- call constructor function (if exists in class)
	if constructor and type(constructor) == "function" then
		constructor( t, init_params )
	elseif base_class.init and type(base_class.init) == "function" then
		base_class.init( t, init_params )
	end

	return t
end

return class