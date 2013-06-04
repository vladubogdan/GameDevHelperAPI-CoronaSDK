
--!@docBegin
--!In Box2d, a body can have multiple shapes. SpriteHelper lets you define this multiple shapes very easy. 
--!
--!This class is just a represetation of those shapes in order to differentiate between each shape in the body when you receive collision notifications.
--!
--!@docEnd

GHShape = {}
function GHShape:createWithDictionary(dictionary, sprite, physics, completeBodyFixtures)

	local object = {lhFixtureName = dictionary.name,
					lhFixtureID = dictionary.tag,
					coronaMinFixtureIdForThisObject = 1,
					coronaMaxFixtureIdForThisObject = 1,
					fixtureShape = {},
					}
	setmetatable(object, { __index = GHShape })  -- Inheritance	
	
	
    local fcollisionFilter = { 	categoryBits = dictionary.category,	
								maskBits 	 = dictionary.mask } 

    local fdensity 		= dictionary.density;
	local ffriction 	= dictionary.friction;
	local frestitution	= dictionary.restitution;
        
	local fsensor 	= dictionary.sensor;
        
    --local offset 	= dictionary:pointForKey("LHShapePositionOffset");
	
	local fixturePoints = dictionary["fixtures"];
	--if(nil ~= fixturePoints)then --fixture object may be missing - this way we dont get a warning
	--	fixturePoints = {};
	--end

    local type = dictionary.type;
    
	sprW = sprite.width/2.0;
	sprH = sprite.height/2.0;

	sprScaleX = sprite.xScale;
	sprScaleY = sprite.yScale;
    
    local GHUtils = require("GameDevHelperAPI.GHUtils");
    
    if(type == 2)then --circle
        
        --No way to offset a circle inside Corona - really bad that this feature is missing
        local radius = dictionary.radius/2.0*sprScaleX;
        if(radius < 0)then
            radius = radius*(-1.0);
        end
		currentFixInfo = { density 	= fdensity,
						   friction = ffriction,
						   bounce 	= frestitution,
						   isSensor = fsensor,
						   radius 	= radius,
						   filter 	= fcollisionFilter
						 }
							 
		object.fixtureShape[#object.fixtureShape+1] = currentFixInfo;
		completeBodyFixtures[#completeBodyFixtures+1] = object.fixtureShape[#object.fixtureShape];
    else
        for i=1, #fixturePoints do
		
			local fixInfo = fixturePoints[i];
					
			local verts = {};
			local k = #fixInfo;
            
            for j = 1, #fixInfo do
                
                local idx = j;
                
                if( (sprScaleX < 0  and sprScaleY >= 0) or 
                    (sprScaleX >= 0 and sprScaleY < 0) )then
                    idx = j;
                end
            
				local pt = GHUtils.pointFromString(fixInfo[idx]);
				
				--pt.y = sprite.height - pt.y;
				--pt.y = pt.y - sprite.height;
			
				verts[#verts+1] = pt.x*sprScaleX;
				verts[#verts+1] = pt.y*sprScaleY;		
				k = k -1		
			end
						
			currentFixInfo = { density 	= fdensity,
							   friction = ffriction,
							   bounce 	= frestitution,
							   isSensor = fsensor,
							   shape 	= verts,
							   filter 	= fcollisionFilter
							 }
	
			object.fixtureShape[#object.fixtureShape+1] = currentFixInfo;
			completeBodyFixtures[#completeBodyFixtures+1] = object.fixtureShape[#object.fixtureShape];
        end
    end
    
	
--	if(fixturePoints ~= nil and fixturePoints:count() > 0 and
--	   fixturePoints:objectAtIndex(1).m_type == 5)then 
--		
--		for i=1,fixturePoints:count() do
--		
--			local fixInfo = fixturePoints:objectAtIndex(i);
--			
--			if(fixInfo.m_type ~= 5)then--array type
--				 print("ERROR: Please update to SpriteHelper 1.8.1 and resave all your scenes. Body will be created without a shape.");
--				 break;
--			end
--		
--			fixInfo = fixInfo:arrayValue()
--			local verts = {};
--			local k = fixInfo:count();
--            
--            for j = 1, fixInfo:count()do
--                
--                local idx = k;
--                
--                if( (sprScaleX < 0  and sprScaleY >= 0) or 
--                    (sprScaleX >= 0 and sprScaleY < 0) )then
--                    idx = j;
--                end
--            
--				local pt = lh_pointFromString(fixInfo:objectAtIndex(idx):stringValue());
--				
--				pt.y = coronaSprite.height - pt.y;
--				pt.y = pt.y - coronaSprite.height;
--			
--				verts[#verts+1] = pt.x*sprScaleX;
--				verts[#verts+1] = pt.y*sprScaleY;		
--				k = k -1		
--			end
--						
--			currentFixInfo = { density 	= fdensity,
--							   friction = ffriction,
--							   bounce 	= frestitution,
--							   isSensor = fisSensor,
--							   shape 	= verts,
--							   filter 	= fcollisionFilter
--							 }
--	
--			object.fixtureShape[#object.fixtureShape+1] = currentFixInfo;
--			completeBodyFixtures[#completeBodyFixtures+1] = object.fixtureShape[#object.fixtureShape];
--
--		
--		end


	return object
end
--------------------------------------------------------------------------------
function GHShape:removeSelf()

	--print("GHShape removeSelf");

	self.coronaMinFixtureIdForThisObject = nil
 	self.coronaMaxFixtureIdForThisObject = nil
	self.lhFixtureName = nil;
	self.lhFixtureID = nil;
	self.fixtureShape = nil;
	self = nil
end
