local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- include Corona's "physics" library
--local physics = require "physics"
--physics.start(); physics.pause()

--------------------------------------------
local testCaseInfo = "Demonstrate loading sprite sheet animations using GameDevHelper API.\n\nClick to create sprite sheet animations.\nUsing this method you will have random frames, user info per frame, random delay time and notifications.\nAnimation will run faster for first 5 frames and then will slow down.\nWatch console for notifications.\nFrame 6 has user info.\n";

-- forward declarations and other locals
local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5


local localGroup = nil;

function scene:createScene( event )
	local group = self.view
    
    localGroup = group;
end

local createdSprites = {}
local currentAnim = 1;
local createSpriteAnimationAtLocation = function(x, y)

    --YOU SHOULD LOOK AT config.lua to see how image suffixes are setup for dynamic content scaling.

    local animNames = {"NumbersAnim", "fireAnim", "blinkingAnim"}


--because of how content scaling is handled by Corona. (@2x.lua @4x.lua are never read by Corona) certain trimmed animation my not play correctly.
--Im working with Corona team to resolve this issue.

    local GHSprite = require("GameDevHelperAPI.GHSprite");
    local animatedSprite = GHSprite.createAnimatedSpriteWithFile(  "Assets/sheetAnimations/spriteSheetAnimationsTest_SheetAnimations.json", 
                                                         {"NumbersAnim", "fireAnim", "blinkingAnim"});
    
    
    localGroup:insert(animatedSprite);
    --here for testing purposes we set up a different animation to play
    local animToPlay = animNames[currentAnim];
    animatedSprite:prepareAnimationNamed(animToPlay);
    animatedSprite:playAnimation();
    
    --demonstrate how to register for frame change notifications
    animatedSprite:setDidChangeFrameNotificationObserver(function(frameIdx, spriteObject)
        
        print("Did change frame index to " .. frameIdx .. " on animation running on sprite object " .. tostring(spriteObject));
        
        
        local userInfo = spriteObject:getUserInfoForFrameAtIndex(frameIdx);
        if(userInfo)then
            print("Frame has USER INFO");
            for k,v in pairs(userInfo) do
               print(tostring(k) .. " = " .. tostring(v));
            end
        else
            print("This frame has NO user info");
        end
        
        
        end);


    animatedSprite:setDidFinishRepetitionNotificationObserver(function(performedRepetitions, spriteSheetObj)
            print("Did FINISH REPETITION " .. tostring(performedRepetitions) .. " on animation running on sprite object " .. tostring(spriteSheetObj));
        end);
 
 
    animatedSprite:setDidFinishPlayingNotificationObserver(function(spriteSheetObj)
        print("Did finish playing animation running on sprite object " .. tostring(spriteSheetObj));
    end);
 
 


    animatedSprite.x = x;
    animatedSprite.y = y;
    createdSprites[#createdSprites+1] = animatedSprite;
    
    --test case related code to change the sprite that will be created on next click
    currentAnim = currentAnim+1;
    if(currentAnim > #animNames)then
        currentAnim = 1;
    end
end


local function onScreenTouch( event ) 
    if(event.phase == "began")then
        createSpriteAnimationAtLocation(event.x, event.y);
    end
    if(event.phase == "moved")then
    
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
    
    for i = 1, #createdSprites do
       local spr = createdSprites[i];
       
       spr:removeSelf();
    end
    createdSprites = nil
    createdSprites = {}
    
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