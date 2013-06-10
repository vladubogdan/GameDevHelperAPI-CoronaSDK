
module (..., package.seeall)

--!@docBegin
--!This class provides frienly methods to create sprites and change its properties.
--! 
--!@docEnd

local GHSprite = nil;

local function addGHSpriteMethods()

--------------------------------------------------------------------------------    
--------------------------------------------------------------------------------    
--add GameDevHelper related methods to the sprite    

--!@docBegin
--!Set the texture rect coresponding to the frame name given. In other words, changes sprite representation with a new sprite.
--!@param name A string value represeting the name of the sprite as defined in SpriteHelper. Note that the sprite name must be a sprite in the same sheet as current sprite. 
--!User should only call this function if destroyBody was previously called.
function GHSprite:setFrameName(name)
--!@docEnd
    local idx = self.frameNamesMap[name];
    if(idx)then
        self:setFrame(idx);
    end
end

--!@docBegin
--!Creates physical body on the sprite body. This function is called when creating the sprite.
--! 
--!User should only call this function if destroyBody was previously called.
    function GHSprite:createBody()
--!@docEnd

        local physics = require("physics")
    
        if(nil == physics)then
    	    return
	    end
    
        
        local pType = self.physicsInfo.type;
        
        if(pType == 3) then--NO PHYSICS
	    	return
	    end

	    local physicType = "static"	
	    if(pType == 1)then
		    physicType = "kinematic";
	    elseif(pType == 2)then
		    physicType = "dynamic";
	    end

	    local shapes = self.physicsInfo.shapes;
	
	    if(nil == shapes)then
		    return
	    end

        local completeBodyFixtures = {};
    
        require("GameDevHelperAPI.GHShape");
    
	    self.ghShapes = {};
	
 	    for i=1, #shapes do
 		    local shInfo = shapes[i];
		    local previousFixSize = #completeBodyFixtures
 		    local shape = GHShape:createWithDictionary(shInfo, self, physics, completeBodyFixtures);

		    shape.coronaMinFixtureIdForThisObject = previousFixSize +1;
 		    shape.coronaMaxFixtureIdForThisObject = #completeBodyFixtures;
 		 		
	    	self.ghShapes[#self.ghShapes +1] = shape;		
        end
 
        physics.addBody(self, 
		    			physicType,
					    unpack(completeBodyFixtures))

	    self.isFixedRotation    = self.physicsInfo.fixed;
	    self.isBullet           = self.physicsInfo.bullet;
	    self.isSleepingAllowed  = self.physicsInfo.sleep;
	    self.gravityScale       = self.physicsInfo.gravityScale;

    end
--------------------------------------------------------------------------------    
--!@docBegin
--!Destroys the physical body available on this sprite.
function GHSprite:destroyBody(arg1, arg2, arg3)
--!@docEnd

print("did destroy body on " .. tostring(self));
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--!@docBegin
--!Prepares an animation to be played on the sprite object. Animation name should be one of the animations given when the sprite was crated with createAnimatedSpriteWithFile .
function GHSprite:prepareAnimationNamed(animName)
--!@docEnd

    self:stopAnimation();
    self.activeAnimation = nil;
    self.activeAnimation = self.animations[animName];

    if self.activeAnimation then
        self.activeAnimation.playing = false;
        self.activeAnimation.firstEnterFrameCall = true;
        self.activeAnimation.spriteObject = self;
        self:setSequence( animName );
        print("did prepare anim with name " .. self.activeAnimation.name);
        
        Runtime:addEventListener( "enterFrame", self.activeAnimation )
    end
end
--------------------------------------------------------------------------------
--!@docBegin
--!Plays the prepared sprite sheet animation on the sprite object.
function GHSprite:playAnimation()
--!@docEnd
    if self.activeAnimation then
        self.activeAnimation.playing = true;
    end
end
--------------------------------------------------------------------------------
--!@docBegin
--!Stops the active sprite sheet animation playing on the sprite object.
function GHSprite:stopAnimation()
--!@docEnd

    if self.activeAnimation then
        Runtime:removeEventListener( "enterFrame", self.activeAnimation )
        self.activeAnimation = nil;
    end
end
--------------------------------------------------------------------------------
--!@docBegin
--!Stops the active sprite sheet animation playing on the sprite object.
function GHSprite:setDidChangeFrameNotificationObserver(callback)
--!@docEnd
    self.didChangeFrameNotificationCallback = callback;
end

--!@docBegin
--!Stops the active sprite sheet animation playing on the sprite object.
function GHSprite:setDidFinishRepetitionNotificationObserver(callback)
--!@docEnd
    self.didFinishRepetitionNotificationCallback = callback;
end
--!@docBegin
--!Stops the active sprite sheet animation playing on the sprite object.

function GHSprite:setDidFinishPlayingNotificationObserver(callback)
--!@docEnd
    self.didFinishPlayingNotificationCallback = callback;
end

--!@docBegin
--!Stops the active sprite sheet animation playing on the sprite object.
function GHSprite:getUserInfoForFrameAtIndex(frmIdx)
--!@docEnd
    if(self.activeAnimation ~= nil)then
        local frm = self.activeAnimation.frames[frmIdx];
        if(frm)then
        
            return frm:getUserInfo();
        end
    end
    return nil;
end
    
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
end

function ghRemoveSelf(selfSprite)
    selfSprite:stopAnimation();
    selfSprite:destroyBody();
    selfSprite:originalCoronaRemoveSelf();
end


function loadPhysicsForImageFileAndSpriteName(imageFilePath, spriteName)
--execute related creation methods 
   local GHUtils = require("GameDevHelperAPI.GHUtils");
   
    local physicsPath = GHUtils.getPathFromFilename(imageFilePath);
    physicsPath = physicsPath .. "Bodies/";
    
    local fileName = GHUtils.getFileFromFilename(imageFilePath);
    fileName = GHUtils.stripExtension(fileName);
    fileName = fileName .. ".json";
    
    physicsPath = physicsPath .. fileName;
    -- set default base dir if none specified
    if not base then base = system.ResourceDirectory; end
    print("physics path " ..physicsPath);
    local jsonContent = GHUtils.jsonFileContent(physicsPath, base);
    if(jsonContent)then
        local json = require "json"
        GHSprite.physicsInfo = json.decode( jsonContent )[spriteName];
        
        if(GHSprite.physicsInfo)then
           GHSprite:createBody(); 
        end
    end
end

--!@docBegin
--!Creates a sprite object using the image file and the sprite name. 
--! 
--!The physical info file path will be automatically calculated from the image path and the physics will be loaded only if the the physic engine is started and the body has a type other then NO PHYSICS.
--!@param imageFilePath The path to the image file.
--!@param spriteName The name of the sprite as defined in SpriteHelper.
--!@param base Optional parameter. Specify where to look for the file. Default value is system.ResourceDirectory.
--!@return Returns the sprite display object.
--!
--!Example Code: 
--!@code
--!    local GHSprite =  require("GameDevHelperAPI.GHSprite");
--!    local sprite = GHSprite.createSpriteWithFile("Assets/PhysicalSpritesObjects_Objects.png", "banana");
--!@endcode
function createSpriteWithFile(imageFilePath, spriteName, base)
--!@docEnd
    
    local GHUtils = require("GameDevHelperAPI.GHUtils");

    
--create the actual sprite
    local spriteSheetPath = GHUtils.stripExtension(imageFilePath);
    spriteSheetPath = GHUtils.replaceOccuranceOfStringWithString( spriteSheetPath, "/", "." )
        
    -- require the sprite sheet information file
    local sheetInfo = require(spriteSheetPath); 
    --create the image sheet
    local imageSheet = graphics.newImageSheet( imageFilePath, sheetInfo.getSpriteSheetData() );
    --create the sprite
    --local GHSprite = display.newImage(imageSheet, sheetInfo.getFrameForName(spriteName));
    --here i call the local GHSprite only because i want the documentation parser to know where to add this method
    --i could have called it in any way.
    
    local imageFile = GHUtils.getFileFromFilename(imageFilePath);
    -- consecutive frames
    local sequenceData = {
        name=imageFile,
        start=1,
        count=sheetInfo.getFramesCount()
    }
    GHSprite = display.newSprite( imageSheet, sequenceData )

    GHSprite:setFrame(sheetInfo.getFrameForName(spriteName));
    GHSprite.frameNamesMap = GHUtils.GHDeepCopy(sheetInfo.getFrameNamesMap());
    
    addGHSpriteMethods();

    loadPhysicsForImageFileAndSpriteName(imageFilePath, spriteName);    
    
    return GHSprite;
end

--!@docBegin
--!Creates an animated sprite object using the animation json file and the animation sequence names that should be available on the created sprites. 
--! 
--!@param animJsonFilePath The path to the json animation file that was generated using SpriteHelper.
--!@param animationSequenceNames The names of the animations that should be available on the sprite object as a table.
--!@param bodySpriteName The sprite name whose info should be used to generated a physical body. Body sprite should be a sprite available in the sheet that is used by first animation.
--!@param base Optional parameter. Specify where to look for the file. Default value is system.ResourceDirectory.
--!@return Returns the sprite display object.
--!
--!Example Code: 
--!@code
--! local GHSprite = require("GameDevHelperAPI.GHSprite");
--! local animatedSprite = GHSprite.createAnimatedSpriteWithFile(  "Assets/sheetAnimations/spriteSheetAnimationsTest_SheetAnimations.json", 
--!                                                             {"NumbersAnim", "fireAnim"});
--! animatedSprite:prepareAnimationNamed("NumbersAnim");
--! animatedSprite:playAnimation();
--!@endcode
function createAnimatedSpriteWithFile(animJsonFilePath, animationSequenceNames, bodySpriteName, base)
--!@docEnd
    
    local GHUtils = require("GameDevHelperAPI.GHUtils");

    local jsonInfo = nil;
    if not base then base = system.ResourceDirectory; end
    local jsonContent = GHUtils.jsonFileContent(animJsonFilePath, base);
    if(jsonContent)then
        local json = require "json"
        jsonInfo = json.decode( jsonContent );
    end

    local imageFile = nil;
    if jsonInfo then
        
        local sheetPath = GHUtils.getPathFromFilename(animJsonFilePath);
        
        GHSpriteSheetAnimation = require("GameDevHelperAPI.GHSpriteSheetAnimation");
        local sequenceData, imageSheet, imageFilePath, ghAnims = GHSpriteSheetAnimation.sequenceDataAndImageSheetForAnimations( animationSequenceNames, 
                                                                                                        sheetPath, 
                                                                                                        jsonInfo.animations);
                                                                                                    
        if sequenceData and imageSheet and imageFilePath and ghAnims then
            imageFile = imageFilePath; 
            GHSprite = display.newSprite( imageSheet, sequenceData )
            GHSprite.animations = ghAnims;
        end
        
    end

    if GHSprite and imageFile then
        
        addGHSpriteMethods();
        
        --overloaded functions
        ----------------------------------------------------------------------------
	    GHSprite.originalCoronaRemoveSelf 	= GHSprite.removeSelf;
	    GHSprite.removeSelf 				= ghRemoveSelf;
    
        if(bodySpriteName)then
            loadPhysicsForImageFileAndSpriteName(imageFile, bodySpriteName);    
        end
        
    end
    
    return GHSprite;
end