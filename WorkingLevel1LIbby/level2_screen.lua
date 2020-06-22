----------------------------------------------------------------------------------------
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

local failSound = audio.loadSound("Sounds/fail.mp3")
local failSoundChannel

local winnerSound = audio.loadSound("Sounds/winner.mp3")
local winnerSoundChannel

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
local bkgImage

local wall1
local wall2
local wall3
local wall4
local wall5
local wall6 
local wall7
local wall8 
local wall9 
local wall10
local wall11


local heart1
local heart2
local heart3
local numLives = 3
local lives = 1

local rArrow 
local uArrow
local lArrow

-- variables for the timer
local totalSeconds = 31
local secondsLeft = 31
local clockText
local countDownTimer

local muteButton 
local unmuteButton 

local motionx = 0
local motiony = 0
local SPEED = 7
-- NOT SURE I NEED THESE SO IM TEMPORARILY COMMENTING OUT 
local LINEAR_VELOCITY = -150
local GRAVITY = -2

-----------------------------------------------------------------------------------------
-- LOCAL SCENE FUNCTIONS
----------------------------------------------------------------------------------------- 

--  MOVE THE CAR WHEN THE TIMER RUNS OUT 

local scrollspeed = 3

--[[local function MoveCar( event )
    -- make the car move one the timer runs out 
    car.x = car.x + scrollspeed 
end]]
-----------------------------------------------------------------------------------------

-- TIMER FUNCTIONS 

local function UpdateTime()
    -- decrement the number of seconds 
    secondsLeft = secondsLeft - 1
    print ("secondsLeft : " .. secondsLeft)
    -- display the number of seconds left in the clock object 
    clockText.text = secondsLeft .. ""

   -- if(secondsLeft == 2) then 
        --MoveCar()

    if (secondsLeft == 0) then 
       -- rest the number of seconds left 
       --secondsLeft = totalSeconds
        if (secondsLeft == 0) then 
            print ("timer is out " )
            timer.performWithDelay(500)
            level2MusicChannel = audio.pause(level2Music)
            failSoundChannel = audio.play(failSound)
            timer.cancel(countDownTimer)
            clockText.isVisible = false
            composer.gotoScene( "you_lose" )

        end 
       -- cancel timer
       timer.cancel(countDownTimer)

     -- *****CALLL THE FUNCTION TO ASK A NEW QUESTION*****
     -- AskQuestion()
     -- secondsLeft = 31 
     -- countDownTimer = timer.performWithDelay(1000, UpdateTime, secondsLeft)
    end 
end

-- function that calls the timer 
local function StartTimer()
    -- create a countdown timer that loops infinitely
    if (lives > 0) then
        secondsLeft = 11
        countDownTimer = timer.performWithDelay(1000, UpdateTime, secondsLeft)
        print ("Start timer.")
    else
        timer.cancel(countDownTimer)
    end

end

-----------------------------------------------------------------------------------------

-- LEVEL TRANSTIONS 

local function YouLoseTransition()
    composer.gotoScene( "youLose" )
end

local function YouWinTransition()
    composer.gotoScene( "youwin" )
end

-- ARROW FUNCTIONS 

-- When right arrow is touched, move player right
local function right (touch)
    motionx = SPEED
    player.xScale = 1

    if player.x >= 900 and (player.y <= 400 and player.y >= 350) then
        
        composer.gotoScene( "youwin" )
        winnerSoundChannel = audio.pause(winnerSound)
        --YouWinTransition()
    end
end

-- When up arrow is touched, add vertical so it can jump
local function left (touch)
    motionx = -SPEED 
    player.xScale = -1
    
end


-- When up arrow is touched, add vertical so it can jump
local function down (touch)
    motiony = SPEED 
    player.yScale = 1
end


-- When up arrow is touched, add vertical so it can jump
local function up (touch)
    motiony = -SPEED 
    player.yScale = 1
end


-- Move player horizontally
local function movePlayer (event)
    player.x = player.x + motionx
    player.y = player.y + motiony
end
 
-- Stop player movement when no arrow is pushed
local function stop (event)
    if (event.phase =="ended") then
        motionx = 0
        motiony = 0
    end
end

local function AddArrowEventListeners()
    rArrow:addEventListener("touch", right)
    uArrow:addEventListener("touch", up)
    lArrow:addEventListener("touch", left)
    dArrow:addEventListener("touch", down)  
 
end

local function RemoveArrowEventListeners()
    rArrow:removeEventListener("touch", right)
    uArrow:removeEventListener("touch", up)
    lArrow:removeEventListener("touch", left)
    dArrow:removeEventListener("touch", down)
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
    player.isVisible = true 
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
    physics.addBody( wall3, "static", { density= 0, friction= 0, bounce= 0 } )
    physics.addBody( wall4, "static", { density= 0, friction= 0, bounce= 0 } )
    physics.addBody( wall5, "static", { density= 0, friction= 0, bounce= 0 } )
    physics.addBody( wall6, "static", { density= 0, friction= 0, bounce= 0 } )
    physics.addBody( wall7, "static", { density= 0, friction= 0, bounce= 0 } )
    physics.addBody( wall8, "static", { density= 0, friction= 0, bounce= 0 } )
    physics.addBody( wall9, "static", { density= 0, friction= 0, bounce= 0 } )
    physics.addBody( wall10, "static", { density= 0, friction= 0, bounce= 0 } )
    --physics.addBody( wall11, "static", { density= 0, friction= 0, bounce= 0 } )
    physics.addBody(car, "static", {density= 0, friction= 0, bounce= 0 })
end

local function RemovePhysicsBodies()
	-- takes away the physics bodies of all objects called in this function 
	physics.removeBody(wall1)
    physics.removeBody(wall2)
    physics.removeBody(wall3)
    physics.removeBody(wall4)
    physics.removeBody(wall5)
    physics.removeBody(wall6)
    physics.removeBody(wall7)
    physics.removeBody(wall8)
    physics.removeBody(wall9)
    physics.removeBody(wall10)
    --physics.removeBody(wall11)
    -- MAKE THIS ONE FOR THE player CHOSEN BY THE UESR 
    physics.removeBody( player )
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
    player.collision = onCollision
    player:addEventListener("collision")   
end

local function RemoveCollisionListeners()
	-- rempves all of the colision listners of everything called in this function 
    car:removeEventListener( "collision" )
    -- MAKE THIS ONE FOR THE player CHOSEN BY THE USER
    player:removeEventListener( "collision" )
end
-----------------------------------------------------------------------------------------

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
    wall1 = display.newImageRect("Images/woodHorizontal.png", 800, 800)
    wall1.x = 250
    wall1.y = 100
	
	wall2 = display.newImageRect("Images/woodHorizontal.png", 800, 800)
    wall2.x = 720
    wall2.y = 100

    wall3 = display.newImageRect("Images/woodVertical.png", 400, 500)
    wall3.x = 15
    wall3.y = 200

    wall4 = display.newImageRect("Images/woodVertical.png", 400, 500)
    wall4.x = 985
    wall4.y = 200

    wall5 = display.newImageRect("Images/woodVertical.png", 600, 600)
    wall5.x = 400
    wall5.y = 335

    wall6 = display.newImageRect("Images/woodHorizontal.png", 800, 800)
    wall6.x = 250
    wall6.y = 775

    wall7 = display.newImageRect("Images/woodHorizontal.png", 800, 800)
    wall7.x = 720
    wall7.y = 775

    wall8 = display.newImageRect("Images/woodVertical.png", 400, 400)
    wall8.x = 15
    wall8.y = 650

    wall9 = display.newImageRect("Images/woodVertical.png", 400, 400)
    wall9.x = 985
    wall9.y = 650

    wall10 = display.newImageRect("Images/woodVertical.png", 600, 600)
    wall10.x = 650
    wall10.y = 520

    --wall11 = display.newImageRect("Images/woodHorizontal.png", 300, 300)
    --wall11.x = 120
    --wall11.y = 515

    -- insert maze walls  into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( wall1 )
    sceneGroup:insert( wall2 )
    sceneGroup:insert( wall3 )
    sceneGroup:insert( wall4 )
    sceneGroup:insert( wall5 )
    sceneGroup:insert( wall6 )
    sceneGroup:insert( wall7 )
    sceneGroup:insert( wall8 )
    sceneGroup:insert( wall9 )
    sceneGroup:insert( wall10 )
    --sceneGroup:insert( wall11 )

    -- create the car 
    car = display.newImageRect("Images/car.png", 200, 200)
    car.x = 940
    car.y = 400
    sceneGroup:insert( car )

    --Insert the right arrow
    rArrow = display.newImageRect("Images/rArrow.png", 50, 25)
    rArrow.x =  900   
    rArrow.y =  710   
   
    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( rArrow)

    --Insert the left arrow
    lArrow = display.newImageRect("Images/lArrow.png", 50, 25)
    lArrow.x = 800
    lArrow.y = 710
   
    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert(lArrow )

    --Insert the left arrow
    uArrow = display.newImageRect("Images/uArrow.png", 25, 50)
    uArrow.x = 850
    uArrow.y = 680

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( uArrow )

    --ADDDED THIS -- IMAGE DOES NOT EXIST YET 
    --Insert the down arrow
    dArrow = display.newImageRect("Images/dArrow.png", 25, 50)
    dArrow.x = 850
    dArrow.y = 740

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( dArrow )

    -- display the clock text, showing the number countdown 
    clockText = display.newText("Start", 150, 50, native.systemFontBold, 80)
    clockText:setFillColor(0, 0, 0)
    clockText.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( clockText )

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
		
        -- add physics bodies to each object
        --AddPhysicsBodies()
        -- add collision listeners to objects
        --AddCollisionListeners()
        -- create the character, add physics bodies and runtime listeners
        Replaceplayer()

        -- start the timer 
        StartTimer()

        -- play the level music 
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

        physics.stop()
        --RemoveCollisionListeners()
        RemovePhysicsBodies()

        --RemoveArrowEventListeners()
        --RemoveRuntimeListeners()
        --display.remove(player)
        player.isVisible = false 
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