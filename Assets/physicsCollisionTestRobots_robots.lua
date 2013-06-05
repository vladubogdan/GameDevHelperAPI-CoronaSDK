-- This file was generated using SpriteHelper 2
-- For more informations please visit http://www.gamedevhelper.com/spritehelper2

module(...)

function getSpriteSheetData()

	local options = {
		-- array of tables representing each frame (required)
		frames = {

				--FRAME "blueRobot"
				{
					x = 0,
					y = 0,
					width = 54,
					height = 66,
					sourceWidth = 65,
					sourceHeight = 75,
					sourceX = 5,
					sourceY = 3
				},


				--FRAME "greenRobot"
				{
					x = 56,
					y = 0,
					width = 54,
					height = 66,
					sourceWidth = 65,
					sourceHeight = 75,
					sourceX = 5,
					sourceY = 3
				},


				--FRAME "pinkRobot"
				{
					x = 0,
					y = 68,
					width = 54,
					height = 66,
					sourceWidth = 65,
					sourceHeight = 75,
					sourceX = 5,
					sourceY = 3
				},

		},
		sheetContentWidth = 111,
		sheetContentHeight = 135
	}
	return options
end

function getFrameNamesMap()
	local frameIndexes =
	{
		["blueRobot"] = 1,
		["greenRobot"] = 2,
		["pinkRobot"] = 3,
	}
	return frameIndexes;
end

function getFramesCount()
	return 3;
end

function getFrameForName(name)
	return getFrameNamesMap()[name];
end
