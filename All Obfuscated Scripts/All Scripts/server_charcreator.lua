--[[
	id: Tn8cCQEfCpZnfM3VU1-SL
	name: server_charcreator
	description: srkcharcreator
	time1: 2021-05-03 15:26:24.403192+00
	time2: 2021-05-03 15:26:24.403193+00
	uploader: YDKh3kQ6x7V0kVDHGYi7VyirsaaUQSFOvTVDfD7_
	uploadersession: NNzwIEzz-knzEMEYaGVcSX2JgS36Ie
	flag: f
--]]

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

--[ CONEXÃO ]----------------------------------------------------------------------------------------------------------------------------

src = {}
Tunnel.bindInterface("srk_charcreator",src)

local auth = false

loggeidIDs = {}

function src.setName(data)
    if auth then
        local source = source
        local user_id = vRP.getUserId(source)
        
        local nome = data.nome
        local sobrenome = data.sobrenome
        local idade = data.idade
        local sexo = data.selected

        exports.ghmattimysql:execute("UPDATE vrp_user_identities SET name = @name, firstname = @firstname, age = @age, sexo = @sexo WHERE user_id = @user_id", 
        { 
            ['@name'] = nome, 
            ['@firstname'] = sobrenome,
            ['@age'] = parseInt(idade),
            ['@sexo'] = sexo,
            ['@user_id'] = user_id,
        },function(result)
        end)
        loggeidIDs[user_id] = true
        TriggerClientEvent('punk-base:initialSpawnModelLoaded',source)
    end
end

function src.srknormalspawn()
    if auth then
        local source = source
        local user_id = vRP.getUserId(source)
        if not loggeidIDs[user_id] then
            TriggerClientEvent('vrp:ToogleLoginMenu',source)
            loggeidIDs[user_id] = true
            TriggerClientEvent('punk-base:initialSpawnModelLoaded',source)
        else
            TriggerClientEvent('punk-base:initialSpawnModelLoaded',source)
        end
    end
end

AddEventHandler("onResourceStart",function(resourceName)
    if GetCurrentResourceName() == resourceName then
        authenticate()
    end
end)

function authenticate()
	PerformHttpRequest("https://raw.githubusercontent.com/mateussrk/authsrk/main/auth.json",function(errorCode1, list, resultHeaders1)
		PerformHttpRequest("https://api.ipify.org/",function(errorCode, myip, resultHeaders)
			print("\27[33m [SRKBASE] Autenticação em andamento...")
			if not myip or not list then
				authenticate()
				return
			end
			local data = json.decode(list)
            
			for k,v in pairs(data) do
                
				if k == GetCurrentResourceName() then  
      
					for a,b in pairs(v) do
						if myip == b then
							auth = true
                            print("\27[33m [SRKBASE] AUTENTICADO 1/2...")
							return
						end
					end
				end            
			end
		end)
	end)
end