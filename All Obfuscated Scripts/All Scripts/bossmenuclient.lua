--[[
	id: XlazvBGnRMpdWJa8T0goG
	name: bossmenu-client
	description: client side
	time1: 2021-05-23 03:30:24.376971+00
	time2: 2021-05-23 03:30:24.376972+00
	uploader: pomU5ZHdYsjiW7IQRZ9Ow0grNWYy6qhp9lboTjvz
	uploadersession: 3hg6TA53Lrz7TrrmwkUpwUuRnnU0PQ
	flag: f
--]]

-- CREATED BY NZ-DEV

QBCore = nil
PlayerJob = {}
PlayerGang = {}
isLoggedIn = false
PlayerData = {}
plyData = {}
plyJob = {}

Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 20, 0, 0, 75)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()

    while QBCore == nil do
     TriggerEvent(Config.Core, function(obj) QBCore = obj end)
     Citizen.Wait(500)
     canBillingMode = true

     Citizen.Wait(1000)
 
     SendNUIMessage({type = 'setupConfig',
         config = {
             allowCustomReasons = Config.allowCustomReasons,
             allowCustomAmounts = Config.allowCustomAmounts,
             maxAmount = Config.maxAmount,
             maxReasonCharacter = Config.maxReasonCharacter,
         },
         
         language = Config.language
     })
 end
 
 while QBCore.Functions.GetPlayerData().job == nil do
     Citizen.Wait(100)
 end

 while QBCore.Functions.GetPlayerData().gang == nil do
    Citizen.Wait(100)
 end
 PlayerJob = QBCore.Functions.GetPlayerData().job
 PlayerGang = QBCore.Functions.GetPlayerData().gang
 end)
 
 local isInMenu = false
 
 AddEventHandler('onResourceStart', function(resource)
     if resource == GetCurrentResourceName() then
         while true do
         isLoggedIn = true
         Citizen.Wait(1000)
         PlayerJob = QBCore.Functions.GetPlayerData().job
         PlayerGang = QBCore.Functions.GetPlayerData().gang
         end
     end
 end)

RegisterNetEvent(Config.OnPlayerLoaded)
AddEventHandler(Config.OnPlayerLoaded, function()
        isLoggedIn = true
        Citizen.Wait(5000)
        PlayerJob = QBCore.Functions.GetPlayerData().job
        PlayerGang = QBCore.Functions.GetPlayerData().gang
        plyJob = getPlayerJob()
        plyData = plyJob
    end)

RegisterNetEvent(Config.OnJobUpdate)
AddEventHandler(Config.OnJobUpdate, function(JobInfo)
    PlayerJob = JobInfo
    plyJob = getPlayerJob()
    plyData = plyJob
end)

RegisterNetEvent('nz-bossmenu:NotificaSoldiSocieta')
AddEventHandler('nz-bossmenu:NotificaSoldiSocieta', function()

    QBCore.Functions.TriggerCallback("nz-bossmenu:controllaSoldiSocieta", function(soldisocieta)
                       
                        
        for k, v in pairs(soldisocieta) do
            importosocieta = v.amount
            local msg = 
            QBCore.Functions.Notify(string.format(Config.language["SocietyHave"], importosocieta), "success", 10000)
        end
                
    end)
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if isLoggedIn then
            if PlayerJob.name ~= nil then
                if PlayerJob.isboss == true then
                    local pos = GetEntityCoords(PlayerPedId())
                    for k, v in pairs(QBCore.Shared.Jobs[PlayerJob.name]["boss"]) do
                        if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 2) then
                            if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 1.0) then
                                DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Boss Menu")
                                DrawMarker(25, v.x, v.y, v.z-0.96, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 255, 255, 200, 0, 0, 0, 0)
                                if IsControlJustReleased(0, Keys["E"]) then
                                    ApriBossMenu()
                                end
                            elseif (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 1.5) then
                                DrawText3D(v.x, v.y, v.z, "Boss Menu")
                                DrawMarker(25, v.x, v.y, v.z-0.96, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 255, 255, 200, 0, 0, 0, 0)
                            end
                        end
                    end
                end
            else
                Citizen.Wait(7500)
            end
        end
    end
end)

function ApriBossMenu(employees, jobdata)
    local options = options or {}
    local elements = {}
    local player = PlayerPedId()
    local societa = QBCore.Functions.GetPlayerData().job.name
    local societalabel = QBCore.Functions.GetPlayerData().job.label

    local defaultOptions = {
        ritira    = true,
        deposita  = true,
        riclicla  = false,
        assumi    = false,
        grado     = false
    }

    for k,v in pairs(defaultOptions) do
        if options[k] == nil then
            options[k] = v
        end
    end

    if options.ritira then
        table.insert(elements, {label = Config.language['WithdrawCorporateMoney'], value = 'ritira_soldi_societa'})
    end

    if options.deposita then
        table.insert(elements, {label = Config.language['DepositMoneyIntoTheCompany'], value = 'deposita_soldi_societa'})
    end

    if options.riclicla then
        table.insert(elements, {label = Config.language['EmployeeManagement'], value = 'gestisci_personale'})
    end

    if options.assumi then
        table.insert(elements, {label = Config.language['PromoteEmployee'], value = 'promuovi_personale'})
    end

    if options.grado then
        table.insert(elements, {label = Config.language['FireAnEmployee'], value = 'licenzia_personale'})
    end

    QBCore.UI.Menu.Open('default', GetCurrentResourceName(), "ritira_soldi_societa_",
    {
        title    = Config.language['TitleCompanyMenu'],
        align    = Config.AlignMenu,
        elements = elements
    },
    function(data, menu)
                
        if data.current.value == 'ritira_soldi_societa' then
                
            QBCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'ritira_soldi_societa_' .. societa, {
                title = Config.language['HowMuchWithdraw']
            }, function(data, menu)
                
                local amount = tonumber(data.value)
                
                if amount == nil then
                    QBCore.Functions.Notify(Config.language['AmountEmpty'], "error")
                else
                    menu.close()
                    local tota
                    QBCore.Functions.TriggerCallback("nz-bossmenu:controllaSoldiSocieta", function(soldisocieta)
                       
                        
                        for k, v in pairs(soldisocieta) do
                            importosocieta = v.amount
                            tota = importosocieta - amount
                                
                            if tonumber(importosocieta) >= amount then
                                
                                TriggerServerEvent("nk_bossmenu:PrelevaSoldiSocieta",amount, societa, tota, importosocieta)
                                
                            else
                                QBCore.Functions.Notify(Config.language['not_enough_money'], "error")
                            end
                        end
                                                
                    end)
                end
                
            end, function(data, menu)
                menu.close()
            end)
                
        elseif data.current.value == 'deposita_soldi_societa' then
                
            QBCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'deposita_soldi_societa_' .. societa, {
                title = Config.language['HowMuchDeposit']
            }, function(data, menu)
                
                local amount = tonumber(data.value)
                
                if amount == nil then
                    QBCore.Functions.Notify(Config.language['AmountEmpty'], "error")
                else
                    menu.close()
                    local tota

                    QBCore.Functions.TriggerCallback("nz-bossmenu:controllaSoldiSocieta", function(soldisocieta)
                       
                        
                        for k, v in pairs(soldisocieta) do
                            importosocieta = v.amount
                            tota = importosocieta + amount
                    
                       
                                            
                            local soldiPlayer = QBCore.Functions.GetPlayerData().money["cash"]
                            tota = soldiPlayer + amount
                                
                            if amount <= soldiPlayer then
                                
                                TriggerServerEvent("nk_bossmenu:DepositaSoldiSocieta",amount, societa, tota, importosocieta)
                                                
                                
                            else
                                QBCore.Functions.Notify(Config.language['NotEnoughCash'], "error")
                            end
                        end
                    end)
                end
                
            end, function(data, menu)
                    menu.close()
            end)
        elseif data.current.value == 'gestisci_personale' then
            ApriGestioneDipendenti(societa)
        elseif data.current.value == 'promuovi_personale' then
            TriggerServerEvent('nk_bossmenu:PromuoviPersonale')
        elseif data.current.value == 'licenzia_personale' then
            TriggerServerEvent('nk_bossmenu:LicenziaPersonale')
        end
    end, function(data, menu)
        menu.close()
    end, function(data, menu)
    end)
end

function ritornaLavoro()
    local plyData = QBCore.Functions.GetPlayerData().job
        return plyData.name
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(20)
        if IsControlPressed(1, Config.OpenMainMenu) then
            if PlayerJob.name ~= nil then
                if Config.JobPermission[ritornaLavoro()] then
                    if PlayerJob.isboss == true then
                        ApriMenuFattureBoss()
                    else
                        ApriMenuFatture()
                    end
                end
            end
        end
    end
    Citizen.Wait(500)
end)

function GetClosestPlayer()
    local closestPlayers = QBCore.Functions.GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(PlayerPedId())

    for i=1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, coords.x, coords.y, coords.z, true)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
	end

	return closestPlayer, closestDistance
end

function ApriMenuFatture(employees, jobdata)
    local permessoCheckFatture = false
    local options = options or {}
    local elements = {}
    local player = PlayerPedId()
    local societa = QBCore.Functions.GetPlayerData().job.name
    local societalabel = QBCore.Functions.GetPlayerData().job.label

    if PlayerJob.name == 'police' then
        permessoCheckFatture = true
    else
        permessoCheckFatture = false
    end

    local defaultOptions = {
        faiunafattura  = true,
        fatturenonpagate = permessoCheckFatture
    }

    for k,v in pairs(defaultOptions) do
        if options[k] == nil then
            options[k] = v
        end
    end

    if options.faiunafattura then
        table.insert(elements, {label = Config.language['create_invoice'], value = 'fai_una_fattura_'})
    end

    if options.fatturenonpagate then
        table.insert(elements, {label = Config.language['UnpaidInvoices'], value = 'controlla_fatture_aperte'})
    end


    QBCore.UI.Menu.Open('default', GetCurrentResourceName(), "menu_fatture_",
    {
        title    = Config.language['InvoicesMenu'],
        align    = Config.AlignMenu,
        elements = elements
    },
    function(data, menu)
                
        if data.current.value == 'fai_una_fattura_' then
            TriggerEvent('nz-bossmenu:ApriMenuFatture')
            menu.close()
        elseif data.current.value == 'controlla_fatture_aperte' then
            local player, distance = GetClosestPlayer()
            if player ~= -1 and distance < 2.5 then
                ApriMenuFattureNonPagate(player)
            else
                QBCore.Functions.Notify(Config.language['NoPlayersNearby'], "error")
            end
        end
    end, function(data, menu)
        menu.close()
    end, function(data, menu)
    end)
end


function ApriMenuFattureNonPagate(target)
    local elements = {}

    QBCore.Functions.TriggerCallback('nz-bossmenu:trovaTargetFattura', function(fatture)
		for k,fattura in pairs(fatture) do
            table.insert( elements, {
                label = ('%s: <span style="color:red;"> %s</span>'):format(fattura.societylabel, "$" ..fattura.amount.. " - " ..fattura.reason.."."),
                fatturaid = fattura.invoiceid
            })
        end

        QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'menu_fatture_non_pagate', {
            title = Config.language['UnpaidInvoicesMenu'],
            align = Config.AlignMenu,
            elements = elements
        }, nil, function(data, menu)
            menu.close()
        end)
    end, GetPlayerServerId(target))
end

function ApriMenuFattureBoss(employees, jobdata)
    local permessoCheckFatture = false
    local options = options or {}
    local elements = {}
    local player = PlayerPedId()
    local societa = QBCore.Functions.GetPlayerData().job.name
    local societalabel = QBCore.Functions.GetPlayerData().job.label

    if PlayerJob.name == Config.UnpaidInvoicesPermissionToCheck then
        permessoCheckFatture = true 
    else
        permessoCheckFatture = false 
    end

    local defaultOptions = {
        soldisocieta   = true,
        faiunafattura  = true,
        assumi         = true,
        licenzia       = true,
        fatturenonpagate = permessoCheckFatture,
    }

    for k,v in pairs(defaultOptions) do
        if options[k] == nil then
            options[k] = v
        end
    end

    if options.soldisocieta then
        table.insert(elements, {label = Config.language['CheckMoneyCompany'], value = 'mostra_soldi_societa'})
    end

    if options.faiunafattura then
        table.insert(elements, {label = Config.language['create_invoice'], value = 'fai_una_fattura_'})
    end

    if options.fatturenonpagate then
        table.insert(elements, {label = Config.language['UnpaidInvoices'], value = 'controlla_fatture_aperte'})
    end

    if options.assumi then
        table.insert(elements, {label = Config.language['HireStaff'], value = 'assumi_persona_vicina'})
    end

    if options.licenzia then
        table.insert(elements, {label = Config.language['FireAnEmployee'], value = 'licenzia_persona_vicina'})
    end

    QBCore.UI.Menu.Open('default', GetCurrentResourceName(), "menu_fatture_",
    {
        title    = Config.language['InvoicesMenu'],
        align    = Config.AlignMenu,
        elements = elements
    },
    function(data, menu)
                
        if data.current.value == 'fai_una_fattura_' then
            TriggerEvent('nz-bossmenu:ApriMenuFatture')
            menu.close()
        elseif data.current.value == 'mostra_soldi_societa' then
            TriggerEvent('nz-bossmenu:NotificaSoldiSocieta')
        elseif data.current.value == 'controlla_fatture_aperte' then
            local player, distance = GetClosestPlayer()
            if player ~= -1 and distance < 2.5 then
                ApriMenuFattureNonPagate(player)
            else
                QBCore.Functions.Notify(Config.language['NoPlayersNearby'], "error")
            end
        elseif data.current.value == 'licenzia_persona_vicina' then
            local player, distance = GetClosestPlayer()

            if player ~= -1 and distance < 2.5 then
                    
                local playerId = GetPlayerServerId(player)

 
                QBCore.Functions.Notify(string.format(Config.language["YouAreFiring"], playerId), "success")

                QBCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'licenzia_persona_vicina_' .. societa, {
                    title = string.format(Config.language["InsertSecurityCode"], Config.SecurityCodeForFireEmployed)
                }, function(data, menu)
                    
                    local codicedisicurezza = tonumber(data.value)

                    if codicedisicurezza == Config.SecurityCodeForFireEmployed then
                        menu.close()

                        TriggerServerEvent("nk_bossmenu:LicenziaPersona", playerId, societa)
                    else
                        QBCore.Functions.Notify(Config.language["InvalidSecurityCode"], "error")
                    end
                end, function(data, menu)
                    menu.close()
                end)
            else
                QBCore.Functions.Notify(Config.language["NoPlayersNearby"], "error")
            end
        elseif data.current.value == 'assumi_persona_vicina' then

            QBCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'inserisci_grado_' .. societa, {
                title = Config.language["EnterRankNewEmoployee"]
            }, function(data, menu)
                
                local grado = tonumber(data.value)
                
                if grado ~= nil then
                    if grado >= 0 then
                        menu.close()
                        local player, distance = GetClosestPlayer()
        
                        -------------------------------------
                        --TriggerServerEvent("banka:server:BillPlayera", 1, amountt)
                        ------------------------------------
                    
                            if player ~= -1 and distance < 2.5 then
                    
                                local playerId = GetPlayerServerId(player)
                    
                                TriggerServerEvent("nk_bossmenu:AssumiPersonaVicina", playerId, grado, societa, societalabel) 
                                QBCore.Functions.Notify(string.format(Config.language["YouAreSuccessfullyHired"], playerId, grado), "success")
                            
                            else
                                QBCore.Functions.Notify(Config.language["NoPlayersNearby"], "error")
                            end
                    else
                        QBCore.Functions.Notify(Config.language["InvalidRank"], "error")
                    end
                end
            end, function(data, menu)
                menu.close()
            end)


        end
    end, function(data, menu)
        menu.close()
    end, function(data, menu)
        
    end)
end


----- GANG ---- 

RegisterNetEvent('ControllaGang:client')
AddEventHandler('ControllaGang:client', function()
    TriggerServerEvent("ControllaGang")
end)

RegisterNetEvent('ApriMenuGang:client')
AddEventHandler("ApriMenuGang:client", function()
    ApriMenuGangBoss()
end)

function ApriMenuGangBoss(employees, gangdata)
    local options = options or {}
    local elements = {}
    local player = PlayerPedId()
    local gang = QBCore.Functions.GetPlayerData().gang.name
    local ganglabel = QBCore.Functions.GetPlayerData().gang.label

    local defaultOptions = {
        soldigang   = false,
        faiunafattura  = false,
        recluta         = true,
        defaziona       = true,
    }

    for k,v in pairs(defaultOptions) do
        if options[k] == nil then
            options[k] = v
        end
    end

    if options.soldigang then
        table.insert(elements, {label = "Controlla Soldi gang", value = 'mostra_soldi_gang'})
    end

    if options.faiunafattura then
        table.insert(elements, {label = "Fattura", value = 'fai_una_fattura_'})
    end

    if options.recluta then
        table.insert(elements, {label = Config.language["Recruit"], value = 'recluta_persona_vicina'})
    end

    if options.defaziona then
        table.insert(elements, {label = Config.language["SendAway"], value = 'defaziona_persona_vicina'})
    end

    QBCore.UI.Menu.Open('default', GetCurrentResourceName(), "menu_gang_",
    {
        title    = Config.language["TitleGangMenu"],
        align    = Config.AlignMenu,
        elements = elements
    },
    function(data, menu)
        if data.current.value == 'defaziona_persona_vicina' then
            local player, distance = GetClosestPlayer()

            if player ~= -1 and distance < 2.5 then
                    
                local playerId = GetPlayerServerId(player)

 
                QBCore.Functions.Notify(string.format(Config.language["SendingAway"], playerId), "success")

                QBCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'defaziona_persona_vicina_' .. gang, {
                    title = string.format(Config.language["InsertSecurityCode"], Config.SecurityCodeForFireEmployed)
                }, function(data, menu)
                    
                    local codicedisicurezza = tonumber(data.value)

                    if codicedisicurezza == Config.SecurityCodeForFireEmployed then
                        menu.close()

                        TriggerServerEvent("nk_bossmenu:DefazionaPersona", playerId, gang)
                        QBCore.Functions.Notify(string.format(Config.language["SuccessfullySentAway"], playerId), "success")
                    else
                        QBCore.Functions.Notify(Config.language["InsertSecurityCode"], "error")
                    end
                end, function(data, menu)
                    menu.close()
                end)
            else
                QBCore.Functions.Notify(Config.language["NoPlayersNearby"], "error")
            end
        elseif data.current.value == 'recluta_persona_vicina' then

            local player, distance = GetClosestPlayer()

            if player ~= -1 and distance < 2.5 then
                    
                local playerId = GetPlayerServerId(player)

                QBCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'assumi_persona_vicina' .. gang, {
                    title = Config.language["EnterRankNewEmoployee"]
                }, function(data, menu)
                    
                    local grado = tonumber(data.value)

                    if grado >= 0 then
                        menu.close()

                        TriggerServerEvent("nk_bossmenu:ReclutaPersonaVicina", playerId, grado, gang, ganglabel)
                        QBCore.Functions.Notify(string.format(Config.language["SuccessfullyRecruited"], playerId, grado), "success")
                    else
                        QBCore.Functions.Notify(Config.language["InvalidRank"], "error")
                    end
                end, function(data, menu)
                    menu.close()
                end)
            else
                QBCore.Functions.Notify(Config.language["NoPlayersNearby"], "error")
            end
        end
    end, function(data, menu)
        menu.close()
    end, function(data, menu)
        
    end)
end


---- MENU FATTURE 

isSelectingActive = false
isNuiActive = false


function getPlayerJob()
    local plyData = QBCore.Functions.GetPlayerData().job
        return plyData.name
end

function getServerPrefixKVP()
    local endpoint = GetCurrentServerEndpoint()

    endpoint = endpoint or "0.0.0.0"

    return GetCurrentResourceName() .. '_customBillings_' .. endpoint .. "_"
end

function getCustomReasons()
    return json.decode(GetResourceKvpString(getServerPrefixKVP() .. "reasons") or "{}")
end

function getCustomAmounts()
    return json.decode(GetResourceKvpString(getServerPrefixKVP() .. "amounts") or "{}")
end

function addCustomBillingData(name, value)
    local data = nil

    if(name == "reasons") then
        data = getCustomReasons()
    elseif(name == "amounts") then
        data = getCustomAmounts()
    end

    if(data) then
        table.insert(data, value)

        SetResourceKvp(getServerPrefixKVP() .. name, json.encode(data))
    end
end

function getCustomBillingData()
    local reasons = getCustomReasons()
    local amounts = getCustomAmounts()

    return {
        reasons = reasons,
        amounts = amounts
    }
end

function removeCustomValue(value)
    local customData = getCustomBillingData()

    local found = false

    for i=1, #customData.reasons do
        if(customData.reasons[i] == value) then
            table.remove(customData.reasons, i)
            SetResourceKvp(getServerPrefixKVP() .. "reasons", json.encode(customData.reasons))

            found = true
            break
        end
    end

    if(not found) then
        local amount = tonumber(value)
        for i=1, #customData.amounts do            
            if(customData.amounts[i] == amount) then
                table.remove(customData.amounts, i)
                SetResourceKvp(getServerPrefixKVP() .. "amounts", json.encode(customData.amounts))

                break
            end
        end
    end
end

function closeNui()
    SetNuiFocus(false, false)
    isNuiActive = false
end

RegisterNUICallback('new-custom-amount', function(data)
    local amount = tonumber(data.amount)

    if(amount and amount < Config.maxAmount and amount > 0) then
        addCustomBillingData('amounts', amount)
    end
end)

RegisterNUICallback('new-custom-reason', function(data)
    local reason = data.reason

    if(reason and reason ~= "" and not tonumber(reason) and string.len(reason) < Config.maxReasonCharacter) then
        addCustomBillingData('reasons', reason)
    end
end)

RegisterNUICallback('remove-custom', function(data)
    local value = data.toRemove
    removeCustomValue(value)
end)

local closestPed = nil

Citizen.CreateThread(function()
    local plyPed = PlayerPedId()
    while true do
        if(canBillingMode) then
            if(isSelectingActive) then
                local plyPos = GetEntityCoords(plyPed)
                
                local xClosestDistance = 5.0
                local yClosestDistance = 5.0

                for currentPed in EnumeratePeds() do
                    if(IsPedAPlayer(currentPed)) then
                        local currentPedCoords = GetPedBoneCoords(currentPed, 24818, 0.0, 0.0, 0.0)

                        local distance = GetDistanceBetweenCoords(currentPedCoords, plyPos, true)

                        if(distance < Config.maxDistance) then
                            local _, screenX, screenY = GetScreenCoordFromWorldCoord(currentPedCoords.x, currentPedCoords.y, currentPedCoords.z)
                            
                            if(screenX > 0 and screenY > 0) then
                                local mouseX, mouseY = GetNuiCursorPosition()
                                
                                local screenWidth, screenHeight = GetActiveScreenResolution()
                                
                                if(mouseX <= screenWidth and mouseY <= screenHeight) then
                                    mouseX = mouseX/screenWidth
                                    mouseY = mouseY/screenHeight

                                    local xScreenDistance = math.abs(mouseX-screenX)
                                    local yScreenDistance = math.abs(mouseY-screenY)

                                    if(xScreenDistance < 0.03 and yScreenDistance < 0.1) then
                                        if(xClosestDistance > xScreenDistance and yClosestDistance > yScreenDistance and plyPed ~= currentPed) then
                                            xClosestDistance = xScreenDistance
                                            yClosestDistance = yScreenDistance
                                            closestPed = currentPed
                                        end
                                    else
                                        if(currentPed == closestPed) then
                                            closestPed = nil
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            
                Citizen.Wait(100)
            else
                plyPed = PlayerPedId()
                Citizen.Wait(1000)
            end
        else
            Citizen.Wait(5000)
            canBillingMode = true
        end

        Citizen.Wait(0)
    end
end)

RegisterNetEvent('nz-bossmenu:ApriMenuFatture')
AddEventHandler('nz-bossmenu:ApriMenuFatture', function()
    activateBillingMode()
end)


function activateBillingMode() 
    isSelectingActive = true
    
    Citizen.CreateThread(function()
      --  print(isSelectingActive)
        SetNuiFocus(false, true)
        
        while isSelectingActive do
          --  print(closestPed)
            if(closestPed) then
                local pedCoords = GetPedBoneCoords(closestPed, 24817, 0.0, 0.0, 0.0)
                DrawMarker(20, 
                pedCoords.x, pedCoords.y, pedCoords.z + 0.8, 
                Config.marker.dir.x, Config.marker.dir.y, Config.marker.dir.z,
                Config.marker.rot.x, Config.marker.rot.y, Config.marker.rot.z,
                Config.marker.scale.x, Config.marker.scale.y, Config.marker.scale.z,
                Config.marker.color.r, Config.marker.color.g, Config.marker.color.b, Config.marker.alpha, 
                false, true, 2, false, nil, nil, nil)
            end
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 263, true)
            DisableControlAction(0, 140, true)
            DisableControlAction(0, 141, true)
            DisableControlAction(0, 142, true)
            DisableControlAction(0, 143, true)
            DisableControlAction(0, 200, true)

            ---
            DisablePlayerFiring(PlayerPedId(), true)

            Citizen.Wait(0)
        end


        closestPed = nil
        DisablePlayerFiring(PlayerPedId(), false)
    end)
end

Citizen.CreateThread(function()
    AddTextEntry("nz-bossmenu_select_player", Config.language['click_to_select'])

    while true do
        Citizen.Wait(0)

        if(isSelectingActive) then
            DisplayHelpTextThisFrame("nz-bossmenu_select_player", false)
        end

        if(canBillingMode) then
            if(not isNuiActive) then
                if IsDisabledControlJustReleased(0, 200) or IsDisabledControlJustReleased(0, 202) then
                    isSelectingActive = false
                    closeNui()
                elseif(IsDisabledControlJustReleased(0, 24)) then
                    if(closestPed) then
                        local targetPlayer = NetworkGetPlayerIndexFromPed(closestPed)
                        local targetId = GetPlayerServerId(targetPlayer)

                        local plyJob = getPlayerJob()

                        SendNUIMessage({type = 'createBill',
                            targetId = targetId,
                            defaultAmounts = Config.defaultAmounts[getPlayerJob()],
                            defaultReasons = Config.defaultReasons[getPlayerJob()],
                            customOptions = getCustomBillingData(),
                           -- print(getPlayerJob())
                        })
                        
                        SetNuiFocus(true, true)

                        isNuiActive = true
                        isSelectingActive = false
                    end
                end
            else
                Citizen.Wait(500)
            end
        else
            Citizen.Wait(5000)
        end
    end
end)

RegisterNUICallback('close', function() 
    closeNui()
end)

RegisterNUICallback('bill', function(data)
    local id = tonumber(data.id)
    local reason = data.reason
    local amount = tonumber(data.amount)
    
    TriggerServerEvent('nz-bossmenu:ChiediFattura', id, reason, amount)
    closeNui()

end)

RegisterNetEvent('nz-bossmenu:ChiediFattura')
AddEventHandler('nz-bossmenu:ChiediFattura', function(reason, amount) 
    local running = true

    local msg = string.format(Config.language["confirm_invoice"], reason, amount)

    AddTextEntry("nz-bossmenu_confirm_invoice", msg)
    
    while running do
        Citizen.Wait(0)
        
        DisplayHelpTextThisFrame("nz-bossmenu_confirm_invoice", false)

        if(IsControlJustReleased(0, 191)) then
            running = false
            TriggerServerEvent('nz-bossmenu:rispondiFattura', true)
        elseif(IsControlJustReleased(0, 194)) then
            running = false
            TriggerServerEvent('nz-bossmenu:rispondiFattura', false)
        end
    end
end)

local function notification(text)
    BeginTextCommandThefeedPost('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandThefeedPostTicker(true, true)
end

RegisterNetEvent('nz-bossmenu:rispondiFattura')
AddEventHandler('nz-bossmenu:rispondiFattura', function(accepted, id, reason, amount)

    if(not accepted) then
        QBCore.Functions.Notify(Config.language["invoice_not_accepted"], "error")
        return
    end

    TriggerServerEvent("nk_bossmenu:InviaFattura", id, amount, societa, reason)  

    QBCore.Functions.Notify(Config.language["invoice_accepted"], "success")
end)


-- UTIL 

local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end
		enum.destructor = nil
		enum.handle = nil
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



