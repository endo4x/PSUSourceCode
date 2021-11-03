--[[
	id: e8p-aj9JD1fCoG5geYjGB
	name: wolf_deadbox_client
	description: client/main.lua
	time1: 2021-06-21 00:00:24.078636+00
	time2: 2021-06-21 00:00:24.078638+00
	uploader: GpCCvQyWs-AEuDdLaE60qMW5F7gI-n4KMGxxr4uj
	uploadersession: PRkBs2WQpLAg7aPe8tsB2K8l-nhQ8u
	flag: f
--]]

local Boxes              = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerLoaded = true
  StartWolfDeadBox()
end)

RegisterNetEvent('esx:onPlayerLogout')  -- Trigger this event when a player logs out to character selection
AddEventHandler('esx:onPlayerLogout', function()
  PlayerLoaded = false
end)

RegisterNetEvent('wolf_deadbox:client:CreateDeadBox')
AddEventHandler('wolf_deadbox:client:CreateDeadBox', function(boxId, owner, coords)
  local function setObjectProperties(object)
    SetEntityAsMissionEntity(object, true, false)
    PlaceObjectOnGroundProperly(object)
    FreezeEntityPosition(object, true)
    SetEntityCollision(object, true, true)

    Boxes[boxId] = {
      obj = object,
      owner = owner,
      delete = -1,
      coords = vector3(coords.x, coords.y, coords.z)
    }
  end

  ESX.Game.SpawnLocalObject(Config.ContainerModel, coords, setObjectProperties)
end)

RegisterNetEvent('wolf_deadbox:client:PreDelete')
AddEventHandler('wolf_deadbox:client:PreDelete', function(boxId, time)
  Citizen.CreateThread(function()
    if Boxes[boxId] and Boxes[boxId].obj then
      Boxes[boxId].delete = time
    end
    while Boxes[boxId].delete > 1 do
      Citizen.Wait(1000)
      Boxes[boxId].delete = Boxes[boxId].delete - 1
    end
  end)
end)

RegisterNetEvent('wolf_deadbox:client:DeleteDeadBox')
AddEventHandler('wolf_deadbox:client:DeleteDeadBox', function(boxId)
  if Boxes[boxId] and Boxes[boxId].obj then
    ESX.Game.DeleteObject(Boxes[boxId].obj)
    Boxes[boxId] = nil
  end
end)

RegisterNetEvent('wolf_deadbox:client:openBindMenu')
AddEventHandler('wolf_deadbox:client:openBindMenu', function(item, wait, cb)
  cb(true)
  SetTimeout(wait, function()
  	OpenBindingStoneMenu()
  end)
end)

StartWolfDeadBox = function()
  ESX.TriggerServerCallback('wolf_deadbox:setup', function(missingBoxes)
    for boxId,box in pairs(missingBoxes) do
      TriggerEvent('wolf_deadbox:client:CreateDeadBox', boxId, box.owner, box.coords)
    end
    PlayerLoaded = true
    TriggerLoops()
  end)
end
if ESX.IsPlayerLoaded() then StartWolfDeadBox() end

TriggerLoops = function()
  Citizen.CreateThread(function()
    while PlayerLoaded do
      Citizen.Wait(0)
      local playerCoords, letSleep = GetEntityCoords(ESX.PlayerData.ped), true

      for boxId,box in pairs(Boxes) do
        local distance = #(playerCoords - box.coords)

        if distance < 5 then
          local label = _U('owner', box.owner)
          letSleep = false

          if distance < 2 then
            if IsControlJustReleased(0, 38) then
              if IsPedOnFoot(ESX.PlayerData.ped) then
                exports['wolf_inventory']:OpenStash({id = boxId, slots = 50, label = _U('box_lebel', box.owner)})
                PlaySoundFrontend(-1, 'PICK_UP', 'HUD_FRONTEND_DEFAULT_SOUNDSET', false)
              end
            end

            if box.delete > 0 then
              label = ('%s~n~%s~n~%s'):format(label, _U('open_tip'), _U('delete_countdown', box.delete))
            else
              label = ('%s~n~%s'):format(label, _U('open_tip'))
            end
          end

          ESX.Game.Utils.DrawText3D({
            x = box.coords.x,
            y = box.coords.y,
            z = box.coords.z + 0.25
          }, label, 1.2, 1)
          end
      end

      if letSleep then
        Citizen.Wait(500)
      end
    end
  end)
end

OpenBindingStoneMenu = function()
  local inventory = ESX.GetPlayerData().inventory
  local checkStone = exports['wolf_inventory']:SearchItems('bindstone')
  if checkStone and checkStone.count > 0 then
    local elements = {}
    for i=1, #inventory, 1 do
      local item = inventory[i]
      local bind = item.metadata.bind or false
      if item.count > 0 and (not bind) and not (item.name == 'bindstone') then
        table.insert(elements, {label = ('[%s]%s %s 個'):format(item.slot, item.label, item.count), type = 'item_standard', value = item.slot})
      end
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'BindingMenu',
      {
        title = "保險選單",
        align = 'bottom-right',
        elements = elements
      },
      function(data, menu)
        local itemSlot = data.current.value

        ESX.UI.Menu.Open(          
          'dialog', GetCurrentResourceName(), 'bindingQuantity',
          {
            title = _U('menuTitle', checkStone.count)
          },
          function(data2, menu2)

            local count = tonumber(data2.value)

            if count == nil or count > checkStone.count or count > inventory[itemSlot].count then
              TriggerEvent('mythic_notify:client:SendAlert', {type = 'error', text = _U('validAmount'), length = 2500})
            else
              menu2.close()
              menu.close()
              TriggerServerEvent('wolf_deadbox:server:bindOn', inventory[itemSlot], count)
            end

          end,
          function(data2, menu2)
            menu2.close()
          end
          )
      end,
      function(data, menu)
        menu.close()
      end
      )
  else
    TriggerEvent('mythic_notify:client:SendAlert', {type = 'error', text = _U('error'), length = 2500})
  end
end