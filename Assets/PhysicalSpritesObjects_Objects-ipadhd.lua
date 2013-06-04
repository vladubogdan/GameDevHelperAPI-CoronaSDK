-- This file was generated using SpriteHelper 2
-- For more informations please visit http://www.gamedevhelper.com/spritehelper2

module(...)

function getSpriteSheetData()

	local options = {
		-- array of tables representing each frame (required)
		frames = {

				--FRAME "statue"
				{
					x = 2,
					y = 2,
					width = 184,
					height = 276
				},


				--FRAME "ball"
				{
					x = 165,
					y = 412,
					width = 52,
					height = 52
				},


				--FRAME "backpack"
				{
					x = 2,
					y = 282,
					width = 159,
					height = 190
				},


				--FRAME "canteen"
				{
					x = 386,
					y = 257,
					width = 84,
					height = 129
				},


				--FRAME "pineapple"
				{
					x = 386,
					y = 2,
					width = 100,
					height = 251
				},


				--FRAME "banana"
				{
					x = 190,
					y = 2,
					width = 163,
					height = 111
				},


				--FRAME "bananabunch"
				{
					x = 190,
					y = 117,
					width = 154,
					height = 109
				},


				--FRAME "hat"
				{
					x = 165,
					y = 282,
					width = 217,
					height = 126
				},

		},
		sheetContentWidth = 488,
		sheetContentHeight = 474
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
