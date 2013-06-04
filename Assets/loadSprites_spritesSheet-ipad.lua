-- This file was generated using SpriteHelper 2
-- For more informations please visit http://www.gamedevhelper.com/spritehelper2

module(...)

function getSpriteSheetData()

	local options = {
		-- array of tables representing each frame (required)
		frames = {

				--FRAME "hat"
				{
					x = 83,
					y = 142,
					width = 109,
					height = 63
				},


				--FRAME "banana"
				{
					x = 95,
					y = 1,
					width = 82,
					height = 56
				},


				--FRAME "backpack"
				{
					x = 1,
					y = 142,
					width = 80,
					height = 95
				},


				--FRAME "pineapple"
				{
					x = 194,
					y = 1,
					width = 50,
					height = 126
				},


				--FRAME "canteen"
				{
					x = 194,
					y = 129,
					width = 42,
					height = 65
				},


				--FRAME "bananabunch"
				{
					x = 95,
					y = 59,
					width = 77,
					height = 55
				},


				--FRAME "statue"
				{
					x = 1,
					y = 1,
					width = 92,
					height = 138
				},

		},
		sheetContentWidth = 246,
		sheetContentHeight = 239
	}
	return options
end

function getFrameNamesMap()
	local frameIndexes =
	{
		["hat"] = 1,
		["banana"] = 2,
		["backpack"] = 3,
		["pineapple"] = 4,
		["canteen"] = 5,
		["bananabunch"] = 6,
		["statue"] = 7,
	}
	return frameIndexes;
end

function getFramesCount()
	return 7;
end

function getFrameForName(name)
	return getFrameNamesMap()[name];
end
