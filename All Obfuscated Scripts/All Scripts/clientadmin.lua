--[[
	id: rA75GlxWalPWY-86Gqq_3
	name: client-admin
	description: client-admin
	time1: 2021-06-11 15:36:40.50971+00
	time2: 2021-06-11 15:36:40.509712+00
	uploader: CPUG6VTvptq0yUHZMqFjxaXUceBN5FGMrRUsQ6ST
	uploadersession: ViA8IomNgnZ5bOlTCpE1Puo4WP439R
	flag: f
--]]

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

src = Tunnel.getInterface("vrp_admin",src)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAR COLOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vcolorv")
AddEventHandler("vcolorv",function(veh,r,g,b)
    if IsEntityAVehicle(veh) then
        SetVehicleCustomPrimaryColour(veh,r,g,b)
        --SetVehicleCustomSecondaryColour(veh,r,g,b)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- dv
-----------------------------------------------------------------------------------------------------------------------------------------
function src.deleteVehicle(vehicle)
	if IsEntityAVehicle(vehicle) then
		vSERVER.tryDelete(VehToNet(vehicle),GetVehicleEngineHealth(vehicle),GetVehicleBodyHealth(vehicle),GetVehicleFuelLevel(vehicle))
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRINT PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ppreset",function(source,args)
	if not exports["chat"]:statusChat() then return end

    local chapeu, jaqueta, blusa, mascara, calca, maos, acessorios, sapatos, oculos, mochila, colete = ""
    local ped = PlayerPedId()
    if GetEntityHealth(ped) > 100 then
        chapeu = "chapeu "..(GetPedPropIndex(ped, 0) > 0 and GetPedPropIndex(ped, 0) or "").." "..(GetPedPropTextureIndex(ped, 0) > 0 and GetPedPropTextureIndex(ped, 0) or "")
        oculos = "oculos "..(GetPedPropIndex(ped, 0) > 0 and GetPedPropIndex(ped, 0) or "").." "..(GetPedPropTextureIndex(ped, 0) > 0 and GetPedPropTextureIndex(ped, 0) or "")
        mascara = "mascara "..GetPedDrawableVariation(ped, 1).." "..GetPedTextureVariation(ped, 1)
        maos = "maos "..GetPedDrawableVariation(ped, 3).." "..GetPedTextureVariation(ped, 3)
        calca = "calca "..GetPedDrawableVariation(ped, 4).." "..GetPedTextureVariation(ped, 4)
        mochila = "mochila "..GetPedDrawableVariation(ped, 5).." "..GetPedTextureVariation(ped, 5)
        sapatos = "sapatos "..GetPedDrawableVariation(ped, 6).." "..GetPedTextureVariation(ped, 6)
        acessorios = "acessorios "..GetPedDrawableVariation(ped, 7).." "..GetPedTextureVariation(ped, 7)
        blusa = "blusa "..GetPedDrawableVariation(ped, 8).." "..GetPedTextureVariation(ped, 8)
        colete = "colete "..GetPedDrawableVariation(ped, 9).." "..GetPedTextureVariation(ped, 9)
        jaqueta = "jaqueta "..GetPedDrawableVariation(ped, 11).." "..GetPedTextureVariation(ped, 11)
        vRP.prompt("Preset:",chapeu.."; "..mascara.."; "..jaqueta.."; "..blusa.."; "..maos.."; "..calca.."; "..sapatos.."; "..acessorios.."; "..oculos.."; "..mochila.."; "..colete)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /NEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('Neymarzite')
AddEventHandler('Neymarzite',function(ForwardVectorX,ForwardVectorY,ForwardVectorZ,Tackler)
	SetPedToRagdollWithFall(PlayerPedId(),1500,2000,0,ForwardVector,1.0,0.0,0.0,0.0,0.0,0.0,0.0)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /TAPA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('feijonts:tapa')
AddEventHandler('feijonts:tapa',function()
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	if ped then
		SetEntityCoords(ped,x,y,(z+500))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FURAR PNEU TELEGUIADO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('feijonts:FurarPneuTeleguiado')
AddEventHandler('feijonts:FurarPneuTeleguiado', function(roda)
	if IsPedInAnyVehicle(PlayerPedId(), false) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1)  == PlayerPedId() then
		SetVehicleTyreBurst(GetVehiclePedIsIn(PlayerPedId(), false), roda, true, 1000.0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTRAR NO CARRO TELEGUIADO 
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('feijonts:SetarNoDocarro')
AddEventHandler('feijonts:SetarNoDocarro', function(nsource)
	--[[local nplayer = GetPlayerFromServerId(nsource)
	local nped = GetPlayerPed(nplayer)
	local ncarro = GetVehiclePedIsUsing(nped)
	local ped = PlayerPedId()
	if ncarro then
		SetPedIntoVehicle(ped, ncarro, -2)
	end]]--
	local ped = PlayerPedId()
	local ncarro = vRP.getNearestVehicle(10000)
	if IsVehicleSeatFree(ncarro, -1) then
		SetPedIntoVehicle(ped, ncarro, -1)
	else
		SetPedIntoVehicle(ped, ncarro, -2)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TURBAO
-----------------------------------------------------------------------------------------------------------------------------------------
local turbao = false
local qtdturbao = 150.0
RegisterNetEvent('feijonts:LigarTurbao')
AddEventHandler('feijonts:LigarTurbao', function(qtd)
	if qtd then qtdturbao = qtd end
	local ped = PlayerPedId()
	turbao = not turbao
	print('TURBAO', turbao)
end)

Citizen.CreateThread(function() 
	while true do
		local timeDistance = 500
		if turbao then
			local ped = PlayerPedId()
			local veh = GetVehiclePedIsIn(ped, false)
			if veh then
				timeDistance = 4
				if IsControlJustPressed(0,316) then
					SetVehicleEnginePowerMultiplier(veh, qtdturbao)
					SetVehicleEngineTorqueMultiplier(veh, qtdturbao)
					TriggerEvent('chatMessage', 'TURBAO', {0,150,0}, 'LIGADO ' .. qtdturbao .. 'Kg')
				end
				if IsControlJustPressed(0,317) then
					SetVehicleEnginePowerMultiplier(veh, 1.0)
					SetVehicleEngineTorqueMultiplier(veh, 1.0)
					TriggerEvent('chatMessage', 'TURBAO', {150,0,0}, 'DESLIGADO')
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('admcuff')
AddEventHandler('admcuff',function()
	local ped = PlayerPedId()
	if vRP.isHandcuffed() then
		vRP._setHandcuffed(source,false)
		SetPedComponentVariation(PlayerPedId(),7,0,0,2)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("syncarea")
AddEventHandler("syncarea",function(x,y,z)
    ClearAreaOfVehicles(x,y,z,2000.0,false,false,false,false,false)
    ClearAreaOfEverything(x,y,z,2000.0,false,false,false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TROCAR SEXO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinmenu")
AddEventHandler("skinmenu",function(mhash)
    while not HasModelLoaded(mhash) do
        RequestModel(mhash)
        Citizen.Wait(10)
    end

    if HasModelLoaded(mhash) then
        SetPlayerModel(PlayerId(),mhash)
        SetModelAsNoLongerNeeded(mhash)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCDELETEOBJ
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("syncdeleteobj")
AddEventHandler("syncdeleteobj",function(index)
    if NetworkDoesNetworkIdExist(index) then
        local v = NetToPed(index)
        if DoesEntityExist(v) and IsEntityAnObject(v) then
            Citizen.InvokeNative(0xAD738C3085FE7E11,v,true,true)
            SetEntityAsMissionEntity(v,true,true)
            NetworkRequestControlOfEntity(v)
            Citizen.InvokeNative(0x539E0AE3E6634B9F,Citizen.PointerValueIntInitialized(v))
            DeleteEntity(v)
            DeleteObject(v)
            SetObjectAsNoLongerNeeded(v)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HEADING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("h",function(source,args)
	if not exports["chat"]:statusChat() then return end
    --TriggerEvent('chatMessage',"HEADING",{255,70,50},GetEntityHeading(PlayerPedId()))
    vRP.prompt("Heading:",GetEntityHeading(PlayerPedId()))
	--print(GetEntityHeading(PlayerPedId()))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vehash")
AddEventHandler("vehash",function()
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		-- TriggerEvent('chatMessage',"ALERTA",{255,70,50},GetEntityModel(vehicle))
		vRP.prompt("Hash Vehicle:",GetEntityModel(vehicle))
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNAR VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('spawnarveiculo')
AddEventHandler('spawnarveiculo',function(name)
	local mhash = GetHashKey(name)
	while not HasModelLoaded(mhash) do
		RequestModel(mhash)
		Citizen.Wait(10)
	end

	if HasModelLoaded(mhash) then
		local ped = PlayerPedId()
		local nveh = CreateVehicle(mhash,GetEntityCoords(ped),GetEntityHeading(ped),true,false)
		DecorSetInt(nveh,"GamemodeCar",955)
		NetworkRegisterEntityAsNetworked(nveh)
		while not NetworkGetEntityIsNetworked(nveh) do
			NetworkRegisterEntityAsNetworked(nveh)
			Citizen.Wait(1)
		end

		SetVehicleOnGroundProperly(nveh)
		SetVehicleAsNoLongerNeeded(nveh)
		SetVehicleIsStolen(nveh,false)
		SetPedIntoVehicle(ped,nveh,-1)
		SetVehicleNeedsToBeHotwired(nveh,false)
		SetEntityInvincible(nveh,false)
		SetVehicleNumberPlateText(nveh,vRP.getRegistrationNumber())
		Citizen.InvokeNative(0xAD738C3085FE7E11,nveh,true,true)
		SetVehicleHasBeenOwnedByPlayer(nveh,true)
		SetVehRadioStation(nveh,"OFF")
		SetVehicleDirtLevel(nveh,0.0)

		SetModelAsNoLongerNeeded(mhash)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORTAR PARA O LOCAL MARCADO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('tptoway')
AddEventHandler('tptoway',function()
	local ped = PlayerPedId()
	local veh = GetVehiclePedIsUsing(ped)
	if IsPedInAnyVehicle(ped) then
		ped = veh
    end

	local waypointBlip = GetFirstBlipInfoId(8)
	local x,y,z = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09,waypointBlip,Citizen.ResultAsVector()))

	local ground
	local groundFound = false
	local groundCheckHeights = { 0.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0,450.0,500.0,550.0,600.0,650.0,700.0,750.0,800.0,850.0,900.0,950.0,1000.0,1050.0,1100.0 }

	for i,height in ipairs(groundCheckHeights) do
		SetEntityCoordsNoOffset(ped,x,y,height,0,0,1)

		RequestCollisionAtCoord(x,y,z)
		while not HasCollisionLoadedAroundEntity(ped) do
			RequestCollisionAtCoord(x,y,z)
			Citizen.Wait(1)
		end
		Citizen.Wait(20)

		ground,z = GetGroundZFor_3dCoord(x,y,height)
		if ground then
			z = z + 1.0
			groundFound = true
			break;
		end
	end

	if not groundFound then
		z = 1200
		GiveDelayedWeaponToPed(PlayerPedId(),0xFBAB5776,1,0)
	end

	RequestCollisionAtCoord(x,y,z)
	while not HasCollisionLoadedAroundEntity(ped) do
		RequestCollisionAtCoord(x,y,z)
		Citizen.Wait(1)
	end

	SetEntityCoordsNoOffset(ped,x,y,z,0,0,1)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETAR NPCS MORTOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('delnpcs')
AddEventHandler('delnpcs',function()
	local handle,ped = FindFirstPed()
	local finished = false
	repeat
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),GetEntityCoords(ped),true)
		if IsPedDeadOrDying(ped) and not IsPedAPlayer(ped) and distance < 3 then
			Citizen.InvokeNative(0xAD738C3085FE7E11,ped,true,true)
			TriggerServerEvent("trydeleteped",PedToNet(ped))
			finished = true
		end
		finished,ped = FindNextPed(handle)
	until not finished
	EndFindPed(handle)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('admcuff')
AddEventHandler('admcuff',function()
	local ped = PlayerPedId()
	if vRP.isHandcuffed() then
		vRP._setHandcuffed(source,false)
		SetPedComponentVariation(PlayerPedId(),7,0,0,2)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vehtuning")
AddEventHandler("vehtuning",function()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(ped)
	if IsEntityAVehicle(vehicle) then
		SetVehicleModKit(vehicle,0)
		--SetVehicleWheelType(vehicle,7)
		SetVehicleMod(vehicle,0,GetNumVehicleMods(vehicle,0)-1,false)
		SetVehicleMod(vehicle,1,GetNumVehicleMods(vehicle,1)-1,false)
		SetVehicleMod(vehicle,2,GetNumVehicleMods(vehicle,2)-1,false)
		SetVehicleMod(vehicle,3,GetNumVehicleMods(vehicle,3)-1,false)
		SetVehicleMod(vehicle,4,GetNumVehicleMods(vehicle,4)-1,false)
		SetVehicleMod(vehicle,5,GetNumVehicleMods(vehicle,5)-1,false)
		SetVehicleMod(vehicle,6,GetNumVehicleMods(vehicle,6)-1,false)
		SetVehicleMod(vehicle,7,GetNumVehicleMods(vehicle,7)-1,false)
		SetVehicleMod(vehicle,8,GetNumVehicleMods(vehicle,8)-1,false)
		SetVehicleMod(vehicle,9,GetNumVehicleMods(vehicle,9)-1,false)
		SetVehicleMod(vehicle,10,GetNumVehicleMods(vehicle,10)-1,false)
		SetVehicleMod(vehicle,11,GetNumVehicleMods(vehicle,11)-1,false)
		SetVehicleMod(vehicle,12,GetNumVehicleMods(vehicle,12)-1,false)
		SetVehicleMod(vehicle,13,GetNumVehicleMods(vehicle,13)-1,false)
		SetVehicleMod(vehicle,14,16,false)
		SetVehicleMod(vehicle,15,GetNumVehicleMods(vehicle,15)-2,false)
		SetVehicleMod(vehicle,16,GetNumVehicleMods(vehicle,16)-1,false)
		ToggleVehicleMod(vehicle,17,true)
		ToggleVehicleMod(vehicle,18,true)
		ToggleVehicleMod(vehicle,19,true)
		ToggleVehicleMod(vehicle,20,true)
		ToggleVehicleMod(vehicle,21,true)
		ToggleVehicleMod(vehicle,22,true)
		--SetVehicleMod(vehicle,23,1,false)
		SetVehicleMod(vehicle,24,1,false)
		SetVehicleMod(vehicle,25,GetNumVehicleMods(vehicle,25)-1,false)
		SetVehicleMod(vehicle,27,GetNumVehicleMods(vehicle,27)-1,false)
		SetVehicleMod(vehicle,28,GetNumVehicleMods(vehicle,28)-1,false)
		SetVehicleMod(vehicle,30,GetNumVehicleMods(vehicle,30)-1,false)
		--SetVehicleMod(vehicle,33,GetNumVehicleMods(vehicle,33)-1,false)
		SetVehicleMod(vehicle,34,GetNumVehicleMods(vehicle,34)-1,false)
		SetVehicleMod(vehicle,35,GetNumVehicleMods(vehicle,35)-1,false)
		SetVehicleMod(vehicle,38,GetNumVehicleMods(vehicle,38)-1,true)
        SetVehicleWindowTint(vehicle,1)
        --SetVehicleTyresCanBurst(vehicle,false)
        --SetVehicleNumberPlateText(vehicle,"LAST")
        --SetVehicleNumberPlateTextIndex(vehicle,5)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNING2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vehtuning2")
AddEventHandler("vehtuning2",function()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(ped)
	if IsEntityAVehicle(vehicle) then
		SetVehicleModKit(vehicle,0)
		SetVehicleMod(vehicle,11,GetNumVehicleMods(vehicle,11)-1,false)
		SetVehicleMod(vehicle,12,GetNumVehicleMods(vehicle,12)-1,false)
		SetVehicleMod(vehicle,13,GetNumVehicleMods(vehicle,13)-1,false)
		SetVehicleMod(vehicle,15,GetNumVehicleMods(vehicle,15)-1,false)
		ToggleVehicleMod(vehicle,18,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISTANCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("distance")
AddEventHandler("distance",function(args)
    local player = PlayerPedId()
    if args == "a" then
        cds = GetEntityCoords(player)
    end
    if args == "b" then
        cds2 = GetEntityCoords(player)
    end
    if args == nil then
        cds = nil
        cds2 = nil
    end

    while true do
        if cds ~= nil then
            local myCoords = GetEntityCoords(player)
            local distanceb = GetDistanceBetweenCoords(cds,myCoords.x,myCoords.y,myCoords.z,true)
            DrawMarker(21,cds,0,0,0,180.0,0,0,0.75,0.75,0.4,0,255,0,50,1,0,0,1)
            drawTxt("DISTÂNCIA DO PED > ~g~A~w~: "..distanceb,4,0.5,0.96,0.50,255,255,255,180)
            if cds2 ~= nil then
                local distance = GetDistanceBetweenCoords(cds,cds2,true)
                DrawMarker(21,cds2,0,0,0,180.0,0,0,0.75,0.75,0.4,255,0,0,50,1,0,0,1)
                drawTxt("DISTÂNCIA DO ~g~A ~w~> ~r~B~w~: ~w~"..distance,4,0.5,0.93,0.50,255,255,255,180)
            end
        end
        Wait(0)
    end
end)

function drawTxt(text,font,x,y,scale,r,g,b,a)
    SetTextFont(font)
    SetTextScale(scale,scale)
    SetTextColour(r,g,b,a)
    SetTextOutline()
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x,y)
end

function DrawText3Ds(x,y,z, text)
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
    --local factor = (string.len(text)) / 870
    --DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03,0,0,0,68)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFICAÇÃO /ADM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('feijontsUi:MostrarNotAdm')
AddEventHandler('feijontsUi:MostrarNotAdm', function (args)
	local title = args[1]
	local message = args[2]
	local type = args[3]
	SendNUIMessage({ action = 'sendNotification', title = title, message = message, type = type })
end)