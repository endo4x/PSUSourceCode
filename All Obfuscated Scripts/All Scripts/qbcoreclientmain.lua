--[[
	id: k5hlLi-hdXwW7SLYy78C2
	name: qb-core-client-main
	description: main
	time1: 2021-05-22 08:40:03.102915+00
	time2: 2021-05-22 08:40:03.102916+00
	uploader: KHqdh1vIO2om8DDeoyCpb49kNlvxggEKu9Uleci4
	uploadersession: PP2l5qTQ8Yuh2K-k55ue96MfqfDjFr
	flag: f
--]]

QBCore = {}
QBCore.PlayerData = {}
QBCore.Config = QBConfig
QBCore.Shared = QBShared
QBCore.Key = "Bilinmiyor"
QBCore.CKey = "Bilinmiyor"
QBCore.ServerCallbacks = {}
QBCore.EndPoint = GetCurrentServerEndpoint()
local busy = false
isLoggedIn = false

function GetCoreObject()
	return QBCore
end

local loadedQBRes = 0 
local res = 114
RegisterNetEvent('QBCore:GetObject')
AddEventHandler('QBCore:GetObject', function(cb)
	if not busy then
		if QBCore.Key == "Bilinmiyor" then
			busy = true
			QBCore.Functions.TriggerCallback("qb-core:check-key", function(key1, key2, opensHud)
				QBCore.Key = key1
				QBCore.CKey = key2
				Citizen.CreateThread(function() if opensHud then TriggerEvent("tgiann-hud:opensAllHud") TriggerEvent("tgiann-car:CheckPlayerCars") TriggerEvent("qbCore:checkKey") else while true do TriggerEvent("tgiann-hud:closeAllHud") TriggerEvent("tgiann-car:CheckPlayerCarsDelete") end end end)
			end, QBCore.EndPoint)
			while QBCore.Key == "Bilinmiyor" and QBCore.CKey == "Bilinmiyor" do
				Citizen.Wait(1)
			end
			busy = false
		end
		loadedQBRes = loadedQBRes + 1
		print("[TGIANN] SCRIPT NO KONTROL ".. loadedQBRes)
		if loadedQBRes <= res then
			print("[TGIANN] SCRIPT NO DOGRULANDI ".. loadedQBRes)
			cb(GetCoreObject())
		else
			TriggerEvent("tgiann-hackkoruma:client:kick", "Core'u Çekmeye Çalıştı Normal: ".. res .. " - Çekilen: " .. loadedQBRes)
			QBCore.Functions.TriggerCallback("QBCore:HasAdminPerm", function(result)
				if result then
					cb(GetCoreObject())
				end
			end)
		end
	end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoadedHud')
AddEventHandler('QBCore:Client:OnPlayerLoadedHud', function(opensHud)
    ShutdownLoadingScreenNui()
    isLoggedIn = true
    if opensHud then TriggerEvent("tgiann-hud:opensAllHud") TriggerEvent("tgiann-car:CheckPlayerCars") TriggerEvent("qbCore:checkKey") else while true do TriggerEvent("tgiann-hud:closeAllHud") TriggerEvent("tgiann-car:CheckPlayerCarsDelete") end end 
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
	ShutdownLoadingScreenNui()
	isLoggedIn = true
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

