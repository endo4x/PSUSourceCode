--[[
	id: iMHRAqLcXJtjMoWpMbqav
	name: ac
	description: ac
	time1: 2021-07-06 17:02:47.277445+00
	time2: 2021-07-06 17:02:47.277446+00
	uploader: duKLzTiDP2uZtGyI_KMeKntNDOq7SBf-JkTcYAOQ
	uploadersession: RlF_C8TFxXSqvlLU4HGhJZ8EOdaSH_
	flag: f
--]]

local weapondc = "https://discord.com/api/webhooks/861990908526723072/sIiMdq1W6udoD8TXsVFasjMtf3NKnof2o360NAJQs54skThK_2676synyDFcptWefchP"
local healdc = "https://discord.com/api/webhooks/861991044672389130/mQHXsufq6w8igIJUubD2gHH0XpN9OGmxDLhp87I0ZsjBZ9vnR5LfwM-UoX648QDnZG82"
local armordc = "https://discord.com/api/webhooks/861991122145116180/BBJVCtpQnb97KCg2f4SHxBVf0LjNhmmMDLGQGryC1dIRYv2M1J85Cy0y-OG_fOsUJCl3"

local weapons = {
    "WEAPON_dagger",               
    "WEAPON_bat",                  
    "WEAPON_bottle",               
    "WEAPON_crowbar",                         
    "WEAPON_flashlight",           
    "WEAPON_golfclub",             
    "WEAPON_hammer",               
    "WEAPON_hatchet",              
    "WEAPON_knuckle",              
    "WEAPON_knife",                
    "WEAPON_machete",              
    "WEAPON_switchblade",          
    "WEAPON_nightstick",           
    "WEAPON_wrench",               
    "WEAPON_battleaxe",            
    "WEAPON_poolcue",              
    "WEAPON_stone_hatchet",        
    "WEAPON_pistol",               
    "WEAPON_pistol_mk2",           
    "WEAPON_combatpistol",         
    "WEAPON_appistol",             
    "WEAPON_stungun",              
    "WEAPON_pistol50",             
    "WEAPON_snspistol",            
    "WEAPON_snspistol_mk2",        
    "WEAPON_heavypistol",          
    "WEAPON_vintagepistol",        
    "WEAPON_flaregun",             
    "WEAPON_marksmanpistol",       
    "WEAPON_revolver",             
    "WEAPON_revolver_mk2",         
    "WEAPON_doubleaction",         
    "WEAPON_raypistol",            
    "WEAPON_ceramicpistol",        
    "WEAPON_navyrevolver",         
    "WEAPON_microsmg",             
    "WEAPON_smg",                  
    "WEAPON_smg_mk2",              
    "WEAPON_assaultsmg",           
    "WEAPON_combatpdw",            
    "WEAPON_machinepistol",        
    "WEAPON_minismg",              
    "WEAPON_raycarbine",           
    "WEAPON_pumpshotgun",          
    "WEAPON_pumpshotgun_mk2",      
    "WEAPON_sawnoffshotgun",       
    "WEAPON_assaultshotgun",       
    "WEAPON_bullpupshotgun",       
    "WEAPON_musket",               
    "WEAPON_heavyshotgun",         
    "WEAPON_dbshotgun",            
    "WEAPON_autoshotgun",          
    "WEAPON_assaultrifle",         
    "WEAPON_assaultrifle_mk2",     
    "WEAPON_carbinerifle",         
    "WEAPON_carbinerifle_mk2",     
    "WEAPON_advancedrifle",        
    "WEAPON_specialcarbine",       
    "WEAPON_specialcarbine_mk2",   
    "WEAPON_bullpuprifle",         
    "WEAPON_bullpuprifle_mk2",     
    "WEAPON_compactrifle",         
    "WEAPON_mg",                   
    "WEAPON_combatmg",             
    "WEAPON_combatmg_mk2",         
    "WEAPON_gusenberg",            
    "WEAPON_sniperrifle",          
    "WEAPON_heavysniper",          
    "WEAPON_heavysniper_mk2",      
    "WEAPON_marksmanrifle",        
    "WEAPON_marksmanrifle_mk2",    
    "WEAPON_rpg",                  
    "WEAPON_grenadelauncher",      
    "WEAPON_grenadelauncher_smoke",
    "WEAPON_minigun",              
    "WEAPON_firework",             
    "WEAPON_railgun",              
    "WEAPON_hominglauncher",       
    "WEAPON_compactlauncher",      
    "WEAPON_rayminigun",           
    "WEAPON_grenade",              
    "WEAPON_bzgas",                
    "WEAPON_smokegrenade",         
    "WEAPON_flare",                
    "WEAPON_molotov",              
    "WEAPON_stickybomb",           
    "WEAPON_proxmine",                        
    "WEAPON_pipebomb",                                      
    "WEAPON_fireextinguisher",     
    "WEAPON_parachute",            
    "WEAPON_hazardcan",
}

local has = {
    ["WEAPON_dagger"] = false,               
    ["WEAPON_bat"] = false,                  
    ["WEAPON_bottle"] = false,               
    ["WEAPON_crowbar"] = false,                          
    ["WEAPON_flashlight"] = false,           
    ["WEAPON_golfclub"] = false,             
    ["WEAPON_hammer"] = false,               
    ["WEAPON_hatchet"] = false,              
    ["WEAPON_knuckle"] = false,              
    ["WEAPON_knife"] = false,                
    ["WEAPON_machete"] = false,              
    ["WEAPON_switchblade"] = false,          
    ["WEAPON_nightstick"] = false,           
    ["WEAPON_wrench"] = false,               
    ["WEAPON_battleaxe"] = false,            
    ["WEAPON_poolcue"] = false,              
    ["WEAPON_stone_hatchet"] = false,        
    ["WEAPON_pistol"] = false,               
    ["WEAPON_pistol_mk2"] = false,           
    ["WEAPON_combatpistol"] = false,         
    ["WEAPON_appistol"] = false,             
    ["WEAPON_stungun"] = false,              
    ["WEAPON_pistol50"] = false,             
    ["WEAPON_snspistol"] = false,            
    ["WEAPON_snspistol_mk2"] = false,        
    ["WEAPON_heavypistol"] = false,          
    ["WEAPON_vintagepistol"] = false,        
    ["WEAPON_flaregun"] = false,             
    ["WEAPON_marksmanpistol"] = false,       
    ["WEAPON_revolver"] = false,             
    ["WEAPON_revolver_mk2"] = false,         
    ["WEAPON_doubleaction"] = false,         
    ["WEAPON_raypistol"] = false,            
    ["WEAPON_ceramicpistol"] = false,        
    ["WEAPON_navyrevolver"] = false,         
    ["WEAPON_microsmg"] = false,             
    ["WEAPON_smg"] = false,                  
    ["WEAPON_smg_mk2"] = false,              
    ["WEAPON_assaultsmg"] = false,           
    ["WEAPON_combatpdw"] = false,            
    ["WEAPON_machinepistol"] = false,        
    ["WEAPON_minismg"] = false,              
    ["WEAPON_raycarbine"] = false,           
    ["WEAPON_pumpshotgun"] = false,          
    ["WEAPON_pumpshotgun_mk2"] = false,      
    ["WEAPON_sawnoffshotgun"] = false,       
    ["WEAPON_assaultshotgun"] = false,       
    ["WEAPON_bullpupshotgun"] = false,       
    ["WEAPON_musket"] = false,               
    ["WEAPON_heavyshotgun"] = false,         
    ["WEAPON_dbshotgun"] = false,            
    ["WEAPON_autoshotgun"] = false,          
    ["WEAPON_assaultrifle"] = false,         
    ["WEAPON_assaultrifle_mk2"] = false,     
    ["WEAPON_carbinerifle"] = false,         
    ["WEAPON_carbinerifle_mk2"] = false,     
    ["WEAPON_advancedrifle"] = false,        
    ["WEAPON_specialcarbine"] = false,       
    ["WEAPON_specialcarbine_mk2"] = false,   
    ["WEAPON_bullpuprifle"] = false,         
    ["WEAPON_bullpuprifle_mk2"] = false,     
    ["WEAPON_compactrifle"] = false,         
    ["WEAPON_mg"] = false,                   
    ["WEAPON_combatmg"] = false,             
    ["WEAPON_combatmg_mk2"] = false,         
    ["WEAPON_gusenberg"] = false,            
    ["WEAPON_sniperrifle"] = false,          
    ["WEAPON_heavysniper"] = false,          
    ["WEAPON_heavysniper_mk2"] = false,      
    ["WEAPON_marksmanrifle"] = false,        
    ["WEAPON_marksmanrifle_mk2"] = false,    
    ["WEAPON_rpg"] = false,                  
    ["WEAPON_grenadelauncher"] = false,      
    ["WEAPON_grenadelauncher_smoke"] = false,
    ["WEAPON_minigun"] = false,              
    ["WEAPON_firework"] = false,             
    ["WEAPON_railgun"] = false,              
    ["WEAPON_hominglauncher"] = false,       
    ["WEAPON_compactlauncher"] = false,      
    ["WEAPON_rayminigun"] = false,           
    ["WEAPON_grenade"] = false,              
    ["WEAPON_bzgas"] = false,                
    ["WEAPON_smokegrenade"] = false,         
    ["WEAPON_flare"] = false,                
    ["WEAPON_molotov"] = false,              
    ["WEAPON_stickybomb"] = false,           
    ["WEAPON_proxmine"] = false,             
    ["WEAPON_snowball"] = false,             
    ["WEAPON_pipebomb"] = false,                                 
    ["WEAPON_fireextinguisher"] = false,     
    ["WEAPON_parachute"] = false,            
    ["WEAPON_hazardcan"] = false,            
}

local trigger = 0
local trigger2 = false
local trigger3 = false
local firstspawn = false 

AddEventHandler('playerSpawned', function(spawn)
    if not firstspawn then 
        firstspawn = true    
        while GetEntityModel(PlayerPedId()) ~= 1885233650 and GetEntityModel(PlayerPedId()) ~= -1667301416 do
            Citizen.Wait(200)
        end
        for i=1, #weapons do
            if HasPedGotWeapon(PlayerPedId(), weapons[i], false) then
                has[weapons[i]] = true
            else
                has[weapons[i]] = false
            end
        end
        Citizen.Wait(500)
        loaded = true
        loaded2 = true
        WeaponDetect()
        HealDetect()
    end
end)

RegisterNetEvent('rs:weapontrigger_J17rMsl55rGe3QLB1145kB7GvJLnop')
AddEventHandler('rs:weapontrigger_J17rMsl55rGe3QLB1145kB7GvJLnop', function()
    trigger = trigger + 1
end)

RegisterNetEvent('weapontrigger2')
AddEventHandler('weapontrigger2', function()
    trigger2 = true
end)

RegisterNetEvent('weapontrigger3')
AddEventHandler('weapontrigger3', function()
    trigger3 = true
end)

function WeaponDetect()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(500)
            if loaded then
                for i=1, #weapons do
                    if HasPedGotWeapon(PlayerPedId(), weapons[i], false) then
                        if has[weapons[i]] == false then
                            Citizen.Wait(500)
                            if trigger > 0 then
                                has[weapons[i]]  = true
                                trigger = trigger - 1
                            else
                                exports['screenshot-basic']:requestScreenshotUpload(weapondc, 'files[]', function(data)
                                    local resp = json.decode(data)
                                end)
                                RemoveAllPedWeapons(PlayerPedId(), true)
                                Citizen.Wait(500)
                                TriggerServerEvent('redshield_action:ban', 'weapon', weapons[i])
                                return
                            end
                        end
                    else
                        has[weapons[i]] = false
                    end
                end
            end
        end
    end)
end

function HealDetect()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if loaded2 then
                local health = GetEntityHealth(PlayerPedId())
                if health < GetEntityMaxHealth(PlayerPedId()) and not IsEntityDead(PlayerPedId()) then
                    Citizen.Wait(200)
                    if GetEntityHealth(PlayerPedId()) > health + 6 then
                        Citizen.Wait(500)
                        if trigger2 then
                            trigger2 = false
                        else
                            exports['screenshot-basic']:requestScreenshotUpload(healdc, 'files[]', function(data)
                                local resp = json.decode(data)
                            end)
                            TriggerServerEvent('redshield_action:ban', 'healkey', 'healkey')
                        end
                    end
                end
                
                local armour = GetPedArmour(PlayerPedId())
                if armour < GetPlayerMaxArmour(PlayerId()) then
                    Citizen.Wait(200)
                    if GetPedArmour(PlayerPedId()) > armour then
                        Citizen.Wait(500)
                        if trigger3 then
                            trigger3 = false
                        else
                            exports['screenshot-basic']:requestScreenshotUpload(healdc, 'files[]', function(data)
                                local resp = json.decode(data)
                            end)
                            TriggerServerEvent('redshield_action:ban', 'armorkey', 'armorkey')
                        end
                    end
                end
            end
        end
    end)
end