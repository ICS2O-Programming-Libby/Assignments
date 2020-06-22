-----------------------------------------------------------------------------------------
-- SceneTemplate.lua
-- Scene Template (Composer API)
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Calling Composer Library
local composer = require( "composer" )

local widget = require( "widget" )

local level2Button
local level1Button
local backButton

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level_select"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- FORWARD REFERENCES
-----------------------------------------------------------------------------------------

-- local variables for the scene
local bkg
-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

-- Creating Transition to Level2 Screen
local function Level2ScreenTransition()
    composer.gotoScene( "level2_screen")
end 
-- Creating Transition to Main Menu
local function Level1ScreenTransition()
    composer.gotoScene( "level1_screen")
end 

-- Creating Transition to Main Menu
local function MainMenuTransition()
    composer.gotoScene( "main_menu")
end 


--------------------------------------------------------------------------------------
-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- Display background
    bkg = display.newImage("PhotoShop/LevelSelect.png")
    bkg.x = display.contentCenterX
    bkg.y = display.contentCenterY
    bkg.width = display.contentWidth
    bkg.height = display.contentHeight
   
    -- Associating display objects with this scene 
    sceneGroup:insert( bkg )

-----------------------------------------------------------------------------------------
-- BUTTON WIDGETS
-----------------------------------------------------------------------------------------   

    -- Creating level2 Button
    level2Button = widget.newButton( 
        {
            -- MAKE THE LENGTH 200 AND THE WIDTH 100
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth/2,
            y = display.contentHeight*4/8,
            --x = 512,
            --y = 300, 

            -- Insert the images here
            defaultFile = "Images/buttonlevel2.png",  200, 200,
            overFile = "Images/buttonlevel2Pressed.png",  200, 200, 

            -- When the button is released, call the Credits transition function
            onRelease = Level2ScreenTransition 
        } )
    -----------------------------------------------------------------------------------------


    -- Creating level2 Button
    level1Button = widget.newButton( 
        {
            -- MAKE THE LENGTH 200 AND THE WIDTH 100
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth/2,
            y = display.contentHeight*3/8,


            -- Insert the images here
            defaultFile = "Images/buttonlevel1.png",  200, 200,
            overFile = "Images/buttonlevel1Pressed.png",  200, 200, 

            -- When the button is released, call the Credits transition function
            onRelease = Level1ScreenTransition 
        } )
    -----------------------------------------------------------------------------------------

    backButton = widget.newButton( 
        {
            -- MAKE THE LENGTH 200 AND THE WIDTH 100
            -- Set its position on the screen relative to the screen size
            --x = display.contentWidth*1/8,
            --y = display.contentHeight*7/8,
            x = 512,
            y = 565,

            -- Insert the images here
            defaultFile = "Images/buttonback.png",  200, 200,
            overFile = "Images/buttonbackPressed.png",  200, 200, 

            -- When the button is released, call the Credits transition function
            onRelease = MainMenuTransition 
        } )

    sceneGroup:insert( level2Button )
    sceneGroup:insert( level1Button )
    sceneGroup:insert( backButton )
  
end    

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then

        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
    end

end

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

end
-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------


    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end

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