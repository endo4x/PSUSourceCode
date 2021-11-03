--[[
	id: SE3uKbkSdz7Uw-ctudbuZ
	name: level
	description: level
	time1: 2021-05-17 11:45:02.663704+00
	time2: 2021-05-17 11:45:02.663704+00
	uploader: tE03msrxXX5paZRQo5c4IO4syh6a7V4UNjXBwOK4
	uploadersession: baCmIei3V4cWvBQJXideznIscmBGJ_
	flag: f
--]]

ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(xPlayer)
  PlayerData = xPlayer
  ESX.TriggerServerCallback("t11_newLevel:checkData", function(exp, level)
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
        TriggerServerEvent("t11_newLevel:addExp", playerEXP, playerLevel)
        ESX.ShowNotification('Seviye Atladın! Seviyen: ~y~' ..playerLevel)
        if playerLevel == 100 or playerLevel == 110 or playerLevel == 120 or playerLevel == 130 or playerLevel == 140 or playerLevel == 150 or playerLevel == 160 or playerLevel == 170 or playerLevel == 180 or playerLevel == 190 or playerLevel == 200 then
          TriggerServerEvent('t11levelbonus',playerLevel)
        end
      else
        TriggerServerEvent("t11_newLevel:addExp", playerEXP, playerLevel)
        ESX.ShowNotification('Seviye Atladın! Seviyen: ~y~' ..playerLevel)
        if playerLevel == 100 or playerLevel == 110 or playerLevel == 120 or playerLevel == 130 or playerLevel == 140 or playerLevel == 150 or playerLevel == 160 or playerLevel == 170 or playerLevel == 180 or playerLevel == 190 or playerLevel == 200 then
          TriggerServerEvent('t11levelbonus',playerLevel)
        end
      end
    else
      TriggerServerEvent("t11_newLevel:addExp", playerEXP, playerLevel)
      break
    end
  end
end