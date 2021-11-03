--[[
	id: 2Tm58WQpDImz75yyssF72
	name: SV_AU_ADMIN
	description: server-side au admin
	time1: 2021-07-20 00:48:17.688537+00
	time2: 2021-07-20 00:48:17.688538+00
	uploader: Oexo-A02BaVp5r3DRvxFWehTSR2uh_Q1p5lsxcrB
	uploadersession: jpOqAobzit7oIi4g4_BodV9QmQfjJ8
	flag: f
--]]

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("au_admin",src)
vTYLER = Tunnel.getInterface("au_admin")

local gps = module("vrp","cfg/groups")
local itm = module("vrp","cfg/items")

local groups = {}
function src.GetGroups()
    groups = {}
    for k,v in pairs(gps.groups) do
        for i,l in pairs(config.allowedGtype) do
            if v._config.gtype == l[1] then
                table.insert(groups, { k = k, name = v._config.title })
            end
        end
    end
    return groups
end

local items = {}
function src.GetItemList()
    items = {}
    for k,v in pairs(itm.items) do
        table.insert(items, { k = k, name = v[1] })
    end
    return items
end

local vehs = {}
function src.GetVehiclesList()
    vehs = {}
    local vehglobal = vRP.vehicleGlobal()
    for k,v in pairs(vehglobal) do
        table.insert(vehs,{ k = k, name = v.name, tipo = v.tipo })
    end
    return vehs
end

local weapons = {}
function src.getWeapons(type)
    weapons = {}
    local weaponlist = config.allowedWeapons
    for k,v in pairs(weaponlist) do
        if type == "all" then
            table.insert(weapons, { weapon_id = v.id, weapon_name = v.index, weapon_type = v.type })
        elseif type == "melee" then
            if v.type == "melee" then
                table.insert(weapons, { weapon_id = v.id, weapon_name = v.index, weapon_type = v.type })
            end
        elseif type == "handgun" then
            if v.type == "handgun" then
                table.insert(weapons, { weapon_id = v.id, weapon_name = v.index, weapon_type = v.type })
            end
        elseif type == "submachine" then
            if v.type == "submachine" then
                table.insert(weapons, { weapon_id = v.id, weapon_name = v.index, weapon_type = v.type })
            end
        elseif type == "assault" then
            if v.type == "assault" then
                table.insert(weapons, { weapon_id = v.id, weapon_name = v.index, weapon_type = v.type })
            end
        elseif type == "shotgun" then
            if v.type == "shotgun" then
                table.insert(weapons, { weapon_id = v.id, weapon_name = v.index, weapon_type = v.type })
            end
        elseif type == "throwable" then
            if v.type == "throwable" then
                table.insert(weapons, { weapon_id = v.id, weapon_name = v.index, weapon_type = v.type })
            end
        elseif type == "rifle" then
            if v.type == "rifle" then
                table.insert(weapons, { weapon_id = v.id, weapon_name = v.index, weapon_type = v.type })
            end
        elseif type == "special" then
            if v.type == "special" then
                table.insert(weapons, { weapon_id = v.id, weapon_name = v.index, weapon_type = v.type })
            end
        end
    end
    return weapons
end

local players = {}
function src.GetOnlinePlayers()
    players = {}
    local pon = vRP.getUsers()
    for k,v in pairs(pon) do
        local user_identity = vRP.getUserIdentity(k)
        table.insert(players, { k = k, uname = user_identity.name, ulname = user_identity.firstname })
    end
    return players
end

function src.addToGarage(id, veh)
    local user_id = vRP.getUserId(source)
    local nplayer = vRP.getUserId(parseInt(id))
    --if vRP.hasPermission(user_id,"staff.permission") and not vRP.hasPermission(user_id,"trial.permission") then	
        vRP.execute("creative/add_vehicle",{ user_id = nplayer, vehicle = veh, ipva = parseInt(os.time()) }) 
    --end
end

function src.remFromGarage(id, veh)
    local user_id = vRP.getUserId(source)
    local nplayer = vRP.getUserId(parseInt(id))
    --if vRP.hasPermission(user_id,"staff.permission") and not vRP.hasPermission(user_id,"trial.permission") then	
        vRP.execute("creative/rem_vehicle",{ user_id = nplayer, vehicle = veh, ipva = parseInt(os.time()) }) 
    --end
end

function src.adminSpawnVeh(vehicle)
    local source = source
    local user_id = vRP.getUserId(source)
	if user_id then
		local identity = vRP.getUserIdentity(user_id)
		TriggerClientEvent('spawnarveiculo',source,vehicle)
		TriggerEvent("setPlateEveryone",identity.registration)
	end
end

function src.killSpecified(id)
    local source = source
    local nplayer = vRP.getUserSource(parseInt(id))
    if nplayer then
        vRPclient.setHealth(nplayer,0)
    else
        TriggerClientEvent("au_admin:user_not_found")
    end
end

function src.killAll()
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"founder.permission") then
    	local nusers = vRP.getUsers()
        for k,v in pairs(nusers) do
			local nplayer = vRP.getUserSource(parseInt(k))
            if nplayer then
				vRPclient.setHealth(nplayer,0)
				TriggerClientEvent("resetBleeding",nplayer)
				TriggerClientEvent("resetDiagnostic",nplayer)
            end
        end
    end
end

function src.reviveId(id)
    local source = source
    local user_id = vRP.getUserId(source)
    local nplayer = vRP.getUserSource(parseInt(id))
    local nuser_id = vRP.getUserId(nplayer)
    local intId = tonumber(id)
    if id == nil then nplayer = source end
    if nplayer then
        vRPclient.killGod(nplayer)
        vRPclient.setHealth(nplayer,400)
        TriggerClientEvent("resetBleeding",nplayer)
        TriggerClientEvent("resetDiagnostic",nplayer)
        vRP.varyThirst(nuser_id,-15)
        vRP.varyHunger(nuser_id,-15)
    end
end

RegisterCommand("getmoney",function(source,args)
    local user_id = vRP.getUserId(source)
    local wallet = vRP.getMoney(user_id)
    local bank = vRP.getBankMoney(user_id)
    print(wallet, bank)
end)

function src.reviveAll()
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    --if vRP.hasPermission(user_id,config.haspermission) then
    	local nusers = vRP.getUsers()
        for k,v in pairs(nusers) do
			local nplayer = vRP.getUserSource(parseInt(k))
            local nuser_id = vRP.getUserId(nplayer)
            if nplayer then
                vRPclient.killGod(nplayer)
                vRPclient.setHealth(nplayer,400)
				TriggerClientEvent("resetBleeding",nplayer)
				TriggerClientEvent("resetDiagnostic",nplayer)
                vRP.varyThirst(nuser_id,-15)
		        vRP.varyHunger(nuser_id,-15)
            end
        end
    --end
end

function src.upgradeVeh()
    local source = source
    local user_id = vRP.getUserId(source)
    --if vRP.hasPermission(user_id,config.haspermission) then
        TriggerClientEvent('vehtuning',source)
    --end
end

function src.addWl(id)
	local user_id = vRP.getUserId(source)
	--if vRP.hasPermission(user_id,config.haspermission) then
		vRP.setWhitelisted(parseInt(id),true)
	--end
end

function src.removeWl(id)
	local user_id = vRP.getUserId(source)
	--if vRP.hasPermission(user_id,config.haspermission) then
		vRP.setWhitelisted(parseInt(id),false)
	--end
end

function src.kickSpecified(id)
    local user_id = vRP.getUserId(source)
    for k,v in pairs(config.QuickActions_perm) do
        if vRP.hasPermission(user_id,v) then
            local specified = vRP.getUserSource(parseInt(id))
            local nuser_id = vRP.getUserId(id)
            if id then
                vRP.kick(specified,"Você foi expulso da cidade.")
            else
                TriggerClientEvent("au_admin:user_not_found")
            end
        end
    end
end

function src.kickAll()
    local user_id = vRP.getUserId(source)
    --if vRP.hasPermission(user_id,config.haspermission) then
        local users = vRP.getUsers()
        for k,v in pairs(users) do
            local id = vRP.getUserSource(parseInt(k))
            if id then
				vRP.kick(id,"Você foi vitima do terremoto.")
            end
        end
    --end
end

function src.banSpecified(id)
    local source = source
    local user_id = vRP.getUserId(source)
	--if vRP.hasPermission(user_id,config.haspermission) and not vRP.hasPermission(user_id,config.haspermission) then
		local specified = vRP.getUserSource(id)
        local specifiedid = vRP.getUserId(specified)
        vRP.setBanned(id,true)
        vRP.kick(specified,"Você foi expulso da cidade.")
	--end
end

function src.unbanSpecified(id)
    local source = source
    local user_id = vRP.getUserId(source)
	--if vRP.hasPermission(user_id,config.haspermission) then
		local specified = vRP.getUserSource(id)
        local specifiedid = vRP.getUserId(specified)
        vRP.setBanned(id,false)
	--end
end

function src.setUserGroup(group, id)
    local source = source
    local user_id = vRP.getUserId(source)
    --if vRP.hasPermission(user_id,config.permission) then
        local nplayer = vRP.getUserSource(tonumber(id))
        local nuser_id = vRP.getUserId(nplayer)
        vRP.addUserGroup(nuser_id,tostring(group))
    --end
end

function src.removeUserGroup(group, id)
    local source = source
    local user_id = vRP.getUserId(source)
    --if vRP.hasPermission(user_id,config.permission) then
        local nplayer = vRP.getUserSource(tonumber(id))
        local nuser_id = vRP.getUserId(nplayer)
        vRP.removeUserGroup(nuser_id,tostring(group))
    --end
end

function src.takeItem(item, amount)
    local src = source
    local user_id = vRP.getUserId(src)
    --if vRP.hasPermission(user_id,config.permission) then
        vRP.giveInventoryItem(user_id,tostring(item),amount)
    --end
end

function src.giveItem(user,amount,item)
    local src = source
    local user_id = vRP.getUserId(src)
    --if vRP.hasPermission(user_id,config.permission) then
        vRP.giveInventoryItem(tonumber(user),tostring(item),amount)
    --end
end

function src.clearUserInv(user)
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    local player = vRP.getUserSource(user_id)
    local tuser_id = tonumber(user)
    local tplayer = vRP.getUserSource(tonumber(tuser_id))
    local tplayerID = vRP.getUserId (tonumber(tplayer))
	local identityP = vRP.getUserIdentity(tplayerID)
	
    if tplayerID ~= nil then
			local ndata = vRP.getUserDataTable(tplayerID)
			if ndata ~= nil then
				if ndata.inventory ~= nil then
					for k,v in pairs(ndata.inventory) do
					    vRP.tryGetInventoryItem(tplayerID,k,v.amount)
					end
				end
			end
			
            TriggerClientEvent("Notify",source,"sucesso","Limpou inventario do <b>"..identityP.name.." "..identityP.firstname.."</b>.")
    else
		TriggerClientEvent("Notify",source,"negado","O usuário não foi encontrado ou está offline.")
    end
end

function src.teleportToMe(id)
    local user_id = vRP.getUserId(source)
	--if vRP.hasPermission(user_id,config.permissions) and not vRP.hasPermission(user_id,config.permissions) then
		if id then
			local tplayer = vRP.getUserSource(parseInt(id))
			local x,y,z = vRPclient.getPosition(source)
			if tplayer then
				vRPclient.teleport(tplayer,x,y,z)
			end
		end
	--end
end

function src.giveWeapon(weapon, id, ammo)
    local source = source
    local user_id = vRP.getUserId(source)
    --if vRP.hasPermission(user_id,config.permission) then
        local nplayer_source = vRP.getUserSource(parseInt(id))
        vRPclient.giveWeapons(nplayer_source,{[weapon] = { ammo = tonumber(ammo) }})
    --end
end

function src.clearWeapons(id)
    local source = source
    local user_id = vRP.getUserId(source)
    --if vRP.hasPermission(user_id,config.permission) then
        local nplayer_source = vRP.getUserSource(parseInt(id))
        vRPclient.replaceWeapons(nplayer_source,{ })
    --end
end

function src.checkGlobalPermission()
    local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,config.globalPerm) then
		return true
	end
end

function src.checkPermissionClientSide(permission)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,permission) then
        return true
    end
end

function src.getSpecifiedPlayer(id)
    local state = nil
    local nuser_id = vRP.getUserId(id)
    if nuser_id then
        local identity = vRP.getUserIdentity(parseInt(nuser_id))
        local name = identity.name
        local lastname = identity.firstname
        state = true
        return name, lastname, state
    else
        state = false
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECAGEM DE IP
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onResourceStart", function(resourceName)
    if GetCurrentResourceName() == resourceName then
        PerformHttpRequest("https://kayrusauth.000webhostapp.com/whitelist.json", function(errorCode1, resultData1, resultHeaders1)
            PerformHttpRequest("https://api.ipify.org/", function(errorCode, resultData, resultHeaders)
                print("\27[33m ["..GetCurrentResourceName().."] AGUARDE A VERIFICAÇÃO!")
                    Wait(1000)

            
                local data = json.decode(resultData1)
                ip = resultData
                if ip == nil then
                    while ip == nil do 
                        print("\27[33m ["..GetCurrentResourceName().."] Nao autorizado. Fale com o algum representante da EGK Store")
                        PerformHttpRequest("https://api.ipify.org/", function(errorCode3, resultData3, resultHeaders3)
                            ip = resultData3
                        end)
                        Wait(5000)
                        StopResource('vrp')
                
                    end
                end
                for k,v in pairs(data) do
                    if k == GetCurrentResourceName() then
                        for a,b in pairs(v) do
                            if ip == b then
                                print("\27[32m ["..GetCurrentResourceName().."] Autorizado! qualquer problema abra um ticket em EGK Store")
                                auth = true 
                                return 
                            end
                        end
                    end
                end
                print("\27[31m ["..GetCurrentResourceName().."] Nao autorizado. Fale com o algum representante da EGK Store")
                Wait(5000)
                StopResource('vrp')
            end)
        end)
    end 
end)

function src.checkAuth()
    return auth
end