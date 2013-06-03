-- This file was generated using SpriteHelper 2
-- For more informations please visit http://www.gamedevhelper.com/spritehelper2

module(...)

function getSpriteSheetData()

	local options = {
		-- array of tables representing each frame (required)
		frames = {

				--FRAME "hat"
				{
					x = 165,
					y = 282,
					width = 217,
					height = 126
				},


				--FRAME "banana"
				{
					x = 190,
					y = 2,
					width = 163,
					height = 111
				},


				--FRAME "backpack"
				{
					x = 2,
					y = 282,
					width = 159,
					height = 190
				},


				--FRAME "pineapple"
				{
					x = 386,
					y = 2,
					width = 100,
					height = 251
				},


				--FRAME "canteen"
				{
					x = 386,
					y = 257,
					width = 84,
					height = 129
				},


				--FRAME "bananabunch"
				{
					x = 190,
					y = 117,
					width = 154,
					height = 109
				},


				--FRAME "statue"
				{
					x = 2,
					y = 2,
					width = 184,
					height = 276
				},

		},
		sheetContentWidth = 488,
		sheetContentHeight = 474
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
