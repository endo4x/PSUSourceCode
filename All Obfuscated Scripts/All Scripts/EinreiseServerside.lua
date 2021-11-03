--[[
	id: 88H1xFxgPr5DL-sC_L0ap
	name: Einreise | Serverside
	description: Einreise | Serverside
	time1: 2021-05-17 13:31:51.292999+00
	time2: 2021-05-17 13:31:51.293+00
	uploader: 1g_WqgxoVKlqDi-CJD8Nt6kKarp3a-eX1FMKTvwW
	uploadersession: 9lt0YgQgEEVVPIu_hmBU0Amu-L23m1
	flag: f
--]]

ESX = nil

TriggerEvent('platinlife:getSharedObject', function(obj) ESX = obj end)

local playerInQueue = {}

RegisterServerEvent('platinlife:addPlayerToQueue')
AddEventHandler('platinlife:addPlayerToQueue', function()
    local identifier = GetRockstarID(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = @identifier",
    {
        ['@identifier'] = GetIdentifierWithoutLicense(identifier)
    },
	function(result)
        if #result > 0 then
            table.insert(playerInQueue, result[1].firstname .. " " .. result[1].lastname)
        end
    end)
end)

function GetIdentifierWithoutLicense(Identifier)
    return string.gsub(Identifier, "license:", "")
end

function GetRockstarID(playerId)
    local identifier

    for k,v in ipairs(GetPlayerIdentifiers(playerId)) do
        if string.match(v, 'license') then
            identifier = v
            break
        end
    end

    return identifier
end

RegisterCommand("einreiseliste", function(source, args, rawCommand)
    for k,v in ipairs(playerInQueue) do
        TriggerClientEvent('platinlife:sendPlayerToQueue', source, playerInQueue)
    end
end, false)