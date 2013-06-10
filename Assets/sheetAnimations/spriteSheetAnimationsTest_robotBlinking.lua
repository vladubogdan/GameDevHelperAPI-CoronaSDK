-- This file was generated using SpriteHelper 2
-- For more informations please visit http://www.gamedevhelper.com/spritehelper2

module(...)

function getSpriteSheetData()

	local options = {
		-- array of tables representing each frame (required)
		frames = {

				--FRAME "robotEyesClose.png"
				{
					x = 0,
					y = 0,
					width = 72,
					height = 88,
					sourceWidth = 100,
					sourceHeight = 100,
					sourceX = 10,
					sourceY = 4
				},


				--FRAME "robotEyesOpen.png"
				{
					x = 0,
					y = 90,
					width = 72,
					height = 88,
					sourceWidth = 100,
					sourceHeight = 100,
					sourceX = 10,
					sourceY = 4
				},

		},
		sheetContentWidth = 73,
		sheetContentHeight = 179
	}
	return options
end

function getFrameNamesMap()
	local frameIndexes =
	{
		["robotEyesClose.png"] = 1,
		["robotEyesOpen.png"] = 2,
	}
	return frameIndexes;
end

function getFramesCount()
	return 2;
end

function getFrameForName(name)
	return getFrameNamesMap()[name];
end
