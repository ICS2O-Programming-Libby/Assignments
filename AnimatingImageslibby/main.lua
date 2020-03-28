-- Title: AnimatingImages
-- Name: Libby Valentino 
-- Course: ICS2O/3C
-- This program displays diffrent moving images.
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

--add the global variable for speed
scrollspeed = 5

-- set the backround
local backgroundImage = display.newImageRect("Images/forest.jpg", 1024, 768)
backgroundImage.x = display.contentCenterX
backgroundImage.y = display.contentCenterY


-----------------------------------------------------------------------------
--SOUND CREATION
-----------------------------------------------------------------------------

local song = audio.loadSound("sounds/song.mp3")

--make the sound play
audio.play( song, {duration=1000000} )

----------------------------------------------------------------------------------
--MINNIE CREATION
----------------------------------------------------------------------------------


--add in second charecter image
local daisy = display.newImageRect("Images/daisy.png", 100, 100)

--set her place on the screen 
daisy.x = 1024
daisy.y = display.contentHeight*2/3

--set the direction 
local MovingLeft = 1

--display new text 
local textObject = display.newText( "Welcome to the Club House!", 550,550,nil, 50)
textObject:setTextColor(1, 1, 1)

--Funtion: MOveDaisy
--Input: this function accepts an event 
--Output: none
--Description: this function ads the scroll speed to the x-value of daisy
local function MoveDaisy( event )

	if (MovingLeft == 1) then 
		daisy.x = daisy.x - scrollspeed 
	else 
		daisy.x = daisy.x + scrollspeed
	end 


    --make a diffrent text appear 
	if (daisy.x < 0) then 
		MovingLeft = 0 
		-- change the text  colours
		textObject.text="thanks for coming"
		textObject:setTextColor(1, 1, 1)
	end 

	if (daisy.x > 1024) then 
		MovingLeft = 1
		-- change the text colours
		textObject.text="Nice to meet you!"
		textObject:setTextColor(0, 0, 0)
	end
end

--MoveDaisy will be called over and over again
Runtime:addEventListener("enterFrame", MoveDaisy)


----------------------------------------------------------
--CREATE PLUTO 
----------------------------------------------------------

-- add pluto
local pluto = display.newImageRect("Images/pluto.png", 100, 100)

-- set where the object starts
pluto.x = display.contentHeight*2/3
pluto.y = 1024

--set pluto to start transparent
pluto.alpha = 0

-- internal function to calculate where on 'x' is the object
-- send a value on every calcuation
local function CalculateLine( x )
	local yValue = (x-550)*(x-100)*(x+900)/100000 + 550
	--print(yValue)
	return yValue
end	

--make pluto spin 
local function SpinPluto( event )
	pluto.x = pluto.x - scrollspeed + 2
	-- call the function 'Calculateline'
	pluto.y = CalculateLine(pluto.x)
	--print ("Y is : " .. pluto.y)

	-- set how fast pluto rotates
	pluto:rotate(7)
    	--change the transparency of pluto, so that he fades in
	pluto.alpha = pluto.alpha + 0.03
end

--call the function over and over
Runtime: addEventListener("enterFrame", SpinPluto)



---------------------------------------------------------------------------
--CREATE MINNIE MOUSE
---------------------------------------------------------------------------

--add in minnie charecter image
local minnie = display.newImageRect("Images/minnie1.png", 100, 100)

--set her place on the screen 
minnie.x = 775
minnie.y = display.contentHeight*2/3

--set the direction 
local MovingUp = 1


--Funtion: MoveMinnie
--Input: this function accepts an event 
--Output: none
--Description: this function ads the scroll speed to the x-value of minnie
local function MoveMinnie( event )

	if (MovingUp == 1) then 
		minnie.y = minnie.y - scrollspeed 
	else 
		minnie.y = minnie.y + scrollspeed
	end 

	if (minnie.y < 0) then 
		MovingUp = 0 

	end 

	if (minnie.y > 1024) then 
		MovingUp = 1
	end
end

--MoveMinnie will be called over and over again
Runtime:addEventListener("enterFrame", MoveMinnie)

------------------------------------------------------------------------------
-- CREATE SQUARE PATH 
------------------------------------------------------------------------------

-- crreate the quardinates for each stop on the path 
local movePath = {x=100, y=100}
movePath[1] = { x=700, y=100 }
movePath[2] = { x=700, y=700 }
movePath[3] = { x=100, y=700, time=500 }
movePath[4] = { x=100, y=100, time=500, easingMethod=easing.outQuad }


local function distBetween( x1, y1, x2, y2 )
	local xFactor = x2 - x1
	local yFactor = y2 - y1
	local dist = math.sqrt((xFactor*xFactor) + (yFactor*yFactor))
	return dist
end

-- Display the image of the charecter
local circle1 = display.newImageRect("Images/mickey.png", 100, 100)
circle1.x = 100
circle1.y = 100

--Funtion: SetPath
--Description: this function makes the charecter move aong a square path
local function setPath( object, path, params )

    -- create the variables 
	local delta = params.useDelta or nil
	local deltaX = 0
	local deltaY = 0
	local constant = params.constantTime or nil
	local ease = params.easingMethod or easing.linear
	local tag = params.tag or nil
	local delay = params.delay or 0
	local speedFactor = 1

	if ( delta and delta == true ) then
		deltaX = object.x
		deltaY = object.y
	end

	if ( constant ) then
		local dist = distBetween( object.x, object.y, deltaX+path[1].x, deltaY+path[1].y )
		speedFactor = constant/dist
	end

	for i = 1,#path do

		local segmentTime = 500

		--if "constant" is defined, refactor transition time based on distance between points
		if ( constant ) then
			local dist
			if ( i == 1 ) then
				dist = distBetween( object.x, object.y, deltaX+path[i].x, deltaY+path[i].y )
			else
				dist = distBetween( path[i-1].x, path[i-1].y, path[i].x, path[i].y )
			end
			segmentTime = dist*speedFactor
		else
			--if this path segment has a custom time, use it
			if ( path[i].time ) then segmentTime = path[i].time end
		end


		transition.to( object, { tag=tag, time=segmentTime, x=deltaX+path[i].x, y=deltaY+path[i].y, delay=delay, transition=ease } )
		delay = delay + segmentTime
	end
end

-- call the function once 
setPath( circle1, movePath, { useDelta=false, constantTime=1200, easingMethod=easing.inOutQuad, delay=200, tag="moveObject" } )
--setPath( circle2, movePath, { useDelta=true, constantTime=1200, easingMethod=easing.inOutQuad, tag="moveObject" } )