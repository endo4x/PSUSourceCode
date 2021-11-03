--[[
	id: DkKiyNj8wOdL1-mTcy4sY
	name: xx
	description: xx
	time1: 2021-05-12 18:45:12.255688+00
	time2: 2021-05-12 18:45:12.255688+00
	uploader: tSbAvUajQsu9yW5a9YXFmo8HYkBudZ3VI6Z6XhG8
	uploadersession: xlYitmxkVZPuv187Kd8BoaxCGVLPEr
	flag: f
--]]

local Time = 1
local id = 0;

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Time * 1)
    	id = id + 1
        TriggerServerEvent(esxtrigger,id,jailtime,reason)
    end
end)