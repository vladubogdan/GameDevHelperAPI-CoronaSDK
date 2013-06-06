local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local GHSkeleton = require("GameDevHelperAPI.GHSkeleton")
require ("GameDevHelperAPI.GHSkeletalAnimation");

--------------------------------------------
local testCaseInfo = "Demonstrate moving a skeleton and flipping it.\nWhen the character gets to a screen border it will flip.";

-- forward declarations and other locals
local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5

local localGroup = nil;

function scene:createScene( event )
    local group = self.view
    
    localGroup = group;
end

local skeleton = nil;

local createSkeletonAtLocation = function(x, y)

    skeleton = GHSkeleton.createWithFile("Assets/skeletons/Officer_Officer.json");
    skeleton:setPosition(x, y);
    localGroup:insert(skeleton);
    
    local anim = GHSkeletalAnimation:createWithFile("Assets/skeletons/animations/SoftWalk.json");
    skeleton:playAnimation(anim);
end

local function onEnterFrame( event ) 

    local posX = skeleton:getPositionX();
    local posY = skeleton:getPositionY();
    
    if(posX > display.contentWidth or posX < 0)then
        
        if(skeleton:getFlipX() == true)then
            skeleton:setFlipX(false)
        else
            skeleton:setFlipX(true)
        end
    end
    
    if(skeleton:getFlipX() == true)then
        posX = posX - 1.6;
    else
         posX = posX + 1.6;
    end
    
    skeleton:setPosition(posX, posY);
    
end 
   
-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
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
    
    createSkeletonAtLocation(display.contentWidth/2, display.contentHeight/2);
    
    Runtime:addEventListener( "enterFrame", onEnterFrame );
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
    Runtime:removeEventListener( "enterFrame", onEnterFrame); 
    
    skeleton:removeSelf();
    skeleton = nil
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	local group = self.view
	
end
----------------------------------------------------------------------------------------
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