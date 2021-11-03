--[[
	id: DHvSCoc1CWjObIZGv5BZd
	name: esx_crafting
	description: crafting 2
	time1: 2021-04-24 18:03:19.225735+00
	time2: 2021-04-24 18:03:19.225736+00
	uploader: FJIC7pcrNJaVRLxDGePzVkqOPXWh0QE9QApmYc4O
	uploadersession: _XxKdolx_RpReM5YGAWabY2RP6i8xC
	flag: f
--]]

local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}
ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(7)
    end
end)
local CurrentCraft = nil
-- Location Loop
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(7)
        if ESX ~= nil and Crafting.Locations ~= nil then
            local pos = GetEntityCoords(GetPlayerPed(-1), true)
            for i=1, #Crafting.Locations, 1 do
                if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Crafting.Locations[i].x, Crafting.Locations[i].y, Crafting.Locations[i].z, true) < 2.5 then
                    DrawText3D(Crafting.Locations[i].x, Crafting.Locations[i].y, Crafting.Locations[i].z, "[~g~E~w~] to craft item")
                    if IsControlJustReleased(0, Keys["E"]) then
                        OpenCraftMenu()
                    end
                end
            end
        end
    end
end)

-- NUI that get triggered on success
RegisterNUICallback('CraftingSuccess', function()
    SetNuiFocus(false, false)
    ClearPedTasks(GetPlayerPed(-1))
    FreezeEntityPosition(GetPlayerPed(-1),false)
    TriggerServerEvent("rs_crafting:CraftingSuccess", CurrentCraft)
end)

-- NUI that get triggered on fail
RegisterNUICallback('CraftingFailed', function()
    SetNuiFocus(false, false)
    ClearPedTasks(GetPlayerPed(-1))
    FreezeEntityPosition(GetPlayerPed(-1),false)
    TriggerServerEvent("rs_crafting:CraftingFailed", CurrentCraft)
end)

function OpenCraftMenu()
    local elements = {}
    ESX.TriggerServerCallback('rs_crafting:GetSkillLevel', function(level)
        for item, v in pairs(Crafting.Items) do
            if tonumber(level) >= v.threshold then
                local elementlabel = v.label .. ": "
                local somecount = 1
                for k, need in pairs(v.needs) do
                    if somecount == 1 then
                        somecount = somecount + 1
                        elementlabel = elementlabel .. need.label .. " ("..need.count..")"
                    else
                        elementlabel = elementlabel .. " - "..need.label .. " ("..need.count..")"
                    end
                end
                table.insert(elements, {value = item, label = elementlabel})
            end
        end
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'crafting_actions', {
            title    = "Craften",
            elements = elements,
            align    = 'top-left',
        }, function(data, menu)
            menu.close()
            CurrentCraft = data.current.value
            ESX.TriggerServerCallback('rs_crafting:HasTheItems', function(result)
                if result then
                    SetNuiFocus(true,true)
                    SendNUIMessage({
                        action = "opengame",
                    })
                    RequestAnimDict("mini@repair")
                    while (not HasAnimDictLoaded("mini@repair")) do
                        Citizen.Wait(0)
                    end
                    TaskPlayAnim(GetPlayerPed(-1), "mini@repair" ,"fixing_a_ped" ,8.0, -8.0, -1, 1, 0, false, false, false )
                    FreezeEntityPosition(GetPlayerPed(-1),true)
                else
                    ESX.ShowNotification("~r~Je hebt niet genoeg materieel")
                end
            end, CurrentCraft)

        end, function(data, menu)
            menu.close()
        end)
    end)
end

DrawText3D = function(x, y, z, text)
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(true)
	AddTextComponentString(text)
	--DrawText(_x,_y)
	SetDrawOrigin(x,y,z, 0)
	DrawText(0.0, 0.0)
	local factor = (string.len(text)) / 370
	--DrawRect(_x,_y+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 68)
	DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 68)
	ClearDrawOrigin()
end