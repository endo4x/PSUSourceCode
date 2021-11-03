--[[
	id: tN3ibDmlHdo6iRqQMu4mK
	name: ArtGallery
	description: by peter light
	time1: 2021-05-03 19:01:28.970773+00
	time2: 2021-05-03 19:01:28.970774+00
	uploader: hjUpFtDLN3QU7fmgHl1akB62vmzv5vuxNoYxovYG
	uploadersession: 8BNCl5BZgzO0vcVA2kC6uZozDH1K_4
	flag: f
--]]

ESX              = nil
QBCore = nil
-- print("TESTING")
CT(function() while QBCore == nil do TE("QBCore:GetObject", function(obj) QBCore = obj end) Citizen.Wait(0) end end)

RNE('QBCore:Client:OnPlayerLoaded', function(xPlayer) Opod.data.PlayerData = xPlayer end)
RNE('QBCore:Client:OnJobUpdate', function(job) Opod.data.PlayerData.job = job end)

CT(function()
    while QBCore == nil do Citizen.Wait(0) end
    -- while #Opod.data == 0 do Citizen.Wait(0) end
    FreezeEntityPosition(PlayerPedId(), false)
    Opod.data.IsRapealing   = false
    Opod.data.InteriorId    = GetInteriorAtCoords(27.478, 143.0223, 97.945)
    Opod.data.IsBusy        = false
    Opod.data.IsRobber      = false
    Opod.data.canRapeal     = true
    Opod.data.PlayerData    = QBCore.Functions.GetPlayerData()

     QBCore.Functions.TriggerCallback('opod-artHeist:CheckEntityStatus', function(data)
        for k, v in ipairs(data.PaintingCache) do
            TE('opod-artHeist:RegisterPainting', k, v.isStolen)
        end
        DeactivateInteriorEntitySet(Opod.data.InteriorId, "slidedoors_unlocked")
        Opod.data.BankVault = data.BankVault
        TE('opod-artHeist:SetVaultDoor', data.BankVault.isLocked, true)
        TE('opod-artHeist:SetWindowCut', data.WindowCut)
        TE('opod-artHeist:SetDisplayCut', data.EggDisplayCut)
        TE('opod-artHeist:RegisterDoors', data.DoorStatus)
        TE('opod-artHeist:HackSecurity', data.SystemsHacked)
        if data.GalleryClosed then
            TE('opod-artHeist:SetGalleryClosed', true)
        end
        if data.WinchSpawned then
            TE('opod-artHeist:SetWinchSync', true)
        end
        if Config.GallerySettings.UseTimes then
            if (NetworkGetGlobalMultiplayerClock() >= Config.GallerySettings['ClosingTime'] or NetworkGetGlobalMultiplayerClock() < Config.GallerySettings['OpeningTime']) then
                if not data.GalleryClosed then
                    TSE('opod-artHeist:SetGalleryClosed', true)
                else
                    TE('opod-artHeist:SetGalleryClosed', true)
                end
            else
                if data.GalleryClosed then
                    Opod.data.GalleryClosed = false
                    TSE('opod-artHeist:SetGalleryClosed', false)
                else
                    Opod.data.GalleryClosed = false
                    TE('opod-artHeist:SetGalleryClosed', false)
                end
            end
        else
            -- print("NOT USING")
            -- print(data.GalleryClosed)
            if not data.GalleryClosed then
                TSE('opod-artHeist:SetGalleryClosed', true)
            else
                TE('opod-artHeist:SetGalleryClosed', true)
            end
        end
            CT(function()
                Opod.data.VaultDoor = GetClosestObjectOfType(Opod.data.BankVault.pos, 2.0, Opod.data.BankVault.hash, false, false, false)
                while not DoesEntityExist(Opod.data.VaultDoor) and #((Opod.data.PlayerPosition or GetEntityCoords(PlayerPedId())) - vector3(27.478, 143.0223, 97.945)) <= 50.0 do
                    Citizen.Wait(5)
                    Opod.data.VaultDoor = GetClosestObjectOfType(Opod.data.BankVault.pos, 2.0, Opod.data.BankVault.hash, false, false, false)
                end
            end)
        RefreshInterior(Opod.data.InteriorId)
    end)

    Opod.data.MueseumBlip = AddBlipForCoord(Config.WindowEntrance)
    SetBlipSprite(Opod.data.MueseumBlip, 269)
    SetBlipDisplay(Opod.data.MueseumBlip, 4)
    SetBlipScale(Opod.data.MueseumBlip, 1.0)
    SetBlipColour(Opod.data.MueseumBlip, 11)
    SetBlipAsShortRange(Opod.data.MueseumBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(_U('blip_name'))
    EndTextCommandSetBlipName(Opod.data.MueseumBlip)

    if Config.BlackmarketSettings.useBlip then
        for _, v in ipairs(Config.SellLocations) do
            v.blip = AddBlipForCoord(v.callMarker)
            SetBlipSprite(v.blip, 465)
            SetBlipDisplay(v.blip, 4)
            SetBlipScale(v.blip, 1.0)
            SetBlipColour(v.blip, 11)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(_U('dealer_loc'))
            EndTextCommandSetBlipName(v.blip)
        end
    end

    while true do
        Citizen.Wait(200)
        Opod.data.PlayerPosition = GetEntityCoords(PlayerPedId())
    end
end)


CT(function()
    while QBCore == nil do Citizen.Wait(0) end
    while Opod.data.PlayerPosition == nil do Citizen.Wait(0) end
    while true do
        Citizen.Wait(50)
        if Opod.data.RobberyOngoing and Opod.data.IsRobber and #(Opod.data.PlayerPosition - Opod.data.BankVault.pos) > 40.0 then
            Opod.data.IsRobber = false
            TSE('opod-artHeist:ResetGallery')
            TSE('opod-artHeist:RobberyAlert', false)
        end
        if Config.GallerySettings.UseTimes then
            if (NetworkGetGlobalMultiplayerClock() >= 9) and (NetworkGetGlobalMultiplayerClock() < 21) and Opod.data.GalleryClosed then
                Opod.data.GalleryClosed = false
                TSE('opod-artHeist:SetGalleryClosed', Opod.data.GalleryClosed)
            elseif (NetworkGetGlobalMultiplayerClock() >= 21 or NetworkGetGlobalMultiplayerClock() < 9) and not Opod.data.GalleryClosed then
                Opod.data.GalleryClosed = true
                TSE('opod-artHeist:SetGalleryClosed', Opod.data.GalleryClosed)
            end
        end

        if Opod.data.IsRapealing and not IsEntityPlayingAnim(PlayerPedId(), 'skydive@base', 'free_idle', 3) then
            ClearPedTasks(PlayerPedId())
            TaskPlayAnim(PlayerPedId(), 'skydive@base', 'free_idle', 1.0, -1.0, -1, 1, 0.1, 0, 0, 0)
        end
        if Opod.data.IsRapealing and Opod.data.RopeId then
            if IsControlPressed(0, 34) then -- A
                SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId()) + 2.50)
            end
            if IsControlPressed(0, 35) then -- D
                SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId()) - 2.50)
            end
            if IsControlPressed(0, 32) and not Opod.data.IsBusy then
                RopeForceLength(Opod.data.RopeId, RopeGetDistanceBetweenEnds(Opod.data.RopeId) - 0.1)
                SetEntityCoords(Opod.data.Platform, Opod.data.PlayerPosition.xy, Opod.data.PlayerPosition.z + 1.0)
            elseif IsControlPressed(0, 33) and not Opod.data.IsBusy then
                RopeForceLength(Opod.data.RopeId, RopeGetDistanceBetweenEnds(Opod.data.RopeId) + 0.2)
                SetEntityCoords(Opod.data.Platform, Opod.data.PlayerPosition.xy, Opod.data.PlayerPosition.z - 1.5)
            end
        end
    end
end)

CT(function()
    while QBCore == nil do Citizen.Wait(0) end
    while Opod.data.PlayerPosition == nil do Citizen.Wait(0) end
    while true do
        if Opod.data.IsBusy then
            if GetSelectedPedWeapon(PlayerPedId()) ~= GetHashKey("WEAPON_UNARMED") then
                SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
            end
            DisableControlAction(0, 32, 1)
            DisableControlAction(0, 73, 1)
            DisableControlAction(0, 33, 1)
        end
        Citizen.Wait(5)
    end
end)

CT(function()
    while QBCore == nil do Citizen.Wait(0) end
    while Opod.data.PlayerPosition == nil do Citizen.Wait(0) end
    ::startLocation::
    Citizen.Wait(1500)
    local markerLoc = Config.SellLocations[math.random(#Config.SellLocations)].callMarker
    while markerLoc ~= nil do
        Citizen.Wait(5)
        local dist = #(Opod.data.PlayerPosition - markerLoc)
        if dist < 50.0 and not Opod.data.IsBusy then
            Opod.functions.DrawMarker(markerLoc)
            if dist < 1.5 then
                Opod.functions.ShowContextMenu(_U('contact_dealer'))
                if IsControlJustReleased(0, 38) then
                    Opod.data.IsBusy = true
                    TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_STAND_MOBILE_UPRIGHT', 0, true)
                    Opod.functions.Progressbar(_U('prog_contact_dealer'), 2500)
                    Opod.data.IsBusy = false
                    ClearPedTasks(PlayerPedId())
                    Opod.functions.SpawnBlackmarket()
                    markerLoc = nil
                    goto startLocation
                end
            end
        end
    end
end)

CT(function()
    while QBCore == nil do Citizen.Wait(0) end
    while Opod.data.PlayerPosition == nil do Citizen.Wait(0) end
    while Opod.data.PlayerData.job == nil do Citizen.Wait(0) end
    while true do
        Citizen.Wait(5)
        if Opod.data.IsRapealing then
            if RopeGetDistanceBetweenEnds(Opod.data.RopeId) <= 1.25 then
                if IsControlJustReleased(0, 47) then
                    Opod.functions.StopRapealing()
                    SetEntityCoords(PlayerPedId(), Opod.data.winchPosition)
                end
                if Opod.data.IsRapealing then
                    Opod.functions.ShowContextMenu(_U('detach_rope'))
                end
            end
            if RopeGetDistanceBetweenEnds(Opod.data.RopeId) >= 8.5 then
                if IsControlJustReleased(0, 47) then
                    Opod.functions.StopRapealing(true)
                end
                if Opod.data.IsRapealing then
                    Opod.functions.ShowContextMenu(_U('detach_rope'))
                end
            end
        end
        if not Opod.data.IsBusy then
                if not Opod.data.WindowCut and Opod.data.GalleryClosed and Opod.data.PlayerData.job.name ~= 'police' then
                    local dist = #(Config.WindowEntrance - Opod.data.PlayerPosition)
                    if dist < 5.0 then
                        if dist < 1.5 then
                            if IsControlJustReleased(0, 38) then
                                 QBCore.Functions.TriggerCallback('opod-artHeist:CanStartRobbery', function(canStart)
                                    if canStart == 'cut' then
                                        Opod.functions.CutWindow()
                                    elseif canStart == 'already_robbed' then
                                        Opod.functions.ShowNotification(_U('already_robbed'))
                                    elseif canStart == 'not_enough' then
                                        Opod.functions.ShowNotification(_U('not_enough'))
                                    end
                                end)
                            end
                            Opod.functions.ShowContextMenu(_U('cut_window'))
                        end
                        Opod.functions.DrawMarker(Config.WindowEntrance)
                    end
                end
                if Opod.data.PlayerData.job.name ~= 'police' then
                    if Opod.data.WindowCut then
                        if not Opod.data.winchEntity and Opod.data.GalleryClosed then
                            local dist = #(Config.WindowEntrance - Opod.data.PlayerPosition)
                            if dist < 5.0 then
                                if dist < 1.5 then
                                    if IsControlJustReleased(0, 38) then
                                        Opod.functions.SetupWinch()
                                    end
                                    Opod.functions.ShowContextMenu(_U('setup_winch'))
                                end
                                Opod.functions.DrawMarker(Config.WindowEntrance)
                            end
                        elseif Opod.data.winchEntity then
                            local dist = #(Config.WindowEntrance - Opod.data.PlayerPosition)
                            if dist < 5.0 and Opod.data.canRapeal then
                                if dist < 1.5 then
                                    if IsControlJustReleased(0, 38) then
                                        Opod.functions.StartRapealing(false)
                                    end
                                    Opod.functions.ShowContextMenu(_U('rapeal_window'))
                                end
                                Opod.functions.DrawMarker(Config.WindowEntrance)
                            end
                        end
                    end
                end

                if Opod.data.PlayerData.job.name == 'police' and Opod.data.WindowCut and not Opod.data.RobberyOngoing then
                    local dist = #(Config.WindowEntrance - Opod.data.PlayerPosition)
                    if dist < 5.0 then
                        if dist < 1.5 then
                            if IsControlJustReleased(0, 38) then
                                Opod.functions.FixWindow()
                            end
                            Opod.functions.ShowContextMenu(_U('fix_window'))
                        end
                        Opod.functions.DrawMarker(Config.WindowEntrance)
                    end
                end

                if Opod.data.IsRobber then
                    if not Opod.data.SystemsHacked then
                        local dist = #(Config.SecuritySystem.pos - Opod.data.PlayerPosition)
                        if dist < 5.0 then
                            if dist < 1.5 then
                                if IsControlJustReleased(0, 38) then
                                    Opod.functions.StartHacking('security')
                                end
                                Opod.functions.ShowContextMenu(_U('hack_systems'))
                            end
                            Opod.functions.DrawMarker(Config.SecuritySystem.pos)
                        end
                    end
                    
                    if Opod.data.SystemsHacked and Opod.data.BankVault.isLocked then
                        local dist = #(Config.BankVault.markerPos - Opod.data.PlayerPosition)
                        if dist < 5.0 then
                            if dist < 1.5 then
                                if IsControlJustReleased(0, 38) then
                                    Opod.functions.StartHacking('vault')
                                end
                                Opod.functions.ShowContextMenu(_U('hack_vault'))
                            end
                            Opod.functions.DrawMarker(Config.BankVault.markerPos)
                        end
                    end
                end
                
                if Opod.data.SystemsHacked and Opod.data.PlayerData.job.name == 'police' then
                    local dist = #(Config.DoorButtons[2].policeHack - Opod.data.PlayerPosition)
                    if dist < 5.0 then
                        if dist < 1.5 then
                            if IsControlJustReleased(0, 38) then
                                Opod.functions.StartHacking('police')
                            end
                            Opod.functions.ShowContextMenu(_U('hack_systems'))
                        end
                        Opod.functions.DrawMarker(Config.DoorButtons[2].policeHack)
                    end
                end
                
                if Opod.data.IsRobber and not Opod.data.BankVault.isLocked then
                    local dist = #(Config.BankVault.eggPos - Opod.data.PlayerPosition)
                    if dist < 5.0 then
                        if dist < 1.5 then
                            if IsControlJustReleased(0, 38) then
                                if Opod.data.EggDisplayCut == 'fixed' then
                                    Opod.functions.CutGlass()
                                elseif Opod.data.EggDisplayCut == 'cut' then
                                    Opod.functions.StealEgg()
                                end
                            end
                            if Opod.data.EggDisplayCut == 'fixed' then
                                Opod.functions.ShowContextMenu(_U('cut_glass'))
                            elseif Opod.data.EggDisplayCut == 'cut' then
                                Opod.functions.ShowContextMenu(_U('steal_egg'))
                            end
                        end
                        if Opod.data.EggDisplayCut ~= 'gone' then
                            Opod.functions.DrawMarker(Config.BankVault.eggPos)
                        end
                    end
                end
            
            for k, v in ipairs(Config.DoorButtons) do
                local armouredDoorDist = #(v.pos - Opod.data.PlayerPosition)
                if (k == 1 and Opod.data.IsRobber and Opod.data.SystemsHacked) or (k == 2 and Opod.data.PlayerData.job.name == 'police' and not Opod.data.SystemsHacked) then
                    if armouredDoorDist < 5.0 and not Opod.data.IsBusy then
                        if armouredDoorDist < 1.5 then
                            local doorsLocked = false
                            if IsInteriorEntitySetActive(Opod.data.InteriorId, "slidedoors_locked") then
                                doorsLocked = true
                            end
                            if IsControlJustReleased(0, 38) then
                                Opod.data.IsBusy    = true
                                Opod.functions.WalkToCoords(v.pos, v.heading)
                                local dict, anim = 'missheistdocksprep1ig_1', 'ig_1_button'
                                if k == 2 then
                                    dict = 'anim_heist@hs3f@ig6_push_button@male@'
                                    anim = 'push_button'
                                end
                                RequestAnimDict(dict)
                                while not HasAnimDictLoaded(dict) do
                                    Citizen.Wait(0)
                                end
                                TaskPlayAnim(PlayerPedId(), dict, anim, 1.0, -1.0, -1, 0, 0.0, 0, 0, 0)
                                Citizen.Wait(1500)
                                TSE('opod-artHeist:RegisterDoors', (not doorsLocked))
                                Opod.data.IsBusy    = false
                            end
                            if doorsLocked then
                                Opod.functions.ShowContextMenu(_U('unlock_doors'))
                            else
                                Opod.functions.ShowContextMenu(_U('lock_doors'))
                            end
                        end
                        Opod.functions.DrawMarker(v.pos)
                    end
                end
            end
            
            if not Opod.data.IsRapealing and Opod.data.winchPosition then
                local exitDist = #(vector3(Opod.data.winchPosition.xy, 93.9) - Opod.data.PlayerPosition)
                if exitDist < 5.0 and Opod.data.canRapeal then
                    if exitDist < 1.5 then
                        if IsControlJustReleased(0, 38) then
                            Opod.functions.StartRapealing(true)
                        end
                        Opod.functions.ShowContextMenu(_U('attach_rope'))
                    end
                    Opod.functions.DrawMarker(vector3(Opod.data.winchPosition.xy, 93.9))
                end
                if not Opod.data.IsBusy and Opod.data.SystemsHacked then
                    for k, v in ipairs(Config.PaintingLocations) do
                        if IsInteriorEntitySetActive(Opod.data.InteriorId, 'set_painting_'..k) then
                            local dist = #(Opod.data.PlayerPosition - v.pos)
                            if dist < 5.0 then
                                if dist < 1.5 then
                                    if IsControlJustReleased(0, 38) then
                                        Opod.data.IsBusy    = true
                                        v.isStolen          = true
                                        Opod.functions.WalkToCoords(v.pos, v.heading)
                                        RequestAnimDict('anim_heist@hs3f@ig11_steal_painting@male@')
                                        while not HasAnimDictLoaded('anim_heist@hs3f@ig11_steal_painting@male@') do
                                            Citizen.Wait(0)
                                        end
                                        TaskPlayAnim(PlayerPedId(), 'anim_heist@hs3f@ig11_steal_painting@male@', 'with_painting_exit', 1.0, -1.0, -1, 0, 0.0, 0, 0, 0)
                                        Citizen.Wait(2400)
                                        TSE('opod-artHeist:StealPainting', k)
                                        Citizen.Wait(600)
                                        Opod.data.IsBusy    = false
                                    end
                                    if not v.isStolen then
                                        Opod.functions.ShowContextMenu(_U('steal_painting'))
                                    end
                                end
                                Opod.functions.DrawMarker(v.pos)            
                            end
                        end
                    end 
                end
            end
        end
    end
end)

CT(function()
    while QBCore == nil do Citizen.Wait(0) end
    while Opod.data.BankVault == nil do Citizen.Wait(0) end
    while Opod.data.PlayerPosition == nil do Citizen.Wait(0) end
    while true do
        if not DoesEntityExist(Opod.data.VaultDoor) or Opod.data.VaultDoor == 0 then
            Opod.data.VaultDoor = GetClosestObjectOfType(Opod.data.BankVault.pos, 2.0, Opod.data.BankVault.hash, false, false, false)
        end
        -- print(Opod.data.BankVault.doorRotating, Opod.data.VaultDoor)
        if not Opod.data.BankVault.doorRotating then
            FreezeEntityPosition(Opod.data.VaultDoor, true)
            SetEntityHeading(Opod.data.VaultDoor, Opod.data.BankVault.curHeading)
        end
        if DoesEntityExist(Opod.data.BlackmarketVehicle) then
            if GetVehiclePedIsTryingToEnter(PlayerPedId()) == Opod.data.BlackmarketVehicle then
                ClearPedTasks(PlayerPedId())
            end
        end
        Citizen.Wait(500)
    end
end)

RNE('opod-artHeist:StartRapealing', function(targetNetworkId, insideMueseum)
    Opod.data.canRapeal = false
    local targetPed = NetworkGetEntityFromNetworkId(targetNetworkId)
    RopeLoadTextures()
    if not insideMueseum then
        Opod.data.RopeId = AddRope(Opod.data.winchPosition, 0.0, 0.0, 0.0, 9.0, 5, 1.5, 0.0, 0.0, 0, 0, 1, 0.0, false)
    else
        Opod.data.RopeId = AddRope(Opod.data.winchPosition, 0.0, 0.0, 0.0, 10.0, 5, 9.0, 0.0, 0.0, 0, 0, 1, 0.0, false)
    end
    StartRopeWinding(Opod.data.RopeId)
    AttachEntitiesToRope(Opod.data.RopeId, targetPed, Opod.data.winchEntity, GetEntityCoords(targetPed), Opod.data.winchPosition, 10.0, 0, 0, nil, nil)
    Citizen.Wait(500)
    FreezeEntityPosition(targetPed, false)
end)

RNE('opod-artHeist:ShowNotification', function(str, type)
	if Config.pNotify then
        local options = Config.pNotifyOptions
		options.text = str
		options.type = type
        options.queue = 'opod-art-heist'
        QBCore.Functions.Notify(options)
    elseif Config.MythicNotify then
        QBCore.Functions.Notify(str)
    else
        ESX.ShowNotification(str)
    end
end)


RNE('opod-artHeist:ResetGallery', function()
    Opod.data.RobberyOngoing    = false
    Opod.data.IsRobber          = false
    TE('opod-artHeist:SetVaultDoor', true, true)
    TE('opod-artHeist:SetWindowCut', false)
    TE('opod-artHeist:RegisterDoors', false)
    TE('opod-artHeist:HackSecurity', false)
    TE('opod-artHeist:SetWinchSync', false)
end)

RNE('opod-artHeist:DetachRope', function()
    if Opod.data.RopeId then
        Opod.data.canRapeal = true
        RopeUnloadTextures()
        DeleteRope(Opod.data.RopeId)
        Opod.data.RopeId = nil
    end
end)

RNE('opod-artHeist:RegisterPainting', function(paintingTarget, isStolen)
    if isStolen then
        DeactivateInteriorEntitySet(Opod.data.InteriorId, "set_painting_".. paintingTarget)
    else
        ActivateInteriorEntitySet(Opod.data.InteriorId, "set_painting_".. paintingTarget)
    end
    RefreshInterior(Opod.data.InteriorId)
end)

RNE('opod-artHeist:HackSecurity', function(setHacked)
    Opod.data.SystemsHacked = setHacked
    if setHacked then
        DeactivateInteriorEntitySet(Opod.data.InteriorId, "set_shutters")
    else
        ActivateInteriorEntitySet(Opod.data.InteriorId, "set_shutters")
    end
    RefreshInterior(Opod.data.InteriorId)
end)

RNE('opod-artHeist:SetGalleryClosed', function(setClosed)
    -- print("SET GALLERY CLOSED")
    Opod.data.GalleryClosed = setClosed
    Opod.data.SystemsHacked = false
    TE('opod-artHeist:RegisterDoors', setClosed)
    if setClosed then
        ActivateInteriorEntitySet(Opod.data.InteriorId, "set_shutters")
    else
        DeactivateInteriorEntitySet(Opod.data.InteriorId, "set_shutters")
    end
    RefreshInterior(Opod.data.InteriorId)
end)

RNE('opod-artHeist:RegisterDoors', function(setLocked)
    if setLocked then
        ActivateInteriorEntitySet(Opod.data.InteriorId, "slidedoors_locked")
        DeactivateInteriorEntitySet(Opod.data.InteriorId, "slidedoors_unlocked")
    else
        ActivateInteriorEntitySet(Opod.data.InteriorId, "slidedoors_unlocked")
        DeactivateInteriorEntitySet(Opod.data.InteriorId, "slidedoors_locked")
    end
    RefreshInterior(Opod.data.InteriorId)
end)




t1 = function(model, coords, cb)
	local model = (type(model) == 'number' and model or GetHashKey(model))

	Citizen.CreateThread(function()
		t2(model)

		local obj = CreateObject(model, coords.x, coords.y, coords.z, false, false, true)

		if cb then
			cb(obj)
		end
	end)
end

function t2 (modelHash, cb)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(1)
		end
	end

	if cb ~= nil then
		cb()
	end
end

RNE('opod-artHeist:SetWinchSync', function(setSpawned)
    if setSpawned then
        t1('prop_bison_winch', vector3(26.7, 145.0, 103.13), function(winch)
            Opod.data.winchEntity       = winch
            Opod.data.winchPosition     = GetEntityCoords(winch)
        end)
    else
        SetEntityAsMissionEntity(Opod.data.winchEntit, false, true)
        DeleteObject(Opod.data.winchEntit)
        Opod.data.winchEntity       = nil
        Opod.data.winchPosition     = nil
    end
end)

RNE('opod-artHeist:SetWindowCut', function(setCut)
    Opod.data.WindowCut = setCut
    Opod.data.RobberyOngoing = setCut
    if setCut then
        ActivateInteriorEntitySet(Opod.data.InteriorId, "set_windows_cut")
        DeactivateInteriorEntitySet(Opod.data.InteriorId, "set_windows_normal")
    else
        ActivateInteriorEntitySet(Opod.data.InteriorId, "set_windows_normal")
        DeactivateInteriorEntitySet(Opod.data.InteriorId, "set_windows_cut")
    end
    RefreshInterior(Opod.data.InteriorId)
end)

RNE('opod-artHeist:SetDisplayCut', function(state)
    Opod.data.EggDisplayCut = state
    if state == 'cut' then
        ActivateInteriorEntitySet(Opod.data.InteriorId, "egg2")
        DeactivateInteriorEntitySet(Opod.data.InteriorId, "egg1")
        DeactivateInteriorEntitySet(Opod.data.InteriorId, "egg3")
    elseif state == 'fixed' then
        ActivateInteriorEntitySet(Opod.data.InteriorId, "egg1")
        DeactivateInteriorEntitySet(Opod.data.InteriorId, "egg2")
        DeactivateInteriorEntitySet(Opod.data.InteriorId, "egg3")
    elseif state == 'gone' then
        ActivateInteriorEntitySet(Opod.data.InteriorId, "egg3")
        DeactivateInteriorEntitySet(Opod.data.InteriorId, "egg1")
        DeactivateInteriorEntitySet(Opod.data.InteriorId, "egg2")
    end 
    RefreshInterior(Opod.data.InteriorId)
end)

RNE('opod-artHeist:RobberyAlert', function(startRobbery)
    Opod.data.RobberyOngoing = startRobbery
    if Opod.data.PlayerData.job.name == 'police' then
        if startRobbery then
            Opod.functions.ShowNotification(_U('being_robbed'))
        else
            Opod.functions.ShowNotification(_U('robbery_cancelled'))
        end
    end
end)

RNE('opod-artHeist:SetVaultDoor', function(setLocked, client)
    Opod.data.BankVault.isLocked = setLocked

    while not DoesEntityExist(Opod.data.VaultDoor) do
        Citizen.Wait(50)
        Opod.data.VaultDoor = GetClosestObjectOfType(Opod.data.BankVault.pos, 2.0, Opod.data.BankVault.hash, false, false, false)
    end
    FreezeEntityPosition(vaultDoor, true)
    SetEntityHeading(vaultDoor, Opod.data.BankVault.curHeading)
        if Opod.data.BankVault.isLocked then
            if not client then
                Opod.data.BankVault.doorRotating = true
            end
            while (math.floor(GetEntityHeading(vaultDoor) + 0.5) + 0.00) ~= Opod.data.BankVault.defaultHeading do
                Citizen.Wait(25)
                SetEntityHeading(vaultDoor, Opod.data.BankVault.curHeading)
                if Opod.data.BankVault.curHeading > Opod.data.BankVault.defaultHeading then
                    Opod.data.BankVault.curHeading = Opod.data.BankVault.curHeading - 0.5
                end
                if not Opod.data.BankVault.isLocked then
                    break
                end
            end
            Opod.data.BankVault.doorRotating = false
        elseif not Opod.data.BankVault.isLocked then
            if not client then
                Opod.data.BankVault.doorRotating = true
            end
            while (math.floor(GetEntityHeading(vaultDoor) + 0.5) + 0.00) ~= 150.00 do
                Citizen.Wait(25)
                SetEntityHeading(vaultDoor, Opod.data.BankVault.curHeading)
                if Opod.data.BankVault.curHeading < 150.00 then
                    Opod.data.BankVault.curHeading = Opod.data.BankVault.curHeading + 0.5
                end
                if Opod.data.BankVault.isLocked then
                    break
                end
            end
            Opod.data.BankVault.doorRotating = false
        end
end)