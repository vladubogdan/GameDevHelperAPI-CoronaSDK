local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- include Corona's "physics" library
--local physics = require "physics"
--physics.start(); physics.pause()

--------------------------------------------
local testCaseInfo = "Demonstrate loading sprite sheet animations using pure Corona SDK code from published SpriteHelper 2 files.\n\nClick to create sprite sheet animations.\n\nUsing this method you wont have access to random frames, user info per frame, random delay time and notifications.\n\nAnimation will run faster for first 5 frames and then will slow down.";

-- forward declarations and other locals
local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5


local localGroup = nil;

function scene:createScene( event )
	local group = self.view
    
    localGroup = group;
end

local createdSprites = {}
local createSpriteAnimationAtLocation = function(x, y)

    --YOU SHOULD LOOK AT config.lua to see how image suffixes are setup for dynamic content scaling.

    -- require the sprite sheet information file
    local sheetInfo = require("Assets.sheetAnimations.spriteSheetAnimationsTest_Numbers"); --the folders and the lua file exported by SpriteHelper
    --create the image sheet
    local imageSheet = graphics.newImageSheet( "Assets/sheetAnimations/spriteSheetAnimationsTest_Numbers.png", sheetInfo.getSpriteSheetData() );
    --create the sprite
    
    local allAnimData = require("Assets.sheetAnimations.spriteSheetAnimationsTest_SheetAnimations");
    local numbersAnimSequenceData = allAnimData.getSequenceWithName("NumbersAnim");
    
    local animation = display.newSprite( imageSheet, numbersAnimSequenceData )
    
    
    localGroup:insert(animation);
    animation:play()
    animation.x = x;
    animation.y = y;
   createdSprites[#createdSprites+1] = animation;
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