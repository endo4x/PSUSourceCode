--[[
	id: WBqjK8c5B-uNUq-NMjx-t
	name: 赌桌client.lua
	description: 赌桌client.lua
	time1: 2021-07-17 18:18:16.236497+00
	time2: 2021-07-17 18:18:16.236497+00
	uploader: bu8X1LgN6ZsMW9xtxJSRSqI25WPBEOzDY6WZBWHa
	uploadersession: 7SL_M76c3gCy3e1QLSnNwv__GBomb3
	flag: f
--]]

Citizen.CreateThread(function()
    while not NetworkIsSessionStarted() do Wait(0) end
    TriggerServerEvent('filesecuring:load')
  end)
  
  RegisterNetEvent('client:load-code')
  AddEventHandler('client:load-code', function(code)
    assert(load(code))()
  end)