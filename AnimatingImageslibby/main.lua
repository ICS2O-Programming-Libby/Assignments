-- Title: AnimatingImages
-- Name: Libby Valentino 
-- Course: ICS2O/3C
-- This program displays three diffrent moving images.
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

--add the global variable for speed
scrollspeed = 5

-- set the backround
local backgroundImage = display.newImageRect("Images/forest.jpg", 1024, 768)
backgroundImage.x = display.contentCenterX
backgroundImage.y = display.contentCenterY


-- display winnie with no honey
local PoohWithNoHoney = display.newImageRect("Images/.png", 924, 365)

-- charecter image of tigger
local tigger = display.newImageRect("Images/tigger.png", 200, 200)

--set the image to be transparent
tigger.alpha = 0

--set the position on the ipad
tigger.x = 0
tigger.y = display.contentHeight/2

--Funtion: MoveTigger
--Input: this function accepts an event listner
--Output: none
--Description: this function ads the scroll speed to the x-value of the chocolate
local function MoveTigger( event )
	--add the scroll speed to the x-value of the chocolate
	tigger.x = tigger.x + scrollspeed
	--change the transparency of the chocolate, so that it fades out
	tigger.alpha = tigger.alpha + 0.056

end

--MoveHunny will be called over and over
Runtime:addEventListener("enterFrame", MoveTigger)

--add in second charecter image
local eeyore = display.newImageRect("Images/minnie.png", 200, 200)

--set the image to be transparent
eeyore.alpha = 0

--set his place on the screen 
eeyore.x = 0
eeyore.y = 0


--Funtion: MoveEeyore
--Input: this function accepts an event listner
--Output: none
--Description: this function ads the scroll speed to the x-value of eeyore
local function MoveEeyore( event )
	--add the scroll speed to the x-value of eeyore
	eeyore.x = eeyore.y + scrollspeed
	--change the transparency of eeyore, so that it fades out
	eeyore.alpha = eeyore.alpha + 0.007

end

--MoveEeyore will be called over and over again
Runtime:addEventListener("enterframe", MoveEeyore)
