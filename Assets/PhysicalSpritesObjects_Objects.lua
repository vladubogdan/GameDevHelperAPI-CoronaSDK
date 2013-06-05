-- This file was generated using SpriteHelper 2
-- For more informations please visit http://www.gamedevhelper.com/spritehelper2

module(...)

function getSpriteSheetData()

	local options = {
		-- array of tables representing each frame (required)
		frames = {

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


				--FRAME "ball"
				{
					x = 99,
					y = 1,
					width = 13,
					height = 13,
					sourceWidth = 13,
					sourceHeight = 13,
					sourceX = 0,
					sourceY = 0
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


				--FRAME "canteen"
				{
					x = 76,
					y = 1,
					width = 21,
					height = 32,
					sourceWidth = 29,
					sourceHeight = 39,
					sourceX = 3,
					sourceY = 3
				},


				--FRAME "pineapple"
				{
					x = 49,
					y = 1,
					width = 25,
					height = 62,
					sourceWidth = 30,
					sourceHeight = 66,
					sourceX = 3,
					sourceY = 2
				},


				--FRAME "banana"
				{
					x = 76,
					y = 35,
					width = 40,
					height = 27,
					sourceWidth = 45,
					sourceHeight = 31,
					sourceX = 2,
					sourceY = 1
				},


				--FRAME "bananabunch"
				{
					x = 42,
					y = 99,
					width = 38,
					height = 27,
					sourceWidth = 43,
					sourceHeight = 32,
					sourceX = 3,
					sourceY = 2
				},


				--FRAME "hat"
				{
					x = 49,
					y = 65,
					width = 54,
					height = 31,
					sourceWidth = 61,
					sourceHeight = 37,
					sourceX = 3,
					sourceY = 2
				},

		},
		sheetContentWidth = 117,
		sheetContentHeight = 127
	}
	return options
end

function getFrameNamesMap()
	local frameIndexes =
	{
		["statue"] = 1,
		["ball"] = 2,
		["backpack"] = 3,
		["canteen"] = 4,
		["pineapple"] = 5,
		["banana"] = 6,
		["bananabunch"] = 7,
		["hat"] = 8,
	}
	return frameIndexes;
end

function getFramesCount()
	return 8;
end

function getFrameForName(name)
	return getFrameNamesMap()[name];
end
