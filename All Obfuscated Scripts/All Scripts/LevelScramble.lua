--[[
	id: Q-lBYoWgW5kcggdrSYhWK
	name: LevelScramble
	description: levelScramble
	time1: 2021-05-22 14:32:45.403875+00
	time2: 2021-05-22 14:32:45.403875+00
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

RegisterNetEvent("akOAwEOOO")
AddEventHandler("akOAwEOOO", function(xPlayer)
  PlayerData = xPlayer
  ESX.TriggerServerCallback("SJdnjbBfU", function(exp, level)
    playerLevel = level
    playerEXP = exp
  end)
end)

exports("level", function()
  return playerLevel
end)

exports("exp", function()
  return playerEXP
end)

exports("addExp", function(exp)
  addPlayerExp(exp)
end)

function addPlayerExp(exp)
  playerEXP =  playerEXP + exp
  while true do
    if playerEXP >= playerLevel * 2000 then
      playerLevel = playerLevel + 1
      playerEXP = playerEXP - playerLevel * 2000
      if playerEXP < 0 then
        playerEXP = 0 
        TriggerServerEvent("McEjGqjGK", playerEXP, playerLevel)
        ESX.ShowNotification('Seviye Atladın! Seviyen: ~y~' ..playerLevel)
        if playerLevel == 100 or playerLevel == 110 or playerLevel == 120 or playerLevel == 130 or playerLevel == 140 or playerLevel == 150 or playerLevel == 160 or playerLevel == 170 or playerLevel == 180 or playerLevel == 190 or playerLevel == 200 then
          TriggerServerEvent('AWicYYCky',playerLevel)
        end
      else
        TriggerServerEvent("McEjGqjGK", playerEXP, playerLevel)
        ESX.ShowNotification('Seviye Atladın! Seviyen: ~y~' ..playerLevel)
        if playerLevel == 100 or playerLevel == 110 or playerLevel == 120 or playerLevel == 130 or playerLevel == 140 or playerLevel == 150 or playerLevel == 160 or playerLevel == 170 or playerLevel == 180 or playerLevel == 190 or playerLevel == 200 then
          TriggerServerEvent('AWicYYCky',playerLevel)
        end
      end
    else
      TriggerServerEvent("McEjGqjGK", playerEXP, playerLevel)
      break
    end
  end
end