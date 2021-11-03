--[[
	id: 7MIthnvbZfKN9nW3KhgmW
	name: bank-client
	description: drx_bank script
	time1: 2021-05-20 19:22:47.291604+00
	time2: 2021-05-20 19:22:47.291605+00
	uploader: CQKlIEHmUFoDOxxFG58XOr0-u0jZSNU5HSOvYXHv
	uploadersession: QETHKRUAIi0o9DYhzpHK_gl7g3ThMq
	flag: f
--]]

AddEventHandler("playerSpawned", function ()
    Wait(10)
    TriggerServerEvent('drx_bank:playerSpawned')
end)

Citizen.CreateThread(function()
    if Config.Blips == true then
        for _, info in pairs(Config.Locations) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.id)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, 1.0)
        SetBlipColour(info.blip, info.colour)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
        end
    end
end)

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
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
    while true do
        inRange = false

        local Player = GetPlayerPed(-1)
        local Position = GetEntityCoords(Player)

        for _,Coords in pairs(Config.Locations) do

            local dist = GetDistanceBetweenCoords(Position, Coords.x, Coords.y, Coords.z)
            
            if dist < 2 then
                inRange = true
            
                if Coords.title == 'Bank' then
                    DrawText3D(Coords.x, Coords.y, Coords.z, Config.DrawText3DBank)
                end
                if Coords.title == 'ATM' then
                    DrawText3D(Coords.x, Coords.y, Coords.z, Config.DrawText3DATM)
                end
                DrawMarker(2, Coords.x, Coords.y, Coords.z, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.3, 0.5, 0.2, 200, 0, 0, 222, false, false, false, true, false, false, false)
                if IsControlJustReleased(0, Config.Open) then
                    Open()
                end
            end
        end

        if not inRange then
            Citizen.Wait(1000)
        end

        Citizen.Wait(1)
    end
end)

function Open()
    drxBank.TriggerServerCallback('drx_bank:characterInfo', function(playerInfo)
        drxBank.TriggerServerCallback('drx_bank:playerTransactions', function(playerTransanction)
            drxBank.TriggerServerCallback('drx_bank:basics', function(drxBasics)
                drxBank.TriggerServerCallback('drx_bank:loans', function(drxLoans)

                    if drxLoans[1] == nil then
                        SetNuiFocus(true, true)
                        SendNUIMessage({
                            open = true,
                            userTransactions = playerTransanction,
                            imageLink = drxBasics[1].imageLink,
                            currentLoan = '0.00',
                            currentTimer = '0',
                            characterName = playerInfo[1].firstname.. ' ' ..playerInfo[1].lastname,
                            bankBalance = playerInfo[1].bankBalance,
                            cashBalance = playerInfo[1].cashBalance,
                            phoneNumber = playerInfo[1].phoneNumber,
                            registration = playerInfo[1].registration,
                            age = playerInfo[1].age,
                        })
                    else
                        SetNuiFocus(true, true)
                        SendNUIMessage({
                            open = true,
                            userTransactions = playerTransanction,
                            imageLink = drxBasics[1].imageLink,
                            currentLoan = drxLoans[1].currentLoan,
                            currentTimer = drxLoans[1].currentTimer,
                            characterName = playerInfo[1].firstname.. ' ' ..playerInfo[1].lastname,
                            bankBalance = playerInfo[1].bankBalance,
                            cashBalance = playerInfo[1].cashBalance,
                            phoneNumber = playerInfo[1].phoneNumber,
                            registration = playerInfo[1].registration,
                            age = playerInfo[1].age,
                        })
                    end
                end)
            end)
        end)
    end)
end

function Close()
    SetNuiFocus(false, false)
    SendNUIMessage({
        close = true
    })
end

RegisterNUICallback('close', function(data)
    SetNuiFocus(false, false)
end)

RegisterNUICallback('deposit', function(data)
    TriggerServerEvent('drx_bank:DepositWithdraw', data.type, data.valueDW)
end)

RegisterNUICallback('withdraw', function(data)
    TriggerServerEvent('drx_bank:DepositWithdraw', data.type, data.valueDW)
end)

RegisterNUICallback('quickdeposit', function(data)
    TriggerServerEvent('drx_bank:QuickDepositWithdraw', data.type, data.amount, data.label)
end)

RegisterNUICallback('quickwithdraw', function(data)
    TriggerServerEvent('drx_bank:QuickDepositWithdraw', data.type, data.amount, data.label)
end)

RegisterNUICallback('transfer', function(data)
    TriggerServerEvent('drx_bank:Transfer', data.type, data.valueTransfer, data.recieverID)
end)

RegisterNUICallback('loan', function(data)
    TriggerServerEvent('drx_bank:Loan', data.loanAmount)
end)

RegisterNUICallback('payloan', function(data)
    TriggerServerEvent('drx_bank:PayLoan', data.loanAmount)
end)

RegisterNUICallback('image', function(data)
    TriggerServerEvent('drx_bank:insertImage', data.imageLink)
end)

RegisterNetEvent('drx_bank:updateBalance')
AddEventHandler('drx_bank:updateBalance', function(bankBalance, cashBalance)
    SendNUIMessage({
        type = 'updateBalance',
        bankBalance = bankBalance,
        cashBalance = cashBalance,
    })
end)

RegisterNetEvent('drx_bank:updateLoan')
AddEventHandler('drx_bank:updateLoan', function(currentLoan)
    SendNUIMessage({
        type = 'updateLoan',
        currentLoan = currentLoan,
    })
end)

RegisterNetEvent('drx_bank:updateTimer')
AddEventHandler('drx_bank:updateTimer', function(currentTimer)
    SendNUIMessage({
        type = 'updateTimer',
        currentTimer = currentTimer
    })
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		TriggerServerEvent('drx_bank:loanTimer')
	end
end)