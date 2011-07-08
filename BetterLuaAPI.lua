-- BetterLuaAPI for TI-Nspire
-- Adriweb 2011
-- Put all this or some of this (be careful, though, some functions use each other) in your code and thank me ;)

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

function screenRefresh()
	platform.window:invalidate()
end

function pww()
	return platform.window:width()
end

function pwh()
	return platform.window:height()
end

function drawPoint(x, y)
	platform.gc():fillRect(x, y, 1, 1)
end

function drawCircle(x, y, diameter)
	platform.gc():drawArc(x - diameter/2, y - diameter/2, diameter,diameter,0,360)
end

function drawCenteredString(str)
	platform.gc():drawString(str, (pww() - platform.gc():getStringWidth(str)) / 2, pwh() / 2, "middle")
end

function setColor(theColor)
	theColor = string.lower(theColor)
	platform.gc():setColorRGB(0,0,0) -- set black as default is nothing else valid is found
	if theColor == "blue" then platform.gc():setColorRGB(0,0,255)
	elseif theColor == "brown" then platform.gc():setColorRGB(165,42,42)
	elseif theColor == "cyan" then platform.gc():setColorRGB(0,255,255)
	elseif theColor == "darkblue" then platform.gc():setColorRGB(0,0,139)
	elseif theColor == "darkred" then platform.gc():setColorRGB(139,0,0)
	elseif theColor == "fuchsia" then platform.gc():setColorRGB(255,0,255)
	elseif theColor == "gold" then platform.gc():setColorRGB(255,215,0)
	elseif theColor == "gray" or theColor == "grey" then platform.gc():setColorRGB(127,127,127)
	elseif theColor == "green" then platform.gc():setColorRGB(0,128,0)
	elseif theColor == "lightblue" then platform.gc():setColorRGB(173,216,230)
	elseif theColor == "lightgreen" then platform.gc():setColorRGB(144,238,144)
	elseif theColor == "magenta" then platform.gc():setColorRGB(255,0,255)
	elseif theColor == "maroon" then platform.gc():setColorRGB(128,0,0)
	elseif theColor == "navyblue" then platform.gc():setColorRGB(159,175,223)
	elseif theColor == "orange" then platform.gc():setColorRGB(255,165,0)
	elseif theColor == "palegreen" then platform.gc():setColorRGB(152,251,152)
	elseif theColor == "pink" then platform.gc():setColorRGB(255,192,203)
	elseif theColor == "purple" then platform.gc():setColorRGB(128,0,128)
	elseif theColor == "red" then platform.gc():setColorRGB(255,0,0)
	elseif theColor == "royalblue" then platform.gc():setColorRGB(65,105,225)
	elseif theColor == "salmon" then platform.gc():setColorRGB(250,128,114)
	elseif theColor == "seagreen" then platform.gc():setColorRGB(46,139,87)
	elseif theColor == "silver" then platform.gc():setColorRGB(192,192,192)
	elseif theColor == "turquoise" then platform.gc():setColorRGB(64,224,208)
	elseif theColor == "violet" then platform.gc():setColorRGB(238,130,238)
	elseif theColor == "white" then platform.gc():setColorRGB(255,255,255)
	elseif theColor == "yellow" then platform.gc():setColorRGB(255,255,0)
	end	
end

function verticalBar(x)
	platform.gc():drawLine(x,1,x,platform.window:height())
end

function horizontalBar(y)
	platform.gc():drawLine(1,y,platform.window:width(),y)
end

function drawSquare(x,y,l)
	platform.gc():drawPolyLine({(x-l/2),(y-l/2), (x+l/2),(y-l/2), (x+l/2),(y+l/2), (x-l/2),(y+l/2), (x-l/2),(y-l/2)})
end

function drawRoundRect(x,y,width,height,radius)
	x = x-width/2  -- let the center of the square be the origin (x coord)
	y = y-height/2 -- same for y coord
	if radius > height/2 then radius = height/2 end -- avoid drawing cool but unexpected shapes. This will draw a circle (max radius)
	platform.gc():drawLine(x + radius, y, x + width - (radius), y);
	platform.gc():drawArc(x + width - (radius*2), y + height - (radius*2), radius*2, radius*2, 270, 90);
	platform.gc():drawLine(x + width, y + radius, x + width, y + height - (radius));
	platform.gc():drawArc(x + width - (radius*2), y, radius*2, radius*2,0,90);
	platform.gc():drawLine(x + width - (radius), y + height, x + radius, y + height);
	platform.gc():drawArc(x, y, radius*2, radius*2, 90, 90);
	platform.gc():drawLine(x, y + height - (radius), x, y + radius);
	platform.gc():drawArc(x, y + height - (radius*2), radius*2, radius*2, 180, 90);
end

function fillRoundRect(x,y,wd,ht,radius)  -- wd = width and ht = height -- renders badly when transparency (alpha) is not at maximum >< will re-code later
	if radius > ht/2 then radius = ht/2 end -- avoid drawing cool but unexpected shapes. This will draw a circle (max radius)
    platform.gc():fillPolygon({(x-wd/2),(y-ht/2+radius), (x+wd/2),(y-ht/2+radius), (x+wd/2),(y+ht/2-radius), (x-wd/2),(y+ht/2-radius), (x-wd/2),(y-ht/2+radius)})
    platform.gc():fillPolygon({(x-wd/2-radius+1),(y-ht/2), (x+wd/2-radius+1),(y-ht/2), (x+wd/2-radius+1),(y+ht/2), (x-wd/2+radius),(y+ht/2), (x-wd/2+radius),(y-ht/2)})
    x = x-wd/2  -- let the center of the square be the origin (x coord)
	y = y-ht/2 -- same
	platform.gc():fillArc(x + wd - (radius*2), y + ht - (radius*2), radius*2, radius*2, 1, -91);
    platform.gc():fillArc(x + wd - (radius*2), y, radius*2, radius*2,-2,91);
    platform.gc():fillArc(x, y, radius*2, radius*2, 85, 95);
    platform.gc():fillArc(x, y + ht - (radius*2), radius*2, radius*2, 180, 95);
end

function drawLinearGradient(r1,g1,b1,r2,g2,b2)
 	-- not sure if it's a good idea...
end

function on.paint(gc)
	setColor("red")
	drawPoint(50,50)
	drawCircle(150,50,20)
	drawSquare(200,60,30)
	drawCenteredString("hello world - Adriweb here \\o/")
	drawRoundRect(200,160,51,51,10)
	fillRoundRect(100,160,100,75,20)
	verticalBar(20)
	horizontalBar(40)
--	screenRefresh()
--  fillScreen("color") - TODO
end


---------------  End of BetterLuaAPI
