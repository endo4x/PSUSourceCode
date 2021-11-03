--[[
	id: TfluIbTQhPk3iFnD-YZlK
	name: Lua Sandboxing
	description: test
	time1: 2021-05-05 15:49:46.844047+00
	time2: 2021-05-05 15:49:46.844048+00
	uploader: W8FWkprIhNQI7YQ7QPOCyvO4IKY4ZDXoHwppQrFA
	uploadersession: kwQzQ1-KWp1i1xlgg3opWMxfNCbkD1
	flag: f
--]]

local status = 1
for i = 1,100 do
print('Number '.. status .. ' Is the returned value')
print(status .. ' + 5 = ' .. status+5)
local addValue = status+5
print(addValue .. ' is the returned math value.')
status = status + 1
end
