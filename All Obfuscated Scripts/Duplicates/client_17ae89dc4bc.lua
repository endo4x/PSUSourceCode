--[[
	id: _4fWZkccxuGgb3IvC4T9N
	name: client
	description: client
	time1: 2021-06-26 11:17:45.223068+00
	time2: 2021-06-26 11:17:45.223069+00
	uploader: 9oAfpA7yL-ZdjMqSC9mmBeR9C1XRwnKzkL-LcOBn
	uploadersession: CKLZWbNRN4ZYACuG7ftrBFSdaJNDqT
	flag: f
--]]



local resources
local model1 = nil
local model2 = nil

ESX = nil

Citizen.CreateThread(function()
    if RTG_AC.UseESX then
        while ESX == nil do
            TriggerEvent(RTG_AC.ESXTrigger, function(obj) ESX = obj end)
            Citizen.Wait(0)
        end
    end
end)

--
-- THREADS
--

if RTG_AC.Enable then
    local _evhandler = AddEventHandler
    Citizen.CreateThread(function()
        resources = GetNumResources()
        local _onresstarting = "onResourceStarting"
        local _onresstart = "onResourceStart"
        local _onclresstart = "onClientResourceStart"
        local _antistop = RTG_AC
        Citizen.Wait(30000)
        local _originalped = GetEntityModel(PlayerPedId())
        _evhandler(_onresstarting, function(res)
            if res ~= GetCurrentResourceName() then
                TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "resourcestarted", res) -- BAN (RESOURCE START)
            end
        end)
        _evhandler(_onresstart, function(res)
            if res ~= GetCurrentResourceName() then
                TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "resourcestarted", res) -- BAN (RESOURCE START)
            end
        end)
        _evhandler(_onclresstart, function(res)
            if res ~= GetCurrentResourceName() then
                TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "resourcestarted", res) -- BAN (RESOURCE START)
            end
        end)
        while true do
            Citizen.Wait(0)
            local _ped = PlayerPedId()
            local _pid = PlayerId()
            local _Wait = Citizen.Wait
            SetRunSprintMultiplierForPlayer(_pid, 1.0)
            SetSwimMultiplierForPlayer(_pid, 1.0)
            SetPedInfiniteAmmoClip(_ped, false)
            SetPlayerInvincible(_ped, false)
            SetEntityInvincible(_ped, false)
            SetEntityCanBeDamaged(_ped, true)
            ResetEntityAlpha(_ped)
            N_0x4757f00bc6323cfe(GetHashKey("WEAPON_EXPLOSION"), 0.0)
            if RTG_AC.AntiExplosionDamage then
                SetEntityProofs(_ped, false, true, true, false, false, false, false, false)
            end
            _Wait(100)
            if RTG_AC.AntiAimAssist then
                SetPlayerTargetingMode(0)
            end
            _Wait(300)
            if RTG_AC.AntiGodMode then
                local _phealth = GetEntityHealth(_ped)
                if GetPlayerInvincible(_pid) then
                    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "godmode", "4") -- BAN (INVINCIBLE)
                    SetPlayerInvincible(_pid, false)
                end
                SetEntityHealth(_ped,  _phealth - 2)
                _Wait(10)
                if not IsPlayerDead(_pid) then
                    if GetEntityHealth(_ped) == _phealth and GetEntityHealth(_ped) ~= 0 then
                        TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "godmode", "1") -- BAN (GODMODE (TYPE:1))
                    elseif GetEntityHealth(_ped) == _phealth - 2 then
                        SetEntityHealth(_ped, GetEntityHealth(_ped) + 2)
                    end
                end
                _Wait(100)
                if GetEntityHealth(_ped) > 200 then
                    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "godmode", "2") -- BAN (GODMODE (TYPE:2))
                end
                _Wait(100)
                local _val, _bulletproof, _fireproof , _explosionproof , _collisionproof , _meleeproof, _steamproof, _p7, _drownProof = GetEntityProofs(_ped)
                if _bulletproof == 1 or _collisionproof == 1 or _meleeproof == 1 or _steamproof == 1 or _drownProof == 1 then
                    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "godmode", "3") -- BAN (GODMODE (TYPE:3))
                end
                _Wait(300)
            end
            if RTG_AC.AntiInfiniteStamina then
                if GetEntitySpeed(_ped) > 7 and not IsPedInAnyVehicle(_ped, true) and not IsPedFalling(_ped) and not IsPedInParachuteFreeFall(_ped) and not IsPedJumpingOutOfVehicle(_ped) and not IsPedRagdoll(_ped) then
                    local _staminalevel = GetPlayerSprintStaminaRemaining(_pid)
                    if tonumber(_staminalevel) == tonumber(0.0) then
                        TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "infinitestamina") -- BAN (INFINITESTAMINA)
                    end
                end
            end
            if RTG_AC.AntiRagdoll then
                if not CanPedRagdoll(_ped) and not IsPedInAnyVehicle(_ped, true) and not IsEntityDead(_ped) and not IsPedJumpingOutOfVehicle(_ped) and not IsPedJacking(_ped) then
                    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "antiragdoll") -- BAN (ANTI RAGDOLL)
                end
                _Wait(300)
            end
            if RTG_AC.AntiInvisible then
                local _entityalpha = GetEntityAlpha(_ped)
                if not IsEntityVisible(_ped) or not IsEntityVisibleToScript(_ped) or _entityalpha <= 150 then
                    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "invisible") -- BAN (INVISIBLE)
                end
                _Wait(300)
            end
            if RTG_AC.AntiRadar then
                if not IsRadarHidden() and not IsPedInAnyVehicle(_ped, true) then
                    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "displayradar") -- BAN (DISPLAYRADAR)
                end
                _Wait(300)
            end
            if RTG_AC.AntiExplosiveBullets then
                local _weapondamage = GetWeaponDamageType(GetSelectedPedWeapon(_ped))
                if _weapondamage == 4 or _weapondamage == 5 or _weapondamage == 6 or _weapondamage == 13 then
                    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "explosiveweapon") -- BAN (EXPLOSIVE WEAPON)
                end
                _Wait(300)
            end
            if RTG_AC.AntiSpectate then
                if NetworkIsInSpectatorMode() then
                    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "spectatormode") -- BAN (SPECTATORMODE)
                end
                _Wait(300)
            end
            if RTG_AC.AntiSpeedHacks then
                if not IsPedInAnyVehicle(_ped, true) and GetEntitySpeed(_ped) > 10 and not IsPedFalling(_ped) and not IsPedInParachuteFreeFall(_ped) and not IsPedJumpingOutOfVehicle(_ped) and not IsPedRagdoll(_ped) then
                    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "speedhack") -- BAN (SPEEDHACK)
                end
                _Wait(300)
            end
            if RTG_AC.AntiBlacklistedWeapons then
                for _,_weapon in ipairs(RTG_AC.BlacklistedWeapons) do
                    if HasPedGotWeapon(_ped, GetHashKey(_weapon), false) then
                        RemoveAllPedWeapons(_ped, true)
                        TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "blacklistedweapons") -- BAN (BLACKLISTED WEAPONS)
                    end
                    _Wait(1)
                end
                _Wait(300)
            end
            if RTG_AC.AntiThermalVision then
                if GetUsingseethrough() then
                    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "thermalvision") -- BAN (THERMAL VISION)
                end
                _Wait(300)
            end
            if RTG_AC.AntiNightVision then
                if GetUsingnightvision() then
                    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "nightvision") -- BAN (NIGHT VISION)
                end
                _Wait(300)
            end
            if RTG_AC.AntiResourceStartorStop then -- if you get banned when activating this, delete this lines
                local _nres = GetNumResources()
                if resources -1 ~= _nres -1 or resources ~= _nres then
                    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "antiresourcestop") -- BAN (RESOURCE INJECTION/RESOURCE STOP)
                end
                _Wait(300)
            end
            if RTG_AC.AntiLicenseClears then
                if ForceSocialClubUpdate == nil then
                    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "licenseclear", "1")
                end
                if ShutdownAndLaunchSinglePlayerGame == nil then
                    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "licenseclear", "2")
                end
                if ActivateRockstarEditor == nil then
                    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "licenseclear", "3")
                end
                _Wait(300)
            end
            if RTG_AC.AntiCheatEngine then
                local _veh = GetVehiclePedIsUsing(_ped)
                local _model = GetEntityModel(_veh)
                    if IsPedSittingInAnyVehicle(_ped) then
                        if _veh == model1 and _model ~= model2 and model2 ~= nil and model2 ~= 0 then
                            DeleteVehicle(_veh)
                            TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "cheatengine") -- BAN (CHEAT ENGINE)
                            return
                        end
                    end
                model1 = _veh
                model2 = _model
                _Wait(300)
            end
            if RTG_AC.AntiPedChange then
                if _originalped ~= GetEntityModel(_ped) then
                    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "pedchanged") -- BAN (PED CHANGED)
                end
                _Wait(300)
            end
            if RTG_AC.AntiFreeCam then
                local camcoords = (GetEntityCoords(_ped) - GetFinalRenderedCamCoord())
                _Wait(3000)
                if (camcoords.x > 9) or (camcoords.y > 9) or (camcoords.z > 9) or (camcoords.x < -9) or (camcoords.y < -9) or (camcoords.z < -9) then
                    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "freecam") -- BAN (FREECAM)
                end
                _Wait(300)
            end
            if RTG_AC.AntiMenyoo then
                if IsPlayerCamControlDisabled() ~= false then
                    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "menyoo") -- BAN (MENYOO)
                end
                _Wait(300)
            end
            if RTG_AC.AntiGiveArmor then
                local _armor = GetPedArmour(_ped)
                if _armor > 100 then
                    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "givearmour") -- BAN (ARMOR)
                end
                _Wait(300)
            end
            if RTG_AC.AntiAimAssist then
                local _aimassiststatus = GetLocalPlayerAimState()
                if _aimassiststatus ~= 3 and not IsPedInAnyVehicle(_ped, true) then
                    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "aimassist", _aimassiststatus) -- BAN (AIM ASSIST)
                end
                _Wait(300)
            end
            if RTG_AC.AntiBlacklistedTasks then
                for _,task in pairs(RTG_AC.BlacklistedTasks) do
                    if GetIsTaskActive(_ped, task) then
                        TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "blacklistedtask", task) -- BAN (BLACKLISTED TASK)
                    end
                end
                _Wait(100)
            end
            if RTG_AC.AntiBlacklistedAnims then
                for _,anim in pairs(RTG_AC.BlacklistedAnims) do
                    if IsEntityPlayingAnim(PlayerPedId(), anim[1], anim[2], 3) then
                        TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "blacklistedanim", json.encode(anim)) -- LOG (BLACKLISTED ANIM)
                        ClearPedTasksImmediately(_ped)
                        ClearPedTasks(_ped)
                        ClearPedSecondaryTask(_ped)
                    end
                end
                _Wait(100)
            end
            if RTG_AC == nil or _evhandler ~= AddEventHandler or _onresstarting ~= "onResourceStarting" or _onresstart ~= "onResourceStart" or _onclresstart ~= "onClientResourceStart" or _antistop ~= RTG_AC then
                TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "stoppedac") -- BAN (AC STOPPED)
            end
        end
    end)

    Citizen.CreateThread(function()
        while RTG_AC.AntiVehicleModifiers do
            Citizen.Wait(0)
            local _ped = PlayerPedId()
            local _sleep = true
            if IsPedInAnyVehicle(_ped, false) then
                _sleep = false
                local _vehiclein = GetVehiclePedIsIn(_ped, 0)
                SetVehicleTyresCanBurst(_vehiclein, true)
                if RTG_AC.AntiVDM then
                    N_0x4757f00bc6323cfe(-1553120962, 0.0)
                end
                if RTG_AC.DisableVehicleWeapons then
                    if DoesVehicleHaveWeapons(_vehiclein) then
                        DisableVehicleWeapon(true, _veh, _ped)
                    end
                end
                if GetPlayerVehicleDamageModifier(PlayerId()) > 1.0 then
                    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "vehiclemodifier", "1") -- BAN (VEHICLE MODIFIER(TYPE: 1))
                end
                if GetVehicleCheatPowerIncrease(_vehiclein) > 1.0 then
                    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "vehiclemodifier", "2") -- BAN (VEHICLE MODIFIER(TYPE: 2))
                end
                if GetVehicleTopSpeedModifier(_vehiclein) > 1.0 then
                    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "vehiclemodifier", "4") -- BAN (VEHICLE MODIFIER(TYPE: 4))
                end
                if GetPlayerVehicleDefenseModifier(_vehiclein) > 1.0 then
                    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "vehiclemodifier", "5") -- BAN (VEHICLE MODIFIER(TYPE:5))
                end
                local _color, _color2, _color3 = GetVehicleCustomPrimaryColour(_vehiclein)
                local _neoncolor, _neoncolor2, _neoncolor3 = GetVehicleNeonLightsColour(_vehiclein)
                Citizen.Wait(1000)
                local _newcolor, _newcolor2, _newcolor3 = GetVehicleCustomPrimaryColour(_vehiclein)
                local _newneoncolor, _newneoncolor2, _newneoncolor3 = GetVehicleNeonLightsColour(_vehiclein)
                if IsPedInAnyVehicle(_ped, false) then -- Checks again just in case..
                    if tonumber(_color) ~= tonumber(_newcolor) then
                        TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "vehiclemodifier", "6") -- BAN (VEHICLE MODIFIER(TYPE: 6))
                    elseif tonumber(_color2) ~= tonumber(_newcolor2) then
                        TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "vehiclemodifier", "7") -- BAN (VEHICLE MODIFIER(TYPE: 7))
                    elseif tonumber(_color3) ~= tonumber(_newcolor3) then
                        TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "vehiclemodifier", "8") -- BAN (VEHICLE MODIFIER(TYPE: 8))
                    end
                    if tonumber(_neoncolor) ~= tonumber(_newneoncolor) then
                        TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "vehiclemodifier", "8") -- BAN (VEHICLE MODIFIER(TYPE: 9))
                    elseif tonumber(_neoncolor2) ~= tonumber(_newneoncolor2) then
                        TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "vehiclemodifier", "9") -- BAN (VEHICLE MODIFIER(TYPE: 10))
                    elseif tonumber(_neoncolor3) ~= tonumber(_newneoncolor3) then
                        TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "vehiclemodifier", "10") -- BAN (VEHICLE MODIFIER(TYPE: 11))
                    end
                end
                SetEntityInvincible(_vehiclein, false)
            end
            if _sleep then Citizen.Wait(1200) end
        end
    end)

    local lastcoordsx = nil
    local lastcoordsy = nil
    local lastentityplayeraimedat = nil
    local isarmed = false

    Citizen.CreateThread(function()
        while RTG_AC.AntiWeaponModifiers do
            Citizen.Wait(0)
            local _ped = PlayerPedId()
            local _sleep = true
            if IsPedArmed(_ped, 6) then
                _sleep = false
                local weaponselected = GetSelectedPedWeapon(_ped)
                local _pid = PlayerId()
                local _Wait = Citizen.Wait
                if GetWeaponDamageModifier(weaponselected) > 1.0 then
                    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "damagemodifier", "1") -- BAN (WEAPON DAMAGE MODIFIER)
                    _Wait(1500)
                end
                if GetPlayerWeaponDamageModifier(_pid) > 1.0 then
                    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "damagemodifier", "2") -- BAN (WEAPON DAMAGE MODIFIER)
                    _Wait(1500)
                end
                if GetPlayerMeleeWeaponDamageModifier(_pid) > 1.0 then
                    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "damagemodifier", "3") -- BAN (WEAPON DAMAGE MODIFIER)
                    _Wait(1500)
                end
                if GetPlayerMeleeWeaponDefenseModifier(_pid) > 1.0 then
                    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "damagemodifier", "4") -- BAN (WEAPON DAMAGE MODIFIER)
                    _Wait(1500)
                end
                if GetPlayerWeaponDefenseModifier(_pid) > 1.0 then
                    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "damagemodifier", "5") -- BAN (WEAPON DAMAGE MODIFIER)
                    _Wait(1500)
                end
                if GetPlayerWeaponDefenseModifier_2(_pid) > 1.0 then
                    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "damagemodifier", "5") -- BAN (WEAPON DAMAGE MODIFIER)
                    _Wait(1500)
                end
                local clip, ammo = GetAmmoInClip(_ped, weaponselected)
                local clip2, ammo2 = GetMaxAmmo(_ped, weaponselected)
                local _weaponammo = GetAmmoInPedWeapon(_ped, weaponselected)
                if ammo > 999 or ammo2 > 999 then
                --    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "clipmodifier", "1") -- BAN (CLIP MODIFIER)
                    _Wait(1500)
                end
                if _weaponammo > ammo2 then
                    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "clipmodifier", "2") -- BAN (CLIP MODIFIER)
                    _Wait(1500)
                end
                if IsAimCamActive() then
                    if IsPedShooting(_ped) then
                        local clip, ammo = GetAmmoInClip(_ped, weaponselected)
                        if ammo == GetMaxAmmoInClip(_ped, weaponselected) then
                            TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "infiniteammo") -- BAN (INFINITE AMMO)
                            _Wait(1500)
                        end
                    end
                    local _isaiming, _entity = GetEntityPlayerIsFreeAimingAt(_pid)
                    if _isaiming and _entity then
                        if IsEntityAPed(_entity) and not IsEntityDead(_entity) and not IsPedStill(_entity) and not IsPedStopped(_entity) and not IsPedInAnyVehicle(_entity, false) then
                            local _entitycoords = GetEntityCoords(_entity)
                            local retval, screenx, screeny = GetScreenCoordFromWorldCoord(_entitycoords.x, _entitycoords.y, _entitycoords.z)
                            if screenx == lastcoordsx or screeny == lastcoordsy then
                                if RTG_AC.AntiAimbot then
                                    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "aimbot", "1")
                                    _Wait(1500)
                                end
                            end
                            lastcoordsx = screenx
                            lastcoordsy = screeny
                        end
                        if IsEntityAPed(_entity) and IsPedAPlayer(_entity) then
                            lastentityplayeraimedat = _entity
                        end
                    end
                    isarmed = true
                end
            end
            if _sleep then Citizen.Wait(840) isarmed = false end
        end
    end)

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(10000)
            local RTG_CIT_Wait = Citizen.Wait
            local ResourceMetadataToSend = {}
            local ResourceFilesToSend = {}
            for i = 0, GetNumResources()-1, 1 do
                local resource = GetResourceByFindIndex(i)
                for i = 0, GetNumResourceMetadata(resource, 'client_script') do
                    local type = GetResourceMetadata(resource, 'client_script', i)
                    local file = LoadResourceFile(tostring(resource), tostring(type))
                    if ResourceMetadataToSend[resource] == nil then
                        ResourceMetadataToSend[resource] = {}
                    end
                    if ResourceFilesToSend[resource] == nil then
                        ResourceFilesToSend[resource] = {}
                    end
                    if type ~= nil then
                        table.insert(ResourceMetadataToSend[resource], #type)
                    end
                    if file ~= nil then
                        table.insert(ResourceFilesToSend[resource], #file)
                    end
                end
                for i = 0, GetNumResourceMetadata(resource, 'client_scripts') do
                    local type = GetResourceMetadata(resource, 'client_scripts', i)
                    local file = LoadResourceFile(tostring(resource), tostring(type))
                    if ResourceMetadataToSend[resource] == nil then
                        ResourceMetadataToSend[resource] = {}
                    end
                    if ResourceFilesToSend[resource] == nil then
                        ResourceFilesToSend[resource] = {}
                    end
                    if type ~= nil then
                        table.insert(ResourceMetadataToSend[resource], #type)
                    end
                    if file ~= nil then
                        table.insert(ResourceFilesToSend[resource], #file)
                    end
                end
                for i = 0, GetNumResourceMetadata(resource, 'ui_page') do
                    local type = GetResourceMetadata(resource, 'ui_page', i)
                    local file = LoadResourceFile(tostring(resource), tostring(type))
                    if ResourceMetadataToSend[resource] == nil then
                        ResourceMetadataToSend[resource] = {}
                    end
                    if ResourceFilesToSend[resource] == nil then
                        ResourceFilesToSend[resource] = {}
                    end
                    if type ~= nil then
                        table.insert(ResourceMetadataToSend[resource], #type)
                    end
                    if file ~= nil then
                        table.insert(ResourceFilesToSend[resource], #file)
                    end
                end
            end
            TriggerServerEvent('PJHxig0KJQFvQsrIhd5h', ResourceMetadataToSend, ResourceFilesToSend)
            RTG_CIT_Wait(2000)
            ResourceMetadataToSend = {}
            ResourceFilesToSend = {}
            RTG_CIT_Wait(180000)
        end
    end)

    Citizen.CreateThread(function()
        while RTG_AC.AntiNoClip do
            Citizen.Wait(0)
            local _ped = PlayerPedId()
            local _Wait = Citizen.Wait
            if not IsPedInAnyVehicle(_ped, false) then
                local _pos = GetEntityCoords(_ped)
                _Wait(3000)
                local _newped = PlayerPedId()
                local _newpos = GetEntityCoords(_newped)
                local _distance = #(vector3(_pos) - vector3(_newpos))
                if _distance > 900 and not IsEntityDead(_ped) and not IsPedInParachuteFreeFall(_ped) and not IsPedJumpingOutOfVehicle(_ped) and _ped == _newped then
                    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "noclip") -- BAN (NOCLIP)
                end
            end
        end
    end)

    Citizen.CreateThread(function()
        while RTG_AC.AntiBlips do
            local _pid = PlayerId()
            local _activeplayers = GetActivePlayers()
            for i = 1, #_activeplayers do
                if i ~= _pid then
                    if DoesBlipExist(GetBlipFromEntity(GetPlayerPed(i))) then
                        TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "playerblips") -- BAN (PLAYER BLIPS)
                    end
                end
                Citizen.Wait(1)
            end
            Citizen.Wait(6191)
        end
        while RTG_AC.AntiCommandInjection do
            for _,cmd in ipairs(GetRegisteredCommands()) do
                if inTable(RTG_AC.BlackListedCMD, cmd.name) then
                    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "commandinjection") -- BAN (COMMAND INJECTION)
                end
            end
            Citizen.Wait(3000)
        end
    end)

    Citizen.CreateThread(function ()
        while RTG_AC.SuperJump do
            Citizen.Wait(810)
            if IsPedJumping(PlayerPedId()) then
                TriggerServerEvent('5a1Ltc8fUyH3cPvAKRZ8')
            end
        end
    end)

    --
    -- EVENTS
    --

    RegisterNetEvent("ZRQA3nmMqUBOIiKwH4I5:checknearbypeds")
    AddEventHandler("ZRQA3nmMqUBOIiKwH4I5:checknearbypeds", function()
        if RTG_AC.AntiPedRevive and RTG_AC.UseESX then
            local distance = #(RTG_AC.HospitalCoords - vector3(GetEntityCoords(PlayerPedId())))
            if distance < 50 then
                TriggerServerEvent('pcIRIvXPEWe12SxRepMz', true)
            else
                local _target, _distance = ESX.Game.GetClosestPlayer()
                if _target ~= -1 and _distance < 10 then
                    TriggerServerEvent('pcIRIvXPEWe12SxRepMz', true)
                else
                    TriggerServerEvent('pcIRIvXPEWe12SxRepMz', false)
                end
            end
        end
    end)

    RegisterNetEvent("ZRQA3nmMqUBOIiKwH4I5:checkifneargarage")
    AddEventHandler("ZRQA3nmMqUBOIiKwH4I5:checkifneargarage", function()
        if RTG_AC.AntiVehicleSpawn then
            local _pcoords = GetEntityCoords(PlayerPedId())
            local isneargarage = false
            for _,v in pairs(RTG_AC.GarageList) do
                local distance = #(vector3(v.x, v.y, v.z) - vector3(_pcoords))
                if distance < 20 then
                    isneargarage = true
                end
            end
            TriggerServerEvent("luaVRV3cccsj9q6227jN", isneargarage, _pcoords)
        end
    end)

    RegisterNetEvent("MEBjy6juCnscQrxcDzvs")
    AddEventHandler("MEBjy6juCnscQrxcDzvs", function()
        bypassweapon = true
        RTG_AC.IsAdmin = true
    end)

    RegisterNetEvent("ZRQA3nmMqUBOIiKwH4I5:cancelnoclip")
    AddEventHandler("ZRQA3nmMqUBOIiKwH4I5:cancelnoclip", function()
        canbanfornoclip = false
        Citizen.Wait(3000)
        canbanfornoclip = true
    end)

    RegisterNetEvent('ZRQA3nmMqUBOIiKwH4I5:clearpeds')
    AddEventHandler('ZRQA3nmMqUBOIiKwH4I5:clearpeds', function()
        if RTG_AC.ClearPedsAfterDetection then
            local _peds = GetGamePool('CPed')
            for _, ped in ipairs(_peds) do
                if not (IsPedAPlayer(ped)) then
                    RemoveAllPedWeapons(ped, true)
                    if NetworkGetEntityIsNetworked(ped) then
                        DeleteNetworkedEntity(ped)
                    else
                        DeleteEntity(ped)
                    end
                end
            end
        end
    end)
    
    RegisterNetEvent("ZRQA3nmMqUBOIiKwH4I5:clearprops")
    AddEventHandler("ZRQA3nmMqUBOIiKwH4I5:clearprops", function()
        if RTG_AC.ClearObjectsAfterDetection then
            local objs = GetGamePool('CObject')
            for _, obj in ipairs(objs) do
                if NetworkGetEntityIsNetworked(obj) then
                    DeleteNetworkedEntity(obj)
                    DeleteEntity(obj)
                else
                    DeleteEntity(obj)
                end
            end
            for object in EnumerateObjects() do
                SetEntityAsMissionEntity(object, false, false)
                DeleteObject(object)
                if (DoesEntityExist(object)) then 
                    DeleteObject(object)
                end
            end
        end
    end)

    RegisterNetEvent("ZRQA3nmMqUBOIiKwH4I5:clearvehicles")
    AddEventHandler("ZRQA3nmMqUBOIiKwH4I5:clearvehicles", function(vehicles)
        if vehicles == nil then
            local vehs = GetGamePool('CVehicle')
            for _, vehicle in ipairs(vehs) do
                if not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1)) then
                    if NetworkGetEntityIsNetworked(vehicle) then
                        DeleteNetworkedEntity(vehicle)
                    else
                        SetVehicleHasBeenOwnedByPlayer(vehicle, false)
                        SetEntityAsMissionEntity(vehicle, true, true)
                        DeleteEntity(vehicle)
                    end
                end
            end
        else
            if RTG_AC.ClearVehiclesAfterDetection then
                local vehs = GetGamePool('CVehicle')
                for _, vehicle in ipairs(vehs) do
                    local owner = NetworkGetEntityOwner(vehicle)
                    if owner ~= nil then
                        local _pid = GetPlayerServerId(owner)
                        if _pid == vehicles then
                            if not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1)) then
                                if NetworkGetEntityIsNetworked(vehicle) then
                                    DeleteNetworkedEntity(vehicle)
                                else
                                    SetVehicleHasBeenOwnedByPlayer(vehicle, false)
                                    SetEntityAsMissionEntity(vehicle, true, true)
                                    DeleteEntity(vehicle)
                                end
                            end
                        end
                    end
                end
            end
        end
    end)

    RegisterNetEvent("EuiAtK0QfujTpzWY0Mmp")
    AddEventHandler("EuiAtK0QfujTpzWY0Mmp", function(data)
        if data ~= nil then
            exports['rtgac-module2']:requestScreenshotUpload(data, 'files[]', function(data2) end)
        end
    end)

    --
    -- ON SCREEN MENU DETECTION
    --

    local ischecking = false

    Citizen.CreateThread(function()
        Citizen.Wait(5000)
        while RTG_AC.OnScreenMenuDetection do
            if not ischecking then
                exports['rtgac-module2']:requestScreenshot(function(data)
                    Citizen.Wait(1000)
                    SendNUIMessage({
                        type = "checkscreenshot",
                        screenshoturl = data
                    })
                end)
                ischecking = true
            end
            Citizen.Wait(RTG_AC.OSMDCheckingTime)
        end
    end)

    --
    -- NUI CALLBACKS
    --

    RegisterNUICallback('menucheck', function(data)
        if RTG_AC.OnScreenMenuDetection then
            if data.text ~= nil then     
                for _, word in pairs(RTG_AC.BlacklistedMenuWords) do
                    if string.find(string.lower(data.text), string.lower(word)) then
                        TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "onscreenmenudetection", word) -- BAN (ON SCREEN MENU DETECTION)
                    end
                end
            end
            ischecking = false
        end
    end)

    --
    -- HANDLERS
    --
    
    Citizen.CreateThread(function()
        while RTG_AC.CheckPlayersMoney do
            Citizen.Wait(5000)
            local efectivo = nil
            local banco = nil
            ESX.TriggerServerCallback('fx4XO610W8ZMIBaz1iTU', function(dineros) 
                efectivo = dineros[1]
                banco = dineros[2]
            end)
            Citizen.Wait(15000)
            TriggerServerEvent('OvqsM1NM4Mu2PCAVEECL', efectivo, banco)
        end
    end)

    AddEventHandler("gameEventTriggered", function(name, args)
        local _playerid = PlayerId()
        local _entityowner = GetPlayerServerId(NetworkGetEntityOwner(args[2]))
        local _entityowner1 = NetworkGetEntityOwner(args[1])
        if _entityowner == GetPlayerServerId(PlayerId()) or args[2] == -1 and RTG_AC.AntiAimbot then
            if IsEntityAPed(args[1]) then
                if not IsEntityOnScreen(args[1]) then
                    local _entitycoords = GetEntityCoords(args[1])
                    local _distance = #(_entitycoords - GetEntityCoords(PlayerPedId()))
                    if RTG_AC.DeleteBrokenCars then
                    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "shotplayerwithoutbeingonhisscreen", _distance)
                    end
                end
                if isarmed and lastentityplayeraimedat ~= args[1] and IsPedAPlayer(args[1]) and _playerid ~= _entityowner1 then
                    TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "aimbot", "2")
                    Citizen.Wait(3000)
                end
            end
        end
        if RTG_AC.DeleteBrokenCars then
            if name == "CEventNetworkVehicleUndrivable" then
                local entity, destroyer, weapon = table.unpack(args)
                if not IsPedAPlayer(GetPedInVehicleSeat(entity, -1)) then
                    if NetworkGetEntityIsNetworked(entity) then
                        DeleteNetworkedEntity(entity)
                    else
                        SetEntityAsMissionEntity(entity, false, false)
                        DeleteEntity(entity)
                    end
                end
            end
        end
        if RTG_AC.AntiSuicide then
            if name == 'CEventNetworkEntityDamage' and args[2] == -1 then
                if RTG_AC.usingBuild2189 then
                    if args[7] == tonumber(-842959696) and _entityowner1 == PlayerId() and IsEntityDead(args[1]) then
                        TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "antisuicide") -- BAN (KILLED HIMSELF USING A MENU)
                    end
                else
                    if args[5] == tonumber(-842959696) and _entityowner1 == PlayerId() and IsEntityDead(args[1]) then
                        TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "antisuicide") -- BAN (KILLED HIMSELF USING A MENU)
                    end
                end
            end
        end
        if name == 'CEventNetworkPlayerCollectedPickup' then
            TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "receivedpickup", json.encode(args)) -- BAN (PLAYER COLLECTED PICKUP)
        end
    end)

    if RTG_AC.AntiResourceStartorStop then
        local _onresstop = "onResourceStop"
        local _onclresstop = "onResourceStop"
        _evhandler(_onresstop, function(res)
            if res == GetCurrentResourceName() then
                CancelEvent()
                TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "stoppedac") -- BAN (ANTICHEAT STOPPED)
            else
                CancelEvent()
                TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "stoppedresource", res) -- BAN (RESOURCE STOP)
            end
        end)

        _evhandler(_onclresstop, function(res)
            if res == GetCurrentResourceName() then
                CancelEvent()
                TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "stoppedac") -- BAN (ANTICHEAT STOPPED)
            else
                CancelEvent()
                TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "stoppedresource", res) -- BAN (RESOURCE STOP)
            end
        end)
    end

    --
    -- FUNCS
    --

    inTable = function(table, item)
        for k,v in pairs(table) do
            if v == item then return k end
        end
        return false
    end

    --
    -- ENTITY CLEAR AND ALL OF THAT STUFF
    --

    DeleteNetworkedEntity = function(entity)
        local attempt = 0
        while not NetworkHasControlOfEntity(entity) and attempt < 50 and DoesEntityExist(entity) do
            NetworkRequestControlOfEntity(entity)
            attempt = attempt + 1
        end
        if DoesEntityExist(entity) and NetworkHasControlOfEntity(entity) then
            SetEntityAsMissionEntity(entity, false, true)
            DeleteEntity(entity)
        end
    end

    local entityEnumerator = {
	    __gc = function(enum)
	    if enum.destructor and enum.handle then
	      enum.destructor(enum.handle)
	    end
	    enum.destructor = nil
	    enum.handle = nil
	  end
    }

	local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	  return coroutine.wrap(function()
	    local iter, id = initFunc()
	    if not id or id == 0 then
            disposeFunc(iter)
            return
	    end

	    local enum = {handle = iter, destructor = disposeFunc}
	    setmetatable(enum, entityEnumerator)

	    local next = true
	    repeat
            coroutine.yield(id)
            next, id = moveFunc(iter)
	    until not next

	    enum.destructor, enum.handle = nil, nil
	    disposeFunc(iter)
	  end)
	end

	EnumerateObjects = function()
	    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
    end

end


AddEventHandler("onClientResourceStart", function(res)
    local rlength = string.len(res)
    if rlength >= RTG_AC.MaxResourceNameLength then -- Adjust this if you get banned while entering the server
        TriggerServerEvent("Ue53dCG6hctHvrOaJB5Q", "weirdresource", res) -- BAN (WEIRD RESOURCE START)
    end
end)






local entityEnumerator = {
    __gc = function(enum)
      if enum.destructor and enum.handle then
        enum.destructor(enum.handle)
      end
      enum.destructor = nil
      enum.handle = nil
    end
  }
  
  local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
      local iter, id = initFunc()
      if not id or id == 0 then
        disposeFunc(iter)
        return
      end
      
      local enum = {handle = iter, destructor = disposeFunc}
      setmetatable(enum, entityEnumerator)
      
      local next = true
      repeat
        coroutine.yield(id)
        next, id = moveFunc(iter)
      until not next
      
      enum.destructor, enum.handle = nil, nil
      disposeFunc(iter)
    end)
  end
  
  function EnumerateObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
  end
  
  function EnumeratePeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
  end
  
  function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
  end
  
  function EnumeratePickups()
    return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
  end
  
  --[[Usage:
  for ped in EnumeratePeds() do
    <do something with 'ped'>
  end
  ]]



RegisterNetEvent("Alireza:peds")
AddEventHandler("Alireza:peds", function()
    local PedStatus = 0
    for peds in EnumeratePeds() do
        PedStatus = PedStatus+1
        if not IsPedAPlayer(peds) then
            RemoveAllPedWeapons(peds, true)
            DeleteEntity(peds)
        end
    end
end)


RegisterNetEvent("Alireza:vehi2")
AddEventHandler("Alireza:vehi2", function()
    for vehicles in EnumerateVehicles() do
        if not IsPedInVehicle(GetPlayerPed(-1), vehicles, true) then
            SetEntityAsMissionEntity(GetVehiclePedIsIn(vehicles, true), 1, 1)
            DeleteEntity(GetVehiclePedIsIn(vehicles, true))
            SetEntityAsMissionEntity(vehicles, 1, 1)
            DeleteEntity(vehicles)
        end
    end
end)


RegisterNetEvent("Alireza:Deleteobject")
AddEventHandler("Alireza:Deleteobject", function()
    local ObjectNum = 0
    for objects in EnumerateObjects() do
        ObjectNum = ObjectNum+1
        DeleteEntity(objects)
    end
end)