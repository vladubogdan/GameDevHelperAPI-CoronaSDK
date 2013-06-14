-- This file was generated using SpriteHelper 2
-- For more informations please visit http://www.gamedevhelper.com/spritehelper2

module(...)

function getSpriteSheetData()

	local options = {
		-- array of tables representing each frame (required)
		frames = {

				--FRAME "TrimAnimation_1.png"
				{
					x = 852,
					y = 368,
					width = 138,
					height = 54,
					sourceWidth = 494,
					sourceHeight = 164,
					sourceX = 13,
					sourceY = 98
				},


				--FRAME "TrimAnimation_8.png"
				{
					x = 1,
					y = 280,
					width = 334,
					height = 139,
					sourceWidth = 494,
					sourceHeight = 164,
					sourceX = 13,
					sourceY = 13
				},


				--FRAME "TrimAnimation_12.png"
				{
					x = 1,
					y = 1,
					width = 469,
					height = 139,
					sourceWidth = 494,
					sourceHeight = 164,
					sourceX = 13,
					sourceY = 13
				},


				--FRAME "TrimAnimation_9.png"
				{
					x = 407,
					y = 140,
					width = 355,
					height = 139,
					sourceWidth = 494,
					sourceHeight = 164,
					sourceX = 13,
					sourceY = 13
				},


				--FRAME "TrimAnimation_5.png"
				{
					x = 631,
					y = 280,
					width = 220,
					height = 135,
					sourceWidth = 494,
					sourceHeight = 164,
					sourceX = 13,
					sourceY = 17
				},


				--FRAME "TrimAnimation_2.png"
				{
					x = 852,
					y = 280,
					width = 150,
					height = 87,
					sourceWidth = 494,
					sourceHeight = 164,
					sourceX = 13,
					sourceY = 64
				},


				--FRAME "TrimAnimation_4.png"
				{
					x = 631,
					y = 416,
					width = 202,
					height = 122,
					sourceWidth = 494,
					sourceHeight = 164,
					sourceX = 13,
					sourceY = 29
				},


				--FRAME "TrimAnimation_6.png"
				{
					x = 763,
					y = 140,
					width = 248,
					height = 139,
					sourceWidth = 494,
					sourceHeight = 164,
					sourceX = 13,
					sourceY = 13
				},


				--FRAME "TrimAnimation_10.png"
				{
					x = 1,
					y = 140,
					width = 406,
					height = 139,
					sourceWidth = 494,
					sourceHeight = 164,
					sourceX = 13,
					sourceY = 13
				},


				--FRAME "TrimAnimation_7.png"
				{
					x = 336,
					y = 280,
					width = 294,
					height = 139,
					sourceWidth = 494,
					sourceHeight = 164,
					sourceX = 13,
					sourceY = 13
				},


				--FRAME "TrimAnimation_3.png"
				{
					x = 834,
					y = 423,
					width = 187,
					height = 111,
					sourceWidth = 494,
					sourceHeight = 164,
					sourceX = 13,
					sourceY = 41
				},


				--FRAME "TrimAnimation_11.png"
				{
					x = 471,
					y = 1,
					width = 438,
					height = 139,
					sourceWidth = 494,
					sourceHeight = 164,
					sourceX = 13,
					sourceY = 13
				},

		},
		sheetContentWidth = 1021,
		sheetContentHeight = 538
	}
	return options
end

function getFrameNamesMap()
	local frameIndexes =
	{
		["TrimAnimation_1.png"] = 1,
		["TrimAnimation_8.png"] = 2,
		["TrimAnimation_12.png"] = 3,
		["TrimAnimation_9.png"] = 4,
		["TrimAnimation_5.png"] = 5,
		["TrimAnimation_2.png"] = 6,
		["TrimAnimation_4.png"] = 7,
		["TrimAnimation_6.png"] = 8,
		["TrimAnimation_10.png"] = 9,
		["TrimAnimation_7.png"] = 10,
		["TrimAnimation_3.png"] = 11,
		["TrimAnimation_11.png"] = 12,
	}
	return frameIndexes;
end

function getFramesCount()
	return 12;
end

function getFrameForName(name)
	return getFrameNamesMap()[name];
end
