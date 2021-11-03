--[[
	id: 58QorzcECpd48ktI4p3Dv
	name: sellcar next
	description: next sell car lua client
	time1: 2021-07-14 02:40:55.529437+00
	time2: 2021-07-14 02:40:55.529438+00
	uploader: dCft37atwBcsNndojr1evTDpQhkwJrLsbbRG3b20
	uploadersession: GvMNB1JjhEtGi8EhpIaYJo-vYIf8hV
	flag: f
--]]

local Tunnel      = module("vrp","lib/Tunnel")
local Proxy       = module("vrp","lib/Proxy")
local vRP         = Proxy.getInterface("vRP")
local lServer     = Tunnel.getInterface(GetCurrentResourceName())
local lClient     = {}
local cars        = {}
local ply         = PlayerPedId()
local plyCoords   = vec3(0.0,0.0,0.0)
local mappedCars  = {}
Tunnel.bindInterface(GetCurrentResourceName(),lClient)

CreateThread(function() 
  while not GlobalState["sellcars"] do 
    Wait(1000)
  end
  lClient.updateMap()
  SetNuiFocus()
  while true do 
    local msec  = 1000
    ply         = PlayerPedId()
    plyCoords   = GetEntityCoords(ply)
    for i = 1,#cfg.locations do 
      for k,v in pairs(cfg.locations[i]) do 
          local distance = #(plyCoords - v.coord) 
          if distance < 40 then 
            if mappedCars and mappedCars[i] and mappedCars[i][k] then 
              setVehicleMods(mappedCars[i][k].data.netid,mappedCars[i][k].data.custom or nil)
            end
          end
          if distance < 6.0 then 
            msec = 3
            if not mappedCars or (not mappedCars[i]) or (not mappedCars[i][k]) then 
              
              
              
              
              Draw3DText(v.coord.x,v.coord.y,v.coord.z+1.0,((IsPedInAnyVehicle(ply, false)) and "~g~VAGA LIVRE<br>~w~Aperte ~r~[E]~w~ para vender seu carro 💰" or "~g~VENDA DE VEÍCULOS<br><br>~r~ Você precisa estar em um veículo"))

              if IsControlJustPressed(0, 38) then 
                local vehicle   = GetVehiclePedIsIn(ply, false)
                if (IsPedInAnyVehicle(ply, false) and GetPedInVehicleSeat(vehicle, -1) == ply) then 
                  
                  local callback = lServer.sellVehicle({
                    location    = k, 
                    park        = i, 
                    kilometers  = Entity(vehicle).state.kilometers,
                    fuel        = GetVehicleFuelLevel(vehicle),
                    body        = GetVehicleBodyHealth(vehicle),
                    engineTemp  = GetVehicleEngineTemperature(vehicle),
                    engine      = GetVehicleEngineHealth(vehicle)
                  })
                  if callback.error then 
                    notify.negado(callback.error)
                    Wait(1000)
                  else 
                    notify.sucesso('Veículo colocado a venda!')
                  end
                else 
                  notify.negado('Você precisa estar dentro de um veículo e ser o motorista.')
                end
              end
            else 
              if mappedCars[i][k] and mappedCars[i][k].data.netid and NetworkDoesNetworkIdExist(mappedCars[i][k].data.netid) then 
                local vehicle = NetworkGetEntityFromNetworkId(mappedCars[i][k].data.netid)
                if vehicle and vehicle > 0 and DoesEntityExist(vehicle) then 
                  local boneCoords = GetWorldPositionOfEntityBone(vehicle,GetEntityBoneIndexByName(vehicle,'bodyshell'))
                  Draw3DText(boneCoords.x,boneCoords.y,boneCoords.z+1.0,"Veículo a venda <br>("..mappedCars[i][k].data.vehicle..")<br> ~g~$"..(mappedCars[i][k].data.price))
                end
              end
              if IsControlJustPressed(0, 38) then 
                SendNUIMessage({
                  action  = 'open',
                  carData =  mappedCars[i][k]
                })
                SetNuiFocus(true,true)
              end
            end 
          end
      end
    end
    Wait(msec)
  end
end)

RegisterNUICallback('close',function(data,cb) 
  SetNuiFocus(false,false)
  cb('ok')
end)


RegisterNUICallback('buy',function(data,cb) 
  local callback = lServer.buyCar(data)
  if callback.error then notify.negado(callback.error) end
  if callback.msg then 
    notify.sucesso(callback.msg) 
    SendNUIMessage({action = 'close'})
    vRP._playAnim(false,{{((GetEntityModel(PlayerPedId()) == 1885233650) and 'ANIM_CASINO_A@AMB@CASINO@GAMES@LUCKY7WHEEL@MALE' or 'ANIM_CASINO_A@AMB@CASINO@GAMES@LUCKY7WHEEL@FEMALE'),"Win_Big"}},false)
  end 
  cb('ok')
end)
local cachedCars = {}

function lClient.updateMap(state)
  cars = state or lServer.getVehState()
  mappedCars = {}
  cachedCars = {}
  for k,v in ipairs(cars) do 
    if not mappedCars[v.park] then 
      mappedCars[v.park] = {}
    end
    v.fuelType = cfg.vehClass[GetVehicleClassFromName(v.vehicle)][2]
    mappedCars[v.park][v.location] = {
      location  = v.location,
      data      = v
    }
  end
end

notify = {
  negado = function(msg) TriggerEvent("Notify", 'negado', msg) end,
  sucesso = function(msg) TriggerEvent("Notify", 'sucesso', msg) end
}

local isRunning = false 
AddEventHandler("gameEventTriggered", function(eventName,args) 
	if eventName == "CEventNetworkPlayerEnteredVehicle" and not isRunning  then 
		if (args[1] == PlayerId() or args[1] == ply) and (GetPedInVehicleSeat(args[2], -1) == ply) then 
      CreateThread(function() 
        isRunning = true
        local kilometers  = Entity(args[2]).state.kilometers or 0
        local oldPos      = GetEntityCoords(ply)
        while true do
          local vehicle =  GetVehiclePedIsIn(ply, false) 
          if vehicle == args[2]  then 
            local curPos = GetEntityCoords(ply)
            if IsVehicleOnAllWheels(vehicle) then 
              kilometers = kilometers + (math.floor((#(curPos - oldPos))*1.33)/1000)
            end
          else break
          end
          Wait(1000)
        end
        local oldEntity = GetVehiclePedIsIn(ply, true) 
        if oldEntity and oldEntity > 0 and oldEntity == args[2] and DoesEntityExist(oldEntity) then 
          Entity(oldEntity).state:set("kilometers",kilometers,true)
          TriggerServerEvent("sellcar:updatekIlometers:", {netid = VehToNet(oldEntity), kilometers = kilometers})
        end
        isRunning = false 
      end)
    end
  end
end)

setVehicleMods  = function(vehid, custom)
  if not  NetworkDoesNetworkIdExist(vehid) then 
    return false 
  end
	local veh = NetworkGetEntityFromNetworkId(vehid)
  if veh then 
    if not DoesEntityExist(veh) then 
      return false 
    end
    if not IsEntityInAir(veh) then 
    FreezeEntityPosition(veh, true)

    end
  end
  if custom and cachedCars[vehid] and cachedCars[vehid] == custom then return false end
  
  if NetworkDoesNetworkIdExist(vehid) then 
    cachedCars[vehid] = custom
  else 
    return false 
  end
  if custom and string.len(custom) > 10 then 
    custom = json.decode(custom)
  else 
    custom = nil return false 
  end
  if custom and veh and custom.colour then
		SetVehicleModKit(veh, 0)
		if custom.colour then
			SetVehicleColours(veh, tonumber(custom.colour.primary), tonumber(custom.colour.secondary))
			SetVehicleExtraColours(veh, tonumber(custom.colour.pearlescent), tonumber(custom.colour.wheel))
			if custom.colour.neon then
				SetVehicleNeonLightsColour(veh, tonumber(custom.colour.neon[1]), tonumber(custom.colour.neon[2]), tonumber(custom.colour.neon[3]))
			end
			if custom.colour.smoke then
				SetVehicleTyreSmokeColor(veh, tonumber(custom.colour.smoke[1]), tonumber(custom.colour.smoke[2]), tonumber(custom.colour.smoke[3]))
			end
			if custom.colour.custom then
				if custom.colour.custom.primary then
					SetVehicleCustomPrimaryColour(veh, tonumber(custom.colour.custom.primary[1]), tonumber(custom.colour.custom.primary[2]), tonumber(custom.colour.custom.primary[3]))
				end
				if custom.colour.custom.secondary then
					SetVehicleCustomSecondaryColour(veh, tonumber(custom.colour.custom.secondary[1]), tonumber(custom.colour.custom.secondary[2]), tonumber(custom.colour.custom.secondary[3]))
				end
			end
		end
		if custom.plate then
			SetVehicleNumberPlateTextIndex(veh, tonumber(custom.plate.index))
		end
		if custom.xenoncolor then
			SetVehicleXenonLightsColour(veh, tonumber(custom.xenoncolor))
		end
		SetVehicleWindowTint(veh, tonumber(custom.janela))
		SetVehicleTyresCanBurst(veh, tonumber(custom.bulletproof))
		SetVehicleWheelType(veh, tonumber(custom.wheel))
		ToggleVehicleMod(veh, 18, tonumber(custom.turbo))
		ToggleVehicleMod(veh, 20, tonumber(custom.fumaca))
		ToggleVehicleMod(veh, 22, tonumber(custom.farol))
		if custom.neon then
			SetVehicleNeonLightEnabled(veh, 0, tonumber(custom.neon.left))
			SetVehicleNeonLightEnabled(veh, 1, tonumber(custom.neon.right))
			SetVehicleNeonLightEnabled(veh, 2, tonumber(custom.neon.front))
			SetVehicleNeonLightEnabled(veh, 3, tonumber(custom.neon.back))
		end
		for i, mod in pairs(custom.mods) do
			if i ~= 18 and i ~= 20 and i ~= 22 and i ~= 46 then
				SetVehicleMod(veh, tonumber(i), tonumber(mod))
			end
		end
		SetVehicleMod(veh, 23, tonumber(custom.tyres), custom.tyresvariation)
		SetVehicleMod(veh, 24, tonumber(custom.tyres), custom.tyresvariation)
	end
end

function Draw3DText(x, y, z, text)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local px, py, pz       = table.unpack(GetGameplayCamCoords())
	local dist             = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)
	
	local scale            = (1 / dist) * 0.85
	local fov              = (1 / GetGameplayCamFov()) * 100
	local scale            = scale * fov
	
	if onScreen then
		SetTextScale(0.0 * scale, 0.75 * scale)
		SetTextFont(0)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x, _y)
	end
end
