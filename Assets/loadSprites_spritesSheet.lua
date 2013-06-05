-- This file was generated using SpriteHelper 2
-- For more informations please visit http://www.gamedevhelper.com/spritehelper2

module(...)

function getSpriteSheetData()

	local options = {
		-- array of tables representing each frame (required)
		frames = {

				--FRAME "hat"
				{
					x = 42,
					y = 72,
					width = 54,
					height = 31,
					sourceWidth = 61,
					sourceHeight = 37,
					sourceX = 3,
					sourceY = 2
				},


				--FRAME "banana"
				{
					x = 49,
					y = 1,
					width = 40,
					height = 27,
					sourceWidth = 45,
					sourceHeight = 31,
					sourceX = 2,
					sourceY = 1
				},


				--FRAME "backpack"
				{
					x = 1,
					y = 72,
					width = 39,
					height = 47,
					sourceWidth = 44,
					sourceHeight = 53,
					sourceX = 2,
					sourceY = 2
				},


				--FRAME "pineapple"
				{
					x = 99,
					y = 1,
					width = 25,
					height = 62,
					sourceWidth = 30,
					sourceHeight = 66,
					sourceX = 3,
					sourceY = 2
				},


				--FRAME "canteen"
				{
					x = 99,
					y = 65,
					width = 21,
					height = 32,
					sourceWidth = 29,
					sourceHeight = 39,
					sourceX = 3,
					sourceY = 3
				},


				--FRAME "bananabunch"
				{
					x = 49,
					y = 30,
					width = 38,
					height = 27,
					sourceWidth = 43,
					sourceHeight = 32,
					sourceX = 3,
					sourceY = 2
				},


				--FRAME "statue"
				{
					x = 1,
					y = 1,
					width = 46,
					height = 69,
					sourceWidth = 52,
					sourceHeight = 73,
					sourceX = 3,
					sourceY = 2
				},

		},
		sheetContentWidth = 125,
		sheetContentHeight = 120
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
