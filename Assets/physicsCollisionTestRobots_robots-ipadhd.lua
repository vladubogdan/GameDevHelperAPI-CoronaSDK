-- This file was generated using SpriteHelper 2
-- For more informations please visit http://www.gamedevhelper.com/spritehelper2

module(...)

function getSpriteSheetData()

	local options = {
		-- array of tables representing each frame (required)
		frames = {

				--FRAME "blueRobot"
				{
					x = 2,
					y = 2,
					width = 219,
					height = 267
				},


				--FRAME "greenRobot"
				{
					x = 225,
					y = 2,
					width = 219,
					height = 267
				},


				--FRAME "pinkRobot"
				{
					x = 2,
					y = 273,
					width = 219,
					height = 267
				},

		},
		sheetContentWidth = 446,
		sheetContentHeight = 542
	}
	return options
end

function getFrameForName(name)
	local frameIndexes =
	{
		["blueRobot"] = 1,
		["greenRobot"] = 2,
		["pinkRobot"] = 3,
	}
	return frameIndexes[name];
end
