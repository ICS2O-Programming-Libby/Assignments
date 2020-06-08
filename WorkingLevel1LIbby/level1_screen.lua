-----------------------------------------------------------------------------------------
--
-- level1_screen.lua
-- Created by: Your Name
-- Date: Month Day, Year
-- Description: This is the level 1 screen of the game.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level1_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- The local variables for this scene
local bkg_image
local monkey
local score = 0

-----------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------


-- this function makes the monkey appear in a random (x, y) position on the screen 
-- before calling the hide function 
function PopUp()

    -- choosing random position on the screen beween 0 and the size of the screen 
    monkey.x = math.random(0, display.contentWidth )
    monkey.y = math.random(0, display.contentHeight )

    -- make the monkey visible 
    monkey.isVisible = true 
    timer.performWithDelay(1500, GoAway)  
end 

-- this function calls the PopuP function after 3 seconds
function PopUpDelay()
    timer.performWithDelay(3000, PopUp)
end

-- this function makes the monkey invisible and then calls the PopUPDelay function 
function GoAway()
    -- change visibility 
    monkey.isVisible = false 
    -- CALL THE POPUPDELAY FUNCTION.
    PopUpDelay()
end

-- this function starts the game 
function GameStart()
    PopUpDelay()
end

-- this funtion increments the score only if the monkey is clicked. It then displays the new score 
function Whacked ( event )
    -- if touched  phase just started 
    if (event.phase == "began") then
        -- INCREASE SCORE BY 1.
        score = score + 1
        -- THEN DISPLAY THE SCORE IN THE TEXT OBJECT.
        scoreObject.text = "score = " .. score  
    end 
end
-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

  -- Creating Background 
  -- local bkg = display.newRect( 0, 0, display.contentWidth, display.ocntentHeight )
  -- set the background colour
  display.setDefault("background", 234/255, 226/255, 226/255)  

  -- creating the monkey 
  monkey = display.newImage( "Images/monkey.png", 0, 0)
  -- setting Position 
  monkey.x = display.contentCentreX
  monkey.y = display.contentCentreY

  monkey:scale (.5, .5)
  monkey.isVisible = true 
  -- add local text to display the score 
  scoreObject = display.newText("score " .. score , 512, 100, nil, 40)
  scoreObject:setTextColor(0, 0, 0)  

end --function scene:create( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then

        -- Called when the scene is still off screen (but is about to come on screen).
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then

        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
        GameStart()
        monkey:addEventListener("touch", Whacked )
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.

end -- function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
