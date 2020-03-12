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

--local song = audio.loadSound("sounds/song.mp3")

--make the sound play
--audio.play( song, {duration=1000000} )

-------------------------------------------------------------------------------
--MICKEY CREATION
-------------------------------------------------------------------------------


-- charecter image of mickey
local mickey = display.newImageRect("Images/mickey.png", 200, 200)

--set the image to be transparent
mickey.alpha = 0

--set the position on the ipad
mickey.x = 0
mickey.y = display.contentHeight*8.69/10

--Funtion: MoveMickey
--Input: this function accepts an event listner
--Output: none
--Description: this function ads the scroll speed to the x-value of the chocolate
local function MoveMickey( event )
	--add the scroll speed to the x-value of the chocolate
	mickey.x = mickey.x + scrollspeed
	--change the transparency of the chocolate, so that it fades out
	mickey.alpha = mickey.alpha + 0.05

end

--MoveHunny will be called over and over
Runtime:addEventListener("enterFrame", MoveMickey)

----------------------------------------------------------------------------------
--MINNIE CREATION
----------------------------------------------------------------------------------


--add in second charecter image
local minnie = display.newImageRect("Images/minnie.png", 200, 200)

--set the image to be transparent
minnie.alpha = 0

--set her place on the screen 
minnie.x = 0
minnie.y = display.contentHeight*8/10


--Funtion: MoveMinnie
--Input: this function accepts an event listner
--Output: none
--Description: this function ads the scroll speed to the x-value of minnie
local function MoveMinnie( event )
	--add the scroll speed to the x-value of eeyore
	minnie.x = minnie.y + scrollspeed
	--change the transparency of eeyore, so that it fades out
	minnie.alpha = minnie.alpha + 0.09

end

--MoveMinnie will be called over and over again
Runtime:addEventListener("enterframe", MoveMinnie)

------------------------------------------------------------------------------------------
--DISPLAYING text
------------------------------------------------------------------------------------------

--display new text 
local textObject = display.newText( "Welcome to the Club House!", 500, 500, nil, 50)

--set the colour of the text 
textObject:setTextColor(1, 1, 1)

------------------------------------------------------------------------------------------
--DAISY DUCK CREATION
------------------------------------------------------------------------------------------

--display daisy duck
local daisy = display.newImageRect("Images/daisy.png", 200, 200)

--set the place on the screen
daisy.x = 0
daisy.y = display.contentHeight/2


--Funtion: MoveDaisy
--Input: this function accepts an event listner
--Output: none
--Description: this function ads the scroll speed to the x-value of minnie
local function MoveDaisy( event )
	--add the scroll speed to the x-value of eeyore
	daisy.x = daisy.y + scrollspeed

end

------------------------------------------------------------------------------------------
--DONALD DUCK CREATION
------------------------------------------------------------------------------------------

local donald = display.newImageRect("Images/donald.png", 200, 200)