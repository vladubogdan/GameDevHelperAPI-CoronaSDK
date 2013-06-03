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
					y = 71,
					width = 54,
					height = 32
				},


				--FRAME "banana"
				{
					x = 48,
					y = 1,
					width = 41,
					height = 28
				},


				--FRAME "backpack"
				{
					x = 1,
					y = 71,
					width = 40,
					height = 48
				},


				--FRAME "pineapple"
				{
					x = 96,
					y = 1,
					width = 25,
					height = 63
				},


				--FRAME "canteen"
				{
					x = 97,
					y = 65,
					width = 21,
					height = 32
				},


				--FRAME "bananabunch"
				{
					x = 48,
					y = 30,
					width = 39,
					height = 27
				},


				--FRAME "statue"
				{
					x = 1,
					y = 1,
					width = 46,
					height = 69
				},

		},
		sheetContentWidth = 123,
		sheetContentHeight = 121
	}
	return options
end

function getFrameForName(name)
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
	return frameIndexes[name];
end
