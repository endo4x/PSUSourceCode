--[[
	id: fO36ZJp_aQBEFQbaOoU6P
	name: wdd
	description: dd
	time1: 2021-07-15 01:05:52.050869+00
	time2: 2021-07-15 01:05:52.05087+00
	uploader: 8SeGeTgZ6HJnKhHUvmwvuoFu0a0R-FGuk5X_NBFY
	uploadersession: giKJUSLt_SJ9nJV2EGnWI_n1ZHsfwr
	flag: f
--]]

Citizen.CreateThread(function()
    RequestModel(GetHashKey("ig_bankman"))
	
    while not HasModelLoaded(GetHashKey("ig_bankman")) do
        Wait(1)
    end
	
	for _, item in pairs(Config.ped) do
		local npc = CreatePed(4, 0x909D9E7F, item.x, item.y, item.z, item.heading, false, true)
			
		SetEntityHeading(npc, item.heading)
		FreezeEntityPosition(npc, true)
		SetEntityInvincible(npc, true)
		SetBlockingOfNonTemporaryEvents(npc, true)	
	end
end)



