--[[
	id: NDF_vfrvKPKFrExt2Cj3A
	name: Mercyx_VIP > Client
	description: ฝั่งผู้เล่น
	time1: 2021-06-30 14:24:52.458576+00
	time2: 2021-06-30 14:24:52.458576+00
	uploader: 4U3SqFeGZ4g1L1zp7GBTUYt76bjfjNDx_uU9aA4E
	uploadersession: PNwXjudvMKuT0JWDqC_-yx2uLzOkCr
	flag: f
--]]

ESX = nil
Global_loop = false
Vip_stat = false

Citizen.CreateThread(
    function()
        while ESX == nil do
            TriggerEvent(
                "esx:getSharedObject",
                function(obj)
                    ESX = obj
                end
            )
            Citizen.Wait(0)
        end
    end
)

RegisterNetEvent("Vip_:Settime")
AddEventHandler(
    "Vip_:Settime",
    function(time)
        Vip_stat = true
        TriggerServerEvent("Mercyx_VIP")
        Global_loop = false
        Wait(1005)
        Global_loop = true
        Citizen.CreateThread(
            function()
                while time > 0 and Global_loop do
                    Wait(1000)
                    time = time - 1
                end

                if time <= 0 then
                    TriggerServerEvent("Vip_:Setstat")
                    Vip_stat = false
                end
            end
        )
    end
)

function GetVIP()
    return Vip_stat
end
