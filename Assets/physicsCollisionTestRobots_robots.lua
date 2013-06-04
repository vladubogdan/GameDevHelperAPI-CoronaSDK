-- This file was generated using SpriteHelper 2
-- For more informations please visit http://www.gamedevhelper.com/spritehelper2

module(...)

function getSpriteSheetData()

	local options = {
		-- array of tables representing each frame (required)
		frames = {

				--FRAME "blueRobot"
				{
					x = 1,
					y = 1,
					width = 55,
					height = 67
				},


				--FRAME "greenRobot"
				{
					x = 57,
					y = 1,
					width = 55,
					height = 67
				},


				--FRAME "pinkRobot"
				{
					x = 1,
					y = 69,
					width = 55,
					height = 67
				},

		},
		sheetContentWidth = 114,
		sheetContentHeight = 138
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
