display.setStatusBar( display.HiddenStatusBar )
display.setDefault( "background", 255 )

-----------------------------------------------------------------------------------------

local owl = require "owl"

-- create a new class
local Cat = owl.class{ name="CatClass", image="cat.png", width="100", height="100" }

-- public class properties; all inherited by sub-classes AND instances
Cat.name = "An unnamed cat"

-- public class methods; all inherited by sub-classes AND instances
function Cat:meow()
	print( self.name .. " says meeeeeooooowww!" )
end

function Cat:purr()
	print( self.name .. " says prrrrrrrrrrrrr..." )
end

--------------------

-- create three object instances of the "CatClass" class
local black_cat1 = owl.instance{ from="CatClass" }
black_cat1:translate( display.contentCenterX, display.contentCenterY*0.25 )
black_cat1.name = "Haiku"

local black_cat2 = owl.instance{ from="CatClass" }
black_cat2:translate( display.contentCenterX, display.contentCenterY+(display.contentCenterY*0.75))
black_cat2.name = "Calcifer"

local black_cat3 = owl.instance{ from="CatClass" }
black_cat3:translate( display.contentCenterX, display.contentCenterY )
-- Let's not set the name of the 3rd CatClass instance; see what happens

print( "\n" )

-- Since all cat objects are of the class "CatClass", they inherit all
-- public class methods such as meow() and purr() (as well as public properties).
black_cat1:meow()
black_cat2:meow()
black_cat3:meow()

print( "\n" )

black_cat1:purr()
black_cat2:purr()
black_cat3:purr()

-- NOTE: Be sure to see the terminal output!