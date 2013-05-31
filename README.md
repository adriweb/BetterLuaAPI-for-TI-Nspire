# BetterLuaAPI for TI-Nspire.

### Made by Adrien "Adriweb" Bertrand.
### Thanks to Jim Bauwens, John Powers, Levak

## How to use :
Copy in your code the functions you want and start using them, that's all ! :-)
Please also write in your code/readme something like "[a part of] BetterLuaAPI by Adriweb was used"...
Since this is all written in Nspire-Lua, it requires you to run the OS any OS 3.x on your calculator. 
The latest OS updates are available on [TI's Website](http://education.ti.com).

## New functions/things brought by BetterLuaAPI :
* __device__ table : informations about the user's device (apiversion ? , hasColor ? , isCalc ? , type of calc ? , current language ? )-
* __Colors table__ (can be used for _setColor_)
* __copyTable(table)__ (copies a table into another)
* __deepcopy(table)__ (deep-copies a table into another)
* __test(arg)__ (returns 1 if _arg_ true or 0 if _arg_ false)
* __screenRefresh()__ same as _platform.window:invalidate()_ but shorter
* __pww()__ same as _platform.window:width()_ but shorter
* __pwh()__ same as _platform.window:height()_ but shorter
* __gc:drawPoint(x, y)__ 
* __gc:drawCircle(x, y, diameter)__ 
* __gc:drawCenteredString(str)__ 
* __gc:drawXCenteredString(str,y)__ 
* __gc:setColor(theColor)__ (string or table of RGB)
* __gc:verticalBar(x)__ 
* __gc:horizontalBar(y)__ 
* __gc:drawSquare(x,y,l)__ 
* __gc:drawRoundRect(x,y,width,height,radius)__ 
* __gc:fillRoundRect(x,y,wd,ht,radius)__ 
* __gc:clearWindow(theColor)__ 


## Notes :
More information about Lua programming on the TI-Nspire : [Inspired-Lua](http://www.inspired-lua.org) and TI Calculators in general : [TI-Planet.org](http://tiplanet.org)


__Contact : adrienbertrand @ msn . com__
