

require('GameDevHelperAPI.GHAffineTransform');
local GHUtils = require('GameDevHelperAPI.GHUtils')

--!@docBegin
--!This is a helper class that connects a bone to a sprite.
--! 
--!End users will probably never have to use this class directly.
--!@docEnd

GHBoneSkin = {}

--!@docBegin
--!Creates a GHBoneSkin object.
function GHBoneSkin:init()
--!@docEnd

    local object = {sprite = nil,
                    bone = null,
                    name = "",
                    uuid = "",
                    positionOffsetX = 0,
                    positionOffsetY = 0,
                    angleOffset = 0,
                    connectionAngle = 0,
                    skeleton = nil
					}

	setmetatable(object, { __index = GHBoneSkin })  -- Inheritance	
	return object
end




--!@docBegin
--!Creates the bone skin with the given arguments.
--!@param sprite The sprite object this skin should use.
--!@param bone The bone object this skin should use.
--!@param skinName The skin name. A string value.
--!@param skinUUID The skin unique id. A string value.
--!@param skeleton The skeleton object. A GHSkeleton object.
function GHBoneSkin:create(sprite, bone, skinName, skinUUID, skeleton)
--!@docEnd

    --load from constructor
    self.sprite = sprite;
    self.bone = bone;
    self.name = skinName;
    self.uuid = skinUUID;
    self.skeleton = skeleton;
    
    return self;
end


--!@docBegin
--!Get the sprite used in this object.
function GHBoneSkin:getSprite()
--!@docEnd
	return self.sprite;
end


--!@docBegin
--!Get the bone used in this object. A GHBone object.
function GHBoneSkin:getBone()
--!@docEnd
	return self.bone;
end

--!@docBegin
--!Set the bone that will be used by this object.
function GHBoneSkin:setBone(newBone)
--!@docEnd
	self.bone = nil;
	self.bone = newBone;
end

--!@docBegin
--!Get the name of this skin connection as a string value.
function GHBoneSkin:getName()
--!@docEnd

	return self.name;  
end

--!@docBegin
--!Get the unique identifier of this connection as a string value.
function GHBoneSkin:getUUID()
--!@docEnd
	return self.uuid;
end


--!@docBegin
--!Set the angle offset that is used when transforming a sprite based on bone movement.
--!@param newVal a numeric value in degrees.
function GHBoneSkin:setAngleOffset(newVal)
--!@docEnd
	self.angleOffset = newVal;
end


--!@docBegin
--!Set the original angle at which the sprite was connected to the bone.
--!@param newVal a numeric value in degrees.
function GHBoneSkin:setConnectionAngle(newVal)
--!@docEnd
	self.connectionAngle = newVal;
end


--!@docBegin
--!Set the position offset that is used when transforming a sprite based on bone movement.
--!@param newValX a numeric value
--!@param newValY a numeric value
function GHBoneSkin:setPositionOffset(newValX, newValY)
--!@docEnd
	self.positionOffsetX = newValX;
	self.positionOffsetY = newValY;
end

--!@docBegin
--!Updates positionOffset, angleOffset and connectionAngle based on the bone movement.
function GHBoneSkin:setupTransformations( )
--!@docEnd

	if self.bone ~= nil and self.sprite ~= nil and self.skeleton ~= nil then
	
		local _father = self.bone:getParent();
		self.angleOffset = 0;
		
		local bonePointX = _father:getPositionX();
		local bonePointY = _father:getPositionY();
		
		local currentPosX = self.sprite.localPosX;
		local currentPosY = self.sprite.localPosY;
		
		local curAngle = self.sprite.angle;
		self.connectionAngle = curAngle;
		
		local posOffsetX = currentPosX - bonePointX;
		local posOffsetY = bonePointY - currentPosY;
		
		self.positionOffsetX = posOffsetX;
		self.positionOffsetY = posOffsetY;
		
		local boneAngle = self.bone:degrees();
		self.angleOffset = boneAngle - curAngle;	
	end
end

--!@docBegin
--!Updates sprite position and rotation based on the bone movement.
function GHBoneSkin:transform()
--!@docEnd

	if self.sprite ~= nil or self.bone ~= nil or self.skeleton ~= nil then
        return;
    end
	
	
	local degrees = self.bone:degrees();
	
	local posOffsetX = self.positionOffsetX;
	local posOffsetY = self.positionOffsetY;
	
	local bonePosX = self.bone:getParent():getPositionX();
	local bonePosY = self.bone:getParent():getPositionY();

	
	local transformOffset = GHAffineTransformTranslate(GHAffineTransformMakeIdentity(), 
														bonePosX,
														bonePosY);
														
	local transform = GHAffineTransformRotate(GHAffineTransformMakeIdentity(), 
											GHDegreesToRadians(degrees - self.angleOffset));
	
	local originX = 0.0;
	local originY = 0.0;
	
	local upwardX = 0.0;
	local upwardY= -10.0;
	 
	local transform3 = GHAffineTransformRotate(GHAffineTransformMakeIdentity(), 
						GHDegreesToRadians(degrees - self.angleOffset - self.connectionAngle));
	
	local posOffset = GHPointApplyAffineTransform(posOffsetX, posOffsetY, transform3);
	posOffsetX = posOffset.x;
	posOffsetY = posOffset.y;
	
	
	local origin = GHPointApplyAffineTransform(originX, originY, transform);
	originX = origin.x;
	originY = origin.y;
	
	local upward = GHPointApplyAffineTransform(upwardX, upwardY, transform);
	upwardX = upward.x;
	upwardY = upward.y;
	
	
	origin = GHPointApplyAffineTransform(originX, originY, transformOffset);
	originX = origin.x;
	originY = origin.y;
	
	
	upward = GHPointApplyAffineTransform(upwardX, upwardY, transformOffset);
	upwardX = upward.x;
	upwardY = upward.y;
	
	
	local newAngle = (math.atan2( upwardY - originY, 
								upwardX - originX)*180.0)/math.pi + 90.0;
	
	
	local rootBone = self.skeleton:getRootBone();
	

	self.sprite.x = originX + posOffsetX - self.sprite.width*0.5        + self.skeleton:getPositionX();
	self.sprite.y = -1*(originY - posOffsetY) - self.sprite.height*0.5  + self.skeleton:getPositionY();
	
	self.sprite.localPosX = self.sprite.x - self.skeleton:getPositionX();
	self.sprite.localPosY = self.sprite.y - self.skeleton:getPositionY();
	
	
	self.sprite.rotate(newAngle);
end
