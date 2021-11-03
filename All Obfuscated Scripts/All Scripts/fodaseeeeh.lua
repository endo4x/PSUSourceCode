--[[
	id: jhiDLfA_X8BGmMZgmDJtA
	name: fodaseeeeh
	description: 12331312
	time1: 2021-06-08 16:06:21.845219+00
	time2: 2021-06-08 16:06:21.84522+00
	uploader: dCft37atwBcsNndojr1evTDpQhkwJrLsbbRG3b20
	uploadersession: GvMNB1JjhEtGi8EhpIaYJo-vYIf8hV
	flag: f
--]]

local Tunnel                = module("vrp", "lib/Tunnel")
local Proxy                 = module("vrp", "lib/Proxy")
vRP                         = Proxy.getInterface("vRP")
local isFuel                = false
local nuiOpen               = false
local lServer               = Tunnel.getInterface(GetCurrentResourceName(), GetCurrentResourceName())
local ply                   = PlayerPedId()

local cachedPumps           = {time = nil, pump = nil}
local lastPump              = nil
local runningOther          = false 
nearFuel = function(pumpObject)
  runningOther = true 
  CreateThread(function() 
    while true do 
      local msec = 1000
      local cds = GetEntityCoords(pumpObject)
      local pCoords = GetEntityCoords(ply)
      if pumpObject and not IsPedInAnyVehicle(ply, false) and #(cds - pCoords) < 3.0 then 
        local vehicle       = GetPlayersLastVehicle()
        if vehicle and DoesEntityExist(vehicle) then 
          local vCoords = GetEntityCoords(vehicle)
          local fuel = GetVehicleFuelLevel(vehicle)
          if #(vCoords - pCoords) < 4.0 then 
            msec = 4
            Draw3DsText(cds + vec3(0.0,0.0,0.4),cfg.lang["press_to_fuel"])
            Draw3DsText(cds,cfg.lang["press_to_buy"])
            if IsControlJustPressed(0, cfg.keys.startFuel) then 
              if math.ceil(fuel) < 100 then 
                SendNUIMessage({
                  case = "show",
                  valorLitro = cfg.price.fuelLitre,
                  fuel = fuel 
                })
                nuiOpen = true
                SetNuiFocus(nuiOpen, nuiOpen)
              else 
                TriggerEvent("Notify", "negado","Tanque cheio.")
              end
            end
            if IsControlJustPressed(0, cfg.keys.buyGaloon) then 
              if lServer.buyGallon() then 
                cfg.customFunctions.buyPetrolCan({amount = 100})
              end
              Citizen.Wait(1000)
            end
          else 
            msec = 4
            Draw3DsText(cds,cfg.lang["press_to_buy"])
            if IsControlJustPressed(0, cfg.keys.buyGaloon) then 
              if lServer.buyGallon() then 
                cfg.customFunctions.buyPetrolCan({amount = 100})
              end
              Citizen.Wait(1000)
            end
            -- apenas galão
          end
        else 
          msec = 4
          Draw3DsText(cds,cfg.lang["press_to_buy"])
          if IsControlJustPressed(0, cfg.keys.buyGaloon) then 
            if lServer.buyGallon() then 
              cfg.customFunctions.buyPetrolCan({amount = 100})
            end
            Citizen.Wait(1000)
          end
          -- apenas galão 
        end
      else 
        break
      end
      Wait(msec)
    end
    lastPump = nil
    runningOther = false 
  end)
end

CreateThread(function()
    ply   = PlayerPedId()
    while true do
        local msec  = 5000
        ply       = PlayerPedId()
        pCoords   = GetEntityCoords(ply)
        if not IsPedInAnyVehicle(ply, false) and not nuiOpen and not isFuel  then 
          if not runningOther then 
          local pumpObject      = findFuelPump(pCoords)
          if pumpObject ~= lastPump then 
            lastPump = pumpObject
            SetTimeout(0, function() 
              nearFuel(pumpObject)            
            end)
          end
          end
            if GetSelectedPedWeapon(ply) == 883325847 and GetAmmoInPedWeapon(ply,883325847) > 0 then 
              local ui              = GetMinimapAnchor() 
              if GetAmmoInPedWeapon(ply,883325847) > 100 then
                SetPedAmmo(ply, 883325847, 100)
              end
              local vehicle         = GetPlayersLastVehicle()
              if vehicle and DoesEntityExist(vehicle) then 
                local vCoords       = GetEntityCoords(vehicle)
                local fuel          = GetVehicleFuelLevel(vehicle)
                if #(vCoords - pCoords) < 4.0 then 
                  if not isFuel then 
                    msec = 3
                    -- drawTxt(ui.right_x+0.0015,ui.bottom_y-0.040,1.0,1.0,0.45,cfg.lang["press_to_fuel"],255,255,255,255)
                    Draw3DsText(vCoords,cfg.lang["press_to_fuel"])
                    if IsControlJustPressed(0, cfg.keys.startFuel) then                       
                      if fuel < 100 then 
                      TaskTurnPedToFaceEntity(ply,vehicle,5000)
                      vRP._playAnim(true, {{"timetable@gardener@filling_can","gar_ig_5_filling_can"}}, true)
                      isFuel = true
                      fuelWithCan()
                      Wait(10)
                      else
                        TriggerEvent("Notify", "sucesso","O tanque desse carro está cheio.") 
                      end
                    end

                  end
                end
              end
            end
        end
        Wait(msec)
    end
end)
function getClosestVeh()
	local plyPed              = PlayerPedId()
	local plyPos              = GetEntityCoords(plyPed, false)
	local plyOffset           = GetOffsetFromEntityInWorldCoords(plyPed, 0.0, 1.0, 0.0)
	local radius              = 0.3
	local rayHandle           = StartShapeTestCapsule(plyPos.x, plyPos.y, plyPos.z, plyOffset.x, plyOffset.y, plyOffset.z, radius, 10, plyPed, 7)
	local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)
	return vehicle
end
function fuelWithCan()
    local vehicle = getClosestVeh()
    if not vehicle or vehicle <= 0 then 
      vehicle = GetPlayersLastVehicle()
    end
    if not DoesEntityExist(vehicle) then 
      TriggerEvent("Notify", "negado","Olhe para o veículo que você deseja abastecer.")
      return 
    end
    local fuel    = GetVehicleFuelLevel(vehicle)
    local ammo    = GetAmmoInPedWeapon(ply,883325847)
  
    CreateThread(function() 
      while isFuel do
        Wait(0)
        local coords = GetEntityCoords(vehicle)
        Draw3DsText(coords+vec3(0.0,0.0,-0.9),''..((fuel > 70) and '~g~'..fuel or '~y~'..fuel)..'/100')
        Draw3DsText(coords,'Litros restantes: '..ammo..'L')

        DisableControlAction(0, 0, true)
        DisableControlAction(0, 22, true)
        DisableControlAction(0, 23, true)
        DisableControlAction(0, 24, true)
        DisableControlAction(0, 29, true)
        DisableControlAction(0, 30, true)
        DisableControlAction(0, 31, true)
        DisableControlAction(0, 37, true)
        DisableControlAction(0, 44, true)
        DisableControlAction(0, 56, true)
        DisableControlAction(0, 82, true)
        DisableControlAction(0, 140, true)
        DisableControlAction(0, 166, true)
        DisableControlAction(0, 167, true)
        DisableControlAction(0, 168, true)
        DisableControlAction(0, 170, true)
        DisableControlAction(0, 288, true)
        DisableControlAction(0, 289, true)
        DisableControlAction(1, 323, true)
        BlockWeaponWheelThisFrame()
      end
    end)
    CreateThread(function() 
      while isFuel do
        ply   = PlayerPedId()
        fuel = GetVehicleFuelLevel(vehicle)
        ammo = GetAmmoInPedWeapon(ply,883325847)
        if not IsEntityPlayingAnim(ply, "timetable@gardener@filling_can","gar_ig_5_filling_can",3) then 
          vRP._playAnim(true, {{"timetable@gardener@filling_can","gar_ig_5_filling_can"}}, true)
        end
        if ammo > 0 and fuel < 100 then 
          SetPedAmmo(ply,883325847,ammo - 1)
          SetVehicleFuelLevel(vehicle, fuel + 1)
        else 
          lServer._updateFuel(VehToNet(vehicle),fuel)
          ClearPedTasksImmediately(ply)
          isFuel = false 
        end 
        Wait(500)
      end
    end)
end

RegisterNUICallback("abastecer", function(data)
  local valor, litros   = tonumber(data.valor), tonumber(data.litros)
  if valor > 0 and litros > 0 then
    local vehicle       = GetPlayersLastVehicle()
    if lServer.tryFullPayment(valor) then 
        nuiOpen = false 
        SetNuiFocus(nuiOpen, nuiOpen)
        SendNUIMessage({
          case = "hide"
        })
        abastecer(vehicle,litros)
    end
  end
end)

RegisterNUICallback("close", function(data)
  nuiOpen = false 
  SetNuiFocus(nuiOpen, nuiOpen)
  SendNUIMessage({
    case = "hide"
  })
end)

RegisterNUICallback("cancel", function(data)
  isFuel = false 
end)


abastecer  = function(vehicle,litros )
  isFuel      = true
  local final = GetVehicleFuelLevel(vehicle) + litros 
  SetNuiFocus(true,false)
	SetCurrentPedWeapon(ply, -1569615261, true)
  TaskTurnPedToFaceEntity(ply,vehicle,5000)
  vRP.playAnim(true, {{"timetable@gardener@filling_can","gar_ig_5_filling_can"}}, true)
  CreateThread(function() 
    while isFuel do 
      local ui = GetMinimapAnchor() 
      drawTxt(ui.right_x+0.0015,ui.bottom_y-0.040,1.0,1.0,0.45,"~r~"..string.format("%.2f",GetVehicleFuelLevel(vehicle)).."%~w~/~g~100%",255,255,255,255)
      drawTxt(ui.right_x+0.0015,ui.bottom_y-0.020,1.0,1.0,0.45,cfg.lang["press_to_cancel"],255,255,255,255)
      if IsControlJustPressed(0, cfg.keys.cancelAction) or IsDisabledControlJustPressed(0, cfg.keys.startFuel) then 
        isFuel = false 
        break
      end
      Wait(3)
    end
  end) 

  CreateThread(function()
    while isFuel do
      local fuel = GetVehicleFuelLevel(vehicle)
      if ( fuel >= final) or (fuel >= 100) then 
        isFuel = false
      else 
        if not IsEntityPlayingAnim(ply, "timetable@gardener@filling_can","gar_ig_5_filling_can", 3) then 
          vRP.playAnim(true, {{"timetable@gardener@filling_can","gar_ig_5_filling_can"}}, true)
        end
        SetVehicleFuelLevel(vehicle,GetVehicleFuelLevel(vehicle)  + 1)
      end
      Wait(1000)
    end
    lServer._updateFuel(VehToNet(vehicle),GetVehicleFuelLevel(vehicle))
    ClearPedTasks(ply)
    SetNuiFocus(false,false)  
  end)

end



local runningThread = false 
local lastUpdated
AddEventHandler("gameEventTriggered", function(evName, evArgs)
	if evName == "CEventNetworkPlayerEnteredVehicle" then
		if evArgs[1] == PlayerId() then
        local entState = Entity(evArgs[2]).state.fuelLevel
        if entState then 
          SetVehicleFuelLevel(evArgs[2], entState+0.0)
        end
        if not runningThread then 
		local isDriver = GetPedInVehicleSeat(evArgs[2], -1) == PlayerPedId()
          runningThread = true 
          Citizen.CreateThread(function()
            local lastSave = GetGameTimer()
              while (IsPedInAnyVehicle(ply, false) and GetVehiclePedIsIn(ply, false) == evArgs[2]) do 
                    local fuel = GetVehicleFuelLevel(evArgs[2])
                    if isDriver then 
                      SetVehicleFuelLevel(evArgs[2],(fuel - cfg.usage.rpmModifier[math.ceil(GetVehicleCurrentRpm(evArgs[2]))] * cfg.usage.classModifier[GetVehicleClass(evArgs[2])] / 4))
                      Entity(evArgs[2]).state.fuelLevel = GetVehicleFuelLevel(evArgs[2])
                    else 
                      SetVehicleFuelLevel(evArgs[2],Entity(evArgs[2]).state.fuelLevel)
                    end
                    Wait(1000)
              end
            local _vehicle = GetPlayersLastVehicle()
            if _vehicle and DoesEntityExist(_vehicle) then 
              lServer._updateFuel(VehToNet(_vehicle),GetVehicleFuelLevel(_vehicle))
            end
            runningThread = false 
          end)
      end
    end
  end
end)









function findFuelPump(plyCds)
  if not cachedPumps.time or GetGameTimer() - cachedPumps.time > 5000 then 
    cachedPumps.time = GetGameTimer()
    for _, v in ipairs(cfg.pumpModels) do
      local prop = GetClosestObjectOfType(plyCds.x, plyCds.y, plyCds.z, 2.5, v, false, false, false)
      if prop > 0 then
        cachedPumps.pump = prop
        return prop
      end
    end
  else 
    return ((cachedPumps.pump and #(GetEntityCoords(cachedPumps.pump) - plyCds) < 3.0) and cachedPumps.pump or nil)
  end
end

function drawTxt(x,y,width,height,scale,text,r,g,b,a)
	SetTextFont(4)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextDropShadow(0, 0, 0, 0, 200)
	SetTextDropShadow()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end
  
  
function GetMinimapAnchor()
	local safezone = GetSafeZoneSize()
	local safezone_x = 1.0 / 20.0
	local safezone_y = 1.0 / 20.0
	local aspect_ratio = GetAspectRatio(0)
	local res_x, res_y = GetActiveScreenResolution()
	local xscale = 1.0 / res_x
	local yscale = 1.0 / res_y
	local Minimap = {}
	Minimap.width = xscale * (res_x / (4 * aspect_ratio))
	Minimap.height = yscale * (res_y / 5.674)
	Minimap.left_x = xscale * (res_x * (safezone_x * ((math.abs(safezone - 1.0)) * 10)))
	Minimap.bottom_y = 1.0 - yscale * (res_y * (safezone_y * ((math.abs(safezone - 1.0)) * 10)))
	Minimap.right_x = Minimap.left_x + Minimap.width
	Minimap.top_y = Minimap.bottom_y - Minimap.height
	Minimap.x = Minimap.left_x
	Minimap.y = Minimap.top_y
	Minimap.xunit = xscale
	Minimap.yunit = yscale
	return Minimap
end

function Draw3DText(pos, text)
	local onScreen, _x, _y = World3dToScreen2d(pos.x, pos.y, pos.z)
	local px, py, pz       = table.unpack(GetGameplayCamCoords())
	local dist             = #(pos - GetGameplayCamCoords())
	
	local scale            = (1 / dist) * 0.85
	local fov              = (1 / GetGameplayCamFov()) * 100
	local scale            = scale * fov
	
	if onScreen then
		SetTextScale(0.0 * scale, 0.55 * scale)
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

function Draw3DsText(pos, text)
	local _, _x, _y = World3dToScreen2d(pos.x, pos.y, pos.z+1.3)
	SetTextFont(4)
	SetTextScale(0.40, 0.40)
	SetTextColour(255, 255, 255, 170)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x, _y)
	local factor = (string.len(text)) / 450
	DrawRect(_x, _y + 0.0125, 0.01 + factor, 0.03, 0, 0, 0, 50)
end