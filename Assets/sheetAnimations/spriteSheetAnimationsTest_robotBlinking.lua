-- This file was generated using SpriteHelper 2
-- For more informations please visit http://www.gamedevhelper.com/spritehelper2

module(...)

function getSpriteSheetData()

	local options = {
		-- array of tables representing each frame (required)
		frames = {

				--FRAME "robotEyesClose.png"
				{
					x = 1,
					y = 1,
					width = 100,
					height = 100,
				},


				--FRAME "robotEyesOpen.png"
				{
					x = 1,
					y = 103,
					width = 100,
					height = 100,
				},

		},
		sheetContentWidth = 102,
		sheetContentHeight = 204
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
