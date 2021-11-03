--[[
	id: efWEgZRXe1XK_7tdbng2r
	name: hehe
	description: hehe
	time1: 2021-04-29 16:41:07.238861+00
	time2: 2021-04-29 16:41:07.238862+00
	uploader: cUSsZLot33kARn6f2nY8EDrhyaWgm0w6i2jmhR4b
	uploadersession: q1I-P3IbHwkNqU52GJ-sc-gcEfUEk7
	flag: f
--]]

local cooldownattivo = false

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(5)
            if IsControlJustPressed(0, 73) then
                if IsPedInAnyVehicle(GetPlayerPed(-1), true) then
                    if not cooldownattivo then
                        if not IsVehicleStopped(GetVehiclePedIsIn(GetPlayerPed(-1), false)) then
                            cooldownattivo = true
                            SetVehicleBoostActive(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1, 0)
                            SetVehicleForwardSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false), 100.0)
                            StartScreenEffect("RaceTurbo", 0, 0)
                            Citizen.Wait(3000)
                            SetVehicleBoostActive(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0, 0)
                            Citizen.Wait(27000)
                            cooldownattivo = false
                        else
                            TriggerEvent(
                                "esx:showNotification",
                                "Il veicolo deve essere in movimento per poter attivare il nitro!"
                            )
                        end
                    else
                        TriggerEvent(
                            "esx:showNotification",
                            "Devi attendere 30 secondi prima di poter attivare nuovamente il nitro!"
                        )
                    end
                end
            end
        end
    end
)
