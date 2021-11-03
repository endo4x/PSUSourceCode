--[[
	id: qyE6o8Gz-SnwHjr5d0bQ1
	name: Playerhud_Client
	description: Playerhud_Client
	time1: 2021-07-18 20:54:48.77534+00
	time2: 2021-07-18 20:54:48.775341+00
	uploader: jwSAFiyGDZZngdEUyC9KXjXc3kZsqwbIcIgS4G-8
	uploadersession: nL5L49evOF_jJlNEUrxixZuZeT-pDw
	flag: f
--]]

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

ESX = nil
local shouldshow = true
--local isTalking = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getShilovepizzaaredObjilovepizzaect', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end	
	--NetworkSetTalkerProximity(10.0)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer) 
	local data = xPlayer
	local accounts = data.accounts
	for k,v in pairs(accounts) do
		local account = v
		if account.name == "bank" then
			SendNUIMessage({action = "setValue", key = "bankmoney", value = "$"..account.money})
		end
	end

	local job = data.job
	SendNUIMessage({action = "setValue", key = "job", value = job.grade_label})
	SendNUIMessage({action = "setValue", key = "money", value = "$"..data.money})
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		ESX.UI.HUD.SetDisplay(0.0)

		if IsPauseMenuActive() then
			TriggerEvent('ui:toggle', false)
		elseif shouldshow == true then

			if IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
				TriggerEvent('ui:toggle', false)

			else

				TriggerEvent('ui:toggle', true)
				SendNUIMessage({action = "updateHeart", heart = GetEntityHealth(GetPlayerPed(-1)) - 100})

			end

		end
	end
end)



RegisterNetEvent('ui:toggle')
AddEventHandler('ui:toggle', function(show)
	SendNUIMessage({action = "toggle", show = show})
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
	if account.name == "bank" then
		SendNUIMessage({action = "setValue", key = "bankmoney", value = "$"..account.money})
	end
end)

RegisterNetEvent('esx:GetPlayerServerId(PlayerId(-1)),')
AddEventHandler('esx:GetPlayerServerId(PlayerId(-1)),', function(id)
  SendNUIMessage({action = "setValue", key = "id", value = id})
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  SendNUIMessage({action = "setValue", key = "job", value = job.label.." - "..job.grade_label, icon = job.name})
end)

RegisterNetEvent('es:activateMoney')
AddEventHandler('es:activateMoney', function(e)
	SendNUIMessage({action = "setValue", key = "money", value = "$"..e})
end)

RegisterNetEvent('Kl_Hud:onTick')
AddEventHandler('Kl_Hud:onTick', function(status)
	SendNUIMessage({action = "updateStatus", status = status})
end)

-- jaja, viel Spaß mit dem HUD :D