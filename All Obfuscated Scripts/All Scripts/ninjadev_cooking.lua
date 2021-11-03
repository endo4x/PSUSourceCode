--[[
	id: xcZw7WtYCzynls6zZvEM_
	name: ninjadev_cooking
	description: cucina jappo
	time1: 2021-04-24 17:21:36.64246+00
	time2: 2021-04-24 17:21:36.642461+00
	uploader: FJIC7pcrNJaVRLxDGePzVkqOPXWh0QE9QApmYc4O
	uploadersession: _XxKdolx_RpReM5YGAWabY2RP6i8xC
	flag: f
--]]

ESX = nil

local inmenu = false

Citizen.CreateThread(function()
    while ESX == nil do 
        TriggerEvent("esx:getSharedObject",function(obj)
            ESX = obj 
        end)
        Citizen.Wait(0)
    end
    
    SetNuiFocus(false, false)
end)

OpenCookbook = function()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "openCookbook",
        pages = Config.Recipes
    })
end;

RegisterNetEvent("ninjadev_cooking:openCookbook")
AddEventHandler("ninjadev_cooking:openCookbook", function()
    inMenu = true
    OpenCookbook()
end)

OpenMenu = function(heading)
    local plyPed = PlayerPedId()
    local elements = {}

    for k, v in ipairs(Config.Recipes) do 
        table.insert(elements,{
            ["label"] = v["recipe"],
            ["value"] = v
        })
    end

    inmenu = true

    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "ninjadev_cooking_menu",
    {
        ["title"] = _U("menu_label"),
        ["align"] = Config.MenuAlign,
        ["elements"] = elements
    },function(data, menu)
        if data.current.value then 
            ESX.TriggerServerCallback("ninjadev_cooking:doesPlayerHaveIngredients",function(hasingredients)
                if hasingredients then 
                    menu.close()

                    SetEntityHeading(plyPed,heading)
                    FreezeEntityPosition(plyPed,true)
                    TaskStartScenarioInPlace(plyPed,"PROP_HUMAN_BBQ",0,false)

                    Citizen.Wait(15000)

                    TriggerServerEvent("ninjadev_cooking:giveReward", data.current.value.item)

                    local prop = GetClosestObjectOfType("prop_fish_slice_01", GetEntityCoords(PlayerPedId()))
                    if DoesEntityExist(prop) then 
                        DeleteEntity(prop)
                    end;

                    ClearPedTasks(plyPed)
                    FreezeEntityPosition(plyPed, false)
                    inmenu = false
                else 
                    ESX.ShowNotification(_U("check_cookbook"))
                end 
            end,data.current.value)
        end 
    end, function(d, menu2)
        menu2.close()
        inmenu = false
    end)
end

if Config.EnableCommand then 
    RegisterCommand(Config.Command,function()
        inMenu=OpenCookbook()
    end)
end

RegisterNUICallback("close",function()
    SetNuiFocus(false)
end)
    
AddEventHandler("onResourceStop",function(resource)
    if resource == GetCurrentResourceName() then 
        if inMenu then 
            inMenu = false
            SetNuiFocus(false,false)
            SendNUIMessage({
                type="closeAll"
            })
        end 
    end 
end)

Citizen.CreateThread(function()
    while true do 
        local sleep = 1000
        if ESX and not inmenu then 
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            for k, v in pairs(Config.Locations) do 
                if GetDistanceBetweenCoords(coords, v["coords"], true) < 1.5 then 
                    sleep = 5
                    ESX.Game.Utils.DrawText3D(v["coords"], _U("marker_text"), Config.TextSize)
                    if IsControlJustReleased(0,38) then 
                        OpenMenu(v["heading"])
                    end 
                end 
            end 
        end
        Citizen.Wait(sleep)
    end 
end)