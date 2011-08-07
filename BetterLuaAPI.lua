-- BetterLuaAPI for TI-Nspire
-- Version 2.1 (Aug 7th 2011)
-- Adriweb 2011 -- Thanks to Jim Bauwens and Levak
-- adrienbertrand@msn.com
-- Put all this or some of this (be careful, though, some functions use each other) in your code and thank me ;)
-- Remember to put "myGC = gc" in the  on.paint(gc)  function.

screenRefresh = platform.window:invalidate()

Color = {
	["black"] = {0, 0, 0},
	["red"] = {0xff, 0, 0},
	["green"] = {0, 0xff, 0},
	["blue "] = {0, 0, 0xff},
	["white"] = {0xff, 0xff, 0xff},
	["brown"] = {165,42,42},
	["cyan"] = {0,255,255},
	["darkblue"] = {0,0,139},
	["darkred"] = {139,0,0},
	["fuchsia"] = {255,0,255},
	["gold"] = {255,215,0},
	["gray"] = {127,127,127},
	["grey"] = {127,127,127},
	["lightblue"] = {173,216,230},
	["lightgreen"] = {144,238,144},
	["magenta"] = {255,0,255},
	["maroon"] = {128,0,0},
	["navyblue"] = {159,175,223},
	["orange"] = {255,165,0},
	["palegreen"] = {152,251,152},
	["pink"] = {255,192,203},
	["purple"] = {128,0,128},
	["royalblue"] = {65,105,225},
	["salmon"] = {250,128,114},
	["seagreen"] = {46,139,87},
	["silver"] = {192,192,192},
	["turquoise"] = {64,224,208},
	["violet"] = {238,130,238},
	["yellow"] = {255,255,0}
}
Color.mt = {__index = function () return {0,0,0} end}
setmetatable(Color,Color.mt)

function copyTable(t)
  local t2 = {}
  for k,v in pairs(t) do
    t2[k] = v
  end
  return t2
end

function deepcopy(t) -- This function recursively copies a table's contents, and ensures that metatables are preserved. That is, it will correctly clone a pure Lua object.
	if type(t) ~= 'table' then return t end
	local mt = getmetatable(t)
	local res = {}
	for k,v in pairs(t) do
		if type(v) == 'table' then
		v = deepcopy(v)
		end
	res[k] = v
	end
	setmetatable(res,mt)
	return res
end -- from http://snippets.luacode.org/snippets/Deep_copy_of_a_Lua_Table_2

function test(arg)
	if type(arg) == "boolean" then
		if arg == true then
			return 1
		elseif arg == false then
			return 0
		end
	else
		print("error in test - not bool")
	end
end

function pww()
	return platform.window:width()
end

function pwh()
	return platform.window:height()
end

function drawPoint(x, y)
	myGC:fillRect(x, y, 1, 1)
end

function drawCircle(x, y, diameter)
	myGC:drawArc(x - diameter/2, y - diameter/2, diameter,diameter,0,360)
end

function drawCenteredString(str)
	myGC:drawString(str, (pww() - myGC:getStringWidth(str)) / 2, pwh() / 2, "middle")
end

function setColor(theColor)
	if type(theColor) == "string" then
		theColor = string.lower(theColor)
		if type(Color[theColor]) == "table" then myGC:setColorRGB(unpack(Color[theColor])) end
	elseif type(theColor) == "table" then
		myGC:setColorRGB(unpack(theColor))
	end
end

function verticalBar(x)
	myGC:fillRect(x,0,1,platform.window:height())
end

function horizontalBar(y)
	myGC:fillRect(0,y,platform.window:width(),1)
end

function drawSquare(x,y,l)
	myGC:drawPolyLine({(x-l/2),(y-l/2), (x+l/2),(y-l/2), (x+l/2),(y+l/2), (x-l/2),(y+l/2), (x-l/2),(y-l/2)})
end

function drawRoundRect(x,y,width,height,radius)
	x = x-width/2  -- let the center of the square be the origin (x coord)
	y = y-height/2 -- same for y coord
	if radius > height/2 then radius = height/2 end -- avoid drawing cool but unexpected shapes. This will draw a circle (max radius)
	myGC:drawLine(x + radius, y, x + width - (radius), y);
	myGC:drawArc(x + width - (radius*2), y + height - (radius*2), radius*2, radius*2, 270, 90);
	myGC:drawLine(x + width, y + radius, x + width, y + height - (radius));
	myGC:drawArc(x + width - (radius*2), y, radius*2, radius*2,0,90);
	myGC:drawLine(x + width - (radius), y + height, x + radius, y + height);
	myGC:drawArc(x, y, radius*2, radius*2, 90, 90);
	myGC:drawLine(x, y + height - (radius), x, y + radius);
	myGC:drawArc(x, y + height - (radius*2), radius*2, radius*2, 180, 90);
end

function fillRoundRect(x,y,wd,ht,radius)  -- wd = width and ht = height -- renders badly when transparency (alpha) is not at maximum >< will re-code later
	if radius > ht/2 then radius = ht/2 end -- avoid drawing cool but unexpected shapes. This will draw a circle (max radius)
    myGC:fillPolygon({(x-wd/2),(y-ht/2+radius), (x+wd/2),(y-ht/2+radius), (x+wd/2),(y+ht/2-radius), (x-wd/2),(y+ht/2-radius), (x-wd/2),(y-ht/2+radius)})
    myGC:fillPolygon({(x-wd/2-radius+1),(y-ht/2), (x+wd/2-radius+1),(y-ht/2), (x+wd/2-radius+1),(y+ht/2), (x-wd/2+radius),(y+ht/2), (x-wd/2+radius),(y-ht/2)})
    x = x-wd/2  -- let the center of the square be the origin (x coord)
	y = y-ht/2 -- same
	myGC:fillArc(x + wd - (radius*2), y + ht - (radius*2), radius*2, radius*2, 1, -91);
    myGC:fillArc(x + wd - (radius*2), y, radius*2, radius*2,-2,91);
    myGC:fillArc(x, y, radius*2, radius*2, 85, 95);
    myGC:fillArc(x, y + ht - (radius*2), radius*2, radius*2, 180, 95);
end

function drawLinearGradient(color1,color2)
	-- syntax would be : color1 and color2: {r,g,b} 
 	-- not sure if it's a good idea...
 	-- todo with unpack(color1) and unpack(color2)
end

function clearWindow(theColor)
    setColor(theColor) -- will handle both strings like "red" and direct colors like {255,0,0}
    myGC:fillRect(0, 0, platform.window:width(), platform.window:height())
end

function on.paint(gc)
	myGC = gc -- very important line !
	setColor("red") -- is the same as gc:setColorRGB(unpack(Color["red"])) or setColor({255,0,0})
	drawPoint(50,50)
	drawCircle(150,50,20)
	drawSquare(200,60,30)
	drawCenteredString("hello world - Adriweb here \\o/")
	drawRoundRect(200,160,51,51,10)
	fillRoundRect(100,160,100,75,20)
	verticalBar(20)
	horizontalBar(40)
--	screenRefresh()
--  clearWindow({0, 0, 255}) - will fill the screen with the given color. Here, blue.
end


---------------  End of BetterLuaAPI
