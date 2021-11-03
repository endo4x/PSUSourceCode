--[[
	id: UZtIwJZvkZzKAvMSpP3pX
	name: daily_CarTestDrive
	description: catalogo concessionario
	time1: 2021-04-24 18:11:19.066466+00
	time2: 2021-04-24 18:11:19.066466+00
	uploader: FJIC7pcrNJaVRLxDGePzVkqOPXWh0QE9QApmYc4O
	uploadersession: _XxKdolx_RpReM5YGAWabY2RP6i8xC
	flag: f
--]]

local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

ESX                           = nil

local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil

local IsInShopMenu            = false
local Categories              = {}
local Vehicles                = {}
local LastVehicles            = {}
local CurrentVehicleData      = nil

local Licenses                = {}
local PlayerData              = {}
local GUI                     = {}

local start                   = false
local testTime                = 0

GUI.Time                      = 0

--== ESX ESSENTIALS ==--

Citizen.CreateThread(function ()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end

  ESX.TriggerServerCallback('sp_vehicleshop:getCategories', function (categories)
    Categories = categories
  end)

  ESX.TriggerServerCallback('sp_vehicleshop:getVehicles', function (vehicles)
    Vehicles = vehicles
  end)
end)

--== LICENSE LOADER ==--

RegisterNetEvent('daily_cartestdrive:loadLicenses')
AddEventHandler('daily_cartestdrive:loadLicenses', function (licenses)
    for i = 1, #licenses, 1 do
      Licenses[licenses[i].type] = true
    end
end)

--== SHOWROOM MENU ==--

function OpenShopMenu ()
  IsInShopMenu = true

  ESX.UI.Menu.CloseAll()

  local playerPed = GetPlayerPed(-1)

  FreezeEntityPosition(playerPed, true)
  SetEntityVisible(playerPed, false)
  SetEntityCoords(playerPed, Config.Zones.ShopInside.Pos.x, Config.Zones.ShopInside.Pos.y, Config.Zones.ShopInside.Pos.z)

  local vehiclesByCategory = {}
  local elements           = {}
  local firstVehicleData   = nil

  for i=1, #Categories, 1 do
    vehiclesByCategory[Categories[i].name] = {}
  end

  for i=1, #Vehicles, 1 do
    table.insert(vehiclesByCategory[Vehicles[i].category], Vehicles[i])
  end

  for i=1, #Categories, 1 do
    local category         = Categories[i]
    local categoryVehicles = vehiclesByCategory[category.name]
    local options          = {}

    for j=1, #categoryVehicles, 1 do
      local vehicle = categoryVehicles[j]

      if i == 1 and j == 1 then
        firstVehicleData = vehicle
      end

      table.insert(options, vehicle.name .. ' ')
    end

    table.insert(elements, {
      name    = category.name,
      label   = category.label,
      value   = 0,
      type    = 'slider',
      max     = #Categories[i],
      options = options
    })
  end

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'vehicle_shop',
    {
      title    = 'Show Room',
      align    = 'top-left',
      elements = elements,
    },
    function (data, menu)
      local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]

      ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'shop_confirm',
        {
          title = vehicleData.name,
          align = 'top-left',
          elements = {
            {label = vehicleData.name .. _U('costs') .. vehicleData.price * Config.DisplayPrice .. _U('currency'), value = 'yes'},
            --{label = vehicleData.name .. _U('stats'), value = 'stats'},
            --{label = _U('test_drive') .. vehicleData.name, value = 'test'},
            {label = _U('back'), value = 'no'},
          },
        },
        function (data2, menu2)
          if data2.current.value == 'yes' then
            exports['mythic_notify']:DoLongHudText('inform', _U('contact_dealer') .. vehicleData.price * Config.DisplayPrice .. _U('currency'), { ['background-color'] = '#ffffff', ['color'] = '#000000' })
          end

          if data2.current.value == 'no' then
             menu2.close()
          end

          if data2.current.value == 'stats' then
            local ped = PlayerPedId()
            local veh = GetVehiclePedIsIn(ped, false)
            local model = GetEntityModel(veh, false)

            ESX.UI.Menu.Open(
              'default', GetCurrentResourceName(), 'statistics',
              {
                title = 'Statistics',
                align = 'top-left',
                elements = {
                  {label = _U('max_speed') .. round(GetVehicleEstimatedMaxSpeed(veh) * 2.23693629,1)},
                  {label = _U('acceleration') .. round(GetVehicleModelAcceleration(model),1)},
                  {label = _U('gears') .. GetVehicleHighGear(veh)},
                  {label = _U('capacity') .. GetVehicleMaxNumberOfPassengers(veh) + 1},
                  {label = _U('back'), value = 'back'},
                },
              },

              function (data3, menu3)
                if data3.current.value == 'back' then
                  menu3.close()
                end
              end,

              function (data3, menu3)
                menu3.close()
              end)
          end

          if data2.current.value == 'test' then
            ESX.UI.Menu.Open(
              'default', GetCurrentResourceName(), 'test_drive',
              {
                title = 'Test Drive',
                align = 'top-left',
                elements = {
                  { label = _U('test_price') .. Config.TestPrice .. _U('currency'), value = "test_yes"},
                  { label = _U('back'), value = "test_no"},
                },
              },

              function (data3, menu3)
                if data3.current.value == "test_yes" then
                  canPlayerTest(vehicleData.model)
                end

                if data3.current.value == "test_no" then
                  menu3.close()
                end
              end,

              function (data3, menu3)
                  menu3.close()
              end)
          end

        end,
        function (data2, menu2)
          menu2.close()
        end)

    end,
    function (data, menu)

      menu.close()

      DoScreenFadeOut(1000)
      Citizen.Wait(1000)
      DoScreenFadeIn(1000)

      DeleteCatalogVehicles()

      local playerPed = GetPlayerPed(-1)

      CurrentAction     = 'shop_menu'
      CurrentActionMsg  = 'shop menu'
      CurrentActionData = {}

      FreezeEntityPosition(playerPed, false)

      SetEntityCoords(playerPed, Config.Zones.Catalog.Pos.x, Config.Zones.Catalog.Pos.y, Config.Zones.Catalog.Pos.z)
      SetEntityVisible(playerPed, true)

      IsInShopMenu = false

    end,

    function (data, menu)
      local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]
      local playerPed   = GetPlayerPed(-1)

      DeleteCatalogVehicles()

      ESX.Game.SpawnLocalVehicle(vehicleData.model, {
        x = Config.Zones.ShopInside.Pos.x,
        y = Config.Zones.ShopInside.Pos.y,
        z = Config.Zones.ShopInside.Pos.z
      }, Config.Zones.ShopInside.Heading, function(vehicle)
        table.insert(LastVehicles, vehicle)
        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
        FreezeEntityPosition(vehicle, true)
      end)
    end
  )

  DeleteCatalogVehicles()

  ESX.Game.SpawnLocalVehicle(firstVehicleData.model, {
    x = Config.Zones.ShopInside.Pos.x,
    y = Config.Zones.ShopInside.Pos.y,
    z = Config.Zones.ShopInside.Pos.z
  }, Config.Zones.ShopInside.Heading, function (vehicle)
    table.insert(LastVehicles, vehicle)
    TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
    FreezeEntityPosition(vehicle, true)
  end)
end

--== TEST DRIVE CHECKS==--

function canPlayerTest(car)

  if Config.UseLicense then

    TriggerEvent('esx_license:getLicenses', source, function (licenses)
      TriggerEvent('daily_cartestdrive:loadLicenses', source, licenses)
    end)

    if Licenses['dmv'] or Licenses['drive'] then

      ESX.TriggerServerCallback('daily_cartestdrive:checkMoney', function(cb)
        if cb then
          startTestDrive(car)
        end
      end)

    else
      exports['mythic_notify']:DoLongHudText('error', _U('no_license'), { ['background-color'] = '#ffffff', ['color'] = '#000000' })
    end

  else
    ESX.TriggerServerCallback('daily_cartestdrive:checkMoney', function(cb)
      if cb then
        startTestDrive(car)
      end
    end)
  end
end

--== TEST DRIVE LOGIC ==--

function startTestDrive(car)
  local playerPed = GetPlayerPed(-1)

  testTime = Config.RentTime

  PlaySoundFrontend(-1, "Player_Enter_Line", "GTAO_FM_Cross_The_Line_Soundset", 0)

  ESX.UI.Menu.CloseAll()

  DoScreenFadeOut(300)

  Citizen.Wait(500)

  RequestModel(GetHashKey(car))

  while not HasModelLoaded(GetHashKey(car)) do
    Citizen.Wait(0)
  end

  exports['mythic_notify']:DoLongHudText('inform', _U('test_start'), { ['background-color'] = '#ffffff', ['color'] = '#000000' })

  local testVeh = CreateVehicle(GetHashKey(car), Config.SpawnPoint.x, Config.SpawnPoint.y, Config.SpawnPoint.z, Config.SpawnPoint.heading,  996.786, 25.1887, false, false)

  SetEntityAsMissionEntity(testVeh)
  SetVehicleLivery(testVeh, 0)
  TaskWarpPedIntoVehicle(GetPlayerPed(-1), testVeh, - 1)
  SetVehicleNumberPlateText(testVeh, "TEST")
  SetVehicleColours(testVeh, 111,111)
  SetPedCanBeKnockedOffVehicle(GetPlayerPed(-1),1)
  SetPedCanRagdoll(GetPlayerPed(-1),false)
  SetEntityVisible(playerPed, true)

  Citizen.Wait(500)

  DoScreenFadeIn(300)

  exports['mythic_notify']:PersistentHudText('start', 'veh_test', 'inform', _U('test_info'), { ['background-color'] = '#ffffff', ['color'] = '#000000' })

  DeleteCatalogVehicles()

  start = true

  while start do

    Citizen.Wait(0)
    DisableControlAction(0, 75, true)
    DisableControlAction(27, 75, true)
    DisableControlAction(0, 70, true)
    DisableControlAction(0, 69, true)

    local pedCoords = GetEntityCoords(GetPlayerPed(-1))

    testTime = testTime - 0.015
    DrawText3D(pedCoords.x, pedCoords.y, pedCoords.z+1.3, _U('time_left')..math.floor(testTime).. _U('seconds'))

    if testTime <= 0 then
      start = false
    end
  end
  exports['mythic_notify']:PersistentHudText('end', 'veh_test')

  SetPedCanRagdoll(GetPlayerPed(-1),true)
  SetPedCanBeKnockedOffVehicle(GetPlayerPed(-1),0)
  PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 1)

  exports['mythic_notify']:DoLongHudText('inform', _U('test_end'), { ['background-color'] = '#ffffff', ['color'] = '#000000' })
  DoScreenFadeOut(300)

  Citizen.Wait(500)

  DeleteEntity(testVeh)
  FreezeEntityPosition(GetPlayerPed(-1), true)

  Citizen.Wait(500)

  FreezeEntityPosition(GetPlayerPed(-1), false)
  DoScreenFadeIn(300)

  CurrentAction     = 'shop_menu'
  CurrentActionMsg  = 'shop menu'
  CurrentActionData = {}

  FreezeEntityPosition(playerPed, false)

  SetEntityCoords(playerPed, Config.Zones.Catalog.Pos.x, Config.Zones.Catalog.Pos.y, Config.Zones.Catalog.Pos.z)

  IsInShopMenu = false
end

--== MANUAL TEST DRIVE STOP ==--

RegisterCommand("done", function()
	if start then
		testTime = 0
	else
		exports['mythic_notify']:DoLongHudText('inform', _U('not_testing'), { ['background-color'] = '#ffffff', ['color'] = '#000000' })
	end
end)

--== CONTROLS ==--

Citizen.CreateThread(function ()
  while true do
    Citizen.Wait(0)

    if CurrentAction ~= nil then
      SetTextComponentFormat('STRING')
      AddTextComponentString(CurrentActionMsg)
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)

      if IsControlPressed(0, Keys['E']) and (GetGameTimer() - GUI.Time) > 300 then
        if CurrentAction == 'cars_menu' then
          OpenShopMenu()
        end

        if CurrentAction == 'go_down_from' then
            local playerPed = GetPlayerPed(-1)
            DoScreenFadeOut(3000)
            Wait(3000)
            DoScreenFadeIn(3000)
            SetEntityCoords(playerPed, Config.Zones.GoUpFrom.Pos.x, Config.Zones.GoUpFrom.Pos.y, Config.Zones.GoUpFrom.Pos.z)
        end

        if CurrentAction == 'go_up_from' then
            local playerPed = GetPlayerPed(-1)
            DoScreenFadeOut(3000)
            Wait(3000)
            DoScreenFadeIn(3000)
            SetEntityCoords(playerPed, Config.Zones.GoDownFrom.Pos.x, Config.Zones.GoDownFrom.Pos.y, Config.Zones.GoDownFrom.Pos.z)
        end

        CurrentAction = nil
        GUI.Time      = GetGameTimer()
      end
    end
  end
end)

--== MARKERS ==--

AddEventHandler('daily_cartestdrive:hasEnteredMarker', function (zone)
  if zone == 'Catalog' then
    CurrentAction     = 'cars_menu'
    CurrentActionMsg  = _U('press_e')
    CurrentActionData = {}
  end

  if zone == 'GoDownFrom' then
    CurrentAction     = 'go_down_from'
    CurrentActionMsg  = _U('press_e_to_enter')
    CurrentActionData = {}
  end

  if zone == 'GoUpFrom' then
    CurrentAction     = 'go_up_from'
    CurrentActionMsg  = _U('press_e_to_exit')
    CurrentActionData = {}
  end

end)

AddEventHandler('daily_cartestdrive:hasExitedMarker', function (zone)
  if not IsInShopMenu then
    ESX.UI.Menu.CloseAll()
  end

  CurrentAction = nil
end)

Citizen.CreateThread(function ()
  while true do
    Wait(0)

    local coords = GetEntityCoords(GetPlayerPed(-1))

    for k,v in pairs(Config.Zones) do
      if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
        DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
      end
    end
  end
end)

Citizen.CreateThread(function ()
  while true do
    Wait(0)

    local coords      = GetEntityCoords(GetPlayerPed(-1))
    local isInMarker  = false
    local currentZone = nil

    for k,v in pairs(Config.Zones) do
      if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
        isInMarker  = true
        currentZone = k
      end
    end

    if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
      HasAlreadyEnteredMarker = true
      LastZone                = currentZone
      TriggerEvent('daily_cartestdrive:hasEnteredMarker', currentZone)
    end

    if not isInMarker and HasAlreadyEnteredMarker then
      HasAlreadyEnteredMarker = false
      TriggerEvent('daily_cartestdrive:hasExitedMarker', LastZone)
    end
  end
end)

--== FUNCTIONS ==--

function DeleteCatalogVehicles ()
  while #LastVehicles > 0 do
    local vehicle = LastVehicles[1]
    ESX.Game.DeleteVehicle(vehicle)
    table.remove(LastVehicles, 1)
  end
end

function round(num, numDecimalPlaces)
  local mult = 100^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function Notify(text)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function DrawText3D(x, y, z, text)
  local onScreen,_x,_y=World3dToScreen2d(x, y, z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  local factor = (string.len(text)) / 370

  SetTextScale(0.45, 0.45)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 140, 60, 215)
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(text)
  DrawText(_x,_y)
  DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 90)
end