-----------------------------------------------------------------------------------------
--
-- betterclass.lua
--
-- Copyright (C) Jonathan Beebe (http://jonbeebe.net)
--
-----------------------------------------------------------------------------------------

local class = {}
local registered = {}	-- where all class definitions are stored

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
	local create_object = params.createFunction  -- should be a function or closure that returns a display object

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

local function extendClass( name, class )
	local class_mt = { __index = class }
	local private_mt = { __index = class.private }
	return setmetatable( { className=name, superClass=class, private=setmetatable( {}, private_mt ) }, class_mt )
end


--
--
-- CLASS METHODS
--
--

-- checks to see if object "is a" class (name or class object can be passed) -- superclasses are also checked
local function is_a( self, className )
	if not className then return false; end
	if type(className) == "table" then className = className.className; end
	local found_match

	while found_match == nil do
		if self.className == className then
			found_match = true
		elseif not self.superClass then
			found_match = false
		else
			found_match = is_a( self.superClass, className )
		end
	end
	return found_match
end

-- checks to see if object is an instance of specific class (superclasses are not checked)
local function instance_of( self, className )
	if not className then return false; end
	if type(className) == "table" then className = className.className; end
	return self.className == className
end

local function addPropertyCallback( self, propertyName, callback )
	if not callback then return; end
	self.callbackProperties[propertyName] = callback
end

local function removePropertyCallback( self, propertyName )
	if not propertyName then return; end
	self.callbackProperties[propertyName] = nil
end


--
--
-- PUBLIC FUNCTIONS
--
--

function class.new( params )
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
		c = extendClass( name, parent_class )
	else
		local proxy = {}
		c = {}
		c.className = name

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
	c.addPropertyCallback = addPropertyCallback
	c.removePropertyCallback = removePropertyCallback

	-- register the class and return it
	registered[name] = c
	return c
end

-- will de-register/remove a class (it's user's responsibility to make sure no objects are using it!)
function class.remove( name )
	registered[name] = nil
end

function class.instance( params )
	local params = params or {}

	-- extract function params
	local id = params.id  -- an id can be optionally assigned to this object
	local base_class = params.from
	local callback = params.callback  -- if specified, will be called on property changes (easy metamethods)

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

	-- set property update calback (if specified; or will inherit from base_class)
	if callback then obj.callback = callback; end
	obj.callbackProperties = {}

	-- proxy and metatable setup
	local _t = obj
	local t = {}

	local mt =
	{
		__index = function(tb,k)
			if k == "private" or k == "display_obj" then return; end

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
			if k == "superClass" or k == "className" or k == "callbackProperties" then return; end

			if _t.callbackProperties[k] and type(_t.callbackProperties[k]) == "function" then
				local event =
				{
					name="propertyUpdate",
					target=tb,
					key=k,
					value=v
				}
				local callback = _t.callbackProperties[k]
				callback( _t, event )

			--[[
			if _t.callback and type(_t.callback) == "function" then
				local event =
				{
					name="propertyUpdate",
					target=tb,
					key=k,
					value=v
				}
				_t:callback( event )
			--]]
			else
				_t[k] = v
			end
		end
	}
	setmetatable(t, mt)

	return t
end

return class