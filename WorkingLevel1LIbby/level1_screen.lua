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
local tigger
local giraffe
local score = 0

local varDirection
local start_x
local pickAnimal
scrollspeed = 6

-----------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------

--[[local function PopUpMonkey()
    -- make a monkey apear when the user reaches 20 points 
    if (score == 20) then
      monkey.isVisible = true  
    end    
end

local function Question( event )
    -- when the user touches a monkey a question screen will apear
    if (event.phase == "began") then 
        composer.gotoScene( "monkeyQuestion" )
    end
end
-- ]]

local function RunAwayGiraffe()
    giraffe.x = giraffe.x - scrollspeed
end

local function RunAway()
    tigger.x = tigger.x + scrollspeed
end

-- this function makes the tigger appear in a random (x, y) position on the screen
-- before calling the hide function
local function PopUp()

    -- choosing random position on the screen beween 0 and the size of the screen
    tigger.x = math.random(0, display.contentWidth )
    tigger.y = 550

    -- make the tigger visible
    tigger.isVisible = true

    -- set tigger's varDirection
    if (tigger.x > display.contentWidth/2) then
        scrollspeed = -6
    else
        scrollspeed = 6
    end

    -- make the tigger run away
    Runtime:addEventListener("enterFrame", RunAway)
    timer.performWithDelay(2000, GoAway)
end

-- this function makes the tigger appear in a random (x, y) position on the screen
-- before calling the hide function
local function PopUpGiraffe()
    print 'PopUpGiraffe called'
    -- choosing random position on the screen beween 0 and the size of the screen
    giraffe.x = math.random(0, display.contentWidth)
    giraffe.y = 550

    -- make the giraffe visible
    giraffe.isVisible = true

    -- set giraffe's varDirection
    if (giraffe.x > display.contentWidth/2) then
        scrollspeed = -6
    else
        scrollspeed = 6
    end

    -- make the tigger run away
    Runtime:addEventListener("enterFrame", RunAwayGiraffe)
    timer.performWithDelay(2000, GoAway)
end

-- this function calls the PopuP function after 3 seconds
local function PopUpDelay()
    pickAnimal = math.random(1,2)
    if pickAnimal == 1 then
        timer.performWithDelay(1000, PopUp) 
        print 'Pick : tigger'
    elseif pickAnimal == 2 then
        timer.performWithDelay(1000, PopUpGiraffe)
        print 'Pick : giraffe'
    end
    -- PopUpMonkey()
end

-- this function makes the tigger invisible and then calls the PopUPDelay function
function GoAway()
    -- change visibility
    tigger.isVisible = false
    giraffe.isVisible = false 
    -- remove the listener
    Runtime:removeEventListener("enterFrame", RunAway)
    Runtime:removeEventListener("enterFrame", RunAwayGiraffe)
    -- CALL THE POPUPDELAY FUNCTION.
    PopUpDelay()
end


-- this funtion increments the score only if the tigger is clicked. It then displays the new score 
function Whacked ( event )
    -- if touched  phase just started 
    if (event.phase == "began") then
        -- INCREASE SCORE BY 1.
        score = score + 5
        if (score >= 20) then 
            composer.gotoScene( "youWin")
        end
        -- THEN DISPLAY THE SCORE IN THE TEXT OBJECT.
        scoreObject.text = "score = " .. score  
    end 
end

-- this function starts the game 
function GameStart()
    PopUpDelay()
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

  -- Insert the background image
    local bkg_image = display.newImageRect("PhotoShop/level1.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentWidth / 2 
    bkg_image.y = display.contentHeight / 2

    -- Insert background image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( bkg_image ) 

    monkey = display.newImage("Images/monkey1.png", 0, 0)    
    monkey.x = 750
    monkey.y = 300
    monkey:scale (.4, .4)
    monkey.isVisible = false 
    sceneGroup:insert( monkey )

    giraffe = display.newImage("Images/giraffe.png", 0, 0)    
    giraffe.x = 1890
    giraffe.y = 490
    -- giraffe:scale (.4, .4)
    giraffe.isVisible = false   
    sceneGroup:insert( giraffe )

    -- creating the tigger 
    tigger = display.newImage( "Images/tigger.png", 0, 0)
    -- setting Position 
    --tigger.x = display.contentCentreX
    --tigger.y = display.contentCentreY
    tigger.x = 1790
    tigger.y = 550

    tigger:scale (.5, .5)
    tigger.isVisible = true 
    sceneGroup:insert( tigger )
    -- add local text to display the score 
    scoreObject = display.newText("score " .. score , 512, 100, nil, 40)
    scoreObject:setTextColor(0, 0, 0)  
    sceneGroup:insert( scoreObject )

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
        tigger:addEventListener("touch", Whacked )
        -- tigger:addEventListener("touch", Question )
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
