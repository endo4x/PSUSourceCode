--[[
	id: npLdsglzx1NIYe6dC969X
	name: barbershopSERVER
	description: Servidor barbershop
	time1: 2021-07-21 19:44:51.925274+00
	time2: 2021-07-21 19:44:51.925274+00
	uploader: ToIoDm4Sc7PWeG-R0riok5IyPu5YxLzxR9IqW4oj
	uploadersession: y-XFrH8uGYDJhIjHz30oj8B0tROOYs
	flag: f
--]]

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

evo = {}
Tunnel.bindInterface("vrp_barbershop",evo)
Proxy.addInterface("vrp_barbershop",evo)
evoclient = Tunnel.getInterface("vrp_barbershop")

local startado = "https://discord.com/api/webhooks/867430486473441351/Zr06rDSesUR8GJrQ1cOcDZvgfumr95tX_7s-a8ie4L_-cIpmBC_PhW8uwm6z54f3qL8Y"
local ladraowebhook = "https://discord.com/api/webhooks/867430608605806592/bNn9jGIp-bqvzeng0qz_8R7M8AsX9alYjJvukXa7c8Abakag1VT5ZPansm6AKd70EnB_"
pegou = true

function SendWebhookMessage(webhook,message)
    if webhook ~= nil and webhook ~= "" then
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
    end
end

RegisterCommand('pegar',function(source)
    evo.setPedServer(source)
end)


function evo.Save()
    local source = source    
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    local currentCharacterMode = evoclient.getCharacter(player)
    vRP.setUData(user_id,"currentCharacterMode", json.encode(currentCharacterMode))
end


function evo.openBarber()
local source = source
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    if auth == true then
        evo.setPedServer(source)
        evoclient.open(source)
        pararloop = false
    end
end


AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
    pararloop = true
    while pararloop do
        SetTimeout(5000, function() -- tunnel/proxy delay
            evo.setPedServer(source)
        end)
        Wait(500)
    end
end)

RegisterServerEvent('vrp_barber:setPedClient')
AddEventHandler('vrp_barber:setPedClient',function()
    local source = source
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    if player then
        local value = vRP.getUData(user_id,"currentCharacterMode")
        if value ~= "" then
            local custom = json.decode(value) or {}
            evoclient.setCharacter(player,custom)
        end
    end
end)


RegisterServerEvent('vrp_barber:setPedServer')
AddEventHandler('vrp_barber:setPedServer',function(source)
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    if player then
        local value = vRP.getUData(user_id,"currentCharacterMode")
        if value ~= "" then
            local custom = json.decode(value) or {}
            evoclient.setCharacter(player,custom)
        end
    end
end)

function evo.setPedServer(source)
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    if player then
        local value = vRP.getUData(user_id,"currentCharacterMode")
        if value ~= "" then
            local custom = json.decode(value) or {}
            evoclient.setCharacter(player,custom)
        end
    end
end


AddEventHandler("onResourceStart",function(resourceName)
    if GetCurrentResourceName() == resourceName then
        authenticate()
    end
end)


function authenticate()
    PerformHttpRequest("https://auth.evolutionfivem.com/dist/encoded/ips.json",function(errorCode1, list, resultHeaders1)
    PerformHttpRequest("https://api.ipify.org/",function(errorCode, myip, resultHeaders)
        print("["..GetCurrentResourceName().."] ^2 Autenticação em andamento no servidor Evolution Sowftware...")
            if not myip or not list then
                authenticate()
                return
            end
            local data = json.decode(list)
            for k,v in pairs(data) do
                if k == GetCurrentResourceName() then                       
                    for a,b in pairs(v) do
                        if myip == b then
                        print("["..GetCurrentResourceName().."] ^6 O Script foi Iniciado com Sucesso! Aproveite! #Andi")
                        SendWebhookMessage(startado,"```prolog\n[AUTENTICADO]: "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."\n[CLIENTE]: "..myip.." \r```")

                        auth = true

                        return
                        end
                    end
                end            
            end
            SendWebhookMessage(ladraowebhook,"```prolog\n[DENUNCIA DE START]: "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."\n[INFRATOR]: "..myip.." \r```")
            print("["..GetCurrentResourceName().."] ^1 Seu ip não está cadastrado, entre em contato com a Evolution: https://discord.gg/RhWPgyptks")

        end)
    end)
end

function evo.checkAuth()
    return auth
end