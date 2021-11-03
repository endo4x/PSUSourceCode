--[[
	id: GFKYIe93h_1bQVasrvWHa
	name: Wager Client
	description: Wager
	time1: 2021-07-08 12:13:54.971069+00
	time2: 2021-07-08 12:13:54.971069+00
	uploader: upmaKftPebf1aacTSUlrUVzIhYdYC6Nowa8t9ti2
	uploadersession: res167k3kt5XoYHIb4FdWDI5eEUNQn
	flag: f
--]]


        Boelah = {}

        Wagers = {}
        
        CurrentLeader = nil
        PlayerPed = GetPlayerPed(-1)
         Citizen.CreateThread(function()
             while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
                 Citizen.Wait(0)
             end
             while ESX.GetPlayerData() == nil do
                 Citizen.Wait(10)
             end
            PlayerData = ESX.GetPlayerData()
            Citizen.Wait(10)
         
             ESX.TriggerServerCallback("boelah-boemba:client:GetConfig", function(result)
                 Boelah = result
             end)
        
             while Boelah.Blips == nil do Wait(500) end
             for k,v in pairs(Boelah.Blips) do
                for i,j in pairs(v.Zones) do
        
                 local blip = AddBlipForCoord(j.x, j.y, j.z)
         
                 SetBlipSprite(blip, 303)
                 SetBlipColour(blip, 1)
                 SetBlipScale(blip, 0.3)
                 SetBlipAsShortRange(blip, true)
                 BeginTextCommandSetBlipName("STRING")
                 AddTextComponentString("Wagers")
                 EndTextCommandSetBlipName(blip)
             end
            end
         end)


        RegisterNetEvent("boelah-boemba:client:ResyncWagers")
        AddEventHandler("boelah-boemba:client:ResyncWagers", function(table)
         Wagers = table
        end)
        
         RegisterNetEvent("boelah-boemba:client:startwager")
         AddEventHandler("boelah-boemba:client:startwager", function(number)
             SetEntityCoords(PlayerPed, vector3(Boelah.Locations[current].SpawnLocations[number].x,Boelah.Locations[current].SpawnLocations[number].y, Boelah.Locations[current].SpawnLocations[number].z))
             AddArmourToPed(PlayerPed, 100)
             TriggerServerEvent("esx_ambulancejob:heal")
             cancel = false
         
             Citizen.CreateThread(function()
                 while true do 
                     Wait(0)
                     local coords = GetEntityCoords(ped)
                     if cancel then 
                         return 
                     end
                     if IsPedDeadOrDying(PlayerPed, true) then 
        
                         SetEntityCoords(PlayerPed, vector3(221.17027282715, -908.96734619141, 30.692157745361))
                         TriggerServerEvent("boelah-boemba:server:winnerchickendinner",current)
                         TriggerEvent('esx_ambulancejob:revive')
                         HasEntered = false
                         return
                     else
                         Wait(500)
                     end
                 end
             end)
         end)
        
         Citizen.CreateThread(function()
             while true do 
                 Wait(0)
                 PlayerPed = GetPlayerPed(-1)
                 local coords = GetEntityCoords(PlayerPed)
                 while Boelah.Locations == nil do Wait(500) end
                 for k,v in pairs(Boelah.Locations) do
                     local dist = GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true)
                     if dist < 10 then 
                         DrawMarker(20,v.x, v.y, v.z - 0.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.3, 0.2, Boelah.MarkerColor.r, Boelah.MarkerColor.G, Boelah.MarkerColor.B, 100, false, true, 2, true, nil, nil, false)
                         if dist < 2 then 
                             current = k
                             if Wagers[current] == nil then 
                                if not HasEntered then
                                    DrawScriptText(vector3(v.x, v.y, v.z), Boelah.Text.StartWager)
                                    if IsControlJustReleased(0, 38) then 
                                        StartWager()
                                    end
                                end
                             elseif Wagers[current].connected < Wagers[current].maxconnected then
                                local hoppa = GetPlayerServerId()
                                 DrawScriptText(vector3(v.x, v.y, v.z), Boelah.Text.WaitPlayer .. Wagers[current].inzet)
                                 local coordsdsadd = v.x 
                                 local coordsdsadc = v.y
                                 local coordsdsadb = v.z

                                 for k,v in pairs(Wagers[current].Members) do
                                        if v.id == hoppa then
                                            DrawScriptText(vector3(coordsdsadd, coordsdsadc, coordsdsadb - 0.14), Boelah.Text.LeaveWager)
                                            if IsControlJustReleased(0, 113) then 
                                                TriggerServerEvent('boelah-boemba:server:leavewager', current)
                                                Citizen.Wait(50)
                                                HasEntered = false
                                                TriggerEvent('esx_ambulancejob:revive')
                                            end
                                        end
                                end
                                if not HasEntered then
                                    if IsControlJustReleased(0, 38) then 
                                     JoinWager()
                                 end
                                end
                             else
                                 DrawScriptText(vector3(v.x, v.y, v.z), Boelah.Text.WagerAlready)
                             end
                         end
                     end
                 end
             end
         end)

         Citizen.CreateThread(function()
            while true do 
                Wait(0)
                if HasEntered then
                    local coords = GetEntityCoords(PlayerPed)
                    while Boelah.LeaveLocations == nil do Wait(500) end
                    for k,v in pairs(Boelah.LeaveLocations) do
                        local dist = GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true)
                        if dist < 5 then 
                            DrawMarker(20,v.x, v.y, v.z - 0.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.3, 0.2, Boelah.MarkerColor.r, Boelah.MarkerColor.G, Boelah.MarkerColor.B, 100, false, true, 2, true, nil, nil, false)
                            if dist < 1 then 
                                DrawScriptText(vector3(v.x, v.y, v.z), Boelah.Text.LeaveWager)
                                if IsControlJustReleased(0, 113) then 
                                    TriggerServerEvent('boelah-boemba:server:winnerchickendinner', current)
                                    SetEntityCoords(PlayerPed, vector3(221.17027282715, -908.96734619141, 30.692157745361))
                                    TriggerEvent('esx_ambulancejob:revive')
                                    HasEntered = false
                                end
                            end
                        end
                    end
                end
            end
        end)
        
         RegisterNetEvent("boelah-boemba:client:win")
         AddEventHandler("boelah-boemba:client:win", function()
             SetEntityCoords(PlayerPed, vector3(Boelah.Locations[current].x, Boelah.Locations[current].y, Boelah.Locations[current].z))
             AddArmourToPed(PlayerPed, 0)
             cancel = true
             HasEntered = false
         end)
         
         StartWager = function()
                exports['br-menu']:SetTitle("Wagers")
                exports['br-menu']:AddButton(Boelah.Text.PriceOneText, Boelah.Text.PriceOneDescription, 'boelah-boemba:client:NieuwWagerInzetten1', current)
                exports['br-menu']:AddButton(Boelah.Text.PriceTwoText, Boelah.Text.PriceTwoDescription, 'boelah-boemba:client:NieuwWagerInzetten2', current)
                exports['br-menu']:AddButton(Boelah.Text.PriceThreeText, Boelah.Text.PriceThreeDescription, 'boelah-boemba:client:NieuwWagerInzetten3', current)
                exports['br-menu']:AddButton(Boelah.Text.PriceFourText, Boelah.Text.PriceFourDescription,'boelah-boemba:client:NieuwWagerInzetten4', current)
                exports['br-menu']:AddButton(Boelah.Text.PriceFiveText, Boelah.Text.PriceFiveDescription,'boelah-boemba:client:NieuwWagerInzetten5', current)
         end
        
         RegisterNetEvent('boelah-boemba:client:NieuwWagerInzetten1')
         AddEventHandler("boelah-boemba:client:NieuwWagerInzetten1", function(variable)
            ESX.TriggerServerCallback("boelah-boemba:server:GetMoney", function(HasEnough)
                if HasEnough then 
                    if not HasEntered then
                        HasEntered = true
                        TriggerServerEvent("boelah-boemba:server:newwager", Boelah.PriceOne, variable)
                    else
                        exports["mythic_notify"]:SendAlert("error", Boelah.Text.onlyonewager)
                    end
                else
                    exports["mythic_notify"]:SendAlert("error", Boelah.Text.notenoughmoney)
                end
            end, Boelah.PriceOne)
         end)
        
         RegisterNetEvent('boelah-boemba:client:NieuwWagerInzetten2')
         AddEventHandler("boelah-boemba:client:NieuwWagerInzetten2", function(variable)
            ESX.TriggerServerCallback("boelah-boemba:server:GetMoney", function(HasEnough)
                if HasEnough then 
                    if not HasEntered then
                        HasEntered = true
                        TriggerServerEvent("boelah-boemba:server:newwager", Boelah.PriceTwo, variable)
                    else
                        exports["mythic_notify"]:SendAlert("error", Boelah.Text.onlyonewager)
                    end
                else
                    exports["mythic_notify"]:SendAlert("error", Boelah.Text.notenoughmoney)
                end
            end, Boelah.PriceTwo)
         end)
        
         RegisterNetEvent('boelah-boemba:client:NieuwWagerInzetten3')
         AddEventHandler("boelah-boemba:client:NieuwWagerInzetten3", function(variable)
            ESX.TriggerServerCallback("boelah-boemba:server:GetMoney", function(HasEnough)
                if HasEnough then 
                    if not HasEntered then
                        HasEntered = true
                        TriggerServerEvent("boelah-boemba:server:newwager", Boelah.PriceThree, variable)
                    else
                        exports["mythic_notify"]:SendAlert("error", Boelah.Text.onlyonewager)
                    end
                else
                    exports["mythic_notify"]:SendAlert("error", Boelah.Text.notenoughmoney)
                end
            end, Boelah.PriceThree)
         end)
        
         RegisterNetEvent('boelah-boemba:client:NieuwWagerInzetten4')
         AddEventHandler("boelah-boemba:client:NieuwWagerInzetten4", function(variable)
            ESX.TriggerServerCallback("boelah-boemba:server:GetMoney", function(HasEnough)
                if HasEnough then 
                    if not HasEntered then
                        HasEntered = true
                        TriggerServerEvent("boelah-boemba:server:newwager", Boelah.PriceFour, variable)
                    else
                        exports["mythic_notify"]:SendAlert("error", Boelah.Text.onlyonewager)
                    end
                else
                    exports["mythic_notify"]:SendAlert("error", Boelah.Text.notenoughmoney)
                end
            end, Boelah.PriceFour)
         end)
        
         RegisterNetEvent('boelah-boemba:client:NieuwWagerInzetten5')
         AddEventHandler("boelah-boemba:client:NieuwWagerInzetten5", function(variable)
            ESX.TriggerServerCallback("boelah-boemba:server:GetMoney", function(HasEnough)
                if HasEnough then 
                    if not HasEntered then
                        HasEntered = true
                        TriggerServerEvent("boelah-boemba:server:newwager", Boelah.PriceFive, variable)
                    else
                        exports["mythic_notify"]:SendAlert("error", Boelah.Text.onlyonewager)
                    end
                else
                    exports["mythic_notify"]:SendAlert("error", Boelah.Text.notenoughmoney)
                end
            end, Boelah.PriceFive)
         end)
        
         JoinWager = function()
             TriggerServerEvent("boelah-boemba:server:newwager", 0, current)
         end
        
         dialog = function(cb)
             ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'price', {
                 title = 'Inzet'
             }, function(data2, menu)
        
                 local price = tonumber(data2.value)
                 if price == nil then
                    menu.close()
                 elseif tonumber(price) > 100000 or tonumber(price) < 25000 then 
                     menu.close()
                 else
                     menu.close()
                     cb(price)
                 end
             end, function(data2,menu)
                 menu.close()
             end)
         end
        
        
         menu = function(cb)
             ESX.UI.Menu.CloseAll()
             ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'warehouse_laptop', {
                 title = "Wagers",
                 align = "top-left",
                 elements = {
                     {label = "50K inzetten", value = 50000},
                     {label = "100K inzetten", value = 100000},
                     {label = "150K inzetten", value = 150000},
                     {label = "200K inzetten", value = 200000},
                     {label = "250K inzetten", value = 250000},
             }}, function(data, menu)
                     local action = data.current.value
                     cb(tonumber(data.current.value))
                     ESX.UI.Menu.CloseAll()
             end, function(data, menu)
             end)
         end
        
         RegisterNetEvent("boelah-boemba:client:CloseMenu")
         AddEventHandler("boelah-boemba:client:CloseMenu", function()
             if ESX.UI.Menu.IsOpen("dialog", GetCurrentResourceName(), "price") then 
                 ESX.UI.Menu.Close("dialog", GetCurrentResourceName(), "price")
             end
         end)
        
        
         function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
             local px,py,pz=table.unpack(GetGameplayCamCoords())
             local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
             local scale = (1/dist)*20
             local fov = (1/GetGameplayCamFov())*100
             local scale = scale*fov   
             SetTextScale(scaleX*scale, scaleY*scale)
             SetTextFont(fontId)
             SetTextProportional(1)
             SetTextColour(250, 250, 250, 255)
             SetTextDropshadow(1, 1, 1, 1, 255)
             SetTextEdge(2, 0, 0, 0, 150)
             SetTextDropShadow()
             SetTextOutline()
             SetTextEntry("STRING")
             SetTextCentre(1)
             AddTextComponentString(textInput)
             SetDrawOrigin(x,y,z+2, 0)
             DrawText(0.0, 0.0)
             ClearDrawOrigin()
         end
        
         function DrawScriptText(coords, text)
             local onScreen, _x, _y = World3dToScreen2d(coords["x"], coords["y"], coords["z"])
         
             SetTextScale(0.35, 0.35)
             SetTextFont(4)
             SetTextProportional(1)
             SetTextColour(255, 255, 255, 215)
             SetTextEntry("STRING")
             SetTextCentre(1)
             AddTextComponentString(text)
             DrawText(_x, _y)
         
             local factor = string.len(text) / 370
         
             DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 65)
         end
