local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- include Corona's "physics" library
local physics = require "physics"
physics.start(); physics.pause()

local GHSprite =  require("GameDevHelperAPI.GHSprite");

--------------------------------------------
local testCaseInfo = "Collision Filtering...\nDrag robots around the screen to test.\nBLUE robots collide with GREEN and PINK but not with BLUE.\nGREEN robots collide with BLUE and PINK but not with GREEN.\nPINK robots collide with all robots.\n(drag BLUE over BLUE or GREEN over GREEN";

-- forward declarations and other locals
local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5


local localGroup = nil;



function scene:createScene( event )
	local group = self.view
    
    localGroup = group;

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
    
end

local createdSprites = {}


-- A general function for dragging physics bodies

-- Simple example:
--     	local dragBody = gameUI.dragBody
-- 		object:addEventListener( "touch", dragBody )

function dragBody( event, params )
	local body = event.target
	local phase = event.phase
	local stage = display.getCurrentStage()

	if "began" == phase then
		stage:setFocus( body, event.id )
		body.isFocus = true

		-- Create a temporary touch joint and store it in the object for later reference
		if params and params.center then
			-- drag the body from its center point
			body.tempJoint = physics.newJoint( "touch", body, body.x, body.y )
		else
			-- drag the body from the point where it was touched
			body.tempJoint = physics.newJoint( "touch", body, event.x, event.y )
		end

--		body.tempJoint.maxForce = 0.25*body.tempJoint.maxForce

		-- Apply optional joint parameters
		if params then
			local maxForce, frequency, dampingRatio

			if params.maxForce then
				-- Internal default is (1000 * mass), so set this fairly high if setting manually
				body.tempJoint.maxForce = params.maxForce
			end
			
			if params.frequency then
				-- This is the response speed of the elastic joint: higher numbers = less lag/bounce
				body.tempJoint.frequency = params.frequency
			end
			
			if params.dampingRatio then
				-- Possible values: 0 (no damping) to 1.0 (critical damping)
				body.tempJoint.dampingRatio = params.dampingRatio
			end
		end
	
	elseif body.isFocus then
		if "moved" == phase then
		
			-- Update the joint to track the touch
			body.tempJoint:setTarget( event.x, event.y )

		elseif "ended" == phase or "cancelled" == phase then
			stage:setFocus( body, nil )
			body.isFocus = false
			
			-- Remove the joint when the touch ends			
			body.tempJoint:removeSelf()
			
		end
	end

	-- Stop further propagation of touch event
	return true
end

local function onScreenTouch( event ) 
    dragBody(event);
end 

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	physics.start()
	
    local leftWall  = display.newRect (-100, 0, 101, display.contentHeight)
    local rightWall = display.newRect (display.contentWidth, 0, 100, display.contentHeight)
    local ceiling   = display.newRect (0, -100, display.contentWidth, 101)
	local floor     = display.newRect (0, display.contentHeight, display.contentWidth, 100)
	 
	local b = 0.3 -- 0.0
	local f = 0.1 -- 10

	physics.addBody (leftWall, "static", {bounce = b, friction = f})
	physics.addBody (rightWall, "static", {bounce = b, friction = f})
	physics.addBody (ceiling, "static", {bounce = b, friction = f})
	physics.addBody (floor, "static", {bounce = b, friction = f})
    
    group:insert(leftWall);
    group:insert(rightWall);
    group:insert(ceiling);
    group:insert(floor);
    

    local blueRobot1 = GHSprite.createSpriteWithFile("Assets/physicsCollisionTestRobots_robots.png", "blueRobot");
    localGroup:insert(blueRobot1);
    blueRobot1.x = 100;
    blueRobot1.y = 100;
    
    local blueRobot2 = GHSprite.createSpriteWithFile("Assets/physicsCollisionTestRobots_robots.png", "blueRobot");
    localGroup:insert(blueRobot2);
    blueRobot2.x = 200;
    blueRobot2.y = 100;


    local greenRobot1 = GHSprite.createSpriteWithFile("Assets/physicsCollisionTestRobots_robots.png", "greenRobot");
    localGroup:insert(greenRobot1);
    greenRobot1.x = 100;
    greenRobot1.y = 200;
    
    local greenRobot2 = GHSprite.createSpriteWithFile("Assets/physicsCollisionTestRobots_robots.png", "greenRobot");
    localGroup:insert(greenRobot2);
    greenRobot2.x = 200;
    greenRobot2.y = 200;


    local pinkRobot1 = GHSprite.createSpriteWithFile("Assets/physicsCollisionTestRobots_robots.png", "pinkRobot");
    localGroup:insert(pinkRobot1);
    pinkRobot1.x = 100;
    pinkRobot1.y = 300;
    
    local pinkRobot2 = GHSprite.createSpriteWithFile("Assets/physicsCollisionTestRobots_robots.png", "pinkRobot");
    localGroup:insert(pinkRobot2);
    pinkRobot2.x = 200;
    pinkRobot2.y = 300;

    blueRobot1:addEventListener( "touch", onScreenTouch );
    blueRobot2:addEventListener( "touch", onScreenTouch );

    greenRobot1:addEventListener( "touch", onScreenTouch );
    greenRobot2:addEventListener( "touch", onScreenTouch );

    pinkRobot1:addEventListener( "touch", onScreenTouch );
    pinkRobot2:addEventListener( "touch", onScreenTouch );
    
    
    createdSprites[#createdSprites+1] = blueRobot1;
    createdSprites[#createdSprites+1] = blueRobot2;
    createdSprites[#createdSprites+1] = greenRobot1;
    createdSprites[#createdSprites+1] = greenRobot2;
    createdSprites[#createdSprites+1] = pinkRobot1;
    createdSprites[#createdSprites+1] = pinkRobot2;
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	physics.setDrawMode( "normal" ) 
    
    
    for i = 1, #createdSprites do
       local spr = createdSprites[i];
       
       spr:removeSelf();
    end
    createdSprites = nil
    createdSprites = {}
    
	physics.stop()
	
    
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	local group = self.view
	
	package.loaded[physics] = nil
	physics = nil
end

-----------------------------------------------------------------------------------------
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