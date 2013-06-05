local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local GHSkeleton = require("GameDevHelperAPI.GHSkeleton")
require ("GameDevHelperAPI.GHSkeletalAnimation");

--------------------------------------------
local testCaseInfo = "Demonstrate transitioninig to new skeleton animation.\nTap on the screen to transtion to new animation and play.\nYou should only transition animations that are related (e.g from walk to run).\nIf you are not careful this may create unrealistic movement.\nIn this test the transition time is big to demonstrate the effect.\nIn real world usage you will probably use a smaller time.";

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

local currentAnim = 1;
local animNames = {
            "HolsterGun", "SoftWalk"}
   
local function onScreenTouch( event ) 
    
    if(event.phase == "ended")then
        
        if(skeleton == nil)then
            
            createSkeletonAtLocation(event.x, event.y);
            
        else   
            
            local currentAnimName = animNames[currentAnim];
            
            local anim = GHSkeletalAnimation:createWithFile("Assets/skeletons/animations/" .. currentAnimName ..".json");
            
            skeleton:transitionToAnimationInTime(anim, 2);--2 seconds
            
            currentAnim = currentAnim+1;
            if(currentAnim > #animNames)then
                currentAnim = 1;
            end
        end
    
    end
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
    
    Runtime:addEventListener( "touch", onScreenTouch );
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
    Runtime:removeEventListener( "touch", onScreenTouch); 
    
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