-- This file was generated using SpriteHelper 2
-- For more informations please visit http://www.gamedevhelper.com/spritehelper2

module(...)

function getSpriteSheetData()

	local options = {
		-- array of tables representing each frame (required)
		frames = {

				--FRAME "flame4.png"
				{
					x = 1,
					y = 1,
					width = 13,
					height = 19,
					sourceWidth = 13,
					sourceHeight = 19,
					sourceX = 0.000000,
					sourceY = 0.000000
				},


				--FRAME "flame6.png"
				{
					x = 16,
					y = 21,
					width = 12,
					height = 19,
					sourceWidth = 12,
					sourceHeight = 19,
					sourceX = 0.000000,
					sourceY = 0.000000
				},


				--FRAME "flame1.png"
				{
					x = 1,
					y = 22,
					width = 12,
					height = 19,
					sourceWidth = 12,
					sourceHeight = 19,
					sourceX = 0.000000,
					sourceY = 0.000000
				},


				--FRAME "flame3.png"
				{
					x = 1,
					y = 63,
					width = 10,
					height = 18,
					sourceWidth = 10,
					sourceHeight = 18,
					sourceX = 0.000000,
					sourceY = 0.000000
				},


				--FRAME "flame5.png"
				{
					x = 15,
					y = 42,
					width = 12,
					height = 19,
					sourceWidth = 12,
					sourceHeight = 19,
					sourceX = 0.000000,
					sourceY = 0.000000
				},


				--FRAME "flame7.png"
				{
					x = 16,
					y = 1,
					width = 13,
					height = 18,
					sourceWidth = 13,
					sourceHeight = 18,
					sourceX = 0.000000,
					sourceY = 0.000000
				},


				--FRAME "flame0.png"
				{
					x = 1,
					y = 43,
					width = 11,
					height = 18,
					sourceWidth = 11,
					sourceHeight = 18,
					sourceX = 0.000000,
					sourceY = 0.000000
				},


				--FRAME "flame2.png"
				{
					x = 13,
					y = 63,
					width = 9,
					height = 19,
					sourceWidth = 9,
					sourceHeight = 19,
					sourceX = 0.000000,
					sourceY = 0.000000
				},

		},
		sheetContentWidth = 31,
		sheetContentHeight = 83
	}
	return options
end

function getFrameNamesMap()
	local frameIndexes =
	{
		["flame4.png"] = 1,
		["flame6.png"] = 2,
		["flame1.png"] = 3,
		["flame3.png"] = 4,
		["flame5.png"] = 5,
		["flame7.png"] = 6,
		["flame0.png"] = 7,
		["flame2.png"] = 8,
	}
	return frameIndexes;
end

function getFramesCount()
	return 8;
end

function getFrameForName(name)
	return getFrameNamesMap()[name];
end
