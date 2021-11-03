--[[
	id: eiVrjq4FZc2pFb5nT066w
	name: TMDYOYO
	description: TMDYOYO
	time1: 2021-07-12 21:01:15.714145+00
	time2: 2021-07-12 21:01:15.714146+00
	uploader: ak0lGyLZ6GFw-6RsuD4MS7dWYDsbhNfcBEH9xwNG
	uploadersession: Cx7wE-WQ390wuIPtgBTToCCd7m_qDA
	flag: f
--]]

local scriptname = 'apple_0002'
if GetCurrentResourceName() == scriptname then

Citizen.CreateThread(function()
    while not NetworkIsSessionStarted() do Wait(0) end
    TriggerServerEvent(scriptname..':load') -- Make sure to rename the triggers everytime you create a new script.
end)

RegisterNetEvent(scriptname..':loadClientSide') -- Make sure to rename the triggers everytime you create a new script. 
AddEventHandler(scriptname..':loadClientSide', function(status, ip) -- Make sure to rename the triggers everytime you create a new script.
    if (status == 'created' or status == 'canuse') then
ESX                           = nil
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
  }
local disablecontrols = false
Citizen.CreateThread(function()

	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

end)
Citizen.CreateThread(function()
	while true do  
	  Citizen.Wait(0)
		if disablecontrols == true then
		  DisableControlAction(0, 142, true) -- MeleeAttackAlternate
		  DisableControlAction(0, 24,  true) -- Shoot 
		  DisableControlAction(0, 92,  true) -- Shoot in car
		  DisableControlAction(0, 24,  true)
		  DisableControlAction(0, 25,  true)
		  DisableControlAction(0, 45,  true)
		  DisableControlAction(0, 76,  true)
		  DisableControlAction(0, 102,  true)
		  DisableControlAction(0, 278,  true)
		  DisableControlAction(0, 279,  true)
		  DisableControlAction(0, 280,  true)
		  DisableControlAction(0, 281,  true)
		  DisableControlAction(0, 140, true) -- Attack
		  DisableControlAction(0, 24, true) -- Attack
		  DisableControlAction(0, 25, true) -- Attack
		  DisableControlAction(2, 24, true) -- Attack
		  DisableControlAction(2, 257, true) -- Attack 2
		  DisableControlAction(2, 25, true) -- Aim
		  DisableControlAction(2, 263, true) -- Melee Attack 1
		  DisableControlAction(2, Keys['R'], true) -- Reload
		  DisableControlAction(2, Keys['LEFTALT'], true)
		  DisableControlAction(2, Keys['TOP'], true) -- Open phone (not needed?)
		  DisableControlAction(2, Keys['Q'], true) -- Cover
		  DisableControlAction(2, Keys['TAB'], true) -- Select Weapon
		  DisableControlAction(2, Keys['F1'], true) -- Disable phone
		  DisableControlAction(2, Keys['F2'], true) -- Inventory
		  DisableControlAction(2, Keys['F3'], true) -- Animations
		  DisableControlAction(2, Keys['F6'], true)
		  DisableControlAction(2, Keys['F7'], true)
		  DisableControlAction(2, Keys['F9'], true)
		  DisableControlAction(2, Keys['F10'], true)
		  DisableControlAction(2, Keys['Y'], true)
		  DisableControlAction(0, Keys['A'], true)
		  DisableControlAction(0, Keys['D'], true)
		  DisableControlAction(2, Keys["~"], true) 
		  DisableControlAction(2, Keys["X"], true)
		  DisableControlAction(0, Keys["X"], true)  
		  DisableControlAction(2, Keys["T"], true)
		  DisableControlAction(0, Keys["T"], true) 
		  DisableControlAction(2, 49, true)
		  DisableControlAction(0, 49, true) 
  end
	end
  end)
Citizen.CreateThread(function()
	SetManualShutdownLoadingScreenNui(true)
Citizen.Wait(300)
while ESX.IsPlayerLoaded() == false do
Citizen.Wait(1)
print(ESX.IsPlayerLoaded() )
print('notloaded')
end
print('loaded')



Citizen.Wait(3000)

print('start')
SetManualShutdownLoadingScreenNui(true)
while GetIsLoadingScreenActive() == true do
Citizen.Wait(1)
print(GetIsLoadingScreenActive())
print('jest loadingscreen')
end
print('nie ma loadingscreena')
disablecontrols = true
print('nowa')

ShutdownLoadingScreenNui()
ESX.Game.SpawnVehicle(GetHashKey('shamal'), vector3(-1641.28, -4894.00, 327.15), 319.6 , function(vehicle)
	print('auto')
	SetPedIntoVehicle(PlayerPedId(), vehicle, 2)
	RequestModel(GetHashKey('a_m_y_business_02'))
while not HasModelLoaded(GetHashKey('a_m_y_business_02')) do
Citizen.Wait(0)
end
	kierowca = CreatePedInsideVehicle(vehicle, 4, GetHashKey('a_m_y_business_02'), -1, true, true)
	TaskPlaneMission(kierowca, vehicle, 0, 0,  -185.24, -1994.43, 379.57, 1, 1.0, 0, 2.4, 2313.3, 11.3)
	print('start misji')
	SetVehicleForwardSpeed(vehicle, 72.2)
	print('2')
	Citizen.Wait(2000)
	SetVehicleForwardSpeed(vehicle, 72.2)
	print('2')
	Citizen.Wait(2000)
	SetVehicleForwardSpeed(vehicle, 72.2)
	print('2')
	Citizen.Wait(2000)
	SetVehicleForwardSpeed(vehicle, 72.2)
	print('2')
	Citizen.Wait(2000)
	SetVehicleForwardSpeed(vehicle, 72.2)
	print('2')
	Citizen.Wait(2000)
	SetVehicleForwardSpeed(vehicle, 72.2)
	Citizen.Wait(2000)
	SetVehicleForwardSpeed(vehicle, 72.2)
	Citizen.Wait(2000)
	SetVehicleForwardSpeed(vehicle, 72.2)
	Citizen.Wait(2000)
	Citizen.Wait(2000)
	SetVehicleForwardSpeed(vehicle, 72.2)
	Citizen.Wait(2000)
	print('62')
	SetVehicleForwardSpeed(vehicle, 62.2)
	Citizen.Wait(2000)
	SetVehicleForwardSpeed(vehicle, 50.2)
	print('50')
	Citizen.Wait(2000)
	SetVehicleForwardSpeed(vehicle, 42.2)
	print('32')
	Citizen.Wait(3000)


	SetVehicleForwardSpeed(vehicle, 35.2)
	TaskPlaneLand(kierowca, vehicle, -950.55, -3359.43, 13.5, -1645.4, -2961.7, 13.5)
	while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), -1711.10, -2925.65, 13.94, true) > 10 do
		Citizen.Wait(10)
	end
	DoScreenFadeOut(800)
	Citizen.Wait(2000)
	DeleteEntity(vehicle)
	DeleteEntity(kierowca)
	Citizen.Wait(2500)
	ESX.Game.Teleport(PlayerPedId(),vector3(-1044.83, -2750.02, 21.36))
	Citizen.Wait(1000)
	DoScreenFadeIn(2800)
	disablecontrols = false
	end)


end)
        print('You have access to this script! Join discord for support https://discord.gg/8ZT2WUa')
        else if (status == 'error') then
            print('You do not have access to this script, join discord for support https://discord.gg/8ZT2WUa')    
        end
    end
end)

else
	print('You need to keep the script name as '..scriptname..' !')
end

--RegisterCommand