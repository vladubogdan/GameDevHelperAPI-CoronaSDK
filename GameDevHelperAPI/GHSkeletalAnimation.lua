--
--GHSkeletalAnimation
--@author Vladu Bogdan Daniel
--Copyright (c) 2013 VLADU BOGDAN DANIEL PFA
--
local GHUtils = require('GameDevHelperAPI.GHUtils')

GHSkeletalSkinConnectionInfo = {}
function GHSkeletalSkinConnectionInfo:init()
    
    local object = {boneName = "",
                    angleOffset = 0,
                    connectionAngle = 0,
                    positionOffsetX = 0,
                    positionOffsetY = 0,
                    positionX = 0,
                    positionY = 0,
                    angle = 0
					}

	setmetatable(object, { __index = GHSkeletalSkinConnectionInfo })  -- Inheritance	
    
	return object
end


function GHSkeletalSkinConnectionInfo:createWithBoneName(name)
    self.boneName = name;
    return self;
end

function GHSkeletalSkinConnectionInfo:createWithSkinConnection(other)
	self:createWithBoneName(other:getBoneName());
	self:setAngleOffset(other.angleOffset);
	self:setConnectionAngle(other.connectionAngle);
	self:setPositionOffset(other.positionOffsetX, other.positionOffsetY);
	self:setPosition(other.positionX, other.positionY);
	self:setAngle(other.angle);
	return self;
end

function GHSkeletalSkinConnectionInfo:getBoneName()
	return self.boneName;
end

function GHSkeletalSkinConnectionInfo:getAngleOffset()
	return self.angleOffset;
end

function GHSkeletalSkinConnectionInfo:setAngleOffset(val)
	self.angleOffset = val;
end

function GHSkeletalSkinConnectionInfo:getConnectionAngle()
    return self.connectionAngle;
end

function GHSkeletalSkinConnectionInfo:setConnectionAngle(val)
    self.connectionAngle = val;
end

function GHSkeletalSkinConnectionInfo:getPositionOffsetX()
    return self.positionOffsetX;
end
function GHSkeletalSkinConnectionInfo:getPositionOffsetY()
    return self.positionOffsetY;
end
function GHSkeletalSkinConnectionInfo:setPositionOffset(valX, valY)
    self.positionOffsetX = valX; 
    self.positionOffsetY = valY;
end


function GHSkeletalSkinConnectionInfo:getPositionX()
    return self.positionX;
end
function GHSkeletalSkinConnectionInfo:getPositionY()
    return self.positionY;
end
function GHSkeletalSkinConnectionInfo:setPosition(valX, valY)
    self.positionX = valX; 
    self.positionY = valY;
end

function GHSkeletalSkinConnectionInfo:getAngle()
    return angle;
end
function GHSkeletalSkinConnectionInfo:setAngle(val)
    angle = val;
end



--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
GHSkeletalAnimationFrame = {}
function GHSkeletalAnimationFrame:init()
    
    local object = {time = 0,
	                bonePositions = nil,
	                spritesZOrder = nil,
	                skinConnections = nil,
	                skinSprites = nil,
	                spritesVisibility = nil,
	                spritesTransform = nil
    				}

	setmetatable(object, { __index = GHSkeletalAnimationFrame })  -- Inheritance	
    
	return object
end

function GHSkeletalAnimationFrame:createWithTime(tm)
	self.time = tm;
	return self;
end
	
--function GHSkeletalAnimationFrame:createWithFrame(other)
--
--	self.time = other:getTime();
--
--    do--copy positions
--        local bonePoses = other.getBonePositions();
--        if(bonePoses)then
--            self.bonePositions = {};
--            
--            for key,value in pairs(bonePoses) do                
--                self.bonePositions[key] = GHUtils.GHDeepCopy(value);
--            end
--        end
--    end
--
--    {//copy sprites z order
--        var zOrders = other.getSpritesZOrder();
--        if(zOrders)
--        {
--            self.spritesZOrder = [];
--            for(var key in zOrders)
--            {
--                self.spritesZOrder[key] = GHDeepCopy(zOrders[key]);
--            }
--        }
--    }
--
--    {//copy skin connections
--        var skinCon = other.getSkinConnections();
--        if(skinCon)
--        {
--            self.skinConnections = [];
--            for(var key in skinCon)
--            {
--                self.skinConnections[key] =  new GHSkeletalSkinConnectionInfo().createWithSkinConnection(skinCon[key]);
--            }
--        }
--    }
--
--    {//copy skin sprites
--        var skinSpr = self.getSkinSprites();
--        if(skinSpr)
--        {
--            self.skinSprites = [];
--            for(var key in skinSpr)
--            {
--                self.skinSprites[key] = GHDeepCopy(skinSpr[key]);
--            }
--        }
--    }
--
--    {//copy sprites visibility
--        var sprVis = self.getSpritesVisibility();
--        if(sprVis)
--        {
--            self.spritesVisibility = [];
--            for(var key in sprVis)
--            {
--                self.spritesVisibility[key] = GHDeepCopy(sprVis[key]);
--            }
--        }
--    }
--
--    {//copy sprites transform
--        var sprTrans = self.getSpritesTransform();
--        if(sprTrans)
--        {
--            self.spritesTransform = [];
--            for(var key in sprTrans)
--            {
--                self.spritesTransform[key] = new GHSkeletalSkinConnectionInfo().createWithSkinConnection(sprTrans[key]);
--            }
--        }
--    }
--
--	return self;
--}

function GHSkeletalAnimationFrame:getTime()
	return self.time;
end
function GHSkeletalAnimationFrame:setTime(val)
	self.time = val;
end

function GHSkeletalAnimationFrame:getBonePositions()
	return self.bonePositions;
end
function GHSkeletalAnimationFrame:getSpritesZOrder()
	return self.spritesZOrder;
end
function GHSkeletalAnimationFrame:getSkinConnections()
	return self.skinConnections;
end
function GHSkeletalAnimationFrame:getSkinSprites()
	return self.skinSprites;
end
function GHSkeletalAnimationFrame:getSpritesVisibility()
	return self.spritesVisibility;
end
function GHSkeletalAnimationFrame:getSpritesTransform()
	return self.spritesTransform;
end

function GHSkeletalAnimationFrame:setBonePositionsWithDictionary(bones)
	if(nil == bones)then
		return;
	end
    
    self.bonePositions = {};
   
    for key,value in pairs(bones) do  
        local boneName = key;
        local bonePos = value;
        if(bonePos)then
            local position = GHUtils.pointFromString(bonePos);
            self.bonePositions[boneName] = {x=position.x, y= position.y};
        end
    end
end

function GHSkeletalAnimationFrame:setSpritesZOrderWithDictionary(sprites)
    if(nil == sprites)then
     	return;
    end
    self.spritesZOrder = GHUtils.GHDeepCopy(sprites);
end

function GHSkeletalAnimationFrame:setSkinConnectionsWithDictionary(connections)

    if(connections == nil)then
        return;
    end
    self.skinConnections = {};
    
    for key,value in pairs(connections) do  
        local sprName = key;
        local connectionInfo = value;--connections[sprName];
        
        if(connectionInfo)then
            local boneName = connectionInfo.bone;
            local angleOff = connectionInfo.angleOff;
            local connAngle= connectionInfo.connAngle;
            local posOff   = GHUtils.pointFromString(connectionInfo.posOff);
            
            local skinInfo = nil;
            if(boneName)then
                skinInfo = GHSkeletalSkinConnectionInfo:init():createWithBoneName(boneName);
            else
                skinInfo = GHSkeletalSkinConnectionInfo:init():createWithBoneName(nil);
            end
            
            if(skinInfo)then
                skinInfo:setAngleOffset(angleOff);
                skinInfo:setConnectionAngle(connAngle);
                skinInfo:setPositionOffset(posOff.x, posOff.y);
                self.skinConnections[sprName] = skinInfo;
            end   
        end
    end
end
function GHSkeletalAnimationFrame:setSkinSpritesWithDictionary(dictionary)
    if(dictionary == nil)then
        return;
    end
    self.skinSprites = GHUtils.GHDeepCopy(dictionary);  
end
function GHSkeletalAnimationFrame:setSpritesVisibilityWithDictionary(dictionary)
    if(dictionary == nil)then
        return;
    end
    self.spritesVisibility = GHUtils.GHDeepCopy(dictionary);    
end
function GHSkeletalAnimationFrame:setSpritesTransformWithDictionary(dictionary)
    if(dictionary == nil)then
        return;
    end
    
    self.spritesTransform = {};
    
    for key,value in pairs(dictionary) do 
        local sprName = key;
        local transformInfo = value;--dictionary[sprName];
        
        if(transformInfo)then
            local angleOff = transformInfo.angleOff;
            local connAngle= transformInfo.connAngle;
            local posOff = GHUtils.pointFromString(transformInfo.posOff);
            
            local angle = transformInfo.angle;
            local position = GHUtils.pointFromString(transformInfo.position);
            
            local transform = GHSkeletalSkinConnectionInfo:init():createWithBoneName(nil);
            
            if(transform)then
                transform:setAngleOffset(angleOff);
                transform:setConnectionAngle(connAngle);
                transform:setPositionOffset(posOff.x, posOff.y);
                
                transform:setAngle(angle);
                transform:setPosition(position.x, position.y);
                
                self.spritesTransform[sprName] = transform;
            end 
        end
    end
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--!@docBegin
--!GHSkeletalAnimation is used to load skeletons animations and then play them on the skeleton. 
--!@docEnd

GHSkeletalAnimation = {}

--!@docBegin
--!Creates a skeletal animation using the content of a json file.
--!@param animationFileName The path of the animation json file.
function GHSkeletalAnimation:createWithFile(animationFileName)
--!@docEnd

    local object = {name = "",
                    totalTime = 0.0,
                    currentTime = 0.0,
	                playMode = 0,
	                bonePositionFrames = {},
	                spriteZOrderFrames = {},
	                skinConnectionFrames = {},
	                skinSpriteFrames = {},
	                visibilityFrames = {},
	                spritesTransformFrames = {},
	                numberOfLoops = 0,
	                currentLoop = 0,
	                reversed = false,
                    paused = false
					}

	setmetatable(object, { __index = GHSkeletalAnimation })  -- Inheritance	
    
	
	local dict = nil;

    if not base then base = system.ResourceDirectory; end
    local jsonContent = GHUtils.jsonFileContent(animationFileName, base);
    if(jsonContent)then
        local json = require "json"
        dict = json.decode( jsonContent );
    end
    
	if(dict ~= nil)then
        object:createWithDictionary(dict);
    end
	
	return object;
    
end

function GHSkeletalAnimation:createWithDictionary(dict)
	if(dict.name)then
		self.name = dict.name
	else
		self.name = "UntitledAnimation";
	end
	
	self.totalTime = dict.totalTime;
	self.playMode = dict.playMode;
	
	do--setting bone positions
		local posFrames = dict.positionFrames;
        for i=1, #posFrames do
			local frmInfo = posFrames[i];
			local frmTime = frmInfo.time;
			
			local frm = GHSkeletalAnimationFrame:init():createWithTime(frmTime);
			frm:setBonePositionsWithDictionary(frmInfo.bones);
			self.bonePositionFrames[#self.bonePositionFrames+1] = frm;
		end
	end
	
	do--setting sprites z order
		local zOrderFrames = dict.zOrderFrames;
        for i = 1, #zOrderFrames do
			local frmInfo = zOrderFrames[i];
			local frmTime = frmInfo.time;
			
			local frm = GHSkeletalAnimationFrame:init():createWithTime(frmTime);
			frm:setSpritesZOrderWithDictionary(frmInfo.sprites);
			self.spriteZOrderFrames[#self.spriteZOrderFrames+1] = frm;
		end
	end
	
	do--setting skin connections
		local frames = dict.connectionFrames;
        for i = 1, #frames do
			local frmInfo = frames[i];
			local frmTime = frmInfo.time;
			
			local frm = GHSkeletalAnimationFrame:init():createWithTime(frmTime);
			frm:setSkinConnectionsWithDictionary(frmInfo.connections);
			self.skinConnectionFrames[#self.skinConnectionFrames+1] =frm;
		end
	end
	
	do--setting skin sprite frames
		local frames = dict.skinFrames;
        for i =1, #frames do
			local frmInfo = frames[i];
			local frmTime = frmInfo.time;
			
			local frm = GHSkeletalAnimationFrame:init():createWithTime(frmTime);
			frm:setSkinSpritesWithDictionary(frmInfo.skins);
			self.skinSpriteFrames[#self.skinSpriteFrames+1] = frm;
		end
	end
	
	do--setting sprite visibility frames
		local frames = dict.visibilityFrames;
        for i = 1, #frames do
			local frmInfo = frames[i];
			local frmTime = frmInfo.time;
			
			local frm = GHSkeletalAnimationFrame:init():createWithTime(frmTime);
			frm:setSpritesVisibilityWithDictionary(frmInfo.sprites);
			self.visibilityFrames[#self.visibilityFrames+1] = frm;
		end
	end
	
	do--setting sprite transform frames
		local frames = dict.spriteTransformFrames;
        for i =1, #frames do
			local frmInfo = frames[i];
			local frmTime = frmInfo.time;
			
		    local frm = GHSkeletalAnimationFrame:init():createWithTime(frmTime);
			frm:setSpritesTransformWithDictionary(frmInfo.transform);
			self.spritesTransformFrames[#self.spritesTransformFrames+1] =frm;
		end
	end

	return self;	
end


function GHSkeletalAnimation:copyFramesFrom(otherArray)

    if(otherArray)then
    
        local toArray = {};
        
        for i = 1, #otherArray do
            local frm = otherArray[i];
            if(frm)then
                toArray[#toArray +1] = GHSkeletalAnimationFrame:init():createWithFrame(frm); 
            end   
        end
        return toArray;
    end
    return nil;
end

--function GHSkeletalAnimation:createWithAnimation(other)
--
--	--WE SHOULD CREATE NEW FRAMES FROM THIS ANIMATIONS FRAMES IN CASE THE USER CHANGES THE TIME
--    --OF AN ANIMATION TO NOT CHANGE ON ALL SAME ANIMATIONS
--
--    if(other.getBonePositionFrames())
--    {
--        self.bonePositionFrames  = [];
--        
--        for(var i = 0; i < other.getBonePositionFrames().length; ++i)
--        {
--            var frm = other.getBonePositionFrames()[i];
--            if(frm)
--            {
--                self.bonePositionFrames.push(new GHSkeletalAnimationFrame().createWithFrame(frm));
--            }   
--        }
--    }
--
--
--    if(other.getSpriteZOrderFrames())
--    {
--        self.spriteZOrderFrames  = [];
--        
--        for(var i = 0; i < other.getSpriteZOrderFrames().length; ++i)
--        {
--            var frm = other.getSpriteZOrderFrames()[i];
--            if(frm)
--            {
--                self.spriteZOrderFrames.push(new GHSkeletalAnimationFrame().createWithFrame(frm));
--            }   
--        }
--    }        
--
--   
--    if(other.getSkinConnectionFrames())
--    {
--        self.skinConnectionFrames  = [];
--        
--        for(var i = 0; i < other.getSkinConnectionFrames().length; ++i)
--        {
--            var frm = other.getSkinConnectionFrames()[i];
--            if(frm)
--            {
--                self.skinConnectionFrames.push(new GHSkeletalAnimationFrame().createWithFrame(frm));
--            }   
--        }
--    }
--    
--    
--    if(other.getSkinSpriteFrames())
--    {
--        self.skinSpriteFrames  = [];
--        
--        for(var i = 0; i < other.getSkinSpriteFrames().length; ++i)
--        {
--            var frm = other.getSkinSpriteFrames()[i];
--            if(frm)
--            {
--                self.skinSpriteFrames.push(new GHSkeletalAnimationFrame().createWithFrame(frm));
--            }   
--        }
--    }
--    
--
--    if(other.getVisibilityFrames())
--    {
--        self.visibilityFrames  = [];
--        
--        for(var i = 0; i < other.getVisibilityFrames().length; ++i)
--        {
--            var frm = other.getVisibilityFrames()[i];
--            if(frm)
--            {
--                self.visibilityFrames.push(new GHSkeletalAnimationFrame().createWithFrame(frm));
--            }   
--        }
--    }        
--
--
--    if(other.getSpritesTransformFrames())
--    {
--        self.spritesTransformFrames  = [];
--        
--        for(var i = 0; i < other.getSpritesTransformFrames().length; ++i)
--        {
--            var frm = other.getSpritesTransformFrames()[i];
--            if(frm)
--            {
--                self.spritesTransformFrames.push(new GHSkeletalAnimationFrame().createWithFrame(frm));
--            }   
--        }
--    } 
--
--
--    self.totalTime = other.getTotalTime();
--    self.currentTime = 0;
--    
--    self.name = other.getName();
--    self.paused = false;
--    self.setNumberOfLoops(other.getNumberOfLoops());
--    self.setCurrentLoop(other.getCurrentLoop());
--    self.setPlayMode(other.getPlayMode());
--    self.setCurrentTime(other.getCurrentTime());
--    self.setReversed(other.getReversed());
--
--    return this;
--}


--!@docBegin
--!Get the number of loops this animation should play. Returns a number value.
function GHSkeletalAnimation:getNumberOfLoops()
--!@docEnd
	return self.numberOfLoops;
end

--!@docBegin
--!Sets the number of loops this animation should play.
--!@param val A numeric value representing loops count.
function GHSkeletalAnimation:setNumberOfLoops(val)
--!@docEnd
	self.numberOfLoops = val;
end

--!@docBegin
--!The the current loop this animation object is at. Returns a number value. 
function GHSkeletalAnimation:getCurrentLoop()
--!@docEnd
	return self.currentLoop;
end

--!@docBegin
--!Set the current loop this animation object is at. The loop count will continue from this number. 
--!@param val A numeric value.
function GHSkeletalAnimation:setCurrentLoop(val)
--!@docEnd
	self.currentLoop = val;
end

--!@docBegin
--!Returns the play mode as a numeric value.
--!0 means normal play mode.
--!1 means looping mode.
--!2 means ping pong mode.
function GHSkeletalAnimation:getPlayMode()
--!@docEnd	
	return self.playMode;
end

--!@docBegin
--!Sets the play mode of this animation object using a numeric value.
--!0 means normal play mode.
--!1 means looping mode.
--!2 means ping pong mode.
--!@param val A numeric value.
function GHSkeletalAnimation:setPlayMode(val)
--!@docEnd
	self.playMode = val;
end

--!@docBegin
--!Get if this animation object is currently playing in reverse. Returns a boolean value.
function GHSkeletalAnimation:getReversed()
--!@docEnd
	return self.reversed;
end

--!@docBegin
--!Set this animation play mode as reversed. 
--!@param val A boolean value.
function GHSkeletalAnimation:setReversed(val)
--!@docEnd
	self.reversed = val;
end

--!@docBegin
--!Get if this animation object is paused. Returns a boolean value.
function GHSkeletalAnimation:getPaused()
--!@docEnd
	return self.paused;
end
--!@docBegin
--!Pause or unpause this animation object.
--!@param val A boolean value.
function GHSkeletalAnimation:setPaused(val)
--!@docEnd
	self.paused = val;
end

--!@docBegin
--!Get the name of this animation object as a string value.
function GHSkeletalAnimation:getName()
--!@docEnd
	return self.name;
end

--!@docBegin
--!Set the total time this animation object should take to complete a loop.
--!When changing this value all frames will be placed at coresponding position.
--!@param  newTime A numeric value representing the total time.
function GHSkeletalAnimation:setTotalTime(newTime)
--!@docEnd

    if(newTime < 0.02)then
        newTime = 0.02
    end
    
    local currentTotalTime = self.totalTime;
    
    self:changeTimeForFrames(self.bonePositionFrames, currentTotalTime, newTime);

    self:changeTimeForFrames(self.spriteZOrderFrames, currentTotalTime, newTime);
    
    self:changeTimeForFrames(self.skinConnectionFrames, currentTotalTime, newTime);
    
    self:changeTimeForFrames(self.skinSpriteFrames, currentTotalTime, newTime);
    
    self:changeTimeForFrames(self.visibilityFrames, currentTotalTime, newTime);
    
    self:changeTimeForFrames(self.spritesTransformFrames, currentTotalTime, newTime);
    
    self.totalTime = newTime;
end

function GHSkeletalAnimation:changeTimeForFrames(frames, currentTotalTime, newTime)

    for i = 1, #frames do
        
        local frame = frames[i];
        
        local currentFrameTime = frame:getTime();
        local frameUnit = currentFrameTime/currentTotalTime;
        --gives a value between 0 and 1 for the frame time
        --multiplying this unit value with the new total time gives use the new frame time
        local newFrameTime = frameUnit*newTime;
        frame:setTime(newFrameTime);
    end   
end

--!@docBegin
--!Get the total time of this animation object as a numeric value.
function GHSkeletalAnimation:getTotalTime()
--!@docEnd
	return self.totalTime;
end

--!@docBegin
--!Change the time position where this animation is currently at.
--!Method has no effect when animation is paused.
--!@param val A numeric value representing the time.
function GHSkeletalAnimation:setCurrentTime(val)
--!@docEnd
    if(self.paused == false)then
        self.currentTime = val;
    end
end
--!@docBegin
--!Get the current time this animation is at.
function GHSkeletalAnimation:getCurrentTime()
--!@docEnd
	return self.currentTime;
end

function GHSkeletalAnimation:getBonePositionFrames()
	return self.bonePositionFrames;
end
function GHSkeletalAnimation:getSpriteZOrderFrames()
	return self.spriteZOrderFrames;
end
function GHSkeletalAnimation:getSkinConnectionFrames()
	return self.skinConnectionFrames;
end
function GHSkeletalAnimation:getSkinSpriteFrames()
	return self.skinSpriteFrames;
end
function GHSkeletalAnimation:getVisibilityFrames()
	return self.visibilityFrames;
end
function GHSkeletalAnimation:getSpritesTransformFrames ()
	return self.spritesTransformFrames;
end

--!@docBegin
--!Moves the animation to first next position frame.
--!Returns new frame index.
function GHSkeletalAnimation:goToNextBonePositionFrame()
--!@docEnd
    return self:goToNextFrameUsingFramesArray(self:getBonePositionFrames());
end
--!@docBegin
--!Moves the animation to first previous position frame.
--!Returns new frame index.
function GHSkeletalAnimation:goToPreviousBonePositionFrame()
--!@docEnd
    return self:goToPreviousFrameUsingFramesArray(self:getBonePositionFrames());
end

--!@docBegin
--!Moves the animation to first next sprite z order frame.
--!Returns new frame index.
function GHSkeletalAnimation:goToNextSpriteZOrderFrame()
--!@docEnd
    return self:goToNextFrameUsingFramesArray(self:getSpriteZOrderFrames());
end
--!@docBegin
--!Moves the animation to first previous sprite z order frame.
--!Returns new frame index.
function GHSkeletalAnimation:goToPreviousSpriteZOrderFrame()
--!@docEnd
    return self:goToPreviousFrameUsingFramesArray(self:getSpriteZOrderFrames());
end

--!@docBegin
--!Moves the animation to first next skin connection frame.
--!Returns new frame index.
function GHSkeletalAnimation:goToNextSkinConnectionFrame()
--!@docEnd
    return self:goToNextFrameUsingFramesArray(self:getSkinConnectionFrames());
end
--!@docBegin
--!Moves the animation to first previous skin connection frame.
--!Returns new frame index.
function GHSkeletalAnimation:goToPreviousSkinConnectionFrame()
--!@docEnd
    return self:goToPreviousFrameUsingFramesArray(self:getSkinConnectionFrames());
end


--!@docBegin
--!Moves the animation to first next sprite texture atlas frame.
--!Returns new frame index.
function GHSkeletalAnimation:goToNextSkinSpriteFrame()
--!@docEnd
    return self:goToNextFrameUsingFramesArray(self:getSkinSpriteFrames());
end
--!@docBegin
--!Moves the animation to first previous sprite texture atlas frame.
--!Returns new frame index.
function GHSkeletalAnimation:goToPreviousSkinSpriteFrame()
--!@docEnd
    return self:goToPreviousFrameUsingFramesArray(self:getSkinSpriteFrames());
end

--!@docBegin
--!Moves the animation to first next sprite visibility frame.
--!Returns new frame index.
function GHSkeletalAnimation:goToNextVisibilityFrame()
--!@docEnd
    return self:goToNextFrameUsingFramesArray(self:getVisibilityFrames());
end
--!@docBegin
--!Moves the animation to first previous sprite visibility frame.
--!Returns new frame index.
function GHSkeletalAnimation:goToPreviousVisibilityFrame()
--!@docEnd
    return self:goToPreviousFrameUsingFramesArray(self:getVisibilityFrames());
end

--!@docBegin
--!Moves the animation to first next sprite transformation frame.
--!Returns new frame index.
function GHSkeletalAnimation:goToNextSpriteTransformFrame()
--!@docEnd
    return self:goToNextFrameUsingFramesArray(self:getSpritesTransformFrames());
end
--!@docBegin
--!Moves the animation to first previous sprite transformation frame.
--!Returns new frame index.
function GHSkeletalAnimation:goToPreviousSpriteTransformFrame()
--!@docEnd
	return self:goToPreviousFrameUsingFramesArray(self:getSpritesTransformFrames());
end



function GHSkeletalAnimation:goToNextFrameUsingFramesArray(array)

	local currentFrame = nil;
	local idx = -1;
    for i = 1, #array do
	    local frm = array[i];
	    if(frm:getTime() <= self.currentTime)then
	       currentFrame = frm;
	       idx = i;    
	    end
	end
	
    if(currentFrame)then
        idx=idx+1;
        
        if(idx > array.length)then
            idx = array.length;
        end
        
        local nextFrame = array[idx];
        if(nextFrame)then
            self.currentTime = nextFrame:getTime();
        end
        return idx;
    end
    
    return -1;
end
function GHSkeletalAnimation:goToPreviousFrameUsingFramesArray(array)

    local currentFrame = nil;
    local idx = -1;
    
    for i = 1, #array do
    
        local frm = array[i];
        if(frm:getTime() <= self.currentTime)then
            currentFrame = frm;
            idx = i;
        end
    end
    
     if(currentFrame)then
        idx = idx - 1;
        
        if(idx<1)then
            idx = 1;
        end
        
        local nextFrame = array[idx];
        if(nextFrame)then
            self.currentTime = nextFrame:getTime();
        end
        return idx;
    end
    
    return -1;	
end
