--[[
	id: 8H2-k9G3eTIzzOS8NjFsm
	name: Shower
	description: Chev_shower
	time1: 2021-07-06 15:11:43.079321+00
	time2: 2021-07-06 15:11:43.079331+00
	uploader: fQ6CKou_mkGdyDJR3XWxLXn4zBXIL284gBWUk0La
	uploadersession: i5_w1VPL0EWOBb_Y7Hec6vK9ZxT0Sy
	flag: f
--]]

Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118, ["Enter"] = 191
}

ESX = nil
local shower = 0
local warm_add = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)

	end
	Citizen.Wait(500)


end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(status)

	Citizen.CreateThread(function()
		
		TriggerEvent('esx_status:registerStatus', 'shower', 1000000, '#0C98F1', function(status) --
			return true
		end, function(status)
			status.remove(100)
		end)
		
		Citizen.CreateThread(function()
			while true do
				Citizen.Wait(1000)

				TriggerEvent('esx_status:getStatus', 'shower', function(status)
					shower = status.val

				end)


				if shower >= 50001 then
					warm_add = false

					DeleteObject(addpropwarm)

				end


				if shower <= 50000 then

					if not warm_add then

						warm_add = true
						propadd()

					end


				end

			end
		end)

	end)
end)



RegisterNetEvent('shower:dropplayerdele')
AddEventHandler('shower:dropplayerdele', function()
	
	DeleteObject(addpropwarm)

end)


function propadd()


	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	local boneIndex = GetPedBoneIndex(ped, 20190)
	addpropwarm = CreateObject(GetHashKey("worm_prop_effect"), x, y, z , true, true, true)
	AttachEntityToEntity(addpropwarm, ped, boneIndex, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)


end



Citizen.CreateThread(function()
	while true do
      
	Citizen.Wait(0)
      
		local coords = GetEntityCoords(GetPlayerPed(-1))
		for k, v in pairs(Config["LocationShower"]) do
			if GetDistanceBetweenCoords(coords, v["x"], v["y"], v["z"], true) < 100 then
				DrawMarker(27, v["x"], v["y"], v["z"], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 2.0, 255, 0, 0, 100, false, true, 2, false, false, false, false)
				if GetDistanceBetweenCoords(coords, v["x"], v["y"], v["z"], true) < 1.5 then
					DrawText3D(v["x"], v["y"], v["z"]+0.9, '~g~[E] ~w~Washbody', 0.80)
					if IsControlPressed(0, 38) then
						if CheckItem(Config["Item"]) then
							local hashSkin = GetHashKey("mp_m_freemode_01") 	
							SetEntityCoords(GetPlayerPed(-1), v["x"], v["y"], v["z"])
							SetEntityHeading(GetPlayerPed(-1), v["h"])
							FreezeEntityPosition(GetPlayerPed(-1), true)
							if GetEntityModel(GetPlayerPed(-1)) == hashSkin then 

								TriggerEvent('skinchanger:getSkin', function(skin)
									local clothesSkin = {
									['tshirt_1'] = 15, ['tshirt_2'] = 0,
									['torso_1'] = 15, ['torso_2'] = 0,
									['arms'] = 15,
									['pants_1'] = 61, ['pants_2'] = 5,
									['shoes_1'] = 34, ['shoes_2'] = 0,
								}
								TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

							end)
							else

								TriggerEvent('skinchanger:getSkin', function(skin)
									local clothesSkin = {
									['tshirt_1'] = 15, ['tshirt_2'] = 0,
									['torso_1'] = 15, ['torso_2'] = 0,
									['arms'] = 15,
									['pants_1'] = 15, ['pants_2'] = 0,
									['shoes_1'] = 35, ['shoes_2'] = 0,
								}
								TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

								end)
							end
							Citizen.Wait(500)
							TriggerServerEvent(GetCurrentResourceName()..":synccoord_sv", GetPlayerServerId(PlayerId()), v["x"], v["y"], v["z"])
							-- TriggerServerEvent(GetCurrentResourceName()..":synccoord_sv",coords)

							-- CleanBody()
							Citizen.Wait(10025)
							DeleteObject(addpropwarm)
							DeleteObject(addpropwarm)
							TriggerEvent('esx_status:add', "shower" , 1000000)
						end
					end
				end
			end
		end
	end
end)




RegisterNetEvent(GetCurrentResourceName()..":synccoord_cl")
AddEventHandler(GetCurrentResourceName()..":synccoord_cl", function(ped, x, y, z)


		local Player = ped
		local PlayerPed = GetPlayerPed(GetPlayerFromServerId(ped))
		local particleDictionary = "core"
		local particleName = "exp_sht_steam"
		local animDictionary = 'mp_safehouseshower@male@'
		local animDictionary2 = 'mp_safehouseshower@female@'
		local animName = 'male_shower_idle_b'
		local animName2 = 'shower_idle_b'
		
		RequestAnimDict(animDictionary)

		while not HasAnimDictLoaded(animDictionary) do
			Citizen.Wait(0)
		end
						
		RequestAnimDict(animDictionary2)

		while not HasAnimDictLoaded(animDictionary2) do
			Citizen.Wait(0)
		end		
		TaskPlayAnim(PlayerPed, animDictionary, animName, 8.0, -8.0, -1, 0, 0, false, false, false)
		
		RequestNamedPtfxAsset(particleDictionary)

		while not HasNamedPtfxAssetLoaded(particleDictionary) do
			Citizen.Wait(0)
		end

		SetPtfxAssetNextCall(particleDictionary)
		
		-- local coords = GetEntityCoords(playerPed)
		local effect = StartParticleFxLoopedAtCoord(particleName, x, y, z+2.6, 0.0, 180.0, 0.0, 5.0, false, false, false, false)
		Wait(25)
		Wait(10000)
		FreezeEntityPosition(GetPlayerPed(-1), false)
		while not DoesParticleFxLoopedExist(effect) do
		Wait(5)
		end
		StopParticleFxLooped(effect, 0)
		Wait(25)
		StopParticleFxLooped(effect, 0)

		ClearPedTasks(PlayerPed)
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
		Wait(25)
		StopParticleFxLooped(effect, 0)
		end)
		SetPedWetnessHeight(PlayerPed, 1.0)

end)


function CheckItem(item_name)
	local inventory = ESX.GetPlayerData().inventory
	for i=1, #inventory do
		local item = inventory[i]
		if item_name == item.name and item.count > 0 then
  
			TriggerServerEvent(GetCurrentResourceName()..":deleitem")

		  return true
		end
	  end
  
	  TriggerEvent("pNotify:SendNotification",{
		  text = " <center><b style='color:yellow'>คุณต้องมี สระบู่</b><br /></center>",
		  type = "alert",
		  timeout = (3000),
		  layout = "bottomCenter",
		  queue = "global"
	  })
	  Wait(4000)
	  return false

end

function DrawText3D(x, y, z, text, scale)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
 
    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 215)
 
    AddTextComponentString(text)
    DrawText(_x, _y)
 
    local factor = (string.len(text)) / 230
    DrawRect(_x, _y + 0.0250, 0.095 + factor, 0.06, 41, 11, 41, 100)
end


function CheckShower(count)

	if shower <= count then

        return true
    else

		return false
	end

end


 ----PlayerDrop พรอบ


AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		DeleteObject(addpropwarm)

	end
end)