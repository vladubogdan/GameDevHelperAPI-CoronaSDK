-- This file was generated using SpriteHelper 2
-- For more informations please visit http://www.gamedevhelper.com/spritehelper2

module(...)

function getSequenceData()

	local sequenceData = {
		{
			name = "NumbersAnim",
			frames={4, 1, 2, 6, 5, 7, 7, 10, 10, 9, 9, 3, 3, 8, 8, },
			time=10000.001192,
			loopCount = 0
		},
		{
			name = "fireAnim",
			frames={7, 3, 8, 4, 1, 5, 2, 6, },
			time=1000.000015,
			loopCount = 0
		},
		{
			name = "blinkingAnim",
			frames={2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, },
			time=1000.000015,
			loopCount = 0
		},
	}
return sequenceData
end

function getSequenceWithName(name)

	local seq = getSequenceData();
	for i =1, #seq do
		if seq[i].name == name then
			return { seq[i] };
		end
	end
return nil;
end
