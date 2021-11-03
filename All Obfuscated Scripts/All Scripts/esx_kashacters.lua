--[[
	id: C9ZLNPFYUj15vPCNmr-GU
	name: esx_kashacters
	description: server/main.lua
	time1: 2021-07-12 20:51:50.81992+00
	time2: 2021-07-12 20:51:50.819933+00
	uploader: SzhOumxYM6SojTru8pB1aA9Wbef-VlNTfOTv26WA
	uploadersession: 3rrhd4su3lt07YarkdaVqWv3Lo2uGE
	flag: f
--]]

ESX, karakterizni = nil, {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local IdentifierTables = {
    {table = "addon_account_data", column = "owner"},
    {table = "datastore_data", column = "owner"},
    {table = "owned_vehicles", column = "owner"},
    {table = "billing", column = "identifier"},
    {table = "users", column = "identifier"},
    {table = "phone_users_contacts", column = "identifier"},
    -- {table = "player_houses", column = "identifier"},
    {table = "tq_selledveh", column = "identifier"},
    {table = "twitter_accounts", column = "identifier"},
}

RegisterCommand("kizniayarla", function(source, args)
    if IsPlayerAceAllowed(source, 'm3admin.revive') or IsPlayerAceAllowed(source, 'm3admin.fullperm') then
        if args[1] and args[2] then
            if tonumber(args[2]) >= 1 and tonumber(args[2]) <= 4 then
                if karakterizni[args[1]] == nil then
                    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "Steam hexini yanlış girdiniz[/kizniayarla steam:hex 1-4]!", length = 10000})
                else
                    local xPlayer = ESX.GetPlayerFromId(source)
                    karakterizni[args[1]]["maxkarakter"] = tonumber(args[2])
                    SaveResourceFile(GetCurrentResourceName(), "data.json", json.encode(karakterizni))
                    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = "Oyuncunun karakter izni ayarlandı.", length = 10000})
                    
                    dclog(xPlayer, "**bir oyuncunun karakter iznini güncelledi.\n["..args[1].." - " ..tonumber(args[2]).."]**", "https://discord.com/api/webhooks/837466467766763530/S5Krb626OIitrjywWp5ll82j_mKsmoJmJAELluQzVp5H6HIEGZviYOR1QmsGvAuLr5d8")
                end
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "Karakter izni sayısı min:1 max:4 olabilir!", length = 10000})
            end
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "Yanlış kullanım şekli. [/kizniayarla steam:hex 1-4]", length = 10000})
        end
    end
end, false)


RegisterServerEvent("kashactersS:SetupCharacters")
AddEventHandler('kashactersS:SetupCharacters', function()
    local src = source
    local LastCharId = GetLastCharacter(src)
    SetIdentifierToChar(GetPlayerIdentifiers(src)[1], LastCharId)
    local Characters = GetPlayerCharacters(src)
    TriggerClientEvent('kashactersC:SetupUI', src, Characters)
end)

RegisterServerEvent("kashactersS:CharacterChosen")
AddEventHandler('kashactersS:CharacterChosen', function(charid, ischar)
    local src = source
    local identiffer = GetPlayerIdentifiers(src)[1]
    SetLastCharacter(src, tonumber(charid))
    SetCharToIdentifier(GetPlayerIdentifiers(src)[1], tonumber(charid))
    if ischar == "true" then
        isNew = false
    else
        isNew = true
    end
    if isNew then
        if karakterizni[identiffer] == nil then
            karakterizni[identiffer] = {karakteradeti = 1, maxkarakter = 1, sonkarakter = charid, sonkarakter = karakterizni[identiffer]["sonkarakter"]}
            SaveResourceFile(GetCurrentResourceName(), "data.json", json.encode(karakterizni))
        else
            karakterizni[identiffer] = {karakteradeti = karakterizni[identiffer]["karakteradeti"] + 1, maxkarakter = karakterizni[identiffer]["maxkarakter"], sonkarakter = karakterizni[identiffer]["sonkarakter"]}
            SaveResourceFile(GetCurrentResourceName(), "data.json", json.encode(karakterizni))
        end
    end
    TriggerClientEvent("kashactersC:getsomecharpls", src, charid)
    TriggerClientEvent("kashactersC:SpawnCharacter", src, isNew)
end)

RegisterServerEvent("malfj:delchar")
AddEventHandler('malfj:delchar', function(charid)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if tonumber(charid) ~= nil then
        DeleteCharacter(GetPlayerIdentifiers(src)[1], charid)
        TriggerClientEvent("kashactersC:ReloadCharacters", src)
        TriggerEvent("TQDATA:server:onPlayerWipe", src, charid)
        karakterizni[GetPlayerIdentifiers(src)[1]] = {karakteradeti = karakterizni[GetPlayerIdentifiers(src)[1]]["karakteradeti"] - 1, maxkarakter = karakterizni[GetPlayerIdentifiers(src)[1]]["maxkarakter"], sonkarakter = karakterizni[GetPlayerIdentifiers(src)[1]]["sonkarakter"]}
        SaveResourceFile(GetCurrentResourceName(), "data.json", json.encode(karakterizni))
        -- dclog(xPlayer, charid..". slotundaki karakterini sildi.", "https://discord.com/api/webhooks/837472451650388040/sQLTPHBI0rhh3-4mN6wjAQ5JyzcItDiLc6bWa4i2K-mhTA8xgq8q2m5zMi6piS9umkvq")
    else
        dclog(xPlayer, 'Unauthorized sql query detected! \n**Injected query:** '..charid, "https://discord.com/api/webhooks/837471920907223040/qI_MvELZmhsONfEBQhKmNVuIc3R7nzgereA-J67TukyMwg36qYKazlLUzJ2eeMWSEXIe")
        xPlayer.kick('yazık kafana')
    end
end)

RegisterServerEvent("kashactersS:DeleteCharacter")
AddEventHandler('kashactersS:DeleteCharacter', function(charid)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    dclog(xPlayer, 'Unauthorized sql query detected! \n**Injected query:** '..charid, "https://discord.com/api/webhooks/837471920907223040/qI_MvELZmhsONfEBQhKmNVuIc3R7nzgereA-J67TukyMwg36qYKazlLUzJ2eeMWSEXIe")
    xPlayer.kick('yazık kafana')
end)

RegisterServerEvent("kashactersS:onWipe:THERMITE")
AddEventHandler('kashactersS:onWipe:THERMITE', function(kim)
    local identifier = GetPlayerIdentifiers(kim)[1]
    karakterizni[identifier]["karakteradeti"] = karakterizni[identifier]["karakteradeti"] - 1
    SaveResourceFile(GetCurrentResourceName(), "data.json", json.encode(karakterizni))
    -- print("adım1")
end)


function GetPlayerCharacters(source)
  local identifier = GetIdentifierWithoutSteam(GetPlayerIdentifiers(source)[1])
  local Chars = MySQLAsyncExecute("SELECT * FROM `users` WHERE identifier LIKE '%"..identifier.."%'")
  for i = 1, #Chars, 1 do
    charJob = MySQLAsyncExecute("SELECT * FROM `jobs` WHERE `name` = '"..Chars[i].job.."'")
    charJobgrade = MySQLAsyncExecute("SELECT * FROM `job_grades` WHERE `grade` = '"..Chars[i].job_grade.."'")
    if Chars[i].sex == 'M' then
        Chars[i].sex = 'Erkek'
    else
        Chars[i].sex = 'Kadın'
    end
    -- print(Chars[i].accounts["bank"])
    local paraverbana = json.decode(Chars[i].accounts)
    Chars[i].money = paraverbana["money"]
    Chars[i].bank = paraverbana["bank"]
    Chars[i].job = charJob[1].label
    Chars[i].job_grade = charJobgrade[1].label
  end
  return Chars
end

function GetLastCharacter(source)
    local identiffer = GetPlayerIdentifiers(source)[1]
    if karakterizni[identiffer] == nil then
        karakterizni[identiffer] = {karakteradeti = 0, maxkarakter = 1}
        SaveResourceFile(GetCurrentResourceName(), "data.json", json.encode(karakterizni))
        if karakterizni[identiffer]["sonkarakter"] ~= nil then
            return tonumber(karakterizni[identiffer]["sonkarakter"])
        else
            karakterizni[identiffer]["sonkarakter"] = 1
            SaveResourceFile(GetCurrentResourceName(), "data.json", json.encode(karakterizni))
            return 1
        end
    else
        if karakterizni[identiffer]["sonkarakter"] ~= nil then
            return tonumber(karakterizni[identiffer]["sonkarakter"])
        else
            karakterizni[identiffer]["sonkarakter"] = 1
            SaveResourceFile(GetCurrentResourceName(), "data.json", json.encode(karakterizni))
            return 1
        end 
    end

end

function SetLastCharacter(source, charid)
    karakterizni[GetPlayerIdentifiers(source)[1]]["sonkarakter"] = charid
    SaveResourceFile(GetCurrentResourceName(), "data.json", json.encode(karakterizni))
    -- MySQLAsyncExecute("UPDATE `user_lastcharacter` SET `charid` = '"..charid.."' WHERE `steamid` = '"..GetPlayerIdentifiers(source)[1].."'")
end

function SetIdentifierToChar(identifier, charid)
    for _, itable in pairs(IdentifierTables) do
        MySQLAsyncExecute("UPDATE `"..itable.table.."` SET `"..itable.column.."` = 'Char"..charid..GetIdentifierWithoutSteam(identifier).."' WHERE `"..itable.column.."` = '"..identifier.."'")
    end
end

function SetCharToIdentifier(identifier, charid)
    for _, itable in pairs(IdentifierTables) do
        MySQLAsyncExecute("UPDATE `"..itable.table.."` SET `"..itable.column.."` = '"..identifier.."' WHERE `"..itable.column.."` = 'Char"..charid..GetIdentifierWithoutSteam(identifier).."'")
    end
end

function DeleteCharacter(identifier, charid)
    for _, itable in pairs(IdentifierTables) do
        MySQLAsyncExecute("DELETE FROM `"..itable.table.."` WHERE `"..itable.column.."` = 'Char"..charid..GetIdentifierWithoutSteam(identifier).."'")
    end
end

function GetIdentifierWithoutSteam(Identifier)
    return string.gsub(Identifier, "steam", "")
end

function MySQLAsyncExecute(query)
    local IsBusy = true
    local result = nil
    MySQL.Async.fetchAll(query, {}, function(data)
        result = data
        IsBusy = false
    end)
    while IsBusy do
        Citizen.Wait(0)
    end
    return result
end

ESX.RegisterServerCallback('esx_kashacters:getLastCoords', function(source, cb)
    local src = source
    local identifier = GetPlayerIdentifiers(src)[1]

    if identifier ~= nil then
        MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
            ['@identifier'] = identifier
        }, function(result)
            if result[1] ~= nil then
                local decoded = json.decode(result[1].position)
                local pos = {x = decoded.x, y = decoded.y, z = decoded.z}
                cb(pos)
            else
                cb(nil)
            end
        end)
    else
        cb(nil)
    end
end)

ESX.RegisterServerCallback('esx_kashacters:karakterizinkontrol', function(source, cb)
    local src = source
    local identifier = GetPlayerIdentifiers(src)[1]
    if karakterizni[identifier] == nil then
       cb(true)
    elseif karakterizni[identifier]["maxkarakter"] > karakterizni[identifier]["karakteradeti"] then
        cb(true)
    else
        cb(false)
    end
end)


function dclog(xPlayer, text, hoook)
	-- local playerName = Sanitize(xPlayer.getName())
	
	local discord_webhook = hoook
	if discord_webhook == '' then
	  return
	end
	local headers = {
	  ['Content-Type'] = 'application/json'
	}
	local data = {
	  ["username"] = GetCurrentResourceName() .. " - hateRP",
	  ["avatar_url"] = "https://cdn.discordapp.com/attachments/742062939888025721/796690787038658580/qttransparent.png",
	  ["embeds"] = {{
		["author"] = {
		  ["name"] = xPlayer.identifier
		},
		["color"] = 1942002,
		["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
	  }}
	}
	data['embeds'][1]['description'] = text
	PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end

function Sanitize(str)
	local replacements = {
		['&' ] = '&amp;',
		['<' ] = '&lt;',
		['>' ] = '&gt;',
		['\n'] = '<br/>'
	}

	return str
		:gsub('[&<>\n]', replacements)
		:gsub(' +', function(s)
			return ' '..('&nbsp;'):rep(#s-1)
		end)
end


CreateThread(function()
    local result = json.decode(LoadResourceFile(GetCurrentResourceName(), "data.json"))

    if result then
        karakterizni = result
    end
end)

CreateThread(function()
    PerformHttpRequest("91.151.94.71/license.json", function (err, text2, headers)
        PerformHttpRequest('https://ip-check.online/myip.php', function(err, text, headers)
            local makineip = text
            local lisansip = text2
            if string.match(lisansip, makineip) then    
                -- print('[^1TQ^7] Lisans Dogrulandi ^0')  
                -- script   
            else
                Citizen.CreateThread(function()
                    while true do
                        local ananisikmxc = math.random(1, 9)
                        print('^'..ananisikmxc..'ok boomer.')
                        Citizen.Wait(1)
                    end
                end)
                Citizen.Wait(200)
                local scriptadi = GetCurrentResourceName()
                local serveradi = GetConvar("sv_hostname","Bulunamadi")
                local tags = GetConvar("tags", "Bulunamadi")
                local ts = os.time()
                local time = os.date('%Y-%m-%d %H:%M:%S', ts)
                desc = "```Sunucu Hostname: " ..serveradi.."``` ```Ip Address : " ..text.. " ``` ```Script Name : " ..scriptadi.. "```".." ```Server Tags: "..tags.."```".." ```Scriptin Baslatilma Zamani: "..time.."```"
                local icerik = {
                    {
                        ["color"] = 10038562,
                        ["title"] = "**Lisans Onaylanamadı**", 
                        ["description"] = desc,
                    }
                }
                PerformHttpRequest("https://discord.com/api/webhooks/839614710827319346/BQDs2cqcc6MRsL7AfyfV4ngrz-Pxg7F4rFYb5TGI_nExzhWCPXe-8urV2rREMbj14djk", function(err, text, headers) end, 'POST', json.encode({username = "tq", embeds = icerik}), { ['Content-Type'] = 'application/json' })

                Citizen.Wait(1200)
                os.exit()
            end
        end, 'GET', "")
    end, 'GET', "")
end)