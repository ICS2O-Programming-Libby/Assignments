-----------------------------------------------------------------------------------------
-- level2_screen.lua
-- Created by: LIbby Valentino
-- Date: Jun. 11th, 2020
-- Description: This is the level 2 screen of the game.
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------
-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )

-- load physics
local physics = require("physics")
-----------------------------------------------------------------------------------------
-- Creating Scene Object
local scene = composer.newScene( sceneName )
-- Naming Scene
sceneName = "level2_screen"
-----------------------------------------------------------------------------------------
-- LOCAL SOUNDS
-----------------------------------------------------------------------------------------

local level2Music = audio.loadSound("Sounds/level2.mp3")
local level2MusicChannel

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
local bkgImage

local wall1
local wall2

local heart1
local heart2
local heart3
local numLives = 3

local rArrow 
local uArrow
local lArrow

local muteButton 
local unmuteButton 

local motionx = 0
local SPEED = 7
-- NOT SURE I NEED THESE SO IM TEMPORARILY COMMENTING OUT 
local LINEAR_VELOCITY = -150
local GRAVITY = -2

-----------------------------------------------------------------------------------------
-- LOCAL SCENE FUNCTIONS
----------------------------------------------------------------------------------------- 

-- ARROW FUNCTIONS 

-- When right arrow is touched, move player right
local function right (touch)
    motionx = SPEED
    player.xScale = 1
end

-- When up arrow is touched, add vertical so it can jump
local function up (touch)
    if (player ~= nil) then
        player:setLinearVelocity( 0, LINEAR_VELOCITY )
        --player:setLinearVelocity( 0, 7 )
    end
end

-- When up arrow is touched, add vertical so it can jump
local function left (touch)
    motionx = -SPEED 
    player.xScale = -1
    
end

-- Move player horizontally
local function movePlayer (event)
    player.x = player.x + motionx
end
 
-- Stop player movement when no arrow is pushed
local function stop (event)
    if (event.phase =="ended") then
        motionx = 0
    end
end

local function AddArrowEventListeners()
    rArrow:addEventListener("touch", right)
    uArrow:addEventListener("touch", up)
    lArrow:addEventListener("touch", left)
end

local function RemoveArrowEventListeners()
    rArrow:removeEventListener("touch", right)
    uArrow:removeEventListener("touch", up)
    lArrow:removeEventListener("touch", left)
end

local function AddRuntimeListeners()
    Runtime:addEventListener("enterFrame", movePlayer)
    Runtime:addEventListener("touch", stop )
end

local function RemoveRuntimeListeners()
    Runtime:removeEventListener("enterFrame", movePlayer)
    Runtime:removeEventListener("touch", stop )
end
-----------------------------------------------------------------------------------------
-- MAKE THIS FOR ANY player CHOSEN BY THE USER 
-- player FUNCTIONS 
local function Replaceplayer()
    player = display.newImageRect("Images/player.png", 100, 150)
    player.x = display.contentWidth * 0.5 / 8
    player.y = 400
    -- player.width = 100
    -- player.height = 150
    player.myName = "Girl1"

    -- intialize horizontal movement of player
    motionx = 0

    -- add physics body
    physics.addBody( player, "dynamic", { density= 0, friction= 0, bounce= 0, rotation= 0 } )

    -- prevent player from being able to tip over
    player.isFixedRotation = true

    -- add back arrow listeners
    AddArrowEventListeners()

    -- add back runtime listeners
    AddRuntimeListeners()
end

----------------------------------------------------------------------------------------- 

-- PHYSICS BODIES 

local function AddPhysicsBodies()
    --adds the physics bodies to all of the objects called in this function 
    physics.addBody( wall1, "static", { density= 0, friction= 0, bounce= 0 } )
    physics.addBody( wall2, "static", { density= 0, friction= 0, bounce= 0 } )
    -- MAKE THIS ONE FOR THE player CHOSEN BY THE USER 
    -- physics.addBody( ... , "static",  {density= 0, friction= 0, bounce= 0 } )
    physics.addBody(car, "static", {density= 0, friction= 0, bounce= 0 })
end

local function RemovePhysicsBodies()
	-- takes away the physics bodies of all objects called in this function 
	physics.removeBody(wall1)
    physics.removeBody(wall2)
    -- MAKE THIS ONE FOR THE player CHOSEN BY THE UESR 
    -- physics.removeBody( ... )
    physics.removeBody(car)
end
-----------------------------------------------------------------------------------------

-- COLISION FUNCTIONS 

local function onCollision( self, event ) 
	-- ADD STUFF TO THIS FUUNCTION 
end


local function AddCollisionListeners()
	-- adds all of the colision listners of everything called in this function 
	car.collision = onCollision
    car:addEventListener( "collision" )
    -- MAKE THIS ONE FOR THE player CHOSEN BY THE USER 
    -- ... .collision = onCollision
    -- ... :addEventListener( "collision" )
    wall1.collision = onCollision
    wall1:addEventListener( "collision" )
    wall2.collision = onCollision
    wall2:addEventListener( "collision" )	
end

local function RemoveCollisionListeners()
	-- rempves all of the colision listners of everything called in this function 
    car:removeEventListener( "collision" )
    -- MAKE THIS ONE FOR THE player CHOSEN BY THE USER
    -- ... :removeEventListener( "collision" )
    wall1:removeEventListener( "collision" )
    wall2:removeEventListener( "collision" )
end
-----------------------------------------------------------------------------------------

--  LEVEL TRANSTIONS 

local function YouLoseTransition()
    composer.gotoScene( "youLose" )
end

local function YouWinTransition()
    composer.gotoScene( "youwin" )
end
-----------------------------------------------------------------------------------------

--  SOUND FUNCTIONS

soundOn = true 

-- make it so the sound mutes when button is pressed
local function Mute( touch )
    if (touch.phase == "ended") then
        -- pause the sound 
        audio.pause(bkgMusic)
        -- set the variable to false 

        --MAKE MUSIC 

        soundOn = false 
        -- hide the mute button 
        muteButton.isVisible = false
        -- show the unmute button 
        unmuteButton.isVisible = true
    end 
end

-- make it so the sound plays when button is pressed
local function Unmute( touch )
    if (touch.phase == "ended") then
        -- pause the sound 
        audio.play(bkgMusic)
        -- set the variable to true 
        soundOn = true 

        -- MAKE MUSIC

        -- show the mute button 
        muteButton.isVisible = true
        -- hide the unmute button 
        unmuteButton.isVisible = flase
    end 
end
-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------
-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- create the background image 
    bkgImage = display.newImageRect("Images/Level2.png", display.contentWidth, display.contentHeight)
    bkgImage.x = display.contentWidth / 2 
    bkgImage.y = display.contentHeight / 2

    -- Insert background image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( bkgImage )

    -- create the maze walls 
    wall1 = display.newImageRect("Images/woodWall.png", 1000, 800)
    wall1.x = 512
    wall1.y = 400
	
	wall2 = display.newImageRect("Images/woodWall2.png", 1000, 800)
    wall2.x = 512
    wall2.y = 380

    -- Insert maze walls  into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( wall1 )
    sceneGroup:insert( wall2 )

    -- create the car 
    car = display.newImageRect("Images/car.png", 200, 200)
    car.x = 940
    car.y = 400
    sceneGroup:insert( car )

    --Insert the right arrow
    rArrow = display.newImageRect("Images/rArrow.png", 75, 50)
    rArrow.x = display.contentWidth * 8.7 / 10
    rArrow.y = display.contentHeight * 9.5 / 10
   
    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( rArrow)

    --Insert the left arrow
    lArrow = display.newImageRect("Images/lArrow.png", 75, 50)
    lArrow.x = display.contentWidth * 6.7 / 10
    lArrow.y = display.contentHeight * 9.5 / 10
   
    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert(lArrow)

    --Insert the left arrow
    uArrow = display.newImageRect("Images/uArrow.png", 50, 75)
    uArrow.x = display.contentWidth * 7.7 / 10
    uArrow.y = display.contentHeight * 8.5 / 10

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( uArrow)

end --function scene:create( event )

-----------------------------------------------------------------------------------------

function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then

        -- Called when the scene is still off screen (but is about to come on screen).
    -----------------------------------------------------------------------------------------
    physics.start() 
    physics.setGravity( 0, 0 )

    elseif ( phase == "did" ) then
		-- create the player, add physics bodies and runtime listeners
        Replaceplayer()
        level2MusicChannel = audio.play(level2Music, {loops = -1})
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

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

























