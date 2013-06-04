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
					width = 110,
					height = 134
				},


				--FRAME "greenRobot"
				{
					x = 113,
					y = 1,
					width = 110,
					height = 134
				},


				--FRAME "pinkRobot"
				{
					x = 1,
					y = 137,
					width = 110,
					height = 134
				},

		},
		sheetContentWidth = 225,
		sheetContentHeight = 273
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
