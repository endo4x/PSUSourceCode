--[[
	id: WABU-Zp8rtRj0Q168fu5K
	name: Narnia-arsenal
	description: Client
	time1: 2021-06-10 15:11:38.498468+00
	time2: 2021-06-10 15:11:38.498468+00
	uploader: yycirKNQfSmTWKnRxllo0FJaoMUfjxG8vtycpQCm
	uploadersession: YROmhjXkQLUYRW5beJS1_AseYi7Mgc
	flag: f
--]]

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPex = Tunnel.getInterface("bdl_arsenal")

local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		TransitionToBlurred(1000)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		TransitionFromBlurred(1000)
		SendNUIMessage({ hidemenu = true })
	end
end

-- [ Callback das ações dos botões ]
RegisterNUICallback("ButtonClick",function(data,cb)
	local ped = PlayerPedId()
	if data == "m4a1" then
		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_CARBINERIFLE"))
		GiveWeaponToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),150,0,0)

	elseif data == "m4a4" then
		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"))
		GiveWeaponToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),150,0,0)

	elseif data == "mp5" then
		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_COMBATPDW"))
		GiveWeaponToPed(ped,GetHashKey("WEAPON_SMG"),100,0,0)

	elseif data == "mpx" then
		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_SMG"))
		GiveWeaponToPed(ped,GetHashKey("WEAPON_COMBATPDW"),100,0,0)

	elseif data == "shot45" then
		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN"))
		GiveWeaponToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),100,0,0)

	elseif data == "shot12" then
		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"))
		GiveWeaponToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN"),100,0,0)

	elseif data == "fiveseven" then
		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_COMBATPISTOL"))
		GiveWeaponToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),100,0,0)

	elseif data == "glock18" then
		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_PISTOL_MK2"))
		GiveWeaponToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),100,0,0)
		
	elseif data == "take-kit" then
		GiveWeaponToPed(ped,GetHashKey("WEAPON_NIGHTSTICK"),0,0,0)
		GiveWeaponToPed(ped,GetHashKey("WEAPON_STUNGUN"),0,0,0)
		GiveWeaponToPed(ped,GetHashKey("WEAPON_FLASHLIGHT"),0,0,0)
		
	elseif data == "rem-kit" then
		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_NIGHTSTICK"))
		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_STUNGUN"))
		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_FLASHLIGHT"))
		
	elseif data == "clear" then
		RemoveAllPedWeapons(ped,0)
	
	elseif data == "fechar" then
		ToggleActionMenu()
	
	end
end)