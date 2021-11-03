--[[
	id: 93YKbC8yOESLKGNsW9f4b
	name: kkkpt2
	description: kkk
	time1: 2021-07-18 00:10:53.611242+00
	time2: 2021-07-18 00:10:53.611243+00
	uploader: fNFlwvflivk-D54KDyZoNSZDKhkd10_e9Z8RvIjN
	uploadersession: Imm8VphatoYqMtzoW5e0slIsq-4ivU
	flag: f
--]]

function Getmunch()
    local players = {}

    for i = 0, 128 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    table.sort(players, function(a,b)
        return GetPlayerServerId(a) < GetPlayerServerId(b)
    end)

    return players
end

local entityEnumerator = {
    __gc = function(enum)
      if enum.destructor and enum.handle then
        enum.destructor(enum.handle)
      end
       enum.destructor = nil
       enum.handle     = nil
    end
}

  local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
	  local iter, id = initFunc()
	  if not id or id == 0 then
		disposeFunc(iter)
		return
	  end
	  
	  local enum = {handle = iter, destructor = disposeFunc}
	  setmetatable(enum, entityEnumerator)
	  
	  local next = true
	  repeat
		coroutine.yield(id)
		next, id = moveFunc(iter)
	  until not next
	  
	  enum.destructor, enum.handle = nil, nil
	  disposeFunc(iter)
	end)
  end
  
  function EnumerateObjects()
	return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
  end
  
  function EnumeratePeds()
	return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
  end
  
  function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
  end
  
  function EnumeratePickups()
	return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
  end

RegisterNetEvent("munchadminv2:utilshit")
AddEventHandler("munchadminv2:utilshit", function()
    for vehicle in EnumerateVehicles() do
        if (not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1))) then 
            SetVehicleHasBeenOwnedByPlayer(vehicle, false) 
            SetEntityAsMissionEntity(vehicle, false, false) 
            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle)) 
            if (DoesEntityExist(vehicle)) then
                Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle)) 
            end
        end
    end
end)

RegisterNetEvent('munchadminv2:utilfuck')
AddEventHandler('munchadminv2:utilfuck', function()
	for ped in EnumeratePeds() do
		if not IsPedAPlayer(ped) then
			Citizen.InvokeNative(0x9614299DCB53E54B, Citizen.PointerValueIntInitialized(ped)) 
			if DoesEntityExist(ped) then
                Citizen.InvokeNative(0x9614299DCB53E54B, Citizen.PointerValueIntInitialized(ped)) 
            end
		end
	end
end)

RegisterNetEvent('munchadminv2:utilbitch')
AddEventHandler('munchadminv2:utilbitch', function()
	for object in EnumerateObjects() do
        if DoesEntityExist(object) then
			Citizen.InvokeNative(0x539E0AE3E6634B9F, Citizen.PointerValueIntInitialized(object)) 
        end
    end
end)