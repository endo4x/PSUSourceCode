--[[
	id: FBsTriNEOPbyKzYBpx9Dg
	name: Adminmenu | Client
	description: Adminmenu | Client
	time1: 2021-06-03 20:14:06.277048+00
	time2: 2021-06-03 20:14:06.277049+00
	uploader: lqGTM7c9511nXgsYGn6GipciWzXeF4k1dlePPmkB
	uploadersession: kei8QVOxGrWrbSu-4mcMQRX3yAF2rK
	flag: f
--]]

Fly = nil

local PersonalMenu = {
	ItemSelected = {},
	ItemIndex = {},
    TicketSys = {},
}

Player = {
	isDead = false,
	noclip = false,
	showCoords = false,
	showName = false,
	gamerTags = {},
	group = 'user'
}




local duty = false
local healwestetest = false
local RedM = false


Citizen.CreateThread(function()
	while Fly == nil do
		TriggerEvent('fly:getSharedObject', function(obj) Fly = obj end)
		Citizen.Wait(500)
	end

	while Fly.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end


	Fly.PlayerData = Fly.GetPlayerData()

	while actualSkin == nil do
		TriggerEvent('skinchanger:getSkin', function(skin)
			actualSkin = skin
		end)

		Citizen.Wait(10)
	end


	PersonalMenu.WeaponData = Fly.GetWeaponList()

	for i = 1, #PersonalMenu.WeaponData, 1 do
		if PersonalMenu.WeaponData[i].name == 'WEAPON_UNARMED' then
			PersonalMenu.WeaponData[i] = nil
		else
			PersonalMenu.WeaponData[i].hash = GetHashKey(PersonalMenu.WeaponData[i].name)
		end
	end



	RMenu.Add('rageui', 'personal', RageUI.CreateMenu(Config.MenuTitle, _U('mainmenu_subtitle'), 0, 0, 'commonmenu', 'interaction_bgd', 255, 255, 255, 255))


	RMenu.Add('personal', 'wallet', RageUI.CreateSubMenu(RMenu.Get('rageui', 'personal'), _U('adminfunktion')), function()
		if Player.group ~= nil and (Player.group == Config.RankHP1 or Player.group == Config.RankHP2 or Player.group == Config.RankHP3 or Player.group == Config.RankHP4 or Player.group == Config.RankHP5 or Player.group == Config.RankHP6 or Player.group == Config.RankHP7 or Player.group == '') then
			return true
		end

		return false
	end)


		RMenu.Add('personal', 'admin', RageUI.CreateSubMenu(RMenu.Get('rageui', 'personal'), _U('admin_title')), function()
			if Player.group ~= nil and (Player.group == Config.RankSLM1 or Player.group == Config.RankSLM2 or Player.group == Config.RankSLM3 or Player.group == Config.RankSLM4 or Player.group == Config.RankSLM5 or Player.group == Config.RankSLM6 or Player.group == Config.RankSLM7 or Player.group == '') then
			return true
		end

		return false
		end)


	RMenu.Add('personal', 'vehiclemenu', RageUI.CreateSubMenu(RMenu.Get('rageui', 'personal'), _U('vehiclemenu_title')), function()
				if Player.group ~= nil and (Player.group == Config.RankVM1 or Player.group == Config.RankVM2 or Player.group == Config.RankVM3 or Player.group == Config.RankVM4 or Player.group == Config.RankVM5 or Player.group == Config.RankVM6 or Player.group == Config.RankVM7 or Player.group == '') then
			return true
		end

		return false
		end)



	RMenu.Add('personal', 'weaponmenu', RageUI.CreateSubMenu(RMenu.Get('rageui', 'personal'), _U('weaponmenu_title')), function()
		if Player.group ~= nil and (Player.group == Config.RankWP1 or Player.group == Config.RankWP2 or Player.group == Config.RankWP3 or Player.group == Config.RankWP4 or Player.group == Config.RankWP5 or Player.group == Config.RankWP6 or Player.group == Config.RankWP7 or Player.group == '') then
			return true
		end

		return false
	end)
end)


RegisterNetEvent('fly:playerLoaded')
AddEventHandler('fly:playerLoaded', function(xPlayer)
	Fly.PlayerData = xPlayer
end)

function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
	AddTextEntry(entryTitle, textEntry)
	DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end

	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		blockinput = false
		return result
	else
		Citizen.Wait(500)
		blockinput = false
		return nil
	end
end


function getCamDirection()
	local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(plyPed)
	local pitch = GetGameplayCamRelativePitch()
	local coords = vector3(-math.sin(heading * math.pi / 180.0), math.cos(heading * math.pi / 180.0), math.sin(pitch * math.pi / 180.0))
	local len = math.sqrt((coords.x * coords.x) + (coords.y * coords.y) + (coords.z * coords.z))

	if len ~= 0 then
		coords = coords / len
	end

	return coords
end

function CheckQuantity(number)
	number = tonumber(number)

	if type(number) == 'number' then
		number = Fly.Math.Round(number)

		if number > 0 then
			return true, number
		end
	end

	return false, number
end

function RenderPersonalMenu()
	RageUI.DrawContent({header = true, instructionalButton = true}, function()
		for i = 1, #RMenu['personal'], 1 do
			if type(RMenu['personal'][i].Restriction) == 'function' then
				if RMenu['personal'][i].Restriction() then
					RageUI.Button(RMenu['personal'][i].Menu.Title, nil, {RightLabel = "→→→"}, true, function() end, RMenu['personal'][i].Menu)
				end
			else
				RageUI.Button(RMenu['personal'][i].Menu.Title, nil, {RightLabel = "→→→"}, true, function() end, RMenu['personal'][i].Menu)
			end
		end
	end)
end



function RenderWalletMenu()
	RageUI.DrawContent({header = true, instructionalButton = true}, function()
		--local onlinePlayers = GetNumberOfPlayers()
		--		RageUI.Button(_U('playeronline', onlinePlayers), nil, {}, true, function() end)
		RageUI.Button(_U('rank_anzeige', Player.group), nil, {}, true, function() end)


			RageUI.Button(_U('adminkleidung'), nil, {}, true, function(Hovered, Active, Selected)
				if (Selected) then
						TriggerEvent("toggleDuty", source)
				end
			end)

			RageUI.Button(_U('normalhealthtest'), nil, {}, true, function(Hovered, Active, Selected)
				if (Selected) then
                    TriggerEvent("j-adminmenü:normalhealth")
				end
			end)


			RageUI.Button(_U('healthdichselber'), nil, {}, true, function(Hovered, Active, Selected)
				if (Selected) then
                    TriggerEvent("j-adminmenü:healwestetest")
				end
			end)


			RageUI.Button(_U('noclip'), nil, {}, true, function(Hovered, Active, Selected)
				if (Selected) then
					TriggerEvent("toggleNoClip", source)
			end
			end)

			RageUI.Button(_U('bring'), nil, {}, true, function(Hovered, Active, Selected)
				if (Selected) then
					TriggerEvent("bringe")
				end

			end)

			RageUI.Button(_U('tpn'), nil, {}, true, function(Hovered, Active, Selected)
				if (Selected) then
					TriggerEvent("goto")
				end
			end)

			RageUI.Button(_U('reviveplayer'), nil, {}, true, function(Hovered, Active, Selected)
				if (Selected) then
					TriggerEvent("revive")
				end
			end)

		--	RageUI.Button(_U('killplayer'), nil, {}, true, function(Hovered, Active, Selected)
		--		if (Selected) then
			--		TriggerEvent("killplayer")
		--		end
		--	end)


			RageUI.Button(_U('kickplayer'), nil, {}, true, function(Hovered, Active, Selected)
			if (Selected) then
					TriggerEvent("kickplayer")
				end
			end)

			RageUI.Button(_U('Bargeld'), nil, {}, true, function(Hovered, Active, Selected)
			if (Selected) then
					TriggerEvent("givebargeldduhsichgibdirbagreldduhstralal")
				end
			end)

			RageUI.Button(_U('Schwarzgeld'), nil, {}, true, function(Hovered, Active, Selected)
			if (Selected) then
					TriggerEvent("schwarzgeldgebenduhsndirridshschwargeld")
				end
			end)


			
	end)
end







function vehiclemenu()
	RageUI.DrawContent({header = true, instructionalButton = true}, function()



      	RageUI.Button(_U('admin_spawnveh_button'), nil, {}, true, function(Hovered, Active, Selected)
				if (Selected) then
					TriggerEvent("spawnveh")
				end
			end)
      	RageUI.Button(_U('repair'), nil, {}, true, function(Hovered, Active, Selected)
			if (Selected) then
              TriggerEvent("repairv")
				end
			end)

      	RageUI.Button(_U('delcar'), nil, {}, true, function(Hovered, Active, Selected)
				if (Selected) then
					TriggerEvent("delcar")
				end
			end)




			
	end)
end



function giveWeapon(hash)
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(hash), 999, false, false)
end



function weaponmenu()
	RageUI.DrawContent({header = true, instructionalButton = true}, function()

      	RageUI.Button(_U('standardsetup'), nil, {}, true, function(Hovered, Active, Selected)
				if (Selected) then
        giveWeapon("weapon_switchblade")
        giveWeapon("weapon_pistol")
        giveWeapon("weapon_advancedrifle")
        giveWeapon("weapon_minismg")
				end
			end)



      	RageUI.Button(_U('waffenloschen'), nil, {}, true, function(Hovered, Active, Selected)
			if (Selected) then
               RemoveAllPedWeapons(GetPlayerPed(-1), true)
              TriggerEvent('notify', 3, "Adminmenü", "Du hast alle deine Waffen gelöscht")
				end
			end)




			
	end)
end








function cleanPlayer(playerPed)
    SetPedArmour(playerPed, 0)
    ClearPedBloodDamage(playerPed)
    ResetPedVisibleDamage(playerPed)
    ClearPedLastWeaponDamage(playerPed)
    ResetPedMovementClipset(playerPed, 0)
end


RegisterNetEvent("j-adminmenü:killPlayer")
AddEventHandler("j-adminmenü:killPlayer", function()
  SetEntityHealth(PlayerPedId(), 0)
end)

RegisterNetEvent("j-adminmenü:healwestetest")
AddEventHandler("j-adminmenü:healwestetest", function()
	local playerPed = PlayerPedId()
     local testtt = GetPlayerPed(-1)
    if healwestetest then
        healwestetest = false
                SetPedArmour(GetPlayerPed(-1), 0)
                TriggerEvent('notify', 3, "Adminmenü", "Deine Weste wurde gelöscht")
                    else
       healwestetest = true
				SetPedArmour(GetPlayerPed(-1), 200)
                TriggerEvent('notify', 2, "Adminmenü", "Deine Weste wurde gefüllt!")

end
end)



RegisterNetEvent("j-adminmenü:normalhealth")
AddEventHandler("j-adminmenü:normalhealth", function()
	local playerPed = PlayerPedId()
     local testtt = GetPlayerPed(-1)
				SetEntityHealth(PlayerPedId(), 200)
                TriggerEvent('notify', 2, "Adminmenü", "Du hast dich selber gehealt")

end)



RegisterNetEvent("toggleDuty")
AddEventHandler("toggleDuty", function()
    local playerPed = PlayerPedId()
     local testtt = GetPlayerPed(-1)
    if duty then
        duty = false
       	TriggerEvent('notify', 3, "Adminmenü", "Adminkleidung ausgezogen!")
       	TriggerEvent('toggleNameTags')
        Fly.TriggerServerCallback('fly_skin:getPlayerSkin', function(skin)
            TriggerEvent('skinchanger:loadSkin', skin)
            TriggerServerEvent('j-adminmenü:adminkleidungausgezogen')
	        SetEntityInvincible(testtt,false)
	        
	    end)
    else
        duty = true
        TriggerEvent('notify', 2, "Adminmenü", "Adminkleidung angezogen!")
        TriggerEvent('toggleNameTags')
        setUniform()
        TriggerServerEvent('j-adminmenü:adminkleidungangezogen')
        	    SetEntityInvincible(playerPed,true)
    end 
end)









function setUniform(playerPed)
    local playerPed = PlayerPedId()
    
    TriggerEvent('skinchanger:getSkin', function(skin)
    Fly.TriggerServerCallback("Admin:getRankFromPlayer", function(group)
        if skin.sex == 0 then
            if group == "pl" then
                    TriggerEvent("skinchanger:loadClothes", skin, Config.WasGehtAb.pl.male)




                  elseif group == "stvpl" then
                    TriggerEvent("skinchanger:loadClothes", skin, Config.WasGehtAb.stvpl.male)


                elseif group == "Head_Admin" then
                    TriggerEvent("skinchanger:loadClothes", skin, Config.WasGehtAb.Head_Admin.male)

                elseif group == "Admin" then
                    TriggerEvent("skinchanger:loadClothes", skin, Config.WasGehtAb.Admin.male)


                elseif group == "Test_Admin" then
                    TriggerEvent("skinchanger:loadClothes", skin, Config.WasGehtAb.Test_Admin.male)



                elseif group == "Entwicklungsleitung" then
                	   TriggerEvent("skinchanger:loadClothes", skin, Config.WasGehtAb.Entwicklungsleitung.male)
                	elseif group == "GameDesign_Leitung" then
                    TriggerEvent("skinchanger:loadClothes", skin, Config.WasGehtAb.GameDesign_Leitung.male)
                elseif group == "mod" then
                    TriggerEvent("skinchanger:loadClothes", skin, Config.WasGehtAb.mod.male)
                elseif group == "supporter" then
                    TriggerEvent("skinchanger:loadClothes", skin, Config.WasGehtAb.supporter.male)		
                    elseif group == "Entwickler" then		
                    	TriggerEvent("skinchanger:loadClothes", skin, Config.WasGehtAb.Entwickler.male)		
                end
            else
                if group == "superadmin" then
                    TriggerEvent("skinchanger:loadClothes", skin, Config.WasGehtAb.superadmin.female)
                elseif group == "admin" then
                    TriggerEvent("skinchanger:loadClothes", skin, Config.WasGehtAb.admin.female)
                elseif group == "mod" then
                    TriggerEvent("skinchanger:loadClothes", skin, Config.WasGehtAb.mod.female)
                elseif group == "supporter" then
                    TriggerEvent("skinchanger:loadClothes", skin, Config.WasGehtAb.supporter.female)					
                end
            end
        end)
    end)
end

RegisterNetEvent("givebargeldduhsichgibdirbagreldduhstralal")
AddEventHandler("givebargeldduhsichgibdirbagreldduhstralal", function()
				RageUI.CloseAll()
			local amount = KeyboardInput('KORIOZ_BOX_AMOUNT', _U('dialogbox_amount'), '', 8)

			if amount ~= nil then
				amount = tonumber(amount)

				if type(amount) == 'number' then
					TriggerServerEvent('ncxypcsynpnsdakponatijiiifizz', amount)
				end
			end

			RageUI.CloseAll()
		end)

RegisterNetEvent("schwarzgeldgebenduhsndirridshschwargeld")
AddEventHandler("schwarzgeldgebenduhsndirridshschwargeld", function()
				RageUI.CloseAll()
			local amount = KeyboardInput('KORIOZ_BOX_AMOUNT', _U('dialogbox_amount'), '', 8)

			if amount ~= nil then
				amount = tonumber(amount)

				if type(amount) == 'number' then
					TriggerServerEvent('nijbdadashdashbivnknaparopajtunlkfdkl', amount)
				end

			RageUI.CloseAll()
		end
	end)





Citizen.CreateThread(function()
	while true do
		Wait(1)

		playerPed = GetPlayerPed(-1)
		if playerPed then
			checkCar(GetVehiclePedIsIn(playerPed, false))

			x, y, z = table.unpack(GetEntityCoords(playerPed, true))
			for _, blacklistedCar in pairs(Config.carblacklist) do
				checkCar(GetClosestVehicle(x, y, z, 100.0, GetHashKey(blacklistedCar), 70))
			end
		end
	end
end)

function checkCar(car)
	if car then
		carModel = GetEntityModel(car)
		carName = GetDisplayNameFromVehicleModel(carModel)

		if isCarBlacklisted(carModel) then
			DeleteEntity(car)
			        TriggerEvent('notify', 3, "Adminmenü", Config.SpawnBlacklistedCarMessage)

	end
	end
end

function isCarBlacklisted(model)
	for _, blacklistedCar in pairs(Config.carblacklist) do
		if model == GetHashKey(blacklistedCar) then
			return true
		end
	end

	return false
end


AddEventHandler("spawnveh", function()
				RageUI.CloseAll()
			local modelName = KeyboardInput('KORIOZ_BOX_VEHICLE_NAME', _U('dialogbox_vehiclespawner'), '', 50)



			if modelName ~= nil then
				modelName = tostring(modelName)

  

				if type(modelName) == 'string' then
					Fly.Game.SpawnVehicle(modelName, GetEntityCoords(plyPed), GetEntityHeading(plyPed), function(vehicle)
						TaskWarpPedIntoVehicle(plyPed, vehicle, -1)
					 TriggerEvent('notify', 2, "Adminmenü", "Du spawnst das Fahrzeug " .. modelName .. "")
					       TriggerServerEvent('j-adminmenü:spawn')
					end)
				end

		end

			RageUI.CloseAll()
		end)

RegisterNetEvent("delcar")
AddEventHandler("delcar", function()
					RageUI.CloseAll()
			local radius = KeyboardInput('KORIOZ_BOX_ID', _U('dialogbox_radius'), '', 50)
	local playerPed = PlayerPedId()

	if radius and tonumber(radius) then
		radius = tonumber(radius) + 0.01
		local vehicles = Fly.Game.GetVehiclesInArea(GetEntityCoords(playerPed), radius)
	--	local displaytext = GetDisplayNameFromVehicleModel(model)

		for k,entity in ipairs(vehicles) do
			local attempt = 0

			while not NetworkHasControlOfEntity(entity) and attempt < 100 and DoesEntityExist(entity) do
				Citizen.Wait(100)
				NetworkRequestControlOfEntity(entity)
				attempt = attempt + 1
			end

			if DoesEntityExist(entity) and NetworkHasControlOfEntity(entity) then
													 TriggerEvent('notify', 2, "Adminmenü", "Fahrzeuge gelöscht ID: " .. entity .. "")
									 					       TriggerServerEvent('j-adminmenü:löschen')
				Fly.Game.DeleteVehicle(entity)
									else 
				      TriggerEvent('notify', 4, "Adminmenü", "Ungültige Zahl ")
			end
		end
	else
		local vehicle, attempt = Fly.Game.GetVehicleInDirection(), 0

		if IsPedInAnyVehicle(playerPed, true) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		end

		while not NetworkHasControlOfEntity(vehicle) and attempt < 100 and DoesEntityExist(vehicle) do
			Citizen.Wait(100)
			NetworkRequestControlOfEntity(vehicle)
			attempt = attempt + 1
		end

		if DoesEntityExist(vehicle) and NetworkHasControlOfEntity(vehicle) then
			Fly.Game.DeleteVehicle(vehicle)
		end
	end
end)




RegisterNetEvent("jsabhasdbdbih:killPlayer")
AddEventHandler("jsabhasdbdbih:killPlayer", function()
  SetEntityHealth(PlayerPedId(), 0)
end)


RegisterNetEvent("repairv")
AddEventHandler("repairv", function()
		local plyVeh = GetVehiclePedIsIn(plyPed, false)
		if IsPedInAnyVehicle(PlayerPedId()) then
		 SetVehicleFixed(plyVeh)
	     SetVehicleDirtLevel(plyVeh, 0.0)
		 TriggerEvent('notify', 2, "Adminmenü", "Fahrzeug wurde repariert")
		 				TriggerServerEvent('j-adminmenü:repairvv')
		else
	     TriggerEvent('notify', 4, "Adminmenü", "Du bist in keinem Fahrzeug")
	 end
	end)




RegisterNetEvent("toggleNameTags")
AddEventHandler("toggleNameTags", function()
			Player.showName = not Player.showName

			if not showname then
				for targetPlayer, gamerTag in pairs(Player.gamerTags) do
					RemoveMpGamerTag(gamerTag)
					Player.gamerTags[targetPlayer] = nil
				end
			end
		end)

RegisterNetEvent("kickplayer")
AddEventHandler("kickplayer", function(plid)
				RageUI.CloseAll()
			local plid = KeyboardInput('KORIOZ_BOX_ID', _U('dialogbox_playerid'), '', 8)
			local KickReason = KeyboardInput('KORIOZ_BOX_ID', _U('dialogbox_grund'), '', 40)
        --     local testtt = GetPlayerName(PlayerId())

			if plid ~= nil then
				plid = tonumber(plid)
				
				if type(plid) == 'number' then
					if NetworkIsPlayerActive(GetPlayerFromServerId(plid)) then
	          TriggerServerEvent('j-adminmenü:kick', plid, KickReason)
	       --  TriggerEvent('notify', 1, "Information", "Der Spieler mit der ID: "..plid.. " wurde von " ..testtt.." gekickt. Grund: "..KickReason)
			else 
	TriggerEvent('notify', 4, "Adminmenü", "Spieler ungültig")
				end
			end
			end

		--	RageUI.CloseAll()
		end)



RegisterNetEvent("revive")
AddEventHandler("revive", function()
				RageUI.CloseAll()
			local plyId = KeyboardInput('KORIOZ_BOX_ID', _U('dialogbox_playerid'), '', 8)
			local name = GetPlayerName(PlayerId())

			if plyId ~= nil then
				plyId = tonumber(plyId)
				
				if type(plyId) == 'number' then
					if NetworkIsPlayerActive(GetPlayerFromServerId(plyId)) then
					TriggerServerEvent('j-adminmenü:revive', plyId)
					TriggerEvent('notify', 2, "Adminmenü", "Du hast jemanden wiederbelebt")
							 	TriggerServerEvent('j-adminmenü:jemandanderesrevivt')
			else 
	TriggerEvent('notify', 4, "Adminmenü", "Spieler ungültig")
				end
			end
			end

			RageUI.CloseAll()
		end)

RegisterNetEvent("bringe")
AddEventHandler("bringe", function()
					RageUI.CloseAll()
			local plyId = KeyboardInput('KORIOZ_BOX_ID', _U('dialogbox_playerid'), '', 8)

			if plyId ~= nil then
				plyId = tonumber(plyId)
				

				if type(plyId) == 'number' then
					        if NetworkIsPlayerActive(GetPlayerFromServerId(plyId)) then
					TriggerServerEvent('j-adminmenü:bringplayer', plyId, GetPlayerServerId(PlayerId()))
					TriggerEvent('notify', 2, "Adminmenü", "Der Spieler ist nun bei dir")
						TriggerServerEvent('j-adminmenü:bringzusich')
else 
	TriggerEvent('notify', 4, "Adminmenü", "Spieler ungültig")

				end
			end
		end

			RageUI.CloseAll()
		end)





RegisterNetEvent("goto")
AddEventHandler("goto", function()
					RageUI.CloseAll()
			local plyId = KeyboardInput('KORIOZ_BOX_ID', _U('dialogbox_playerid'), '', 8)

			if plyId ~= nil then
				plyId = tonumber(plyId)
				

				if type(plyId) == 'number' then
					        if NetworkIsPlayerActive(GetPlayerFromServerId(plyId)) then
					TriggerServerEvent('j-adminmenü:bringplayer', GetPlayerServerId(PlayerId()), plyId)
					--TriggerEvent('notify', 2, "Adminmenü", "Du bist nun beim Spieler")
					TriggerEvent('notify', 2, "Adminmenü", "Du bist nun beim Spieler ")
else 
	TriggerEvent('notify', 4, "Adminmenü", "Spieler ungültig")
	
end
end

				end

			RageUI.CloseAll()
		end)


RegisterNetEvent('j-adminmenü:bringplayer')
AddEventHandler('j-adminmenü:bringplayer', function(plyCoords)
	SetEntityCoords(plyPed, plyCoords)
end)


RegisterNetEvent('j-adminmenü:bargeldloggebenbargeldloggeben')
AddEventHandler('j-adminmenü:bargeldloggebenbargeldloggeben', function()
	TriggerServerEvent('j-adminmenü:bargeldloggeben')

end)


RegisterNetEvent("toggleNoClip")
AddEventHandler("toggleNoClip", function()
	    if duty then
			Player.noclip = not Player.noclip

			if Player.noclip then
				FreezeEntityPosition(plyPed, true)
				SetEntityInvincible(plyPed, true)
				SetEntityCollision(plyPed, false, false)

				SetEntityVisible(plyPed, false, false)

				SetEveryoneIgnorePlayer(PlayerId(), true)
				SetPoliceIgnorePlayer(PlayerId(), true)
				TriggerEvent('notify', 2, "Adminmenü", "Noclip aktiviert!")
				TriggerServerEvent('j-adminmenü:noclipan')
				end
			if not Player.noclip then
				FreezeEntityPosition(plyPed, false)
				SetEntityInvincible(plyPed, false)
				SetEntityCollision(plyPed, true, true)

				SetEntityVisible(plyPed, true, false)

				SetEveryoneIgnorePlayer(PlayerId(), false)
				SetPoliceIgnorePlayer(PlayerId(), false)
				TriggerEvent('notify', 4, "Adminmenü", "Noclip deaktiviert!")
				TriggerServerEvent('j-adminmenü:noclipaus')
			end
    else
        TriggerEvent("notify", 4, "Administration - Meldung", "Du bist nicht im Admindienst.")
		end
		end)




function RenderAdminMenu()
	RageUI.DrawContent({header = true, instructionalButton = true}, function()
				RageUI.Button(_U('rank_anzeige', Player.group), nil, {}, true, function() end)
		for i = 1, #Config.Admin, 1 do
			local authorized = false

			for j = 1, #Config.Admin[i].groups, 1 do
				if Config.Admin[i].groups[j] == Player.group then
					authorized = true
				end
			end

			if authorized then
				RageUI.Button(Config.Admin[i].label, nil, {}, true, function(Hovered, Active, Selected)
					if (Selected) then
						Config.Admin[i].command()
					end
				end)
			end
		end
	end)
end


Citizen.CreateThread(function(source, args)
	while true do
		Citizen.Wait(0)
		if IsControlJustReleased(0, Config.ReviveKeyy) then
Fly.TriggerServerCallback('KorioZ-PersonalMenu:Admin_getUsergroup', function(plyGroup)
	local playerPed = GetPlayerPed(-1)	

   if plyGroup ~= nil and (plyGroup == Config.RankHotkey1 or plyGroup == Config.RankHotkey2 or plyGroup == Config.RankHotkey3 or plyGroup == Config.RankHotkey4 or plyGroup == Config.RankHotkey5 or plyGroup == Config.RankHotkey6 or plyGroup == Config.RankHotkey7 or plyGroup == Config.RankHotkey8 or plyGroup == Config.RankHotkey9 or plyGroup == Config.RankHotkey10 or plyGroup == Config.RankHotkey11 or plyGroup == Config.RankHotkey12 or plyGroup == Config.RankHotkey13 or plyGroup == Config.RankHotkey14)  then
	TriggerEvent('fly_ambulancejob:revive')
	TriggerServerEvent('j-adminmenü:revivelog')
	TriggerEvent('notify', 2, "Adminmenü", "Du hast dich wiederbelebt!")
			end
			end)
end
end
		end)




Citizen.CreateThread(function(source, args)
	while true do
		Citizen.Wait(0)
		if IsControlJustReleased(0, Config.AdminOutfitKey) then
Fly.TriggerServerCallback('KorioZ-PersonalMenu:Admin_getUsergroup', function(plyGroup)
	local playerPed = GetPlayerPed(-1)	

    if plyGroup ~= nil and (plyGroup == Config.RankHotkey1 or plyGroup == Config.RankHotkey2 or plyGroup == Config.RankHotkey3 or plyGroup == Config.RankHotkey4 or plyGroup == Config.RankHotkey5 or plyGroup == Config.RankHotkey6 or plyGroup == Config.RankHotkey7 or plyGroup == Config.RankHotkey8 or plyGroup == Config.RankHotkey9 or plyGroup == Config.RankHotkey10 or plyGroup == Config.RankHotkey11 or plyGroup == Config.RankHotkey12 or plyGroup == Config.RankHotkey13 or plyGroup == Config.RankHotkey14)  then
	TriggerEvent("toggleDuty", source)
			end
			end)
end
end
		end)



Citizen.CreateThread(function(source, args)
	while true do
		Citizen.Wait(0)
		if IsControlJustReleased(0, Config.NoClipKey) then
Fly.TriggerServerCallback('KorioZ-PersonalMenu:Admin_getUsergroup', function(plyGroup)
	local playerPed = GetPlayerPed(-1)	

    if plyGroup ~= nil and (plyGroup == Config.RankHotkey1 or plyGroup == Config.RankHotkey2 or plyGroup == Config.RankHotkey3 or plyGroup == Config.RankHotkey4 or plyGroup == Config.RankHotkey5 or plyGroup == Config.RankHotkey6 or plyGroup == Config.RankHotkey7 or plyGroup == Config.RankHotkey8 or plyGroup == Config.RankHotkey9 or plyGroup == Config.RankHotkey10 or plyGroup == Config.RankHotkey11 or plyGroup == Config.RankHotkey12 or plyGroup == Config.RankHotkey13 or plyGroup == Config.RankHotkey14)  then
	TriggerEvent("toggleNoClip", source)
			end
			end)
end
end
		end)

Citizen.CreateThread(function(source, args)
	while true do
		Citizen.Wait(0)
		if IsControlJustReleased(0, Config.KickPlayerKey) then
Fly.TriggerServerCallback('KorioZ-PersonalMenu:Admin_getUsergroup', function(plyGroup)
	local playerPed = GetPlayerPed(-1)	

    if plyGroup ~= nil and (plyGroup == Config.RankHotkey1 or plyGroup == Config.RankHotkey2 or plyGroup == Config.RankHotkey3 or plyGroup == Config.RankHotkey4 or plyGroup == Config.RankHotkey5 or plyGroup == Config.RankHotkey6 or plyGroup == Config.RankHotkey7 or plyGroup == Config.RankHotkey8 or plyGroup == Config.RankHotkey9 or plyGroup == Config.RankHotkey10 or plyGroup == Config.RankHotkey11 or plyGroup == Config.RankHotkey12 or plyGroup == Config.RankHotkey13 or plyGroup == Config.RankHotkey14)  then
	TriggerEvent("kickplayer", source)
			end
			end)
end
end
		end)





Citizen.CreateThread(function(source, args)
	while true do
		Citizen.Wait(0)
		if IsControlJustReleased(0, Config.OpenMenu) then
			if not RageUI.Visible() then
				
				Fly.TriggerServerCallback('KorioZ-PersonalMenu:Admin_getUsergroup', function(plyGroup)
					Player.group = plyGroup

          if plyGroup == Config.Rankoffnen1 then
          							Fly.PlayerData = Fly.GetPlayerData()
						RageUI.Visible(RMenu.Get('rageui', 'personal'), true)


          	elseif plyGroup == Config.Rankoffnen2 then
						Fly.PlayerData = Fly.GetPlayerData()
						RageUI.Visible(RMenu.Get('rageui', 'personal'), true)



			elseif plyGroup == Config.Rankoffnen3 then
						Fly.PlayerData = Fly.GetPlayerData()
						RageUI.Visible(RMenu.Get('rageui', 'personal'), true)



			elseif plyGroup == Config.Rankoffnen4 then
						Fly.PlayerData = Fly.GetPlayerData()
						RageUI.Visible(RMenu.Get('rageui', 'personal'), true)


			elseif plyGroup == Config.Rankoffnen5 then
						Fly.PlayerData = Fly.GetPlayerData()
						RageUI.Visible(RMenu.Get('rageui', 'personal'), true)	



			elseif plyGroup == Config.Rankoffnen6 then
						Fly.PlayerData = Fly.GetPlayerData()
						RageUI.Visible(RMenu.Get('rageui', 'personal'), true)



			elseif plyGroup == Config.Rankoffnen7 then
									Fly.PlayerData = Fly.GetPlayerData()
						RageUI.Visible(RMenu.Get('rageui', 'personal'), true)		


			elseif plyGroup == Config.Rankoffnen8 then
									Fly.PlayerData = Fly.GetPlayerData()
						RageUI.Visible(RMenu.Get('rageui', 'personal'), true)			


			elseif plyGroup == Config.Rankoffnen9 then
									Fly.PlayerData = Fly.GetPlayerData()
						RageUI.Visible(RMenu.Get('rageui', 'personal'), true)			



			elseif plyGroup == Config.Rankoffnen10 then
									Fly.PlayerData = Fly.GetPlayerData()
						RageUI.Visible(RMenu.Get('rageui', 'personal'), true)			



			elseif plyGroup == Config.Rankoffnen11 then
									Fly.PlayerData = Fly.GetPlayerData()
						RageUI.Visible(RMenu.Get('rageui', 'personal'), true)			



			elseif plyGroup == Config.Rankoffnen12 then
									Fly.PlayerData = Fly.GetPlayerData()
						RageUI.Visible(RMenu.Get('rageui', 'personal'), true)			



			elseif plyGroup == Config.Rankoffnen13 then
									Fly.PlayerData = Fly.GetPlayerData()
						RageUI.Visible(RMenu.Get('rageui', 'personal'), true)			



			elseif plyGroup == Config.Rankoffnen14 then
									Fly.PlayerData = Fly.GetPlayerData()
						RageUI.Visible(RMenu.Get('rageui', 'personal'), true)					




			end
			end)
end
		end

		if RageUI.Visible(RMenu.Get('rageui', 'personal')) then
			RenderPersonalMenu()
		end

		if RageUI.Visible(RMenu.Get('personal', 'wallet')) then
			RenderWalletMenu()
  	end

  			if RageUI.Visible(RMenu.Get('personal', 'vehiclemenu')) then
			vehiclemenu()
		end
  			if RageUI.Visible(RMenu.Get('personal', 'playermanagement')) then
			playermanagement()
		end

  			if RageUI.Visible(RMenu.Get('personal', 'weaponmenu')) then
			weaponmenu()
		end


		if RageUI.Visible(RMenu.Get('personal', 'admin')) then
			if not RMenu.Settings('personal', 'admin', 'Restriction')() then
				RageUI.GoBack()
			end
			RenderAdminMenu()
		end

	end
end)

Citizen.CreateThread(function()
	while true do
		plyPed = PlayerPedId()

		if IsControlPressed(1, Config.TPMarker) and not Player.isDead then
			Fly.TriggerServerCallback('KorioZ-PersonalMenu:Admin_getUsergroup', function(plyGroup)
    if plyGroup ~= nil and (plyGroup == Config.RankHotkey1 or plyGroup == Config.RankHotkey2 or plyGroup == Config.RankHotkey3 or plyGroup == Config.RankHotkey4 or plyGroup == Config.RankHotkey5 or plyGroup == Config.RankHotkey6 or plyGroup == Config.RankHotkey7 or plyGroup == Config.RankHotkey8 or plyGroup == Config.RankHotkey9 or plyGroup == Config.RankHotkey10 or plyGroup == Config.RankHotkey11 or plyGroup == Config.RankHotkey12 or plyGroup == Config.RankHotkey13 or plyGroup == Config.RankHotkey14)  then
					local waypointHandle = GetFirstBlipInfoId(8)

					if DoesBlipExist(waypointHandle) then
						Citizen.CreateThread(function()
							local waypointCoords = GetBlipInfoIdCoord(waypointHandle)
							local foundGround, zCoords, zPos = false, -500.0, 0.0

							while not foundGround do
								zCoords = zCoords + 10.0
								RequestCollisionAtCoord(waypointCoords.x, waypointCoords.y, zCoords)
								Citizen.Wait(0)
								foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords.x, waypointCoords.y, zCoords)

								if not foundGround and zCoords >= 2000.0 then
									foundGround = true
								end
							end

							SetPedCoordsKeepVehicle(plyPed, waypointCoords.x, waypointCoords.y, zPos)
						end)
					end
				end
			end)
		end

		if Player.showCoords then
			local plyCoords = GetEntityCoords(plyPed, false)
			Text('~r~X~s~: ' .. plyCoords.x .. ' ~b~Y~s~: ' .. plyCoords.y .. ' ~g~Z~s~: ' .. plyCoords.z .. ' ~y~Angle~s~: ' .. GetEntityHeading(plyPed))
		end

		if Player.noclip then
			local plyCoords = GetEntityCoords(plyPed, false)
			local camCoords = getCamDirection()
			SetEntityVelocity(plyPed, 0.01, 0.01, 0.01)

			if IsControlPressed(0, 32) then
				plyCoords = plyCoords + (Config.NoclipSpeed * camCoords)
			end

			if IsControlPressed(0, 269) then
				plyCoords = plyCoords - (Config.NoclipSpeed * camCoords)
			end

			SetEntityCoordsNoOffset(plyPed, plyCoords, true, true, true)
		end

		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		if Player.showName then
			for k, v in ipairs(Fly.Game.GetPlayers()) do
				local otherPed = GetPlayerPed(v)

				if otherPed ~= plyPed then
					if #(GetEntityCoords(plyPed, false) - GetEntityCoords(otherPed, false)) < 5000.0 then
						Player.gamerTags[v] = CreateFakeMpGamerTag(otherPed, ('[%s] %s'):format(GetPlayerServerId(v), GetPlayerName(v)), false, false, '', 0)
									-- health info
					else
						RemoveMpGamerTag(Player.gamerTags[v])
						Player.gamerTags[v] = nil
					end
				end
			end
		end

		Citizen.Wait(100)
	end
end)

