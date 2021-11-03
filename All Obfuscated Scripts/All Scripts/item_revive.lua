--[[
	id: rBniQAl88Ok5fguiRJrZt
	name: item_revive
	description: item_revive
	time1: 2021-07-02 06:14:25.307518+00
	time2: 2021-07-02 06:14:25.307518+00
	uploader: fQ6CKou_mkGdyDJR3XWxLXn4zBXIL284gBWUk0La
	uploadersession: i5_w1VPL0EWOBb_Y7Hec6vK9ZxT0Sy
	flag: f
--]]

ESX = nil


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local statusreive = false

RegisterNetEvent('chev_revive:revive')
AddEventHandler('chev_revive:revive', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

    if closestPlayer == -1 or closestDistance > 1.0 then
        TriggerEvent("pNotify:SendNotification", {
            text = '<strong class="red-text">ไม่มีผู้เล่นที่อยู่ใกล้คุณ</strong>',
            type = "error",
            timeout = 3000,
            layout = "bottomCenter",
            queue = "global"
        })
    else

        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        local closestPlayerPed = GetPlayerPed(closestPlayer)

        if IsPedDeadOrDying(closestPlayerPed, 1) then
            
            TriggerEvent("mythic_progbar:client:progress", {
                name = "unique_action_name",
                duration = Config.TimeRevive * 1000,
                label = "กำลังชุบผู้เล่น..",
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "amb@medic@standing@tendtodead@base",
                    anim = "base",
                },
            }, function(status)
                if not status then
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('chev_revive:active', GetPlayerServerId(closestPlayer))
                end
            end)
        else
            TriggerEvent("pNotify:SendNotification", {
                text = '<strong class="red-text">ผู้เล่นยังมีชีวิตอยู่</strong>',
                type = "error",
                timeout = 3000,
                layout = "bottomCenter",
                queue = "global"
            })
        end

    end
end)


RegisterNetEvent('chev_revive:animation')
AddEventHandler('chev_revive:animation', function()


    if not statusreive then
        statusreive = true

        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
    
        TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
    
    
            local formattedCoords = {
                x = ESX.Math.Round(coords.x, 1),
                y = ESX.Math.Round(coords.y, 1),
                z = ESX.Math.Round(coords.z, 1)
            }
    
        ESX.SetPlayerData('lastPosition', formattedCoords)

        TriggerServerEvent('esx:updateLastPosition', formattedCoords)

        RespawnPed(playerPed, formattedCoords, 0.0)
        statusreive = false

    end


end)

function RespawnPed(ped, coords, heading)
    local rnx = math.random(1,30)
    local rny = math.random(1,30)
    local rnz = math.random(1,30)
    SetEntityCoordsNoOffset(ped, coords.x+rnx, coords.y+rny, coords.z+rnz, false, false, false, true)
    NetworkResurrectLocalPlayer(coords.x+rnx, coords.y+rny, coords.z+rnz, heading, true, false)
    SetPlayerInvincible(PlayerPedId(), false)
    TriggerEvent('playerSpawned', coords.x+rnx, coords.y+rny, coords.z+rnz)
    ClearPedBloodDamage(PlayerPedId())
    if Config.MaxHeath then
        SetEntityHealth(PlayerPedId(), 200)
    else
        SetEntityHealth(PlayerPedId(), 110)
    end
    
end


local HandObject = nil


for k,v in pairs(Config.item) do

	RegisterNetEvent(''..v.itemname..':client_sv')
	AddEventHandler(''..v.itemname..':client_sv', function(CurrentZone)
		local healing = false

		if not healing then

            local playerPed = PlayerPedId()
            local health = GetEntityHealth(playerPed)

            healing = true
            type = v.itemname

            TriggerEvent("mythic_progbar:client:progress", {
                name = "unique_action_name",
                duration = v.Time * 1000,
                label = v.Text ,
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {

                    animDict = v.animDict,
                    anim = v.anim,

                },

            }, function(status)
                if not status then

                    if checkHasItem(type) then
                        SetEntityHealth(playerPed, health + v.Count)
                        healing = false
                        TriggerServerEvent('chev_revive:removeitem',type)
                    end

                end
            end)



        else

            exports.pNotify:SendNotification(
                {
                    text = " <center><b style='color:white'>ไม่สามารถทำซ้ำได้</b><br /></center>",
                    type = "error",
                    timeout = 3000,
                    layout = "bottomCenter",
                    queue = "inventoryhud"
                }
            )

        end


	end)

	
end

function checkHasItem (item_name)

	local inventory = ESX.GetPlayerData().inventory
	for i=1, #inventory do
	  local item = inventory[i]
	  if item_name == item.name and item.count > 0 then


		return true
	  end
	end
    TriggerServerEvent('chev_revive:setstatus')

    exports.pNotify:SendNotification(
        {
            text = " <center><b style='color:white'>คุณไม่ไอเทมที่ต้องการ</b><br /></center>",
            type = "error",
            timeout = 3000,
            layout = "bottomCenter",
            queue = "inventoryhud"
        }
    )

    healing = false


	return false
end


AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then

	end
end)

