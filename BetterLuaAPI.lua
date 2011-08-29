-- BetterLuaAPI for TI-Nspire
-- Version 2.2 (Aug 28th 2011)
-- Adriweb 2011 -- Thanks to Jim Bauwens and Levak
-- adrienbertrand@msn.com
-- Put all this or some of this (be careful, though, some functions use each other) in your code and thank me ;)
-- Remember to put "myGC = gc" in the  on.paint(gc)  function.


device = { api, hasColor, isCalc, theType, lang }
device.api = platform.apilevel
device.hasColor = platform.isColorDisplay()
device.lang = locale.name()

-- See the use of that device table in the on.paint function

function on.create()
	on.resize()
end

function on.resize()
    device.isCalc = (platform.window:width() < 320)
    device.theType = platform.isDeviceModeRendering() and "handheld" or "software"
end


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

local function copyTable(t)
  local t2 = {}
  for k,v in pairs(t) do
    t2[k] = v
  end
  return t2
end

local function deepcopy(t) -- This function recursively copies a table's contents, and ensures that metatables are preserved. That is, it will correctly clone a pure Lua object.
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

local function test(arg)
	return arg and 1 or 0
end

local function screenRefresh()
	return platform.window:invalidate()
end

local function pww()
	return platform.window:width()
end

local function pwh()
	return platform.window:height()
end

local function drawPoint(x, y)
	myGC:fillRect(x, y, 1, 1)
end

local function drawCircle(x, y, diameter)
	myGC:drawArc(x - diameter/2, y - diameter/2, diameter,diameter,0,360)
end

local function drawCenteredString(str)
	myGC:drawString(str, (pww() - myGC:getStringWidth(str)) / 2, pwh() / 2, "middle")
end

local function drawXCenteredString(str,y)
	myGC:drawString(str, (pww() - myGC:getStringWidth(str)) / 2, y, "top")
end

local function setColor(theColor)
	if type(theColor) == "string" then
		theColor = string.lower(theColor)
		if type(Color[theColor]) == "table" then myGC:setColorRGB(unpack(Color[theColor])) end
	elseif type(theColor) == "table" then
		myGC:setColorRGB(unpack(theColor))
	end
end

local function verticalBar(x)
	myGC:fillRect(x,0,1,platform.window:height())
end

local function horizontalBar(y)
	myGC:fillRect(0,y,platform.window:width(),1)
end

local function drawSquare(x,y,l)
	myGC:drawPolyLine({(x-l/2),(y-l/2), (x+l/2),(y-l/2), (x+l/2),(y+l/2), (x-l/2),(y+l/2), (x-l/2),(y-l/2)})
end

local function drawRoundRect(x,y,wd,ht,rd)  -- wd = width, ht = height, rd = radius of the rounded corner
	x = x-wd/2  -- let the center of the square be the origin (x coord)
	y = y-ht/2 -- same for y coord
	if rd > ht/2 then rd = ht/2 end -- avoid drawing cool but unexpected shapes. This will draw a circle (max rd)
	myGC:drawLine(x + rd, y, x + wd - (rd), y);
	myGC:drawArc(x + wd - (rd*2), y + ht - (rd*2), rd*2, rd*2, 270, 90);
	myGC:drawLine(x + wd, y + rd, x + wd, y + ht - (rd));
	myGC:drawArc(x + wd - (rd*2), y, rd*2, rd*2,0,90);
	myGC:drawLine(x + wd - (rd), y + ht, x + rd, y + ht);
	myGC:drawArc(x, y, rd*2, rd*2, 90, 90);
	myGC:drawLine(x, y + ht - (rd), x, y + rd);
	myGC:drawArc(x, y + ht - (rd*2), rd*2, rd*2, 180, 90);
end

local function fillRoundRect(x,y,wd,ht,radius)  -- wd = width and ht = height -- renders badly when transparency (alpha) is not at maximum >< will re-code later
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

local function drawLinearGradient(color1,color2)
	-- syntax would be : color1 and color2 as {r,g,b}.
 	-- don't really know how to do that. probably converting to hue/saturation/light mode and change the hue.
 	-- todo with unpack(color1) and unpack(color2)
end

local function clearWindow(theColor)
    setColor(theColor) -- will handle both strings like "red" and direct colors like {255,0,0}
    myGC:fillRect(0, 0, platform.window:width(), platform.window:height())
end

function on.paint(gc)
	myGC = gc -- very important line !
	setColor("red") -- is the same as gc:setColorRGB(unpack(Color["red"])) or setColor({255,0,0})
	drawPoint(50,50)
	drawCircle(150,50,20)
	drawSquare(200,60,30)
	drawRoundRect(200,160,51,51,10)
	fillRoundRect(100,160,100,75,20)
	verticalBar(20)
	horizontalBar(40)
	setColor("black")
	local isCalcCX = device.hasColor and "a CX." or "not a CX."
	drawXCenteredString("You are on the " .. device.theType .. ", and it's " .. isCalcCX, 50)
	drawCenteredString("hello world - Centered String")
	drawXCenteredString("X-Centered String  -  Adriweb here \\o/",0.75*pwh())
--	screenRefresh()
--  clearWindow({0, 0, 255}) - will fill the screen with the given color. Here, blue.
end

---------------  End of BetterLuaAPI
