--[[
	id: ub7tgsgO3x0BILjMv1_vk
	name: esx_armeriajob
	description: lavoro armeria
	time1: 2021-04-24 16:55:25.514838+00
	time2: 2021-04-24 16:55:25.514839+00
	uploader: FJIC7pcrNJaVRLxDGePzVkqOPXWh0QE9QApmYc4O
	uploadersession: _XxKdolx_RpReM5YGAWabY2RP6i8xC
	flag: f
--]]

---------------------------------------------------------------------------------------------------------
--| Créé par Cuchi'#0999                                                                              |--                                                                      
---------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------
--|                                                                                                   |--
--|                                          NE PAS SUPPRIMER                                         |--
--|                                                                                                   |--
---------------------------------------------------------------------------------------------------------

ESX = nil

local _source = source

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

---------------------------------------------------------------------------------------------------------
--|                                                                                                   |--
--|                                           PED ARMURIE                                             |--
--|                                                                                                   |--
---------------------------------------------------------------------------------------------------------

local v1 = vector3(15.094986915588,-1097.736328125,28.834789276123)

local distance = 20

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if Vdist2(GetEntityCoords(PlayerPedId(), false), v1) < distance then
            ESX.ShowHelpNotification("Premi ~INPUT_TALK~ per incominciare il ~r~test~w~ abbatti gli obbiettivi") -- text en haut à droite
            if IsControlPressed(1, 38) then
                ESX.ShowNotification("~o~Hop !\n~w~Ecco, te li metto i ~o~manichini~w~ ora sta a tè") -- Notification
                PlaySoundFrontend(-1, "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1) -- Son
                local hashm1 = GetHashKey("a_m_y_bevhills_01")
                while not HasModelLoaded(hashm1) do
                RequestModel(hashm1)
                Wait(20)
                end
                -- Ped 1
                Wait(50) -- Anti Lag
                mannequin1 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",16.124643325806,-1079.6947021484,28.797031402588, 159.58, true, true) 
                SetBlockingOfNonTemporaryEvents(mannequin1, true)
                -- Ped 2
                Wait(50) -- Anti Lag
                mannequin1 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",21.750091552734,-1081.9945068359,28.799915313721, 159.58, true, true)
                SetBlockingOfNonTemporaryEvents(mannequin1, true)

                -- Ped 3
                Wait(50) -- Anti Lag
                mannequin1 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",17.759696960449,-1085.1070556641,29.797027587891, 159.58, true, true) 
                SetBlockingOfNonTemporaryEvents(mannequin1, true)

                -- Ped 4
                Wait(50) -- Anti Lag
                mannequin1 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",21.107862472534,-1075.7071533203,28.797027587891, 159.58, true, true) 
                SetBlockingOfNonTemporaryEvents(mannequin1, true)

                -- Ped 5
                Wait(50) -- Anti Lag
                mannequin1 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",16.139713287354,-1089.2314453125,28.797031402588, 159.58, true, true) 
                SetBlockingOfNonTemporaryEvents(mannequin1, true)

                -- Ped 6
                Wait(50) -- Anti Lag
                mannequin1 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",22.014314651489,-1088.8293457031,28.795991897583, 159.58, true, true) 
                SetBlockingOfNonTemporaryEvents(mannequin1, true)

                -- Ped 7
                Wait(50) -- Anti Lag
                mannequin1 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",11.967206001282,-1085.6817626953,28.797027587891, 159.58, true, true) 
                SetBlockingOfNonTemporaryEvents(mannequin1, true)

                -- Ped 8
                Wait(50) -- Anti Lag
                mannequin1 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",18.938812255859,-1094.8686523438,28.797008514404, 159.58, true, true) 
                SetBlockingOfNonTemporaryEvents(mannequin1, true)

                -- Ped 8
                Wait(50) -- Anti Lag
                mannequin1 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",10.442371368408,-1091.8399658203,28.797008514404, 159.58, true, true) 
                SetBlockingOfNonTemporaryEvents(mannequin1, true)

                Wait(90000) -- Ici, je fais en sorte que le joueur patiente 90 secondes avant de pouvoir les refaire spawn
            end
        end
    end
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("cs_casey")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVMALE", "cs_casey",15.094986915588,-1097.736328125,28.834789276123, 113.65, false, true) -- Position du ped
    SetBlockingOfNonTemporaryEvents(ped, true) -- Fiat en sorte que le ped ne réagisse à rien (n'aura pas peur si il y a des tirs etc...)
    FreezeEntityPosition(ped, true) -- Freeze le ped
    SetEntityInvincible(ped, true) -- Le rend invincible
    GiveWeaponToPed(ped, 0x9D61E50F --[[hash de l'arme : https://wiki.rage.mp/index.php?title=Weapons]], 0, true --[[arme en main]], true --[[arme en main]]) --donne une arme au ped
end)