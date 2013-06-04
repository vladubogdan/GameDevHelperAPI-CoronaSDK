
module (..., package.seeall)

--!@docBegin
--!This class provides frienly methods to create sprites and change its properties.
--! 
--!@docEnd


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
--!    local sprite = GHSprite.createWithFile("Assets/PhysicalSpritesObjects_Objects.png", "banana");
--!@endcode
function createWithFile(imageFilePath, spriteName, base)
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
    local GHSprite = display.newImage(imageSheet, sheetInfo.getFrameForName(spriteName));
    --here i call the local GHSprite only because i want the documentation parser to know where to add this method
    --i could have called it in any way.
    
--------------------------------------------------------------------------------    
--------------------------------------------------------------------------------    
--add GameDevHelper related methods to the sprite    

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
--execute related creation methods 
    local physicsPath = GHUtils.getPathFromFilename(imageFilePath);
    physicsPath = physicsPath .. "Bodies/";
    
    local fileName = GHUtils.getFileFromFilename(imageFilePath);
    fileName = GHUtils.stripExtension(fileName);
    fileName = fileName .. ".json";
    
    physicsPath = physicsPath .. fileName;
    -- set default base dir if none specified
    if not base then base = system.ResourceDirectory; end
    local jsonContent = GHUtils.jsonFileContent(physicsPath, base);
    if(jsonContent)then
        local json = require "json"
        GHSprite.physicsInfo = json.decode( jsonContent )[spriteName];
        
        if(GHSprite.physicsInfo)then
           GHSprite:createBody(); 
        end
    end
    
    
    return GHSprite;
end
