
--!@docBegin
--!GHBone class is used to define skeleton structures. Each bone is connected to other children bones. 
--! 
--!When a bone is moved each of its children is moved as well in order to simulate skeletons.
--!
--!End users will probably never have to use this class directly.
--!@docEnd

GHBone = {}

--!@docBegin
--!Creates a GHBone object.
function GHBone:init()
--!@docEnd
    
	local object = {m_rigid = false,
                    m_name = "",
                    m_uuid = "",
                    children = {},
                    neighbours = {},
                    neighboursDistances = {},
                    parent = nil,
                    positionX = 0.0,
                    positionY = 0.0,
                    previousPositionX = 0.0,--used when transitioning
                    previousPositionY = 0.0--used when transitioning
					}

	setmetatable(object, { __index = GHBone })  -- Inheritance	
    
	return object
end


--!@docBegin
--!Initializes a bone using the options from a dictionary.
--!@param dict An associative table object with keys representing the bone properties.
function GHBone:createWithDict(dict)
--!@docEnd

    --loading info from dictionary
    self.m_rigid = false;
    if(dict.rigid)then --property not available when bone is not rigid
        self.m_rigid = dict.rigid;
    end
    
    self.m_name = dict.name;
    self.m_uuid = dict.uuid;


    local GHUtils = require("GameDevHelperAPI.GHUtils");
    
    local bonePos = dict.localPos;  
    if(bonePos ~= nil)then--if bone is root it does not have a local pos 
    
        local pos = GHUtils.pointFromString(bonePos);
        if pos then
            self.positionX = pos.x;
            self.positionY = pos.y;
        end
    end
    
    local childrenInfo = dict.children
    if childrenInfo then
    
        for i = 1, #childrenInfo do
        
            local childInfo = childrenInfo[i];
            if childInfo then
                
                local newbone = GHBone:init();
                newbone:createWithDict(childInfo);
                if newbone ~= null then
                    self:addChild(newbone);
                end
            end
        end
    end
    
    return self;
end

--!@docBegin
--!Set the rigid state of this bone.
--!@param val A boolean value.
function GHBone:setRigid(val)
--!@docEnd
    self.m_rigid = val;
end



--!@docBegin
--!Returns a boolean variable representing the rigid state of this bone.
function GHBone:getRigid()
--!@docEnd
    return self.m_rigid;
end

--!@docBegin
--!Returns an array which includes this and all children bones.
function GHBone:getAllBones()
--!@docEnd
    local array = {};
	
    array[#array+1] = self;
	
    for i = 1, #self.children do
		local childBone = self.children[i];
		if childBone then
		
			local boneChildren = childBone:getAllBones();
			if boneChildren  then
                for j = 1, #boneChildren do
				    array[#array+1] = boneChildren[j];
                end
			end
		end
	end
	return array;       
end

--!@docBegin
--!Returns a specific children bone given the name of the bone.
--!@param val A string value representing the bone name.
function GHBone:getBoneWithName(val)
--!@docEnd  

	if self.m_name == val then
		return self;
	end

	local boneChildren = self:getChildren();
	for i = 1, #boneChildren do
		local bone = boneChildren[i];
		if bone then
			local returnBone = bone:getBoneWithName(val)
			if returnBone then
				return returnBone;
			end
		end
	end
		
	return null;
end

--!@docBegin
--!Returns the name of the bone as a string value.
function GHBone:getName()
--!@docEnd
	return self.m_name;
end

--!@docBegin
--!Returns the unique identifier of the bone as a string value.
function GHBone:getUUID()
--!@docEnd
	return self.m_uuid;
end

--!@docBegin
--!Sets the position of the bone given the bone parent, which may be NULL.
--!@param posX A number value.
--!@param posY A number value.
--!@param father null or GHBone object.
function GHBone:setBonePosition(posX, posY, father)
--!@docEnd
	self:setPosition(posX, posY);
	self:move(father);
end

--!@docBegin
--!Returns the angle between this bone and its parent in degrees.
function GHBone:degrees()
--!@docEnd

	local _father = self:getParent();
	if _father then
	
		local curPointX = _father:getPositionX();
		local curPointY = _father:getPositionY();
		
		local endPointX = self:getPositionX();
		local endPointY = self:getPositionY();
		
		return (math.atan2( curPointY - endPointY, 
							endPointX - curPointX)*180.0)/math.pi + 90.0;   
	end

	return 0.0;
end

--!@docBegin
--!Returns the parent bone of this bone.
function GHBone:getParent()
--!@docEnd
	return self.parent;
end

--!@docBegin
--!Get local X position of the bone.
function GHBone:getPositionX()
--!@docEnd
    return self.positionX;
end

--!@docBegin
--!Get local Y position of the bone.
function GHBone:getPositionY()
--!@docEnd
	return self.positionY;
end

--!@docBegin
--!Sets the local position of the bone.
--!@param x a number value
--!@param y a number value
function GHBone:setPosition(x, y)
--!docEnd
	self.positionX = x;
	self.positionY = y;
end

--!@docBegin
--!Save the current position to previousPosition. This is called at the begining of a transition.
function GHBone:savePosition()
--!docEnd
    self.previousPositionX = self.positionX;
    self.previousPositionY = self.positionY;
end

function GHBone:getPreviousPositionX()
    return self.previousPositionX;
end

function GHBone:getPreviousPositionY()
    return self.previousPositionY;
end

function GHBone:calculateDistancesFromNeighbours()

	self.neighboursDistances ={};
	
	for i = 1, #self.neighbours do
	
		local node = self.neighbours[i];
		
		local dx = node:getPositionX() - self:getPositionX();
		local dy = node:getPositionY() - self:getPositionY();
		
		self.neighboursDistances[#self.neighboursDistances+1] = math.sqrt(dx*dx + dy*dy);
	end
end

function GHBone:addNeighbor(neighbor)

	if self.neighbours == nill then
		self.neighbours = {};
		self.neighboursDistances = {};
	end

	self.neighbours[#self.neighbours + 1] = neighbor;
	self:calculateDistancesFromNeighbours();
end

function GHBone:addChild(child)

	self:addNeighbor(child);
	self.children[#self.children + 1] = child;
	child:setParent(self);
	self:calculateDistancesFromNeighbours();
	child:addNeighbor(self);
    
end

--not currently used so its not ported
--function GHBone:removeNeighbor(neighbor)
--
--	local index = this.neighbours.indexOf(neighbor);
--	this.neighbours.splice(index, 1);
--end

function GHBone:setParent(father)

	if self.parent == nil then
		self.parent = father;
	end
end

function GHBone:getChildren()
	return self.children;
end


function GHBone:makeMove(parent, child, dist)

	if child and child:getRigid() then
	--do nothing
	elseif parent then
	
		local dx = self:getPositionX() - parent:getPositionX();
		local dy = self:getPositionY() - parent:getPositionY();
		local angle = math.atan2(dy, dx);

		self:setPosition(   parent:getPositionX() + math.cos(angle)*dist,
                            parent:getPositionY() + math.sin(angle)*dist);

    else 
    
	end
end


function GHBone:move(father)

	for i = 1, #self.neighbours do
		local node = self.neighbours[i];
		if node ~= father then
		
			node:makeMove(self, node, self.neighboursDistances[i]);
			
			node:move(self);
		end
	end
end


function GHBone:updateMovement()

	if self:getRigid() then
	
		self:setBonePosition(self:getPositionX(), self:getPositionY(), nil);
	end

	local boneChildren = self:getChildren();
    for i = 1, #boneChildren do
		local bone = boneChildren[i];
		bone:updateMovement();
	end
end
