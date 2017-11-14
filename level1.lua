local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
    
       local sceneGroup = self.view
       -- Code here runs when the scene is first created but has not yet appeared on screen
       
       --1st background instance
       bg1 = display.newImageRect( "asset/image/black-back2.jpeg",982,780)
       bg1.x =  display.contentCenterX
       bg1.y = display.contentCenterY

       --2nd background instance
       bg2 = display.newImageRect( "asset/image/black-back2.jpeg",982,780)
       bg2.x =  display.contentCenterX
       bg2.y = display.contentCenterY

       --3rd background instance
       bg3 = display.newImageRect( "asset/image/black-back2.jpeg",982,780)
       bg3.x =  display.contentCenterX
       bg3.y = display.contentCenterY

       levelDisplay = display.newText ("Stage 1", 230, 10, native.systemFont, 20 )
       levelDisplay:setFillColor(0.77,1.5,0.3)

       platForm = display.newRoundedRect( 0, 0, 1000, 7, 25 )
       platForm.x = display.contentCenterX
       platForm.y = display.contentCenterY + 70
       platForm.strokeWidth = 3
       platForm:setFillColor( 0.5 )
       platForm:setStrokeColor( 0, 1, 0 )

       star1 = display.newImageRect("asset/image/star-gold.png",50,50)
       star1.x = 990
       star1.y = 80

       star2 = display.newImageRect("asset/image/star-red.png",50,50)
       star2.x = 990
       star2.y = 80

       player = display.newImageRect("asset/image/chicken.png",70,70)
       player.x = 100
       player.y = display.contentCenterY + 41

       dragonFire1 = display.newImageRect("asset/image/dragon-fire.png",80,80)
       dragonFire1.x = 990
       dragonFire1.y = 20
       dragonFire1.rotation = 270

       dragonFire2 = display.newImageRect("asset/image/dragon-fire.png",80,80)
       dragonFire2.x = 990
       dragonFire2.y = 20
       dragonFire2.rotation = 270

       blueFire1 = display.newImageRect("asset/image/blue-orange-fire.png",80,80)
       blueFire1.x = 990
       blueFire1.y = 30
       blueFire1.rotation = 270

       blueFire2 = display.newImageRect("asset/image/blue-orange-fire.png",80,80)
       blueFire2.x = 990
       blueFire2.y = 30
       blueFire2.rotation = 270
       

       flame1 = display.newImageRect("asset/image/flame2.png",90,360)
       flame1.x = 990
       flame1.y = display.contentCenterY + 43
       flame1.rotation = 90

       flame2 = display.newImageRect("asset/image/flame2.png",120,320)
       flame2.x = 990
       flame2.y = display.contentCenterY + 43
       flame2.rotation = 90

       flame3 = display.newImageRect("asset/image/flame3a.png",120,320)
       flame3.x = 990
       flame3.y = display.contentCenterY - 40
       flame3.rotation = 110
       

       scoreDisplay = display.newText ("score:0", 40, 290, native.systemFont, 22 )
       scoreDisplay:setFillColor(0.77,1.5,0.3)

       livesDisplay1 = display.newImageRect ("asset/image/diamond-green.png",30,30)
       livesDisplay1.x = 390
       livesDisplay1.y = 290

       livesDisplay2 = display.newImageRect ("asset/image/diamond-green.png",30,30)
       livesDisplay2.x = 413
       livesDisplay2.y = 290

       livesDisplay3 = display.newImageRect ("asset/image/diamond-green.png",30,30)
       livesDisplay3.x = 443
       livesDisplay3.y = 290

    
   end--end of create scene
    
    
   -- show()
   function scene:show( event )
    
       local sceneGroup = self.view
       local phase = event.phase
      
       if ( phase == "will" ) then
           -- Code here runs when the scene is still off screen (but is about to come on screen)
    
       elseif ( phase == "did" ) then
           -- Code here runs when the scene is entirely on screen
           local physics = require( "physics" )
           physics.start()

           scrollSpeed = 3 --for background scrolling
           score = 0 --player score count

           physics.addBody( player, "dynamic", { bounce=0.5 } )
           physics.addBody( platForm, "static", { bounce=0.3 } )

                   --bgmove function
                   local function bgMove(event)
                       --move background to the left of screen by scroll speed(default is 3)
                       bg1.x = bg1.x - scrollSpeed
                       bg2.x = bg2.x - scrollSpeed
                       bg3.x = bg3.x - scrollSpeed
           
                       --check bg point limit and return to right
                       if(bg1.x + bg1.contentWidth) < 981 then
                           bg1:translate(982, 0)
                       end
                       if(bg2.x + bg2.contentWidth) < 981 then
                           bg2:translate(982*2, 0)
                       end
                       if(bg3.x + bg3.contentWidth) < 480 then
                           bg3:translate(982, 0)
                       end
                   end--end of bg move function

                  --runtime event to move background
                  Runtime:addEventListener( "enterFrame", bgMove)
        end
        
        --function to control player jumps
       local function playerJump()
        transition.moveTo( player, { x=100, y=-5, time=500 } )
        score = score + 1
        scoreDisplay.text = "score:"..score
       end
    
       --flip player by tapping anywhere on the screen
       bg1:addEventListener( "tap", playerJump )

       --function controls flame and fire 'ball' on-screen movement to screen left
       function flameStarAndFireRoll()
        --flame fly-by
        transition.to( flame1, { x=-190, y = display.contentCenterY + 43, time=9000, transition=easing.inExpo, delay=1000,iterations=-1 } )
        transition.to( flame2, { x=-190, y = display.contentCenterY + 43, time=6000, transition=easing.inExpo, delay=5000,iterations=-1 } )
        transition.to( flame3, { x=-190, y = display.contentCenterY - 40,  time=6000, transition=easing.inExpo, delay=9000,iterations=-1 } )
          --fire ball roll-by
          if(blueFire1.rotation>269 or blueFire2.rotation>269 ) then
            transition.to( blueFire1, { x=-190, y=30, rotation=-250, time=26000, transition=easing.inExpo, delay=2000,iterations=-1 } )
            transition.to( blueFire2, { x=-190, y=30, rotation=-250, time=26000, transition=easing.inExpo, delay=12000,iterations=-1 } )
          end
            --bonus points stars, gold and red
            transition.to( star1, { x=-190, y=70, time=16000, transition=easing.inExpo, iterations=5 } )
            transition.to( star2, { x=-190, y=70, time=26000, transition=easing.inExpo, iterations=3 } )
       end--end of flame,star and fire function
        
       ammo = 5
       while( ammo > 0 )
       do
          flameStarAndFireRoll()
          ammo = ammo - 1
       end

   end--end of show function
    
    
   -- hide()
   function scene:hide( event )
    
       local sceneGroup = self.view
       local phase = event.phase
    
       if ( phase == "will" ) then
           -- Code here runs when the scene is on screen (but is about to go off screen)
    
       elseif ( phase == "did" ) then
           -- Code here runs immediately after the scene goes entirely off screen
    
       end
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