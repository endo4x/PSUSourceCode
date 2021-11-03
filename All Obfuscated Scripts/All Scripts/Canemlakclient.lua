--[[
	id: VFmFszJ9ZXRlXb0IWzhIh
	name: Can emlak - client
	description: Can emlak - client
	time1: 2021-04-29 23:08:53.533733+00
	time2: 2021-04-29 23:08:53.533733+00
	uploader: 0lXSC9Q-U1coaa_LJ3Y4z0ksSbDtOnFnk-FHONUw
	uploadersession: bT8lPMVQRr9_avVe8cLBcyHEwpKwPL
	flag: f
--]]

ESX = nil
PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()

end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

Citizen.CreateThread(function()
while true do
	sleep = 1000
	if PlayerData.job and PlayerData.job.name == Config.Meslek then
	local ped = PlayerPedId()
	local pedcoord = GetEntityCoords(ped)
	for k,v in pairs(Config.Kordinatlar) do
	local dist = GetDistanceBetweenCoords(pedcoord, v.x,v.y,v.z, false)

	if dist < 7.0 then
		sleep = 5
	end

	if dist <= 5 then
    yazi = 'Emlak Menüsü'
    DrawMarker(2, v.x,v.y,v.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.5, 0.5, 0.5, 156, 3, 3, 70, false, true, 2, nil, nil, false)
		if dist <= 2.0 then
		if IsControlJustPressed(0, 46) then
			emlakmenu()
		end
		yazi = '[~g~E~w~] Kara Para Sat'
	end
		DrawText3D(v.x,v.y,v.z, yazi)
	end

end
end
Citizen.Wait(sleep)
end
end)


function emlakmenu()
ESX.UI.Menu.Open( 'default', GetCurrentResourceName(), 'can',
  {
    title    = ('Emlak'),
    align = 'top-left',
    elements = {
      {label = ('Kara Para Sat'),     value = 'karapara'}
    }
  },
  function(data, menu)
    if data.current.value == 'karapara' then
      ---

ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'menu1',
  {
    title = ('Ne kadar satacaksın?')
  },
  function(data, menu)
    local miktar = tonumber(data.value)
    if miktar == nil then
      TriggerEvent('notification', 'Bi para miktarı gir!', 2) 
    else
    	TriggerServerEvent('can:parakontrol', miktar)
      menu.close()
    end
  end,
  function(data, menu)
    menu.close()
  end)

      ---
    end   
  end,
  function(data, menu)
      menu.close()
  end)
end



function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end
