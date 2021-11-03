--[[
	id: 0yjW2ocSCZncXqz2Zv_IY
	name: Times Tables Script
	description: Times Tables Solver
	time1: 2021-05-05 16:17:04.29078+00
	time2: 2021-05-05 16:17:04.29078+00
	uploader: W8FWkprIhNQI7YQ7QPOCyvO4IKY4ZDXoHwppQrFA
	uploadersession: kwQzQ1-KWp1i1xlgg3opWMxfNCbkD1
	flag: f
--]]


-- Values

local timesNumber = 15 -- Which number times table you want.
local frontLabel = timesNumber .. ' Times Table:'
local currentNumber = "1"
local howManyTimes = 100 -- How many lines you want printed.

-- ALL BELOW IS THE CODE DO NOT TOUCH UNLESS FORKING

for i = 1,howManyTimes do
if howManyTimes <= 100 then
print(frontLabel)
print('Number '.. currentNumber)
print(timesNumber .. ' x ' .. currentNumber)
print('Product = ' .. timesNumber * currentNumber)
print("-------------------")
currentNumber = currentNumber + 1
else
print("Sorry you can only print up to 100 lines.")
end
end