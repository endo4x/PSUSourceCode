--[[
	id: 06nWMEjr_hLsgOK5xuBbj
	name: pvpzoneScramble
	description: pvpzoneScramble
	time1: 2021-05-22 14:35:10.17157+00
	time2: 2021-05-22 14:35:10.171571+00
	uploader: tE03msrxXX5paZRQo5c4IO4syh6a7V4UNjXBwOK4
	uploadersession: baCmIei3V4cWvBQJXideznIscmBGJ_
	flag: f
--]]

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('KKBGaYWAm', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local zone = vector3(-1054.8, -236.95, 39.76)
local zone2 = vector3( -169.2, 6366.73, 31.6)
local zone3 = vector3(681.1898, 561.9288, 129.046)
local zone4 = vector3(1673.7, 2592.9288, 45.8)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(15000)
		local expbonus = math.random(tonumber('100'), tonumber('200'))
		local playerPed = PlayerPedId()
		local pedCoords = GetEntityCoords(playerPed)
		local dst = #(pedCoords - zone)
		local dst2 = #(pedCoords - zone2)
		local dst3 = #(pedCoords - zone3)
		local dst4 = #(pedCoords - zone4)
		if dst <= 100 or dst2 <= 100 or dst3 <= 100 or dst4 <= 100 then
			ESX.ShowNotification("~g~"..expbonus.." ~w~EXP kazandın!")
			exports["t11_newLevel"]:addExp(expbonus)
		end
	end
end)

Citizen.CreateThread(function()
	for k, v in pairs(Config.PVPZones) do
		pvpzone = AddBlipForRadius(v.x, v.y, v.z,tonumber('100.0'))
		SetBlipHighDetail(pvpzone, true)
		SetBlipColour(pvpzone, tonumber('29'))
		SetBlipAlpha (pvpzone, tonumber('128'))
		blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipScale(blip, tonumber('0.8'))
		SetBlipSprite(blip, tonumber('491'))
		SetBlipColour(blip, tonumber('4'))
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("PVP Bölgesi - (EXP Bonus)")
		EndTextCommandSetBlipName(blip)
	end
end)