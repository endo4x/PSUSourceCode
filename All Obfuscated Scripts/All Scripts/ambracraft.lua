--[[
	id: GSH-xZVEM1rHcYeE1FwR1
	name: ambra-craft
	description: crafting 3
	time1: 2021-04-24 18:06:28.753062+00
	time2: 2021-04-24 18:06:28.753062+00
	uploader: FJIC7pcrNJaVRLxDGePzVkqOPXWh0QE9QApmYc4O
	uploadersession: _XxKdolx_RpReM5YGAWabY2RP6i8xC
	flag: f
--]]

local ESX = nil
local PlayerData                = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true })
		--[[ TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_PARKING_METER", 0, false) ]]	
	else
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		--[[ ClearPedTasksImmediately(GetPlayerPed(PlayerId())) ]]
	end
end


RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "craft-ak47" then
		TriggerServerEvent("ambra_craft:assaultrifle")
	elseif data == "craft-carbinerifle" then
		TriggerServerEvent("ambra_craft:carbinerifle")
	elseif data == "craft-molotov" then
		TriggerServerEvent("ambra_craft:molotov")
	elseif data == "craft-knife" then
		TriggerServerEvent("ambra_craft:knife")
	elseif data == "craft-heavypistol" then
		TriggerServerEvent("ambra_craft:heavypistol")
	elseif data == "craft-pistolammo" then
		TriggerServerEvent("ambra_craft:pistolammo")
	elseif data == "craft-rifleammo" then
		TriggerServerEvent("ambra_craft:rifleammo")
	elseif data == "fechar" then
		ToggleActionMenu()
		onmenu = false
	end
end)


RegisterNetEvent("bancada-armas:posicao")
AddEventHandler("bancada-armas:posicao", function()
	local ped = PlayerPedId()
	SetEntityHeading(ped,270.89)
	SetEntityCoords(ped,1405.96,1137.86,109.75-1,false,false,false,false)
end)

RegisterNetEvent("fechar-nui")
AddEventHandler("fechar-nui", function()
	ToggleActionMenu()
	onmenu = false
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        player = GetPlayerPed(-1)
		coords = GetEntityCoords(player)
		
		for k, v in pairs(Config.Crafts) do
			if GetDistanceBetweenCoords(coords, Config.Crafts[k].x, Config.Crafts[k].y, Config.Crafts[k].z, true) < 2.0 then
			ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ open craft table')
				if IsControlJustPressed(0, Config.OpenMenu) then
				   ToggleActionMenu()
						
				end
            end
        end
    end
end)

Citizen.CreateThread( function()
	for k, v in pairs(Config.Crafts) do
		   local hash = GetHashKey(Config.BenchModel)
		   RequestModel(hash)

		   while not HasModelLoaded(hash) do 
		   RequestModel(hash)
		   Citizen.Wait(0)
		   end  

		   
		   local Bench = CreateObject(hash, Config.Crafts[k].x, Config.Crafts[k].y, Config.Crafts[k].z, false,false,false)
		   
	end
end)

Citizen.CreateThread(function()
    player = GetPlayerPed(-1)
    coords = GetEntityCoords(player)
    for k, v in pairs(Config.Crafts) do
        CreateBlip(vector3(Config.Crafts[k].x, Config.Crafts[k].y, Config.Crafts[k].z ), "Craft table", 3.0, Config.Color, Config.ShopBlipID)
    end

end)

function CreateBlip(coords, text, radius, color, sprite)
	local blip = AddBlipForCoord(coords)
	SetBlipSprite(blip, sprite)
	SetBlipColour(blip, color)
	SetBlipScale(blip, 0.8)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(text)
	EndTextCommandSetBlipName(blip)
end

RegisterNetEvent('ambracraft:startanim')
AddEventHandler('ambracraft:startanim', function(source)
	exports['mythic_progbar']:Progress({
		name = "retrieving_card",
		duration = 10000,
		label = 'Crafting',
		useWhileDead = false,
		canCancel = false,
		controlDisables = {
		  disableMovement = true,
		  disableCarMovement = true,
		  disableMouse = false,
		  disableCombat = true,
		},
	  }, function(cancelled)
		if not cancelled then
		  ClearPedTasksImmediately(GetPlayerPed(PlayerId()))
		else
		  -- Do Something If Action Was Cancelled
		end
	end)
	TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_PARKING_METER", 0, false)
end)
