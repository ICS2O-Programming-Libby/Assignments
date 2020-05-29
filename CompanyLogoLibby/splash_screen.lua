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
local jungleSounds = audio.loadSound("Sounds/animals144.mp3")
local jungleSoundsChannel

local background

-- create the global for scroll speed 
scrollspeed = 5

--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------

-- The function that moves the robot across the screen
--local function moverobot()
    --robot.x = robot.x + scrollXSpeed
    --robot.y = robot.y + scrollYSpeed
--end

-- internal function to calculate where on 'x' is the object
-- send a value on every calcuation
--[[local function CalculateLine( x )
    local yValue = (x-550)*(x-100)*(x+900)/100000 + 550
    --print(yValue)
    return yValue
end ]]



-- MAKE THE TURTLE SPIN IN A STRAIGHT LINE 
local function Spin( event )
    robot.x = robot.x + scrollspeed 

    -- set how fast robot rotates
    robot:rotate(2)
    --change the transparency of robot, so that he fades in
    --robot.alpha = robot.alpha + 0.03

    -- Go to the main menu screen after the given time.
    -- timer.performWithDelay ( 1500 )
end

local function Left( event )
    logo.x = logo.x - scrollspeed

    -- Go to the main menu screen after the given time.
    -- timer.performWithDelay ( 1500 )   

end

local function Up ( event)
    controller.y = controller.y - scrollspeed

    -- make it fade out
    -- controller.alpha = controller.alpha - 0.03
    -- Go to the main menu screen after the given time.
    -- timer.performWithDelay ( 1500 )
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
    robot = display.newImageRect("Images 2/robot.png", 275, 275)

    -- set the initial x and y position of the robot
    robot.x = display.contentWidth/2
    robot.y = display.contentHeight/4

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( robot )

    -- Insert the logo image
    logo = display.newImageRect("Images 2/logo.png", 800, 100)

    -- set the initial x and y position of the logo 
    logo.x = display.contentWidth/2
    logo.y = display.contentHeight/2

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( logo )

    -- Insert the logo image
    controller = display.newImageRect("Images 2/controller.png", 100, 100)

    -- make it visible at first 
    -- controller.alpha = 1

    -- set the initial x and y position of the logo 
    controller.x = 700
    controller.y = display.contentHeight

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
        Runtime:addEventListener("enterFrame", Spin)
        -- Call the Left function as soon as we entre the frame.
        Runtime:addEventListener("enterFrame", Left)
        -- Call the Up function as soon as we entre the frame.
        Runtime:addEventListener("enterFrame", Up)


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
