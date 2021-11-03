--[[
	id: y2mkJSfU9Fv-bg1CBHxe-
	name: bank-server
	description: drx_bank script
	time1: 2021-05-20 19:25:57.860697+00
	time2: 2021-05-20 19:25:57.860698+00
	uploader: CQKlIEHmUFoDOxxFG58XOr0-u0jZSNU5HSOvYXHv
	uploadersession: QETHKRUAIi0o9DYhzpHK_gl7g3ThMq
	flag: f
--]]

------------------------CREDITS------------------------
--------        Script made by Deltarix        --------
--   Copyright 2021 Deltarix. All rights reserved    --
-------------------------------------------------------

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","drx_bank")

-- Delete all transactions
AddEventHandler("onResourceStart", function(resource)
    if resource == GetCurrentResourceName() then
        if Config.ClearDatabase == true then
            exports.ghmattimysql:execute('DELETE FROM drx_transactions')
            print('-------------------------------')
            print('| DRX_BANK | Database cleared |')
            print('-------------------------------')
        end
    end
end)

-- Fetching player information
drxBank.RegisterServerCallback('drx_bank:characterInfo', function(source, cb)
    local src = source
    local user_id = vRP.getUserId({src})

    exports.ghmattimysql:execute('SELECT * FROM vrp_user_identities WHERE user_id = @user_id ', {
		['user_id'] = user_id
	}, function(result)

        local playerInfo = {}
        if (result[1] ~= nil) then
            for i=1, #result, 1 do
                table.insert(playerInfo, {
                    firstname = result[i].firstname,
                    lastname = result[i].name,
                    phoneNumber = result[i].phone,
                    registration = result[i].registration,
                    age = result[i].age,
                    bankBalance = vRP.getBankMoney({user_id}),
                    cashBalance = vRP.getMoney({user_id}),
                })
            end
            cb(playerInfo)
        end
    end)
end)

-- Fetching player transactions
drxBank.RegisterServerCallback('drx_bank:playerTransactions', function(source, cb)
    local src = source
    local user_id = vRP.getUserId({src})

    exports.ghmattimysql:execute('SELECT * FROM drx_transactions WHERE user_id = @user_id ORDER BY transaction_id DESC ', {
        ['@user_id'] = user_id
    }, function(playerTransanction)
        cb(playerTransanction)
    end)
end)

-- Fetching drx_basics info
drxBank.RegisterServerCallback('drx_bank:basics', function(source, cb)
    local src = source
    local user_id = vRP.getUserId({src})

    exports.ghmattimysql:execute('SELECT * FROM drx_basics WHERE user_id = @user_id ', {
		['@user_id'] = user_id
	}, function(result)

        local drxBasics = {}
        if (result[1] ~= nil) then
            for i=1, #result, 1 do
                table.insert(drxBasics, {
                    imageLink = result[i].imageLink,
                })
            end
            cb(drxBasics)
        end
    end)
end)

-- Fetching drx_bank info
drxBank.RegisterServerCallback('drx_bank:loans', function(source, cb)
    local src = source
    local user_id = vRP.getUserId({src})

    exports.ghmattimysql:execute('SELECT * FROM drx_bank WHERE user_id = @user_id', {
        ['@user_id'] = user_id
    }, function(result)

        local drxLoans = {}
        if (result) then
            for i=1, #result, 1 do
                table.insert(drxLoans, {
                    currentLoan = result[i].loanAmount,
                    currentTimer = result[i].loanTimer - os.time()
                })
            end
            cb(drxLoans)
        end
    end)
end)

-- Check loan timer
RegisterServerEvent('drx_bank:loanTimer')
AddEventHandler('drx_bank:loanTimer', function()
    local src = source
    local user_id = vRP.getUserId({src})

    exports.ghmattimysql:execute('SELECT loanTimer FROM drx_bank where user_id = @user_id', {
        ['@user_id'] = user_id
    }, function(result)
        if result[1] then
            local loanTimer = result[1].loanTimer - os.time()

            if loanTimer < 0 then
                TriggerEvent('drx_bank:loanForcePay', src)
            else
                TriggerClientEvent('drx_bank:updateTimer', src, loanTimer)
            end
        end
    end)
end)

-- If player has no image then assign one.
RegisterServerEvent('drx_bank:playerSpawned')
AddEventHandler('drx_bank:playerSpawned', function()
    local src = source
    local user_id = vRP.getUserId({src})

    exports.ghmattimysql:execute('SELECT * FROM `drx_basics` WHERE `user_id` = @user_id', {
        ['@user_id'] = user_id
    }, function(result)
        local actualResult = result

        if (actualResult[1] == nil) then
            exports.ghmattimysql:execute('INSERT INTO `drx_basics` (`user_id`, `imageLink`) VALUES (@user_id, @imageLink)', {
                ['@user_id'] = user_id,
                ['@imageLink'] = Config.ImageOnFirst
            })
        end
    end)
end)

-- Update player image
RegisterServerEvent('drx_bank:insertImage')
AddEventHandler('drx_bank:insertImage', function(imageLink)
    local src = source
    local user_id = vRP.getUserId({src})

    exports.ghmattimysql:execute('SELECT * FROM `drx_basics` WHERE `user_id` = @user_id', {
        ['@user_id'] = user_id
    }, function(result)
        local actualResult = result

        if (actualResult[1] ~= nil) then
            exports.ghmattimysql:execute('UPDATE `drx_basics` SET `imageLink` = @imageLink WHERE `user_id` = @user_id', {
                ['@user_id'] = user_id,
                ['@imageLink'] = imageLink
            })
        else
            exports.ghmattimysql:execute('INSERT INTO `drx_basics` (`user_id`, `imageLink`) VALUES (@user_id, @imageLink)', {
                ['@user_id'] = user_id,
                ['@imageLink'] = imageLink
            })
        end
    end)
end)

-- Deposit & Withdraw
RegisterServerEvent('drx_bank:DepositWithdraw')
AddEventHandler('drx_bank:DepositWithdraw', function(type, valueDW)
    local src = source
    local user_id = vRP.getUserId({src})
    local bankBalance = vRP.getBankMoney({user_id})
    local cashBalance = vRP.getMoney({user_id})
    valueDW = tonumber(valueDW)
    Valid = isValid(valueDW)

    if type == 'Withdraw' then
        if Valid then
            if valueDW ~= nil and valueDW > 0 then
                if bankBalance >= valueDW then
                    vRP.tryWithdraw({user_id, valueDW})
                    TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'success', text = Config.Notifications.Withdraw.. ' ' ..valueDW, length = '5000', style = {}})
                    TriggerClientEvent('drx_bank:updateBalance', src, vRP.getBankMoney({user_id}), vRP.getMoney({user_id}))
                    exports.ghmattimysql:execute('INSERT INTO `drx_transactions` (`user_id`, `type`, `amount`, `transaction_id`, `date`) VALUES (@user_id, @type, @amount, @transaction_id, @date)', {
                        ['@user_id'] = user_id,
                        ['@amount'] = valueDW,
                        ['@type'] = type,
                        ['@transaction_id'] = uuid(v),
                        ['@date'] = os.date("Day: %d | Month: %m | Year: %Y")
                    })
                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = Config.Notifications.WithdrawNotEnough, length = '5000', style = {}})
                end
            end
        elseif Config.SendWebhooks == true then
            sendToDiscord(1598920, 'DRX Bank - Exploit attempts', 'ID: ' ..user_id.. ' | Type: ' ..type.. ' | Value: ' ..valueDW.. ' | Type: '..Type.. ' | Transaction: ' ..uuid(v).. ' | Date: ' ..os.date("Day: %d | Month: %m | Year: %Y | Time: %H:%M:%S"), '- Deltarix')
        end
    end

    if type == 'Deposit' then
        if Valid then
            if valueDW ~= nil and valueDW > 0 then
                if cashBalance >= valueDW then
                    vRP.tryDeposit({user_id, valueDW})
                    TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'success', text = Config.Notifications.Deposit.. ' ' ..valueDW, length = '5000', style = {}})
                    TriggerClientEvent('drx_bank:updateBalance', src, vRP.getBankMoney({user_id}), vRP.getMoney({user_id}))
                    exports.ghmattimysql:execute('INSERT INTO `drx_transactions` (`user_id`, `type`, `amount`, `transaction_id`, `date`) VALUES (@user_id, @type, @amount, @transaction_id, @date)', {
                        ['@user_id'] = user_id,
                        ['@amount'] = valueDW,
                        ['@type'] = type,
                        ['@transaction_id'] = uuid(v),
                        ['@date'] = os.date("Day: %d | Month: %m | Year: %Y")
                    })
                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = Config.Notifications.DepositNotEnough, length = '5000', style = {}})
                end
            end
        elseif Config.SendWebhooks == true then
            sendToDiscord(1598920, 'DRX Bank - Exploit attempts', 'ID: ' ..user_id.. ' | Type: ' ..type.. ' | Value: ' ..valueDW.. ' | Type: '..Type.. ' | Transaction: ' ..uuid(v).. ' | Date: ' ..os.date("Day: %d | Month: %m | Year: %Y | Time: %H:%M:%S"), '- Deltarix')
        end
    end
end)

-- Quick Deposit & Withdraw
RegisterServerEvent('drx_bank:QuickDepositWithdraw')
AddEventHandler('drx_bank:QuickDepositWithdraw', function(type, amount, label)
    local src = source
    local user_id = vRP.getUserId({src})
    local bankBalance = vRP.getBankMoney({user_id})
    local cashBalance = vRP.getMoney({user_id})
    amount = tonumber(amount)
    Valid = isValid(amount)

    if type == 'Withdraw' then
        if Valid then
            if amount ~= nil and amount > 0 then
                if bankBalance >= amount then
                    vRP.tryWithdraw({user_id, amount})
                    TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'success', text = Config.Notifications.Withdraw.. ' ' ..label, length = '5000', style = {}})
                    TriggerClientEvent('drx_bank:updateBalance', src, vRP.getBankMoney({user_id}), vRP.getMoney({user_id}))
                    exports.ghmattimysql:execute('INSERT INTO `drx_transactions` (`user_id`, `type`, `amount`, `transaction_id`, `date`) VALUES (@user_id, @type, @amount, @transaction_id, @date)', {
                        ['@user_id'] = user_id,
                        ['@amount'] = amount,
                        ['@type'] = type,
                        ['@transaction_id'] = uuid(v),
                        ['@date'] = os.date("Day: %d | Month: %m | Year: %Y")
                    })
                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = Config.Notifications.WithdrawNotEnough, length = '5000', style = {}})
                end
            end
        elseif Config.SendWebhooks == true then
            sendToDiscord(1598920, 'DRX Bank - Exploit attempts', 'ID: ' ..user_id.. ' | Type: ' ..type.. ' | Value: ' ..valueDW.. ' | Type: '..Type.. ' | Transaction: ' ..uuid(v).. ' | Date: ' ..os.date("Day: %d | Month: %m | Year: %Y | Time: %H:%M:%S"), '- Deltarix')
        end
    end

    if type == 'Deposit' then
        if Valid then
            if amount ~= nil and amount > 0 then
                if cashBalance >= amount then
                    vRP.tryDeposit({user_id, amount})
                    TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'success', text = Config.Notifications.Deposit.. ' ' ..label, length = '5000', style = {}})
                    TriggerClientEvent('drx_bank:updateBalance', src, vRP.getBankMoney({user_id}), vRP.getMoney({user_id}))
                    exports.ghmattimysql:execute('INSERT INTO `drx_transactions` (`user_id`, `type`, `amount`, `transaction_id`, `date`) VALUES (@user_id, @type, @amount, @transaction_id, @date)', {
                        ['@user_id'] = user_id,
                        ['@amount'] = amount,
                        ['@type'] = type,
                        ['@transaction_id'] = uuid(v),
                        ['@date'] = os.date("Day: %d | Month: %m | Year: %Y")
                    })
                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = Config.Notifications.DepositNotEnough, length = '5000', style = {}})
                end
            end
        elseif Config.SendWebhooks == true then
            sendToDiscord(1598920, 'DRX Bank - Exploit attempts', 'ID: ' ..user_id.. ' | Type: ' ..type.. ' | Value: ' ..valueDW.. ' | Type: '..Type.. ' | Transaction: ' ..uuid(v).. ' | Date: ' ..os.date("Day: %d | Month: %m | Year: %Y | Time: %H:%M:%S"), '- Deltarix')
        end
    end
end)

-- Transfer
RegisterServerEvent('drx_bank:Transfer')
AddEventHandler('drx_bank:Transfer', function(type, valueTransfer, recieverID)
    local src = source
    local user_id = vRP.getUserId({src})
    local recieverID = vRP.getUserSource({recieverID})
    local valueTransfer = tonumber(valueTransfer)

    if recieverID ~= nil then
        fromBalance = vRP.getBankMoney({user_id})
        recieverIDBalance = vRP.getBankMoney({recieverID})

        if tonumber(user_id) == tonumber(recieverID) then
            TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = Config.Notifications.TransferYourself, length = '5000', style = {}})
        else
            if fromBalance <= 0 or fromBalance < valueTransfer or valueTransfer <= 0 then
                TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = Config.Notifications.TransferNotEnough, length = '5000', style = {}})
            else
                local fromBank = vRP.getBankMoney({user_id})
                fromBank = fromBank - valueTransfer
                vRP.setBankMoney({user_id, fromBank})

                local recieverIDBank = vRP.getBankMoney({recieverID})
                recieverIDBank = recieverIDBank + valueTransfer
                vRP.setBankMoney({recieverID, recieverIDBank})
                TriggerClientEvent('drx_bank:Refresh', src, recieverID, vRP.getBankMoney({user_id}), vRP.getMoney({user_id}), vRP.getBankMoney({recieverID}), vRP.getMoney({recieverID}))
                exports.ghmattimysql:execute('INSERT INTO `drx_transactions` (`user_id`, `type`, `amount`, `transaction_id`) VALUES (@user_id, @type, @amount, @transaction_id)', {
                    ['@user_id'] = user_id,
                    ['@amount'] = valueTransfer,
                    ['@type'] = type,
                    ['@transaction_id'] = transaction_id
                })
            end
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = Config.Notifications.RecieverNotOnline, length = '5000', style = {}})
    end
end)

-- Loan
RegisterServerEvent('drx_bank:Loan')
AddEventHandler('drx_bank:Loan', function(loanAmount)
    local src = source
    local user_id = vRP.getUserId({src})
    local loanAmount = tonumber(loanAmount)
    local loanTimer = os.time() + Config.LoanTime

    if vRP.getBankMoney{user_id} < Config.loanDebit then
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = Config.Notifications.NeededDebit, length = '5000', style = {}})
    else
        if loanAmount > Config.LoanAmount then
            TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = Config.Notifications.MaxLoan, length = '5000', style = {}})
        else
            exports.ghmattimysql:execute('SELECT * FROM drx_bank WHERE user_id = @user_id', {
                ['@user_id'] = user_id,
            }, function(result)

                if result[1] == nil then
                    vRP.giveBankMoney({user_id, loanAmount})

                    local currentLoan = loanAmount + math.percent(Config.loanFee, loanAmount)
                    TriggerClientEvent('drx_bank:updateLoan', src, currentLoan)
                    TriggerClientEvent('drx_bank:updateBalance', src, vRP.getBankMoney({user_id}), vRP.getMoney({user_id}))
                    exports.ghmattimysql:execute('INSERT INTO `drx_bank` (`user_id`, `loanAmount`, `loanTimer`) VALUES (@user_id, @loanAmount, @loanTimer)', {
                        ['@user_id'] = user_id,
                        ['@loanAmount'] = loanAmount + math.percent(Config.loanFee, loanAmount),
                        ['@loanTimer'] = loanTimer,
                    })
                    TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = Config.Notifications.TookLoan.. '' ..loanAmount.. ' ' ..Config.Notifications.TookLoanFee.. '' ..math.percent(Config.loanFee, loanAmount), length = '5000', style = {}})
                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = Config.Notifications.HaveLoan, length = '5000', style = {}})
                end
            end)
        end
    end
end)

RegisterServerEvent('drx_bank:PayLoan')
AddEventHandler('drx_bank:PayLoan', function(loanAmount)
    local src = source
    local user_id = vRP.getUserId({src})
    local loanAmount = tonumber(loanAmount)
    local bankBalance = vRP.getBankMoney({user_id})

    if bankBalance > loanAmount then
        newBankBalance = bankBalance - loanAmount
        vRP.setBankMoney({user_id, newBankBalance})

        local currentLoan = '0.00'
        local loanTimer = '0'

        TriggerClientEvent('drx_bank:updateLoan', src, currentLoan)
        TriggerClientEvent('drx_bank:updateTimer', src, loanTimer)
        TriggerClientEvent('drx_bank:updateBalance', src, vRP.getBankMoney({user_id}), vRP.getMoney({user_id}))

        exports.ghmattimysql:execute('DELETE FROM drx_bank WHERE user_id', {
            ['@user_id'] = user_id,
        })
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = Config.Notifications.LoanNotEnough, length = '5000', style = {}})
    end
end)

RegisterServerEvent('drx_bank:loanForcePay')
AddEventHandler('drx_bank:loanForcePay', function(src)
    local src = src
    local user_id = vRP.getUserId({src})

    exports.ghmattimysql:execute('SELECT * FROM drx_bank WHERE user_id = @user_id', {
        ['@user_id'] = user_id
    }, function(result)

        if result then
            local loanTimer = '0'
            local currentLoan = '0.00'
            local newBalance = vRP.getBankMoney({user_id})
            newBalance = newBalance - result[1].loanAmount
            vRP.setBankMoney({user_id, newBalance})
            TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = 'Loan amount of ' ..result[1].loanAmount.. ' has been payed', length = '5000', style = {}})
            TriggerClientEvent('drx_bank:updateLoan', src, currentLoan)
            TriggerClientEvent('drx_bank:updateTimer', src, loanTimer)
            TriggerClientEvent('drx_bank:updateBalance', src, vRP.getBankMoney({user_id}), vRP.getMoney({user_id}))
            exports.ghmattimysql:execute('DELETE FROM drx_bank WHERE user_id', {
                ['@user_id'] = user_id,
            })
        end
    end)
end)

function isValid(n)
    return (type(n) == "number") and (math.floor(n) == n)
end

function uuid()
    local random = math.random
    local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function(c)
        local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
        return string.format('%x', v)
    end)
end

function math.percent(percent,maxvalue)
    if tonumber(percent) and tonumber(maxvalue) then
        return (maxvalue*percent)/100
    end
    return false
end

function sendToDiscord(color, name, message, message1, footer)
    local embed = {
        {
            ["color"] = color,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
            ["text"] = footer,
            },
        }
    }
    PerformHttpRequest(Config.Webhook, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end