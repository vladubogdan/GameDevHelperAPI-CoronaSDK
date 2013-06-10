-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
 
------------------------------------------------------------------------------------
-- This is the array that holds all the links and their associated scenes
------------------------------------------------------------------------------------
local links = {
-- {'button label', 'director scene'}
        {'Sprites: Load sprites using Corona SDK','sprites_loadUsingCorona'},
        {'Physics: Load physical sprites','physics_loadPhysicalSprites'},
        {'Physics: Collision Filtering','physics_collisionFiltering'},
        {'Skeletons: Load Skeleton and move bone','skeleton_loadSkeleton'},
        {'Skeletons: Load Skeleton and set poses','skeleton_loadPoses'},
        {'Skeletons: Load Skeleton and animate','skeleton_loadAnimation'},
        {'Skeletons: Transition from one animation to another','skeleton_animationTransition'},
        {'Skeletons: Animate, move and flip','skeleton_animateMoveAndFlip'},
        {'Sprite Sheet Animations - Corona SDK','spriteAnims_loadUsingCorona'},
        {'Sprite Sheet Animations - GameDevHelper API','spriteAnims_loadUsingGDHAPI'},
--        {'Sprites: Load sprites using GameDevHelper API','Scene2'},
--        {'Physics: Load physical sprites','Scene3'},
--        {'Physics: Collision Filtering','Scene4'},
--        {'Skeletons: load test','Scene5'},
--        {'Skeletons: load pose','Scene6'},
--        {'Skeletons: animation','Scene7'},
--        {'Skeletons: animate and move','Scene8'},
--        {'Skeletons: frame by frame','Scene9'},
--        {'Skeletons: change animation time','Scene9'},
--        {'Skeletons: animation notifications','Scene9'},
} 
local buttons = {}
local localGroup = nil;

-----------------------------------
-- Clear all objects from memory
-----------------------------------
local function freeMem()
  for i = 1, #buttons do
    buttons[i]:removeSelf()
    buttons[i] = nil
  end
 
  buttons = nil
end

-----------------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
-- 
-- NOTE: Code outside of listener functions (below) will only be executed once,
--		 unless storyboard.removeScene() is called.
-- 
-----------------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

    localGroup = group;

    local y = 0 -- initial Y position for text
 
    for i = 1, #links do
      buttons[i] = display.newText(links[i][1], 0, 0, 'ArialMT', 20)
      buttons[i]:setTextColor(255, 255, 255, 255)
      buttons[i]:setReferencePoint(display.CenterReferencePoint)
      buttons[i].x = display.contentWidth/2
      buttons[i].y = (i * 30) + y
 
      buttons[i]:addEventListener("tap", function()
            storyboard.gotoScene( links[i][2] )
            end)
      group:insert(buttons[i])
    end
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	-- INSERT code here (e.g. start timers, load audio, start listeners, etc.)
	
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
	-- INSERT code here (e.g. stop timers, remove listenets, unload sounds, etc.)
	
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	local group = self.view
	
    freeMem();
    
end

local lastEventY = 0;
local myListener = function( event ) 
    if(event.phase == "began")then
        lastEventY = event.y; 
    end
    if(event.phase == "moved")then
        delta = event.y - lastEventY;
        
        lastEventY = event.y;
        localGroup.y = localGroup.y + delta;    
        
        if(localGroup.y > 0)then
            localGroup.y = 0;
        end
        
        if(localGroup.y < -(#links+1)*30 + display.contentHeight)then
            localGroup.y = -(#links+1)*30 + display.contentHeight;
        end
    end
    
end 
Runtime:addEventListener( "touch", myListener ) 


-----------------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
-----------------------------------------------------------------------------------------
-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched whenever before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

-----------------------------------------------------------------------------------------

return scene