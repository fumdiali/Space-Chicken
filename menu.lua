local composer = require( "composer" )

local scene = composer.newScene()

local function levelOne()
   composer.gotoScene( "level1" )
end

local function aboutGame()
   composer.gotoScene( "about" )
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

   local sceneGroup = self.view
   -- Code here runs when the scene is first created but has not yet appeared on screen
   local background = display.newImageRect( sceneGroup, "asset/image/black-back3.jpeg", 1020, 600 )
   background.x = display.contentCenterX
   background.y = display.contentCenterY

   local gameImage = display.newImageRect("asset/image/flame3a.png",270,270)
   gameImage.x = display.contentCenterX
   gameImage.y = 150
   gameImage.rotation = 120

   local gameTitle = display.newText( "Space Chicken", 100, 200, native.systemFont, 46 )
   gameTitle:setFillColor( 1, 0, 0 )
   gameTitle.x = display.contentCenterX
   gameTitle.y = 50

   local chicken = display.newImageRect("asset/image/chicken.png",100,100)
   chicken.x = display.contentCenterX
   chicken.y = 130


   local playButton = display.newText( sceneGroup, "Play", display.contentCenterX, 210, native.systemFont, 24 )
   playButton:setFillColor( 0.77,1.5,0.3 )

   local aboutButton = display.newText( sceneGroup, "About", display.contentCenterX, 250, native.systemFont, 24 )
   aboutButton:setFillColor( 0.77,1.5,0.3 )


   playButton:addEventListener( "tap", levelOne )
   aboutButton:addEventListener( "tap", aboutGame )

end

-- destroy()
function scene:destroy( event )
    
       local sceneGroup = self.view
       -- Code here runs prior to the removal of scene's view
      
   end

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene