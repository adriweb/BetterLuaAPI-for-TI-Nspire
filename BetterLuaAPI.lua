-- BetterLuaAPI for TI-Nspire
-- Adriweb 2011
-- Put all this in your code and thank me ;)

function drawPoint(x, y)
	platform.gc():setPen("thin", "smooth")
	platform.gc():drawLine(x, y, x, y)
end

function drawCircle(x, y, diameter)
	platform.gc():drawArc(x - diameter/2, y - diameter/2, diameter,diameter,0,360)
end

function drawCenteredString(str)
	platform.gc():drawString(str, (platform.window:width() - platform.gc():getStringWidth(str)) / 2, platform.window:height() / 2, "middle")
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
	elseif theColor == "gray" then platform.gc():setColorRGB(127,127,127)
	elseif theColor == "green" then platform.gc():setColorRGB(0,128,0)
	elseif theColor == "lightblue" then platform.gc():setColorRGB(173,216,230)
	elseif theColor == "lightcyan" then platform.gc():setColorRGB(224,255,255)
	elseif theColor == "lightgreen" then platform.gc():setColorRGB(144,238,144)
	elseif theColor == "lightgrey" then platform.gc():setColorRGB(211,211,211)
	elseif theColor == "lightpink" then platform.gc():setColorRGB(255,182,193)
	elseif theColor == "lightseagreen" then platform.gc():setColorRGB(32,178,170)
	elseif theColor == "lightyellow" then platform.gc():setColorRGB(255,255,224)
	elseif theColor == "magenta" then platform.gc():setColorRGB(255,0,255)
	elseif theColor == "maroon" then platform.gc():setColorRGB(128,0,0)
	elseif theColor == "navyblue" then platform.gc():setColorRGB(159,175,223)
	elseif theColor == "orange" then platform.gc():setColorRGB(255,165,0)
	elseif theColor == "palegreen" then platform.gc():setColorRGB(152,251,152)
	elseif theColor == "paleturquoise" then platform.gc():setColorRGB(175,238,238)
	elseif theColor == "palevioletred" then platform.gc():setColorRGB(219,112,147)
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

function drawLinearGradient(r1,g1,b1,r2,g2,b2)
 	-- not sure if it's a good idea...
end

function on.paint(gc)

	setColor("red")
	drawPoint(50,50)
	drawCircle(50,50,20)
	drawSquare(100,120,30)
	drawCenteredString("hello world")
	drawCenteredString("\n  Adriweb here \\o/")
	drawRoundRect(200,160,50,50,10)
	verticalBar(20)
	horizontalBar(40)
	

end
