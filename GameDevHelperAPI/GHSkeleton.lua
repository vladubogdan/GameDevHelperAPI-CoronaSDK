
module (..., package.seeall)

require('GameDevHelperAPI.GHBone');
require('GameDevHelperAPI.GHBoneSkin');
local GHUtils = require('GameDevHelperAPI.GHUtils');
local GHSprite =  require("GameDevHelperAPI.GHSprite");

--var GHSkeletalAnimation = require('GameDevHelperAPI/GHSkeletalAnimation').GHSkeletalAnimation;
--var GHSkeletalAnimationCache = require("GameDevHelperAPI/GHSkeletalAnimationCache").GHSkeletalAnimationCache;

--!@docBegin
--!GHSkeleton class is used to create skeletons as defined in SpriteHelper.
--!
--!@docEnd

--GHSkeleton = {}

----!@docBegin
----!Creates a GHSkeleton object.
--function GHSkeleton:init()
----!@docEnd
--
--    local object = {rootBone = nil,
--                    poses = nil,--may be nil depending on publish settings
--                    skins = nil,--contains GHBoneSkin objects
--                    sprites = {},
--                    positionX = 0,
--                    positionY = 0,
--                    animation = nil,--combined animations currently not supported
--                    transitionTime = nil,--not nil only when transtioning to a new animation
--                    currentTranstionTime = 0.0,
--                    delegate = nil,
--                    lastTime = 0,
--                    animatingInProgress = false,
--                    updateTimer = nil
--					}
--
--	setmetatable(object, { __index = GHSkeleton })  -- Inheritance	
--	return object
--end



--!@docBegin
--!Loads a skeleton object from a json file.
--!@param skeletonFileName The path to the skeleton json file as a string
--!@param base Optional parammeter. Location where the file should be loaded from. Default is system.ResourceDirectory.
function createWithFile(skeletonFileName, base)
--!@docEnd
    local GHSkeleton = display.newGroup();--display group is called like this so that documention parser can process it

    GHSkeleton.rootBone = nil;
    GHSkeleton.poses = nil;--may be nil depending on publish settings
    GHSkeleton.skins = nil;--contains GHBoneSkin objects
    GHSkeleton.sprites = {};
    GHSkeleton.positionX = 0;
    GHSkeleton.positionY = 0;
    GHSkeleton.animation = nil;--combined animations currently not supported
    GHSkeleton.transitionTime = nil;--not nil only when transtioning to a new animation
    GHSkeleton.currentTranstionTime = 0.0;
    GHSkeleton.delegate = nil;
    GHSkeleton.lastTime = 0;
    GHSkeleton.animatingInProgress = false;
    GHSkeleton.updateTimer = nil;



	local dict = nil;
    
    print("skeleton path " .. skeletonFileName);
    
    if not base then base = system.ResourceDirectory; end
    local jsonContent = GHUtils.jsonFileContent(skeletonFileName, base);
    if(jsonContent)then
        local json = require "json"
        dict = json.decode( jsonContent );
    end

	if dict == nil then
        print("Error loading skeleton file. File is null");
        return;
    end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------




--------------------------------------------------------------------------------
--!@docBegin
--!Returns an array which includes "this" and all children bones.
function GHSkeleton:getAllBones()
--!@docEnd
    local array = {};
    
    array[#array+1] = self.rootBone;
    
    for i = 1, #self.rootBone.children do
        local childBone = self.rootBone.children[i];
        if childBone then
            local boneChildren = childBone:getAllBones();
            for j = 1, #boneChildren do
               array[#array+1] = boneChildren[j]; 
            end
        end
    end
    return array;
end
--------------------------------------------------------------------------------
--!@docBegin
--!Sets the position of the skeleton.
--!@param pointX A numeric value representing the X position.
--!@param pointY A numeric value representing the Y position.
function GHSkeleton:setPosition(pointX, pointY)
--!@docEnd
    self.x = pointX;
    self.y = pointY;
	self:updateSkins();
end
--------------------------------------------------------------------------------    
function GHSkeleton:loadSprites(spritesInfo, spriteAtlastFileName)

	if nil == spritesInfo then
        return
    end
	
	local allBones = self:getAllBones()
	
	for i = 1, #spritesInfo do
	
		local sprInfo = spritesInfo[i];
		
		local localPosX = 0.0;
		local localPosY = 0.0;
		
		local sprPos = sprInfo.localPos
		if sprPos then
		
			local pos = GHUtils.pointFromString(sprPos);
            if pos then
                localPosX = pos.x;
                localPosY = pos.y;
			end
		end
		
		local angle = sprInfo.angle;
		
		local visible = false;
		local sprVis = sprInfo.visible;
		if sprVis then
			visible = sprVis;
		end
		
		local boneUUID = sprInfo.boneUUID;
		local skinName = sprInfo.skinName;
		local skinUUID = sprInfo.skinUUID;
		local sprName  = sprInfo.sprName;
		
		if sprName then
		
            local newSprite = GHSprite.createWithFile(spriteAtlastFileName, sprName);
			
			newSprite.name = skinName;
			newSprite.zOrder = i;
            
			newSprite.x = localPosX;
			newSprite.y = -1*localPosY;
            newSprite.rotation = angle;
            
			newSprite.localPosX = localPosX;
			newSprite.localPosY = localPosY;
            
            newSprite.isVisible = visible;
            self.sprites[#self.sprites +1] = newSprite;
            
            self:insert(newSprite);
            
			if boneUUID then
			
                for b = 1, #allBones do
					local bone = allBones[b];
					
					if bone:getUUID() == boneUUID then
					
						self:addSkin(GHBoneSkin:init():create(newSprite, allBones[b], skinName, skinUUID, self));
						break;
					end
				end
			else
				self:addSkin(GHBoneSkin:init():create(newSprite, nil, skinName, skinUUID, self));
			end
		end	
	end
end
--------------------------------------------------------------------------------
function GHSkeleton:addSkin(skin)

    if skin == null then
        return;
    end
    
	if self.skins == nil then
		self.skins = {};
	end
	
	self.skins[#self.skins+1] = skin;
end
--------------------------------------------------------------------------------
function GHSkeleton:loadBones(rootBoneInfo)
	if(nil == rootBoneInfo)then
        return;
    end
	self.rootBone = GHBone:init():createWithDict(rootBoneInfo);
end
--------------------------------------------------------------------------------
--!@docBegin
--!Finds a bone in the skeleton structure and set its position. 
--! 
--!This will cause all children bone to move acordingly.
--!@param posX A numeric value representing the X position where the bone should be placed.
--!@param posY A numeric value representing the Y position where the bone should be placed.
--!@param boneName The name of the bone that should be moved.
function GHSkeleton:setPositionForBoneNamed(posX, posY, boneName)
--!@docEnd

    local bone = self.rootBone:getBoneWithName(boneName);

	if bone then
        
		local localPointX = posX - self.x;
		local localPointY = posY - self.y;
		
		bone:setBonePosition(localPointX, localPointY, nil);
	end
	self.rootBone:updateMovement();
	self:transformSkins();
end
--------------------------------------------------------------------------------
function GHSkeleton:transformSkins()
    for i = 1, #self.skins do
		local skin = self.skins[i];
		if skin then
			skin:transform();
		end
	end
end
--------------------------------------------------------------------------------
function GHSkeleton:updateSkins()
    for i = 1, #self.skins do
		local skin = self.skins[i];
		if skin then
			skin:setupTransformations();
		end
	end
end
--------------------------------------------------------------------------------
--!@docBegin
--!Returns the root bone of this skeleton. A GHBone object.
function GHSkeleton:getRootBone()
--!@docEnd
    return self.rootBone;
end
--------------------------------------------------------------------------------
--!@docBegin
--!Sets a pose onto the skeleton given the pose name.
--!@param poseName The name of the pose to be loaded.
function GHSkeleton:setPoseWithName(poseName)
--!@docEnd
    if self.poses == nil then
		print("ERROR: Skeleton has no poses or poses were not publish.");
		return;
	end

	local poseInfo = self.poses[poseName];
	if(poseInfo == nil)then
		print("ERROR: Skeleton has no pose with name " .. poseName);
		return;
	end
	
	local visibility = poseInfo.visibility;
	if(visibility == nil)then
		print("ERROR: Skeleton pose is in wrong format. Skin visibilities were not found.");
		return;
	end
	
	local zOrder = poseInfo.zOrder;
	if(zOrder == nil)then
		print("ERROR: Skeleton pose is in wrong format. Skin z orders were not found.");
		return;
	end

	local skinTex = poseInfo.skinTex;
	if(skinTex == nil)then
		print("ERROR: Skeleton pose is in wrong format. Skin sprite frame names were not found.");
		return;
	end

	local connections = poseInfo.connections;
	if(connections == nil)then
		print("ERROR: Skeleton pose is in wrong format. Skin connections were not found.");
		return;
	end

    local allBones = self:getAllBones();
    
    for s = 1, #self.skins do
        
		local skin = self.skins[s];
		if skin then
		
			skin:getSprite().isVisible = true;
			
			local value = visibility[skin:getUUID()];
			
			if value == false then
				skin:getSprite().isVisible = false;
			end
			
			local zValue = zOrder[skin:getUUID()];
			if(zValue)then
				skin:getSprite().zOrder = zValue;
			end
            
			local spriteFrameName = skinTex[skin:getUUID()];
			if(spriteFrameName)then
                skin:getSprite():setFrameName(spriteFrameName);
			end
			
			
			local connectionInfo = connections[skin:getUUID()];
			if(connectionInfo)then
			
				--angleOff
				--boneUUID //this may be missing if no connection
				--conAngle
				--posOff
				
				local boneUUID = connectionInfo.boneUUID;
				
				if(boneUUID)then
				
					--check if the current bone is already our connection bone - if not, change it
					if(false == (skin:getBone() and skin:getBone():getUUID() == boneUUID))then
					    
                        for b = 1, #allBones do
							local bone = allBones[b];
							if(bone)then
								if(bone:getUUID() == boneUUID)then
									skin:setBone(bone);
									break;
								end
							end
						end
					end	
				else
					skin:setBone(nil);	
				end
				
				local angleOff = connectionInfo.angleOff;
				if(angleOff)then
					skin:setAngleOffset(angleOff);
				end
				
				local posOff = connectionInfo.posOff;
				if posOff then
					local pos = GHUtils.pointFromString(posOff);
   					if (pos) then
	 					skin:setPositionOffset(pos.x, pos.y);
					end
				end
				
				local connectionAngle = connectionInfo.conAngle;
				if connectionAngle then
					skin:setConnectionAngle(connectionAngle);
				end
			end
		end
    end
  
    --sort sprites in order of z
    table.sort(self, function(a,b) return a.zOrder < b.zOrder end)
            

    local positions = poseInfo.positions;
    if(positions == nil)then
        print("ERROR: Skeleton pose is in wrong format. Bone positions were not found.");
        return;
    end
	
    for j = 1, #allBones do
        local cbone = allBones[j];
        if(cbone)then
		
			local uuid = cbone:getUUID();
			if(uuid == nil or uuid == "")then
				print("ERROR: Bone has no UUID.");
				return;
			end
			
			local bonePos = positions[uuid];
			if(bonePos == nil)then
				print("ERROR: Bone pose does not have a position value. Must be in a wrong format.");
				return;
			end
            
			local newPos = GHUtils.pointFromString(bonePos);
			
			cbone:setPosition(newPos.x, newPos.y);
		end
	end
	
    self:transformSkins();

--	//if(delegate)
--	//{
--  	//  delegate->didLoadPoseWithNameOnSkeleton(poseName, this);
--	//}
end





--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
    if dict ~= nil then
    
        GHSkeleton:loadBones(dict.root);
        
        local path = GHUtils.getPathFromFilename(skeletonFileName); --removes the skeleton.json 
        path = GHUtils.replaceOccuranceOfStringWithString(path, "skeletons/", ""); --removes the "skeleton" folder
        
        local imgPath = path .. dict.sheet;
        print("path " .. imgPath);
        
        
        GHSkeleton:loadSprites(dict.sprites, imgPath);
        GHSkeleton:updateSkins();
        
        local posesDict = dict.poses;
        if posesDict then
            GHSkeleton.poses = GHUtils.GHDeepCopy(posesDict);
        end
    end
    
    return GHSkeleton;
end
--[[
--------------------------------------------------------------------------------
--!@docBegin
--!Start an animation on the skeleton given the animation object.
--!@param anim A GHSkeletalAnimation object.    
function GHSkeleton:playAnimation(anim)
--!@docEnd
    self.animation = null;
    self.animation = anim;

    self.currentTransitionTime = 0;
    self.animation.setCurrentTime(0);
    self.animation.setCurrentLoop(0);
    
    self.lastTime = new Date();
    
    self.animatingInProgress = false;
    
    var myself = this;
    function callUpdateMethod() {
        myself.update();
    }
    self.updateTimer = setInterval(callUpdateMethod, 1.0/30.0);
}

--------------------------------------------------------------------------------
--!@docBegin
--!This will change or set an animation by transitioning each bone position
--!to the new animation bone positions in the period of time specified.
--! 
--!You should only transition related animations. Like from walk, to shoot gun. Character pose should be similar in nature. 
--! 
--!Transitioning from a standing on a chair pose to a walking pose may lead to unrealistic behaviour. 
--! 
--!In such a case, you will need a "in between" animation. An animation that will make the character get up of the chair. When this "in between" animation finishes you will change to a new walking animation.  
--!
--!@param anim A GHSkeletalAnimation object
--!@param time How much time the transition should take. A number value.
function GHSkeleton:transitionToAnimationInTime(anim, time)
--!@docEnd  
    if(null == anim)return;

    var allBones = self.getAllBones();
    
    for(var i = 0; i< allBones.length; ++i)
    {
        var bone = allBones[i];
        bone.savePosition();
    }
    
    self.playAnimation(anim);//this will also rmeove any previous transition time
    
    self.transitionTime = time;
    self.currentTranstionTime = 0;
}

--------------------------------------------------------------------------------
--!@docBegin
--!Stops the active skeleton animation and removes it from memory.
function GHSkeleton:stopAnimation()
--!@docEnd
    self.animation = null;
    self.animatingInProgress = false;
    clearInterval(self.updateTimer);
}

--------------------------------------------------------------------------------
--!@docBegin
--!Returns the skeletal animation running on this skeleton object.    
function GHSkeleton:getAnimation()
--!@docEnd
    return self.animation;
}
pfunction GHSkeleton:playAnimationWithName(animName)
{
    var anim = GHSkeletalAnimationCache.getInstance().skeletalAnimatonWithName(animName);
    if(anim)
    {
        var copyAnim = new GHSkeletalAnimation();
        copyAnim = copyAnim.createWithAnimation(anim);
        if(copyAnim){
            self.playAnimation(copyAnim);
        }
    }
}
function GHSkeleton:update(self)
{
    if(self.animatingInProgress == true)
        return;
        
    if(self.animation == null)
    {
        return;
    }
    
    //we use this variable so that in case the update function is called while we are still changing frames we should ignore the call
    self.animatingInProgress = true;
    
    var delta = new Date() - self.lastTime;
    self.lastTime = new Date();

    var dt = delta/1000.0;//deltaTime/1000.0; 
    
    var time = 0.0;
    
    
    if(self.transitionTime != null)
    {
        if(self.transitionTime < self.currentTransitionTime)
        {
            self.transitionTime = null;
            self.animation.setCurrentTime(dt);
            self.animation.setCurrentLoop(0);
            self.currentTransitionTime = 0;
            time = dt;
            
            //if(delegate){
               // if([delegate respondsToSelector:@selector(didFinishTransitionToAnimation:onSkeleton:)]){
                 //   [delegate didFinishTransitionToAnimation:animation onSkeleton:self];
             //   }
            //}
        }
        time = self.currentTranstionTime;
        self.currentTranstionTime += dt;
    }
    else{
        
        time = self.animation.getCurrentTime();
        if(self.animation.getReversed()){
            self.animation.setCurrentTime(self.animation.getCurrentTime() - dt);
        }
        else{
            self.animation.setCurrentTime(self.animation.getCurrentTime() + dt);
        }
    }
    
    
    if(self.animation.getReversed() && self.transitionTime == null)
    {
        if(time <= 0)
        {
            switch(self.animation.getPlayMode())
            {
                case 0: //normal
                case 1: //loop
                {
                    self.animation.setCurrentTime(self.animation.getTotalTime());    
                }
                break;
                
                case 2: //ping pong
                {
                    self.animation.setCurrentTime(0);
                    self.animation.setReversed(false);
                }
                break;
                
                default:
                break;
            }
            
            
            self.animation.setCurrentLoop(self.animation.getCurrentLoop() + 1);
        }
        
    }
    else{
        if(time >= self.animation.getTotalTime())
        {
            switch(self.animation.getPlayMode())
            {
                case 0://normal
                case 1://loop
                {
                    self.animation.setCurrentTime(0);
                }
                break;
                
                case 2: //ping pong
                {
                    self.animation.setCurrentTime(self.animation.getTotalTime());
                    self.animation.setReversed(true);
                }
                break;
            }
            
            self.animation.setCurrentLoop(self.animation.getCurrentLoop()+1);
            
        }
    }
    
    if(self.animation.getNumberOfLoops() != 0 && self.animation.getCurrentLoop() >= self.animation.getNumberOfLoops())
    {
        self.stopAnimation();
    }
    
    var allBones = self.getAllBones();
    
    
    {//handle bone positions
        
        var beginFrame = null
        var endFrame = null;
        
        var bonePosFrames = self.animation.getBonePositionFrames();
        for(var i = 0; i < bonePosFrames.length; ++i)
        {
            var frm = bonePosFrames[i];
            
            if(frm.getTime() <= time)
            {
                beginFrame = frm;
            }
            
            if(frm.getTime() > time)
            {
                endFrame = frm;
                break;//exit for
            }
        }
        
        if(self.transitionTime)
        {
            var positionFrames = self.animation.getBonePositionFrames();
            
            if(positionFrames.length > 0)
            {
                beginFrame = positionFrames[0];
            }
            
            var beginTime = 0;
            var endTime = self.transitionTime;
            
            var framesTimeDistance = endTime - beginTime;
            var timeUnit = (time - beginTime)/framesTimeDistance;//a value between 0 and 1
            
            var beginBonesInfo = beginFrame.getBonePositions();
            
            if(beginBonesInfo != null)
            {
                for(var b = 0; b < allBones.length; ++b)
                {
                    var bone = allBones[b];
                
                    var beginValue = beginBonesInfo[bone.getName()];
                
                    var beginPositionX = bone.getPreviousPositionX();
                    var beginPositionY = bone.getPreviousPositionY();
                
                    var endPositionX = bone.getPositionX();
                    var endPositionY = bone.getPositionY();
                
                    if(beginValue != null){
                        endPositionX = beginValue[0];
                        endPositionY = beginValue[1];
                    }
                
                    //lets calculate the position of the bone based on the start - end and unit time
                    var newX = beginPositionX + (endPositionX - beginPositionX)*timeUnit;
                    var newY = beginPositionY + (endPositionY - beginPositionY)*timeUnit;
            
                    bone.setPosition(newX, newY);
                }
                self.transformSkins();
                self.rootBone.updateMovement();
            }
        }
        else if(beginFrame && endFrame)
        {
            var beginTime = beginFrame.getTime();
            var endTime = endFrame.getTime();
            
            var framesTimeDistance = endTime - beginTime;
            var timeUnit = (time - beginTime)/framesTimeDistance;//a value between 0 and 1
            
            var beginBonesInfo = beginFrame.getBonePositions();
            var endBonesInfo = endFrame.getBonePositions();
            
            if(null == beginBonesInfo || null == endBonesInfo){
                return;
            }
             
            for(var b = 0; b < allBones.length; ++b)
            {
                var bone = allBones[b];
                if(bone)
                {
                var beginValue   = beginBonesInfo[bone.getName()];
                var endValue     = endBonesInfo[bone.getName()];
                
                var beginPositionX = bone.getPositionX();
                var beginPositionY = bone.getPositionY();
                
                var endPositionX  = bone.getPositionX();
                var endPositionY  = bone.getPositionY();
                
                if(beginValue)
                {
                    beginPositionX = beginValue[0];
                    beginPositionY = beginValue[1];
                }
                
                if(endValue){
                    endPositionX = endValue[0];
                    endPositionY = endValue[1];
                }
                
                //lets calculate the position of the bone based on the start - end and unit time
                var newX = beginPositionX + (endPositionX - beginPositionX)*timeUnit;
                var newY = beginPositionY + (endPositionY - beginPositionY)*timeUnit;
                
                bone.setPosition(newX, newY);
                }
            }       
            self.rootBone.updateMovement();   
        }
        else if(beginFrame)
        {
            var beginBonesInfo = beginFrame.getBonePositions();
            for(var b = 0; b < allBones.length; ++b)
            {
                var bone = allBones[b];
                
                var beginValue = beginBonesInfo[bone.getName()];
                
                var beginPositionX = bone.getPositionX();
                var beginPositionY = bone.getPositionY();
                
                if(beginValue){
                    beginPositionX = beginValue[0];
                    beginPositionY = beginValue[1];
                }
                
                bone.setPosition(beginPositionX, beginPositionY);
                
            }
            self.rootBone.updateMovement();
        }
        
    }
    
    if(self.transitionTime){
        time = 0;
    }
    
    
    {//handle sprites z order
        
        var beginFrame = null
        var spriteZOrderFrames = self.animation.getSpriteZOrderFrames();
        for(var i = 0; i < spriteZOrderFrames.length; ++i)
        {
            var frm = spriteZOrderFrames[i];
            if(frm.getTime() <= time){
                beginFrame = frm;
            }
        }
        
        //we have the last frame with smaller time
        if(beginFrame)
        {
            var zOrderInfo = beginFrame.getSpritesZOrder();
            
            for(var s = 0; s< self.sprites.length; ++s)
            {
                var sprite = self.sprites[s];
                if(sprite)
                {
                    var sprName = sprite.name;
                    if(sprName)
                    {
                        var zNum = zOrderInfo[sprName];
                        if(zNum)
                        {
                            sprite.z = zNum;   
                        }
                    }
                }
            }
        }
    }
    
    {//handle skin connections
        
        var beginFrame = null;
        var skinConnectionFrames = self.animation.getSkinConnectionFrames();
        for(var i = 0; i < skinConnectionFrames.length; ++i)
        {
            var frm = skinConnectionFrames[i];
            if(frm.getTime() <= time)
            {
                beginFrame = frm;
            }
        }
        
        //we have the last frame with smaller time
        if(beginFrame)
        {
            var connections = beginFrame.getSkinConnections();
            
            for(var s = 0; s < self.skins.length; ++s)
            {
                var skin = self.skins[s];
                
                var sprite = skin.getSprite();
                
                if(sprite)
                {
                    var sprName = sprite.name;
                    if(sprName)
                    {
                        var connectionInfo = connections[sprName];
                        if(connectionInfo)
                        {
                            var boneName = connectionInfo.getBoneName();
                            
                            skin.setAngleOffset(connectionInfo.getAngleOffset());
                            skin.setPositionOffset(connectionInfo.getPositionOffsetX(), connectionInfo.getPositionOffsetY());
                            skin.setConnectionAngle(connectionInfo.getConnectionAngle());
                            
                            if(boneName == "" || boneName == null)
                            {
                                skin.setBone(null);
                            }
                            else{
                                
                                for(var b = 0; b < allBones.length; ++b)
                                {
                                    var bone = allBones[b];
                                    if(bone.getName() == boneName)
                                    {
                                        skin.setBone(bone);
                                        break;
                                    }
                                }
                            }
                        }
                    }
                }
                
            }
        }
    }
    
    {//handle skin sprites
        var beginFrame = null;
        var skinSpriteFrames = self.animation.getSkinSpriteFrames();
        for(var s = 0; s < skinSpriteFrames.length; ++s)
        {
            var frm = skinSpriteFrames[s];
            if(frm.getTime() <= time)
            {
                beginFrame = frm;
            }
        }
        
        //we have the last frame with smaller time
        if(beginFrame)
        {
            var info = beginFrame.getSkinSprites();
            if(info)
            {
                for(var s = 0; s< self.skins.length; ++s)
                {
                    var skin = self.skins[s];
                    var newSprFrameName = info[skin.getName()];
                    if(newSprFrameName)
                    {
                        skin.getSprite().selectFrame(newSprFrameName);
                    }
                }
            }
        }
    }
    
    
    {//handle sprites visibility
        
        var beginFrame = null;
        var visibilityFrames = self.animation.getVisibilityFrames();
        for(var v = 0; v < visibilityFrames.length; ++v)
        {
            var frm = visibilityFrames[v];
            if(frm.getTime() <= time)
            {
                beginFrame = frm;
            }
        }
        
        //we have the last frame with smaller time
        if(beginFrame)
        {
            var info = beginFrame.getSpritesVisibility();
            if(info)
            {
                for(var s = 0; s < self.sprites.length; ++s)
                {
                    var sprite = self.sprites[s];
                    if(sprite)
                    {
                        var sprFrmName = sprite.name;
                        if(sprFrmName != null && sprFrmName != "")
                        {
                            var val = info[sprFrmName];
                            
                            if(typeof(val) != undefined && val == true)
                            {
                                sprite.show();
                            }
                            else if(typeof(val) != undefined && val == false ){
                                sprite.hide();
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    {//handle sprites transform
        
        var beginFrame = null;
        var endFrame = null;
        
        var spritesTransformFrames = self.animation.getSpritesTransformFrames();
        for(var t = 0; t < spritesTransformFrames.length; ++t)
        {
            var frm = spritesTransformFrames[t];
            if(frm.getTime() <= time){
                beginFrame = frm;
            }
            
            if(frm.getTime() > time){
                endFrame = frm;
                break;//exit for
            }
        }
        
        if(beginFrame && endFrame){
            
            var beginTime = beginFrame.getTime();
            var endTime = endFrame.getTime();
            
            var framesTimeDistance = endTime - beginTime;
            var timeUnit = (time - beginTime)/framesTimeDistance;
            
            var beginFrameInfo = beginFrame.getSpritesTransform();
            var endFrameInfo = endFrame.getSpritesTransform();
            
            if(beginFrameInfo == null || endFrameInfo == null)
                return;
                
            for(var sk= 0; sk < self.skins.length; ++sk)
            {
                var skin = self.skins[sk];
                
                var beginInfo = beginFrameInfo[skin.getName()];
                var endInfo = endFrameInfo[skin.getName()];
                
                
                if(skin.getSprite() != null && beginInfo != null && endInfo != null)
                {
                    
                    //set position
                    var beginPosX = beginInfo.getPositionX();
                    var beginPosY = beginInfo.getPositionY();
                    
                    var endPosX = endInfo.getPositionX();
                    var endPosY = endInfo.getPositionY();
                    
                    var newX = beginPosX + (endPosX - beginPosX)*timeUnit;
                    var newY = beginPosY + (endPosY - beginPosY)*timeUnit;
                    
                    skin.getSprite().x = newX       + self.positionX + skin.getSprite().width*0.5;
                    skin.getSprite().y = -1.0*newY  + self.positionY + skin.getSprite().height*0.5;
                    
                    //set angle
                    var beginAngle  = beginInfo.getAngle();
                    var endAngle    = endInfo.getAngle();
                    var newAngle    = beginAngle + (endAngle - beginAngle)*timeUnit;
                    skin.getSprite().rotate(newAngle);
                    
                    //set angle at skin time
                    var beginSkinAngle  = beginInfo.getConnectionAngle();
                    var endSkinAngle    = endInfo.getConnectionAngle();
                    var newSkinAngle    = beginSkinAngle + (endSkinAngle - beginSkinAngle)*timeUnit;
                    skin.setConnectionAngle(newSkinAngle);
                    
                    {
                        //set skin angle
                        var beginAngle  = beginInfo.getAngleOffset();
                        var endAngle    = endInfo.getAngleOffset();
                        var newAngle    = beginAngle + (endAngle - beginAngle)*timeUnit;
                        skin.setAngleOffset(newAngle);
                        
                        
                        //set skin position offset
                        var beginPosOffX = beginInfo.getPositionOffsetX();
                        var beginPosOffY = beginInfo.getPositionOffsetY();
                        
                        var endPosOffX = endInfo.getPositionOffsetX();
                        var endPosOffY = endInfo.getPositionOffsetY();
                        
                        var newX = beginPosOffX + (endPosOffX - beginPosOffX)*timeUnit;
                        var newY = beginPosOffY + (endPosOffY - beginPosOffY)*timeUnit;
                        
                        skin.setPositionOffset(newX, newY);
                    }
                    skin.transform();
                    
                }
            }
        }
        
    }

    
    self.transformSkins();
    self.currentTransitionTime += dt;
    
    self.animatingInProgress = false;
}
--]]

--]]


--[[
--function GHSkeleton:flipX()
--{
--    Ti.API.info("flipx");
--    
--    for(var i = 0; i < self.sprites.length; i++)
--    {
--        var spr = self.sprites[i];
--        if(spr)
--        {
--            //var localSprX = spr.x - self.positionX;
--            //var localSprY = spr.y - self.positionY;
--            
--            Ti.API.info("local x " + spr.localPosX );
--            
--            //spr.scale(-1*spr.scaleX, 1, 0, 0);
--            spr.x = self.positionX - spr.localPosX;
--            
--            //spr.localPosX = (-1)*spr.localPosX;
--            //spr.scaleBy(-1*spr.scaleX, 1);
--            
--             
--            
--//                            NSPoint localPos = NSMakePoint(position.x - skeletonCenter.x,
--  //                                             skeletonCenter.y - position.y);
--
--        }
--    }
--    
--}

--------------------------------------------------------------------------------
--!@docBegin
--!Returns the X position of the skeleton.
function GHSkeleton:getPositionX()
--!@docEnd
	return self.positionX;
}
--------------------------------------------------------------------------------
--!@docBegin
--!Returns the Y position of the skeleton.
function GHSkeleton:getPositionY()
--!@docEnd
	return self.positionY;
}

function GHSkeleton:getLocalPositionX()
{
    return self.rootBone.getPositionX() - self.positionX;
}
function GHSkeleton:getLocalPositionY()
{
	return self.rootBone.getPositionY() - self.positionY;
}





--]]

