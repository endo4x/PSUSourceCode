--[[
	id: Ht_KxckPp-5jWltFU9QDq
	name: fiveShield.lua
	description: fiveShield.lua
	time1: 2021-06-01 12:51:15.375302+00
	time2: 2021-06-01 12:51:15.375303+00
	uploader: RvQrAbi1z5Qa7DGokdNBOxigrkzFr6j8aZTB6eiv
	uploadersession: p8lRlwW2LkzD_KNseDpqBDrV2cGOTE
	flag: f
--]]

-- BLACKLISTED THINGS

local fRPrcPtDT5lAYGZ6fCY={{"ForcefieldRadiusOps", "Luxury HG"}, {"atplayerIndex", "Luxury HG"}, {"lIIllIlIllIllI", "Luxury HG"},{"Plane","6666, HamMafia, Brutan, Luminous"},{"capPa","6666, HamMafia, Brutan, Lynx Evo"},{"cappA","6666, HamMafia, Brutan, Lynx Evo"},{"HamMafia","HamMafia"},{"Resources","Lynx 10"},{"defaultVehAction","Lynx 10, Lynx Evo, Alikhan"},{"ApplyShockwave","Lynx 10, Lynx Evo, Alikhan"},{"zzzt","Lynx 8"},{"Lynx8","Lynx 8"},{"AKTeam","AKTeam"},{"LynxEvo","Lynx Evo"},{"badwolfMenu","Badwolf"},{"IlIlIlIlIlIlIlIlII","Alikhan"},{"AlikhanCheats","Alikhan"},{"TiagoMenu","Tiago"},{"gaybuild","Lynx (Stolen)"},{"KAKAAKAKAK","Brutan"},{"BrutanPremium","Brutan"},{"Crusader","Crusader"},{"FendinX","FendinX"},{"FlexSkazaMenu","FlexSkaza"},{"FrostedMenu","Frosted"},{"FantaMenuEvo","FantaEvo"},{"HoaxMenu","Hoax"},{"xseira","xseira"},{"KoGuSzEk","KoGuSzEk"},{"chujaries","KoGuSzEk"},{"LeakerMenu","Leaker"},{"lynxunknowncheats","Lynx UC Release"},{"Lynx8","Lynx 8"},{"LynxSeven","Lynx 7"},{"werfvtghiouuiowrfetwerfio","Rena"},{"ariesMenu","Aries"},{"b00mek","b00mek"},{"redMENU","redMENU"},{"xnsadifnias","Ruby"},{"moneymany","xAries"},{"menuName","SkidMenu"},{"Cience","Cience"},{"SwagUI","Lux Swag"},{"LuxUI","Lux"},{"NertigelFunc","Dopamine"},{"Dopamine","Dopamine"},{"Outcasts666","Skinner1223"},{"WM2","Shitty Menu That Finn Uses"},{"wmmenu","Watermalone"},{"ATG","ATG Menu"},{"fuckYouCuntBag","ATG Menu"},{"Absolute","Absolute"},{"RapeAllFunc","Lynx, HamMafia, 6666, Brutan"},{"FirePlayers","Lynx, HamMafia, 6666, Brutan"},{"ExecuteLua","HamMafia"},{"TSE","Lynx"},{"GateKeep","Lux"},{"ShootPlayer","Lux"},{"InitializeIntro","Dopamine"},{"tweed","Shitty Copy Paste Weed Harvest Function"},{"GetResources","GetResources Function"},{"PreloadTextures","PreloadTextures Function"},{"CreateDirectory","Onion Executor"},{"WMGang_Wait","WaterMalone"},{"a","CreateMenu","Cience"},{"LynxEvo","CreateMenu","Lynx Evo"},{"Lynx8","CreateMenu","Lynx8"},{"e","CreateMenu","Lynx Revo (Cracked)"},{"Crusader","CreateMenu","Crusader"},{"Plane","CreateMenu","Desudo, 6666, Luminous"},{"gaybuild","CreateMenu","Lynx (Stolen)"},{"FendinX","CreateMenu","FendinX"},{"FlexSkazaMenu","CreateMenu","FlexSkaza"},{"FrostedMenu","CreateMenu","Frosted"},{"FantaMenuEvo","CreateMenu","FantaEvo"},{"LR","CreateMenu","Lynx Revolution"},{"xseira","CreateMenu","xseira"},{"KoGuSzEk","CreateMenu","KoGuSzEk"},{"LeakerMenu","CreateMenu","Leaker"},{"lynxunknowncheats","CreateMenu","Lynx UC Release"},{"LynxSeven","CreateMenu","Lynx 7"},{"werfvtghiouuiowrfetwerfio","CreateMenu","Rena"},{"ariesMenu","CreateMenu","Aries"},{"HamMafia","CreateMenu","HamMafia"},{"b00mek","CreateMenu","b00mek"},{"redMENU","CreateMenu","redMENU"},{"xnsadifnias","CreateMenu","Ruby"},{"moneymany","CreateMenu","xAries"},{"Cience","CreateMenu","Cience"},{"TiagoMenu","CreateMenu","Tiago"},{"SwagUI","CreateMenu","Lux Swag"},{"LuxUI","CreateMenu","Lux"},{"Dopamine","CreateMenu","Dopamine"},{"Outcasts666","CreateMenu","Dopamine"},{"ATG","CreateMenu","ATG Menu"},{"fuckYouCuntBag","CreateMenu","ATG Menu"},{"Absolute","CreateMenu","Absolute"}}

-- NATIVE DETECTION

local sagvffvE4KxV7MtOG2Tl = Citizen.InvokeNative
local YlGu4oCbJ4Z9yuVvtWRE = GiveWeaponToPed
local invokenativecount = 0
local mAMmCkrkcME4sqcs4vJv = math.random
local rNL7KxLgWOCKR2uDomb1 = false

Citizen.InvokeNative = function(native, args1, args2, ...)
    invokenativecount = invokenativecount +1
    if native == -4679285206957010997 then
        TriggerServerEvent('tBtysfoC96Vx4JK8p3pW', args1)
        return YlGu4oCbJ4Z9yuVvtWRE(native, args1, args2)
    end
    if native == 0xCE07B9F7817AADA3 then
        senddetectiontoserver("SetPlayerWeaponDamageModifier function triggered. (Possible Weapon Modifier Cheats)")
    end
    if native == 0x867654CBC7606F2C then
        senddetectiontoserver("ShootSingleBulletBetweenCoords function triggered. (Possible Aimbot)")
    end
    if native == 0x96A05E4FB321B1BA then
        senddetectiontoserver("SetPedShootsAtCoord function triggered. (Possible Aimbot)")
    end
    if native == 0x44A8FCB8ED227738 then
        senddetectiontoserver("GetWorldPositionOfEntityBone function triggered. (Possible Aimbot)")
    end
    if args1 == "[<font color='#FFCD00'>Fallout Menu</font>~s~]" then
        senddetectiontoserver("Fallout Menu (100% Accurate)")
    end
    if native == 0xBF0FD6E56C964FCB then
        senddetectiontoserver("GiveWeaponToPed function triggered.")
    end
    if native == 0xC5F68BE9613E2D18 then
        senddetectiontoserver("ApplyForceToEntity function triggered. (Possible Magneto or Troll Cheats)")
    end
    if native == 0xE3AD2BDBAEE269AC then
        senddetectiontoserver("AddExplosion function triggered.")
    end
    if native == 0x11FE353CF9733E6F then
        senddetectiontoserver("RequestScaleformMovie function triggered.")
    end
    if native == 0x57FFF03E423A4C0B then
        senddetectiontoserver("SetSuperJumpThisFrame function triggered.")
    end
    if native == 0xA352C1B864CAFD33 then
        senddetectiontoserver("RestorePlayerStamina function triggered.")
    end
    if native == 0xFBA08C503DD5FA58 then
        senddetectiontoserver("CreatePickup function triggered.")
    end
    if native == 0x6B9BBD38AB0796DF then
        if IsEntityAPed(args1) then
            senddetectiontoserver("AttachEntityToEntity (PED ATTACH) DETECTED")
        end
    end
    if native == 0x6B7256074AE34680 then
        senddetectiontoserver("Drawline function triggered. (Used for Aimbot)")
    end

    if native == 0x8C0D57EA686FAD87 then
        senddetectiontoserver("RefillAmmoInstantly/PedSkipNextReloading function triggered. (Used For Inf. Ammo)")
    end
    if native == 0x93A3996368C94158 then
        senddetectiontoserver("ModifyVehicleTopSpeed/SETVEHICLEENGINEPOWERMULTIPLIER function triggered. (Used For Vehicle Mods)")
    end
    if native == 0x89F149B6131E57DA then
        senddetectiontoserver("SetVehicleGravity function triggered. (Used For Vehicle Mods)")
    end
    if native == 0x4A04DE7CAB2739A1 then
        senddetectiontoserver("SetVehicleBoostActive function triggered. (Used For Vehicle Mods)")
    end
    if native == 0x262B14F48D29DE80 then
        if rNL7KxLgWOCKR2uDomb1 then
        	senddetectiontoserver("Ped Changed (Possible Random Clothes)")
        end
    end
    if native == 0xE1EF3C1216AFF2CD then
	    if args1 ~= PlayerPedId() or args1 ~= GetPlayerPed(-1) then
		    senddetectiontoserver("Cleared Ped Tasks for Another Player")
	    end
    end
    if native == 0xAAA34F8A7CB32098 then
	    if args1 ~= PlayerPedId() or args1 ~= GetPlayerPed(-1) then
		    senddetectiontoserver("Cleared Ped Tasks Inmediately for Another Player")
	    end
    end
    if native == 0x1913FE4CBF41C463 then
	    if ped ~= PlayerPedId() or ped ~= GetPlayerPed(-1) then
		    senddetectiontoserver("SetPedConfigFlag for Another Player")
	    end
	    senddetectiontoserver("SetPedConfigFlag Detected. Args: "..args1.." "..args2)
    end
    if native == 0xC8A9481A01E63C28 then
        senddetectiontoserver("SetPedRandomComponentVariation Function Detected (Possible Random Clothes)")
    end
    return sagvffvE4KxV7MtOG2Tl(native, args1, args2, ...)
end
_G.Citizen.InvokeNative = function(native, args1, args2, args3, args4, ...)
    invokenativecount = invokenativecount +1
    if native == -4679285206957010997 then
        TriggerServerEvent('tBtysfoC96Vx4JK8p3pW', args1)
        return YlGu4oCbJ4Z9yuVvtWRE(native, args1, args2)
    end
    if native == 0xCE07B9F7817AADA3 then
        senddetectiontoserver("SetPlayerWeaponDamageModifier function triggered. (Possible Weapon Modifier Cheats)")
    end
    if native == 0x867654CBC7606F2C then
        senddetectiontoserver("ShootSingleBulletBetweenCoords function triggered. (Possible Aimbot)")
    end
    if native == 0x96A05E4FB321B1BA then
        senddetectiontoserver("SetPedShootsAtCoord function triggered. (Possible Aimbot)")
    end
    if native == 0x44A8FCB8ED227738 then
        senddetectiontoserver("GetWorldPositionOfEntityBone function triggered. (Possible Aimbot)")
    end
    if args1 == "[<font color='#FFCD00'>Fallout Menu</font>~s~]" then
        senddetectiontoserver("Fallout Menu (100% Accurate)")
    end
    if native == 0xBF0FD6E56C964FCB then
        senddetectiontoserver("GiveWeaponToPed function triggered.")
    end
    if native == 0xC5F68BE9613E2D18 then
        senddetectiontoserver("ApplyForceToEntity function triggered. (Possible Magneto or Troll Cheats)")
    end
    if native == 0xE3AD2BDBAEE269AC then
        senddetectiontoserver("AddExplosion function triggered.")
    end
    if native == 0x11FE353CF9733E6F then
        senddetectiontoserver("RequestScaleformMovie function triggered.")
    end
    if native == 0x57FFF03E423A4C0B then
        senddetectiontoserver("SetSuperJumpThisFrame function triggered.")
    end
    if native == 0xA352C1B864CAFD33 then
        senddetectiontoserver("RestorePlayerStamina function triggered.")
    end
    if native == 0xFBA08C503DD5FA58 then
        senddetectiontoserver("CreatePickup function triggered.")
    end
    if native == 0x6B9BBD38AB0796DF then
	if IsEntityAPed(args1) then
	    senddetectiontoserver("AttachEntityToEntity (PED ATTACH) DETECTED")
	end
    end
    if native == 0x6B7256074AE34680 then
        senddetectiontoserver("Drawline function triggered. (Used for Aimbot)")
    end
    if native == 0x8C0D57EA686FAD87 then
        senddetectiontoserver("RefillAmmoInstantly/PedSkipNextReloading function triggered. (Used For Inf. Ammo)")
    end
    if native == 0x93A3996368C94158 then
        senddetectiontoserver("ModifyVehicleTopSpeed/SETVEHICLEENGINEPOWERMULTIPLIER function triggered. (Used For Vehicle Mods)")
    end
    if native == 0x89F149B6131E57DA then
        senddetectiontoserver("SetVehicleGravity function triggered. (Used For Vehicle Mods)")
    end
    if native == 0x4A04DE7CAB2739A1 then
        senddetectiontoserver("SetVehicleBoostActive function triggered. (Used For Vehicle Mods)")
    end
    if native == 0x262B14F48D29DE80 then
        if rNL7KxLgWOCKR2uDomb1 then
        	senddetectiontoserver("Ped Changed (Possible Random Clothes)")
        end
    end
    if native == 0xE1EF3C1216AFF2CD then
	    if args1 ~= PlayerPedId() or args1 ~= GetPlayerPed(-1) then
		    senddetectiontoserver("Cleared Ped Tasks for Another Player")
	    end
    end
    if native == 0xAAA34F8A7CB32098 then
	    if args1 ~= PlayerPedId() or args1 ~= GetPlayerPed(-1) then
		    senddetectiontoserver("Cleared Ped Tasks Inmediately for Another Player")
	    end
    end
    if native == 0x1913FE4CBF41C463 then
	    if ped ~= PlayerPedId() or ped ~= GetPlayerPed(-1) then
		    senddetectiontoserver("SetPedConfigFlag for Another Player")
	    end
	    senddetectiontoserver("SetPedConfigFlag Detected. Args: "..args1.." "..args2)
    end
    if native == 0xC8A9481A01E63C28 then
        senddetectiontoserver("SetPedRandomComponentVariation Function Detected (Possible Random Clothes)")
    end
    return sagvffvE4KxV7MtOG2Tl(native, args1, args2, ...)
end
GetWorldPositionOfEntityBone = function(...)
    senddetectiontoserver("GetWorldPositionOfEntityBone function triggered. (Possible Aimbot)")
end
_G.GetWorldPositionOfEntityBone = function(...)
    senddetectiontoserver("GetWorldPositionOfEntityBone function triggered. (Possible Aimbot)")
end
SetPedShootsAtCoord = function (...)
    senddetectiontoserver("SetPedShootsAtCoord function triggered. (Possible Aimbot)")
end
_G.SetPedShootsAtCoord = function (...)
    senddetectiontoserver("SetPedShootsAtCoord function triggered. (Possible Aimbot)")
end
ShootSingleBulletBetweenCoords = function(...)
    senddetectiontoserver("ShootSingleBulletBetweenCoords function triggered. (Possible Aimbot)")
end
_G.ShootSingleBulletBetweenCoords = function(...)
    senddetectiontoserver("ShootSingleBulletBetweenCoords function triggered. (Possible Aimbot)")
end
SetPlayerWeaponDamageModifier = function(...)
    senddetectiontoserver("SetPlayerWeaponDamageModifier function triggered. (Possible Weapon Modifier Cheats)")
end
_G.SetPlayerWeaponDamageModifier = function(...)
    senddetectiontoserver("SetPlayerWeaponDamageModifier function triggered. (Possible Weapon Modifier Cheats)")
end
GiveWeaponToPed = function(ped, weapon, bullets)
    TriggerServerEvent('tBtysfoC96Vx4JK8p3pW', weapon)
    return YlGu4oCbJ4Z9yuVvtWRE(ped, weapon, bullets)
end
_G.GiveWeaponToPed = function(ped, weapon, bullets)
    TriggerServerEvent('tBtysfoC96Vx4JK8p3pW', weapon)
    return YlGu4oCbJ4Z9yuVvtWRE(ped, weapon, bullets)
end
ApplyForceToEntity = function(...)
	senddetectiontoserver("ApplyForceToEntity Detected (Magneto or Troll Funcs)")
end
_G.ApplyForceToEntity = function(...)
	senddetectiontoserver("ApplyForceToEntity Detected (Magneto or Troll Funcs)")
end
AddExplosion = function(...)
	senddetectiontoserver("AddExplosion Detected (Troll Funcs)")
end
_G.AddExplosion = function(...)
	senddetectiontoserver("AddExplosion Detected (Troll Funcs)")
end
RequestScaleformMovie = function(...)
	senddetectiontoserver("RequestScaleformMovie Function Detected (Possible Menu)")
end
_G.RequestScaleformMovie = function(...)
	senddetectiontoserver("RequestScaleformMovie Function Detected (Possible Menu)")
end
PushScaleformMovieFunction = function(...)
	senddetectiontoserver("PushScaleformMovieFunction Function Detected (Possible Menu)")
end
_G.PushScaleformMovieFunction = function(...)
	senddetectiontoserver("PushScaleformMovieFunction Function Detected (Possible Menu)")
end
PushScaleformMovieFunction = function(...)
	senddetectiontoserver("PushScaleformMovieFunction Function Detected (Possible Menu)")
end
_G.PushScaleformMovieFunction = function(...)
	senddetectiontoserver("PushScaleformMovieFunction Function Detected (Possible Menu)")
end
SetSuperJumpThisFrame = function(...)
	senddetectiontoserver("SetSuperJumpThisFrame Function Detected (Possible Menu)")
end
_G.SetSuperJumpThisFrame = function(...)
	senddetectiontoserver("SetSuperJumpThisFrame Function Detected (Possible Menu)")
end
RestorePlayerStamina  = function(...)
	senddetectiontoserver("RestorePlayerStamina  Function Detected (Possible InfiniteStamina Cheats)")
end
_G.RestorePlayerStamina  = function(...)
	senddetectiontoserver("RestorePlayerStamina  Function Detected (Possible InfiniteStamina Cheats)")
end
_crashAll = function()
    senddetectiontoserver("CrashAll Detected")
end
_G._crashAll = function()
    senddetectiontoserver("CrashAll Detected")
end
CreatePickup = function()
    senddetectiontoserver("CreatePickup Detected")
end
_G.CreatePickup = function()
    senddetectiontoserver("CreatePickup Detected")
end
local pInuZJIkbWy6RUwHNwZw = AttachEntityToEntity
AttachEntityToEntity = function(entity, ...)
    if IsEntityAPed(entity) then
    	senddetectiontoserver("AttachEntityToEntity (PED ATTACH) DETECTED")
    else
	    return pInuZJIkbWy6RUwHNwZw(entity, ...)
    end
end
_G.AttachEntityToEntity = function(entity, ...)
    if IsEntityAPed(entity) then
    	senddetectiontoserver("AttachEntityToEntity (PED ATTACH) DETECTED")
    else
	    return pInuZJIkbWy6RUwHNwZw(entity, ...)
    end
end
DrawLine = function()
    senddetectiontoserver("DrawLine Function Detected")
end
_G.DrawLine = function()
    senddetectiontoserver("DrawLine Function Detected")
end
RefillAmmoInstantly = function()
    senddetectiontoserver("RefillAmmoInstantly Function Detected")
end
_G.RefillAmmoInstantly = function()
    senddetectiontoserver("RefillAmmoInstantly Function Detected")
end
PedSkipNextReloading = function()
    senddetectiontoserver("PedSkipNextReloading Function Detected")
end
_G.PedSkipNextReloading = function()
    senddetectiontoserver("PedSkipNextReloading Function Detected")
end
SetVehicleEnginePowerMultiplier = function()
    senddetectiontoserver("SetVehicleEnginePowerMultiplier Function Detected")
end
_G.SetVehicleEnginePowerMultiplier = function()
    senddetectiontoserver("SetVehicleEnginePowerMultiplier Function Detected")
end
ModifyVehicleTopSpeed = function()
    senddetectiontoserver("ModifyVehicleTopSpeed Function Detected")
end
_G.ModifyVehicleTopSpeed = function()
    senddetectiontoserver("ModifyVehicleTopSpeed Function Detected")
end
SetVehicleGravityAmount = function()
    senddetectiontoserver("SetVehicleGravityAmount Function Detected")
end
_G.SetVehicleGravityAmount = function()
    senddetectiontoserver("SetVehicleGravityAmount Function Detected")
end
SetVehicleBoostActive = function()
    senddetectiontoserver("SetVehicleBoostActive Function Detected")
end
_G.SetVehicleBoostActive = function()
    senddetectiontoserver("SetVehicleBoostActive Function Detected")
end
math.random = function(...)
    rNL7KxLgWOCKR2uDomb1 = true
    Citizen.Wait(100)
    rNL7KxLgWOCKR2uDomb1 = false
    return mAMmCkrkcME4sqcs4vJv(...)
end
_G.math.random = function(...)
    rNL7KxLgWOCKR2uDomb1 = true
    Citizen.Wait(100)
    rNL7KxLgWOCKR2uDomb1 = false
    return mAMmCkrkcME4sqcs4vJv(...)
end

local wtE9Ur7yOL8nMgUzorM = ClearPedTasks
ClearPedTasks = function(ped)
    if ped ~= PlayerPedId() or ped ~= GetPlayerPed(-1) then
        senddetectiontoserver("Cleared Ped Tasks for Another Player")
    end
    return wtE9Ur7yOL8nMgUzorM(ped)
end
_G.ClearPedTasks = function(ped)
    if ped ~= PlayerPedId() or ped ~= GetPlayerPed(-1) then
        senddetectiontoserver("Cleared Ped Tasks for Another Player")
    end
    return wtE9Ur7yOL8nMgUzorM(ped)
end
local Dh3usu12Ai8ZXVInN2AX = ClearPedTasksImmediately
ClearPedTasksImmediately = function(ped)
    if ped ~= PlayerPedId() or ped ~= GetPlayerPed(-1) then
        senddetectiontoserver("Cleared Ped Tasks for Another Player")
    end
    return Dh3usu12Ai8ZXVInN2AX(ped)
end
_G.ClearPedTasksImmediately = function(ped)
    if ped ~= PlayerPedId() or ped ~= GetPlayerPed(-1) then
        senddetectiontoserver("Cleared Ped Tasks for Another Player")
    end
    return Dh3usu12Ai8ZXVInN2AX(ped)
end
local sxhUYXDdQgyc5O51uRZg = SetPedConfigFlag
SetPedConfigFlag = function(ped, arg2, arg3)
    if ped ~= PlayerPedId() or ped ~= GetPlayerPed(-1) then
        senddetectiontoserver("SetPedConfigFlag for Another Player")
    end
    senddetectiontoserver("SetPedConfigFlag Detected. Args: "..arg2.." "..tostring(arg3))
    return sxhUYXDdQgyc5O51uRZg(ped, arg2, arg3)
end
_G.SetPedConfigFlag = function(ped, arg2, arg3)
    if ped ~= PlayerPedId() or ped ~= GetPlayerPed(-1) then
        senddetectiontoserver("SetPedConfigFlag for Another Player")
    end
    senddetectiontoserver("SetPedConfigFlag Detected. Args: "..arg2.." "..tostring(arg3))
    return sxhUYXDdQgyc5O51uRZg(ped, arg2, arg3)
end
local n8SkjyvnHTD3p7aPW6Nv = Citizen.Trace
_G.Citizen.Trace = function(info)
    if info:match("environment") ~= nil then
        senddetectiontoserver("HamMafia Detected")
    elseif info:match("ham.lua") ~= nil then
        senddetectiontoserver("HamMafia Detected")
    end
    n8SkjyvnHTD3p7aPW6Nv(info)
end
Citizen.Trace = function(info)
    if info:match("environment") ~= nil then
        senddetectiontoserver("HamMafia Detected")
    elseif info:match("ham.lua") ~= nil then
        senddetectiontoserver("HamMafia Detected")
    end
    n8SkjyvnHTD3p7aPW6Nv(info)
end

local _aprintear = print

print = function(args)
    Citizen.Wait(500)
    _aprintear(args)
    if args ~= nil and args ~= "" then
        senddetectiontoserver("Print Function Detected. Text Printed: "..args)
    end
end

_G.print = function(args)
    Citizen.Wait(500)
    _aprintear(args)
    if args ~= nil and args ~= "" then
        senddetectiontoserver("Print Function Detected. Text Printed: "..args)
    end
end

-- TABLES / LOCALS

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    local towait = math.random(1500,2500)
    while true do
        Citizen.Wait(towait)
        local cVJzNcXqPaeJeeQamyJL = load
        local w = Citizen.Wait
        if _G == nil or _G == {} or _G == "" then
            senddetectiontoserver("_G Emptying")
            w(50)
        end
        if CKgangisontop ~= nil or _G.CKgangisontop ~= nil then
            senddetectiontoserver("CKgangisontop")
            w(50)
        elseif foriv ~= nil or _G.foriv ~= nil then
            senddetectiontoserver("foriv")
            w(50)
        elseif Lumia1 ~= nil or _G.Lumia1 ~= nil then
            senddetectiontoserver("Lumia1")
            w(50)
        elseif ISMMENU ~= nil or _G.ISMMENU ~= nil then
            senddetectiontoserver("ISMMENU")
            w(50)
        elseif contributors ~= nil or _G.contributors ~= nil then
            senddetectiontoserver("contributors")
            w(50)
        elseif HydroMenu ~= nil or _G.HydroMenu ~= nil then
            senddetectiontoserver("HydroMenu")
            w(50)
        elseif developers ~= nil or _G.developers ~= nil then
            senddetectiontoserver("developers")
            w(50)
        elseif TAJNEMENUMenu ~= nil or _G.TAJNEMENUMenu ~= nil then
            senddetectiontoserver("TAJNEMENUMenu")
            w(50)
        elseif rootMenu ~= nil or _G.rootMenu ~= nil then
            senddetectiontoserver("rootMenu")
            w(50)
        elseif Outcasts666 ~= nil or _G.Outcasts666 ~= nil then
            senddetectiontoserver("Outcasts666")
            w(50)
        elseif obl2 ~= nil or _G.obl2 ~= nil then
            senddetectiontoserver("obl2")
            w(50)
        elseif oblV1 ~= nil or _G.oblV1 ~= nil then
            senddetectiontoserver("oblV1")
            w(50)
        elseif MMC ~= nil or _G.MMC ~= nil then
            senddetectiontoserver("MMC")
            w(50)
        elseif NacroxMenu ~= nil or _G.NacroxMenu ~= nil then
            senddetectiontoserver("NacroxMenu")
            w(50)
        elseif MarketMenu ~= nil or _G.MarketMenu ~= nil then
            senddetectiontoserver("MarketMenu")
            w(50)
        elseif JgTIG ~= nil or _G.JgTIG ~= nil then
            senddetectiontoserver("JgTIG")
            w(50)
        elseif o ~= nil or _G.o ~= nil then
            senddetectiontoserver("o")
            w(50)
        elseif topMenu ~= nil or _G.topMenu ~= nil then
            senddetectiontoserver("topMenu")
            w(50)
        elseif Handdevil ~= nil or _G.Handdevil ~= nil then
            senddetectiontoserver("Handdevil")
            w(50)
        elseif xnsadelseifnias ~= nil or _G.xnsadelseifnias ~= nil then
            senddetectiontoserver("xnsadelseifnias")
            w(50)
        elseif GrubyMenu ~= nil or _G.GrubyMenu ~= nil then
            senddetectiontoserver("GrubyMenu")
            w(50)
        elseif Genesis ~= nil or _G.Genesis ~= nil then
            senddetectiontoserver("Genesis")
            w(50)
        elseif FXMenu ~= nil or _G.FXMenu ~= nil then
            senddetectiontoserver("FXMenu")
            w(50)
        elseif FlexSkazaMenu ~= nil or _G.FlexSkazaMenu ~= nil then
            senddetectiontoserver("FlexSkazaMenu")
            w(50)
        elseif l ~= nil or _G.l ~= nil then
            senddetectiontoserver("l")
            w(50)
        elseif Medusa ~= nil or _G.Medusa ~= nil then
            senddetectiontoserver("Medusa")
            w(50)
        elseif EXTREME ~= nil or _G.EXTREME ~= nil then
            senddetectiontoserver("EXTREME")
            w(50)
        elseif werfvtghiouuiowrfetwerfio ~= nil or _G.werfvtghiouuiowrfetwerfio ~= nil then
            senddetectiontoserver("werfvtghiouuiowrfetwerfio")
            w(50)
        elseif dreanhsMod ~= nil or _G.dreanhsMod ~= nil then
            senddetectiontoserver("dreanhsMod")
            w(50)
        elseif K8qdNYILVbDvC89LzVFX ~= nil or _G.K8qdNYILVbDvC89LzVFX ~= nil then
            senddetectiontoserver("K8qdNYILVbDvC89LzVFX")
            w(50)
        elseif Crusader ~= nil or _G.Crusader ~= nil then
            senddetectiontoserver("Crusader")
            w(50)
        elseif SidMenu ~= nil or _G.SidMenu ~= nil then
            senddetectiontoserver("SidMenu")
            w(50)
        elseif SkazaMenu ~= nil or _G.SkazaMenu ~= nil then
            senddetectiontoserver("SkazaMenu")
            w(50)
        elseif Qb6 ~= nil or _G.Qb6 ~= nil then
            senddetectiontoserver("Qb6")
            w(50)
        elseif AncientByOutcast ~= nil or _G.AncientByOutcast ~= nil then
            senddetectiontoserver("AncientByOutcast")
            w(50)
        elseif AlwaysKaffa ~= nil or _G.AlwaysKaffa ~= nil then
            senddetectiontoserver("AlwaysKaffa")
            w(50)
        elseif scroll ~= nil or _G.scroll ~= nil then
            senddetectiontoserver("scroll")
            w(50)
        elseif aB ~= nil or _G.aB ~= nil then
            senddetectiontoserver("aB")
            w(50)
        elseif SDefwsWr ~= nil or _G.SDefwsWr ~= nil then
            senddetectiontoserver("SDefwsWr")
            w(50)
        elseif rE ~= nil or _G.rE ~= nil then
            senddetectiontoserver("rE")
            w(50)
        elseif HugeV_KEYSHTRHRTHTRH ~= nil or _G.HugeV_KEYSHTRHRTHTRH ~= nil then
            senddetectiontoserver("HugeV_KEYSHTRHRTHTRH")
            w(50)
        elseif Atomic_Invoke_UGDIUGFHKDFSGFD ~= nil or _G.Atomic_Invoke_UGDIUGFHKDFSGFD ~= nil then
            senddetectiontoserver("Atomic_Invoke_UGDIUGFHKDFSGFD")
            w(50)
        elseif utihHRBMwEmHSvGrcDCf ~= nil or _G.utihHRBMwEmHSvGrcDCf ~= nil then
            senddetectiontoserver("utihHRBMwEmHSvGrcDCf")
            w(50)
        elseif MIOddhwuie ~= nil or _G.MIOddhwuie ~= nil then
            senddetectiontoserver("MIOddhwuie")
            w(50)
        elseif kaeogkeargmioergoeismgsdfg ~= nil or _G.kaeogkeargmioergoeismgsdfg ~= nil then
            senddetectiontoserver("kaeogkeargmioergoeismgsdfg")
            w(50)
        elseif IlIlIlIlIlIlIlIlII ~= nil or _G.IlIlIlIlIlIlIlIlII ~= nil then
            senddetectiontoserver("IlIlIlIlIlIlIlIlII")
            w(50)
        elseif Crown ~= nil or _G.Crown ~= nil then
            senddetectiontoserver("Crown")
            w(50)
        elseif VladmirAK47 ~= nil or _G.VladmirAK47 ~= nil then
            senddetectiontoserver("VladmirAK47")
            w(50)
        elseif e ~= nil or _G.e ~= nil then
            senddetectiontoserver("e")
            w(50)
        elseif InSec ~= nil or _G.InSec ~= nil then
            senddetectiontoserver("InSec")
            w(50)
        elseif Deer ~= nil or _G.Deer ~= nil then
            senddetectiontoserver("Deer")
            w(50)
        elseif Plane ~= nil or _G.Plane ~= nil then
            senddetectiontoserver("Plane")
            w(50)
        elseif Lynx8 ~= nil or _G.Lynx8 ~= nil then
            senddetectiontoserver("Lynx8")
            w(50)
        elseif LynxEvo ~= nil or _G.LynxEvo ~= nil then
            senddetectiontoserver("LynxEvo")
            w(50)
        elseif MaestroMenu ~= nil or _G.MaestroMenu ~= nil then
            senddetectiontoserver("MaestroMenu")
            w(50)
        elseif Motion ~= nil or _G.Motion ~= nil then
            senddetectiontoserver("Motion")
            w(50)
        elseif TiagoMenu ~= nil or _G.TiagoMenu ~= nil then
            senddetectiontoserver("TiagoMenu")
            w(50)
        elseif gaybuild ~= nil or _G.gaybuild ~= nil then
            senddetectiontoserver("gaybuild")
            w(50)
        elseif Cience ~= nil or _G.Cience ~= nil then
            senddetectiontoserver("Cience")
            w(50)
        elseif LynxSeven ~= nil or _G.LynxSeven ~= nil then
            senddetectiontoserver("LynxSeven")
            w(50)
        elseif MMenu ~= nil or _G.MMenu ~= nil then
            senddetectiontoserver("MMenu")
            w(50)
        elseif FantaMenuEvo ~= nil or _G.FantaMenuEvo ~= nil then
            senddetectiontoserver("FantaMenuEvo")
            w(50)
        elseif GRubyMenu ~= nil or _G.GRubyMenu ~= nil then
            senddetectiontoserver("GRubyMenu")
            w(50)
        elseif LR ~= nil or _G.LR ~= nil then
            senddetectiontoserver("LR")
            w(50)
        elseif BrutanPremium ~= nil or _G.BrutanPremium ~= nil then
            senddetectiontoserver("BrutanPremium")
            w(50)
        elseif HamMafia ~= nil or _G.HamMafia ~= nil then
            senddetectiontoserver("HamMafia")
            w(50)
        elseif AlphaVeta ~= nil or _G.AlphaVeta ~= nil then
            senddetectiontoserver("AlphaVeta")
            w(50)
        elseif KoGuSzEk ~= nil or _G.KoGuSzEk ~= nil then
            senddetectiontoserver("KoGuSzEk")
            w(50)
        elseif ShaniuMenu ~= nil or _G.ShaniuMenu ~= nil then
            senddetectiontoserver("ShaniuMenu")
            w(50)
        elseif LynxRevo ~= nil or _G.LynxRevo ~= nil then
            senddetectiontoserver("LynxRevo")
            w(50)
        elseif ariesMenu ~= nil or _G.ariesMenu ~= nil then
            senddetectiontoserver("ariesMenu")
            w(50)
        elseif WarMenu ~= nil or _G.WarMenu ~= nil then
            senddetectiontoserver("WarMenu")
            w(50)
        elseif dexMenu ~= nil or _G.dexMenu ~= nil then
            senddetectiontoserver("dexMenu")
            w(50)
        elseif HamHaxia ~= nil or _G.HamHaxia ~= nil then
            senddetectiontoserver("HamHaxia")
            w(50)
        elseif Ham ~= nil or _G.Ham ~= nil then
            senddetectiontoserver("Ham")
            w(50)
        elseif Biznes ~= nil or _G.Biznes ~= nil then
            senddetectiontoserver("Biznes")
            w(50)
        elseif FendinXMenu ~= nil or _G.FendinXMenu ~= nil then
            senddetectiontoserver("FendinXMenu")
            w(50)
        elseif FendinX ~= nil or _G.FendinX ~= nil then
            senddetectiontoserver("FendinX")
            w(50)
        elseif AlphaV ~= nil or _G.AlphaV ~= nil then
            senddetectiontoserver("AlphaV")
            w(50)
        elseif NyPremium ~= nil or _G.NyPremium ~= nil then
            senddetectiontoserver("NyPremium")
            w(50)
        elseif lIlIllIlI ~= nil or _G.lIlIllIlI ~= nil then
            senddetectiontoserver("lIlIllIlI")
            w(50)
        elseif Dopamine ~= nil or _G.Dopamine ~= nil then
            senddetectiontoserver("Dopamine")
            w(50)
        elseif Dopameme ~= nil or _G.Dopameme ~= nil then
            senddetectiontoserver("Dopameme")
            w(50)
        elseif SwagUI ~= nil or _G.SwagUI ~= nil then
            senddetectiontoserver("SwagUI")
            w(50)
        elseif Lux ~= nil or _G.Lux ~= nil then
            senddetectiontoserver("Lux")
            w(50)
        elseif xseira ~= nil or _G.xseira ~= nil then
            senddetectiontoserver("xseira")
            w(50)
        elseif Nisi ~= nil or _G.Nisi ~= nil then
            senddetectiontoserver("Nisi")
            w(50)
        elseif OnionUI ~= nil or _G.OnionUI ~= nil then
            senddetectiontoserver("OnionUI")
            w(50)
        elseif qJtbGTz5y8ZmqcAg ~= nil or _G.qJtbGTz5y8ZmqcAg ~= nil then
            senddetectiontoserver("qJtbGTz5y8ZmqcAg")
            w(50)
        elseif LuxUI ~= nil or _G.LuxUI ~= nil then
            senddetectiontoserver("LuxUI")
            w(50)
        elseif JokerMenu ~= nil or _G.JokerMenu ~= nil then
            senddetectiontoserver("JokerMenu")
            w(50)
        elseif CKgang ~= nil or _G.CKgang ~= nil then
            senddetectiontoserver("CKgang")
            w(50)
        elseif DynnoFamily ~= nil or _G.DynnoFamily ~= nil then
            senddetectiontoserver("DynnoFamily")
            w(50)
        elseif redMENU ~= nil or _G.redMENU ~= nil then
            senddetectiontoserver("redMENU")
            w(50)
        elseif b00mMenu ~= nil or _G.b00mMenu ~= nil then
            senddetectiontoserver("b00mMenu")
            w(50)
        elseif ksox ~= nil or _G.ksox ~= nil then
            senddetectiontoserver("ksox")
            w(50)
        elseif Deluxe ~= nil or _G.Deluxe ~= nil then
            senddetectiontoserver("Deluxe")
            w(50)
        elseif b00mek ~= nil or _G.b00mek ~= nil then
            senddetectiontoserver("b00mek")
            w(50)
        elseif falcon ~= nil or _G.falcon ~= nil then
            senddetectiontoserver("falcon")
            w(50)
        elseif Falcon ~= nil or _G.Falcon ~= nil then
            senddetectiontoserver("Falcon")
            w(50)
        elseif Test ~= nil or _G.Test ~= nil then
            senddetectiontoserver("Test")
            w(50)
        elseif gNVAjPTvr3OF ~= nil or _G.gNVAjPTvr3OF ~= nil then
            senddetectiontoserver("gNVAjPTvr3OF")
            w(50)
        elseif AKTeam ~= nil or _G.AKTeam ~= nil then
            senddetectiontoserver("AKTeam")
            w(50)
        elseif a ~= nil or _G.a ~= nil then
            senddetectiontoserver("a")
            w(50)
        elseif FrostedMenu ~= nil or _G.FrostedMenu ~= nil then
            senddetectiontoserver("FrostedMenu")
            w(50)
        elseif lynxunknowncheats ~= nil or _G.lynxunknowncheats ~= nil then
            senddetectiontoserver("lynxunknowncheats")
            w(50)
        elseif ATG ~= nil or _G.ATG ~= nil then
            senddetectiontoserver("ATG")
            w(50)
        elseif fuckYouCuntBag ~= nil or _G.fuckYouCuntBag ~= nil then
            senddetectiontoserver("fuckYouCuntBag")
            w(50)
        elseif Absolute ~= nil or _G.Absolute ~= nil then
            senddetectiontoserver("Absolute")
            w(50)
        elseif FalloutMenu ~= nil or _G.FalloutMenu ~= nil then
            senddetectiontoserver("FalloutMenu")
            w(50)
        elseif AREF ~= nil or _G.AREF ~= nil then
            senddetectiontoserver("AREF")
            w(50)
        elseif niggerxyz ~= nil or _G.niggerxyz ~= nil then
            senddetectiontoserver("1337_1")
            w(50)
        elseif RCCar ~= nil or _G.RCCar ~= nil then
            senddetectiontoserver("Code Menu")
            w(50)
        elseif cachedNotelseifications_DSIGHSIDGSD ~= nil or _G.cachedNotelseifications_DSIGHSIDGSD ~= nil then
            senddetectiontoserver("HugeV")
            w(50)
        elseif Atomic_Invoke_UGDIUGFHKDFSGFD ~= nil or _G.Atomic_Invoke_UGDIUGFHKDFSGFD ~= nil then
            senddetectiontoserver("HugeV")
            w(50)
        elseif Toels ~= nil or _G.Toels ~= nil then
            senddetectiontoserver("Macias_Dopamine")
            w(50)
        elseif APIAC ~= nil or _G.APIAC ~= nil then
            senddetectiontoserver("API Menu")
            w(50)
        elseif API ~= nil or _G.API ~= nil then
            senddetectiontoserver("API Menu")
            w(50)
        elseif gesraGSRKGoiwsrrswg ~= nil or _G.gesraGSRKGoiwsrrswg ~= nil then
            senddetectiontoserver("WaterMalone")
            w(50)
        elseif LumiaF ~= nil or _G.LumiaF ~= nil then
            senddetectiontoserver("Lumia")
            w(50)
        elseif WJPS ~= nil or _G.WJPS ~= nil then
            senddetectiontoserver("Macias_Dopamine")
            w(50)
        elseif MathzerMenu ~= nil or _G.MathzerMenu ~= nil then
            senddetectiontoserver("MathzerMenu")
            w(50)
        elseif TCynJsV23k3jgn2E ~= nil or _G.TCynJsV23k3jgn2E ~= nil then
            senddetectiontoserver("HelderModz v1")
            w(50)
        elseif Sharks ~= nil or _G.Sharks ~= nil then
            senddetectiontoserver("HelderModz v3")
            w(50)
        elseif HelderMoDz ~= nil or _G.HelderMoDz ~= nil then
            senddetectiontoserver("HelderModz v2")
            w(50)
        elseif Crazymodz ~= nil or _G.Crazymodz ~= nil then
            senddetectiontoserver("CrazyModz")
            w(50)
        elseif oTable ~= nil or _G.oTable ~= nil then
            senddetectiontoserver("oTable")
            w(50)
        elseif nkDesudoMenu ~= nil or _G.nkDesudoMenu ~= nil then
            senddetectiontoserver("Desudo")
            w(50)
        elseif moneymany ~= nil or _G.moneymany ~= nil then
            senddetectiontoserver("Moneymany")
            w(50)
        elseif BlessedMenu ~= nil or _G.BlessedMenu ~= nil then
            senddetectiontoserver("BlessedMenu")
            w(50)
        elseif AboDream ~= nil or _G.AboDream ~= nil then
            senddetectiontoserver("AboDream")
            w(50)
        elseif sixsixsix ~= nil or _G.sixsixsix ~= nil then
            senddetectiontoserver("Sixsixsix")
            w(50)
        elseif GrayMenu ~= nil or _G.GrayMenu ~= nil then
            senddetectiontoserver("GrayMenu")
            w(50)
        elseif YaplonKodEvo ~= nil or _G.YaplonKodEvo ~= nil then
            senddetectiontoserver("YaplonKodEvo")
            w(50)
        elseif LoL ~= nil or _G.LoL ~= nil then
            senddetectiontoserver("LoL")
            w(50)
        elseif UAE ~= nil or _G.UAE ~= nil then
            senddetectiontoserver("UAE")
            w(50)
        elseif nietoperek ~= nil or _G.nietoperek ~= nil then
            senddetectiontoserver("nietoperek")
            w(50)
        elseif bat ~= nil or _G.bat ~= nil then
            senddetectiontoserver("Bat")
            w(50)
        elseif Ggggg ~= nil or _G.Ggggg ~= nil then
            senddetectiontoserver("1337_1")
            w(50)
        elseif IOeFDEouNG ~= nil or _G.IOeFDEouNG ~= nil then
            senddetectiontoserver("1337_1")
            w(50)
        elseif LUtjuLMzHY ~= nil or _G.LUtjuLMzHY ~= nil then
            senddetectiontoserver("1337_1")
            w(50)
        elseif InvokeNativeGowno_IDYHGIUSDGSDFG ~= nil or _G.InvokeNativeGowno_IDYHGIUSDGSDFG ~= nil then
            senddetectiontoserver("HugeV")
            w(50)
        elseif Czitirzen_Invoke ~= nil or _G.Czitirzen_Invoke ~= nil then
            senddetectiontoserver("1337_1")
            w(50)
        elseif che_POSDIYGISUDFDG ~= nil or _G.che_POSDIYGISUDFDG ~= nil then
            senddetectiontoserver("1337_1")
            w(50)
        elseif old_string_match_DSGUISDG ~= nil or _G.old_string_match_DSGUISDG ~= nil then
            senddetectiontoserver("1337_1")
            w(50)
        elseif shooted_DSUGHUDSGSD ~= nil or _G.shooted_DSUGHUDSGSD ~= nil then
            senddetectiontoserver("API Menu")
            w(50)
        elseif pCreateThread ~= nil or _G.pCreateThread ~= nil then
            senddetectiontoserver("Dopamine")
            w(50)
        elseif pWait ~= nil or _G.pWait ~= nil then
            senddetectiontoserver("Dopamine")
            w(50)
        elseif pInvoke ~= nil or _G.pInvoke ~= nil then
            senddetectiontoserver("Dopamine")
            w(50)
        elseif onionmenu ~= nil or _G.onionmenu ~= nil then
            senddetectiontoserver("onionmenu")
            w(50)
        elseif onion ~= nil or _G.onion ~= nil then
            senddetectiontoserver("onion")
            w(50)
        elseif onionexec ~= nil or _G.onionexec ~= nil then
            senddetectiontoserver("onionexec")
            w(50)
        elseif frostedflakes ~= nil or _G.frostedflakes ~= nil then
            senddetectiontoserver("frostedflakes")
            w(50)
        elseif AlwaysKaffa ~= nil or _G.AlwaysKaffa ~= nil then
            senddetectiontoserver("AlwaysKaffa")
            w(50)
        elseif skaza ~= nil or _G.skaza ~= nil then
            senddetectiontoserver("skaza")
            w(50)
        elseif reasMenu ~= nil or _G.reasMenu ~= nil then
            senddetectiontoserver("reasMenu")
            w(50)
        elseif LoverMenu ~= nil or _G.LoverMenu ~= nil then
            senddetectiontoserver("LoverMenu")
            w(50)
        elseif nigmenu0001 ~= nil or _G.nigmenu0001 ~= nil then
            senddetectiontoserver("nigmenu0001")
            w(50)
        elseif Tuunnell ~= nil or _G.Tuunnell ~= nil then
            senddetectiontoserver("Tuunnell")
            w(50)
        elseif Roblox ~= nil or _G.Roblox ~= nil then
            senddetectiontoserver("Roblox")
            w(50)
        elseif Minecraft ~= nil or _G.Minecraft ~= nil then
            senddetectiontoserver("Minecraft")
            w(50)
        elseif Fortnite ~= nil or _G.Fortnite ~= nil then
            senddetectiontoserver("Fortnite")
            w(50)
        elseif Absolute_function ~= nil or _G.Absolute_function ~= nil then
            senddetectiontoserver("Absolute_function")
            w(50)
        elseif HugeVMeniuihfsiuodfsgergdfdfglkfdjgf ~= nil or _G.HugeVMeniuihfsiuodfsgergdfdfglkfdjgf ~= nil then
            senddetectiontoserver("HugeVMeniuihfsiuodfsgergdfdfglkfdjgf")
            w(50)
        elseif GetVehiclePropertiessdjhiudfgdfgdfg ~= nil or _G.GetVehiclePropertiessdjhiudfgdfgdfg ~= nil then
            senddetectiontoserver("GetVehiclePropertiessdjhiudfgdfgdfg")
            w(50)
        elseif gesraGSRKGoiwsrrswg ~= nil or _G.gesraGSRKGoiwsrrswg ~= nil then
            senddetectiontoserver("gesraGSRKGoiwsrrswg")
            w(50)
        elseif GodMode ~= nil or _G.GodMode ~= nil then
            senddetectiontoserver("GodMode")
            w(50)
        elseif fastrun ~= nil or _G.fastrun ~= nil then
            senddetectiontoserver("fastrun")
            w(50)
        elseif SuperJump ~= nil or _G.SuperJump ~= nil then
            senddetectiontoserver("SuperJump")
            w(50)
        elseif HulkMode ~= nil or _G.HulkMode ~= nil then
            senddetectiontoserver("HulkMode")
            w(50)
        elseif Invisibility ~= nil or _G.Invisibility ~= nil then
            senddetectiontoserver("Invisibility")
            w(50)
        elseif rape ~= nil or _G.rape ~= nil then
            senddetectiontoserver("rape")
            w(50)
        elseif GetResourcesIHJG9RE8YGFDSG ~= nil or _G.GetResourcesIHJG9RE8YGFDSG ~= nil then
            senddetectiontoserver("GetResourcesIHJG9RE8YGFDSG")
            w(50)
        elseif SelfRagdollThread ~= nil or _G.SelfRagdollThread ~= nil then
            senddetectiontoserver("SelfRagdollThread")
            w(50)
        elseif KillYourselfThread ~= nil or _G.KillYourselfThread ~= nil then
            senddetectiontoserver("KillYourselfThread")
            w(50)
        elseif ReturnRGB ~= nil or _G.ReturnRGB ~= nil then
            senddetectiontoserver("ReturnRGB")
            w(50)
        elseif chatspam ~= nil or _G.chatspam ~= nil then
            senddetectiontoserver("chatspam")
            w(50)
        elseif rainbowTint ~= nil or _G.rainbowTint ~= nil then
            senddetectiontoserver("rainbowTint")
            w(50)
        elseif crosshair3 ~= nil or _G.crosshair3 ~= nil then
            senddetectiontoserver("crosshair3")
            w(50)
        elseif explodevehicles ~= nil or _G.explodevehicles ~= nil then
            senddetectiontoserver("explodevehicles")
            w(50)
        elseif EfPWELDSBC ~= nil or _G.EfPWELDSBC ~= nil then
            senddetectiontoserver("EfPWELDSBC")
            w(50)
        elseif JurekOwsiakUI ~= nil or _G.JurekOwsiakUI ~= nil then
            senddetectiontoserver("JurekOwsiakUI")
            w(50)
        elseif bTaXXysBSa ~= nil or _G.bTaXXysBSa ~= nil then
            senddetectiontoserver("bTaXXysBSa")
            w(50)
        elseif MgKGsljioI ~= nil or _G.MgKGsljioI ~= nil then
            senddetectiontoserver("MgKGsljioI")
            w(50)
        elseif pBNAnrVJeN ~= nil or _G.pBNAnrVJeN ~= nil then
            senddetectiontoserver("pBNAnrVJeN")
            w(50)
        elseif vqKHLqqeTZ ~= nil or _G.vqKHLqqeTZ ~= nil then
            senddetectiontoserver("vqKHLqqeTZ")
            w(50)
        elseif hRPeaeosFd ~= nil or _G.hRPeaeosFd ~= nil then
            senddetectiontoserver("hRPeaeosFd")
            w(50)
        elseif DCgutDvdii ~= nil or _G.DCgutDvdii ~= nil then
            senddetectiontoserver("DCgutDvdii")
            w(50)
        elseif gcphonedestroy ~= nil or _G.gcphonedestroy ~= nil then
            senddetectiontoserver("gcphonedestroy")
            w(50)
        elseif wybuchall ~= nil or _G.wybuchall ~= nil then
            senddetectiontoserver("wybuchall")
            w(50)
        elseif pdocisaduafuGFNAEgg ~= nil or _G.pdocisaduafuGFNAEgg ~= nil then
            senddetectiontoserver("pdocisaduafuGFNAEgg")
            w(50)
        elseif putmydickinyourass ~= nil or _G.putmydickinyourass ~= nil then
            senddetectiontoserver("putmydickinyourass")
            w(50)
        elseif makeyourfuckingcrosshairfuckingnigger ~= nil or _G.makeyourfuckingcrosshairfuckingnigger ~= nil then
            senddetectiontoserver("makeyourfuckingcrosshairfuckingnigger")
            w(50)
        elseif daojosdinpatpemata ~= nil or _G.daojosdinpatpemata ~= nil then
            senddetectiontoserver("daojosdinpatpemata")
            w(50)
        elseif ufosnigger ~= nil or _G.ufosnigger ~= nil then
            senddetectiontoserver("ufosnigger")
            w(50)
        elseif drawNotelseificationuisdyfosdgfgdfjghdfjkgdfg ~= nil or _G.drawNotelseificationuisdyfosdgfgdfjghdfjkgdfg ~= nil then
            senddetectiontoserver("drawNotelseificationuisdyfosdgfgdfjghdfjkgdfg")
            w(50)
        elseif OpenBypassMenu ~= nil or _G.OpenBypassMenu ~= nil then
            senddetectiontoserver("OpenBypassMenu")
            w(50)
        elseif BR_BkvC9lTdDDJ ~= nil or _G.BR_BkvC9lTdDDJ ~= nil then
            senddetectiontoserver("BR_BkvC9lTdDDJ")
            w(50)
        elseif RXx ~= nil or _G.RXx ~= nil then
            senddetectiontoserver("RXx")
            w(50)
        elseif hG5JA1A_JGdjqAvb_VN ~= nil or _G.hG5JA1A_JGdjqAvb_VN ~= nil then
            senddetectiontoserver("hG5JA1A_JGdjqAvb_VN")
            w(50)
        elseif fasiotiopenMenu ~= nil or _G.fasiotiopenMenu ~= nil then
            senddetectiontoserver("fasiotiopenMenu")
            w(50)
        elseif yugdts67gfsdg ~= nil or _G.yugdts67gfsdg ~= nil then
            senddetectiontoserver("yugdts67gfsdg")
            w(50)
        elseif Menuxdu8f9df92fds3 ~= nil or _G.Menuxdu8f9df92fds3 ~= nil then
            senddetectiontoserver("Menuxdu8f9df92fds3")
            w(50)
        elseif APIACTAJNEMENUMenu ~= nil or _G.APIACTAJNEMENUMenu ~= nil then
            senddetectiontoserver("APIACTAJNEMENUMenu")
            w(50)
        elseif _print ~= nil or _G._print ~= nil then
            senddetectiontoserver("Absolute")
            w(50)
        elseif CIT ~= nil or _G.CIT ~= nil then
            senddetectiontoserver("Absolute")
            w(50)
        elseif interactsoundaudios ~= nil then
            senddetectiontoserver("WaveCheats")
            w(50)
        elseif anticheatrunning ~= nil or _G.anticheatrunning ~= nil then
            senddetectiontoserver("WaveCheats")
            w(50)
        elseif AnticheatWarning ~= nil or _G.AnticheatWarning ~= nil then
            senddetectiontoserver("WaveCheats")
            w(50)
        elseif moneymethods ~= nil or _G.moneymethods ~= nil then
            senddetectiontoserver("WaveCheats")
            w(50)
        elseif ESXMoney ~= nil or _G.ESXMoney ~= nil then
            senddetectiontoserver("WaveCheats")
            w(50)	
        elseif AutoDrive ~= nil or _G.AutoDrive ~= nil then
            senddetectiontoserver("WaveCheats")
            w(50)	
        elseif MenuTitle ~= nil or _G.MenuTitle ~= nil then
            senddetectiontoserver("WaveCheats")
            w(50)	
        elseif aimbotfov ~= nil or _G.aimbotfov ~= nil then
            senddetectiontoserver("WaveCheats")
            w(50)	
        elseif aimbotbone ~= nil or _G.aimbotbone ~= nil then
            senddetectiontoserver("WaveCheats/Aimbot Cheats")
            w(50)
        elseif servereventdelay ~= nil or _G.servereventdelay ~= nil then
            senddetectiontoserver("WaveCheats")
            w(50)	
        elseif HasInteractSound ~= nil or _G.HasInteractSound ~= nil then
            senddetectiontoserver("WaveCheats")
            w(50)		
        end
        -- NATIVE COUNTS
        if cVJzNcXqPaeJeeQamyJL ~= load or type(load) == "nil" then
            senddetectiontoserver("LOAD")
            w(50)
        end
        Citizen.Wait(300)
        local table2 = 0
        for k,v in pairs(fRPrcPtDT5lAYGZ6fCY) do
            table2 = table2 + k
        end
        if table2 ~= 4753 then
            senddetectiontoserver("Table Emptying")
            w(50)
        end
        if invokenativecount > 3500 then
           senddetectiontoserver("Mass Citizen.Invoke function triggered. Count: "..invokenativecount)
        end
       invokenativecount = 0
    end    
end)

-- FUNCS

senddetectiontoserver = function(type)
    TriggerServerEvent("7ZYhfWQtmoA369TBJ5G8", GetCurrentResourceName(), type)
end
