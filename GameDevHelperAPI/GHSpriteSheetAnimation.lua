module (..., package.seeall)

--!@docBegin
--!This class provides frienly methods to create animated sprites.
--! 
--!@docEnd
local GHUtils = require("GameDevHelperAPI.GHUtils");


GHSpriteSheetAnimationFrame = {}
function GHSpriteSheetAnimationFrame:createWithDictionary(frmInfo)

    local object = {spriteFrameName = frmInfo.spriteframe,
    				time = frmInfo.delayUnits,
                    userInfo = GHUtils.GHDeepCopy(frmInfo.notification)
                    }
					
	setmetatable(object, { __index = GHSpriteSheetAnimationFrame })  -- Inheritance	
	return object
end
function GHSpriteSheetAnimationFrame:getUserInfo()
    
    --we do this in order to test if there are any keys or its an empty table
    for k,v in pairs(self.userInfo) do
        return self.userInfo
    end
    return nil;
end


GHSpriteSheetAnimation = {}
function GHSpriteSheetAnimation:createWithDictionary(animDict, animName)

    local object = {totalTime = 0.0,
                    name = animName,
                    frames = {},
                    frameNamesMap = nil,
                    delayPerUnit = animDict.delayPerUnit,
                    loops = animDict.loops,
                    randomReplay = animDict.randomReplay,
                    minRandomTime = animDict.minRandomTime,
                    maxRandomTime = animDict.maxRandomTime,
                    restoreOriginalFrame = animDict.restoreOriginalFrame,
                    randomFrames = animDict.randomFrames,
                    currentFrameIdx = 1,
                    loop = animDict.loop,
                    activeFrame = nil,
                    currentTime = 0.0,
                    spriteSheet = nil,
                    playing = false,
                    lastTime = 0.0,
                    currentRandomRepeatTime = 0.0,
                    repetitionsPerformed = 0
                    }
					
	setmetatable(object, { __index = GHSpriteSheetAnimation })  -- Inheritance	
    
    if animDict.frames ~= nil then
        
        for i = 1, #animDict.frames do
        
            local frmInfo = animDict.frames[i];
            
            local frameTime = frmInfo.delayUnits*object.delayPerUnit;
            object.totalTime = object.totalTime + frameTime;
            
            local newFrame = GHSpriteSheetAnimationFrame:createWithDictionary(frmInfo);
            if(newFrame)then
                newFrame.time = frameTime;
                object.frames[#object.frames + 1] = newFrame;
                if object.activeFrame == nil then
                    object.activeFrame = newFrame;
                end
            end
        end
    end
    
	return object
end

function GHSpriteSheetAnimation:moveToFirstFrame()
    self:setActiveFrameWithIndex(0);
end
function GHSpriteSheetAnimation:setActiveFrameWithIndex(frmIdx)

    if(frmIdx < 1)then
        frmIdx = 1;
    end
    
    if(frmIdx > #self.frames)then
        frmIdx = self.frames;
    end

    if(frmIdx >= 1 and frmIdx <= #self.frames)then
    
        self.currentFrameIdx = frmIdx;
        self.activeFrame = self.frames[frmIdx];
        
        self.spriteObject:setFrame(self.currentFrameIdx);
        
        if(self.spriteObject.didChangeFrameNotificationCallback ~= nil)then
            self.spriteObject.didChangeFrameNotificationCallback(frmIdx, self.spriteObject);
        end
    end
end

function GHSpriteSheetAnimation:calculateRandomReplayTime()
    local from = self.minRandomTime;
    local to = self.maxRandomTime;
    
    return math.random(from, to);
end

function GHSpriteSheetAnimation:randomFrame()
    local from = 1;
    local to = #self.frames;
    
    return math.random(from, to);
end

function GHSpriteSheetAnimation:enterFrame( event )

    if(self.playing == false)then
        return;
    end
    
     if self.firstEnterFrameCall == true then
        self.lastTime = event.time/1000;
        self.firstEnterFrameCall = false
	end
    
    local dt = event.time/1000 - self.lastTime;
    self.lastTime = event.time/1000;

    self.currentTime = self.currentTime + dt;


    local endedAllRep = false;
    local endedRep = false;    
    
    
    if self.activeFrame.time <= self.currentTime then
    
        local resetCurrentTime = true;
        local nextFrame = self.currentFrameIdx+1;

        if(self.randomFrames == true)then
        
            nextFrame = self:randomFrame();
            while (nextFrame == self.currentFrameIdx) do
                nextFrame = self:randomFrame();
                --in case the random number returns the same frame
            end
        end
                
        if(nextFrame > #self.frames)then
        
            if(self.loop == true)then
            
                if(self.activeFrame.time + self.currentRandomRepeatTime <= self.currentTime) then
                
                    print("reset to 1");
                
                    nextFrame = 1;
                    self.currentRandomRepeatTime = self:calculateRandomReplayTime();
                    self.repetitionsPerformed = self.repetitionsPerformed+1;
                    endedRep = true;
                else
                    
                    nextFrame = #self.frames;
                    resetCurrentTime = false;
                    
                end
            else
                self.repetitionsPerformed = self.repetitionsPerformed +1 
                if(self.repetitionsPerformed >= self.repetitions)then
                
                    nextFrame = #self.frames;
                    endedAllRep = true;
                    self.playing = false;
                
                else
                    if(self.restoreSprite == true or self.repetitionsPerformed < self.repetitions) then
                        nextFrame = 1;
                        endedRep = true;
                    else
                        nextFrame = #self.frames;
                    end
                end
            end
        end
        if resetCurrentTime then
            self.currentTime = 0.0;
        end
        
        self:setActiveFrameWithIndex(nextFrame);
    end
    
    if(endedAllRep)then
        self.playing = false;
    end
    
    if(endedRep and self.spriteObject.didFinishRepetitionNotificationCallback)then
        self.spriteObject.didFinishRepetitionNotificationCallback(self.repetitionsPerformed, self.spriteSheet);
    end
    
    
    if(endedAllRep and self.spriteObject.didFinishPlayingNotificationCallback)then
        self.spriteObject.didFinishPlayingNotificationCallback(self.spriteSheet);
    end
end


function sequenceDataAndImageSheetForAnimations( animationSequenceNames, sheetPath, animations)

    local firstImageSheet = nil;
    local sequenceData = {};
    local firstImageFilePath = nil;
    
    local ghAnimations = {};
    
    for i =1, #animationSequenceNames do
        
        local animName = animationSequenceNames[i];
        local animInfo = animations[animName];
        local sprSheet = animInfo.spriteSheet;
        local imageFilePath = sheetPath .. sprSheet .. ".png";
            
        if(firstImageFilePath == nil)then
            firstImageFilePath = imageFilePath;
        end
        --create the actual sprite
        local spriteSheetPath = GHUtils.stripExtension(imageFilePath);
        spriteSheetPath = GHUtils.replaceOccuranceOfStringWithString( spriteSheetPath, "/", "." )
        -- require the sprite sheet information file
        local sheetInfo = require(spriteSheetPath); 
        --create the image sheet
        local imageSheet = graphics.newImageSheet( imageFilePath, sheetInfo.getSpriteSheetData() );
        
        if(firstImageSheet == nil)then
            firstImageSheet = imageSheet; 
        end
        
        local frms = {};
        for f =1, #animInfo.frames do
            
            local frmInfo = animInfo.frames[f]
            
            local frmName = frmInfo.spriteframe;
            
            local frmIdx = sheetInfo.getFrameForName(frmName);
            
            --for j = 1, frmInfo.delayUnits do
                frms[#frms+1] = frmIdx; 
            --end
            
        end
        
        local newGHAnim = GHSpriteSheetAnimation:createWithDictionary(animInfo, animName);
        newGHAnim.frameNamesMap = GHUtils.GHDeepCopy(sheetInfo.getFrameNamesMap());
        ghAnimations[animName] = newGHAnim;
        
        local animSequence = {name =  animName, time = animInfo.delayPerUnit, frames = frms, sheet = imageSheet};
        
        sequenceData[#sequenceData+1] = animSequence;
    end    
    
    return sequenceData, firstImageSheet, firstImageFilePath, ghAnimations;
end
--------------------------------------------------------------------------------    
--------------------------------------------------------------------------------    