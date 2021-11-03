--[[
	id: _NuoW7iB9-bPXIPOh4jtF
	name: entis nuevo aparte
	description: todos de entis
	time1: 2021-07-21 08:28:50.375091+00
	time2: 2021-07-21 08:28:50.375092+00
	uploader: VVNt0cj-hz2CH5jkESZw-kkH85LAm5IYdVDsmdWe
	uploadersession: 8Jd9DLXQYEfzu5DDIJNeydUIF5Nmsi
	flag: f
--]]


function IsPropBlacklisted(a6)
    local a7 = GetEntityModel(a6)
    if a7 ~= nil then
        if GetEntityType(a6) == 1 and GetEntityPopulationType(a6) == 7 then
            return true
        end
        for i = 1, #ListBK.EntidadesBL do
            local a8 =
                tonumber(ListBK.EntidadesBL[i]) ~= nil and tonumber(ListBK.EntidadesBL[i]) or
                GetHashKey(ListBK.EntidadesBL[i])
            if a8 == a7 then
                return true
            end
        end
    end
    return false
end
function IsPropBlscklistedBan(s6)
    local s7 = GetEntityModel(s6)
    if s7 ~= nil then
        if GetEntityType(s6) == 1 and GetEntityPopulationType(s6) == 7 then
            return true
        end
        for i = 1, #ListBK.EntidadesBAN do
            local s8 =
                tonumber(ListBK.EntidadesBAN[i]) ~= nil and tonumber(ListBK.EntidadesBAN[i]) or
                GetHashKey(ListBK.EntidadesBAN[i])
            if s8 == s7 then
                return true
            end
        end
    end
    return false
end

local dataEnti = {
    {id=0, ultima='tug', numero=1, numis=0, numeroth=0},
}
Citizen.CreateThread(function()
while true do
Citizen.Wait(8000)
for k=1, #dataEnti do
dataEnti[k].numeroth = 0
end
end 
end)
local log = false
local anti = true
local cancelar = false
RegisterCommand('anti', function(source, args)
if source == 0 then
    if args[1] == 'c' then
        if cancelar == false then
            print('\n ^6Cancelar ^2TRUE')
        cancelar = true
        else
            print('\n ^6Cancelar ^1FALSE')
            cancelar = false
        end
    end     
if anti == true then
anti = false 
print('Anti Meduza SPAM desactivado')
else anti = true
print('Anti Meduza SPAM Activado') end end end)
RegisterCommand('snowiLag', function(source, args)
if source == 0 then
if quitoLag == true then
    quitoLag= false
print('Quito lag to ', quitoLag)
else    
    quitoLag = true
print('Quito lag to ', quitoLag)
end end end)
local maxEntiDrop = 12
local maxEntiWarn = 3
RegisterCommand('maxEnt', function(source, args)
if source == 0 then
if args[1] == 'drop' then
    maxEntiDrop = tonumber(args[2])
    print('maxEntiDrop to ->', maxEntiDrop)
elseif args[1] == 'warn' then
    maxEntiWarn = tonumber(args[2])
    print('maxEntiWarn to ->', maxEntiWarn)
else
    print('Args invalidos, args validos ->\n- drop (numero de entidades maximo para dropear al jugador)\n- warn(numero de entidades maximo para dar warning en consola)')
end

end end
 )
 RegisterCommand("snowidale", function(source, args, rawCommand) if source == 0 then TriggerClientEvent("snowi:fallout", -1) print('Limpieza de entidades con exito! All') return end TriggerClientEvent("snowi:fallout",source) print('Limpieza de entidades con exito! Source') end)
RegisterCommand('logs', function(source, args)
    if source == 0 then
    if log == true then
        print('Logs anti SPAM desactivado')
    log = false
    else log = true
        print('Logs anti SPAM activado')
    end end end)
    AddEventHandler(
        "entityCreating",
        function(s6,s)
            if quitoLag == true then
                print('Activado QuitoLag', quitoLag)
                return
            end
            local laenti = GetEntityModel(s6)
            local idd = NetworkGetEntityOwner(s6)
            if log == true then
            print(GetEntityModel(s6)..' ID['..idd..']', json.encode(s))
            end
            if laenti == 0 then return end
            if anti == true then
            for me=1, #dataEnti do
                if idd == dataEnti[me].id then
                    dataEnti[me].numero = dataEnti[me].numero +1
                    if dataEnti[me].numero >= maxEntiDrop then
                        DropPlayer(idd, 'SNOWI - AC || ANTI SPAM DE ENTIDADES \n Ultima entidad:'..laenti..' \n Número de entidad:'..dataEnti[me].numero)
                        CancelEvent()
                    elseif dataEnti[me].ultima == laenti and dataEnti[me].numero >= maxEntiWarn then
                        dataEnti[me].numis = dataEnti[me].numis +1
                            print('Jugador con ID['..idd..'] Creando entidad igual a la anterior entidad:'..laenti..' || Número de entidad:'..dataEnti[me].numero..' Número de misma entidad:'..dataEnti[me].numis)
                            if cancelar == true then
                            CancelEvent()
                            end
                    else
                        dataEnti[me].ultima = laenti
                        dataEnti[me].numis = 0
                        print('Jugador con ID['..idd..'] Creó la ['..dataEnti[me].numero..'] entidad:'..laenti)
                        if cancelar == true then
                      CancelEvent()
                        end
                    end
                else
                    table.remove(dataEnti, 1)
                    table.insert(dataEnti, {id=idd, ultima=laenti, numero=1, numis=0, numeroth=0})
                end
            end
        end
            if Settings.EntiBan then
            local s6 = s6
            if not DoesEntityExist(s6) then
                return
            end
            local s9 = NetworkGetEntityOwner(s6)
            local aa = NetworkGetNetworkIdFromEntity(s6)
            local sb = GetPlayerName(s9)
            
            if IsPropBlscklistedBan(s6) then
                CancelEvent()
            end
            if GetEntityType(s6) ~= 0 then
                local s7 = GetEntityModel(s6)
                local sb = GetPlayerName(s9)
                for i, sc in ipairs(ListBK.EntidadesBAN) do
                    local msjban = '⚠️ '..sc..' ⚠️'
                    if s7 == GetHashKey(sc) then
                        if s9 == nil then
                        elseif sb == nil then
                        else
                            print(
                                "^0[^3" ..
                                    sc .. "^0] ^3Jugador: ^0[^3" .. s9 .. "^0] " .. sb
                            )
                            TriggerEvent('snw:banobj', s9, msjban)
                            CancelEvent()
                            return
                        end
                        local s1 = "Deteccion de Objeto ^1BAN:^4 " .. sc
                        Citizen.Wait(1000)
                    end
                end
            end
            if Settings.Enti then
                local s6 = s6
                if not DoesEntityExist(s6) then
                    return
                end
                local a9 = NetworkGetEntityOwner(s6)
                local aa = NetworkGetNetworkIdFromEntity(s6)
                if IsPropBlacklisted(s6) then
                    CancelEvent()
                end
                if GetEntityType(s6) ~= 0 then
                    local a7 = GetEntityModel(s6)
                    local ab = GetPlayerName(a9)
                    for v, ac in ipairs(ListBK.EntidadesBL) do
                        if a7 == GetHashKey(ac) then
                            if a9 == nil then
                            elseif ab == nil then
                            else
                                print(
                                    "^0[^3" ..
                                        ac .. "^0] ^3Jugador: ^0[^3" .. a9 .. "^0] " .. ab
                                )
                                CancelEvent()
                            return
                            end
                            local a1 = "Deteccion de Objeto Bloqueado: " .. ac
                            Citizen.Wait(1000)
                        end
                    end
                end
            end
        end
        end
    )