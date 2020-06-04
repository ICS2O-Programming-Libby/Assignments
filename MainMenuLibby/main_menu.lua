-----------------------------------------------------------------------------------------
-- main_menu.lua
-- Created by: Your Name
-- Date: Month Day, Year
-- Description: This is the main menu, displaying the credits, instructions & play buttons.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- SOUNDS
-----------------------------------------------------------------------------------------

local music = audio.loadSound("Sounds/mainMenu.mp3")
local musicSoundChannel

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

-- Use Widget Library
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "main_menu"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

local bkg_image
local playButton
local creditsButton
local instructionsButton

soundOn = true 

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

 -- Pre-Setting the Transition options
    local transitionOptions_ZoomOutInFade = (
            {
                effect = "zoomOutInFade", -- The animation it's going to use when transitioning
                time = 1000, -- How long the transition will take
            })

 -- The function which transitions to the next screen
 function Transition_ZoomOutInFade( )
        composer.gotoScene( "zoomOutInFade Screen", transitionOptions_ZoomOutInFade )
end

local transitionOptions_ZoomOutInFadeRotate = (
            {
                effect = "zoomOutInFadeRotate", -- The animation it's going to use when transitioning
                time = 1000, -- How long the transition will take
            })

 -- The function which transitions to the next screen
 function Transition_ZoomOutInFadeRotate( )
        composer.gotoScene( "zoomOutInFadeRotate Screen", transitionOptions_ZoomOutInFadeRotate )
end

local transitionOptions_zoomInOutFadeRotate = (
            {
                effect = "zoomInOutFadeRotate", -- The animation it's going to use when transitioning
                time = 1000, -- How long the transition will take
            })

 -- The function which transitions to the next screen
 function Transition_zoomInOutFadeRotate( )
        composer.gotoScene( "zoomInOutFadeRotate Screen", transitionOptions_zoomInOutFadeRotate )
end

local transitionOptions_zoomInOutFade = (
            {
                effect = "zoomInOutFade", -- The animation it's going to use when transitioning
                time = 1000, -- How long the transition will take
            })

 -- The function which transitions to the next screen
 function Transition_zoomInOutFade( )
        composer.gotoScene( "zoomInOutFade Screen", transitionOptions_zoomInOutFade )
end

-- make it so the sound mutes when button is pressed
local function Mute( touch )
    if (touch.phase == "ended") then
        -- pause the sound 
        audio.pause(music)
        -- set the variable to false 
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
        audio.play(music)
        -- set the variable to true 
        soundOn = true 
        -- show the mute button 
        muteButton.isVisible = true
        -- hide the unmute button 
        unmuteButton.isVisible = flase
    end 
end

-----------------------------------------------------------------------------------------

-- Creating Transition Function to Credits Page
local function CreditsTransition( )       
    composer.gotoScene( "credits_screen", transitionOptions_ZoomOutInFade)
end 
-----------------------------------------------------------------------------------------

-- Creating Transition Function to Instructions Page
local function InstructionsTransition( )       
    composer.gotoScene( "instructions", transitionOptions_ZoomOutInFadeRotate )
end 

-----------------------------------------------------------------------------------------

-- Creating Transition to Level1 Screen
local function Level1ScreenTransition( )
    composer.gotoScene( "level1_screen", transitionOptions_ZoomInOutFade)
end    

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------
    -- BACKGROUND IMAGE & STATIC OBJECTS
    -----------------------------------------------------------------------------------------

    -- Insert the background image and set it to the center of the screen
    bkg_image = display.newImage("PhotoShop/Main_Menu.png")
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    -- insert the heads to the animals 
    local gHead = display.newImage("Images/gHead.png", 200, 200)
    gHead.x = 285
    gHead.y = 175

    local zHead = display.newImage("Images/zHead.png", 50, 50)
    zHead.x = 450
    zHead.y = 282.5
    zHead.width = 210
    zHead.height = 210

    local lHead = display.newImage("Images/lHead.png", 200, 200)
    lHead.x = 750
    lHead.y = 290
    lHead.width = 300
    lHead.height = 300

    muteButton = display.newImageRect("Images/mute.png", 70, 70)
    muteButton.x = 50
    muteButton.y = 50
    muteButton.isVisible = true 


    unmuteButton = display.newImageRect("Images/unmute.png", 70, 70)
    unmuteButton.x = 50
    unmuteButton.y = 50
    unmuteButton.isVisible = false 

    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )
    sceneGroup:insert( gHead )
    sceneGroup:insert( zHead )
    sceneGroup:insert( lHead )

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()

    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------   

    -- Creating Play Button
    playButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth/2,
            y = display.contentHeight*7/8,            

            -- Insert the images here
            defaultFile = "Images/buttonPlay.png",
            overFile = "Images/buttonPlayPressed.png", 

            -- When the button is released, call the Level1 screen transition function
            onRelease = Level1ScreenTransition          
        } )

    -----------------------------------------------------------------------------------------

    -- Creating Credits Button
    creditsButton = widget.newButton( 
        {
            -- MAKE THE LENGTH 200 AND THE WIDTH 100
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*7/8,
            y = display.contentHeight*7/8,

            -- Insert the images here
            defaultFile = "Images/buttonCredits.png",  200, 200, 
            overFile = "Images/buttonCreditsPressed.png",  200, 200,   

            -- When the button is released, call the Credits transition function
            onRelease = CreditsTransition
        } ) 

    -----------------------------------------------------------------------------------------

    -- Creating Instructions Button
    instructionsButton = widget.newButton( 
        {
            -- MAKE THE LENGTH 200 AND THE WIDTH 100
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*1/8,
            y = display.contentHeight*7/8,


            -- Insert the images here
            defaultFile = "Images/buttonInstructions.png",  200, 200,
            overFile = "Images/buttonInstructionsPressed.png",  200, 200, 

            -- When the button is released, call the Credits transition function
            onRelease = InstructionsTransition
        } ) 

    

    -----------------------------------------------------------------------------------------

    -- Associating button widgets with this scene
    sceneGroup:insert( playButton )
    sceneGroup:insert( creditsButton )
    sceneGroup:insert( instructionsButton )
 -- function scene:create( event )      

    -----------------------------------------------------------------------------------------

    -- Associating button widgets with this scene
    --[[
    sceneGroup:insert( playButton )
    sceneGroup:insert( creditsButton )
    sceneGroup:insert( instructionsButton )
    ]]
end -- function scene:create( event )   



-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    -----------------------------------------------------------------------------------------


    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).   
    if ( phase == "will" ) then
       
    -----------------------------------------------------------------------------------------

    -- Called when the scene is now on screen.
    -- Insert code here to make the scene come alive.
    -- Example: start timers, begin animation, play audio, etc.
    elseif ( phase == "did" ) then   

    musicSoundChannel = audio.play(music, {loops = -1})
    musicSoundChannel = audio.pause(music)
    unmuteButton:addEventListener("touch", Unmute)  
    muteButton:addEventListener("touch", Mute)
  
        
    -- make the background music
    -- musicSoundChannel = audio.play(music)  
    -----------------------------------------------------------------------------------------

    end

end -- function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

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

end -- function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

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
