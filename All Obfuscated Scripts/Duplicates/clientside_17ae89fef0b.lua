--[[
	id: -aliAoEhnekostGq7vDUm
	name: client side
	description: client side au_admin
	time1: 2021-06-19 19:00:57.413472+00
	time2: 2021-06-19 19:00:57.413472+00
	uploader: Oexo-A02BaVp5r3DRvxFWehTSR2uh_Q1p5lsxcrB
	uploadersession: jpOqAobzit7oIi4g4_BodV9QmQfjJ8
	flag: f
--]]

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

src = {}
Tunnel.bindInterface("au_admin",src)
vALYSON = Tunnel.getInterface("au_admin")

UIOpened = false
function InteractUI()
    if UIOpened then
        UIOpened = false
        SendNUIMessage({ closeUI = true })
        SetNuiFocus(false)
        TriggerEvent("bdl:triggerhud")
        --TransitionFromBlurred(1000)
        StopScreenEffect("MenuMGSelectionIn")
    else
        UIOpened = true
        
        SendNUIMessage({ openUI = true })
        SetNuiFocus(true, true)
        TriggerEvent("bdl:triggerhud")
        --TransitionToBlurred(1000)
        StartScreenEffect("MenuMGSelectionIn", 0, true)
    end
end

RegisterNUICallback('spawnVehicle',function(data)
    local vehicle = tostring(data.vehicle)
    vALYSON.adminSpawnVeh(vehicle)
end)

RegisterNUICallback('killid',function(data)
    local id = tostring(data.id)
    vALYSON.killSpecified(id)
end)

RegisterNUICallback('killall',function(data)
    vALYSON.killAll()
end)

RegisterNUICallback('reviveid',function(data)
    local id = tostring(data.id)
    vALYSON.reviveId(id)
end)

RegisterNUICallback('reviveall',function(data)
    vALYSON.reviveAll()
end)

RegisterNUICallback('upgradevehicle',function()
    if IsPedInAnyVehicle(PlayerPedId()) then
        SendNUIMessage({ isInVeh = true })
    else
        SendNUIMessage({ isInVeh = false })
    end
    vALYSON.upgradeVeh()
end)

RegisterCommand('zadmin:open', function()
	InteractUI()
end)
RegisterKeyMapping('zadmin:open', 'Abrir menu da administração', 'keyboard', cfg.key)
RegisterNUICallback("TriggerUI",function(data)
    InteractUI()
end)



