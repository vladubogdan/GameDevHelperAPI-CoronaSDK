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
					height = 69
				},


				--FRAME "ball"
				{
					x = 41,
					y = 103,
					width = 13,
					height = 13
				},


				--FRAME "backpack"
				{
					x = 1,
					y = 71,
					width = 40,
					height = 48
				},


				--FRAME "canteen"
				{
					x = 97,
					y = 65,
					width = 21,
					height = 32
				},


				--FRAME "pineapple"
				{
					x = 96,
					y = 1,
					width = 25,
					height = 63
				},


				--FRAME "banana"
				{
					x = 48,
					y = 1,
					width = 41,
					height = 28
				},


				--FRAME "bananabunch"
				{
					x = 48,
					y = 30,
					width = 39,
					height = 27
				},


				--FRAME "hat"
				{
					x = 42,
					y = 71,
					width = 54,
					height = 32
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
		["statue"] = 1,
		["ball"] = 2,
		["backpack"] = 3,
		["canteen"] = 4,
		["pineapple"] = 5,
		["banana"] = 6,
		["bananabunch"] = 7,
		["hat"] = 8,
	}
	return frameIndexes[name];
end
