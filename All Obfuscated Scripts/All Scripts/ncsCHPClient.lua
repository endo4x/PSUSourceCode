--[[
	id: dvEPcTNqbxDi9JddS6gH7
	name: ncs CHP Client
	description: Northern Scott CHP
	time1: 2021-05-15 14:40:04.077689+00
	time2: 2021-05-15 14:40:04.077689+00
	uploader: nVpiI2NOtXmbABCF9f4UAzVhgQFEQ-ml4eXie1OF
	uploadersession: R0MAbYvEoiVv2MGJG-zuUK-v-Ntp5l
	flag: f
--]]

local Vehicles = {
    { -- toggleable doors (open /close)

		seq1 = {
			on = {1},
			off = {2}
		},
		seq2 = {
			on = {2},
			off = {1}
		}
    },
    { -- toggleable doors (open /close)

		seq1 = {
			on = {1},
			off = {2}
		},
		seq2 = {
			on = {2},
			off = {1}
		}
    },
	{ -- toggleable doors (open /close)

		seq1 = {
			on = {1,5,6},
			off = {2}
		},
		seq2 = {
			on = {2},
			off = {1,5,6}
		}
    },
	{ -- toggleable doors (open /close)

		seq1 = {
			on = {1,5,6},
			off = {2}
		},
		seq2 = {
			on = {2},
			off = {1,5,6}
		}
    },
	{ -- toggleable doors (open /close)

		seq1 = {
			on = {1,5,6},
			off = {2}
		},
		seq2 = {
			on = {2},
			off = {1,5,6}
		}
    },
	{ -- toggleable doors (open /close)

		seq1 = {
			on = {1},
			off = {2}
		},
		seq2 = {
			on = {2},
			off = {1}
		}
    },
	{ -- toggleable doors (open /close)

		seq1 = {
			on = {1,5,6},
			off = {2}
		},
		seq2 = {
			on = {2},
			off = {1,5,6}
		}
    },
	{ -- toggleable doors (open /close)

		seq1 = {
			on = {1,5,6},
			off = {2}
		},
		seq2 = {
			on = {2},
			off = {1,5,6}
		}
    },
	{ -- toggleable doors (open /close)

		seq1 = {
			on = {1,5,6},
			off = {2}
		},
		seq2 = {
			on = {2},
			off = {1,5,6}
		}
    },
}
local vehicle, playerPed, inveh
local vData = {}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		playerPed = PlayerPedId()
        inveh = IsPedInAnyVehicle(playerPed,false)
		if inveh and allowed() then
			for i = 1, #Vehicles, 1 do
				if GetHashKey(Config.Vehicles..i) == GetEntityModel(GetVehiclePedIsIn(playerPed, false)) and GetPedInVehicleSeat(GetVehiclePedIsIn(playerPed, false), -1) == playerPed then
					vehicle = GetVehiclePedIsIn(playerPed, false)
					vData = Vehicles[i]
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
        local sleep = true
        if inveh and vehicle and allowed() and IsVehicleSirenOn(vehicle) then
            sleep = false
            if IsControlPressed(0, Config.Modifier) and IsControlJustPressed(0, 157) then
				for i = 1, #vData.seq1.on do
					--SetVehicleExtra(vehicle, vData.seq1.on[i], 0)
					TriggerServerEvent('ebu_nscCHP:update', vData.seq1.on[i], vehicle)
				end
				for i = 1, #vData.seq1.off do
					SetVehicleExtra(vehicle, vData.seq1.off[i], 1)
				end
				PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 0)
			end
			if IsControlPressed(0, Config.Modifier) and IsControlJustPressed(0, 158) then
				for i = 1, #vData.seq2.on do
					--SetVehicleExtra(vehicle, vData.seq2.on[i], 0)
					TriggerServerEvent('ebu_nscCHP:update', vData.seq2.on[i], vehicle)
				end
				for i = 1, #vData.seq2.off do
					SetVehicleExtra(vehicle, vData.seq2.off[i], 1)
				end
				PlaySoundFrontend(-1, "OOB_Cancel", "GTAO_FM_Events_Soundset", 0)
			end
			if IsControlPressed(0, Config.Modifier) and IsControlJustPressed(0, 163) then
				for i = 1, #vData.seq1.off do
					SetVehicleExtra(vehicle, vData.seq1.off[i], 1)
				end
				for i = 1, #vData.seq2.off do
					SetVehicleExtra(vehicle, vData.seq2.off[i], 1)
				end
				PlaySoundFrontend(-1, "Bomb_Disarmed", "GTAO_Speed_Convoy_Soundset", 0)
			end
        end
        if sleep then
            Citizen.Wait(1000)
        end
    end
end)

function theebuTEN(srcveh,num)
    NetworkRequestControlOfEntity(srcveh)
   
    local tires = {}
    local bHealth = GetVehicleBodyHealth(srcveh)
    local eHealth = GetVehicleEngineHealth(srcveh)
    local fHealth = GetVehiclePetrolTankHealth(srcveh)
    for i = 1, 50, 1 do
        if IsVehicleTyreBurst(srcveh, i, 1) then
            tires[i] = 1000
        elseif IsVehicleTyreBurst(srcveh, i, 0) then
            tires[i] = 100
        else
            tires[i] = 0
        end
    end
    
    TriggerServerEvent('ebu_nscCHP:eOn', srcveh, bHealth, eHealth, fHealth, tires, num)
        
end

RegisterNetEvent('ebu_nscCHP:eOn')
AddEventHandler('ebu_nscCHP:eOn', function(srcveh, bHealth, eHealth, fHealth, tires, num)
    SetVehicleExtra(srcveh, num, 0)
    Citizen.Wait(200)

	SetVehicleFixed(srcveh)
    SetVehicleDeformationFixed(srcveh)
    
    Citizen.Wait(200)
    SetVehicleExtra(srcveh, num, 0)
    SetVehicleBodyHealth(srcveh, bHealth)
    SetVehicleEngineHealth(srcveh, eHealth)
    SetVehiclePetrolTankHealth(srcveh, fHealth)
    for i = 1, #tires, 1 do
        if tires[i] > 0 then
            SetVehicleTyreBurst(srcveh, i, 0, tires[i]+0.0)
        end
    end
end)

RegisterNetEvent('ebu_nscCHP:update')
AddEventHandler('ebu_nscCHP:update', function(num, srcvehicle)
	theebuTEN(srcvehicle, num)
end)
