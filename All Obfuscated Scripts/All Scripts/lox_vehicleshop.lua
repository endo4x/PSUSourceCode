--[[
	id: wBqcx5aEsUec4s9w_fGDK
	name: lox_vehicleshop
	description: lox_vehicleshop
	time1: 2021-07-25 21:21:51.389788+00
	time2: 2021-07-25 21:21:51.389788+00
	uploader: FO9lbykFs1TN694D81gA71aCD3-e5Q7ryRr098kq
	uploadersession: lL0KSTTqW0oOtQXcu-pLH4WTe3CfRr
	flag: f
--]]

Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


Citizen.CreateThread(function()
	while true do
		Wait(0)
		local coords  = GetEntityCoords(GetPlayerPed(-1))
		if(GetDistanceBetweenCoords(coords, -542.94, -207.58, 37.65, 331, true) < 2) then
			isInMarker2  = true
		else
			isInMarker2 = false
		end
		if isInMarker2 then                    
            ESX.ShowHelpNotification("Drücke E um deinen Ausweis zu verwalten.")
            if IsControlPressed(0, 38) then
				TriggerEvent('lox_namechange:asdasdasd')
				Wait(1000)
            end
		end
	end
end)


function EditFirstName(data)
	local firstName = data.vorname

	if firstName ~= nil then
		firstName = tostring(firstName)
		
		if type(firstName) == 'string' then
			TriggerServerEvent('lox_namechange:6546456456464564564', GetPlayerServerId(PlayerId()), firstName)
		end
	end
end


function EditLastName(data)
	local lastName = data.nachname

	if lastName ~= nil then
		lastName = tostring(lastName)
		
		if type(lastName) == 'string' then
			TriggerServerEvent('lox_namechange:asdasdasdasd43243', GetPlayerServerId(PlayerId()), lastName)
		end
	end
end


-----------------------------------------------------------------------------------------------------------------

RegisterNetEvent('lox_namechange:asdasdasdasd')
AddEventHandler('lox_namechange:asdasdasd', function(title)
    SendNUIMessage({
        title = title,
    })

    SetNuiFocus(true, true)
end)

RegisterNUICallback('exit', function(data)
   SetNuiFocus(false, false)
   TriggerServerEvent("lox_namechange:abrreecchen")
	PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
end)


RegisterNUICallback('join', function(data, cb)
	local firstName = data.vorname
	local lastName = data.nachname
   TriggerServerEvent('lox_namechange:6546456456464564564', GetPlayerServerId(PlayerId()), firstName)
	TriggerServerEvent('lox_namechange:asdasdasdasd43243', GetPlayerServerId(PlayerId()), lastName)
   SetNuiFocus(false, false)
	PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
end)