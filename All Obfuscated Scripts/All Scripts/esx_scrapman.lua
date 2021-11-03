--[[
	id: D_oJIwkIBpPlZRFG2JckL
	name: esx_scrapman
	description: ????
	time1: 2021-04-24 16:39:13.594693+00
	time2: 2021-04-24 16:39:13.594694+00
	uploader: FJIC7pcrNJaVRLxDGePzVkqOPXWh0QE9QApmYc4O
	uploadersession: _XxKdolx_RpReM5YGAWabY2RP6i8xC
	flag: f
--]]

local Keys = {
	["ESC"] = 322, ["BACKSPACE"] = 177, ["E"] = 38, ["ENTER"] = 18,	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173
}

ESX                           = nil
local PlayerData                = {}
local menuIsShowed 				 = false
local hasAlreadyEnteredMarker 	 = false
local hasAlreadyEnteredMarkerr 	 = false
local lastZone 					 = nil
local isInJoblistingMarker 		 = false
local isInJoblistingMarkerr 		 = false
local bet = 0
local wtrakcie = false
local bagModel = "prop_apple_box_01"
local bagspawned = nil
local maitem = false
local tekst = 0
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
end)
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	
	Citizen.Wait(5000)

end)

Citizen.CreateThread(function()
	while true do

		Citizen.Wait(5)
		local coords = GetEntityCoords(GetPlayerPed(-1))

			if(GetDistanceBetweenCoords(coords, -491.460, -1746.190, 18.70, true) < 10.0) or (GetDistanceBetweenCoords(coords, -491.870, -1756.750, 19.20, true) < 10.0) or (GetDistanceBetweenCoords(coords, 220.870, 6501.150, 31.20, true) < 10.0) then

					ESX.Game.Utils.DrawText3D({ x = -491.740, y = -1746.890, z = 19.30 }, '~y~[E] ~w~Raccolta rottami.', 0.6)		
					ESX.Game.Utils.DrawText3D({ x = -491.470, y = -1756.750, z = 19.00 }, '~y~[E] ~w~Raccolta rottami.', 0.6)	
					ESX.Game.Utils.DrawText3D({ x = -498.250, y = -1756.160, z = 19.00 }, '~y~[E] ~w~Raccolta rottami.', 0.6)				

	end
	end
end)
function HelpText(text)
  SetTextComponentFormat("STRING")
  AddTextComponentString(text)
  DisplayHelpTextFromStringLabel(0, 0, 0, -1)
end


Citizen.CreateThread(function()
	while true do

		Wait(15)
		local coords      = GetEntityCoords(GetPlayerPed(-1))


if (GetDistanceBetweenCoords(coords, -491.740, -1746.890, 19.00, true) < 4.0) or (GetDistanceBetweenCoords(coords, -491.470, -1756.750, 18.70, true) < 4.0) or (GetDistanceBetweenCoords(coords, -498.250, -1756.160, 18.70, true) < 4.0) then


			local coords      = GetEntityCoords(GetPlayerPed(-1))
			local isInMarker  = false
			local currentZone = nil
      local zaplata = 0


					if ESX.GetPlayerData().job.name == 'multijob' then
								if IsControlJustReleased(0, Keys['E']) then
									if wtrakcie == false and maitem == false then
                                      zbieranie()
									end
								end
						end
		end -- od getdistance
		end -- od while
end)

function zbieranie()
TriggerServerEvent('smerfikcraft:zlomiarzzbier')
wtrakcie = true
end



RegisterNetEvent('smerfik:zamrozcrft22')
AddEventHandler('smerfik:zamrozcrft22', function()
	playerPed = PlayerPedId()	
	ClearPedTasks(PlayerPedId())
	FreezeEntityPosition(playerPed, true)
end)
RegisterNetEvent('smerfik:odmrozcrft22')
AddEventHandler('smerfik:odmrozcrft22', function()
	playerPed = PlayerPedId()
	FreezeEntityPosition(playerPed, false)
	ClearPedTasks(PlayerPedId())

	


maitem = true
Citizen.Wait(1000)
	wtrakcie = false
	TriggerEvent('podlacz:propa2')

end)


RegisterNetEvent('smerfik:craftanimacja22')
AddEventHandler('smerfik:craftanimacja22', function()
	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
Citizen.Wait(2000)
end)



function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(10)
	end
end
Citizen.CreateThread(function()
  
    RequestModel(GetHashKey("s_m_m_dockwork_01"))
    while not HasModelLoaded(GetHashKey("s_m_m_dockwork_01")) do
      Wait(155)
    end

      local ped =  CreatePed(4, GetHashKey("s_m_m_dockwork_01"), -425.16, -1722.05, 18.20, 349.404, false, true)
      FreezeEntityPosition(ped, true)
      SetEntityInvincible(ped, true)
      SetBlockingOfNonTemporaryEvents(ped, true)
end)

Citizen.CreateThread(function()
	while true do

		Wait(5)
		local coords  = GetEntityCoords(GetPlayerPed(-1))


if(GetDistanceBetweenCoords(coords, -429.870, -1728.850, 19.90, true) < 20.0) or (GetDistanceBetweenCoords(coords, -1040.660, 5329.250, 43.370, true) < 5.0) then
	if ESX.GetPlayerData().job.name == 'multijob' then

	ESX.Game.Utils.DrawText3D({ x = -429.870, y = -1728.850, z = -1900.90 }, '~y~[E] ~w~Guardaroba', 0.6)	
			local coords      = GetEntityCoords(GetPlayerPed(-1))

                        local zaplata = 0

						if(GetDistanceBetweenCoords(coords, -423.260, -1720.750, 19.370, true) < 3.0) then
							ESX.ShowAdvancedNotification('Vendita di rottami', '~y~Sfasciacarrozze', '~y~[E] ~w~Vendi', 'CHAR_PROPERTY_CAR_SCRAP_YARD', 3)
								if IsControlJustReleased(0, Keys['E']) then
                            		  skup()
								end

							end
	

								
								if(GetDistanceBetweenCoords(coords, -429.870, -1728.850, 19.90, true) < 5.0) then
							
									if IsControlJustReleased(0, Keys['E']) then
										
									ubrania()
								end
	
								end	
						end
		end
		end

end)
function ubrania()

	TriggerEvent('skinchanger:getSkin', function(skin)
	
		if skin.tshirt_1 == 59 and skin.torso_1 == 56 then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
				end)
				
			else
				local clothesSkin = {
					['tshirt_1'] = 59, ['tshirt_2'] = 1,
					['torso_1'] = 56, ['torso_2'] = 0,
					['arms'] = 52, ['arms_2'] = 0,
					['pants_1'] = 9, ['pants_2'] = 1,
					['helmet_1'] = 85,  ['helmet_2'] = 0,
					['shoes_1'] = 9, ['shoes_2'] = 2
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
				
		end
	end)
end
RegisterNetEvent('podlacz:propa2')
AddEventHandler('podlacz:propa2', function()
	local ad = "anim@heists@box_carry@"
	loadAnimDict( ad )
	TaskPlayAnim( PlayerPedId(), ad, "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )

	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	local szn = math.random(1,3)
	if szn == 1 then
		bagModel = 'prop_car_door_01'
		bagspawned = CreateObject(GetHashKey(bagModel), x, y, z+0.2,  true,  true, true)
		AttachEntityToEntity(bagspawned, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.025, 0.00, 0.355, -75.0, 470.0, 0.0, true, true, false, true, 1, true)
		Citizen.Wait(10000)

	elseif szn == 2 then
		bagModel = 'prop_car_seat'
		bagspawned = CreateObject(GetHashKey(bagModel), x, y, z+0.2,  true,  true, true)
		AttachEntityToEntity(bagspawned, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.025, 0.00, 0.355, -045.0, 480.0, 0.0, true, true, false, true, 1, true)
		Citizen.Wait(10000)

	else	
		bagModel = 'prop_rub_bike_02'
		bagspawned = CreateObject(GetHashKey(bagModel), x, y, z,  true,  true, true)
		AttachEntityToEntity(bagspawned, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.125, -0.50, 0.355, -045.0, 410.0, 0.0, true, true, false, true, 1, true)
		Citizen.Wait(10000)

	end

end)
RegisterNetEvent('sprzedawanie:jablekanim2')
AddEventHandler('sprzedawanie:jablekanim2', function()

	local playerPed = PlayerPedId()
	local lib, anim = 'gestures@m@standing@casual', 'gesture_easy_now'
	FreezeEntityPosition(playerPed, true)
	ESX.Streaming.RequestAnimDict(lib, function()
	TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
end)
end)
function skup()

	TriggerServerEvent('smerfikcraft:skup2')

Citizen.Wait(3500)
	Citizen.Wait(13000)
	FreezeEntityPosition(PlayerPedId(), false)

	wtrakcie = false
end
	
RegisterNetEvent('odlacz:propa')
AddEventHandler('odlacz:propa', function()
	DetachEntity(bagspawned, 1, 1)
	DeleteObject(bagspawned)
	maitem = false
	ClearPedSecondaryTask(PlayerPedId())
	FreezeEntityPosition(PlayerPedId(), false)
end)

local blips = {

	--{title="Raccolta di rottami metallici", colour=5, id=468, x = -491.240, y = -1753.890, z = 19.00},
	--{title="Base di metallo di scarto", colour=5, id=488, x = -430.060, y = -1726.750, z = 29.90},
	--{title="Gruppo di rottura", colour=5, id=479, x = -422.020, y = -1720.250, z = 43.370}

}      
Citizen.CreateThread(function()

   for _, info in pairs(blips) do
	 info.blip = AddBlipForCoord(info.x, info.y, info.z)
	 SetBlipSprite(info.blip, info.id)
	 SetBlipDisplay(info.blip, 4)
	 SetBlipScale(info.blip, 1.0)
	 SetBlipColour(info.blip, info.colour)
	 SetBlipAsShortRange(info.blip, true)
	 BeginTextCommandSetBlipName("STRING")
	 AddTextComponentString(info.title)
	 EndTextCommandSetBlipName(info.blip)
   end

end)

local UI = { 

	x =  0.000 ,	-- Base Screen Coords 	+ 	 x
	y = -0.001 ,	-- Base Screen Coords 	+ 	-y

}
RegisterNetEvent('smerfik:tekstjab2')
AddEventHandler('smerfik:tekstjab2', function()
while true do
	Citizen.Wait(1)
	if wtrakcie == true then

	drawTxt(UI.x + 0.9605, UI.y + 0.962, 1.0,0.98,0.4, "~y~[~w~".. tekst .. "%~y~]", 255, 255, 255, 255)

end
end
end)
function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
	SetTextFont(4)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(2, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x - width/2, y - height/2 + 0.005)
end
RegisterNetEvent('smerfik:zdejmijznaczek2')
AddEventHandler('smerfik:zdejmijznaczek2', function()
wtrakcie = false
end)
RegisterNetEvent('zacznijtekst2')
AddEventHandler('zacznijtekst2', function()
	Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1
Citizen.Wait(37)
tekst = tekst + 1

Citizen.Wait(1500)
tekst = 0
end)

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

