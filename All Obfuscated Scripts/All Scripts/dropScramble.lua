--[[
	id: GGW8cHpzl7QcMFZRq0OcU
	name: dropScramble
	description: dropScramble
	time1: 2021-05-22 14:31:02.008138+00
	time2: 2021-05-22 14:31:02.008138+00
	uploader: tE03msrxXX5paZRQo5c4IO4syh6a7V4UNjXBwOK4
	uploadersession: baCmIei3V4cWvBQJXideznIscmBGJ_
	flag: f
--]]

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('KKBGaYWAm', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local droplar = {}
local cooldown = false

RegisterNetEvent("sgqPlkSMj")
AddEventHandler("sgqPlkSMj", function(id, item, playerCoord)
	local itemler = item
	if droplar[id] == nil then
		table.insert(droplar, { coords = playerCoord, items = itemler, timer = 600000, taken}) -- determines the time it will stay on the ground (timer)
	end
end)

local DupeDelayDrop = false

Citizen.CreateThread(function()
	while true do
		local sleep = 1000
		local playerPed = PlayerPedId()
		local playerCoord = GetEntityCoords(playerPed)
		if #droplar > 0 then
			for i = 1, #droplar do
				if droplar[i] ~= nilc then
					local dst = #(playerCoord - droplar[i].coords)
					if dst < 50 then
						sleep = 1
						DrawMarker(2,  droplar[i].coords, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.2, 128, 0, 0, 100, false, true, 2, false, false, false, false)
						if dst < 10 then
							DrawText3D(droplar[i].coords.x, droplar[i].coords.y, droplar[i].coords.z + 0.20, 0.30, "~g~[G]~w~ Esyaları Topla ~w~")
							if dst < 2 then
								if IsControlJustPressed(0, 183) and not cooldown then
									dropid = i
									items = droplar[i].items
									if not DupeDelayDrop then
										DupeDelayDrop = true
										droplar[i].taken = true
										ESX.TriggerServerCallback('GPyEqAYCX', function(ping)
											if ping ~= nil then
												cooldown = true
												TriggerEvent('OHvHQJEiO',dropid, items)
											else
												ESX.ShowNotification('Denediğin şeyi yapamazsın.')
												Citizen.Wait(150)
												DupeDelayDrop = false
												droplar[i].taken = false
											end
										end)
									else
										ESX.ShowNotification("Bu şekilde ~r~Spam ~w~Yapamazsın!")
										Citizen.Wait(150)
										DupeDelayDrop = false
										droplar[i].taken = false
									end
								end
							end
						end
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)

RegisterNetEvent("OHvHQJEiO")
AddEventHandler("OHvHQJEiO", function(i, items)
	local playerPed = PlayerPedId()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 4 then   
        ESX.ShowNotification("Yakında Birileri Var!")
		droplar[i].taken = false
		cooldown = false
		Citizen.Wait(150)
		DupeDelayDrop = false
	elseif IsPedInAnyVehicle(playerPed, false) then
		ESX.ShowNotification("Araçtayken eşya toplayamazsın!")
		droplar[i].taken = false
		cooldown = false
		Citizen.Wait(150)
		DupeDelayDrop = false
	elseif IsEntityDead(playerPed) then
		ESX.ShowNotification("Ölüyken eşya toplayamazsın!")
		droplar[i].taken = false
		cooldown = false
		Citizen.Wait(150)
		DupeDelayDrop = false
	elseif IsPedSprinting(playerPed) or IsPedJumping(playerPed) or IsPedWalking(playerPed) or IsPedClimbing(playerPed) or IsPedOnVehicle(playerPed) or not IsPedOnFoot(playerPed) then
		ESX.ShowNotification("Hareket halindeyken eşya toplayamazsın!")
		droplar[i].taken = false
		cooldown = false
		Citizen.Wait(150)
		DupeDelayDrop = false
	else
		if droplar[i] then
			TriggerServerEvent("fOEXUMXwn", i, items)
		else
			ESX.ShowNotification('Bu drop alınmış.')
			Citizen.Wait(150)
			DupeDelayDrop = false
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		if #droplar > 0 then
			for i = 1, #droplar do
				if droplar[i] then
					droplar[i].timer = droplar[i].timer - 10000
					if droplar[i].timer <= 0 then
						TriggerServerEvent("dfTARvngm", i)
					end
				end
			end
		end
		Citizen.Wait(10000)
	end
end)

RegisterNetEvent("PrgAInIHm")
AddEventHandler("PrgAInIHm", function(id,items)
	if droplar[id] then
		table.remove(droplar, id)
	end
end)

RegisterNetEvent("vSclPtrNW")
AddEventHandler("vSclPtrNW", function(id)
	if droplar[id] then
		table.remove(droplar, id)
	end
end)

RegisterNetEvent("YDZkCMOFx")
AddEventHandler("YDZkCMOFx", function(items)
	TriggerServerEvent('ADqeQQYLK',items)
	Citizen.Wait(150)
	cooldown = false
	DupeDelayDrop = false
end)

function DrawText3D(x, y, z, scale, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextDropshadow(0)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
        local factor = (string.len(text)) / 490
        DrawRect(_x, _y + 0.0120, 0.0 + factor, 0.025, 41, 11, 41, 100)
    end
end
