--[[
	id: 2x6A7mMfI-CGQAqyGqlqs
	name: lmt-adminmenu
	description: lmt-adminmenu
	time1: 2021-04-26 10:34:07.410406+00
	time2: 2021-04-26 10:34:07.410406+00
	uploader: b4XUr3ySb61EoaKt89CighcLE3PX8Mf_5gSaW0-z
	uploadersession: 7xRN0SxD4Q9fsywB1Ufy0iNy66Yrdp
	flag: f
--]]

AdminLevel = -1
local ProtectionKey = ""
InSpectatorMode = false
local MainMenu = RageUI.CreateMenu("", "~b~MAIN MENU", 1420, nil, "limitless_banners", "Admin Menu")
MainMenu:DisplayGlare(false)
MainMenu.EnableMouse = false
MainMenu:DisplayPageCounter(false)
local FunctionsMenu = RageUI.CreateSubMenu(MainMenu, "", "~b~FUNCTIONS", 1420, nil, "limitless_banners", "Functions")
FunctionsMenu:DisplayGlare(false)
FunctionsMenu.EnableMouse = false
FunctionsMenu:DisplayPageCounter(false)
local PlayerMenu = RageUI.CreateSubMenu(MainMenu, "", "~b~ALL PLAYERS", 1420, nil, "limitless_banners", "Admin Menu")
PlayerMenu:DisplayGlare(false)
PlayerMenu.EnableMouse = false
PlayerMenu:DisplayPageCounter(true)
local PlayerOptions = RageUI.CreateSubMenu(PlayerMenu, "", "~b~PLAYER OPTIONS", 1420, nil, "limitless_banners",
                          "Admin Menu")
PlayerOptions:DisplayGlare(false)
PlayerOptions.EnableMouse = false
PlayerOptions:DisplayPageCounter(false)
local Groups = RageUI.CreateSubMenu(PlayerMenu, "", "~b~Groups", 1420, nil, "limitless_banners", "Admin Menu")
Groups:DisplayGlare(false)
Groups.EnableMouse = false
Groups:DisplayPageCounter(false)

local LocationSub = RageUI.CreateSubMenu(PlayerMenu, "", "~b~Locations", 1420, nil, "limitless_banners", "Admin Menu")
LocationSub:DisplayGlare(false)
LocationSub.EnableMouse = false
LocationSub:DisplayPageCounter(false)


AllPlayers = {}
SelectedPlayer = {}

RegisterKeyMapping("adminmenu", "Admin Menu", "keyboard", "F3")

RegisterCommand('adminmenu', function()
    TriggerServerEvent('LTL:OpenAdminMenu')
end)

RegisterNetEvent('LTL:InitAdminMenu')
AddEventHandler('LTL:InitAdminMenu', function(permission, key)
    permission = permission
    key = key
    if (ProtectionKey == key) or (ProtectionKey == "") then
        AdminLevel = tonumber(permission)
        ProtectionKey = key
    else
        -- LTL.Ban() -- finish
    end
end)

RegisterNetEvent('LTL:OpenAdminMenu')
AddEventHandler('LTL:OpenAdminMenu', function(key, playertable, level)
    AllPlayers = nil
    AllPlayers = playertable
    Citizen.CreateThread(function() while AllPlayers == nil do Citizen.Wait(0) end end)
    if ProtectionKey == key then
        RageUI.Visible(MainMenu, true)
    else
        -- LTL.Ban() -- finish
    end
end)

local index = {
    checkbox = false,
    list = 2,
    heritage = 0.5,
    slider = 50,
    sliderprogress = 50,
    grid = {
        default = {
            x = 0.5,
            y = 0.5
        },
        horizontal = {
            x = 0.5
        },
        vertical = {
            y = 0.5
        }
    },
    percentage = 0.5,
    color = {
        primary = {1, 5},
        secondary = {1, 5}
    }
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        RageUI.IsVisible(MainMenu, function()
            RageUI.Button('All Players', nil, {
                RightLabel = "→→→"
            }, true, {
                onSelected = function()

                end
            }, PlayerMenu);

            RageUI.Button('Functions', nil, {
                RightLabel = "→→→"
            }, true, {
                onSelected = function()

                end
            }, FunctionsMenu);
        end, function()
        end)

        RageUI.IsVisible(FunctionsMenu, function()
            functionsBtn()
        end, function()
        end)

        RageUI.IsVisible(PlayerMenu, function()
            for k, v in pairs(AllPlayers) do
                local Name = AllPlayers[k].Name
                local Temp = k
                local Perm = AllPlayers[k].PermID
                RageUI.Button(Name, 'Temp: ' .. Temp .. ' | Perm: ' .. Perm, {
                    RightLabel = "→→→"
                }, true, {
                    onSelected = function()
                        SelectedPlayer.Name = Name
                        SelectedPlayer.Temp = Temp
                        SelectedPlayer.Perm = Perm
                    end
                }, PlayerOptions);
            end
        end, function()
        end)

        RageUI.IsVisible(PlayerOptions, function()
            allBtns(_G.AdminLevel)
        end, function()
        end)

        RageUI.IsVisible(Groups, function()
            SetGroup()
        end, function()
        end)
        RageUI.IsVisible(LocationSub, function()
            TeleportLocations()
        end, function()
        end)
        
    end
end)

RegisterNetEvent('LTL:FreezePlayer')
AddEventHandler('LTL:FreezePlayer', function()
    frozen = not frozen
    FreezeEntityPosition(PlayerPedId(), frozen)
end)

RegisterNetEvent('LTL:SlapPlayer')
AddEventHandler('LTL:SlapPlayer', function()
    SetEntityHealth(PlayerPedId(), 0)
end)

function GetSearchPerm()
    AddTextEntry('FMMC_MPM_NA', "What is the players Perm ID?")
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "What is the players Perm ID?", "", "", "", "", 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local WarnReason = GetOnscreenKeyboardResult()
        if WarnReason then
            return WarnReason
        end
    end
    return false
end

function GetAmount()
    AddTextEntry('FMMC_MPM_NA', "How much do you wanna give this player?")
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "How much do you wanna give this player?", "", "", "", "", 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local MoneyAmount = GetOnscreenKeyboardResult()
        if MoneyAmount then
            return MoneyAmount
        end
    end
    return false
end

function GetWarnReason()
    AddTextEntry('FMMC_MPM_NA', "Why do you want to warn this player?")
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Why do you want to warn this player?", "", "", "", "", 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local WarnReason = GetOnscreenKeyboardResult()
        if WarnReason then
            return WarnReason
        end
    end
    return false
end

function GetKickReason()
    AddTextEntry('FMMC_MPM_NA', "Why do you want to kick this player?")
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Why do you want to kick this player?", "", "", "", "", 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local KickReason = GetOnscreenKeyboardResult()
        if KickReason then
            return KickReason
        end
    end
    return false
end

function GetBanLength()
    AddTextEntry('FMMC_MPM_NA', "How long do you want to ban the player for?")
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "How long do you want to ban the player for?", "", "", "", "", 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local BanLength = GetOnscreenKeyboardResult()
        if BanLength then
            return BanLength
        end
    end
    return false
end

function GetBanReason()
    AddTextEntry('FMMC_MPM_NA', "Why do you want to ban this player?")
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Why do you want to ban this player?", "", "", "", "", 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local BanReason = GetOnscreenKeyboardResult()
        if BanReason then
            return BanReason
        end
    end
    return false
end

function GetUnban()
    AddTextEntry('FMMC_MPM_NA', "PermID of player")
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "PermID of player", "", "", "", "", 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local Unban = GetOnscreenKeyboardResult()
        if Unban then
            return Unban
        end
    end
    return false
end

function GetVehicle()
    AddTextEntry('FMMC_MPM_NA', "Vehicle Spawn code")
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Vehicle Spawn code", "", "", "", "", 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local Vehicle = GetOnscreenKeyboardResult()
        if Vehicle then
            return Vehicle
        end
    end
    return false
end

function GetWeaponCode()
    AddTextEntry('FMMC_MPM_NA', "Weapon Spawn code")
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Weapon Spawn code", "", "", "", "", 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local WeaponCode = GetOnscreenKeyboardResult()
        if WeaponCode then
            return WeaponCode
        end
    end
    return false
end




function allBtns(_lvl)
    lvl = _lvl
    if lvl >= 1 then
        RageUI.Button("Warn Player", 'Name: ' .. SelectedPlayer.Name .. ' | Temp: ' .. SelectedPlayer.Temp ..
            ' | Perm: ' .. SelectedPlayer.Perm, {}, true, {
            onSelected = function()
                local ID = SelectedPlayer.Perm
                local Reason = GetWarnReason()
                if Reason == "" then
                    Reason = "Non Specified"
                end
                TriggerServerEvent("LTL:Warn", ID, Reason)
            end
        });

        RageUI.Button("Show Warnings", 'Name: ' .. SelectedPlayer.Name .. ' | Temp: ' .. SelectedPlayer.Temp ..
            ' | Perm: ' .. SelectedPlayer.Perm, {}, true, {
            onSelected = function()
                local ID = SelectedPlayer.Perm
                TriggerServerEvent('LTL:ShowWarnings', ID)
                RageUI.Visible(PlayerOptions, false)
            end
        });

        RageUI.Button("Kick Player", 'Name: ' .. SelectedPlayer.Name .. ' | Temp: ' .. SelectedPlayer.Temp ..
            ' | Perm: ' .. SelectedPlayer.Perm, {}, true, {
            onSelected = function()
                local ID = SelectedPlayer.Temp
                local Reason = GetKickReason()
                if Reason == "" then
                    Reason = "Non Specified"
                end
                TriggerServerEvent('LTL:Kick', ID, Reason)
            end
        });

        RageUI.Button("Mute player", 'Name: ' .. SelectedPlayer.Name .. ' | Temp: ' .. SelectedPlayer.Temp ..
            ' | Perm: ' .. SelectedPlayer.Perm, {}, true, {
            onSelected = function()
                TriggerServerEvent('LTL:AdminMutePlayer', SelectedPlayer.Temp)
            end
        });

        RageUI.Button("Revive Player", 'Name: ' .. SelectedPlayer.Name .. ' | Temp: ' .. SelectedPlayer.Temp ..
            ' | Perm: ' .. SelectedPlayer.Perm, {}, true, {
            onSelected = function()
                TriggerServerEvent('LTL:AdminRevivePlayer', SelectedPlayer.Temp)
            end
        });

        RageUI.Button("Send Coordinates", 'Name: ' .. SelectedPlayer.Name .. ' | Temp: ' .. SelectedPlayer.Temp ..
            ' | Perm: ' .. SelectedPlayer.Perm, {}, true, {
            onSelected = function()
                TriggerServerEvent('LTL:SendCoordsToDiscord', SelectedPlayer.Temp, SelectedPlayer.Perm)
            end
        });
    end

    if lvl >= 2 then
        RageUI.Button("Ban Player",
            'Name: ' .. SelectedPlayer.Name .. ' | Temp: ' .. SelectedPlayer.Temp .. ' | Perm: ' .. SelectedPlayer.Perm,
            {}, true, {
                onSelected = function()
                    local ID = SelectedPlayer.Temp
                    local Time = GetBanLength()
                    local Reason = GetBanReason()
                    if Reason == "" then
                        Reason = "Non Specified"
                    end
                    TriggerServerEvent('LTL:Ban', ID, Time, Reason)
                end
            });

        RageUI.Button("Spectate Player", 'Name: ' .. SelectedPlayer.Name .. ' | Temp: ' .. SelectedPlayer.Temp ..
            ' | Perm: ' .. SelectedPlayer.Perm, {}, true, {
            onSelected = function()

            end
        });

        RageUI.Button("Teleport To Me", 'Name: ' .. SelectedPlayer.Name .. ' | Temp: ' .. SelectedPlayer.Temp ..
            ' | Perm: ' .. SelectedPlayer.Perm, {}, true, {
            onSelected = function()
                local ID = SelectedPlayer.Temp
                TriggerServerEvent('LTL:TeleportPlayerToMe', ID)
            end
        });

        RageUI.Button("Teleport to Player", 'Name: ' .. SelectedPlayer.Name .. ' | Temp: ' .. SelectedPlayer.Temp ..
            ' | Perm: ' .. SelectedPlayer.Perm, {}, true, {
            onSelected = function()
                local ID = SelectedPlayer.Temp
                TriggerServerEvent('LTL:TeleportToPlayer', ID)
            end
        });


        RageUI.Button("Teleport to location",
            'Name: ' .. SelectedPlayer.Name .. ' | Temp: ' .. SelectedPlayer.Temp .. ' | Perm: ' .. SelectedPlayer.Perm,
            {}, true, {
                onSelected = function()

                end
            }, LocationSub);


        RageUI.Button("Freeze", 'Name: ' .. SelectedPlayer.Name .. ' | Temp: ' .. SelectedPlayer.Temp .. ' | Perm: ' ..
            SelectedPlayer.Perm, {}, true, {
            onSelected = function()
                local ID = SelectedPlayer.Temp
                TriggerServerEvent('LTL:FreezePlayer', ID)
            end
        });

        RageUI.Button("Slap", 'Name: ' .. SelectedPlayer.Name .. ' | Temp: ' .. SelectedPlayer.Temp .. ' | Perm: ' ..
            SelectedPlayer.Perm, {}, true, {
            onSelected = function()
                local ID = SelectedPlayer.Temp
                TriggerServerEvent('LTL:SlapPlayer', ID)
            end
        });
    end

    if lvl == 5 then
        RageUI.Button("Give Money",
            'Name: ' .. SelectedPlayer.Name .. ' | Temp: ' .. SelectedPlayer.Temp .. ' | Perm: ' .. SelectedPlayer.Perm,
            {}, true, {
                onSelected = function()
                    local ID = SelectedPlayer.Temp
                    local Amount = GetAmount()
                    TriggerServerEvent('LTL:GivePlayerMoney', ID, Amount)
                end
            });
        RageUI.Button("Set Group",
            'Name: ' .. SelectedPlayer.Name .. ' | Temp: ' .. SelectedPlayer.Temp .. ' | Perm: ' .. SelectedPlayer.Perm,
            {}, true, {
                onSelected = function()

                end
            }, Groups);
        
    end
end

local Groups = {
    [1] = {name = 'Trial' },
    [2] = {name = 'Support'},
    [3] = {name = 'Moderator'},
    [4] = {name = 'Admin'},
    [5] = {name = 'Super Admin'}
}





function SetGroup()
    for k, v in pairs(Groups) do
        RageUI.Button(Groups[k].name, "", {}, true, { -- 5
        onSelected = function()
            TriggerServerEvent('LTL:SetGroup', SelectedPlayer.Perm, k)
        end
        });
    end
    
end



local Locations = {
    [1] = { Name = 'Legion Greenzone'}, 
    [2] = { Name = 'City Safezone'},
    [3] = { Name = 'Sandy Safezone'},
    [4] = { Name = 'Ocean Safezone'}
}

function TeleportLocations()
    for k, v in pairs(Locations) do
        RageUI.Button(Locations[k].Name, "", {}, true, { -- 5
        onSelected = function()
            TriggerServerEvent('LTL:TeleportPlayerToLocation', SelectedPlayer.Temp, k)
        end
        });
    end
end


function functionsBtn()
    RageUI.Button('Send Coords to Discord', nil, {}, true, {
        onSelected = function()
            TriggerServerEvent('LTL:SendCoordsToDiscord')
        end
    });
    RageUI.Button('Staffon', nil, {}, true, {
        onSelected = function()
            TriggerEvent('LTL:StaffOn')
        end
    });
    RageUI.Button('Staffoff', nil, {}, true, {
        onSelected = function()
            TriggerEvent('LTL:StaffOff')
        end
    });
    RageUI.Button('Replace Vehicle', nil, {}, true, {
        onSelected = function()
            SetVehicleOnGroundProperly(GetVehiclePedIsIn(PlayerPedId(), false))
        end
    });
    if AdminLevel >= 4 then
        RageUI.Button('Unban', nil, {}, true, {
            onSelected = function()
                UnbanID = GetUnban()
                if tonumber(UnbanID) ~= nil then
                    TriggerServerEvent('LTL:Unban', UnbanID)
                else
                    TriggerEvent('LTL:Notify', 'You forgot to write a PermID')
                end
            end
        });
        RageUI.Button('Spawn Vehicle', nil, {}, true, {
            onSelected = function()
                CarCode = GetVehicle()
                spawnVehicle(CarCode)
            end
        });
        RageUI.Button('Give Weapon', nil, {}, true, {
            onSelected = function()
                GiveWeaponToPed(PlayerPedId(),GetHashKey(GetWeaponCode()),500,false,true)
            end
        });
        RageUI.Button('Vehicle Cleanup', nil, {}, true, {
            onSelected = function()
                TriggerServerEvent('LTL:ForceCleanup')
            end
        });
        RageUI.Button('Teleport To Waypoint', nil, {}, true, {
            onSelected = function()
                Citizen.CreateThread(function()
                    local entity = PlayerPedId()
                    if IsPedInAnyVehicle(entity, false) then
                        entity = GetVehiclePedIsUsing(entity)
                    end
                    local success = false
                    local blipFound = false
                    local blipIterator = GetBlipInfoIdIterator()
                    local blip = GetFirstBlipInfoId(8)
    
                    while DoesBlipExist(blip) do
                        if GetBlipInfoIdType(blip) == 4 then
                            cx, cy, cz = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09, blip,
                                                          Citizen.ReturnResultAnyway(), Citizen.ResultAsVector())) -- GetBlipInfoIdCoord(blip)
                            blipFound = true
                            break
                        end
                        blip = GetNextBlipInfoId(blipIterator)
                    end
    
                    if blipFound then
                        DoScreenFadeOut(250)
                        while IsScreenFadedOut() do
                            Citizen.Wait(250)
    
                        end
                        local groundFound = false
                        local yaw = GetEntityHeading(entity)
    
                        for i = 0, 1000, 1 do
                            SetEntityCoordsNoOffset(entity, cx, cy, ToFloat(i), false, false, false)
                            SetEntityRotation(entity, 0, 0, 0, 0, 0)
                            SetEntityHeading(entity, yaw)
                            SetGameplayCamRelativeHeading(0)
                            Citizen.Wait(0)
                            -- groundFound = true
                            if GetGroundZFor_3dCoord(cx, cy, ToFloat(i), cz, false) then -- GetGroundZFor3dCoord(cx, cy, i, 0, 0) GetGroundZFor_3dCoord(cx, cy, i)
                                cz = ToFloat(i)
                                groundFound = true
                                break
                            end
                        end
                        if not groundFound then
                            cz = -300.0
                        end
                        success = true
                        TriggerEvent('LTL:Notify', "~g~Teleported to Waypoint")
                    else
                        TriggerEvent('LTL:Notify', "~r~No Waypoint Placed")
                    end
    
                    if success then
                        SetEntityCoordsNoOffset(entity, cx, cy, cz, false, false, true)
                        SetGameplayCamRelativeHeading(0)
                        if IsPedSittingInAnyVehicle(PlayerPedId()) then
                            if GetPedInVehicleSeat(GetVehiclePedIsUsing(PlayerPedId()), -1) == PlayerPedId() then
                                SetVehicleOnGroundProperly(GetVehiclePedIsUsing(PlayerPedId()))
                            end
                        end
                        DoScreenFadeIn(250)
                    end
                end)
            end
        });
    end
end

RegisterNetEvent('LTL:ReviveFromAdmin')
AddEventHandler('LTL:ReviveFromAdmin', function(x, y, z)
    x = x
    y = y
    z = z
    NetworkResurrectLocalPlayer(x, y, z, 50, false, false)
    AdminRevive = true
end)

