-- This file was generated using SpriteHelper 2
-- For more informations please visit http://www.gamedevhelper.com/spritehelper2

module(...)

function getSpriteSheetData()

	local options = {
		-- array of tables representing each frame (required)
		frames = {

				--FRAME "object_statue.png"
				{
					x = 52,
					y = 184,
					width = 46,
					height = 69,
					sourceWidth = 53,
					sourceHeight = 74,
					sourceX = 4,
					sourceY = 3
				},


				--FRAME "object_hat.png"
				{
					x = 88,
					y = 53,
					width = 54,
					height = 32,
					sourceWidth = 61,
					sourceHeight = 38,
					sourceX = 4,
					sourceY = 3
				},


				--FRAME "object_backpack.png"
				{
					x = 48,
					y = 53,
					width = 40,
					height = 48,
					sourceWidth = 45,
					sourceHeight = 53,
					sourceX = 3,
					sourceY = 3
				},


				--FRAME "object_banana.png"
				{
					x = 88,
					y = 85,
					width = 41,
					height = 28,
					sourceWidth = 46,
					sourceHeight = 32,
					sourceX = 3,
					sourceY = 2
				},


				--FRAME "bg_2_jungle_960x2048.png"
				{
					x = 229,
					y = 84,
					width = 240,
					height = 512,
					sourceWidth = 240,
					sourceHeight = 512,
					sourceX = 0,
					sourceY = 0
				},


				--FRAME "bg_2_grassfront_960w.png"
				{
					x = 258,
					y = 35,
					width = 240,
					height = 17,
					sourceWidth = 240,
					sourceHeight = 38,
					sourceX = 0,
					sourceY = 20
				},


				--FRAME "object_canteen.png"
				{
					x = 209,
					y = 53,
					width = 21,
					height = 32,
					sourceWidth = 30,
					sourceHeight = 39,
					sourceX = 4,
					sourceY = 4
				},


				--FRAME "bg_2_grassfront_1024w.png"
				{
					x = 1,
					y = 35,
					width = 256,
					height = 17,
					sourceWidth = 256,
					sourceHeight = 38,
					sourceX = 0,
					sourceY = 21
				},


				--FRAME "object_bananabunch.png"
				{
					x = 170,
					y = 53,
					width = 39,
					height = 27,
					sourceWidth = 44,
					sourceHeight = 33,
					sourceX = 4,
					sourceY = 3
				},


				--FRAME "bg_2_jungle_1024x2048.png"
				{
					x = 436,
					y = 54,
					width = 256,
					height = 512,
					sourceWidth = 256,
					sourceHeight = 512,
					sourceX = 0,
					sourceY = 0
				},


				--FRAME "bg_2_grassbehind_960w.png"
				{
					x = 258,
					y = 1,
					width = 240,
					height = 33,
					sourceWidth = 240,
					sourceHeight = 38,
					sourceX = 0,
					sourceY = 4
				},


				--FRAME "object_pineapple.png"
				{
					x = 144,
					y = 53,
					width = 25,
					height = 63,
					sourceWidth = 30,
					sourceHeight = 67,
					sourceX = 3,
					sourceY = 3
				},


				--FRAME "bg_2_grassbehind_1024w.png"
				{
					x = 1,
					y = 1,
					width = 256,
					height = 33,
					sourceWidth = 256,
					sourceHeight = 38,
					sourceX = 0,
					sourceY = 4
				},

		},
		sheetContentWidth = 692,
		sheetContentHeight = 596
	}
	return options
end

function getFrameNamesMap()
	local frameIndexes =
	{
		["object_statue.png"] = 1,
		["object_hat.png"] = 2,
		["object_backpack.png"] = 3,
		["object_banana.png"] = 4,
		["bg_2_jungle_960x2048.png"] = 5,
		["bg_2_grassfront_960w.png"] = 6,
		["object_canteen.png"] = 7,
		["bg_2_grassfront_1024w.png"] = 8,
		["object_bananabunch.png"] = 9,
		["bg_2_jungle_1024x2048.png"] = 10,
		["bg_2_grassbehind_960w.png"] = 11,
		["object_pineapple.png"] = 12,
		["bg_2_grassbehind_1024w.png"] = 13,
	}
	return frameIndexes;
end

function getFramesCount()
	return 13;
end

function getFrameForName(name)
	return getFrameNamesMap()[name];
end
