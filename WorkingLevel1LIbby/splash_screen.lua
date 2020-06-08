-----------------------------------------------------------------------------------------
--
-- splash_screen.lua
-- Created by: Your Name
-- Date: Month Day, Year
-- Description: This is the splash screen of the game. It displays the 
-- company logo that...
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-- Name the Scene
sceneName = "splash_screen"
-----------------------------------------------------------------------------------------
--SOUNDS
-----------------------------------------------------------------------------------------
local robotNoises = audio.loadSound("Sounds/robot.mp3")
local robotNoisesSoundChannel

local controllerBeeps = audio.loadSound("Sounds/beeps.mp3")
local controllerBeepsSoundChannel


-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )

----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
 
-- The local variables for this scene
local robot
local logo
local controller

local scrollXSpeed = 15
local scrollYSpeed = -3
local jungleSounds = audio.loadSound("Sounds/animals145.mp3")
local jungleSoundsChannel

local background

-- create the globals
scrollspeed = 8
gospeed = 20

--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------

-- MAKE THE TURTLE SPIN IN A STRAIGHT LINE 
local function Spin( event )
    robot.x = robot.x + scrollspeed 
    -- make the robot make noises 
    -- robotNoisesSoundChannel = audio.play(robotNoises)

    -- set how fast robot rotates
    robot:rotate(20) 

    if( robot.x == 1000) then
        robot.x = robot.x - scrollspeed
        robot:rotate(-7)
    end 
end

local function Left( event )
    logo.x = logo.x - scrollspeed 

    if logo.x == 512 then
        logo.x = logo.x + scrollspeed
    end

end

local function Up ( event )
    controller.y = controller.y - scrollspeed
    controller.alpha = controller.alpha + 0.3

    if controller.y == 400 then
        controller.y = controller.y + scrollspeed
        -- controllerBeepsSoundChannel = audio.play(controllerBeeps)
    end

    -- make it fade out
    --controller.alpha = controller.alpha - 0.03
    --controller.alpha = controller.alpha + 0.03

end 

--------------------------------------------------------------------------------------------

-- The function that will go to the main menu 
local function gotoMainMenu()
    composer.gotoScene( "main_menu" )
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- set the background to be black
    display.setDefault("background", 1, 1, 1)

    -- Insert the robot image
    robot = display.newImageRect("Images/robot.png", 275, 275)

    -- set the initial x and y position of the robot
    --robot.x = display.contentWidth/2
    --robot.x = display.contentWidth/12
    robot.x = 100
    robot.y = display.contentHeight/4

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( robot )

    logo = display.newImageRect("Images/logo.png", 800, 100)

    -- set the initial x and y position of the logo 
    --logo.x = display.contentWidth/2
    logo.x = display.contentWidth*2
    logo.y = display.contentHeight/2

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( logo )

    -- Insert the logo image
    controller = display.newImageRect("Images/controller.png", 80, 85)

    -- make it visible at first 
    controller.alpha = 0

    -- set the initial x and y position of the logo 
    controller.x = 776
    controller.y = 600

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( controller )
end -- function scene:create( event )

--------------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).
    if ( phase == "will" ) then
       
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- start the splash screen music
        jungleSoundsChannel = audio.play(jungleSounds)

        -- Call the Spin function as soon as we enter the frame.
        --Runtime:addEventListener("enterFrame", Spin)
        timer.performWithDelay(57, Spin, -1)
        controllerBeepsSoundChannel = audio.play(controllerBeeps)
        -- Call the Left function as soon as we entre the frame.
        Runtime:addEventListener("enterFrame", Left )
        --timer.performWithDelay(850, Left, -1)
        -- Call the Up function as soon as we entre the frame.
        --Runtime:addEventListener("enterFrame", Up)
        timer.performWithDelay(38, Up, -1)
        robotNoisesSoundChannel = audio.play(robotNoises)
        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 3500, gotoMainMenu)          
        
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
    if ( phase == "will" ) then  

     -----------------------------------------------------------------------------------------

     -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        
        -- stop the jungle sounds channel for this screen
        audio.stop(jungleSoundsChannel)
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
