--[[
	id: K12VKw9jhzosDfg_9tLnc
	name: zFuel-Client
	description: zFuel Client
	time1: 2021-06-07 16:36:56.430729+00
	time2: 2021-06-07 16:36:56.430729+00
	uploader: ALlAZBQYN2rPz5f3bOiocrTqxNn3y_Pt5SNAC029
	uploadersession: SIrrfIWTpFYZrLwDZ-haTF1KyxW8TD
	flag: f
--]]

local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')

src = {}
Tunnel.bindInterface('zFuel',src)
vSERVER = Tunnel.getInterface('zFuel')

local menuEnabled = false
local fueling = false
local totalpay = 0
local temp = 0
local veh = 0
local value = 0.0
local i = 0
local isNearPump = false
local isFueling = false
local isManFueling = false
local currentFuel = 0.0
local choose = false
local state = 0
local fuelTotal = 0
local fuelPartial = 0
local cans = {}
local bool = false
local jerrycan = false
local lastVeh = 0
local driving = false
local count = 0
local openVeh = {}
local peds = {}
local closeVeh = false
local geverifieer = 0

RegisterNUICallback('ButtonClick',function(data,cb)
	if data == 'exit' then
		ToggleActionMenu()
		state = -1
	end
end)

RegisterNUICallback('buy-jerrycan',function(data) 
	if vSERVER.checkPayment(Config.canPrice) then
		GiveWeaponToPed(PlayerPedId(),883325847,4500,false,true)
		TriggerEvent('Notify','sucesso', 'Comprou um galão por $ '..Config.canPrice..'')
	else
		TriggerEvent('Notify','negado', 'Dinheiro insuficiente.')
	end
end)

RegisterNUICallback('complete',function(data)
	if geverifieer == 1 then
		if fuelTotal < 99.0 then
			if vSERVER.checkPayment(100.0*Config.tax) then
				state = 1
				SendNUIMessage({ action = 'hideMenu' })
				SetNuiFocus(false,false)
				StopScreenEffect('MenuMGSelectionIn')
			end
		else
			TriggerEvent('Notify','negado', 'Seu veículo está completamente abastecido.')
		end
	else
		TriggerEvent('chatMessage','zFuel',{64,64,255},'Uso não autorizado, esse Script não foi autenticado.')
	end	
end)

RegisterNUICallback('partial',function(data)
	if geverifieer == 1 then
		if data.value ~= '.' or data.value ~= '' then
			local valor = parseInt(data.value)
			local maxval = (100.0 - fuelTotal)*Config.tax
			if valor > 0 then
				if valor <= maxval then
					if vSERVER.checkPayment(valor) then
						fuelPartial = valor/Config.tax
						state = 2
						SendNUIMessage({ action = 'hideMenu' })
						SetNuiFocus(false,false)
						StopScreenEffect('MenuMGSelectionIn')
					end
				else
					TriggerEvent('Notify','negado', 'O valor máximo que você pode abastecer é $ '..math.floor(maxval))
				end
			else
				TriggerEvent('Notify','negado', 'Não pode abastecer com esse valor.')
			end
		else
			TriggerEvent('Notify','negado', 'Valor inválido.')
		end
	else
		TriggerEvent('chatMessage','zFuel',{64,64,255},'Uso não autorizado, esse Script não foi autenticado.')
	end
end)

RegisterNUICallback('refuel',function(data) 
	local ped = PlayerPedId()
	if geverifieer == 1 then
		if not fueling then
			veh = GetPlayersLastVehicle()
			if veh ~= 0 then
				local vehicleCoords = GetEntityCoords(veh)
				if GetDistanceBetweenCoords(GetEntityCoords(ped),vehicleCoords, true) < 3.5 then
					local fuel = GetVehicleFuelLevel(veh)
					i = fuel
					local totalfuel = 100.0 - fuel
					if totalfuel > 0 then
						totalpay = (totalfuel*Config.tax)
						temp = totalpay
						local money = vSERVER.returnMoney()
						if money > 0 then
							if money < totalpay then
								totalpay = money
							end
							TaskTurnPedToFaceEntity(ped,veh,5000)
							LoadAnimDict('timetable@gardener@filling_can')
							TaskPlayAnim(ped,'timetable@gardener@filling_can','gar_ig_5_filling_can',2.0,8.0,-1,50,0,0,0,0)
							fueling = true
						else
							TriggerEvent('Notify','negado', 'Dinheiro insuficiente.')
						end
					else
						TriggerEvent('Notify','negado', 'Seu veículo já esta completamente abastecido.')
					end
				else
					TriggerEvent('Notify','negado', 'Você está longe do seu veículo.')
				end
			else
				TriggerEvent('Notify','negado', 'Seu último veículo não foi identificado, tente usar o galão.')
			end
		end
	else
		TriggerEvent('chatMessage','zFuel',{64,64,255},'Uso não autorizado, esse Script não foi autenticado.')
	end
end)

RegisterNUICallback('requestFuel',function(data)
	if geverifieer == 1 then
		fueling = false
		local total = math.floor(value)
		value = 0.0
		if total > 0 then
			vSERVER.checkPayment(total)
			TriggerEvent('Notify','sucesso', 'Pagou $ '..parseInt(total)..' pelo combustivel.')
		end
		ClearPedTasks(PlayerPedId())
		RemoveAnimDict('timetable@gardener@filling_can')
		if DoesEntityExist(veh) then
			vSERVER.syncFuel(VehToNet(veh), GetVehicleFuelLevel(veh))
		end
	else
		TriggerEvent('chatMessage','zFuel',{64,64,255},'Uso não autorizado, esse Script não foi autenticado.')
	end
end)

function src.Auth()
    geverifieer = 1
end

function ToggleActionMenu()
	menuEnabled = not menuEnabled
	if menuEnabled then
		local vehicle = GetPlayersLastVehicle()
		StartScreenEffect('MenuMGSelectionIn', 0, true)
		SetNuiFocus(true,true)
		SendNUIMessage({ action = 'showMenu', fuel = GetVehicleFuelLevel(vehicle), price = Config.canPrice })
	else
		SetNuiFocus(false,false)
		SendNUIMessage({ action = 'hideMenu' })
		StopScreenEffect('MenuMGSelectionIn')
		fueling = false
		local total = math.floor(value)
		value = 0.0
		if  total > 0 then
			vSERVER.checkPayment(total)
			TriggerEvent('Notify','sucesso', 'Pagou $ '..parseInt(total)..' pelo combustivel.')
		end
		ClearPedTasks(PlayerPedId())
		RemoveAnimDict('timetable@gardener@filling_can')
		if DoesEntityExist(veh) then
			vSERVER.syncFuel(VehToNet(veh), GetVehicleFuelLevel(veh))
		end
	end
end

function ManageFuelUsage(vehicle)
	if IsVehicleEngineOn(vehicle) then
		SetVehicleFuelLevel(vehicle,GetVehicleFuelLevel(vehicle) - Config.FuelUsage[Round(GetVehicleCurrentRpm(vehicle),1)] * (Config.Classes[GetVehicleClass(vehicle)] or 1.0) / 10)
		DecorSetFloat(vehicle,Config.FuelDecor,GetVehicleFuelLevel(vehicle))
	end
end

function FindNearestFuelPump()
	local coords = GetEntityCoords(PlayerPedId())
	local fuelPumps = {}
	local handle,object = FindFirstObject()
	local success

	repeat
		if Config.PumpModels[GetEntityModel(object)] then
			table.insert(fuelPumps,object)
		end

		success,object = FindNextObject(handle,object)
	until not success

	EndFindObject(handle)

	local pumpObject = 0
	local pumpDistance = 1000

	for k,v in pairs(fuelPumps) do
		local dstcheck = GetDistanceBetweenCoords(coords,GetEntityCoords(v))

		if dstcheck < pumpDistance then
			pumpDistance = dstcheck
			pumpObject = v
		end
	end
	return pumpObject,pumpDistance
end

function Round(num,numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num*mult+0.5) / mult
end

function frontMenu(v)
	SendNUIMessage({ action = 'frontman', fuel = GetVehicleFuelLevel(v)})
	menuEnabled = true
	StartScreenEffect('MenuMGSelectionIn', 0, true)
	SetNuiFocus(true,true)
	state = 0
end

function callFrontman()
	local nearPed = false
	for k,v in pairs(peds) do
			local d = GetDistanceBetweenCoords(GetEntityCoords(v.ped), GetEntityCoords(PlayerPedId()), true)
			if d < 70.0 and not vSERVER.getService(k) then
				nearPed = true
				break
			end
	end
	if not nearPed then
		TriggerEvent('Notify', 'negado', 'Não há frentistas disponíveis no momento. Saia do veículo e abasteça manualmente.')
	else
		local minor = -1
		local ped = 0
		local syncped = 0
		for k,v in pairs(peds) do
			local d = GetDistanceBetweenCoords(GetEntityCoords(v.ped), GetEntityCoords(PlayerPedId()), true)
			if d < minor or minor == -1 then
				if not vSERVER.getService(k) then 
					minor = d
					ped = v.ped
					syncped = k
				end
			end
		end
		if syncped ~= 0 then
			vSERVER.setService(syncped,true)
		end
		
		local v = GetPlayersLastVehicle()
		fuelTotal = GetVehicleFuelLevel(v)
		local window = GetWorldPositionOfEntityBone(v, GetEntityBoneIndexByName(v, 'window_lf'))
		local wheel = GetWorldPositionOfEntityBone(v, GetEntityBoneIndexByName(v, 'wheel_rr'))
		local wheel2 = GetWorldPositionOfEntityBone(v, GetEntityBoneIndexByName(v, 'wheel_lr'))
		local x,y,z = table.unpack(wheel)
		local x2,y2,z2 = table.unpack(wheel2)
		local x3,y3,z3 = table.unpack(window)
		if GetVehicleClass(v) == 8 then
			x3,y3,z3 = table.unpack(GetEntityCoords(v))
		end
		vSERVER.syncMove(syncped,x3,y3,z3)
		Wait(2000)
		while not IsPedStopped(ped) do 
			Citizen.Wait(0) 
		end
		vSERVER.syncFace(syncped,PedToNet(PlayerPedId()),1000)
		if not DoesEntityExist(v) then vSERVER.setService(syncped,false) return end
		frontMenu(v)
		while state == 0 do Citizen.Wait(200) end

		if state == 1 then
			if not DoesEntityExist(v) then vSERVER.setService(syncped,false) return end
			vSERVER.addList(syncped)
			SetVehicleEngineOn(v,false,false,true)
			if not Config.nearWheel then
				FreezeEntityPosition(v, true)
				vSERVER.syncMove(syncped,x2,y2,z2)
				Wait(2000)
				while not IsPedStopped(ped) do 
					Citizen.Wait(0) 
				end
				TaskTurnPedToFaceCoord(ped,x,y,z,5000)
				vSERVER.syncAnim(syncped, true, 'fuel')
			else
				local d1 = GetDistanceBetweenCoords(GetEntityCoords(isNearPump), wheel, true)
				local d2 = GetDistanceBetweenCoords(GetEntityCoords(isNearPump), wheel2, true)
				if d1 > d2 then
					FreezeEntityPosition(v, true)
					vSERVER.syncMove(syncped,x2,y2,z2)
					Wait(2000)
					while not IsPedStopped(ped) do 
						Citizen.Wait(0) 
					end
					TaskTurnPedToFaceCoord(ped,x,y,z,5000)
					vSERVER.syncAnim(syncped, true, 'fuel')
				else
					FreezeEntityPosition(v, true)
					vSERVER.syncMove(syncped,x,y,z)
					Wait(2000)
					while not IsPedStopped(ped) do 
						Citizen.Wait(0) 
					end
					TaskTurnPedToFaceEntity(ped,v,5000)
					vSERVER.syncAnim(syncped, true, 'fuel')
				end
			end
			if Config.sound then TriggerEvent('vrp_sound:source','fueling2',Config.volume) end
			RequestModel(GetHashKey('prop_oilcan_02a'))
			while not HasModelLoaded(GetHashKey('prop_oilcan_02a')) do
				Citizen.Wait(100)
			end
			vSERVER.syncObject(syncped,x,y,z)
			Wait(2500)
			if Config.sound then TriggerEvent('vrp_sound:source','fueling',Config.volume) end
			i = 0
			if not DoesEntityExist(v) then vSERVER.setService(syncped,false) return end
			while GetVehicleFuelLevel(v) < 100.0 do
				if not DoesEntityExist(v) then vSERVER.setService(syncped,false) return end
				Citizen.Wait(50)
				SetVehicleFuelLevel(v, GetVehicleFuelLevel(v) + Config.velFrontMan)
				i = i+1
				if i == 230 then
					i=0
					if Config.sound then TriggerEvent('vrp_sound:source','fueling',Config.volume) end
				end
			end
			if Config.sound then TriggerEvent('vrp_sound:source','endfueling',Config.volume) end
			Wait(1000)
			if not DoesEntityExist(v) then vSERVER.setService(syncped,false) return end
			FreezeEntityPosition(v, false)
			vSERVER.syncFuel(VehToNet(v), 100.0)
			vSERVER.syncDeleteObject(syncped)
			vSERVER.syncAnim(syncped, false, '')
			vSERVER.syncAnim(syncped, true, 'thumbs')
			SetVehicleEngineOn(v,true,false,true)
			Wait(2000)
			vSERVER.syncAnim(syncped, false, '')
			vSERVER.syncMove(syncped, Config.pedlist[syncped].x,Config.pedlist[syncped].y,Config.pedlist[syncped].z)
			vSERVER.setService(syncped,false)
			vSERVER.removeList()
			Wait(10000)
			if not vSERVER.getService(syncped) then
				vSERVER.syncAnim(syncped, true, 'freeze')
			end
			
		elseif state == 2 then
			if not DoesEntityExist(v) then vSERVER.setService(syncped,false) return end
			vSERVER.addList(syncped)
			SetVehicleEngineOn(v,false,false,true)
			if not Config.nearWheel then
				FreezeEntityPosition(v, true)
				vSERVER.syncMove(syncped,x2,y2,z2)
				Wait(2000)
				while not IsPedStopped(ped) do 
					Citizen.Wait(0) 
				end
				TaskTurnPedToFaceCoord(ped,x,y,z,5000)
				vSERVER.syncAnim(syncped, true, 'fuel')
			else
				local d1 = GetDistanceBetweenCoords(GetEntityCoords(isNearPump), wheel, true)
				local d2 = GetDistanceBetweenCoords(GetEntityCoords(isNearPump), wheel2, true)
				if d1 > d2 then
					FreezeEntityPosition(v, true)
					vSERVER.syncMove(syncped,x2,y2,z2)
					Wait(2000)
					while not IsPedStopped(ped) do 
						Citizen.Wait(0) 
					end
					TaskTurnPedToFaceCoord(ped,x,y,z,5000)
					vSERVER.syncAnim(syncped, true, 'fuel')
				else
					FreezeEntityPosition(v, true)
					vSERVER.syncMove(syncped,x,y,z)
					Wait(2000)
					while not IsPedStopped(ped) do 
						Citizen.Wait(0) 
					end
					TaskTurnPedToFaceEntity(ped,v,5000)
					vSERVER.syncAnim(syncped, true, 'fuel')
				end
			end
			if Config.sound then TriggerEvent('vrp_sound:source','fueling2',Config.volume) end
			RequestModel(GetHashKey('prop_oilcan_02a'))
			while not HasModelLoaded(GetHashKey('prop_oilcan_02a')) do
				Citizen.Wait(100)
			end
			vSERVER.syncObject(syncped,x,y,z)
			Wait(2500)
			if Config.sound then TriggerEvent('vrp_sound:source','fueling',Config.volume) end
			if not DoesEntityExist(v) then vSERVER.setService(syncped,false) return end
			i = 0
			while GetVehicleFuelLevel(v) < fuelTotal + fuelPartial do
				if not DoesEntityExist(v) then vSERVER.setService(syncped,false) return end
				Citizen.Wait(50)
				SetVehicleFuelLevel(v, GetVehicleFuelLevel(v) + Config.velFrontMan)
				i = i+1
				if i == 230 then
					i=0
					if Config.sound then TriggerEvent('vrp_sound:source','fueling',Config.volume) end
				end
			end
			if Config.sound then TriggerEvent('vrp_sound:source','endfueling',Config.volume) end
			if not DoesEntityExist(v) then vSERVER.setService(syncped,false) return end
			FreezeEntityPosition(v, false)
			vSERVER.syncFuel(VehToNet(v), fuelTotal + fuelPartial)
			vSERVER.syncDeleteObject(syncped)
			vSERVER.syncAnim(syncped, false, '')
			vSERVER.syncAnim(syncped, true, 'thumbs')
			SetVehicleEngineOn(v,true,false,true)
			Wait(2000)
			vSERVER.syncAnim(syncped, false, '')
			vSERVER.syncMove(syncped, Config.pedlist[syncped].x,Config.pedlist[syncped].y,Config.pedlist[syncped].z)
			vSERVER.setService(syncped,false)
			vSERVER.removeList()
			Wait(10000)
			if not vSERVER.getService(syncped) then
				vSERVER.syncAnim(syncped, true, 'freeze')
			end
		elseif state == -1 then
			vSERVER.syncMove(syncped, Config.pedlist[syncped].x,Config.pedlist[syncped].y,Config.pedlist[syncped].z)
			vSERVER.setService(syncped,false)
			Wait(10000)
			if not vSERVER.getService(syncped) then
				vSERVER.syncAnim(syncped, true, 'freeze')
			end
		end
	end
end

function DrawText3Ds(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)

	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	SetTextEntry('STRING')
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/370
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,80)
end

function DrawText3Ds2(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)

	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	SetTextEntry('STRING')
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/370
end

function LoadAnimDict(dict)
	if not HasAnimDictLoaded(dict) then
		RequestAnimDict(dict)
		while not HasAnimDictLoaded(dict) do
			Citizen.Wait(10)
		end
	end
end

RegisterNetEvent('syncFuel')
AddEventHandler('syncFuel',function(index, amount)
    if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			SetVehicleFuelLevel(v, amount)
		end
	end
end)

RegisterNetEvent('syncFace')
AddEventHandler('syncFace',function(index, target, time)
	local ped = peds[index].ped
    if NetworkDoesNetworkIdExist(target) then
		local p = NetToPed(target)
		if DoesEntityExist(p) then
			TaskTurnPedToFaceEntity(ped,p,time)
		end
	end
end)

RegisterNetEvent('syncWhistle')
AddEventHandler('syncWhistle',function(index, target, time)
	local ped = peds[index].ped
    if NetworkDoesNetworkIdExist(target) then
		local p = NetToPed(target)
		if DoesEntityExist(p) then
			FreezeEntityPosition(ped,false)
			TaskTurnPedToFaceEntity(ped,p,time)
			Wait(1000)
			LoadAnimDict('rcmnigel1c')
			TaskPlayAnim(ped,'rcmnigel1c','hailing_whistle_waive_a', 1.0, -1.0, 4000, 0, 1, true, true, true)
			Wait(2000)
			if not vSERVER.getService(index) then
				FreezeEntityPosition(ped,true)
			end
		end
	end
end)

RegisterNetEvent('syncObject')
AddEventHandler('syncObject',function(index, x,y,z)
	local ped = peds[index].ped
    local can = CreateObject(GetHashKey('prop_oilcan_02a'), x, y, z+3, 0, 0, 1)
	table.insert(cans,{ped = index, obj = can})
	AttachEntityToEntity(can,ped, GetPedBoneIndex((ped), 36029),0.13,-0.12,0.29,152.0,372.0,224.0, 1, 1, 0, 1, 0, 1)
end)

RegisterNetEvent('syncDeleteObject')
AddEventHandler('syncDeleteObject',function(index)
	for k,v in pairs(cans) do
		if v.ped == index then
			DeleteObject(v.obj)
			table.remove(cans,k)
		end
	end
end)

RegisterNetEvent('syncAnim')
AddEventHandler('syncAnim',function(index,toggle,type)
    local ped = peds[index].ped
	if toggle then
		if type == 'fuel' then
			LoadAnimDict('timetable@gardener@filling_can')
			TaskPlayAnim(ped,'timetable@gardener@filling_can','gar_ig_5_filling_can',2.0,8.0,-1,50,0,0,0,0)
		elseif type == 'thumbs' then
			LoadAnimDict('anim@mp_player_intincarthumbs_upbodhi@ps@')
			TaskPlayAnim(ped, 'anim@mp_player_intincarthumbs_upbodhi@ps@', 'enter', 8.0, 8.0, -1, 50, 0, false, false, false)
		elseif type == 'freeze' then
			FreezeEntityPosition(ped,true)
		end
	else
		ClearPedTasks(ped)
	end
end)

RegisterNetEvent('pedMove')
AddEventHandler('pedMove',function(index,x,y,z)
    local ped = peds[index].ped
	FreezeEntityPosition(ped,false)
	TaskGoToCoordAnyMeans(ped, x, y, z, 1.6, 0, 0, 786603, 1.0)
end)

RegisterNetEvent('pedReturn')
AddEventHandler('pedReturn',function(index,x,y,z)
    local ped = peds[index].ped
	FreezeEntityPosition(ped,false)
	TaskGoToCoordAnyMeans(ped, x, y, z, 1.6, 0, 0, 786603, 1.0)
	SetTimeout(10000,function()
		if not vSERVER.getService(ped) then
			vSERVER.syncAnim(ped, true, 'freeze')
		end
	end)
end)

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		if menuEnabled then
			idle = (Config.vel*100)
			if fueling then
				if parseInt(value) < totalpay then
					value = value + (Config.tax/2)+0.01
					SetVehicleFuelLevel(veh, GetVehicleFuelLevel(veh) + 0.5)
					SendNUIMessage({ action = 'updateVisor', amount = value, fuel = i, tax = Config.tax, done = false })
					i=i+0.5
				else
					SendNUIMessage({ action = 'updateVisor', amount = totalpay, fuel = GetVehicleFuelLevel(veh), tax = Config.tax, done = true})
					if totalpay == temp then
						SetVehicleFuelLevel(veh, 100.0)
						vSERVER.syncFuel(VehToNet(veh), 100.0)
					end
					fueling = false
					value = 0.0
					vSERVER.checkPayment(totalpay)
					TriggerEvent('Notify','sucesso', 'Pagou $ '..parseInt(totalpay)..' pelo combustivel.')
					ClearPedTasks(PlayerPedId())
					RemoveAnimDict('timetable@gardener@filling_can')
				end
			end
		end
		Citizen.Wait(idle)
	end
end)

Citizen.CreateThread(function()
	DecorRegister(Config.FuelDecor,1)
	while true do
		Citizen.Wait(1000)
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsIn(ped)
			if GetPedInVehicleSeat(vehicle,-1) == ped then
				ManageFuelUsage(vehicle)
				if openVeh[vehicle] then
					openVeh[vehicle] = nil
				end
				if not driving then
					driving = true
					count = 0
					if vehicle ~= lastVeh then
						vSERVER.syncFuel(VehToNet(vehicle), GetVehicleFuelLevel(vehicle))
					end
				end
				if count >= 60 then
					vSERVER.syncFuel(VehToNet(vehicle), GetVehicleFuelLevel(vehicle))
					count = 0
				end
				count = count+1
				lastVeh = vehicle
			end
		else
			if driving then
				driving = false
				if DoesEntityExist(lastVeh) then
					vSERVER.syncFuel(VehToNet(lastVeh), GetVehicleFuelLevel(lastVeh))
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(250)
		local pumpObject,pumpDistance = FindNearestFuelPump()
		if pumpDistance < 3.0 then
			isNearPump = pumpObject
		else
			isNearPump = false
			Citizen.Wait(math.ceil(pumpDistance*20))
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()

		if not isFueling and (isNearPump and GetEntityHealth(isNearPump) > 0) then
			idle = 5
			if IsPedInAnyVehicle(ped) and GetPedInVehicleSeat(GetVehiclePedIsIn(ped),-1) == ped then
				local pumpCoords = GetEntityCoords(isNearPump)
				DrawText3Ds(pumpCoords.x,pumpCoords.y,pumpCoords.z + 1.5,'~g~[E]~w~ CHAMAR UM FRENTISTA 🧢')
				if IsControlJustReleased(0,38) then
					if geverifieer == 1 then
						if GetVehicleFuelLevel(GetVehiclePedIsIn(ped)) < 99.0 then
							isManFueling = true
						else
							TriggerEvent('Notify', 'negado', 'Seu veículo está completamente abastecido')
						end
					else
						TriggerEvent('chatMessage','zFuel',{64,64,255},'Uso não autorizado, esse Script não foi autenticado.')
					end
				end
			else
				local pumpCoords = GetEntityCoords(isNearPump)
				if not menuEnabled then
					DrawText3Ds(pumpCoords.x,pumpCoords.y,pumpCoords.z + 1.2,'~g~[E] ~w~ ACESSAR O POSTO ⛽')
				end
				if IsControlJustReleased(0,38) then
					if geverifieer == 1 then
						ToggleActionMenu()
					else
						TriggerEvent('chatMessage','zFuel',{64,64,255},'Uso não autorizado, esse Script não foi autenticado.')
					end
				end
			end
		end

		if GetSelectedPedWeapon(ped) == 883325847 and not isFueling then
			local pos = GetEntityCoords(ped)
    		local entityWorld = GetOffsetFromEntityInWorldCoords(ped, 0.0, 20.0, 0.0)

    		local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, ped, 0)
    		local a, b, c, d, vehicleHandle = GetRaycastResult(rayHandle)
			local vehicle = 0
    		if vehicleHandle ~= nil and IsEntityAVehicle(vehicleHandle) then
				vehicle = vehicleHandle
				closeVeh = true
				idle = 5
			else
				closeVeh = false
			end
			local vehicleCoords = GetEntityCoords(vehicle)
			local x,y,z = 0,0,0
			if GetVehicleClass(vehicle) == 8 then
				x,y,z = vehicleCoords.x,vehicleCoords.y,vehicleCoords.z
			else
				local wheel = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, 'wheel_rr'))
				x,y,z = table.unpack(wheel)
			end
			if DoesEntityExist(vehicle) and GetDistanceBetweenCoords(GetEntityCoords(ped),vehicleCoords) < 2.5 then
				if not DoesEntityExist(GetPedInVehicleSeat(vehicle,-1)) then
					if GetAmmoInPedWeapon(ped,883325847) > 100 then
						if GetVehicleFuelLevel(vehicle) < 99.0 then
							if openVeh[vehicle] then
								DrawText3Ds(vehicleCoords.x,vehicleCoords.y,vehicleCoords.z + 0.5,'🛢️ ~b~'..Round(GetAmmoInPedWeapon(ped,883325847) / 4500 * 100,1)..'%~w~    ⛽ ~p~'..Round(GetVehicleFuelLevel(vehicle),1)..'%')
								if IsControlJustPressed(0,24) then
									local pos = GetEntityCoords(ped)
									entityWorld = GetOffsetFromEntityInWorldCoords(ped, 0.0, 20.0, 0.0)
					
									local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, ped, 0)
									local a, b, c, d, vehicleHandle = GetRaycastResult(rayHandle)
									local vehicle = 0
									if vehicleHandle ~= nil and vehicleHandle ~= 0  and IsEntityAVehicle(vehicleHandle) and openVeh[vehicleHandle] then
										vehicle = vehicleHandle
										local currentFuel = GetVehicleFuelLevel(vehicle)
										jerrycan = true
										local heading = GetEntityHeading(vehicle)-90.0
										if currentFuel < 99.0 then
											while not IsControlJustReleased(0,24) and jerrycan and closeVeh do
												if not bool then
													jerrycan = true
													LoadAnimDict('weapon@w_sp_jerrycan')
													TaskPlayAnim(ped,'weapon@w_sp_jerrycan','fire',3.0,8.0,-1,1,1,0,0,0)
													bool = true
												end
												DrawText3Ds(vehicleCoords.x,vehicleCoords.y,vehicleCoords.z + 0.5,'🛢️ ~b~'..Round(GetAmmoInPedWeapon(ped,883325847) / 4500 * 100,1)..'%~w~    ⛽ ~p~'..Round(GetVehicleFuelLevel(vehicle),1)..'%')
												local oldFuel = currentFuel
												local fuelToAdd = math.random(2,3) / 100.0
					
												if GetAmmoInPedWeapon(ped,883325847) - fuelToAdd * 100 >= 0 then
													currentFuel = oldFuel + fuelToAdd
													SetPedAmmo(ped,883325847,math.floor(GetAmmoInPedWeapon(ped,883325847) - fuelToAdd * 100))
												else
													jerrycan = false
												end
										
												if currentFuel > 100.0 then
													currentFuel = 100.0
													jerrycan = false
												end
										
												SetVehicleFuelLevel(vehicle,currentFuel)
					
												Citizen.Wait(5)
											end
											vSERVER.syncFuel(VehToNet(vehicle), GetVehicleFuelLevel(vehicle))
										end
									end
								end
								if bool then
									LoadAnimDict('move_weapon@jerrycan@generic')
									TaskPlayAnim(ped,'move_weapon@jerrycan@generic','idle',2.0,8.0,0.5,50,0,0,0,0)
									Wait(250)
									ClearPedTasks(ped)
								end
								bool = false
							else
								DrawText3Ds2(x,y,z+0.5,'🔒~g~[G]~w~')
							end
							if IsControlJustReleased(0,Config.openButton) and not openVeh[vehicle] then
								openVeh[vehicle] = true
								SetPedCurrentWeaponVisible(ped,0,0,1,1)
								LoadAnimDict('veh@mower@base')
								TaskPlayAnim(ped,'veh@mower@base','start_engine',2.0,8.0,-1,50,0,0,0,0)
								Wait(2200)
								SetPedCurrentWeaponVisible(ped,1,0,1,1)
								ClearPedTasks(ped)
							end
						else
							DrawText3Ds(vehicleCoords.x,vehicleCoords.y,vehicleCoords.z + 0.5,'~g~TANQUE CHEIO')
						end
					else
						DrawText3Ds(vehicleCoords.x,vehicleCoords.y,vehicleCoords.z + 0.5,'~o~GALÃO VAZIO')
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)

Citizen.CreateThread(function()
	for k,v in pairs(Config.pedlist) do
		RequestModel(GetHashKey(v.hash2))
		while not HasModelLoaded(GetHashKey(v.hash2)) do
			Citizen.Wait(10)
		end
		local ped = CreatePed(4,v.hash,v.x,v.y,v.z-1,v.h,false,true)
		table.insert(peds, {
			ped = ped,
		})
		FreezeEntityPosition(ped,true)
		SetEntityInvincible(ped,true)
		SetPedCanBeTargetted(ped,false)
		SetBlockingOfNonTemporaryEvents(ped,true)
	end
end)

Citizen.CreateThread(function()
	while Config.whistle do
		local idle = 2000
		if IsPedInAnyVehicle(PlayerPedId()) then
			for k,v in pairs(peds) do
				local d = GetDistanceBetweenCoords(GetEntityCoords(v.ped), GetEntityCoords(PlayerPedId()), true)
				if d < 15.0 then
					if not vSERVER.getWhistle(k) and not vSERVER.getService(k) then
						vSERVER.syncWhistle(k, PedToNet(PlayerPedId()), 1000)
						idle = Config.whistleCD*1000
						vSERVER.setWhistle(k, true)
						break
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		if isManFueling then
			callFrontman()
			isManFueling = false
		end
		Citizen.Wait(idle)
	end
end)