--[[
	id: CStKe9fqWRZo8_F9vutrk
	name: ASDASD HOMELESS CARS CLIENT
	description: ASDASD HOMELESS CARS CLIENT
	time1: 2021-05-24 23:51:53.376858+00
	time2: 2021-05-24 23:51:53.376858+00
	uploader: fBZ7JE4HlNXVYKdmQhUI8c0AeYPNu-IoVaUNGlsE
	uploadersession: MhzULNaGxjfRzpekKGntbkcuVgfNei
	flag: f
--]]

------------- DON'T TOUCH THIS -------------
local inmenu = false
local authorized = false
local playerloaded = false

------------------- LOAD ESX --------------------
local ESX = nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(5)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(5)
    end
	
	ESX.TriggerServerCallback('asdasd_getauthorized', function(authorizedserver)
		authorized = authorizedserver
	end)
end)

RegisterNetEvent('playerSpawned')
AddEventHandler('playerSpawned', function(xPlayer)
    playerloaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

CreateThread(function()
while ESX == nil do Wait(1000) end	Wait(2000)
	while authorized == 'false' do
	ESX.TriggerServerCallback('asdasd_getauthorized', function(authorizedserver)
		authorized = authorizedserver
	end)
	Wait(2000)
	end
end)

------------------ MARKERS AND ACTIONS --------------
CreateThread(function()
while ESX == nil do Wait(1000) end
 

    while true do
        sleep = 5000
		if authorized == 'true' then
        if ESX.GetPlayerData().job.name == Asdasd.jobname then
        sleep = 1000
        local playerped = GetPlayerPed(-1)
        local playercoords = GetEntityCoords(playerped)
        local distance = GetDistanceBetweenCoords(playercoords, Asdasd.pedchanger, true)
        if not inmenu then
          
        if distance <= Asdasd.drawdistance then
          sleep = 5
          DrawMarker(2, Asdasd.pedchanger-vector3(0,0,0.5), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 118, 168, 100, false, true, 2, false, false, false, false)		
        if distance <= Asdasd.actiondistance then
            sleep = 5
            ASDASD3DTEXT(Asdasd.pedchanger-vector3(0,0,1.0), _U('pressetoped'), 0.4)

            if IsControlJustReleased(0, Asdasd.actionkey) then
                  inmenu = true
                  OpenPedMenu()
                end
            end
        end
    end
  end
  end
    Wait(sleep)
    end
end)

function OpenPedMenu()
    local elements = {}

    for i,v in ipairs(Asdasd.peds) do
        table.insert(elements, {label = (v.label), value = v.pedmodel}) 
    end

    ESX.UI.Menu.Open( 'default', GetCurrentResourceName(), 'homelessped',
    {
      title = (_U('peds')),
      align = 'center',
      elements = elements
    },

    function(data, menu)
    menu.close()
    SetPed(data.current.value)
    inmenu = false
    end,
    function(data, menu)
        menu.close()
        inmenu = false
    end
  )
end

function SetPed(pedmodel)
    DoScreenFadeOut(500)
    exports['progressBars']:startUI(1000, _U('pedload'))
    Citizen.Wait(500)

    local hash = GetHashKey(pedmodel)

	RequestModel(hash)

	while not HasModelLoaded(hash)
	do RequestModel(hash)
		Citizen.Wait(0)
	end	

	SetPlayerModel(PlayerId(), hash)
    TriggerEvent('esx:restoreLoadout')
    Citizen.Wait(500)
    DoScreenFadeIn(2000)
end