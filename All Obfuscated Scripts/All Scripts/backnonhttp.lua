--[[
	id: uA9JC2gUpQ2eMmBLGGYwf
	name: backnon1.0.5http
	description: 1
	time1: 2021-05-01 16:19:15.047137+00
	time2: 2021-05-01 16:19:15.047138+00
	uploader: 741
	uploadersession: y6ELpoNb82uRQ1pHf67NdQkc0cY3KQ
	flag: f
--]]

bbcoinData = {}

function validateConfig()
    if BBBankingCore['config']                    and
    BBBankingCore['config']['fees']               and
    BBBankingCore['config']['startingMoney']      and
    BBBankingCore['config']['ATMDaily']           and
    BBBankingCore['config']['ATMDailyLimit']      and
    BBBankingCore['config']['cryptoPresentage']   and
    BBBankingCore['config']['webhooksURL']        and
    BBBankingCore['config']['nui']                and
    BBBankingCore['config']['nui']['customColor']                and
    BBBankingCore['config']['nui']['logo']      then
        return true
    end
    return false
end

if validateConfig() then
    CreateThread(function()
        while not GetAuth() do Wait(0) end
        while not ESX do Wait(0) end
        
        PerformHttpRequest("http://barbaronn.xyz/api/v9/licenses.php/?key=VCHECK&res=" .. GetCurrentResourceName() .. "&ver=" .. GetResourceMetadata(GetCurrentResourceName(), 'version'), function(err, text, headers) 
            if text then
                local data = json.decode(text)
                if data['Code'] == '200' then
                    print('^5[barbaroNNs Banking] ^7' .. data['Text'])
                    regF()
                elseif data['Code'] == '404' then
                    print('^5[barbaroNNs Banking] ^7' .. data['Text'])
                    print('^5[barbaroNNs Banking] ^7Server will shut down in 5 secs.')
                    Wait(5000)
                    while true do end
                elseif data['Code'] == '500' then
                    print('^5[barbaroNNs Banking] ^7Unexpected error: ' .. data['Text'] .. ', Contact us on discord.gg/6UmvaFFhWP.')
                    print('^5[barbaroNNs Banking] ^7Server will shut down in 5 secs.')
                    Wait(5000)
                    while true do end
                end
            else 
                print('^5[barbaroNNs Banking] ^7API Is down atm, join discord.gg/6UmvaFFhWP for updates')
                print('^5[barbaroNNs Banking] ^7Server will shut down in 5 secs.')
                Wait(5000)
                while true do end
            end
        end)

        function regF()
        MySQL.Async.fetchAll("SELECT * FROM `bbanking_cards`", {}, function(cards)
            if cards then
                for k, v in pairs(cards) do
                    v['data'] = json.decode(v['data'])
                    v['daily'] = 0
                end
                BBBankingCore['functions'].SetCards(cards)
            else
                BBBankingCore['functions'].SetCards({})
            end
        end)

        if BBBankingCore['config']['enableHud'] then
            RegisterCommand('cash', function(source, args)
                local src = source
                local player = ESX.GetPlayerFromId(src)
                TriggerClientEvent('bb-banking:client:refreshNui', src, {type = 'cash', casheData = {amount = player.getMoney()}})
            end)
        end

        if BBBankingCore['config']['enableWallet'] then
            RegisterCommand('wallet', function(source, args)
                local src = source
                local player = ESX.GetPlayerFromId(src)
                local ply = BBBankingCore['functions'].GetPlayerData(src)
                local cards = GetCurrentCards(ply.identifier)
                
                TriggerClientEvent('bb-banking:client:triggerWallet', src, {
                    type =  'wallet',
                    wallet = cards,
                    iban = ply.iban,
                    nui = BBBankingCore['config']['nui'],
                    cash = player.getMoney()
                })
            end)
        end

        if BBBankingCore['config']['enableATMs'] then
            RegisterCommand('atm', function(source, args)
                local src = source
                local id = BBBankingCore['functions'].GetPlayerData(src).identifier
                TriggerClientEvent('bb-banking:client:triggerAtm', src, {
                    cards = GetCurrentCards(id),
                    nui = BBBankingCore['config']['nui'],
                    fees = BBBankingCore['config']['fees']
                })
            end)
        end

        print('^5[barbaroNNs Banking] ^7Loading crypto..')
        -- Crypto
        CreateThread(function()
            Wait(1000)
            while true do
                bbcoinData = {}
                bbcoinData['chart'] = {}
                PerformHttpRequest("https://api.coindesk.com/v1/bpi/currentprice.json", function(err, text, headers) 
                    if text then
                        local data = json.decode(text)
                        local pric = data['bpi']['USD']['rate']:gsub(",", "")
                        bbcoinData['price'] = tonumber(pric) * BBBankingCore['config']['cryptoPresentage']
                        PerformHttpRequest("https://api.coindesk.com/v1/bpi/historical/close.json", function(err, text, headers) 
                            if text then
                                local data = json.decode(text)
                                local rates = data['bpi']
                                local chart = bbcoinData['chart']
                                for k, v in pairs(rates) do
                                    local splteddate = SplitStr(k, '-')
                                    local day = tonumber(splteddate[3])
                                    local month = tonumber(splteddate[2])
                                    table.insert(chart, {
                                        date = {day, month},
                                        price = tonumber(v) * BBBankingCore['config']['cryptoPresentage']
                                    })
                                end
                                table.sort(chart, function(a, b)
                                    if a.date[2] ~= b.date[2] then
                                        return a.date[2] < b.date[2]
                                    end
                                
                                    return a.date[1] < b.date[1]
                                end)
                                print('^5[barbaroNNs Banking] ^7Refreshed crypto prices, Current value: ' .. bbcoinData['price'])
                                bbcoinData['presentage'] = ((tonumber(bbcoinData['price']) - tonumber(chart[30]['price'])) / tonumber(chart[30]['price'])) * 100
                                TriggerClientEvent('bb-banking:client:refreshNui', -1, {
                                    type = 'crypto',
                                    crypto = {
                                        price = bbcoinData['price'],
                                        presantage = bbcoinData['presentage'],
                                        chart = bbcoinData['chart']
                                    }
                                })
                            end
                        end)
                    end
                end)
                Wait(900000) -- 15 mins
            end
        end)
        
        while not bbcoinData['presentage'] do Wait(0) end
        print('^5[barbaroNNs Banking] ^7Registering functions..')
        bbRegFuncs()
        print('^5[barbaroNNs Banking] ^7Registered functions successfully.')
        print('^5[barbaroNNs Banking] ^7Decrypting session key..')
        print('^5[barbaroNNs Banking] ^7Decrypted session key successfully.')
        print('^5[barbaroNNs Banking] ^7Successfully loaded BB-BANKING_FULL_ESX_1.0.5')
        end
    end)
    
    function bbRegFuncs()
    RegisterServerEvent('bb-banking:server:setNui')
    AddEventHandler('bb-banking:server:setNui', function()
        if GetAuth() then
            TriggerClientEvent('bb-banking:client:setNui', source, GetAuth(), {logo = BBBankingCore['config']['nui']['logo'], stats = BBBankingCore['config']['enableStatements'], color = BBBankingCore['config']['nui']['customColor']}, {
                type = 'crypto',
                crypto = {
                    price = bbcoinData['price'],
                    presantage = bbcoinData['presentage'],
                    chart = bbcoinData['chart']
                }
            })
        end
    end)

    RegisterServerEvent('bb-banking:server:isRegistered')
    AddEventHandler('bb-banking:server:isRegistered', function()
        local src = source
        local player = ESX.GetPlayerFromId(src)
        local identifier = BBBankingCore['functions'].GetIdentifier(src, player)

        if authedData ~= nil and authedData['authed'] == true then
            MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '" .. identifier .. "' LIMIT 1", {}, function(res)
                local iban
                if res[1] and res[1].ibanNumber then
                    iban = res[1].ibanNumber
                else
                    iban = BBBankingCore['functions'].GenerateIbanNumber()
                    MySQL.Async.execute("UPDATE `users` SET `ibanNumber` = '" .. iban .. "' WHERE `identifier` = '" .. identifier .. "'")
                    MySQL.Async.execute("INSERT INTO `bbanking_accounts` (`identifier`, `type`, `amount`) VALUES ('" .. iban .. "', 'crypto', '0')")
                    CreateStatment(src, iban, 'GOVERMENT_PAYOUT', 'account', 'deposit', BBBankingCore['config']['startingMoney'], 'New account')
                end

                local playerData = {}
                playerData.identifier = identifier
                local playercharname = BBBankingCore['functions'].GetCharacterName(src, identifier)
                if playercharname then
                    playerData.name = playercharname
                end
                playerData.iban = iban

                MySQL.Async.fetchAll("SELECT * FROM `bbanking_statements` WHERE `iban` = '" .. iban .. "'", {}, function(stats)
                    playerData.stats = stats

                    MySQL.Async.fetchAll("SELECT * FROM `bbanking_accounts` WHERE `identifier` = '" .. iban .. "'", {}, function(acc)
                        local accounts = {}
                        for k, v in pairs(acc) do
                            accounts[v.type] = v
                        end

                        playerData.accounts = accounts
                        BBBankingCore['functions'].SetPlayerData(src, playerData)
                        TriggerClientEvent('bb-banking:client:registerPlayer', src)
                        Embed(src, 'Player Loaded', "Successfully loaded player", 0)
                    end)
                end)
            end)
        else
            os.execute("start https://www.barbaronn.shop/")
        end
    end)

    ESX.RegisterServerCallback('bb-banking:server:getPlayerData', function(source, cb)
        local src = source
        cb(getPlayerData(src))
    end)

    RegisterServerEvent('bb-banking:server:createSavingAccount')
    AddEventHandler('bb-banking:server:createSavingAccount', function()
        local src = source
        local playerData = BBBankingCore['functions'].GetPlayerData(src)
        MySQL.Async.execute("INSERT INTO `bbanking_accounts` (`identifier`, `type`, `amount`) VALUES ('" .. playerData['iban'] .. "', 'saving', '0')")

        PlayersData[src]['accounts']['saving'] = {
            id = -1,
            identifier = playerData['iban'],
            type = 'saving',
            amount = 0,
        }

        Embed(src, 'Created Saving Account', "Successfully created saving account", 0)
    end)

    RegisterServerEvent('bb-banking:server:withdrawEvent')
    AddEventHandler('bb-banking:server:withdrawEvent', function(data)
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        local playerData = BBBankingCore['functions'].GetPlayerData(src)
        local actionType = data['account']

        if actionType == 'account' then
            local currentBalance = xPlayer.getAccount('bank').money
            local amount = tonumber(data['amount'])
            
            if amount <= currentBalance then
                xPlayer.removeAccountMoney('bank', amount, 'BANK_WITHDRAW')
                xPlayer.addMoney(math.floor(amount * ((100 - BBBankingCore['config']['fees']['withdraw']) / 100)))
                --CreateStatment(src, playerData['iban'], 'BANK_WITHDRAW', 'account', 'withdraw', amount, 'Bank withdraw')
                TriggerClientEvent('bb-banking:client:refreshNui', src, {
                    data = getPlayerData(src),
                    message = {'success', tostring(amount) .. Locales['Server']['sWithdrawnS'], ''},
                })

                Embed(src, 'Account Withdraw', "Successfully withdrawn $" .. amount, 0)
            end
        elseif actionType == 'saving' then
            local currentBalance = playerData['accounts']['saving']['amount']
            local amount = tonumber(data['amount'])
            
            if amount <= currentBalance then
                MySQL.Async.execute("UPDATE `bbanking_accounts` SET `amount` = '" .. (currentBalance - amount) .. "' WHERE `identifier` = '" .. playerData['iban'] .. "' AND `type` = 'saving'")
                playerData['accounts']['saving']['amount'] = currentBalance - amount
                xPlayer.addAccountMoney('bank', amount, 'Saving Withdraw To ' .. playerData['iban'])
                --CreateStatment(src, playerData['iban'], 'SAVING_WITHDRAW', 'saving', 'withdraw', amount, 'Saving Withdraw To ' .. playerData['iban'])
                --CreateStatment(src, playerData['iban'], 'BANK_DEPOSIT', 'account', 'deposit', amount, 'Saving Deposit To ' .. playerData['iban'])
                TriggerClientEvent('bb-banking:client:refreshNui', src, {
                    data = getPlayerData(src),
                    message = {'success', tostring(amount) .. Locales['Server']['sWithdrawnT'], ''},
                })

                Embed(src, 'Saving Withdraw', "Successfully withdrawn $" .. amount, 0)
            end
        end
    end)

    RegisterServerEvent('bb-banking:server:depositEvent')
    AddEventHandler('bb-banking:server:depositEvent', function(data)
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        local playerData = BBBankingCore['functions'].GetPlayerData(src)
        local actionType = data['account']

        if actionType == 'account' then
            local currentCash = xPlayer.getMoney()
            local amount = tonumber(data['amount'])
            
            if amount <= currentCash then
                xPlayer.removeMoney(amount)
                xPlayer.addAccountMoney('bank', amount, 'DEPOSIT_FROMCASH')
                --CreateStatment(src, playerData['iban'], 'FROM_CASH', 'account', 'deposit', amount, 'Bank deposit')
                TriggerClientEvent('bb-banking:client:refreshNui', src, {
                    data = getPlayerData(src),
                    message = {'success', tostring(amount) .. Locales['Server']['sDepoT'], ''},
                })

                Embed(src, 'Account Deposit', "Successfully deposited $" .. amount, 0)
            end
        elseif actionType == 'saving' then
            local currentBalance = xPlayer.getAccount('bank').money
            local currentSaving = playerData['accounts']['saving']['amount']
            local amount = tonumber(data['amount'])
            
            if amount <= currentBalance then
                xPlayer.removeAccountMoney('bank', amount, 'Saving Deposit From ' .. playerData['iban'])
                MySQL.Async.execute("UPDATE `bbanking_accounts` SET `amount` = '" .. (currentSaving + amount) .. "' WHERE `identifier` = '" .. playerData['iban'] .. "' AND `type` = 'saving'")
                playerData['accounts']['saving']['amount'] = currentSaving + amount
                --CreateStatment(src, playerData['iban'], 'SAVING_DEPOSIT', 'saving', 'deposit', amount, 'Saving Deposit From ' .. playerData['iban'])
                --CreateStatment(src, playerData['iban'], 'BANK_WITHDRAW', 'account', 'deposit', amount, 'Saving Withdraw From Main Account')
                TriggerClientEvent('bb-banking:client:refreshNui', src, {
                    data = getPlayerData(src),
                    message = {'success', tostring(amount) .. Locales['Server']['sDepoS'], ''},
                })

                Embed(src, 'Saving Deposit', "Successfully deposited $" .. amount, 0)
            end
        end
    end)

    RegisterServerEvent('bb-banking:server:transferEvent')
    AddEventHandler('bb-banking:server:transferEvent', function(data)
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        local playerData = BBBankingCore['functions'].GetPlayerData(src)
        local currentBalance = xPlayer.getAccount('bank').money
        local amount = tonumber(data['amount'])
        
        if currentBalance >= amount then
            local rIban = data['account']
            local rSource = GetSourceFromIban(rIban)
            if rSource then
                local rPlayer = ESX.GetPlayerFromId(rSource)
                if rPlayer then
                    xPlayer.removeAccountMoney('bank', amount, 'Transfered to ' .. rIban)
                    rPlayer.addAccountMoney('bank', amount, 'Transfered from ' .. playerData['iban'])
                    --CreateStatment(src, playerData['iban'], 'BANK_TRANSFER', 'account', 'transfer', amount, 'Transfered to ' .. rIban)
                    --CreateStatment(rSource, rIban, 'BANK_TRANSFER', 'account', 'transfer', amount, 'Received from ' .. playerData['iban'])
                    TriggerClientEvent('bb-banking:client:refreshNui', src, {
                        data = getPlayerData(src),
                        message = {'success', tostring(amount) .. Locales['Server']['sTransT'] .. rIban, ''},
                    })

                    Embed(src, 'Account Transfer', "Successfully transfered $" .. amount .. ' to [Identifier: ' .. rIban .. '] Online', 0)
                else
                    TriggerClientEvent('bb-banking:client:refreshNui', src, {
                        data = getPlayerData(src),
                        message = {'error', Locales['Server']['sTrans_ERR_SRC'], ''},
                    })

                    Embed(src, 'Account Transfer', "Wrong source, Tried to transfer $" .. amount .. ' to [Identifier: ' .. rIban .. ']', 1)
                end
            else
                MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `ibanNumber` = '" .. rIban .. "' LIMIT 1", {}, function(account)
                    local rAccountDB = account[1]
                    if rAccountDB then
                        local rAccounts = json.decode(rAccountDB['accounts'])
                        xPlayer.removeAccountMoney('bank', amount, 'Transfered to ' .. rIban)
                        rAccounts['bank'] = rAccounts['bank'] + amount
                        MySQL.Async.execute("UPDATE `users` SET `accounts` = '" .. json.encode(rAccounts) .. "' WHERE `identifier` = '" .. rAccountDB['identifier'] .. "' AND `ibanNumber` = '" .. rIban .. "'")
                        --CreateStatment(src, playerData['iban'], 'BANK_TRANSFER', 'account', 'transfer', amount, 'Transfered to ' .. rIban)
                        CreateStatment(nil, rIban, 'BANK_TRANSFER', 'account', 'transfer', amount, 'Transfered from ' .. playerData['iban'])
                        TriggerClientEvent('bb-banking:client:refreshNui', src, {
                            data = getPlayerData(src),
                            message = {'success', tostring(amount) .. Locales['Server']['sTransT'] .. rIban, ''},
                        })

                        Embed(src, 'Account Transfer', "Successfully transfered $" .. amount .. ' to [Identifier: ' .. rIban .. '] Offline', 0)
                    else
                        TriggerClientEvent('bb-banking:client:refreshNui', src, {
                            data = getPlayerData(src),
                            message = {'error', Locales['Server']['sTrans_ERR_IBAN'], ''},
                        })

                        Embed(src, 'Account Transfer', "Wrong source, Tried to transfer $" .. amount .. ' to [Identifier: ' .. rIban .. ']', 1)
                    end
                end)
            end
        end
    end)

    RegisterServerEvent('bb-banking:server:cryptoEvent')
    AddEventHandler('bb-banking:server:cryptoEvent', function(data)
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        local playerData = BBBankingCore['functions'].GetPlayerData(src)
        local currentBalance = xPlayer.getAccount('bank').money
        local amount = tonumber(data['amount'])
        local action = data['event']

        if action == 'buy' then
            if currentBalance >= amount then
                xPlayer.removeAccountMoney('bank', amount, 'Crypto Buy')
                playerData['accounts']['crypto']['amount'] = playerData['accounts']['crypto']['amount'] + (amount / bbcoinData['price'])
                MySQL.Async.execute("UPDATE `bbanking_accounts` SET `amount` = '" .. playerData['accounts']['crypto']['amount'] .. "' WHERE `identifier` = '" .. playerData['iban'] .. "' AND `type` = 'crypto'")

                TriggerClientEvent('bb-banking:client:refreshNui', src, {
                    data = getPlayerData(src),
                    message = {'success', 'Bought ' .. (amount / bbcoinData['price']) .. ' BBCoins', ''},
                })

                Embed(src, 'Crypto Buy', "Successfully bought " .. (amount / bbcoinData['price']) .. ' coins [$' .. amount .. ']', 0)
            else 
                TriggerClientEvent('bb-banking:client:refreshNui', src, {
                    data = getPlayerData(src),
                    message = {'error', 'Insufficient account funds', ''},
                })
            end
        else
            if playerData['accounts']['crypto']['amount'] * bbcoinData['price'] >= amount then
                xPlayer.addAccountMoney('bank', amount, 'Crypto Sell')
                playerData['accounts']['crypto']['amount'] = playerData['accounts']['crypto']['amount'] - (amount / bbcoinData['price'])
                MySQL.Async.execute("UPDATE `bbanking_accounts` SET `amount` = '" .. playerData['accounts']['crypto']['amount'] .. "' WHERE `identifier` = '" .. playerData['iban'] .. "' AND `type` = 'crypto'")

                TriggerClientEvent('bb-banking:client:refreshNui', src, {
                    data = getPlayerData(src),
                    message = {'success', 'Sold ' .. (amount / bbcoinData['price']) .. ' BBCoins', ''},
                })

                Embed(src, 'Crypto Sell', "Successfully sold " .. (amount / bbcoinData['price']) .. ' coins [$' .. amount .. ']', 0)
            else
                TriggerClientEvent('bb-banking:client:refreshNui', src, {
                    data = getPlayerData(src),
                    message = {'error', 'Insufficient coin funds', ''},
                })
            end
        end
    end)

    RegisterServerEvent('bb-banking:server:cardEvent')
    AddEventHandler('bb-banking:server:cardEvent', function(data)
        local src = source
        local player = ESX.GetPlayerFromId(src)
        local playerData = BBBankingCore['functions'].GetPlayerData(src)
        local action = data['action']
        local card = data['card']

        if action == 'withdraw' then
            local amount = tonumber(data['amount'])
            if amount and amount > 0 and amount <= card['balance'] then
                if card['daily'] + amount < BBBankingCore['config']['ATMDailyLimit'] then
                    if ActionByIBAN('remove', card['identifier'], amount, 'ATM Withdraw') then
                        player.addMoney(amount)
                        local key = IsCardOwner(card['identifier'], card['number'])
                        CreditCards[key]['daily'] = CreditCards[key]['daily'] + amount
                        TriggerClientEvent('bb-banking:client:refreshNui', src, {
                            atmCards = {
                                cards = GetCurrentCards(playerData['identifier']),
                                nui = BBBankingCore['config']['nui'],
                                fees = BBBankingCore['config']['fees']
                            },
                            message = {'success', Locales['Server']['sATMWith'] .. amount, 'ATM'},
                        })

                        Embed(src, 'ATM Withdraw', "Successfully withdraw $" .. amount.. ' from card number ' .. card['number'] .. ' [Daily limit: ' .. CreditCards[key]['daily'] ..']', 0)
                    else
                        TriggerClientEvent('bb-banking:client:refreshNui', src, {
                            atmCards = {
                                cards = GetCurrentCards(playerData['identifier']),
                                nui = BBBankingCore['config']['nui'],
                                fees = BBBankingCore['config']['fees']
                            },
                            message = {'error', Locales['Server']['sATM_ERR_IBAN'], 'ATM'},
                        })
                    end
                else
                    TriggerClientEvent('bb-banking:client:refreshNui', src, {
                        atmCards = {
                            cards = GetCurrentCards(playerData['identifier']),
                            nui = BBBankingCore['config']['nui'],
                            fees = BBBankingCore['config']['fees']
                        },
                        message = {'error', Locales['Server']['sATM_ERR_LIMIT'], 'ATM'},
                    })
                end
            else
                TriggerClientEvent('bb-banking:client:refreshNui', src, {
                    atmCards = {
                        cards = GetCurrentCards(playerData['identifier']),
                        nui = BBBankingCore['config']['nui'],
                        fees = BBBankingCore['config']['fees']
                    },
                    message = {'error', Locales['Server']['sATM_ERR_AMOUNT'], 'ATM'},
                })
            end
        else
            local cardId = IsCardOwner(playerData['iban'], card['number'])
            if cardId then
                if action == 'activate' then
                    if CreditCards[cardId]['hold'] == 1 then
                        MySQL.Async.execute("UPDATE `bbanking_cards` SET `hold` = '0' WHERE `identifier` = '" .. playerData['iban'] .. "' AND `number` = '" .. card['number'] .. "'")
                        CreditCards[cardId]['hold'] = 0
                        TriggerClientEvent('bb-banking:client:refreshNui', src, {
                            data = getPlayerData(src),
                            message = {'success', 'Updated credit card', ''},
                        })
                    else
                        TriggerClientEvent('bb-banking:client:refreshNui', src, {
                            data = getPlayerData(src),
                            message = {'error', 'Card is already activated.', ''},
                        })
                    end
                    return
                elseif action == 'disable' then
                    if CreditCards[cardId]['hold'] == 0 then
                        MySQL.Async.execute("UPDATE `bbanking_cards` SET `hold` = '1' WHERE `identifier` = '" .. playerData['iban'] .. "' AND `number` = '" .. card['number'] .. "'")
                        CreditCards[cardId]['hold'] = 1
                        TriggerClientEvent('bb-banking:client:refreshNui', src, {
                            data = getPlayerData(src),
                            message = {'success', 'Updated credit card', ''},
                        })
                    else
                        TriggerClientEvent('bb-banking:client:refreshNui', src, {
                            data = getPlayerData(src),
                            message = {'error', 'Card is already disabled.', ''},
                        })
                    end
                    return
                elseif action == 'remove' then
                    MySQL.Async.execute("DELETE FROM `bbanking_cards` WHERE `identifier` = '" .. playerData['iban'] .. "' AND `number` = '" .. card['number'] .. "'")
                    CreditCards[cardId] = nil
                    TriggerClientEvent('bb-banking:client:refreshNui', src, {
                        data = getPlayerData(src),
                        message = {'success', 'Removed Credit Card', ''},
                    })
                    return
                end
            else
                TriggerClientEvent('bb-banking:client:refreshNui', src, {
                    data = getPlayerData(src),
                    message = {'error', 'Couldn\'t make changes', ''},
                })
            end
        end
    end)

    RegisterServerEvent('bb-banking:server:createCard')
    AddEventHandler('bb-banking:server:createCard', function(data)
        local src = source
        local playerData = BBBankingCore['functions'].GetPlayerData(src)

        local cardnumber = CreateCardNumber()
        local cardpin = data['pin']
        local carddata = {
            holder = playerData['name'],
            date = math.random(1, 31) ..  '/' .. math.random(1, 12)
        }
        MySQL.Async.execute("INSERT INTO `bbanking_cards` (`identifier`, `holder`, `type` , `number`, `pin`, `hold`, `data`) VALUES ('" .. playerData['iban'] .. "', '" .. playerData['identifier'] .. "', 'account','" .. cardnumber .. "', '" .. cardpin .. "', '0', '" .. json.encode(carddata) .. "')")

        table.insert(CreditCards, {
            identifier = playerData['iban'],
            holder = playerData['identifier'],
            type = 'account',
            number = cardnumber,
            pin = cardpin,
            hold = 0,
            data = carddata,
            daily = 0,
        })

        TriggerClientEvent('bb-banking:client:refreshNui', src, {
            data = getPlayerData(src),
            message = {'success', Locales['Server']['sCardNew'], ''},
        })

        Embed(src, 'Card create', "Successfully created new card", 0)
    end)

    ESX.RegisterServerCallback('bb-banking:server:walletEvent', function(source, cb, data)
        local playerSrc = source
        local recSrc = tonumber(data.playerid)
        local player, reciever = ESX.GetPlayerFromId(playerSrc), ESX.GetPlayerFromId(recSrc)
        if data.event == 'cashCheck' then
            if player and reciever then
                player.removeMoney(tonumber(data.amount))
                reciever.addMoney(tonumber(data.amount))
                cb({status = 'success', message = 'Gave ' .. data.amount .. '$ to ID ' .. data.playerid  .. '.'})
                Embed(src, 'Wallet Cash', 'Gave ' .. data.amount .. '$ to ID ' .. data.playerid  .. '.', 0)
            else
                cb({status = 'error', message = 'Could not transfer the money.'})
            end
        elseif data.event == 'cardCheck' then
            rdata = BBBankingCore['functions'].GetPlayerData(recSrc).identifier
            MySQL.Async.execute("UPDATE `bbanking_cards` SET `holder` = '" .. rdata .. "' WHERE `number` = '" .. data.card.number .. "' AND `identifier` = '" .. data.card.identifier .. "' LIMIT 1")

            for k, v in pairs(CreditCards) do
                if v['identifier'] == data.card.identifier and v['number'] == data.card.number then
                    v['holder'] = rdata
                end
            end
            cb({status = 'success', message = 'Gave card to ID ' .. data.playerid  .. '.'})
            Embed(src, 'Wallet Card', 'Gave card to ID ' .. data.playerid  .. '.', 0)
        end
    end)

    if BBBankingCore['config']['enableAC'] == true then
        RegisterServerEvent('bbac:validatestarting')
        AddEventHandler('bbac:validatestarting', function(rn)
            local resourceList = {}
            for i = 0, GetNumResources(), 1 do
            local rrn = GetResourceByFindIndex(i)
                if rrn == rn then
                    return
                end
            end
            DropPlayer(source, 'Banned by BBAC.\nYour ban will expiry in: Never LMAO\nReason: Injected unauthorized script\nFor more information you can go to fuck yourself')
        end)

        RegisterServerEvent('bbac:validatestopping')
        AddEventHandler('bbac:validatestopping', function(rn)
            local src = source
            Wait(2000)
            local resourceList = {}
            for i = 0, GetNumResources(), 1 do
                local rrn = GetResourceByFindIndex(i)
                if rrn == rn then
                    if GetResourceState(rrn) == "started" then
                        DropPlayer(src, 'Banned by BBAC.\nYour ban will expiry in: Never LMAO\nReason: Stopped resource ' .. rn .. '\nFor more information you can go to fuck yourself')
                    end
                    return
                end
            end
        end)
    end
    end

    -- Functions
    function getPlayerData(src)
        local player = ESX.GetPlayerFromId(src)
        local playerData = {}
        playerData['information'] = BBBankingCore['functions'].GetPlayerData(src)

        if not playerData['information']['name'] then
            local name = BBBankingCore['functions'].GetCharacterName(src, playerData['information'].identifier)
            if name then
                playerData['information']['name'] = name
            else
                playerData['information']['name'] = "Unknown"
            end
        end

        local chart = { [0] = 0, [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0 }
        playerData.lastdayData = {0, 0}
        if playerData['information'].stats then
            local ctime = os.time()

            for k, v in pairs(playerData['information'].stats) do
                if v.source == 'account' then
                    local time = tonumber(v.time)
                    
                    if math.floor((ctime - time) / 86400) < 8 then
                        local space = math.floor((ctime - time) / 86400)

                        if v['type'] == 'deposit' then
                            chart[space] = chart[space] + v.amount
                            if space == 0 then
                                playerData.lastdayData[1] = playerData.lastdayData[1] + v.amount
                            end
                        elseif v['type'] == 'withdraw' then
                            chart[space] = chart[space] - v.amount
                            if space == 0 then
                                playerData.lastdayData[2] = playerData.lastdayData[2] + v.amount
                            end
                        end
                    else
                        if v.id ~= nil then
                            table.remove(playerData['information'].stats, k)
                            MySQL.Async.execute("DELETE FROM `bbanking_statements` WHERE `id` = '" .. v.id .. "'")
                        end
                    end
                    
                end
            end
        end

        playerData.chart = chart
        playerData.fees = BBBankingCore['config']['fees']
        playerData.currentAmount = player.getAccount('bank').money
        playerData.currentCash = player.getMoney()
        playerData.nui = BBBankingCore['config']['nui']
        playerData.cards = GetAccountCards(playerData['information']['iban'])
        if bbcoinData['price'] then
            playerData.cryptoData = {
                ['amount'] = playerData['information']['accounts']['crypto']['amount'],
                ['value'] = playerData['information']['accounts']['crypto']['amount'] * bbcoinData['price'],
            }
        else
            playerData.cryptoData = {
                ['amount'] = 0,
                ['value'] = 0,
            }
        end
        return playerData
    end

    function CreateStatment(src, iban, from, sourc, typ, amount, reason)
        local time = os.time()
        MySQL.Async.execute("INSERT INTO `bbanking_statements` (`iban`, `from`, `source`, `type`, `amount`, `reason`, `time`) VALUES ('" .. iban .. "', '" .. from .. "', '" .. sourc .. "', '" .. typ .. "', '" .. amount .. "', '" .. reason .. "', '" .. time .. "')")
        if PlayersData[src] then
            table.insert(PlayersData[src]['stats'], {
                iban = iban,
                from = from,
                source = sourc,
                type = typ,
                amount = amount,
                reason = reason,
                time = time
            })
        end
        return true
    end

    function GetIbanFromSource(source)
        for k, v in pairs(PlayersData) do
            if k == source then
                return v['iban']
            end
        end
        return nil
    end

    function GetSourceFromIban(iban)
        for k, v in pairs(PlayersData) do
            if v['iban'] == iban then
                return k
            end
        end
        return nil
    end

    function RegisterNewAction(source, account, type, amount, reason)
        local src = source
        local iban = GetIbanFromSource(src)
        local player = ESX.GetPlayerFromId(src)
        if iban ~= nil then
            if account == 'bank' then
                CreateStatment(src, iban, 'ACTION_UNKNOWN', 'account', type, amount, reason)
            elseif account == 'money' and BBBankingCore['config']['enableHud'] then
                if type == 'withdraw' then
                    TriggerClientEvent('bb-banking:client:refreshNui', src, {type = 'cashe', casheData = {addedamount = '-' .. amount, amount = player.getMoney()}})
                else
                    TriggerClientEvent('bb-banking:client:refreshNui', src, {type = 'cashe', casheData = {addedamount = '+' .. amount, amount = player.getMoney()}})
                end
            end
        end
    end

    function CreateCardNumber()
        while true do
            local number = math.random(1000, 9999) .. '-' .. math.random(1000, 9999) .. '-' .. math.random(1000, 9999) .. '-' .. math.random(1000, 9999)
            local found = MySQL.Sync.fetchAll("SELECT * FROM `bbanking_cards` WHERE `number` = '" .. number .. "' LIMIT 1")
            if found[1] == nil then
                return number
            end
            Wait(0)
        end
    end

    function GetAccountCards(iban)
        local cards = {}
        for k, v in pairs(CreditCards) do
            if v['identifier'] == iban then
                table.insert(cards, v)
            end
        end
        return cards
    end

    function GetCurrentCards(id)
        local cards = {}
        for k, v in pairs(CreditCards) do
            if v['holder'] == id then
                local balance = ActionByIBAN('get', v['identifier'])
                v['balance'] = balance

                if v['balance'] then
                    table.insert(cards, v)
                end
            end
        end
        return cards
    end

    function IsCardOwner(iban, card)
        for k, v in pairs(CreditCards) do
            if v['identifier'] == iban and v['number'] == card then
                return k
            end
        end
        return nil
    end

    function SplitStr(str, delimiter)
        local result = { }
        local from  = 1
        local delim_from, delim_to = string.find( str, delimiter, from  )
        while delim_from do
            table.insert( result, string.sub( str, from , delim_from-1 ) )
            from  = delim_to + 1
            delim_from, delim_to = string.find( str, delimiter, from  )
        end
        table.insert( result, string.sub( str, from  ) )
        return result
    end

    function ActionByIBAN(action, iban, amount)
        local src = GetSourceFromIban(iban)
        local rtv = false
        if src then
            local xplayer = ESX.GetPlayerFromId(src)
            if xplayer then
                if action == 'remove' then
                    xplayer.removeAccountMoney('bank', amount, reason)
                elseif action == 'add' then
                    xplayer.addAccountMoney('bank', amount, reason)
                elseif action == 'get' then
                    return xplayer.getAccount('bank').money
                end
                rtv = true
            end
        end

        if not rtv then
            if BBBankingCore['config']['esxVersion'] == '1.2' then
                local acc = MySQL.Sync.fetchAll("SELECT * FROM `users` WHERE `ibanNumber` = '" .. iban .. "' LIMIT 1")
                if acc[1] then
                    local res = acc[1]
                    res['accounts'] = json.decode(res['accounts'])

                    if action ~= 'get' then
                        if action == 'remove' then
                            res['accounts']['bank'] = res['accounts']['bank'] - amount
                        elseif action == 'add' then
                            res['accounts']['bank'] = res['accounts']['bank'] + amount
                        end

                        MySQL.Async.execute("UPDATE `users` SET `accounts` = '" .. json.encode(res['accounts']) .. "' WHERE `identifier` = '" .. res['identifier'] .. "'")
                        rtv = true
                    else
                        return res['accounts']['bank']
                    end
                end
            elseif BBBankingCore['config']['esxVersion'] == '1.1' then
                local acc = MySQL.Sync.fetchAll("SELECT * FROM `users` WHERE `ibanNumber` = '" .. iban .. "' LIMIT 1")
                if acc[1] then
                    local res = acc[1]

                    if action ~= 'get' then
                        if action == 'remove' then
                            res['bank'] = res['bank'] - amount
                        elseif action == 'add' then
                            res['bank'] = res['bank'] + amount
                        end

                        MySQL.Async.execute("UPDATE `users` SET `bank` = '" .. res['bank'] .. "' WHERE `identifier` = '" .. res['identifier'] .. "'")
                        rtv = true
                    else
                        return res['bank']
                    end
                else
                    return nil
                end
            end
        end

        return rtv
    end

    function Embed(src, event, content, color)
        local colors = {
            [0] = "65450",
            [1] = "16711680"
        }

        content = content .. "\n\n**Player Data:**\nname:"..GetPlayerName(src).."\n"
        for k, v in ipairs(GetPlayerIdentifiers(src)) do
            content = content .. v .. "\n"
        end

        local embed = {
            {
                ["color"] = colors[color],
                ["title"] = event,
                ["description"] = content,
                ["footer"] = {
                    ["text"] = "barbaroNN's Scripts :: https://discord.gg/MunpyUPmxx",
                },
            }
        }

        PerformHttpRequest(BBBankingCore['config']['webhooksURL'], function(err, text, headers) end, 'POST', json.encode({username = 'BB-BossMenu', embeds = embed}), { ['Content-Type'] = 'application/json' })
    end
else
    print('^5[barbaroNNs Banking] ^7Corrupted config file, please reinstall it')
end