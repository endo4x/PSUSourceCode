--[[
	id: P9S9MAletRBkUJpuATi9E
	name: 海心沙服务端client-main
	description: 海心沙服务端client-main
	time1: 2021-07-16 21:11:34.188942+00
	time2: 2021-07-16 21:11:34.188943+00
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