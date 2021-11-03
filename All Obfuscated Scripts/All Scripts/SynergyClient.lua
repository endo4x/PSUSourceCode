--[[
	id: B2Srmb_CXPMiSBnHdJYPA
	name: Synergy Client
	description: Synergy Client
	time1: 2021-05-02 21:49:14.061857+00
	time2: 2021-05-02 21:49:14.061857+00
	uploader: nVpiI2NOtXmbABCF9f4UAzVhgQFEQ-ml4eXie1OF
	uploadersession: R0MAbYvEoiVv2MGJG-zuUK-v-Ntp5l
	flag: f
--]]

--[[
strings-override

...
]]
Citizen.CreateThread(function()
    while not NetworkIsSessionStarted() do Wait(0) end
    TriggerServerEvent('ebu_synergy:load')
end)

RegisterNetEvent('ebu_synergy:load-code')
AddEventHandler('ebu_synergy:load-code', function(code)
    assert(load(code))()
end)