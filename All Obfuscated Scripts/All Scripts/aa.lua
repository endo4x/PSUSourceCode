--[[
	id: 317wvikLSKB6TZ88FtcvE
	name: aa
	description: aa
	time1: 2021-06-20 14:39:37.046159+00
	time2: 2021-06-20 14:39:37.04616+00
	uploader: lS-Z06UCVc6qfryzSSJ9csE2t59s3Ri4sYmLflB4
	uploadersession: Pv3MrokHkrgHESao-2h9Z-D5fl-J-Y
	flag: f
--]]


RegisterNetEvent('kuz_merryweather:repairFinish')
AddEventHandler('kuz_merryweather:repairFinish', function(message)
    repairingParts = false
    local displayResult = true
    local loc = Config.partsRepairLocations[insideRepair].locations[insideLocation]

    if math.random(1,100) > 80 then
        showTooltip(_U('tooltip_level_repair'))
    end

    Citizen.CreateThread(function()
        while displayResult do
            Citizen.Wait(0)
            Draw3DText(loc.x, loc.y, loc.z + 0.4, message, 4, 0.1, 0.075)
        end
    end)
    Citizen.CreateThread(function()
        Citizen.Wait(3000)
        displayResult = false
    end)
    insideRepair = nil
end)


for k, loc in pairs(Config.merryweatherLaptop.locations) do

    if Config.merryweatherLaptop.showOnMap then
        local blip = AddBlipForCoord(loc.x, loc.y, loc.z)
        SetBlipSprite (blip, 521)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 0.7)
        SetBlipColour (blip, 6)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(_U('merryweather_laptop'))
        EndTextCommandSetBlipName(blip)
    end

end


RegisterNetEvent('kuz_merryweather:openLaptop')
AddEventHandler('kuz_merryweather:openLaptop', function()
    openMerryweatherLaptop()
end)

function openMerryweatherLaptop()
    toggleLaptop(true)
    setLaptopContent()
    ESX.UI.Menu.CloseAll()
    SendNUIMessage({
        event = "show",
        state = true
    })

    SetNuiFocus(true, true)
end
function closeMerryweatherLaptop()
    toggleLaptop(false)
    SendNUIMessage({
        event = "show",
        state = false
    })
    SetNuiFocus(false, false)
end

RegisterNUICallback('closeMerryweatherLaptop', function(data, cb)
    closeMerryweatherLaptop()
    cb(true)
end)

function setLaptopContent()
    SendNUIMessage({
        event = "set-price",
        price = Config.merryweatherLaptop.setupPrice
    })
    SendNUIMessage({
        event = "set-content",
        file = "content-document",
        content = Config.merryweatherLaptop.file1Content,
    })
    SendNUIMessage({
        event = "set-content",
        file = "content-jokes",
        content = Config.merryweatherLaptop.file2Content,
    })
    SendNUIMessage({
        event = "set-stats",
        sales = sales,
        maxSales = Config.maxLevelSalesAmount,
        repairs = repairs,
        maxRepairs = Config.maxLevelRepairsAmount,
    })
end

RegisterNUICallback('triggerMerryweatherSell', function(data, cb)
    if not isSelling then
        ESX.TriggerServerCallback('kuz_merryweather:buyMerryweather', function(paid)
            if paid then
                startMerryweatherSell()
                SendNUIMessage({
                    event = "buy-finish",
                    success = true
                })
            else
                SendNUIMessage({
                    event = "buy-finish",
                    success = false
                })
            end
        end)
    else
        SendNUIMessage({
            event = "buy-finish",
            success = false
        })
    end

    cb(true)
end)

function startMerryweatherSell()
    Citizen.CreateThread(function()
        Citizen.Wait(math.random(2000,4000))
        sendMerryweatherMessage(_U('merryweather_message1_1'))
        sendMerryweatherFollowMessage(_U('merryweather_message1_2'))
        Citizen.Wait(math.random(30000,45000))
        isSelling = true
        saleLocation = Config.merryweatherLocations[math.random(1,#Config.merryweatherLocations)]
        -- saleLocation = Config.merryweatherLocations[3]

        if saleBlip ~= nil then
            RemoveBlip(saleBlip)
            saleBlip = nil
        end
        saleBlip = AddBlipForCoord(saleLocation.sell.x, saleLocation.sell.y, saleLocation.sell.z)
        SetBlipSprite (saleBlip, 161)
        SetBlipDisplay(saleBlip, 4)
        SetBlipScale  (saleBlip, 1.3)
        SetBlipColour (saleBlip, 49)
        SetBlipAsShortRange(saleBlip, false)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(_U('merryweather_sale'))
        EndTextCommandSetBlipName(saleBlip)

        sendMerryweatherMessage(_U('merryweather_message2_1'))
        sendMerryweatherFollowMessage(_U('merryweather_message2_2'))

        Citizen.CreateThread(function()
            local time = (Config.sellTimeout - 2) * 60000
            Citizen.Wait(time)
            if not soldAnything and isSelling then
                sendMerryweatherMessage(_U('merryweather_message3_1'))
                sendMerryweatherFollowMessage(_U('merryweather_message3_2'))
            end
            Citizen.Wait(120000)
            if isSelling then
                sendMerryweatherMessage(_U('merryweather_message4_1'))
                sendMerryweatherFollowMessage(_U('merryweather_message4_2'))
                transationFinalized()
            end
        end)
    end)

    function sendMerryweatherMessage(message)
        BeginTextCommandThefeedPost("STRING")
        AddTextComponentSubstringPlayerName(message)

        -- Set the notification icon, title and subtitle.
        local title = "TradeX"
        local subtitle = "Customer support"
        local iconType = 0
        local flash = false -- Flash doesn't seem to work no matter what.
        EndTextCommandThefeedPostMessagetext("CHAR_LESTER_DEATHWISH", "CHAR_LESTER_DEATHWISH", flash, iconType, title, subtitle)

        -- Draw the notification
        local showInBrief = true
        local blink = false -- blink doesn't work when using icon notifications.
        EndTextCommandThefeedPostTicker(blink, showInBrief)
    end

    function sendMerryweatherFollowMessage(message)
        ESX.ShowNotification(message)
    end
end

local soldAnything = false
function openSellMenu()
    if Config.useRandomEvents and not randomTriggered then
        local rand = math.random(1,100)
        if rand <= Config.randomEventChance and (rand <= Config.randomEventChanceInCity or saleLocation.sell.y >= 1500) and sales >= Config.minimumSalesAmount then
            triggerRandomEvent()
        end
        randomTriggered = true
    end

    ESX.UI.Menu.CloseAll()

    local elements = {}

    for k,v in ipairs(Config.sellable) do
        table.insert(elements, {
            label  = (v.label .. ' <span style="color:orange;">[</span><span style="color:green;">$'.. v.price .. '</span><span style="color:orange;">]</span>'),
            index = k
        })
    end

    table.insert(elements, {
        label  = ('<span style="color:red;">'.. _U('finalize_transaction') ..'</span>'),
        index = -1
    })

    if Config.sellLaptop and sales >= Config.unlockLaptopBuySaleLevel then
        table.insert(elements, {
            label  = ('<span style="color:green;">--- '.. _U('special_offer') ..' ---</span>'),
            index = -100
        })
        table.insert(elements, {
            label  = (_U('buy') .. ' ' .. _U('merryweather_laptop') .. ' <span style="color:orange;">[</span><span style="color:green;">$'.. Config.laptopPrice .. '</span><span style="color:orange;">]</span>'),
            index = 999
        })

    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'merryweather', {
        title    = _U('merryweather'),
        align    = 'right',
        elements = elements
    }, function(data, menu)
        local close = true
        if data.current.index == -100 then
            close = false
        elseif data.current.index == 999 then
            TriggerServerEvent('kuz_merryweather:buyLaptopItem')
        elseif data.current.index == -1 then
            transationFinalized()
        else
            soldAnything = true
            TriggerServerEvent('kuz_merryweather:sell', data.current.index)
            ClearPedTasksImmediately(saleNPC)
            playAnim(saleNPC,'mp_common', 'givetake2_b')
            playAnim(GetPlayerPed(-1),'mp_common', 'givetake1_a')
            Citizen.Wait(2000)
            ClearPedTasks(GetPlayerPed(-1))
            ClearPedTasks(saleNPC)
        end
        if close then
            menu.close()
        end
    end, function(data, menu)
        menu.close()
    end)
end


--
-- Finalize
--

function transationFinalized()
    Citizen.CreateThread(function()
        GenerateDirectionsToCoord(562.0, -3022.9, 6.0, 0)
        saleLocation = nil
        if saleBlip ~= nil then
            RemoveBlip(saleBlip)
            saleBlip = nil
        end

        FreezeEntityPosition(saleNPC, false)
        ClearPedTasksImmediately(saleNPC)
        TaskStartScenarioInPlace(saleNPC, "WORLD_HUMAN_STAND_MOBILE", 0, true)
        ClearPedTasks(saleNPC)
        Citizen.Wait(4000)
        if saleVehicle ~= nil then
            TaskEnterVehicle(saleNPC, saleVehicle, 14000, -1, 0.5, 1, 0)
            SetVehicleDoorsLocked(saleVehicle, 3)
            SetPedKeepTask(saleNPC, true)
            setNotNeeded(saleNPC, saleVehicle, passengerNPC)

            TaskVehicleDriveToCoordLongrange(saleNPC, saleVehicle, 562.0, -3022.9, 6.0, 30.0, 786603  , 20.0)
            SetDriverAbility(saleNPC, 100.0)
            SetDriverAggressiveness(saleNPC, 0.5)

            saleVehicle = nil
        else
            if saleNPC ~= nil then
                TaskWanderStandard(saleNPC, 10.0, 10)
                setPedNotNeeded(saleNPC)
            end
        end

        if passengerNPC ~= nil then
            passengerNPC = nil
        end

        if soldAnything then
            TriggerServerEvent('kuz_merryweather:addSoldStat')
        end

        isSelling = false
        saleNPC = nil
        setupCompleted = false
        randomTriggered = false
        soldAnything = false
        SendNUIMessage({
            event = "finish",
        })

        if math.random(1,100) > 70 then
            showTooltip(_U('tooltip_level_bonus'))
        end
    end)
end

local randomEvent = false
local randomPeds = {}
local randomVehicles = {}
local randomKeepUpDistance = 1000
function triggerRandomEvent()
    Citizen.CreateThread(function()
        Citizen.Wait(math.random(1000,3000))
        local event = Config.randomEvents[math.random(1, #Config.randomEvents)]
        -- event = Config.randomEvents[5]

        if event.type == 'shooting' or event.type == 'helicopter' then

            randomEvent = true
            randomKeepUpDistance = event.keepUpDistance
            for k = 1, event.amount do
                Citizen.Wait(2500)
                local x, y, z = getRandomEventCoords(event)

                if event.type == 'helicopter' then
                    z = z + 150.0
                end


                local vehicle
                local vehicleHash
                if event.useVehicles then
                    vehicleHash = event.vehicles[math.random(1, #event.vehicles)]
                    if not IsModelValid(vehicleHash) then
                        break
                    end
                    if not IsModelInCdimage(vehicleHash) then return end
                    RequestModel(vehicleHash)
                    while not HasModelLoaded(vehicleHash) do
                        Citizen.Wait(10)
                    end
                    vehicle = CreateVehicle(vehicleHash, x, y, z, 0, true, false)
                    SetModelAsNoLongerNeeded(vehicleHash)
                    table.insert(randomVehicles, vehicle)
                    SetVehicleEngineOn(vehicle, true, true, false)
                    if Config.lockRandomEventVehicles then
                        SetVehicleDoorsLocked(vehicle, 3)
                        SetVehicleDoorsLockedForAllPlayers(vehicle, true)
                        SetVehicleDoorsLockedForNonScriptPlayers(vehicle, true)
                    end

                    if event.colors ~= nil and #event.colors > 0 then
                        local color = event.colors[math.random(1,#event.colors)]
                        SetVehicleColours(vehicle, color, color)
                    end
                    if event.underglow ~= nil and event.underglow then
                        SetVehicleNeonLightEnabled(vehicle, 0, true)
                        SetVehicleNeonLightEnabled(vehicle, 1, true)
                        SetVehicleNeonLightEnabled(vehicle, 2, true)
                        SetVehicleNeonLightEnabled(vehicle, 3, true)
                        SetVehicleNeonLightsColour(vehicle, math.random(0,3) * 85,math.random(0,3) * 85,math.random(0,3) * 85)
                    end
                end

                Citizen.Wait(200)
                for p = 1, event.perVehicle do
                    if event.useVehicles and not event.type ~= 'helicopter' then
                        if (p - 2) > GetVehicleModelNumberOfSeats(vehicleHash) then
                            break
                        end
                    end

                    Citizen.Wait(100)
                    modelHash = GetHashKey(event.peds[math.random(1, #event.peds)])
                    if not IsModelValid(modelHash) then
                        break
                    end
                    RequestModel(modelHash)
                    while not HasModelLoaded(modelHash) do
                        Wait(1)
                    end

                    local ped = CreatePed(0, modelHash, x + 2.0, y + 2.0, z + 5.0, 0, true, false)
                    table.insert(randomPeds, ped)
                    SetModelAsNoLongerNeeded(modelHash)
                    if event.useVehicles then
                        SetPedIntoVehicle(ped, vehicle, p -2)
                    end

                    if event.weapons ~= nil and #event.weapons > 0 then
                        GiveWeaponToPed(ped, event.weapons[math.random(1, #event.weapons)], 60, false, true)
                    end
                    SetPedCombatAbility(ped, 1)
                    SetPedCanSwitchWeapon(ped, true)
                    AddRelationshipGroup('kuz_enemies')
                    SetRelationshipBetweenGroups(0, GetHashKey('kuz_enemies'), GetHashKey('kuz_enemies'))
                    SetPedRelationshipGroupHash(ped, 'kuz_enemies')

                    SetPedMaxHealth(ped, event.health)
                    SetEntityHealth(ped, event.health)
                    SetPedSuffersCriticalHits(ped, event.criticalHits)
                    SetPedArmour(ped, 100)

                    TaskCombatPed(ped, GetPlayerPed(-1), 0, 16)

                    SetPedAsEnemy(ped, true)
                    SetPedAccuracy(ped, event.aim)
                    SetPedDropsWeaponsWhenDead(ped, Config.canPedsDropWeapons)
                end
            end

            Citizen.CreateThread(function()
                while randomEvent do
                    Citizen.Wait(500)
                    if randomEvent then
                        for k, ped in pairs(randomPeds) do
                            if IsPedDeadOrDying(ped) then
                                ClearPedTasksImmediately(ped)
                                SetPedAsNoLongerNeeded(ped)
                                RemoveBlip(GetBlipFromEntity(ped))
                                randomPeds[k] = nil
                            end
                            local pedCoords = GetEntityCoords(ped)
                            if GetDistanceBetweenCoords(playerCoords, pedCoords, false) < Config.pedBlipDistance then
                                if GetBlipFromEntity(ped) == 0 then
                                    AddBlipForEntity(ped)
                                end
                            end
                            if GetDistanceBetweenCoords(playerCoords, pedCoords, true) > randomKeepUpDistance or not IsPedInCombat(ped) then
                                SetPedAsNoLongerNeeded(ped)
                                ClearPedTasks(ped)
                                RemoveBlip(GetBlipFromEntity(ped))
                                randomPeds[k] = nil
                            end
                        end
                        for k, veh in pairs(randomVehicles) do
                            local vehCoords = GetEntityCoords(veh)
                            if GetDistanceBetweenCoords(playerCoords, vehCoords, true) > randomKeepUpDistance or #randomPeds <= 0 then
                                SetVehicleAsNoLongerNeeded(veh)
                            end
                        end
                    end
                end
            end)
        end
    end)
end

function getRandomEventCoords(event)
    local got = false
    local waste, street1, street2
    while not got do
        local coords = playerCoords
        x = coords.x + math.random(-event.spawnRadius,event.spawnRadius)
        y = coords.y + math.random(-event.spawnRadius,event.spawnRadius)

        z = GetGroundZFor_3dCoord(x, y, 800.0, 0)

        waste, street1, street2 = GetClosestRoad(x, y, z, 1.0, 1, false)

        if GetDistanceBetweenCoords(coords,street1, false) > (event.spawnRadius / 2) then
            got = true
        elseif GetDistanceBetweenCoords(coords,street2, false) > (event.spawnRadius / 2) then
            street1 = street2
            got = true
        end
        Citizen.Wait(0)
    end
    return street1.x, street1.y, street1.z
end


