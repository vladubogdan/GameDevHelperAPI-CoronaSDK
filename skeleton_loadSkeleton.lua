local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

require("GameDevHelperAPI.GHBone")
require("GameDevHelperAPI.GHAffineTransform")
require("GameDevHelperAPI.GHBoneSkin")

--------------------------------------------
local testCaseInfo = "Demonstrate loading a skeleton.\nWORK IN PROGRESS";

-- forward declarations and other locals
local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5

local localGroup = nil;

function scene:createScene( event )
	local group = self.view
    
    localGroup = group;
end

local createdSprites = {}
local currentSprite = 1;
local createSpriteAtLocation = function(x, y)

    local spriteFrameNames = {
            "backpack", "banana", "bananabunch", "canteen", "hat", "pineapple", "statue" }

    local spriteName = spriteFrameNames[currentSprite];
    --YOU SHOULD LOOK AT config.lua to see how image suffixes are setup for dynamic content scaling.

    -- require the sprite sheet information file
    local sheetInfo = require("Assets.loadSprites_spritesSheet"); --the folder "Assets" and the lua file exported by SpriteHelper "loadSprites_spritesSheet"
    --create the image sheet
    local imageSheet = graphics.newImageSheet( "Assets/loadSprites_spritesSheet.png", sheetInfo.getSpriteSheetData() );
    --create the sprite
    
    print("Did create sprite with name " .. spriteName .. " which has frame index " ..  sheetInfo.getFrameForName(spriteName));
    local sprite = display.newImage(imageSheet, sheetInfo.getFrameForName(spriteName));
    
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