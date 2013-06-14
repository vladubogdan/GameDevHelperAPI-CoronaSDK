-- This file was generated using SpriteHelper 2
-- For more informations please visit http://www.gamedevhelper.com/spritehelper2

module(...)

function getSpriteSheetData()

	local options = {
		-- array of tables representing each frame (required)
		frames = {

				--FRAME "number_1.png"
				{
					x = 17,
					y = 64,
					width = 13,
					height = 20,
					sourceWidth = 20,
					sourceHeight = 23,
					sourceX = 4,
					sourceY = 2
				},


				--FRAME "number_2.png"
				{
					x = 1,
					y = 106,
					width = 15,
					height = 20,
					sourceWidth = 20,
					sourceHeight = 23,
					sourceX = 3,
					sourceY = 2
				},


				--FRAME "number_8.png"
				{
					x = 1,
					y = 43,
					width = 15,
					height = 20,
					sourceWidth = 20,
					sourceHeight = 23,
					sourceX = 3,
					sourceY = 2
				},


				--FRAME "number_0.png"
				{
					x = 1,
					y = 64,
					width = 15,
					height = 20,
					sourceWidth = 20,
					sourceHeight = 23,
					sourceX = 3,
					sourceY = 2
				},


				--FRAME "number_4.png"
				{
					x = 1,
					y = 1,
					width = 16,
					height = 20,
					sourceWidth = 20,
					sourceHeight = 23,
					sourceX = 2,
					sourceY = 2
				},


				--FRAME "number_3.png"
				{
					x = 17,
					y = 22,
					width = 15,
					height = 20,
					sourceWidth = 20,
					sourceHeight = 23,
					sourceX = 3,
					sourceY = 2
				},


				--FRAME "number_5.png"
				{
					x = 18,
					y = 1,
					width = 14,
					height = 20,
					sourceWidth = 20,
					sourceHeight = 23,
					sourceX = 3,
					sourceY = 2
				},


				--FRAME "number_9.png"
				{
					x = 1,
					y = 85,
					width = 15,
					height = 20,
					sourceWidth = 20,
					sourceHeight = 23,
					sourceX = 3,
					sourceY = 2
				},


				--FRAME "number_7.png"
				{
					x = 17,
					y = 43,
					width = 15,
					height = 20,
					sourceWidth = 20,
					sourceHeight = 23,
					sourceX = 3,
					sourceY = 2
				},


				--FRAME "number_6.png"
				{
					x = 1,
					y = 21,
					width = 16,
					height = 20,
					sourceWidth = 20,
					sourceHeight = 23,
					sourceX = 3,
					sourceY = 2
				},

		},
		sheetContentWidth = 32,
		sheetContentHeight = 126
	}
	return options
end

function getFrameNamesMap()
	local frameIndexes =
	{
		["number_1.png"] = 1,
		["number_2.png"] = 2,
		["number_8.png"] = 3,
		["number_0.png"] = 4,
		["number_4.png"] = 5,
		["number_3.png"] = 6,
		["number_5.png"] = 7,
		["number_9.png"] = 8,
		["number_7.png"] = 9,
		["number_6.png"] = 10,
	}
	return frameIndexes;
end

function getFramesCount()
	return 10;
end

function getFrameForName(name)
	return getFrameNamesMap()[name];
end
