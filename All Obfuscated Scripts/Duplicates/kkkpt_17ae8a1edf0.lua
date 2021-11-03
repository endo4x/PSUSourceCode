--[[
	id: uafKh7h-8ghkxJamnMSgM
	name: kkkpt1
	description: kkk
	time1: 2021-07-17 23:49:24.662186+00
	time2: 2021-07-17 23:49:24.662187+00
	uploader: fNFlwvflivk-D54KDyZoNSZDKhkd10_e9Z8RvIjN
	uploadersession: Imm8VphatoYqMtzoW5e0slIsq-4ivU
	flag: f
--]]

local menuX = { 0.015, 0.05, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.75 }
local menuY = { 0.015, 0.05, 0.1, 0.2, 0.3, 0.4, 0.5 } 
local frozen = false
local godmode = false
local isSpectatingTarget = false
local spectatedPlayer = nil
local infoOn = false    
local coordsText = ""   
local headingText = ""  
local modelText = ""   
local currBanIndex = 1
local selBanIndex = 1
local currGroupIndex = 1
local selGroupIndex = 1
local currLevelIndex = 1
local selLevelIndex = 1
local allowedToUseMenu = false
local allowedToNoclip = false
local allowedToFreeze = false
local allowedToUseGodmode = false
local allowedToUseInvisibility = false
local allowedToUnban = false
local allowedToCustomPed = false
local allowedToPedWipe = false
local allowedToCarWipe = false
local allowedToObjectWipe = false
local allowedToMassWipe = false
local allowedToSpawnVehicle = false
local allowedToBan = false
local allowedToRevive = false
local AssistList = {}
local onesync = false
local admin = false

Citizen.CreateThread(function()
	Wait(1000)
	TriggerServerEvent("MunchAdminAssists:GetAssists")
end)


if Config.AssistCommand then
	if Config.AssistCommand ~= "" then
		RegisterCommand(Config.AssistCommand, function(source, args, rawCommand)
			AssistNUI(false)
		end, false)
	end
end

RegisterCommand("assistlist", function(source, args, rawCommand)
	if admin then
		AssistNUI(true)
	end
end)

BanLength = {"1 Hour", "3 Hours", "6 Hours", "12 Hours", "1 Day", "2 Days", "3 Days", "1 Week", "2 Weeks", "1 Month", "Permanent"}
PlayerGroups = {"user", "mod", "admin", "superadmin"}
PermLevels = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}

local function tpm()
	local WaypointHandle = GetFirstBlipInfoId(8)

    if DoesBlipExist(WaypointHandle) then
        local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)

        for height = 1, 1000 do
            SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

            local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

            if foundGround then
                SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

                break
            end

            Citizen.Wait(5)
		end
	else
		exports['mythic_notify']:SendAlert('error', 'You must place a waypoint first. - [mAdmin]', 5000)
	end
end

RegisterNetEvent("munchadminv2:CaptureScreenshot")
AddEventHandler('munchadminv2:CaptureScreenshot', function(url)
	exports['screenshot-basic']:requestScreenshotUpload(GetConvar("ea_screenshoturl", url), GetConvar("ea_screenshotfield", 'files[]'), function(data)
        TriggerServerEvent("munchadminv2:TookScreenshot", data)
    end)
end)

local function DrawPlayerInfo(player)
	drawTarget = player
	drawspectate = true
end

local function StopDrawPlayerInfo()
	drawspectate = false
	drawTarget = 0
end

local function drawspectext(text)
	SetTextFont(4)
	SetTextScale(0.45, 0.45)
	SetTextColour(255, 255, 255, 255)
	SetTextDropShadow()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(0.45, 0.005)
end

local function spectate(id)
	spectating = not spectating
	local player = GetPlayerPed(id)
	if spectating then
		RequestCollisionAtCoord(GetEntityCoords(player))
		NetworkSetInSpectatorMode(true, player)
		DrawPlayerInfo(id)
	else
		RequestCollisionAtCoord(GetEntityCoords(player))
		NetworkSetInSpectatorMode(false, player)
		StopDrawPlayerInfo()
	end
end

local function customped()
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 64 + 1)
    
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end
    
    local modelhash = GetOnscreenKeyboardResult()
	
	if modelhash == nil then 
		modelhash = ""
	end

	if modelhash == "" then 
		return
	end
    
	local model = GetHashKey(modelhash)

	if IsModelValid(model) and IsModelAPed(model) then
    	RequestModel(model)
    	while not HasModelLoaded(model) do
        	Wait(100)
		end
	else
		exports['mythic_notify']:SendAlert('error', 'Invalid Ped Model. - [mAdmin]', 5000) 
	end

    SetPlayerModel(PlayerId(), model)
	SetModelAsNoLongerNeeded(model)
end

function OpenAssist()
	AssistNUI(false)
end

function DrawInfos(text)
    SetTextColour(255, 255, 255, 255) 
    SetTextFont(4)                     
    SetTextScale(0.4, 0.4)            
    SetTextWrap(0.0, 1.0)             
    SetTextCentre(false)              
    SetTextDropshadow(0, 0, 0, 0, 255)  
    SetTextEdge(50, 0, 0, 0, 255)      
    SetTextOutline()                    
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.015, 0.31)               
end

function OpenAssistList()
	AssistNUI(true)
end

exports('AssistList', OpenAssistList)

exports('Assist', OpenAssist)

function AssistNUI(bool)
	SetNuiFocus(true, true)
	if bool then
		SendNUIMessage({
			action = "updateAssistList",
			assistList = AssistList
		})
		SendNUIMessage({
			action = "openAssistList",
		})
	else
		SendNUIMessage({
			action = "startAssistForm",
		})
	end
end

RegisterNetEvent('munchadminv2:openassists')
AddEventHandler('munchadminv2:openassists', function()
ExecuteCommand("assistlist")
end)

RegisterNUICallback("action", function(data)
	local action = data.action
	if action ~= "solvedassist" then
		SetNuiFocus(false, false)
	end
	if action == "createNewAssist" then
		local url = true
		if Config.TakeScreenshot then
			if Config.TakeScreenshot ~= "" and Config.TakeScreenshot ~= "YOUR_DISCORD_WEBHOOK_HERE" then
				url = false
				exports['screenshot-basic']:requestScreenshotUpload(Config.TakeScreenshot, "files[]", function(data)
					local image = json.decode(data)
					url = image.attachments[1].url
				end)
			end
		end
		while not url do
			Wait(10)
		end
		if type(url) ~= "string" then
			url = ""
		end
		local list = {title=data.title,description=data.description,url=url}
		TriggerServerEvent("MunchAdminAssists:NewAssist",list)
	elseif action == "gotoplayer" then
		if AssistList[data.id] then
			if onesync then
				TriggerServerEvent("MunchAdminAssists:TeleportAssist",data.id,true)
			else
				local id = AssistList[data.id].playerid
				local playerIdx = GetPlayerFromServerId(id)
				local active = NetworkIsPlayerActive(playerIdx)
				if active then
					SetEntityCoords(PlayerPedId(), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(id))))
					TriggerServerEvent("MunchAdminAssists:TeleportAssist",id)
				else
					if Config.WTF then
						WTF.ShowNotification("~r~ That player is no longer in the server!")
					else
						--your notification system
					end
				end
			end
		end
	elseif action == "solvedassist" then
		local id = data.id
		local can = data.can
		local assistinfo = AssistList[id]
		if assistinfo then
			if assistinfo.solved ~= true or can then
				TriggerServerEvent("MunchAdminAssists:AssistSolved",id,can)
			end
		end
	end
end)

RegisterNetEvent('MunchAdminAssists:AssistSolved')
AddEventHandler('MunchAdminAssists:AssistSolved', function(id,more)
	local assist = AssistList[id]
	--if assist and assist.solved ~= true then
		AssistList[id].solved = more
		SendNUIMessage({
			action = "updateAssistList",
			assistList = AssistList
		})
	--end
end)

RegisterNetEvent('MunchAdminAssists:GetAssists')
AddEventHandler('MunchAdminAssists:GetAssists', function(assists,osync,staff)
	admin = staff
	AssistList = assists
	onesync = osync
end)

RegisterNetEvent('MunchAdminAssists:AddToList')
AddEventHandler('MunchAdminAssists:AddToList', function(newassist)
	if admin then
		SendNUIMessage({
			action = "notification",
		})
		AssistList[#AssistList+1] = newassist
		SendNUIMessage({
			action = "updateAssistList",
			assistList = AssistList
		})
	end
end)

local function spectate(id)
	spectating = not spectating
	local player = GetPlayerPed(id)
	if spectating then
		RequestCollisionAtCoord(GetEntityCoords(player))
		NetworkSetInSpectatorMode(true, player)
		DrawPlayerInfo(id)
	else
		RequestCollisionAtCoord(GetEntityCoords(player))
		NetworkSetInSpectatorMode(false, player)
		StopDrawPlayerInfo()
	end
end

local function customped()
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 64 + 1)
    
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(100)
    end
    
    local modelhash = GetOnscreenKeyboardResult()
	
	if modelhash == nil then 
		modelhash = ""
	end

	if modelhash == "" then 
		return
	end
    
	local model = GetHashKey(modelhash)

	if IsModelValid(model) and IsModelAPed(model) then
    	RequestModel(model)
    	while not HasModelLoaded(model) do
        	Wait(100)
		end
	else
		exports['mythic_notify']:SendAlert('error', 'Invalid Ped Model. - [mAdmin]', 5000) 
	end

    SetPlayerModel(PlayerId(), model)
	SetModelAsNoLongerNeeded(model)
end

RegisterNetEvent('munchadminv2:slap')
AddEventHandler('munchadminv2:slap', function()
	SetEntityHealth(PlayerPedId(), 0)
end)

RegisterNetEvent('munchadminv2:freeze')
AddEventHandler('munchadminv2:freeze', function(toggle)
	frozen = toggle
	FreezeEntityPosition(PlayerPedId(), frozen)
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		FreezeEntityPosition(GetVehiclePedIsIn(PlayerPedId(), false), frozen)
	end 
end)

RegisterNetEvent('munchadminv2:gotobring')
AddEventHandler('munchadminv2:gotobring', function(x, y, z)
	SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
end)

local function freeze()
	frozen = not frozen
	if frozen then
		TriggerServerEvent("munchadminv2:freeze", GetPlayerServerId(selectedPlayer), true)
	else
		TriggerServerEvent("munchadminv2:freeze", GetPlayerServerId(selectedPlayer), false)
	end
end

local function spawnvehicle(dawhip)
    RequestModel(GetHashKey(dawhip))
    Citizen.CreateThread(
        function()
            local cartimer = 0
            while not HasModelLoaded(GetHashKey(dawhip)) do
                cartimer = cartimer + 100.0
                Citizen.Wait(100.0)
                if cartimer > 5000 then
                    exports['mythic_notify']:SendAlert('error', 'Vehicle was unable to be spawned. - [mAdmin]', 5000) 
                    break
                end
            end
            SpawnedCar = CreateVehicle(GetHashKey(dawhip), GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), true, true)
            SetVehicleEngineOn(SpawnedCar, true, true, false)
			SetPedIntoVehicle(PlayerPedId(), SpawnedCar, -1)
			SetVehicleNumberPlateText(SpawnedCar, "mAdmin")
        end
    )
end

local function fixvehicle()
	local player = PlayerPedId()
	local carrito = GetVehiclePedIsIn(player, false)
	if IsPedInAnyVehicle(player, true) then
		SetVehicleEngineHealth(carrito, 1000)
		SetVehicleEngineOn(carrito, true, true)
		SetVehicleFixed(carrito)
		exports['mythic_notify']:SendAlert('inform', 'Vehicle Fixed. - [mAdmin]', 5000)
	else
		exports['mythic_notify']:SendAlert('error', 'You are not in a vehicle. - [mAdmin]', 5000)
	end
end

local function cleanvehicle()
	local player = PlayerPedId()
	local carrito = GetVehiclePedIsIn(player, false)
	if IsPedInAnyVehicle(player, true) then
		SetVehicleDirtLevel(carrito, 0)
		exports['mythic_notify']:SendAlert('inform', 'Vehicle Cleaned. - [mAdmin]', 5000)
	else
		exports['mythic_notify']:SendAlert('error', 'You are not in a vehicle. - [mAdmin]', 5000)
	end
end

local function flipvehicle()
	local ppd = PlayerPedId()
	local dacar = GetVehiclePedIsIn(ppd)
	if IsPedInAnyVehicle(ppd, true) then
		if not IsVehicleOnAllWheels(dacar) then
			SetVehicleOnGroundProperly(dacar)
			exports['mythic_notify']:SendAlert('inform', 'Vehicle Flipped. - [mAdmin]', 5000)
		else
			exports['mythic_notify']:SendAlert('error', 'Your vehicle is not upside down. - [mAdmin]', 5000)
		end
	else
		exports['mythic_notify']:SendAlert('error', 'You are not in a vehicle. - [mAdmin]', 5000)
	end
end

local function deletevehicle()
	local ped = PlayerPedId()
	local vehs = GetVehiclePedIsIn(ped)
	if IsPedInAnyVehicle(ped, true) then
		DeleteVehicle(vehs)
	else
		exports['mythic_notify']:SendAlert('error', 'You are not in a vehicle. - [mAdmin]', 5000)
	end
end

local function selfheal()
	local ped = PlayerPedId()
	SetEntityHealth(ped, 200)  
	exports['mythic_notify']:SendAlert('inform', 'Healed. - [mAdmin]', 5000)
end

local function selfarmor()
	SetPedArmour(PlayerPedId(), 100)
	exports['mythic_notify']:SendAlert('inform', 'Armor Applied. - [mAdmin]', 5000)
end

local function selfinvis()
	invis = not invis
	if not invis then
		SetEntityVisible(PlayerPedId(), true)
	end
end

local function GetCamDirection()
    local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(PlayerPedId())
    local pitch = GetGameplayCamRelativePitch()
    
    local x = -math.sin(heading * math.pi / 180.0)
    local y = math.cos(heading * math.pi / 180.0)
    local z = math.sin(pitch * math.pi / 180.0)
    
    local len = math.sqrt(x * x + y * y + z * z)
    if len ~= 0 then
        x = x / len
        y = y / len
        z = z / len
    end
    
    return x, y, z
end

local function DrawGenericText(text)
	SetTextColour(186, 186, 186, 255)
	SetTextFont(7)
	SetTextScale(0.378, 0.378)
	SetTextWrap(0.0, 1.0)
	SetTextCentre(false)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 205)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(0.40, 0.0)
end

FormatCoord = function(coord)
	if coord == nil then
		return "unknown"
	end

	return tonumber(string.format("%.2f", coord))
end

Citizen.CreateThread(function()
  TriggerServerEvent("munchadminv2:openmenucheck")
  TriggerServerEvent("munchadminv2:godmodecheck")
  TriggerServerEvent("munchadminv2:freezeplayercheck")
  TriggerServerEvent("munchadminv2:manageplayercheck")
  TriggerServerEvent("munchadminv2:invisibilitycheck")
  TriggerServerEvent("munchadminv2:unbancheck")
  TriggerServerEvent("munchadminv2:custompedcheck")
  TriggerServerEvent("munchadminv2:pedwipecheck")
  TriggerServerEvent("munchadminv2:objectwipecheck")
  TriggerServerEvent("munchadminv2:masswipecheck")
  TriggerServerEvent("munchadminv2:noclipcheck")
  TriggerServerEvent("munchadminv2:spawnvehiclecheck")
  TriggerServerEvent("munchadminv2:carwipecheck")
  TriggerServerEvent("munchadminv2:banplayercheck")
  TriggerServerEvent("munchadminv2:reviveplayercheck")
  TriggerServerEvent("munchadminv2:gotobringplayercheck")
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(15000)
		TriggerServerEvent("munchadminv2:requestCachedPlayers") 
	end
end)

RegisterNetEvent("munchadminv2:openmenu")
AddEventHandler("munchadminv2:openmenu", function(isAllowedtoOpenMenu)
    allowedToUseMenu = isAllowedtoOpenMenu
end)

RegisterNetEvent("munchadminv2:bandamunch")
AddEventHandler("munchadminv2:bandamunch", function(isAllowedtoBan)
    allowedToBan = isAllowedtoBan
end)

RegisterNetEvent("munchadminv2:managedamunch")
AddEventHandler("munchadminv2:managedamunch", function(isAllowedtoManage)
    allowedToManage = isAllowedtoManage
end)

RegisterNetEvent("munchadminv2:freezedamunch")
AddEventHandler("munchadminv2:freezedamunch", function(isAllowedtoFreeze)
    allowedToFreeze = isAllowedtoFreeze
end)

RegisterNetEvent("munchadminv2:gotobringdamunch")
AddEventHandler("munchadminv2:gotobringdamunch", function(isAllowedtoGotoBring)
    allowedToGotoBring = isAllowedtoGotoBring
end)

RegisterNetEvent("munchadminv2:revivedamunch")
AddEventHandler("munchadminv2:revivedamunch", function(isAllowedtoRevive)
    allowedToRevive = isAllowedtoRevive
end)

RegisterNetEvent("munchadminv2:noclip")
AddEventHandler("munchadminv2:noclip", function(isAllowedtoNoclip)
    allowedToNoclip = isAllowedtoNoclip
end)

RegisterNetEvent("munchadminv2:godmode")
AddEventHandler("munchadminv2:godmode", function(isAllowedtoUseGodmode)
    allowedToUseGodmode = isAllowedtoUseGodmode
end)

RegisterNetEvent("munchadminv2:invisibility")
AddEventHandler("munchadminv2:invisibility", function(isAllowedtoUseInvisibility)
    allowedToUseInvisibility = isAllowedtoUseInvisibility
end)

RegisterNetEvent("munchadminv2:unbanplayer")
AddEventHandler("munchadminv2:unbanplayer", function(isAllowedtoUnban)
    allowedToUnban = isAllowedtoUnban
end)

RegisterNetEvent("munchadminv2:customped")
AddEventHandler("munchadminv2:customped", function(isAllowedtoCustomPed)
    allowedToCustomPed = isAllowedtoCustomPed
end)

RegisterNetEvent("munchadminv2:pedwipe")
AddEventHandler("munchadminv2:pedwipe", function(isAllowedtoPedWipe)
    allowedToPedWipe = isAllowedtoPedWipe
end)

RegisterNetEvent("munchadminv2:objectwipe")
AddEventHandler("munchadminv2:objectwipe", function(isAllowedtoObjectWipe)
    allowedToObjectWipe = isAllowedtoObjectWipe
end)

RegisterNetEvent("munchadminv2:masswipe")
AddEventHandler("munchadminv2:masswipe", function(isAllowedtoMassWipe)
    allowedToMassWipe = isAllowedtoMassWipe
end)

RegisterNetEvent("munchadminv2:carwipe")
AddEventHandler("munchadminv2:carwipe", function(isAllowedtoCarWipe)
    allowedToCarWipe = isAllowedtoCarWipe
end)

RegisterNetEvent("munchadminv2:spawnvehicle")
AddEventHandler("munchadminv2:spawnvehicle", function(isAllowedtoSpawnVehicle)
    allowedToSpawnVehicle = isAllowedtoSpawnVehicle
end)

cachedplayers = {}

RegisterNetEvent("munchadminv2:fillCachedPlayers")
AddEventHandler("munchadminv2:fillCachedPlayers", function(thecached)
	cachedplayers = thecached
end)

Citizen.CreateThread(function()

	WarMenu.CreateMenu('munch', '')
	WarMenu.SetSubTitle('munch', 'mAdmin | munchdev.xyz')
	WarMenu.CreateSubMenu('vehicle', 'munch', 'Vehicle')
	WarMenu.CreateSubMenu('player', 'munch', 'Player List')
    WarMenu.CreateSubMenu('ass', 'munch', 'Assists')
	WarMenu.CreateSubMenu('wea', 'munch', 'Weather')
	WarMenu.CreateSubMenu('self', 'munch', 'Self')
    WarMenu.CreateSubMenu('util', 'munch', 'Utilities')
    WarMenu.CreateSubMenu('dev', 'munch', 'Development')
    WarMenu.CreateSubMenu('set', 'munch', 'Info')
	WarMenu.CreateSubMenu('wea2', 'munch', 'Time')

	WarMenu.CreateSubMenu('displayers', 'player', 'Disconnected Players')
	WarMenu.CreateSubMenu('open', 'ass', 'Open Assist Menu')
	WarMenu.CreateSubMenu('unban', 'player', 'Unban Player')
	WarMenu.CreateSubMenu('steam', 'unban', 'Enter Player Steam Name')
	WarMenu.CreateSubMenu('selectedPlayerOptionsdisc', 'displayers', 'Selected Player Options') 
	WarMenu.CreateSubMenu('selectedPlayerOptions', 'player', 'Selected Player Options')
	WarMenu.CreateSubMenu('selectedPlayerInfo', 'selectedPlayerOptions', 'Selected Player Info')
	WarMenu.CreateSubMenu('setgroup', 'selectedPlayerInfo', 'Set Player Group')
	WarMenu.CreateSubMenu('setperms', 'selectedPlayerInfo', 'Set Player Permission Level')
    WarMenu.CreateSubMenu('kick', 'selectedPlayerOptions', 'Are You Sure?')
	WarMenu.CreateSubMenu('ban', 'selectedPlayerOptions', 'Are You Sure?')
	WarMenu.CreateSubMenu('offlineban', 'selectedPlayerOptionsdisc', 'Are You Sure?')

	while true do
	    local sleepThread = 500

		playerhealth = GetEntityHealth(GetPlayerPed(selectedPlayer))
		playerarmor = GetPedArmour(GetPlayerPed(selectedPlayer))
		if WarMenu.IsMenuOpened('munch') then
			if WarMenu.MenuButton('Player List', 'player') then
			    sleepThread = 5

            elseif WarMenu.MenuButton('Assists', 'ass') then
			    sleepThread = 5

			elseif WarMenu.MenuButton('Vehicle', 'vehicle') then
			    sleepThread = 5

			elseif WarMenu.MenuButton('Self', 'self') then
			    sleepThread = 5

            elseif WarMenu.MenuButton('Weather', 'wea') then
			    sleepThread = 5

            elseif WarMenu.MenuButton('Time', 'wea2') then
			    sleepThread = 5

			elseif WarMenu.MenuButton('Development', 'dev') then
			    sleepThread = 5

			elseif WarMenu.MenuButton('Utilities', 'util') then
			    sleepThread = 5

            elseif WarMenu.MenuButton('Info', 'set') then
			    sleepThread = 5

			elseif WarMenu.Button('Exit mAdmin') then
			    sleepThread = 5

			WarMenu.CloseMenu()
            end
			
		elseif WarMenu.IsMenuOpened('player') then
			WarMenu.SetSubTitle('player', 'Players Online - ' ..#GetActivePlayers())
			local hom = Getmunch()
			for k, v in pairs(hom) do
				local currentPlayer = v
				if WarMenu.MenuButton(GetPlayerName(currentPlayer).." (ID - "..GetPlayerServerId(currentPlayer)..")", 'selectedPlayerOptions') then
					selectedPlayer = currentPlayer 
				end
			end
			if WarMenu.MenuButton('Disconnected Players', 'displayers') then
			end
			if WarMenu.Button('Refresh Disconnected Players') then
				TriggerServerEvent("munchadminv2:requestCachedPlayers")
			end
			if allowedToUnban then
				if WarMenu.MenuButton('Unban Player', 'unban') then
				end
			end
			if WarMenu.Button('Go Back') then
				WarMenu.OpenMenu('munch')
			end

		elseif WarMenu.IsMenuOpened('displayers') then
			for _, cps in pairs(cachedplayers) do
				if cps.name ~= nil and cps.id ~= nil and cps.id < 1000 then
					if WarMenu.MenuButton(cps.name.." (ID - "..cps.id..")", 'selectedPlayerOptionsdisc') then
						seldiscplayer = cps 
					end
				end
			end
			if WarMenu.Button('Go Back') then
				WarMenu.OpenMenu('player')
			end
		elseif WarMenu.IsMenuOpened('unban') then
			if WarMenu.MenuButton('Enter Player Steam Hex', 'steam') then
				WarMenu.SetSubTitle('unban', 'ex: steam:110000148e6d440')
				DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "ex: steam:110000148e6d440 (BACKSPACE THIS LINE BEFORE TYPING)", "", "", 64 + 1)
				
				while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
					Citizen.Wait(0)
				end
					
				local result = GetOnscreenKeyboardResult()

				if result == nil then 
					WarMenu.OpenMenu('unban')
					result = "a"
				elseif result == "" then
					WarMenu.OpenMenu('unban')
					result = "a"
				end

				local length = string.len(result)

				if not string.match(result, "steam") then
					exports['mythic_notify']:SendAlert('error', 'Invalid Steam Hex. - [mAdmin]', 5000) 
					WarMenu.OpenMenu('unban')
				elseif length < 21 then
					exports['mythic_notify']:SendAlert('error', 'Invalid Steam Hex. - [mAdmin]', 5000) 
					WarMenu.OpenMenu('unban')
				elseif length > 21 then
					exports['mythic_notify']:SendAlert('error', 'Invalid Steam Hex. - [mAdmin]', 5000) 
					WarMenu.OpenMenu('unban')
				end
				
				targetU = result
			end
			if WarMenu.Button('Go Back') then
				WarMenu.OpenMenu('player')
			end
		
		elseif WarMenu.IsMenuOpened('steam') then
			WarMenu.SetSubTitle('steam', 'Are You Sure?')
			if WarMenu.Button('Yes') then
				TriggerServerEvent('munchadminv2:unban', targetU)
				exports['mythic_notify']:SendAlert('inform', 'Player Unbanned. - [mAdmin]', 5000) 
				WarMenu.OpenMenu('player')
			elseif WarMenu.Button('No') then
				WarMenu.OpenMenu('player')
			end

		elseif WarMenu.IsMenuOpened('selectedPlayerOptionsdisc') then
			WarMenu.SetSubTitle('selectedPlayerOptionsDisc', ''..seldiscplayer.name..' (ID - '..seldiscplayer.id..')')
			if WarMenu.MenuButton('Offline Ban', 'offlineban') then
			elseif WarMenu.Button('Go Back') then
				WarMenu.OpenMenu('player')
			end

		elseif WarMenu.IsMenuOpened('selectedPlayerOptions') then
			WarMenu.SetSubTitle('selectedPlayerOptions', ''..GetPlayerName(selectedPlayer)..' (ID - '..GetPlayerServerId(selectedPlayer)..')')
			if WarMenu.MenuButton('Kick', 'kick') then	
			end
			if allowedToBan then	
				if WarMenu.MenuButton('Ban', 'ban') then
				end
			end
			if WarMenu.Button("Spectate", isSpectatingTarget and '~g~Spectating: ~s~['..GetPlayerServerId(spectatedPlayer)..']') then
				spectatedPlayer = selectedPlayer
				spectate(spectatedPlayer)
			end
			if allowedToGotoBring then
            	if WarMenu.Button("Goto") then
					TriggerServerEvent("munchadminv2:gotobutton", GetPlayerServerId(selectedPlayer))
				elseif WarMenu.Button("Bring") then
					TriggerServerEvent("munchadminv2:bringbutton", GetPlayerServerId(selectedPlayer))
				end
			end
			if allowedToRevive then
            	if WarMenu.Button("Revive") then 
					TriggerServerEvent("munchadminv2:revive", GetPlayerServerId(selectedPlayer))
				end
			end
            if WarMenu.Button("Force Skin") then
                TriggerServerEvent("munchadminv2:forceskin", GetPlayerServerId(selectedPlayer))
			elseif WarMenu.Button("Kill") then
				TriggerServerEvent("munchadminv2:slap", GetPlayerServerId(selectedPlayer))
			end
			if allowedToFreeze then
				if WarMenu.CheckBox("Freeze", frozen) then
					freeze()
				end
			end
			if WarMenu.Button('Screenshot') then
				TriggerServerEvent("munchadminv2:TakeScreenshot", GetPlayerServerId(selectedPlayer))
			end
			if allowedToManage then
				if WarMenu.MenuButton('Manage', 'selectedPlayerInfo') then
				end
			end
			    if WarMenu.Button('Go Back') then
				WarMenu.OpenMenu('player')
			end

		elseif WarMenu.IsMenuOpened('selectedPlayerInfo') then
			WarMenu.SetSubTitle('selectedPlayerInfo', ''..GetPlayerName(selectedPlayer)..' (ID - '..GetPlayerServerId(selectedPlayer)..')')
			if WarMenu.Button('Set Bank') then
				local player = GetPlayerServerId(selectedPlayer)
				DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 64 + 1)
				while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
					Citizen.Wait(0)
				end
				local result = GetOnscreenKeyboardResult()
				local bank = tonumber(result)
				TriggerServerEvent('munchadminv2:setbank', player, bank)
			elseif WarMenu.Button('Set Money') then
					local player = GetPlayerServerId(selectedPlayer)
					DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 64 + 1)
					while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
						Citizen.Wait(0)
					end
					local result = GetOnscreenKeyboardResult()
					local money = tonumber(result)
					TriggerServerEvent('munchadminv2:setmoney', player, money)
			elseif WarMenu.MenuButton('Set Group', 'setgroup') then
			elseif WarMenu.MenuButton('Set Permission Level', 'setperms') then
			end

		elseif WarMenu.IsMenuOpened('setgroup') then
			if WarMenu.ComboBox("Group", PlayerGroups, currGroupIndex, selGroupIndex, function(currentIndex, selectedIndex)
                currGroupIndex = currentIndex
                selGroupIndex = currentIndex
                chosengroup = PlayerGroups[currentIndex]
            end) then 
            elseif WarMenu.Button('Confirm') then
				local player = GetPlayerServerId(selectedPlayer)
				local group = chosengroup
				
				TriggerServerEvent('munchadminv2:setgroup', player, group)
				WarMenu.OpenMenu('selectedPlayerInfo')
			end
		
		elseif WarMenu.IsMenuOpened('setperms') then
			if WarMenu.ComboBox("Level", PermLevels, currLevelIndex, selLevelIndex, function(currentIndex, selectedIndex)
                currLevelIndex = currentIndex
                selLevelIndex = currentIndex
                chosenlevel = PermLevels[currentIndex]
            end) then 
            elseif WarMenu.Button('Confirm') then
				local player = GetPlayerServerId(selectedPlayer)
				local level = chosenlevel
				
				TriggerServerEvent('munchadminv2:setpermissionlevel', player, level)
				WarMenu.OpenMenu('selectedPlayerInfo')
			end

		elseif WarMenu.IsMenuOpened('kick') then
			if WarMenu.Button('Reason:', KickReason) then
				DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 64 + 1)				
				while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
					Citizen.Wait(0)
				end					
				local result = GetOnscreenKeyboardResult()
				KickReason = result
				if KickReason == "" then 
					KickReason = "No Reason Specified."
				end
			elseif WarMenu.Button('Confirm') then
				if KickReason == nil then 
					KickReason = "No Reason Specified."
				end
				TriggerServerEvent('munchadminv2:kickplayer', GetPlayerServerId(selectedPlayer), KickReason)
				WarMenu.OpenMenu('player')
			elseif WarMenu.Button('Go Back') then
				WarMenu.OpenMenu('selectedPlayerOptions')
			end
		elseif WarMenu.IsMenuOpened('ban') then
			if WarMenu.Button('Reason:', BanReason) then
				DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 64 + 1)
				while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
					Citizen.Wait(0)
				end
				local result = GetOnscreenKeyboardResult()
				BanReason = result
				if BanReason == "" then
					BanReason = "No Reason Specified."
				end
			elseif WarMenu.ComboBox("Ban Length", BanLength, currBanIndex, selBanIndex, function(currentIndex, selectedIndex)
				currBanIndex = currentIndex
				selBanIndex = currentIndex
				duration = BanLength[currentIndex]
				if duration == "1 Hour" then
					duration = 3600
				elseif duration == "3 Hours" then
					duration = 10800
				elseif duration == "6 Hours" then
					duration = 21600
				elseif duration == "12 Hours" then
					duration = 43200
				elseif duration == "1 Day" then
					duration = 86400
				elseif duration == "2 Days" then
					duration = 172800
				elseif duration == "3 Days" then
					duration = 259200
				elseif duration == "1 Week" then
					duration = 518400
				elseif duration == "2 Weeks" then
						duration = 1123200
				elseif duration == "1 Month" then
					duration = 2678400
				elseif duration == "Permanent" then
					duration = 10444633200
				end
			end) then 
			elseif WarMenu.Button('Confirm') then
				if BanReason == nil then
					BanReason = "No Reason Specified. Join the discord and make a ticket for more information regarding your ban."
				end
				local duration = duration
				TriggerServerEvent('munchadminv2:banplayer', GetPlayerServerId(selectedPlayer), BanReason, duration)
				WarMenu.OpenMenu('player')
			elseif WarMenu.Button('Go Back') then
				WarMenu.OpenMenu('selectedPlayerOptions')
			end
		elseif WarMenu.IsMenuOpened('offlineban') then
			if WarMenu.Button('Reason:', offlinebanreason) then
				DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 64 + 1)
				while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
					Citizen.Wait(0)
				end
				local result = GetOnscreenKeyboardResult()
				offlinebanreason = result
				if offlinebanreason == "" then
					offlinebanreason = "No Reason Specified."
				end
			elseif WarMenu.ComboBox("Ban Length", BanLength, currBanIndex, selBanIndex, function(currentIndex, selectedIndex)
				currBanIndex = currentIndex
				selBanIndex = currentIndex
				dursoo = BanLength[currentIndex]
				if dursoo == "1 minute" then
					dursoo = 1
				elseif dursoo == "1 Hour" then
					dursoo = 3600
				elseif dursoo == "3 Hours" then
					dursoo = 10800
				elseif dursoo == "6 Hours" then
					dursoo = 21600
				elseif dursoo == "12 Hours" then
					dursoo = 43200
				elseif dursoo == "1 Day" then
					dursoo = 86400
				elseif dursoo == "2 Days" then
					dursoo = 172800
				elseif dursoo == "3 Days" then
					dursoo = 259200
				elseif dursoo == "1 Week" then
					dursoo = 518400
				elseif dursoo == "2 Weeks" then
					dursoo = 1123200
				elseif dursoo == "1 Month" then
					dursoo = 2678400
				elseif dursoo == "Permanent" then
					dursoo = 10444633200
				end
			end) then 
			elseif WarMenu.Button('Confirm') then
				if offlinebanreason == nil then
					offlinebanreason = "No Reason Specified."
				end
				local dursio = dursoo
				TriggerServerEvent('munchadminv2:offlinebanplayer', seldiscplayer.id, seldiscplayer.license, seldiscplayer.steam, seldiscplayer.live, seldiscplayer.xbl, seldiscplayer.discord, seldiscplayer.ip, seldiscplayer.name, dursio, offlinebanreason)
				WarMenu.OpenMenu('player')
			elseif WarMenu.Button('Go Back') then
				WarMenu.OpenMenu('selectedPlayerOptionsDisc')
			end
		elseif WarMenu.IsMenuOpened('vehicle') then
			WarMenu.SetSubTitle('vehicle', 'Vehicle Options')
			if allowedToSpawnVehicle then
				if WarMenu.Button("Spawn Vehicle") then
					DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 64 + 1)
		
					while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
						Citizen.Wait(0)
					end
					
					local spawndawhip = GetOnscreenKeyboardResult()
					if spawndawhip and IsModelValid(spawndawhip) and IsModelAVehicle(spawndawhip) then
						if spawndawhip == "adder" then
							exports['mythic_notify']:SendAlert('error', 'This vehicle is blacklisted. - [mAdmin]', 5000)
						else
							spawnvehicle(spawndawhip)
						end
					else
						exports['mythic_notify']:SendAlert('error', 'Invalid Vehicle Model. - [mAdmin]', 5000)
					end
				end
			end
			if WarMenu.Button("Delete Vehicle") then
				deletevehicle()
			elseif WarMenu.Button('Go Back') then
				WarMenu.OpenMenu('munch')
            end

		elseif WarMenu.IsMenuOpened('self') then
			WarMenu.SetSubTitle('self', 'Self Options')
			if WarMenu.Button("Heal") then
			    ExecuteCommand("heal")
			elseif WarMenu.Button("Revive") then
			    ExecuteCommand("revive")
			elseif WarMenu.Button("Force Skin") then
				TriggerEvent("betrayed_skins:defaultReset")
			end
			if allowedToCustomPed then
				 if WarMenu.Button("Custom Ped") then
					customped()
				end
			end
			if allowedToUseInvisibility then
				if WarMenu.CheckBox('Invisibility', invis) then
					selfinvis()
				end
			end
			if allowedToNoclip then
				if WarMenu.CheckBox('Noclip', noclip) then
					noclip = not noclip
					if noclip then
						SetEntityVisible(PlayerPedId(), false, false)
					else
						SetEntityRotation(GetVehiclePedIsIn(PlayerPedId(), 0), GetGameplayCamRot(2), 2, 1)
						SetEntityVisible(GetVehiclePedIsIn(PlayerPedId(), 0), true, false)
						SetEntityVisible(PlayerPedId(), true, false)
					end
				end
		    end
			if WarMenu.Button('Go Back') then
				WarMenu.OpenMenu('munch')
			end
		
		elseif WarMenu.IsMenuOpened('dev') then
			if WarMenu.Button("~r~Teleport to Waypoint") then
				tpm()
			elseif WarMenu.CheckBox('~g~Hash Gun', infoOn) then
				infoOn = not infoOn
			elseif WarMenu.CheckBox('~b~Get Your Coords', coordsVisible) then
				coordsVisible = not coordsVisible
			elseif WarMenu.Button('~p~Back') then
				WarMenu.OpenMenu('munch')
            end    
            
        elseif WarMenu.IsMenuOpened('set') then
			    if WarMenu.Button(Config.ServerName) then
			elseif WarMenu.Button('Made by Munch#3374') then
			elseif WarMenu.Button('Go Back') then
				WarMenu.OpenMenu('munch')
            end
			
        elseif WarMenu.IsMenuOpened('tide') then
			if WarMenu.Button('"We Never Lose"') then
			elseif WarMenu.Button('Dont you mean') then
			elseif WarMenu.Button('"We Always Lose?"') then
				WarMenu.OpenMenu('munch')
			end

		elseif WarMenu.IsMenuOpened('util') then
			if allowedToCarWipe then
				if WarMenu.Button("Car Wipe", "Instant") then
					TriggerEvent('munchadminv2:utilshit')
				end
			end
			if allowedToMassWipe then
				if WarMenu.Button("Entity Wipe", "Instant") then
					TriggerEvent('munchadminv2:utilbitch')
					TriggerEvent('munchadminv2:utilfuck')
					TriggerEvent('munchadminv2:utilshit')
				end
			end
		end

		    if WarMenu.IsMenuOpened('ass') then
				if WarMenu.Button("Open Assist Menu", 'GUI') then
					TriggerEvent('munchadminv2:openassists')
			elseif WarMenu.Button('Go Back') then
				WarMenu.OpenMenu('munch')
				end
			end

		    if WarMenu.IsMenuOpened('wea') then
				    if WarMenu.Button("ExtraSunny", 'Weather') then
				ExecuteCommand("weather extrasunny")
				    elseif WarMenu.Button("Clear", 'Weather') then
				ExecuteCommand("weather clear")
				    elseif WarMenu.Button("Neutral", 'Weather') then
				ExecuteCommand("weather neutral")
				    elseif WarMenu.Button("Smog", 'Weather') then
				ExecuteCommand("weather smog")
				    elseif WarMenu.Button("Foggy", 'Weather') then
				ExecuteCommand("weather foggy")
				    elseif WarMenu.Button("Overcast", 'Weather') then
				ExecuteCommand("weather overcast")
				    elseif WarMenu.Button("Clouds", 'Weather') then
				ExecuteCommand("weather clouds")
				    elseif WarMenu.Button("Clearing", 'Weather') then
				ExecuteCommand("weather clearing")
				    elseif WarMenu.Button("Rain", 'Weather') then
				ExecuteCommand("weather rain")
				    elseif WarMenu.Button("Thunder", 'Weather') then
				ExecuteCommand("weather thunder")
				    elseif WarMenu.Button("Snow", 'Weather') then
				ExecuteCommand("weather snow")
				    elseif WarMenu.Button("Blizzard", 'Weather') then
				ExecuteCommand("weather blizzard")
				    elseif WarMenu.Button("Snowlight", 'Weather') then
				ExecuteCommand("weather snowlight")
				    elseif WarMenu.Button("Xmas", 'Weather') then
				ExecuteCommand("weather xmas")
				    elseif WarMenu.Button("Halloween", 'Weather') then
				ExecuteCommand("weather halloween")
			elseif WarMenu.Button('Go Back') then
				WarMenu.OpenMenu('munch')
				end
			end

		    if WarMenu.IsMenuOpened('wea2') then
				    if WarMenu.Button("12AM", 'Time') then
				ExecuteCommand("time 00 00")
				    elseif WarMenu.Button("1AM", 'Time') then
				ExecuteCommand("time 1 00")
				    elseif WarMenu.Button("2AM", 'Time') then
				ExecuteCommand("time 2 00")
				    elseif WarMenu.Button("3AM", 'Time') then
				ExecuteCommand("time 3 00")
				    elseif WarMenu.Button("4AM", 'Time') then
				ExecuteCommand("time 4 00")
				    elseif WarMenu.Button("5AM", 'Time') then
				ExecuteCommand("time 5 00")
				    elseif WarMenu.Button("6AM", 'Time') then
				ExecuteCommand("time 6 00")
				    elseif WarMenu.Button("7AM", 'Time') then
				ExecuteCommand("time 7 00")
				    elseif WarMenu.Button("8AM", 'Time') then
				ExecuteCommand("time 8 00")
				    elseif WarMenu.Button("9AM", 'Time') then
				ExecuteCommand("time 9 00")
				    elseif WarMenu.Button("10AM", 'Time') then
				ExecuteCommand("time 10 00")
				    elseif WarMenu.Button("11AM", 'Time') then
				ExecuteCommand("time 11 00")
				    elseif WarMenu.Button("12PM", 'Time') then
				ExecuteCommand("time 12 00")
				    elseif WarMenu.Button("1PM", 'Time') then
				ExecuteCommand("time 13 00")
				    elseif WarMenu.Button("2PM", 'Time') then
				ExecuteCommand("time 14 00")
				    elseif WarMenu.Button("3PM", 'Time') then
				ExecuteCommand("time 15 00")
				    elseif WarMenu.Button("4PM", 'Time') then
				ExecuteCommand("time 16 00")
				    elseif WarMenu.Button("5PM", 'Time') then
				ExecuteCommand("time 17 00")
				    elseif WarMenu.Button("6PM", 'Time') then
				ExecuteCommand("time 18 00")
				    elseif WarMenu.Button("7PM", 'Time') then
				ExecuteCommand("time 19 00")
				    elseif WarMenu.Button("8PM", 'Time') then
				ExecuteCommand("time 20 00")
				    elseif WarMenu.Button("9PM", 'Time') then
				ExecuteCommand("time 21 00")
				    elseif WarMenu.Button("10PM", 'Time') then
				ExecuteCommand("time 22 00")
				    elseif WarMenu.Button("11PM", 'Time') then
				ExecuteCommand("time 23 00")
			elseif WarMenu.Button('Go Back') then
				WarMenu.OpenMenu('munch')
			end

		elseif IsControlJustReleased(0, Config.OpenMenu) then 
			if allowedToUseMenu then
				WarMenu.OpenMenu('munch')
			end
		end

        WarMenu.Display()

		SetPlayerInvincible(PlayerId(), godmode)
	
		if coordsVisible then
			local playerPed = PlayerPedId()
			local playerX, playerY, playerZ = table.unpack(GetEntityCoords(playerPed))
			local playerH = GetEntityHeading(playerPed)
			DrawGenericText(("~r~X~r~: %s ~g~Y~g~: %s ~b~Z~b~: %s ~y~H~y~: %s"):format(FormatCoord(playerX), FormatCoord(playerY), FormatCoord(playerZ), FormatCoord(playerH)))
		end

		if noclip then
			local NoclipSpeed = 1
            local isInVehicle = IsPedInAnyVehicle(PlayerPedId(), 0)
            local k = nil
            local x, y, z = nil
            
            if not isInVehicle then
                k = PlayerPedId()
                x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), 2))
            else
                k = GetVehiclePedIsIn(PlayerPedId(), 0)
                x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), 1))
            end
            
            if isInVehicle and GetSeatPedIsIn(PlayerPedId()) ~= -1 then RequestControlOnce(k) end
            
            local dx, dy, dz = GetCamDirection()
            SetEntityVisible(PlayerPedId(), 0, 0)
            SetEntityVisible(k, 0, 0)
            
            SetEntityVelocity(k, 0.0001, 0.0001, 0.0001)
            
            if IsDisabledControlPressed(0, 32) then -- MOVE FORWARD
                x = x + NoclipSpeed * dx
                y = y + NoclipSpeed * dy
                z = z + NoclipSpeed * dz
            end
            
            if IsDisabledControlPressed(0, 269) then -- MOVE BACK
                x = x - NoclipSpeed * dx
                y = y - NoclipSpeed * dy
                z = z - NoclipSpeed * dz
            end
			
			if IsDisabledControlPressed(0, 22) then -- MOVE UP
                z = z + NoclipSpeed
            end
            
			if IsDisabledControlPressed(0, 36) then -- MOVE DOWN
                z = z - NoclipSpeed
            end
            
            SetEntityCoordsNoOffset(k, x, y, z, true, true, true)
        end
		
		if infoOn then                                     
            pause = 5                                       
            local player = GetPlayerPed(-1)               
            if IsPlayerFreeAiming(PlayerId()) then          
                local entity = getEntity(PlayerId())       
                local coords = GetEntityCoords(entity)     
                local heading = GetEntityHeading(entity)   
                local model = GetEntityModel(entity)        
                coordsText = coords                        
                headingText = heading                      
                modelText = model                           
            end                                           
            DrawInfos("Coordinates: " .. coordsText .. "\nHeading: " .. headingText .. "\nHash: " .. modelText)    
        end     

		if invis then
            SetEntityVisible(PlayerPedId(), 0, 0)
        end

		if drawspectate then
			local targetPed = GetPlayerPed(drawTarget)
			local thaname = GetPlayerName(selectedPlayer)
			drawspectext("~y~Currently Spectating~s~: "..thaname.."\nPress [~y~E~s~] to Stop Spectating")
			
			if IsControlJustPressed(0, 103) then
				spectate(targetPed)
				StopDrawPlayerInfo()
			end
			
		end

		Citizen.Wait(1)
	end
end)

RegisterCommand("die", function()
	SetEntityHealth(PlayerPedId(), 0)
end, false)

CurrentWeather = 'EXTRASUNNY'
local lastWeather = CurrentWeather
local baseTime = 0
local timeOffset = 0
local timer = 0
local freezeTime = false
local blackout = false

RegisterNetEvent('vSync:updateWeather')
AddEventHandler('vSync:updateWeather', function(NewWeather, newblackout)
    CurrentWeather = NewWeather
    blackout = newblackout
end)

Citizen.CreateThread(function()
    while true do
        if lastWeather ~= CurrentWeather then
            lastWeather = CurrentWeather
            SetWeatherTypeOverTime(CurrentWeather, 15.0)
            Citizen.Wait(150000)
        end
        Citizen.Wait(0) -- Wait 0 seconds to prevent crashing.
        SetBlackout(blackout)
        ClearOverrideWeather()
        ClearWeatherTypePersist()
        SetWeatherTypePersist(lastWeather)
        SetWeatherTypeNow(lastWeather)
        SetWeatherTypeNowPersist(lastWeather)
        if lastWeather == 'XMAS' then
            SetForceVehicleTrails(true)
            SetForcePedFootstepsTracks(true)
        else
            SetForceVehicleTrails(false)
            SetForcePedFootstepsTracks(false)
        end
    end
end)

RegisterNetEvent('vSync:updateTime')
AddEventHandler('vSync:updateTime', function(base, offset, freeze)
    freezeTime = freeze
    timeOffset = offset
    baseTime = base
end)

Citizen.CreateThread(function()
    local hour = 0
    local minute = 0
    while true do
        Citizen.Wait(0)
        local newBaseTime = baseTime
        if GetGameTimer() - 500  > timer then
            newBaseTime = newBaseTime + 0.25
            timer = GetGameTimer()
        end
        if freezeTime then
            timeOffset = timeOffset + baseTime - newBaseTime			
        end
        baseTime = newBaseTime
        hour = math.floor(((baseTime+timeOffset)/60)%24)
        minute = math.floor((baseTime+timeOffset)%60)
        NetworkOverrideClockTime(hour, minute, 0)
    end
end)

AddEventHandler('playerSpawned', function()
    TriggerServerEvent('vSync:requestSync')
end)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/weather', 'Change the weather.', {{ name="weatherType", help="Available types: extrasunny, clear, neutral, smog, foggy, overcast, clouds, clearing, rain, thunder, snow, blizzard, snowlight, xmas & halloween"}})
    TriggerEvent('chat:addSuggestion', '/time', 'Change the time.', {{ name="hours", help="A number between 0 - 23"}, { name="minutes", help="A number between 0 - 59"}})
    TriggerEvent('chat:addSuggestion', '/freezetime', 'Freeze / unfreeze time.')
    TriggerEvent('chat:addSuggestion', '/freezeweather', 'Enable/disable dynamic weather changes.')
    TriggerEvent('chat:addSuggestion', '/morning', 'Set the time to 09:00')
    TriggerEvent('chat:addSuggestion', '/noon', 'Set the time to 12:00')
    TriggerEvent('chat:addSuggestion', '/evening', 'Set the time to 18:00')
    TriggerEvent('chat:addSuggestion', '/night', 'Set the time to 23:00')
    TriggerEvent('chat:addSuggestion', '/blackout', 'Toggle blackout mode.')
end)

function ShowNotification(text)
		exports['mythic_notify']:SendAlert('inform', text, 5000)
end

RegisterNetEvent('vSync:notify')
AddEventHandler('vSync:notify', function(message)
    ShowNotification(message)
end)

