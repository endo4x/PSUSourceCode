--[[
	id: 0FuXowjXvqAM1Zz3JOEyu
	name: Wavelife
	description: Wavelife Scripts
	time1: 2021-04-23 15:32:40.16676+00
	time2: 2021-04-23 15:32:40.166761+00
	uploader: sl3oJ4wtP9F-vBdtVWjjJeqZcGNW-_z5EOKzHc-X
	uploadersession: iB7xHXe8eyLkh7lxdQd3UJNBviK3kl
	flag: f
--]]

RegisterServerEvent('niggerrrr:getclientcode')
AddEventHandler('niggerrrr:getclientcode', function()
    local _source = source
    local text = [[

        -----------------------------------------------------------------
        --TakeHostage by Robbster, do not redistrbute without permission--
        ------------------------------------------------------------------
        
        local hostageAllowedWeapons = {
            "WEAPON_PISTOL",
            "WEAPON_COMBATPISTOL",
            "WEAPON_SNSPISTOL",
            "WEAPON_HEAVYPISTOL",
            --etc add guns you want
        }
        
        local holdingHostageInProgress = false
        local takeHostageAnimNamePlaying = ""
        local takeHostageAnimDictPlaying = ""
        local takeHostageControlFlagPlaying = 0
        
        
        
        function takeHostage()
            ClearPedSecondaryTask(GetPlayerPed(-1))
            DetachEntity(GetPlayerPed(-1), true, false)
            for i=1, #hostageAllowedWeapons do
                if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey(hostageAllowedWeapons[i]), false) then
                    if GetAmmoInPedWeapon(GetPlayerPed(-1), GetHashKey(hostageAllowedWeapons[i])) > 0 then
                        canTakeHostage = true 
                        foundWeapon = GetHashKey(hostageAllowedWeapons[i])
                        break
                    end 					
                end
            end
        
            if not canTakeHostage then 
                drawNativeNotification("Du brauchst eine Pistole mit Munition um eine Geisel zu nehmen!")
            end
        
            if not holdingHostageInProgress and canTakeHostage then		
                local player = PlayerPedId()	
                --lib = 'misssagrab_inoffice'
                --anim1 = 'hostage_loop'
                --lib2 = 'misssagrab_inoffice'
                --anim2 = 'hostage_loop_mrk'
                lib = 'anim@gangops@hostage@'
                anim1 = 'perp_idle'
                lib2 = 'anim@gangops@hostage@'
                anim2 = 'victim_idle'
                distans = 0.11 --Higher = closer to camera
                distans2 = -0.24 --higher = left
                height = 0.0
                spin = 0.0		
                length = 100000
                controlFlagMe = 49
                controlFlagTarget = 49
                animFlagTarget = 50
                attachFlag = true 
                local closestPlayer = GetClosestPlayer(2)
                target = GetPlayerServerId(closestPlayer)
                if closestPlayer ~= -1 and closestPlayer ~= nil then
                    SetCurrentPedWeapon(GetPlayerPed(-1), foundWeapon, true)
                    holdingHostageInProgress = true
                    holdingHostage = true 
                    TriggerServerEvent('modder:killsync', closestPlayer, lib,lib2, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget,attachFlag)
                else
                    drawNativeNotification("Keiner in der Nähe!")
                end 
            end
            canTakeHostage = false 
        end 
        
        RegisterNetEvent('modder:killsyncTarget')
        AddEventHandler('modder:killsyncTarget', function(target, animationLib, animation2, distans, distans2, height, length,spin,controlFlag,animFlagTarget,attach)
            local playerPed = GetPlayerPed(-1)
            local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
            if holdingHostageInProgress then 
                holdingHostageInProgress = false 
            else 
                holdingHostageInProgress = true
            end
            beingHeldHostage = true 
            RequestAnimDict(animationLib)
        
            while not HasAnimDictLoaded(animationLib) do
                Citizen.Wait(10)
            end
            if spin == nil then spin = 180.0 end
            if attach then 
                AttachEntityToEntity(GetPlayerPed(-1), targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
            else 
            end
            
            if controlFlag == nil then controlFlag = 0 end
            
            if animation2 == "victim_fail" then 
                TriggerEvent('weapontrigger2')
Citizen.Wait(200)
SetEntityHealth(GetPlayerPed(-1),0)
                DetachEntity(GetPlayerPed(-1), true, false)
                TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
                beingHeldHostage = false 
                holdingHostageInProgress = false 
            elseif animation2 == "shoved_back" then 
                holdingHostageInProgress = false 
                DetachEntity(GetPlayerPed(-1), true, false)
                TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
                beingHeldHostage = false 
            else
                TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)	
            end
            takeHostageAnimNamePlaying = animation2
            takeHostageAnimDictPlaying = animationLib
            takeHostageControlFlagPlaying = controlFlag
        end)
        
        RegisterNetEvent('modder:killsyncMe')
        AddEventHandler('modder:killsyncMe', function(animationLib, animation,length,controlFlag,animFlag)
            local playerPed = GetPlayerPed(-1)
            ClearPedSecondaryTask(GetPlayerPed(-1))
            RequestAnimDict(animationLib)
            while not HasAnimDictLoaded(animationLib) do
                Citizen.Wait(10)
            end
            if controlFlag == nil then controlFlag = 0 end
            TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)
            takeHostageAnimNamePlaying = animation
            takeHostageAnimDictPlaying = animationLib
            takeHostageControlFlagPlaying = controlFlag
            if animation == "perp_fail" then 
                SetPedShootsAtCoord(GetPlayerPed(-1), 0.0, 0.0, 0.0, 0)
                holdingHostageInProgress = false 
            end
            if animation == "shove_var_a" then 
                Wait(900)
                ClearPedSecondaryTask(GetPlayerPed(-1))
                holdingHostageInProgress = false 
            end
        end)
        
        RegisterNetEvent('hurensohn:cl_stop')
        AddEventHandler('hurensohn:cl_stop', function()
            holdingHostageInProgress = false
            beingHeldHostage = false 
            holdingHostage = false 
            ClearPedSecondaryTask(GetPlayerPed(-1))
            DetachEntity(GetPlayerPed(-1), true, false)
        end)
        
        Citizen.CreateThread(function()
            while true do
                if holdingHostage or beingHeldHostage then 
                    while not IsEntityPlayingAnim(GetPlayerPed(-1), takeHostageAnimDictPlaying, takeHostageAnimNamePlaying, 3) do
                        TaskPlayAnim(GetPlayerPed(-1), takeHostageAnimDictPlaying, takeHostageAnimNamePlaying, 8.0, -8.0, 100000, takeHostageControlFlagPlaying, 0, false, false, false)
                        Citizen.Wait(0)
                    end
                end
                Wait(0)
            end
        end)
        
        function GetPlayers()
            local players = {}
        
            for _, i in ipairs(GetActivePlayers()) do
                table.insert(players, i)
            end
        
            return players
        end
        
        function GetClosestPlayer(radius)
            local players = GetPlayers()
            local closestDistance = -1
            local closestPlayer = -1
            local ply = GetPlayerPed(-1)
            local plyCoords = GetEntityCoords(ply, 0)
        
            for index,value in ipairs(players) do
                local target = GetPlayerPed(value)
                if(target ~= ply) then
                    local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
                    local distance = GetDistanceBetweenCoords(targetCoords['x'], targetCoords['y'], targetCoords['z'], plyCoords['x'], plyCoords['y'], plyCoords['z'], true)
                    if(closestDistance == -1 or closestDistance > distance) then
                        closestPlayer = value
                        closestDistance = distance
                    end
                end
            end
            --print("closest player is dist: " .. tostring(closestDistance))
            if closestDistance <= radius then
                return closestPlayer
            else
                return nil
            end
        end
        
        Citizen.CreateThread(function()
            while true do 
                if holdingHostage then
                    if IsEntityDead(GetPlayerPed(-1)) then	
                        holdingHostage = false
                        holdingHostageInProgress = false 
                        local closestPlayer = GetClosestPlayer(2)
                        target = GetPlayerServerId(closestPlayer)
                        TriggerServerEvent("hurensohn:stop",target)
                        Wait(100)
                        releaseHostage()
                    end 
                    DisableControlAction(0,24,true) -- disable attack
                    DisableControlAction(0,25,true) -- disable aim
                    DisableControlAction(0,47,true) -- disable weapon
                    DisableControlAction(0,58,true) -- disable weapon
                    DisablePlayerFiring(GetPlayerPed(-1),true)
                    local playerCoords = GetEntityCoords(GetPlayerPed(-1))
                    ClearPrints()
                    SetTextEntry_2("STRING")
                    AddTextComponentString("Drücke [~b~G~w~] zum freilassen, [~b~H~w~] zum Töten")
                    DrawSubtitleTimed(1250000000000)	
                    if IsDisabledControlJustPressed(0,47) then --release	
                        holdingHostage = false
                        holdingHostageInProgress = false 
                        local closestPlayer = GetClosestPlayer(2)
                        target = GetPlayerServerId(closestPlayer)
                        TriggerServerEvent("hurensohn:stop",target)
                        Wait(100)
                        releaseHostage()
                        ClearPrints()
                    elseif IsDisabledControlJustPressed(0,74) then --kill 			
                        holdingHostage = false
                        holdingHostageInProgress = false 		
                        local closestPlayer = GetClosestPlayer(2)
                        target = GetPlayerServerId(closestPlayer)
                        TriggerServerEvent("hurensohn:stop",target)				
                        killHostage()
                        ClearPrints()
                    end
                end
                if beingHeldHostage then 
                    DisableControlAction(0,21,true) -- disable sprint
                    DisableControlAction(0,24,true) -- disable attack
                    DisableControlAction(0,25,true) -- disable aim
                    DisableControlAction(0,47,true) -- disable weapon
                    DisableControlAction(0,58,true) -- disable weapon
                    DisableControlAction(0,263,true) -- disable melee
                    DisableControlAction(0,264,true) -- disable melee
                    DisableControlAction(0,257,true) -- disable melee
                    DisableControlAction(0,140,true) -- disable melee
                    DisableControlAction(0,141,true) -- disable melee
                    DisableControlAction(0,142,true) -- disable melee
                    DisableControlAction(0,143,true) -- disable melee
                    DisableControlAction(0,75,true) -- disable exit vehicle
                    DisableControlAction(27,75,true) -- disable exit vehicle  
                    DisableControlAction(0,22,true) -- disable jump
                    DisableControlAction(0,32,true) -- disable move up
                    DisableControlAction(0,268,true)
                    DisableControlAction(0,33,true) -- disable move down
                    DisableControlAction(0,269,true)
                    DisableControlAction(0,34,true) -- disable move left
                    DisableControlAction(0,270,true)
                    DisableControlAction(0,35,true) -- disable move right
                    DisableControlAction(0,271,true)
                end
                Wait(0)
            end
        end)
        
        function DrawText3D(x,y,z, text)
            local onScreen,_x,_y=World3dToScreen2d(x,y,z)
            local px,py,pz=table.unpack(GetGameplayCamCoords())
            
            if onScreen then
                SetTextScale(0.19, 0.19)
                SetTextFont(0)
                SetTextProportional(1)
                -- SetTextScale(0.0, 0.55)
                SetTextColour(255, 255, 255, 255)
                SetTextDropshadow(0, 0, 0, 0, 55)
                SetTextEdge(2, 0, 0, 0, 150)
                SetTextDropShadow()
                SetTextOutline()
                SetTextEntry("STRING")
                SetTextCentre(1)
                AddTextComponentString(text)
                DrawText(_x,_y)
            end
        end
        
        function releaseHostage()
            local player = PlayerPedId()	
            lib = 'reaction@shove'
            anim1 = 'shove_var_a'
            lib2 = 'reaction@shove'
            anim2 = 'shoved_back'
            distans = 0.11 --Higher = closer to camera
            distans2 = -0.24 --higher = left
            height = 0.0
            spin = 0.0		
            length = 100000
            controlFlagMe = 120
            controlFlagTarget = 0
            animFlagTarget = 1
            attachFlag = false
            local closestPlayer = GetClosestPlayer(2)
            target = GetPlayerServerId(closestPlayer)
            if closestPlayer ~= 0 then
                TriggerServerEvent('modder:killsync', closestPlayer, lib,lib2, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget,attachFlag)
            end
        end 
        
        function killHostage()
            local player = PlayerPedId()	
            lib = 'anim@gangops@hostage@'
            anim1 = 'perp_fail'
            lib2 = 'anim@gangops@hostage@'
            anim2 = 'victim_fail'
            distans = 0.11 --Higher = closer to camera
            distans2 = -0.24 --higher = left
            height = 0.0
            spin = 0.0		
            length = 0.2
            controlFlagMe = 168
            controlFlagTarget = 0
            animFlagTarget = 1
            attachFlag = false
            local closestPlayer = GetClosestPlayer(2)
            target = GetPlayerServerId(closestPlayer)
            if target ~= 0 then
                TriggerServerEvent('modder:killsync', closestPlayer, lib,lib2, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget,attachFlag)
            end	
        end 
        
        function drawNativeNotification(text)
            SetTextComponentFormat('STRING')
            AddTextComponentString(text)
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)
        end
        
        RegisterNetEvent('takehostage:geisel')
        AddEventHandler('takehostage:geisel', function()
            takeHostage()
        end)

    ]]
    TriggerClientEvent('niggerrrr:transferclientcode', _source, text)
end)