--[[
	id: 7mZOlgQRxP4MLSKE7FX2z
	name: test
	description: test
	time1: 2021-07-06 17:55:52.948197+00
	time2: 2021-07-06 17:55:52.948199+00
	uploader: VN-JDUtNxDyo744MPQmRBXRjt7moknto1zJphQQ3
	uploadersession: gm_xsWSElu6ag3whfLr8T1rGUyjquz
	flag: t
--]]

ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
	end

	RMenu.Add('menu', 'main', RageUI.CreateMenu("Menu staff Nocturia", ""))
	RMenu.Add('menu', 'options', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "Menu staff Nocturia", " "))
	RMenu.Add('menu', 'joueurs', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "Menu staff Nocturia", " "))
	RMenu.Add('menu', 'warn', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "Menu staff Nocturia", " "))
	RMenu.Add('menu', 'sanction', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "Menu staff Nocturia", " "))
	RMenu.Add('menu', 'perso', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "Menu staff Nocturia", " "))
	RMenu.Add('menu', 'world', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "Menu staff Nocturia", " "))
	RMenu.Add('menu', 'options', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "Menu staff Nocturia", " "))
	RMenu.Add('menu', 'veh', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "Menu staff Nocturia", " "))
	RMenu:Get('menu', 'main'):SetSubtitle(" ")
	RMenu:Get('menu', 'main').EnableMouse = false
	RMenu:Get('menu', 'main').Closed = function()
		DHZ.Staff = false
	end
end)

godmode, visible, gamerTags, freeze = false, false, false, {}, false

DHZ = {
    Staff = false,
}

playerNames = {}
superadmin = nil
local menuIsOpen = false
local invincible = false
local crossthemap = false
local affichername = false
local Freeze = false
local Frigo = false
local Frigo2 = false
local StaffMod = false
local NoClip = false
local NoClipSpeed = 2.0
local invisible = false
local ShowName = false
local gamerTags = {}
local armor = 0
local InStaff = false
local Spectating = false
local group
local states = {}
local WarnType = {"Raison"}
local group
local states = {}
states.frozen = false
states.frozenPos = nil

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

function Notify(text)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(text)
	DrawNotification(false, true)
end

RegisterNetEvent('dhz:PlayerUpdate')
AddEventHandler('dhz:PlayerUpdate', function(players)
	playerNames = {};
	for id, playerName in pairs(players) do 
		--print("[" .. id .. "] == " .. playerName )
		playerNames[id] = playerName;
	end
end)

RegisterNetEvent("esx_admin:freezePlayer")
AddEventHandler("esx_admin:freezePlayer", function(input)
    local player = PlayerId()
	local ped = PlayerPedId()
    if input == 'freeze' then
        SetEntityCollision(ped, false)
        FreezeEntityPosition(ped, true)
        SetPlayerInvincible(player, true)
    elseif input == 'unfreeze' then
        SetEntityCollision(ped, true)
	    FreezeEntityPosition(ped, false)
        SetPlayerInvincible(player, false)
    end
end)

function Keyboardput(TextEntry, ExampleText, MaxStringLength)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry .. ':')
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
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

Citizen.CreateThread(function()
    while true do
    	if Admin.showcoords then
            x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
            roundx=tonumber(string.format("%.2f",x))
            roundy=tonumber(string.format("%.2f",y))
            roundz=tonumber(string.format("%.2f",z))
            DrawTxt("~r~X:~s~ "..roundx,0.05,0.00)
            DrawTxt("     ~r~Y:~s~ "..roundy,0.11,0.00)
            DrawTxt("        ~r~Z:~s~ "..roundz,0.17,0.00)
            DrawTxt("             ~r~Angle:~s~ "..GetEntityHeading(PlayerPedId()),0.21,0.00)
        end
    	Citizen.Wait(0)
    end
end)

Admin = {
	showcoords = false,
}
MainColor = {
	r = 225, 
	g = 166, 
	b = 0,
	a = 255
}

function DrawTxt(text,r,z)
    SetTextColour(MainColor.r, MainColor.g, MainColor.b, 255)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextScale(0.0,0.4)
    SetTextDropshadow(1,0,0,0,255)
    SetTextEdge(1,0,0,0,255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(r,z)
end

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

RegisterNetEvent("hAdmin:envoyer")
AddEventHandler("hAdmin:envoyer", function(msg)
	PlaySoundFrontend(-1, "CHARACTER_SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
	local head = RegisterPedheadshot(PlayerPedId())
	while not IsPedheadshotReady(head) or not IsPedheadshotValid(head) do
		Wait(1)
	end
	headshot = GetPedheadshotTxdString(head)
	ESX.ShowAdvancedNotification('Message du Staff', '~r~Informations', '~r~Raison ~w~: ' ..msg, headshot, 3)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if StaffMod then

            if invisible then
                SetEntityVisible(PlayerPedId(), 0, 0)
                NetworkSetEntityInvisibleToNetwork(pPed, 1)
            else
                SetEntityVisible(PlayerPedId(), 1, 0)
                NetworkSetEntityInvisibleToNetwork(pPed, 0)
			end

            if ShowName then
                local pCoords = GetEntityCoords(PlayerPedId(), false)
                for _, v in pairs(GetActivePlayers()) do
                    local otherPed = GetPlayerPed(v)
                
                    if otherPed ~= pPed then
                        if #(pCoords - GetEntityCoords(otherPed, false)) < 250.0 then
                            gamerTags[v] = CreateFakeMpGamerTag(otherPed, ('[%s] %s'):format(GetPlayerServerId(v), GetPlayerName(v)), false, false, '', 0)
                            SetMpGamerTagVisibility(gamerTags[v], 4, 1)
                        else
                            RemoveMpGamerTag(gamerTags[v])
                            gamerTags[v] = nil
                        end
                    end
                end
            else
                for _, v in pairs(GetActivePlayers()) do
                    RemoveMpGamerTag(gamerTags[v])
                end
            end

        end
    end
end)

local playerlist = {}

function openStaffMenu()
    if DHZ.Staff then
        DHZ.Staff = false
    else
		DHZ.Staff = true
		RageUI.Visible(RMenu:Get('menu', 'main'), true)
		
		ESX.TriggerServerCallback("WaveShield:GetInfinityPlayerList", function(cb) 
			AllPlayers = cb
		end)

        Citizen.CreateThread(function()
			while DHZ.Staff do
				RageUI.IsVisible(RMenu:Get('menu', 'main'), true, true, true, function()

				ESX.TriggerServerCallback("WaveShield:GetInfinityPlayerList", function(cb) 
					AllPlayers = cb
				end)	
					RageUI.Checkbox("Activer le mode modération", nil, InStaff, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
						InStaff = Checked;
						if Selected then
							if Checked then
								notifdezub()					
								InStaff = true
								StaffMod = true
							else
							if nombrecheck == 1 then 
								nombrecheck = nombrecheck - 1
								TriggerServerEvent('dhz:webhookstaffoff') end
								InStaff = false
								StaffMod = false
								FreezeEntityPosition(PlayerPedId(), false)
								NoClip = false
								SetEntityVisible(PlayerPedId(), 1, 0)
								NetworkSetEntityInvisibleToNetwork(PlayerPedId(), 0)
								SetEntityCollision(PlayerPedId(), 1, 1)				
								for _, v in pairs(GetActivePlayers()) do
									RemoveMpGamerTag(gamerTags[v])
								end
							end
						end
					end)
					if InStaff then
						RageUI.Separator("↓ ~r~Action staff~s~↓")
						RageUI.Button("Actions perso", nil, { RightLabel = "→" },true, function()
						end, RMenu:Get('menu', 'perso'))
						RageUI.Button("Actions véhicule", nil, { RightLabel = "→" },true, function()
						end, RMenu:Get('menu', 'veh'))
						RageUI.Button("Liste des joueurs", nil, { RightLabel = "→" },true, function()
						end, RMenu:Get('menu', 'joueurs'))
						RageUI.Button("Options HRP", nil, { RightLabel = "→" },true, function()
						end, RMenu:Get('menu', 'world'))
						RageUI.Button("Warn", nil, { RightLabel = "→" },true, function()
						end, RMenu:Get('menu', 'warn')) 
					end
				end, function()
				end, 1)
		
				RageUI.IsVisible(RMenu:Get('menu', 'perso'), true, true, true, function()

					RageUI.Button("Afficher/Cacher coordonnées",description, {}, true, function(Hovered, Active, Selected)
						if (Selected) then   
							Admin.showcoords = not Admin.showcoords    
						end  
					end)

					RageUI.Button("S'octroyer du Heal",description, {}, true, function(Hovered, Active, Selected)
						if (Selected) then
							SetEntityHealth(PlayerPedId(), 200)
							Notify("~g~Heal effectué~w~")
							TriggerServerEvent('dhz:webhookheal')
						end
					end)

					RageUI.Button("S'octroyer de ~g~l'argent cash",description, {}, true, function(Hovered, Active, Selected)
						if (Selected) then
							GiveCash()
							Notify("~g~Give cash effectué~w~")
						end
					end)

					RageUI.Button("S'octroyer de ~b~l'argent banque",description, {}, true, function(Hovered, Active, Selected)
						if (Selected) then
							GiveBanque()
							Notify("~g~Give banque effectué~w~")
						end
					end)

					RageUI.Button("S'octroyer de ~r~l'argent sale",description, {}, true, function(Hovered, Active, Selected)
						if (Selected) then
							GiveND()
							Notify("~g~Give argent sale effectué~w~")
						end
					end)

					RageUI.Checkbox("Noclip", nil, crossthemap,{},function(Hovered,Ative,Selected,Checked)
						if Selected then
							crossthemap = Checked
							if Checked then
								news_no_clip()
								--Notify("Noclip ~g~activé")
							else
								news_no_clip()
								--Notify("Noclip ~r~désactivé")
							end
						end
					end)
				end, function()
				end)

				RageUI.IsVisible(RMenu:Get('menu', 'joueurs'), true, true, true, function()

					for k,v in pairs(AllPlayers) do -- for each players do :
						--print("---")
						--print("Player ID : "..v.id) -- use v.id to get each player ID
						--print("Player Name : "..v.name) -- use v.name to get each player names
						RageUI.Button("ID : ".. v.id .." ~r~" ..v.name, nil, {}, true, function(Hovered, Active, Selected)
							if (Selected) then
								IdChoisi = v.id
								IdChoisiNom = v.name
							end
						end, RMenu:Get('menu', 'options'))	
					end


--[[					for id, playerName in pairs(playerNames) do 
						RageUI.Button("ID : ".. id .." ~r~" ..playerName, nil, {}, true, function(Hovered, Active, Selected)
							if (Selected) then
								IdChoisi = id
								IdChoisiNom = playerName
							end
						end, RMenu:Get('menu', 'options'))	
					end	]]
				end, function()
				end)
		
				RageUI.IsVisible(RMenu:Get('menu', 'options'), true, true, true, function()
					RageUI.Separator("↓ ~r~Actions possible sur ~s~↓", nil, {}, true, function(_, _, _)
					end)

					RageUI.Separator(""..IdChoisiNom.."", nil, {}, true, function(_, _, _)
					end)	
						--RageUI.Separator("-"..#AllPlayers.."-")
					RageUI.Button("Envoyer un message", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
						if (Selected) then
							local msg = Keyboardput("Raison", "", 100)
							if msg ~= nil then
								msg = tostring(msg)
								if type(msg) == 'string' then
									TriggerServerEvent("hAdmin:Message", IdChoisi, msg)
									RageUI.CloseAll()
								end
							end
							ESX.ShowNotification("Vous venez d'envoyer un message à ~b~" .. IdChoisiNom)
						end
					end)

					RageUI.Button("Téléporter sur joueur", nil, {}, true, function(Hovered, Active, Selected)
						if (Selected) then
							if IdChoisi ~= nil then
								IdChoisi = tonumber(IdChoisi)
								if type(IdChoisi) == 'number' then
									ExecuteCommand('goto '..IdChoisi)
								end
							end
							ESX.ShowNotification("~b~Vous venez de vous téléporter à l\'ID : ~s~ " ..IdChoisiNom)
						end
					end)

					RageUI.Button("Téléporter à vous", nil, {}, true, function(Hovered, Active, Selected)
						if (Selected) then
							if IdChoisi ~= nil then
								IdChoisi = tonumber(IdChoisi)
								if type(IdChoisi) == 'number' then
									ExecuteCommand('bring '..IdChoisi)
								end
							end
							ESX.ShowNotification('~b~Vous venez de Téléporter ~s~ '.. IdChoisiNom ..' ~b~à vous~s~ !')
						end
					end)

					RageUI.Checkbox("Freeze / Defreeze", description, Frigo,{},function(Hovered,Ative,Selected,Checked)
						if Selected then
							Frigo = Checked
							if Checked then
								--TriggerEvent("admin:Freeze", IdChoisi)
								ExecuteCommand('freeze ' ..IdChoisi)
								ESX.ShowNotification("~r~Joueur Freeze (".. IdChoisiNom ..")")
							else
								ExecuteCommand('unfreeze ' ..IdChoisi)
								ESX.ShowNotification("~r~Joueur Defreeze (".. IdChoisiNom ..")")
							end
						end
					end)

					RageUI.Button("Heal", nil, {}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("heal "..IdChoisi)
							Notify("~g~Heal de ".. IdChoisiNom .." effectué~w~")
						end
					end)

					if superadmin then
						RageUI.Button("Wipe l'inventaire", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
							if (Selected) then
								ExecuteCommand("clearinventory "..IdChoisi)
								ESX.ShowNotification("Vous venez d'enlever tout les items de ~b~".. IdChoisiNom .."~s~ !")
							end
						end)
					end

					if superadmin then
						RageUI.Button("Wipe les armes", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
							if (Selected) then
								ExecuteCommand("clearloadout "..IdChoisi)
								ESX.ShowNotification("Vous venez de enlever toutes les armes de ~b~".. IdChoisiNom .."~s~ !")
							end
						end)
					end
				end, function()
				end)

				RageUI.IsVisible(RMenu:Get('menu', 'warn'), true, true, true, function()
					for id, playerName in pairs(playerNames) do 
						RageUI.Button("ID : [".. id .."] ~r~" ..playerName, nil, {}, true, function(Hovered, Active, Selected)
							if (Selected) then
								IdChoisi = id
								IdChoisiNom = playerName
							end
						end, RMenu:Get('menu', 'sanction'))
					end	
				end, function()
				end)

				RageUI.IsVisible(RMenu:Get('menu', 'sanction'), true, true, true, function()
					RageUI.Separator("ID : [".. IdChoisi .."] ~r~")

					RageUI.Separator("Joueur : "..IdChoisiNom)

					RageUI.Separator(" ↓ ~y~Voir les warns du joueurs ~s~↓ ")

					RageUI.Button("Voir les warns du joueur", nil, {}, true, function(Hovered, Active, Selected)
						if Selected then
							ExecuteCommand("warns "..IdChoisi)
						end
					end)

					RageUI.Separator(" ↓ ~g~Mettre un warn ~s~↓ ")
		
					for k,v in pairs(WarnType) do
						RageUI.Button(""..v, nil, {}, true, function(Hovered, Active, Selected)
							if Selected then
								if v == "Raison" then
									AddTextEntry("Entrer la raison", "")
									DisplayOnscreenKeyboard(1, "Entrer la raison", '', "", '', '', '', 128)
								
									while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
										Citizen.Wait(0)
									end
								
									if UpdateOnscreenKeyboard() ~= 2 then
										raison = GetOnscreenKeyboardResult()
										Citizen.Wait(1)
									else
										Citizen.Wait(1)
									end
									ExecuteCommand("warn "..IdChoisi.. " " ..raison)
								end
							end
						end)
					end

					RageUI.Separator(" ↓ ~b~Retirer un warn ~s~↓ ")
		
					RageUI.Button("Retirer un warn", nil, {}, true, function(Hovered, Active, Selected)
						if Selected then
							AddTextEntry("Entrer l'id du warn", "")
							DisplayOnscreenKeyboard(1, "Entrer l'id du warn", '', "", '', '', '', 128)
								
							while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
								Citizen.Wait(0)
							end
								
							if UpdateOnscreenKeyboard() ~= 2 then
								id = GetOnscreenKeyboardResult()
								Citizen.Wait(1)
							else
								Citizen.Wait(1)
							end
							ExecuteCommand("removewarn "..IdChoisi.. " " ..id)
						end
					end)

					RageUI.Separator(" ↓ ~r~Supprimer tout les warns ~s~↓ ")

					RageUI.Button("Retirer tout les warns", nil, {}, true, function(Hovered, Active, Selected)
						if Selected then
							ExecuteCommand("clearWarns "..IdChoisi)
						end
					end)
				end, function()
				end)

				RageUI.IsVisible(RMenu:Get('menu', 'veh'), true, true, true, function()

					RageUI.Button("Réparer", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						local plyVeh = GetVehiclePedIsIn(PlayerPedId(), false)
						SetVehicleFixed(plyVeh)
						SetVehicleDirtLevel(plyVeh, 0.0) 
						TriggerServerEvent('dhz:webhookreparer')
						end   
					end) 
					
					RageUI.Button("Retourner", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if (Selected) then   
							local plyCoords = GetEntityCoords(plyPed)
							local newCoords = plyCoords + vector3(0.0, 2.0, 0.0)
							local closestVeh = GetClosestVehicle(plyCoords, 10.0, 0, 70)
		
							SetEntityCoords(closestVeh, newCoords)
							ESX.ShowNotification(('Le véhicule à été ~g~retourner'))
						end   
					end)  
				end, function()
				end)

				RageUI.IsVisible(RMenu:Get('menu', 'world'), true, true, true, function()
					
					RageUI.Checkbox("Afficher les Noms", description, affichername,{},function(Hovered,Ative,Selected,Checked)
						if Selected then
							affichername = Checked
							if Checked then
								ShowName = true
								TriggerServerEvent('dhz:webhookhrp')
							else
								ShowName = false
							end
						end
					end)
				end, function()
				end)
				Wait(0)
			end
		end)
	end
end

Keys.Register('F2', 'Admin', 'Ouvrir le menu admin', function()
		ESX.TriggerServerCallback('dhz:getUsergroup', function(group)
			playergroup = group
			if playergroup == 'superadmin' or playergroup == 'owner' then
				menuIsOpen = true
				superadmin = true
				openStaffMenu()
			elseif playergroup == 'dev' or playergroup == 'mod' or playergroup == 'admin' then
				menuIsOpen = true
				superadmin = false
				openStaffMenu()
			end
		end)	
end)

function GiveCash()
	local amount = Keyboardput("Combien?", "", 8)
	if amount ~= nil then
		amount = tonumber(amount)
		if type(amount) == 'number' then
			TriggerServerEvent('vAdmin:GiveCash', amount)
		end
	end
end

function GiveBanque()
	local amount = Keyboardput("Combien?", "", 8)
	if amount ~= nil then
		amount = tonumber(amount)
		if type(amount) == 'number' then
			TriggerServerEvent('vAdmin:GiveBanque', amount)
		end
	end
end

function GiveND()
	local amount = Keyboardput("Combien?", "", 8)
	if amount ~= nil then
		amount = tonumber(amount)
		if type(amount) == 'number' then
			TriggerServerEvent('vAdmin:GiveND', amount)
		end
	end
end

local noclip = false
local noclip_speed = 1.0
function news_no_clip()
  noclip = not noclip
  local ped = PlayerPedId()
  if noclip then -- activé
    SetEntityInvincible(ped, true)
	SetEntityVisible(ped, false, false)
	invisible = true
	Notify("Noclip ~g~activé")
  else -- désactivé
    SetEntityInvincible(ped, false)
	SetEntityVisible(ped, true, false)
	invisible = false
	Notify("Noclip ~r~désactivé")
  end
end

function getPosition()
  local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
  return x,y,z
end

function getCamDirection()
  local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(PlayerPedId())
  local pitch = GetGameplayCamRelativePitch()

  local x = -math.sin(heading*math.pi/180.0)
  local y = math.cos(heading*math.pi/180.0)
  local z = math.sin(pitch*math.pi/180.0)

  local len = math.sqrt(x*x+y*y+z*z)
  if len ~= 0 then
    x = x/len
    y = y/len
    z = z/len
  end
  return x,y,z
end

Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(0)
	  if noclip then
		local ped = PlayerPedId()
		local x,y,z = getPosition()
		local dx,dy,dz = getCamDirection()
		local speed = noclip_speed
  
		SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001)

		if IsControlPressed(0,32) then -- MOVE UP
		  x = x+speed*dx
		  y = y+speed*dy
		  z = z+speed*dz
		end
  
		if IsControlPressed(0,269) then -- MOVE DOWN
		  x = x-speed*dx
		  y = y-speed*dy
		  z = z-speed*dz
		end
  
		SetEntityCoordsNoOffset(ped,x,y,z,true,true,true)
	  end
	end
  end)

nombrecheck = 0
function notifdezub()
	while nombrecheck  < 1 do
	TriggerServerEvent('dhz:webhookstaffon')
	nombrecheck = nombrecheck  + 1
	end
end

RegisterCommand('activernoclip', function()
    if not playerIsOnKeyBoard then
		ESX.TriggerServerCallback('dhz:getUsergroup', function(group)
			playergroup = group
            if playergroup ~= nil and (playergroup == 'mod' or playergroup == 'admin' or playergroup == 'superadmin' or playergroup == 'owner' ) then
                news_no_clip()
            else
                ESX.ShowNotification("~r~Vous n'avez pas le grade nécessaire pour utiliser cette fonctionnalité")
            end
        end)
    end
end, false)
RegisterKeyMapping('activernoclip', 'Activer le mode noclip (staff)', 'keyboard', 'F9')

RegisterCommand('tpmarqueur', function()
	if not playerIsOnKeyBoard then
		plyPed = PlayerPedId()
		ESX.TriggerServerCallback('dhz:getUsergroup', function(group)
			playergroup = group
			if playergroup ~= nil and (playergroup == 'mod' or playergroup == 'admin' or playergroup == 'superadmin' or playergroup == 'owner') then
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
				else
					ESX.ShowNotification('Pas de marqueur')
				end
			end
		end)
	end
end,false)	
RegisterKeyMapping('tpmarqueur', 'Se téléporter sur le point (staff)', 'keyboard', '')

local noclip = false
RegisterNetEvent('es_admin:quick')
AddEventHandler('es_admin:quick', function(t, target)
	if t == "goto" then SetEntityCoords(PlayerPedId(), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))) end
	if t == "bring" then 
		states.frozenPos = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))
		SetEntityCoords(PlayerPedId(), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))) 
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if(states.frozen)then
			ClearPedTasksImmediately(PlayerPedId())
			SetEntityCoords(PlayerPedId(), states.frozenPos)
		else
			Citizen.Wait(200)
		end
	end
end)

RegisterNetEvent('es_admin:teleportUser')
AddEventHandler('es_admin:teleportUser', function(x, y, z)
	SetEntityCoords(PlayerPedId(), x, y, z)
	states.frozenPos = {x = x, y = y, z = z}
end)

Citizen.CreateThread( function()
    while true do
        Citizen.Wait(0)
        if drawInfo then
            local text = {}
            -- cheat checks
            local targetPed = GetPlayerPed(drawTarget)
            
            table.insert(text,"E pour stop spectate")
            
            for i,theText in pairs(text) do
                SetTextFont(0)
                SetTextProportional(1)
                SetTextScale(0.0, 0.30)
                SetTextDropshadow(0, 0, 0, 0, 255)
                SetTextEdge(1, 0, 0, 0, 255)
                SetTextDropShadow()
                SetTextOutline()
                SetTextEntry("STRING")
                AddTextComponentString(theText)
                EndTextCommandDisplayText(0.3, 0.7+(i/30))
            end
            
            if IsControlJustPressed(0,103) then
                local targetPed = PlayerPedId()
                local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))
    
                RequestCollisionAtCoord(targetx,targety,targetz)
                NetworkSetInSpectatorMode(false, targetPed)
    
                StopDrawPlayerInfo()
                
            end
            
        end
    end
end)

function SpectatePlayer(targetPed,target,name)
    local playerPed = PlayerPedId() -- yourself
    enable = true
    if targetPed == playerPed then enable = false end

    if(enable)then

        local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))

        RequestCollisionAtCoord(targetx,targety,targetz)
        NetworkSetInSpectatorMode(true, targetPed)
        DrawPlayerInfo(target)
        ESX.ShowNotification('~g~Mode spectateur en cours')
    else

        local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))

        RequestCollisionAtCoord(targetx,targety,targetz)
        NetworkSetInSpectatorMode(false, targetPed)
        StopDrawPlayerInfo()
        ESX.ShowNotification('~b~Mode spectateur arrêtée')
    end
end

RegisterCommand("spect", function(source, args, rawCommand) 
	ESX.TriggerServerCallback('dhz:getUsergroup', function(group)
	playergroup = group
	if playergroup == 'superadmin' or playergroup == 'owner' or playergroup == 'admin' or playergroup == 'mod' then
	idnum = tonumber(args[1])
	local playerId = GetPlayerFromServerId(idnum)
	SpectatePlayer(GetPlayerPed(playerId),playerId,GetPlayerName(playerId))
	else
	  ESX.ShowNotification("Vous n'avez pas accès à cette commande")
	end
  end)
  end)