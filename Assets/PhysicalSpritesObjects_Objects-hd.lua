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
					width = 92,
					height = 138
				},


				--FRAME "ball"
				{
					x = 83,
					y = 206,
					width = 26,
					height = 26
				},


				--FRAME "backpack"
				{
					x = 1,
					y = 142,
					width = 80,
					height = 95
				},


				--FRAME "canteen"
				{
					x = 194,
					y = 129,
					width = 42,
					height = 65
				},


				--FRAME "pineapple"
				{
					x = 194,
					y = 1,
					width = 50,
					height = 126
				},


				--FRAME "banana"
				{
					x = 95,
					y = 1,
					width = 82,
					height = 56
				},


				--FRAME "bananabunch"
				{
					x = 95,
					y = 59,
					width = 77,
					height = 55
				},


				--FRAME "hat"
				{
					x = 83,
					y = 142,
					width = 109,
					height = 63
				},

		},
		sheetContentWidth = 246,
		sheetContentHeight = 239
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
