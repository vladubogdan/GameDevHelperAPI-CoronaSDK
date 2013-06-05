local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- include Corona's "physics" library
local physics = require "physics"
physics.start(); physics.pause()

local GHSprite =  require("GameDevHelperAPI.GHSprite");

--------------------------------------------
local testCaseInfo = "Demonstrate loading sprites with physical body using GameDevHelper API.\n\nClick to create sprites.";

-- forward declarations and other locals
local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5


local localGroup = nil;

function scene:createScene( event )
	local group = self.view
    
    localGroup = group;

    local multiText = display.newText( testCaseInfo, display.contentWidth/10, 0, display.contentWidth - display.contentWidth/5, display.contentHeight/2, "Helvetica", 12 )
    multiText:setReferencePoint(display.CenterReferencePoint)
    multiText:setTextColor(255, 255, 255, 255)
    group:insert(multiText);
    
    backButton = display.newText("Back", 0, 0, 'ArialMT', 20)
    backButton:setTextColor(255, 255, 255, 255)
    backButton:setReferencePoint(display.TopLeftReferencePoint)
    backButton.x = 0;
    backButton.y = 0;
 
    backButton:addEventListener("tap", function()
            storyboard.gotoScene("menu")
        end)
    group:insert(backButton);

end

local createdSprites = {}
local currentSprite = 1;
local createSpriteAtLocation = function(x, y)

    
    local spriteFrameNames = {
            "backpack", "banana", "bananabunch", "canteen", "hat", "pineapple", "statue", "ball" }

    local spriteName = spriteFrameNames[currentSprite];
    --YOU SHOULD LOOK AT config.lua to see how image suffixes are setup for dynamic content scaling.

    local sprite = GHSprite.createWithFile("Assets/PhysicalSpritesObjects_Objects.png", spriteName);
    
    localGroup:insert(sprite);
    
    sprite.x = x;
    sprite.y = y;
    
    --test case related code to change the sprite that will be created on next click
    currentSprite = currentSprite+1;
    if(currentSprite > #spriteFrameNames)then
        currentSprite = 1;
    end
    
    createdSprites[#createdSprites+1] = sprite;
end


local function onScreenTouch( event ) 
    if(event.phase == "began")then
        createSpriteAtLocation(event.x, event.y);
    end
    if(event.phase == "moved")then
    end
end 

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	physics.start()
	
    local leftWall  = display.newRect (-100, 0, 101, display.contentHeight)
    local rightWall = display.newRect (display.contentWidth, 0, 100, display.contentHeight)
    local ceiling   = display.newRect (0, -100, display.contentWidth, 101)
	local floor     = display.newRect (0, display.contentHeight, display.contentWidth, 100)
	 
	local b = 0.3 -- 0.0
	local f = 0.1 -- 10

	physics.addBody (leftWall, "static", {bounce = b, friction = f})
	physics.addBody (rightWall, "static", {bounce = b, friction = f})
	physics.addBody (ceiling, "static", {bounce = b, friction = f})
	physics.addBody (floor, "static", {bounce = b, friction = f})
    
    group:insert(leftWall);
    group:insert(rightWall);
    group:insert(ceiling);
    group:insert(floor);
    

    Runtime:addEventListener( "touch", onScreenTouch );

end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	physics.setDrawMode( "normal" ) 
    
    Runtime:removeEventListener( "touch", onScreenTouch); 
    
    for i = 1, #createdSprites do
       local spr = createdSprites[i];
       
       spr:removeSelf();
    end
    createdSprites = nil
    createdSprites = {}
    
	physics.stop()
	
    
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	local group = self.view
	
	package.loaded[physics] = nil
	physics = nil
end

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