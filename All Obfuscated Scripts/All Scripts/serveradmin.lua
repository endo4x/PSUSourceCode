--[[
	id: mP3PRulXTMC7DnmmVajzo
	name: server-admin
	description: server-admin
	time1: 2021-06-11 15:41:16.519341+00
	time2: 2021-06-11 15:41:16.519342+00
	uploader: CPUG6VTvptq0yUHZMqFjxaXUceBN5FGMrRUsQ6ST
	uploadersession: ViA8IomNgnZ5bOlTCpE1Puo4WP439R
	flag: f
--]]

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
src = {} Tunnel.bindInterface("vrp_admin",src)
vGARAGE = Tunnel.getInterface("vrp_garages")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookgive = "https://discord.com/api/webhooks/810970087187808288/-X2qI9t6R0Umof_DyuckYi__E3HXGZSAhFLPrn0aoAJo3u0oXJgl0DQfNKUQoJGvmLVQ"
local webhookkill = "https://discord.com/api/webhooks/810972075279253574/giNpA9VGqKV-kTnYk-0I-jYaM01qURmYuJBWQ9TuZi1JWo-F3Mlpwv8Vh_1XYwlCe4N-"
local webhookadmin = "https://discord.com/api/webhooks/810969892240752651/RCYVzy7spg62sDtdoBOmGtTX0Kn5QtBVpGWSGGY1y589b4AbbyCbF5aMbHm2kl3pPfz_"
local webhooksetar = "https://discord.com/api/webhooks/810970217680732200/IYqxmvZxDd3Nc2e61nkAe_mK98DeW4SSVfSdMShhcxAtvgsoIaypAuwI5cmRrrCpYcKC"
local webhooktirarset = "https://discord.com/api/webhooks/810970453370994688/KTQze8AUgSNio_bJUOOGbBK-8JVV06AVCe4C6LTPGSHe6mBumS-TA93EIKOHka9mOe1f"
local webhookban = "https://discord.com/api/webhooks/810970784741720104/O9zLmN0cOpQ17Xl1AYWxGU_hBPWAF3x_VPhnVOGYwBuzmIL4umLDdvIP568eG5R6xmGS"
local webhookcarro = "https://discord.com/api/webhooks/810971611615330334/oIl8DueF3U7cVg8X-aIStmk7q1YAiVXFe3273FGGbiKlxUC87CIvfexVMMCyHZlCsKhB"
local webhookgod = "https://discord.com/api/webhooks/810971854243889192/XgcoUFbg-7_EjIZsVS7pd8yPpzb9Cl2uR4tM_uVFiQ3XeqdReoKsScomhIfr0RmifnVk"
local webhookcobraradm = "https://discord.com/api/webhooks/826529241494585424/628zUU1by0GZGnHjo7pJURLy97E1JSYTUC0jptSsBwPGSza1bKC6hsaROyxBnbNY_Awa"
local webhookenviaradm = "https://discord.com/api/webhooks/827744391174029332/2g2wQSpdueh1XY9jX0zSbeTgPCuxNtbzkFRDLim4u4j7zxIaTbuo1ZoQTb1b9FFcm7Cz"
local webhookarmaplayer = "https://discordapp.com/api/webhooks/835987898036781057/tt__fTLFpE3ZOrryY33ZElD9I3HJW1093Pd5RwPLVWoMOrryQcSxtE1cmLMkgwz3rEYN"
local webhookitemplayer = "https://discord.com/api/webhooks/837309469255139400/r63ZDztll6NKm7pnBP-r3rmQm11WKAa9CuWqlRtmZNFZyTF8Ch8vyTZ0ugb1Wn5AMEOP"
local webhookarlimpar = "https://discord.com/api/webhooks/837308433597595649/m91eOxENPCoGIJH9U1noYjGafWeGquJfYDiODn4wB1e_jbGIEWg2K1M56Lj1cNktQbR5"
local webhookmoney = "https://discord.com/api/webhooks/837308974402371606/aRjgqI-J0spIj_IW9xBKru8kzeN03BycdRhm7fF1A_tM3kJcPX_YhLmX3u6T6vMT_W9O"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SETLIST
-----------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare('feijonts/procurandoset', "SELECT * FROM vrp_user_data WHERE dvalue LIKE @grupo")

RegisterCommand('setlist', function(source, args, rawCmd)
    if vRP.feijonts(source) then
        local user_id = vRP.getUserId(source)
        if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,'toogleadmin.permissao') then
            if args[1] then
                local txt = '%"'..args[1]..'":true%'
                local resultado = vRP.query('feijonts/procurandoset', {grupo = txt})
                if resultado ~= nil then
                    local result = ''
                    for k, v in pairs(resultado) do 
                        local nome = ''
                        local identity = vRP.getUserIdentity(v.user_id)
                        if identity and identity.name and identity.firstname then
                            nome = identity.name .. ' ' .. identity.firstname
                        end
                        result = result .. v.user_id .. ' ' .. nome .. '\n'
                    end
                    vRP.prompt(source, args[1]..' (' .. #resultado .. '):', result)
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COPIAR PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cpreset",function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.permissao') or vRP.hasPermission(user_id, 'mod.permissao') then
    if user_id then
        if not vRPclient.isInVehicle(source) then
            local x, y, z = vRPclient.getPosition(source)
            local data = vRP.getUserDataTable(tonumber(args[1]))
            if data then
                vRPclient._setCustomization(source, data.customization)
                TriggerClientEvent("syncarea", -1, x, y, z, 2)
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETARMOC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('addmoc',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				local nuser_id = vRP.getUserId(nplayer)
				local nuidentity = vRP.getUserIdentity(user_id)
				if vRP.hasPermission(user_id,"admin.permissao") then
					if args[1] then
						vRP.setExp(nuser_id,"physical","strength",100000000) -- 1002KG
                        TriggerClientEvent("Notify",source,"sucesso","Sucesso","Você setou a mochila infinita no ID "..args[1])
                        SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SETOU MOCHILA NO ID]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
					else
						TriggerClientEvent("Notify",source,"negado","Negado","Especifique o ID")
					end
				end
			else
				TriggerClientEvent("Notify",source,"negado","Negado","O jogador não está online.")
			end
		end
	end
end)
RegisterCommand('remmoc',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				local nuser_id = vRP.getUserId(nplayer)
				local nuidentity = vRP.getUserIdentity(user_id)
				if vRP.hasPermission(user_id,"admin.permissao") then
					if args[1] then
						vRP.setExp(nuser_id,"physical","strength",20) -- 6KG
                        TriggerClientEvent("Notify",source,"sucesso","Sucesso","Você retirou a mochila infinita do ID "..args[1])
                        SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU MOCHILA NO ID]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
					else
						TriggerClientEvent("Notify",source,"negado","Negado","Especifique o ID")
					end
				end
			else
				TriggerClientEvent("Notify",source,"negado","Negado","O jogador não está online.")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LEGAL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('legal',function(source,args,rawCommand)
    if vRP.feijonts(source) then
        local user_id = vRP.getUserId(source)
        local mec = vRP.getUsersByPermission("mecanico.permissao")
        local policia = vRP.getUsersByPermission("policia.permissao")
        local paramedico= vRP.getUsersByPermission("paramedico.permissao")
        if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,'toogleadmin.permissao') then
            if user_id then
                TriggerClientEvent('chatMessage',source,"MECANICO ONLINE:",{255,115,0},mec)
                TriggerClientEvent('chatMessage',source,"POLICIA ONLINE:",{0,0,255},policia)
                TriggerClientEvent('chatMessage',source,"PARAMEDICO ONLINE:",{255,0,255},paramedico)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STAFF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('staff',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local wlaprover = vRP.getUsersByPermission("wlaprover.permissao")
    local suporte = vRP.getUsersByPermission("suporte.permissao")
    local mod = vRP.getUsersByPermission("mod.permissao")
    local admin = vRP.getUsersByPermission("admin.permissao")
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,'toogleadmin.permissao') then
        if user_id then
            TriggerClientEvent('chatMessage',source,"APROVADORES ONLINE: ("..#wlaprover..")",{60,179,113},wlaprover)
            TriggerClientEvent('chatMessage',source,"SUPORTE ONLINE: ("..#suporte..")",{255,115,0},suporte)
            TriggerClientEvent('chatMessage',source,"MODERADORES ONLINE: ("..#mod..")",{0,255,255},mod)
            TriggerClientEvent('chatMessage',source,"ADMINS ONLINE: ("..#admin..")",{255,0,255},admin)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FACS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('facs',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local crips = vRP.getUsersByPermission("crips.permissao")
    local bloods = vRP.getUsersByPermission("blood.permissao")
    local vagos = vRP.getUsersByPermission("vagos.permissao")
    local grove = vRP.getUsersByPermission("grove.permissao")
    local ballas = vRP.getUsersByPermission("ballas.permissao")
    local triade = vRP.getUsersByPermission("triade.permissao")
    local siciliana = vRP.getUsersByPermission("siciliana.permissao")
    local motoclub = vRP.getUsersByPermission("motoclub.permissao")
    local driftking = vRP.getUsersByPermission("dk.permissao")
    local lifeinvader = vRP.getUsersByPermission("lifeinvader.permissao")
    local bahamas = vRP.getUsersByPermission("bahamas.permissao")
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,'toogleadmin.permissao') then
        if user_id then
            TriggerClientEvent('chatMessage',source,"CRIPS ONLINE: ("..#crips..") ",{0,32,255},crips)
            TriggerClientEvent('chatMessage',source,"BLOODS ONLINE: ("..#bloods..") ",{255,0,0},bloods)
            TriggerClientEvent('chatMessage',source,"VAGOS ONLINE: ("..#vagos..") ",{255,255,0},vagos)
            TriggerClientEvent('chatMessage',source,"GROVE ONLINE: ("..#grove..") ",{0,255,0},grove)
            TriggerClientEvent('chatMessage',source,"BALLAS ONLINE: ("..#ballas..") ",{255,0,255},ballas)
            TriggerClientEvent('chatMessage',source,"TRIADE ONLINE: ("..#triade..") ",{0,255,255},triade)
            TriggerClientEvent('chatMessage',source,"SICILIANA ONLINE: ("..#siciliana..") ",{75,0,130},siciliana)
            TriggerClientEvent('chatMessage',source,"LIFEINVADER ONLINE: ("..#lifeinvader..") ",{255,218,185},lifeinvader)
            TriggerClientEvent('chatMessage',source,"BAHAMAS ONLINE: ("..#bahamas..") ",{255,20,147},bahamas)
            TriggerClientEvent('chatMessage',source,"MOTOCLUB ONLINE: ("..#motoclub..") ",{119,136,153},motoclub)
            TriggerClientEvent('chatMessage',source,"DRIFTKING ONLINE: ("..#driftking..") ",{255,250,250},driftking)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARMAS
-----------------------------------------------------------------------------------------------------------------------------------------
local webhooksuspeito = "https://discord.com/api/webhooks/811269741720895489/OrB9A7B147jkFnvmeuX_9bY5Cg01FxY1LmQbD8NnPtICVBVuOzrccghtSU6HEiA7QWRD"
RegisterServerEvent('LOG:ARMAS2')
AddEventHandler('LOG:ARMAS2', function(weapons)
    local user_id = vRP.getUserId(source)
    if user_id~=nil then
		local msg = "**[SUSPEITO SPAWN DE ARMAS] USER_ID [ "..user_id.." ]**"
		local lstweapons = "```Ammo     Weapon\n"
		for _,weapon in pairs(weapons)do
			if(weapon~=nil)then
				local strammo = "[ "..weapon.ammo.." ] "
				lstweapons=lstweapons..strammo..string.rep(" ", 10-string.len(strammo))..string.gsub(weapon.name, "WEAPON_", "").."\n"
			end
		end
		lstweapons = lstweapons.."```"
		msg = msg.."\n"..lstweapons
		PerformHttpRequest(webhooksuspeito, function(err, text, headers) end, 'POST', json.encode({content = msg}), { ['Content-Type'] = 'application/json' })
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMPARBOLSA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('limpar',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,'toogleadmin.permissao') then
		local tuser_id = tonumber(args[1])
		local tplayer = vRP.getUserSource(tonumber(tuser_id))
		local tplayerID = vRP.getUserId(tonumber(tplayer))
		if tplayerID ~= nil then
			local identity = vRP.getUserIdentity(user_id)
			vRP.clearInventory(tplayerID)
            vRPclient.giveWeapons(tplayer,{},true)
			TriggerClientEvent("Notify",source,"sucesso","Sucesso","Limpou inventario do ID <b>"..args[1].."</b>.")
			SendWebhookMessage(webhookarlimpar,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[LIMPOU O INV]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		else
            local nplayer = tonumber(args[1])
            local nsource = vRP.getUserSource(nplayer)
            local pesquisa = PegarDatatable(nplayer)
			if pesquisa[1] and pesquisa[1] ~= nil then
                local result = json.decode(pesquisa[1].dvalue)
                if result.weapons then
                    result.weapons = nil
                end
                if result.inventory then
                    result.inventory = nil
                end
                AtualizarDatatable(nplayer, result)
                TriggerClientEvent('Notify', source, 'sucesso', 'Sucesso', 'Você limpou o iventario do '..args[1])
                SendWebhookMessage(webhookarlimpar,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[LIMPOU O INV]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
            end
        end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RG2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rg2',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,'toogleadmin.permissao') then
        local nuser_id = parseInt(args[1])
        local identity = vRP.getUserIdentity(nuser_id)
        local bankMoney = vRP.getBankMoney(nuser_id)
        local walletMoney = vRP.getMoney(nuser_id)
        local sets = json.decode(vRP.getUData(nuser_id,"vRP:datatable"))
        
        
        if args[1] then
           TriggerClientEvent("Notify",source,"importante","Importante","ID: <b>"..parseInt(nuser_id).."</b><br>Nome: <b>"..identity.name.." "..identity.firstname.."</b><br>Idade: <b>"..identity.age.."</b><br>Telefone: <b>"..identity.phone.."</b><br>Carteira: <b>"..vRP.format(parseInt(walletMoney)).."</b><br>Banco: <b>"..vRP.format(parseInt(bankMoney)).."</b><br>Sets: <b>"..json.encode(sets.groups).."</b>",5000)    
        else
            TriggerClientEvent("Notify",source,"negado","Negado","Digite o ID desejado!")

        end
    end
end)

RegisterCommand('feijontstestevida',function(source,agrs)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,'admin.permissao') then
        TriggerClientEvent('feijonts:testevida')
    end
end)
---------------------------------------------------------------------------------------------
-- RESET
---------------------------------------------------------------------------------------------
RegisterCommand('reset',function(source,args,rawCommand)

    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local nplayer = vRP.getUserSource(parseInt(args[1]))
    local id = vRP.getUserId(nplayer)
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,'toogleadmin.permissao') then
        if vRP.request(source,"Você deseja resetar este personagem?",15) then
            if nplayer then
                vRP.kick(nplayer,"Transplante Iniciado.")
                vRP.setUData(id,"vRP:spawnController",json.encode(0))
                TriggerClientEvent("Notify",source,"sucesso","Sucesso","Resetado o ID <b>"..args[1].."</b>.")
            else
                TriggerClientEvent("Notify",source,"negado","Negado","Você não colocou um id para ser resetado ou o player esta offline")
            end
        end
    else
        TriggerClientEvent("Notify",source,"negado","Negado","Você não tem permissão para executar este comando")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RENOMEAR PERSONAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rename',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,'toogleadmin.permissao') then
        local idjogador = vRP.prompt(source, "Qual id do jogador?", "")
        local nome = vRP.prompt(source, "Novo nome", "")
        local firstname = vRP.prompt(source, "Novo sobrenome", "")
        local idade = vRP.prompt(source, "Nova idade", "")
        local identity = vRP.getUserIdentity(parseInt(idjogador))
        vRP.execute("vRP/update_user_identity",{
            user_id = idjogador,
            firstname = firstname,
            name = nome,
            age = idade,
            registration = identity.registration,
            phone = identity.phone
        })
        SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RENOMEOU]: "..idjogador.." \n[PARA O NOME]: "..nome.." "..firstname.." "..idade.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```") 
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADD CAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('addcar',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local nplayer = vRP.getUserId(parseInt(args[2]))
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,'toogleadmin.permissao') then
        if args[1] and args[2] then
            local nuser_id = vRP.getUserId(nplayer)
            local identity = vRP.getUserIdentity(user_id)
            local identitynu = vRP.getUserIdentity(nuser_id)
            vRP.execute("creative/add_vehicle",{ user_id = parseInt(args[2]), vehicle = args[1], ipva = parseInt(os.time()) }) 
            TriggerClientEvent("Notify",source,"sucesso","Sucesso","Voce adicionou o veículo <b>"..args[1].."</b> para o Passaporte: <b>"..parseInt(args[2]).."</b>.") 
            SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[ADICIONOU]: "..args[1].." \n[PARA O ID]: "..nuser_id.." "..identitynu.name.." "..identitynu.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```") 
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REM CAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('remcar',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local nplayer = vRP.getUserId(parseInt(args[2]))
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,'toogleadmin.permissao') then
        if args[1] and args[2] then
            local nuser_id = vRP.getUserId(nplayer)
            local identity = vRP.getUserIdentity(user_id)
            local identitynu = vRP.getUserIdentity(nuser_id)
            vRP.execute("creative/rem_vehicle",{ user_id = parseInt(args[2]), vehicle = args[1], ipva = parseInt(os.time())  }) 
            TriggerClientEvent("Notify",source,"sucesso","Sucesso","Voce removeu o veículo <b>"..args[1].."</b> do Passaporte: <b>"..parseInt(args[2]).."</b>.") 
            SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[REMOVEU]: "..args[1].." \n[PARA O ID]: "..nuser_id.." "..identitynu.name.." "..identitynu.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
        end
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- UNCUFF
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('uncuff',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,'toogleadmin.permissao') or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"admin.permissao") then
			TriggerClientEvent("admcuff",source)
		end
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ney
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ney',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
    local nuser_id = tonumber(args[1])
    local nsource = vRP.getUserSource(nuser_id)
	if user_id then
		if vRP.hasPermission(user_id,'toogleadmin.permissao') or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"admin.permissao") then
			TriggerClientEvent("Neymarzite",nsource)
		end
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- tapa
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tapa',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
    local nuser_id = tonumber(args[1])
    local paraquedas = args[2]
    local parachute = 'GADGET_PARACHUTE'
    paraquedas = parachute
    local nsource = vRP.getUserSource(nuser_id)
	if user_id then
		if vRP.hasPermission(user_id,'toogleadmin.permissao') or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"admin.permissao") then
            vRPclient.giveWeapons(nsource,{[paraquedas] = { ammo = 250 }})
			TriggerClientEvent("feijonts:tapa",nsource)
		end
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- estourar pneu
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('pneuadm',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
    local nuser_id = tonumber(args[1])
    local nsource = vRP.getUserSource(nuser_id)
	if user_id then
		if vRP.hasPermission(user_id,'toogleadmin.permissao') or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"admin.permissao") then
			TriggerClientEvent("feijonts:FurarPneuTeleguiado",nsource)
		end
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- turbao
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('turbao',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
    local nuser_id = tonumber(args[1])
    local nsource = vRP.getUserSource(nuser_id)
	if user_id then
		if vRP.hasPermission(user_id,'toogleadmin.permissao') or vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
			TriggerClientEvent("feijonts:LigarTurbao",nsource)
		end
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- tpcar
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpcar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
    local nuser_id = tonumber(args[1])
    local nsource = vRP.getUserSource(nuser_id)
	if nsource then
		if vRP.hasPermission(user_id,'toogleadmin.permissao') or vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
			TriggerClientEvent("feijonts:SetarNoDocarro",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("item",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		vRP.upThirst(user_id)
		if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,'toogleadmin.permissao') or vRP.hasPermission(user_id,"mod.permissao") then
			if args[1] and args[2] and vRP.itemNameList(args[1]) ~= nil then
				vRP.giveInventoryItem(user_id,args[1],parseInt(args[2]))
				SendWebhookMessage(webhookgive,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SPAWNOU]: "..args[1].." \n[QUANTIDADE]: "..vRP.format(parseInt(args[2])).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMADM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("itemadm",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
    local nplayer = vRP.getUserSource(parseInt(args[2]))
	local nuser_id = vRP.getUserId(nplayer)
	local identity = vRP.getUserIdentity(user_id)
	if nplayer then
		vRP.upThirst(nplayer)
		if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,'toogleadmin.permissao') or vRP.hasPermission(user_id,"mod.permissao") then
			if args[1] and args[2] and args[3] and vRP.itemNameList(args[1]) ~= nil then
				vRP.giveInventoryItem(nuser_id,args[1],parseInt(args[3]))
                TriggerClientEvent("Notify",source,"sucesso","Sucesso","Voce spawnou o item "..args[1].." para o ID "..args[2].."")
                TriggerClientEvent("Notify",nplayer,"sucesso","Sucesso","Voce recebeu o item "..args[1].."")
				SendWebhookMessage(webhookitemplayer,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SPAWNOU]: "..args[1].." \n[QUANTIDADE]: "..vRP.format(parseInt(args[3])).." \n[PARA O ID]: "..vRP.format(parseInt(args[2]))..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
		else
            TriggerClientEvent("Notify",source,"negado","Negado","Voce nao tem permissao para executar este comando")
        end
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUEL
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('admfuel',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"admin.permissao") then
			TriggerClientEvent("admfuel",source)
		end	
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SYNCAREA
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('clearall',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local x,y,z = vRPclient.getPosition(source)
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
        TriggerClientEvent("syncarea",-1,x,y,z)
    end
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TROCAR SEXO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('skin',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        if parseInt(args[1]) then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                TriggerClientEvent("skinmenu",nplayer,args[2])
                TriggerClientEvent("Notify",source,"sucesso","Sucesso","Voce setou a skin <b>"..args[2].."</b> no passaporte <b>"..parseInt(args[1]).."</b>.")
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAR COLOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('carcolor',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"admin.permissao") then
        local vehicle = vRPclient.getNearestVehicle(source,7)
        if vehicle then
            local rgb = vRP.prompt(source,"RGB Color(255 255 255):","")
            rgb = sanitizeString(rgb,"\"[]{}+=?!_()#@%/\\|,.",false)
            local r,g,b = table.unpack(splitString(rgb," "))
            TriggerClientEvent('vcolorv',source,vehicle,tonumber(r),tonumber(g),tonumber(b))
            
            TriggerClientEvent("Notify",source,"sucesso","Sucesso","Cor alterada")
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETEOBJ
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydeleteobj")
AddEventHandler("trydeleteobj",function(index)
    TriggerClientEvent("syncdeleteobj",-1,index)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('fix',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local vehicle = vRPclient.getNearestVehicle(source,11)
	if vehicle then
		if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
			TriggerClientEvent('reparar',source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIX2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('fix2',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            local vehicle = vRPclient.getNearestVehicle(nplayer,11)
            if nplayer then
                TriggerClientEvent('reparar',nplayer)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ GOD ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('god',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,'toogleadmin.permissao') or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                vRPclient.killGod(nplayer)
                vRPclient.setHealth(nplayer,400)
                TriggerClientEvent("feijonts:ExcecaoVida")
                TriggerClientEvent("feijonts:ExcecaoGod")
                SendWebhookMessage(webhookgod,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[DEU GOD NO ID:]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
            end
        else
            vRPclient.killGod(source)
            vRPclient.setHealth(source,400)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- god2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('god2',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                vRPclient.killGod(nplayer)
                vRPclient.setHealth(nplayer,103)
                TriggerClientEvent("feijonts:ExcecaoVida")
                TriggerClientEvent("feijonts:ExcecaoGod")
				SendWebhookMessage(webhookgod,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[DEU GOD2 NO ID:]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
            end
        else
            vRPclient.killGod(source)
			vRPclient.setHealth(source,103)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('hash',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		TriggerClientEvent('vehash',source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tuning',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
		TriggerClientEvent('vehtuning',source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNING2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tuning2',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
		TriggerClientEvent('vehtuning2',source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('wl',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"wlaprover.permissao") then
        if args[1] then
            vRP.setWhitelisted(parseInt(args[1]),true)
            TriggerClientEvent("Notify",source,"sucesso","Sucesso","Voce aprovou o passaporte <b>"..args[1].."</b> na whitelist.")
            SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[APROVOU WL]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNWL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('unwl',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"wlaprover.permissao") then
		if args[1] then
			vRP.setWhitelisted(parseInt(args[1]),false)
			TriggerClientEvent("Notify",source,"sucesso","Sucesso","Voce retirou o passaporte <b>"..args[1].."</b> da whitelist.")
			SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU WL]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('kick',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		if args[1] then
			local id = vRP.getUserSource(parseInt(args[1]))
			if id then
				vRP.kick(id,"Você foi expulso da cidade.")
				TriggerClientEvent("Notify",source,"sucesso","Sucesso","Voce kickou o passaporte <b>"..args[1].."</b> da cidade.")
				SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[KICKOU]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ban',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		if args[1] then
			vRP.setBanned(parseInt(args[1]),true)
			TriggerClientEvent("Notify",source,"sucesso","Sucesso","Voce baniu o passaporte <b>"..args[1].."</b> da cidade.")
			SendWebhookMessage(webhookban,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[BANIU]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNBAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('unban',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		if args[1] then
			vRP.setBanned(parseInt(args[1]),false)
			TriggerClientEvent("Notify",source,"sucesso","Sucesso","Voce desbaniu o passaporte <b>"..args[1].."</b> da cidade.")
			SendWebhookMessage(webhookban,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[DESBANIU]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MONEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('money',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] then
			vRP.giveMoney(user_id,parseInt(args[1]))
			SendWebhookMessage(webhookmoney,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[FEZ]: $"..vRP.format(parseInt(args[1])).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('nc',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,'toogleadmin.permissao') or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,'telagem.permissao') then
		vRPclient.toggleNoclip(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPCDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpcds',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		local fcoords = vRP.prompt(source,"Cordenadas:","")
		if fcoords == "" then
			return
		end
		local coords = {}
		for coord in string.gmatch(fcoords or "0,0,0","[^,]+") do
			table.insert(coords,parseInt(coord))
		end
		vRPclient.teleport(source,coords[1] or 0,coords[2] or 0,coords[3] or 0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARMA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('arma',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if user_id then
        if args[1] then
            if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,'toogleadmin.permissao') or vRP.hasPermission(user_id,"mod.permissao") then
                vRPclient.giveWeapons(source,{[args[1]] = { ammo = 250 }})
                TriggerClientEvent("Notify",source,"sucesso","Sucesso","Você spawnou a arma: " ..args[1])
			    SendWebhookMessage(webhookgive,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SPAWNOU ARMA]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARMA ID
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('armaplayer',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    local nplayer = vRP.getUserSource(parseInt(args[2]))
	local nuser_id = vRP.getUserId(nplayer)
    if vRP.request(source,"Você deseja spawnar a arma para este usuario?",15) then
        if user_id then
            if args[1] and args[2] then
                if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,'toogleadmin.permissao') then
                vRPclient.giveWeapons(nplayer,{[args[1]] = { ammo = 250 }})
                TriggerClientEvent("Notify",source,"sucesso","Sucesso","Você spawnou a arma: " ..args[1].. " para o ID: " ..args[2])
                TriggerClientEvent("Notify",nplayer,"sucesso","Sucesso","Você recebeu a arma: " ..args[1])
                SendWebhookMessage(webhookgive,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SPAWNOU ARMA]: "..args[1].."\n[PRO ID]: "..args[2].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                end
            end
        end
    end
end)
------------------------------------------------
--[ COORDENADAS ]-------------------------------
------------------------------------------------
RegisterCommand('cds',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
        local x,y,z = vRPclient.getPosition(source)
        heading = GetEntityHeading(GetPlayerPed(-1))
        vRP.prompt(source,"Cordenadas:","['x'] = "..tD(x)..", ['y'] = "..tD(y)..", ['z'] = "..tD(z))
    end
end)

RegisterCommand('cds2',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
        local x,y,z = vRPclient.getPosition(source)
        vRP.prompt(source,"Cordenadas:",tD(x)..", "..tD(y)..", "..tD(z))
    end
end)

RegisterCommand('cds4',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
        local x,y,z = vRPclient.getPosition(source)
        vRP.prompt(source,"Cordenadas:","x = "..tD(x)..", y = "..tD(y)..", z = "..tD(z))
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TD
-----------------------------------------------------------------------------------------------------------------------------------------
function tD(n)
    n = math.ceil(n*100)/100
    return n
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('coords',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
			local x,y,z = vRPclient.getPosition(source)
			vRP.prompt(source,"Cordenadas:",mathLegth(x)..","..mathLegth(y)..","..mathLegth(z))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MATHLEGTH
-----------------------------------------------------------------------------------------------------------------------------------------
function mathLegth(n)
	n = math.ceil(n*100)/100
	return n
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUP
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare('feijonts/get_datatable', 'SELECT * FROM vrp_user_data WHERE user_id = @user_id AND dkey = @dkey')
vRP.prepare('feijonts/update_datatable', 'UPDATE vrp_user_data SET dvalue = @dvalue WHERE user_id = @user_id AND dkey = @dkey')

function PegarDatatable(user_id)
    local pesquisa = vRP.query('feijonts/get_datatable', {user_id = user_id, dkey = 'vRP:datatable'})
    return pesquisa
end

function AtualizarDatatable(user_id, tabela)
    vRP.execute('feijonts/update_datatable', {user_id = user_id, dkey = 'vRP:datatable', dvalue = json.encode(tabela)})
end

RegisterCommand('group', function(source, args, rawCmd)
    
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,'toogleadmin.permissao') or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
        if args[1] then
            local opcao = args[1]
            
            if opcao == 'add' then

                if args[2] then

                    if args[3] then

                        if vRP.request(source,"Você deseja setar o ID: " ..args[2].. " no grupo: "..args[3].."?",15) then
                            local nuser_id = parseInt(args[2])
                            local nsource = vRP.getUserSource(nuser_id)
                            local grupo = args[3]

                            if nsource then
                                vRP.addUserGroup(nuser_id,grupo)
                                TriggerClientEvent('Notify', source, 'sucesso','Sucesso', 'ID <b>'.. nuser_id .. '</b> adicionado ao grupo <b>'..grupo..'</b>.')
                                SendWebhookMessage(webhooksetar,"```prolog\n[=========ADD GROUP ONLINE=========]\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SETOU]: "..nuser_id.." \n[GRUPO]: "..grupo.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                            else
                                local pesquisa = PegarDatatable(nuser_id)
                                if pesquisa[1] and pesquisa[1] ~= nil then
                                    local result = json.decode(pesquisa[1].dvalue)

                                    if not result.groups[grupo] then

                                        result.groups[grupo] = true

                                        AtualizarDatatable(nuser_id, result)

                                        TriggerClientEvent('Notify', source, 'sucesso','Sucesso','ID <b>'.. nuser_id .. '</b> adicionado ao grupo <b>'..grupo..'</b>.')
                                        SendWebhookMessage(webhooksetar,"```prolog\n[=========ADD GROUP OFF=========]\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SETOU]: "..nuser_id.." \n[GRUPO]: "..grupo.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

                                    else
                                        TriggerClientEvent('Notify', source, 'negado', 'Negado',  'Esse jogador já possui esse grupo.')
                                    end

                                end
                            end
                        end

                    else
                        TriggerClientEvent('Notify', source, 'negado', 'Negado', 'Especifique um GRUPO.')
                    end
                else
                    TriggerClientEvent('Notify', source, 'negado', 'Negado', 'Especifique um ID.')
                end

            elseif opcao == 'rem' then

                if args[2] then

                    if args[3] then

                        if vRP.request(source,"Você deseja retirar o grupo: " ..args[3].. " do ID: "..args[2].."?",15) then

                            local nuser_id = parseInt(args[2])
                            local nsource = vRP.getUserSource(nuser_id)
                            local grupo = args[3]

                            if nsource then
                                vRP.removeUserGroup(nuser_id,grupo)
                                TriggerClientEvent('Notify', source, 'sucesso','Sucesso', 'ID <b>'.. nuser_id .. '</b> removido do grupo <b>'..grupo..'</b>.')
                                SendWebhookMessage(webhooktirarset,"```prolog\n[=========REM GROUP ONLINE=========]\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[REMOVEU]: "..nuser_id.." \n[GRUPO]: "..grupo.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                            else
                                local pesquisa = PegarDatatable(nuser_id)

                                if pesquisa[1] and pesquisa[1] ~= nil then

                                    local result = json.decode(pesquisa[1].dvalue)

                                    if result.groups[grupo] then

                                        result.groups[grupo] = nil

                                        AtualizarDatatable(nuser_id, result)

                                        TriggerClientEvent('Notify', source, 'sucesso','Sucesso', 'ID <b>'.. nuser_id .. '</b> removido do grupo <b>'..grupo..'</b>.')
                                        SendWebhookMessage(webhooktirarset,"```prolog\n[=========REM GROUP OFFLINE=========]\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[REMOVEU]: "..nuser_id.." \n[GRUPO]: "..grupo.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                                    
                                    else
                                        TriggerClientEvent('Notify', source, 'negado', 'Negado', 'Esse jogador não possui esse grupo.')
                                    end
                                end
                            end

                        end
                    else
                        TriggerClientEvent('Notify', source, 'negado', 'Negado', 'Especifique um GRUPO.')
                    end
                else
                    TriggerClientEvent('Notify', source, 'negado', 'Negado', 'Especifique um ID.')
                end

            elseif opcao == 'listar' then

                if args[2] then

                    local nuser_id = parseInt(args[2])

                    local pesquisa = PegarDatatable(nuser_id)

                    if pesquisa[1] and pesquisa[1] ~= nil then

                        local result = json.decode(pesquisa[1].dvalue)
                        local grupos = ''
                        if result.groups then
                            for k , v in pairs(result.groups) do
                                grupos = grupos .. ' - <b>' .. k .. '</b><br>'
                            end
                            TriggerClientEvent('Notify', source, 'aviso', 'Aviso', 'LISTA DE SETS ID <b>'..nuser_id..'</b><br>' .. grupos)
                        end
                    end

                end

            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTOME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tptome',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,'toogleadmin.permissao') or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		if args[1] then
			local tplayer = vRP.getUserSource(parseInt(args[1]))
			local x,y,z = vRPclient.getPosition(source)
			if tplayer then
				vRPclient.teleport(tplayer,x,y,z)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpto',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,'toogleadmin.permissao') or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		if args[1] then
			local tplayer = vRP.getUserSource(parseInt(args[1]))
			if tplayer then
				vRPclient.teleport(source,vRPclient.getPosition(tplayer))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpway',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,'toogleadmin.permissao') or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		TriggerClientEvent('tptoway',source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('car',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,'toogleadmin.permissao') or vRP.hasPermission(user_id,"mod.permissao") then
		if args[1] then
			TriggerClientEvent('spawnarveiculo',source,args[1])
			SendWebhookMessage(webhookcarro,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SPAWNOU]: "..(args[1]).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ADM
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('adm', function(source, args, rawCmd)
	local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.permissao') or vRP.hasPermission(user_id, 'mod.permissao') then
        if args[1] then
            local tipo = args[1]
			if (tipo == 'normal') or (tipo == 'verm') or (tipo == 'ai') then
				
                local titulo = vRP.prompt(source, 'Título da mensagem', 'AVISO ADMIN')
				if titulo == '' then TriggerClientEvent('chatMessage', source, '[ERROR]', {255,0,0}, 'Você não especificou um título.' ) return	end

				local msg = vRP.prompt(source, 'Mensagem', '')
				if msg == '' then TriggerClientEvent('chatMessage', source, '[ERROR]', {255,0,0}, 'Você não especificou uma mensagem.' ) return end

				TriggerClientEvent('feijontsUi:MostrarNotAdm', -1, {titulo, msg, tipo})
			end
		else
			TriggerClientEvent('chatMessage', source, '[ERROR]', {255,0,0}, 'O tipo precisa ser válido. Tipos válidos: verm, ai' )
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('pon',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,'toogleadmin.permissao') or vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
        local users = vRP.getUsers()
        local players = ""
        local quantidade = 0
        for k,v in pairs(users) do
            if k ~= #users then
                players = players..", "
            end
            players = players..k
            quantidade = quantidade + 1
        end
        TriggerClientEvent('chatMessage',source,"TOTAL ONLINE",{255,160,0},quantidade)
        TriggerClientEvent('chatMessage',source,"ID's ONLINE",{255,160,0},players)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAT ADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('aa',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "chatstaff.permissao"
		if vRP.hasPermission(user_id,permission) then
			local soldado = vRP.getUsersByPermission(permission)
			for l,w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player,"[CHAT ADMIN] ["..user_id.."] "..identity.name.." "..identity.firstname,{164,132,255},rawCommand:sub(3))
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------
-- /KILL 
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('kill',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,'toogleadmin.permissao') or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                vRPclient.killGod(nplayer)
                vRPclient.setHealth(nplayer,101)
				SendWebhookMessage(webhookkill,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[DEU KILL NO ID:]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
            end
        else
            vRPclient.killGod(source)
            vRPclient.setHealth(source,101)
            vRPclient.setArmour(source,0)
			
        end
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUEL
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('admfuel',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"admin.permissao") then
			TriggerClientEvent("admfuel",source)
		end	
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RADM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('radm',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then

        if vRP.hasPermission(user_id,"radm.permissao") then
            if args[1] then
                local identity = vRP.getUserIdentity(user_id)
                local theMessage = vRP.prompt(source,"Message:","")

                if theMessage == "" then return end


                local playerSource = vRP.getUserSource(parseInt(args[1]))
                local thePlayerId = vRP.getUserId(playerSource)
                local thePlayerIdentity = vRP.getUserIdentity(thePlayerId)

                --Source recives message
                TriggerClientEvent("Notify",source,"sucesso","Sucesso","Mensagem enviada com sucesso.",5000)

                ---Other player recive message
                TriggerClientEvent('chatMessage',parseInt(playerSource),"[ATENDIMENTO ADM] "..identity.name.." "..identity.firstname.." respondeu você:",{164, 0, 9},theMessage)

                --Message to admin's

                local adminDisplay = vRP.getUsersByPermission("radm.permissao")
                for l,w in pairs(adminDisplay) do
                    local adminSource = vRP.getUserSource(parseInt(w))
                    if adminSource then
                        async(function()
                            TriggerClientEvent('chatMessage',adminSource,"[ATENDIMENTO ADM] "..identity.name.." "..identity.firstname.." respondeu "..thePlayerIdentity.name.." "..thePlayerIdentity.firstname.." ("..thePlayerId.."):",{173, 0, 9},theMessage)
                        end) 
                    end
                end
            end


        end


    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
---ADM COBRAR
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare('admcobraroffline', 'UPDATE vrp_user_moneys SET wallet = @wallet, bank = @bank WHERE user_id = @user_id')
vRP.prepare('admcobrargetinfo', 'SELECT * FROM vrp_user_moneys WHERE user_id = @user_id')

RegisterCommand('admcobrar', function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,'toogleadmin.permissao') or vRP.hasPermission(user_id,"mod.permissao") then
        local nuser_id = parseInt(args[1])
        local nsource = vRP.getUserSource(nuser_id)
        local quantidade = tonumber(args[2])
        local identity = vRP.getUserIdentity(user_id)
        if nsource then
            vRP.tryFullPayment(nuser_id,quantidade)
            TriggerClientEvent("Notify",nsource,"financeiro","Financeiro","O Governo Federal tomou $"..vRP.format(quantidade).." de sua conta bancária.")
            TriggerClientEvent("Notify",source,'financeiro','Financeiro',"[ONLINE] O Governo Federal tomou $"..vRP.format(quantidade).." da conta bancária do ID " .. args[1])
            SendWebhookMessage(webhookcobraradm,"```prolog\n[=========COBRAR ADM ONLINE=========]\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU DO ID]: "..nuser_id.." \n[QUANTIDADE]: $"..quantidade.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
        else
            local pesquisa = vRP.query('admcobrargetinfo', {user_id = nuser_id})
            local carteira, banco = parseInt(pesquisa[1].wallet), parseInt(pesquisa[1].bank)
            if carteira + banco >= quantidade then
                if carteira >= quantidade then
                    carteira = 0
                else
                    quantidade = quantidade - carteira
                    carteira = 0
                    banco = banco - quantidade
                end
                vRP.execute('admcobraroffline', {user_id = nuser_id, wallet = carteira, bank = banco})
                TriggerClientEvent("Notify",source,'financeiro','Financeiro',"[OFFLINE] O Governo Federal tomou $"..vRP.format(quantidade).." da conta bancária do ID " .. args[1])
                SendWebhookMessage(webhookcobraradm,"```prolog\n[=========COBRAR ADM OFFLINE=========]\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU DO ID]: "..nuser_id.." \n[QUANTIDADE]: $"..quantidade.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
            else
                TriggerClientEvent('Notify', source, 'negado', 'Negado', 'O jogador não possui toda essa quantia.')
            end
        end
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------
-- ADM ENVIAR DINHEIRO
------------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare('admenviardinheiro', 'UPDATE vrp_user_moneys SET wallet = @wallet, bank = @bank WHERE user_id = @user_id')
vRP.prepare('admenviardinheiro', 'SELECT * FROM vrp_user_moneys WHERE user_id = @user_id')

RegisterCommand('admenviardinheiro', function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,'toogleadmin.permissao') then
        local nuser_id = parseInt(args[1])
        local nsource = vRP.getUserSource(nuser_id)
        local quantidade = tonumber(args[2])
        local identity = vRP.getUserIdentity(user_id)
        if nsource then
            vRP.giveBankMoney(nuser_id,parseInt(quantidade))
            TriggerClientEvent("Notify",nsource,"financeiro","Financeiro","O Governo Federal adicionou $"..vRP.format(quantidade).." em sua conta bancária.")
            TriggerClientEvent("Notify",source,'financeiro','Financeiro',"[ONLINE] O Governo Federal adicionou $"..vRP.format(quantidade).." na conta bancária do ID " .. args[1])
            SendWebhookMessage(webhookenviaradm,"```prolog\n[=========ENVIAR ADM ONLINE=========]\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[ADICIONOU NO ID]: "..nuser_id.." \n[QUANTIDADE]: $"..quantidade.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
        else
            local pesquisa = vRP.query('admenviardinheiro', {user_id = nuser_id})
            local carteira, banco = parseInt(pesquisa[1].wallet), parseInt(pesquisa[1].bank)
            if banco >= 0 then
                banco = banco + quantidade
            end
            vRP.execute('admenviardinheiro', {user_id = nuser_id, wallet = carteira, bank = banco})
            TriggerClientEvent("Notify",source,'financeiro','Financeiro',"[OFFLINE] O Governo Federal adicionou $"..vRP.format(quantidade).." na conta bancária do ID " .. args[1])
            SendWebhookMessage(webhookenviaradm,"```prolog\n[=========ENVIAR ADM OFFLINE=========]\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[ADICIONOU NO ID]: "..nuser_id.." \n[QUANTIDADE]: $"..quantidade.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
        end
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------
-- UNLOCK ADM
------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('unlock', function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local vehicle,vnetid,placa,vname,lock,banned,trunk,model,street = vRPclient.vehList(source,7)
    if vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,'toogleadmin.permissao') or vRP.hasPermission(user_id,"admin.permissao") then
        TriggerEvent("setPlateEveryone",placa)
        vGARAGE.vehicleClientLock(-1,vnetid,lock)
        TriggerClientEvent("vrp_sound:source",source,'lock',0.5)
        TriggerClientEvent("Notify",source,"sucesso","Sucesso","Veiculo destrancado")
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------
-- CONSOLE
------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('console',function(source,args,rawCommand)
    if source == 0 then
        if args[1] then
            TriggerClientEvent('chatMessage',-1,"FLAME CONSOLE ",{255,0,0},rawCommand:sub(8))
        end
    end
end)
-------------------------------------------------------------------------------------------------------------------------------
-- Kickall
-------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('kickall', function(source)
	if source == 0 or vRP.hasPermission(user_id,'toogleadmin.permissao') or vRP.hasPermission(vRP.getUserId(source),'admin.permissao') then
		TriggerEvent('feijonts:rr',false)
		for k,v in pairs(vRP.getUsers()) do
			aviso(source,'[FLAME RP] O USER_ID ' .. k .. ' SAIU DO SERVIDOR!')
			vRP.kick(v,'[FLAME RP] O servidor está desligando, voltaremos em breve! Aproveite para fechar seu FiveM e se preparar para entrar novamente!\n\n\n\n')
		end
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MANUTENCAO
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('manutencaoon', function(source)
	if source == 0 or vRP.hasPermission(vRP.getUserId(source),'admin.permissao') then
		aviso(source,'[FLAME RP] Manutencao ligada com sucesso!')
		TriggerEvent('feijonts:blockentering',false)
	end
end)

RegisterCommand('manutencaooff', function(source)
	if source == 0 or vRP.hasPermission(vRP.getUserId(source),'admin.permissao') then
		aviso(source,'[FLAME RP] Manutencao desligada com sucesso!')
		TriggerEvent('feijonts:blockentering',true)
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- RR
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rron', function(source)
	if source == 0 or vRP.hasPermission(vRP.getUserId(source),'admin.permissao') then
		aviso(source,'[FLAME RP] Reinicio ligado com sucesso!')
		TriggerEvent('feijonts:rr',false)
	end
end)

RegisterCommand('rroff', function(source)
	if source == 0 or vRP.hasPermission(vRP.getUserId(source),'admin.permissao') then
		aviso(source,'[FLAME RP] Reinicio desligado com sucesso!')
		TriggerEvent('feijonts:rr',true)
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- AVISO
------------------------------------------------------------------------------------------------------------------------------------------------------------------
function aviso(source,aviso)
	if source == 0 then
		print(aviso)
	elseif source > 0 then
		TriggerClientEvent('Notify', source, 'aviso', 'Aviso', aviso)
	end
end