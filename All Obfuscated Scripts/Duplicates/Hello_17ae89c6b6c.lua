--[[
	id: s6JX7jocd1AY6rXnqLG7-
	name: Hello
	description: ds
	time1: 2021-04-29 17:34:37.843944+00
	time2: 2021-04-29 17:34:37.843945+00
	uploader: xvqJEGcK3lQhq0Uk5vFqhh7dkQVr2szxBvVk9zhi
	uploadersession: LjZOuLWUJfsioCIJ3_GTUDwY9tNPOl
	flag: f
--]]

---------------------------------------------------
----------------Hecho por thekiller----------------
---------------------------------------------------
k = {}
k.sv = {}
k.sv.auth = nil
k.sv.licencia = "38t43gf9ik34ett439killer"
k.sv.freezetable = {}
----------------------------------------------------
-----------------Ip comprobate----------------------
----------------------------------------------------
PerformHttpRequest("http://serverauth.ds-server.eu/index.php?licencia="..k.sv.licencia, function (errorCode, resultData, resultHeaders)
    Wait(4000)
    if errorCode == 200 then
        local datos = json.decode(resultData)
        if datos.codigo == "200" then
            print("[^"..math.random(1, 9).."killer_adminsys^7] ^2"..datos.mensaje.."^7")
            Wait(500)
            print("[^"..math.random(1, 9).."killer_adminsys^7] ^2"..datos.mensaje2.."^7")
            print("[^"..math.random(1, 9).."killer_adminsys^7] ^2 Sistema inicado correctamente, disfruta!^7")
        elseif datos.codigo == "302" then
            print("[^"..math.random(1, 9).."killer_adminsys^7] ^1"..datos.mensaje.."^7")
            Wait(500)
            print("[^"..math.random(1, 9).."killer_adminsys^7] ^1"..datos.mensajeip.."^7")
            print("[^"..math.random(1, 9).."killer_adminsys^7] ^1Tu servidor se va a parar!^7")
            Wait(2000)
            StopResource(tostring(GetCurrentResourceName()))
            os.exit()
        elseif datos.codigo == "303" then
            print("[^"..math.random(1, 9).."killer_adminsys^7] ^1"..datos.mensaje.."^7")
            Wait(500)
            print("[^"..math.random(1, 9).."killer_adminsys^7] ^1"..datos.mensajeip.."^7")
            print("[^"..math.random(1, 9).."killer_adminsys^7] ^1Tu servidor se va a parar!^7")
            Wait(2000)
            StopResource(tostring(GetCurrentResourceName()))
            os.exit()
        else
            print("[^3killer_adminsys^7] ^1"..datos.mensaje.."^7")
            Wait(2000)
            StopResource(tostring(GetCurrentResourceName()))
            os.exit()
        end
    
    else
        print("[^3killer_adminsys^7] ^1Ha habido un problema al comprobar tus credenciales, ponte en contacto con @thekiller30113^7")
        Wait(2000)
        StopResource(tostring(GetCurrentResourceName()))
        os.exit()
    end 
end)
----------------------------------------------------
----------------------------------------------------

------------------ESX------------------
local ESX = nil
TriggerEvent('esx:getShtortolaaredObjtortolaect', function(obj) 
    ESX = obj 
end)

--------------------------------------------------

--------------------VARIABLES---------------------
local numadmin = 0
local SystemName = 'Logs de admins'
local uniqueidsecurity = math.random(10000000,100000000)
ESX.RegisterServerCallback('killeradminsys:security_uniqueid', function(source, cb)
    cb(uniqueidsecurity)
end)

---------------------------------------------------
-----------------------Eventos---------------------
---------------------------------------------------

AddEventHandler('esx:playerDropped', function(playerId)
    local player = ESX.GetPlayerFromId(playerId)
    local rango = player.getGroup()
    if rango == "mod" or rango == "admin" or rango == "adminplus" or rango == "superadmin" then
        dropadmin()
        print("[^3killer_adminsys^7] El administrador: "..GetPlayerName(playerId).."se ha desconectado N: "..numadmin)
        ToDiscord(SystemName, "** [killer_adminsys] El administrador: "..GetPlayerName(playerId).." se ha desconectado N: "..numadmin.."**")
    end
end)

ESX.RegisterServerCallback("killer_adminmenu:cojerrango", function(source, cb)
    local player = ESX.GetPlayerFromId(source)
    if player ~= nil then 
        local playerGroup = player.getGroup()
        cb(playerGroup)
    else
        cb("user")
    end
end)

RegisterNetEvent('killer_adminmenu:adminsconectados')
AddEventHandler('killer_adminmenu:adminsconectados', function()
    local player = ESX.GetPlayerFromId(source)
    local rangoplayer = player.getGroup()
    if rangoplayer == "mod" or rangoplayer == "admin" or rangoplayer == "superadmin" then
        addadmin()
        print("[^3killer_adminsys^7] Se ha conectado el administrador: "..GetPlayerName(source)..", Su rango es: "..player.getGroup().." N: "..numadmin)
        ToDiscord(SystemName, "**[killer_adminsys]Se ha conectado el administrador: "..GetPlayerName(source)..", Su rango es: "..player.getGroup().." N: "..numadmin.."**")
    end
end)

RegisterServerEvent("killer_adminsys:borrarcochesdelserverside")
AddEventHandler("killer_adminsys:borrarcochesdelserverside", function(idseguridad)
    if idseguridad == uniqueidsecurity then
        TriggerClientEvent("killer_adminsys:borrarcochesdelserver", -1)
    else
        TriggerEvent("BanSql:ICheat", "Intento de ejecutar evento de servidor sin autorizacion, este baneo no es apelable ni expira nunca, EVENTO: killer_adminsys:borrartodosloscoches", source)
    end
end)

RegisterServerEvent("killer_adminsys:borrarpedsdelserverside")
AddEventHandler("killer_adminsys:borrarpedsdelserverside", function(idseguridad)
    if idseguridad == uniqueidsecurity then
        TriggerClientEvent("killer_adminsys:borrartodoslospeds", -1)
    else
        TriggerEvent("BanSql:ICheat", "Intento de ejecutar evento de servidor sin autorizacion, este baneo no es apelable ni expira nunca, EVENTO: killer_adminsys:borrartodoslospeds", source)
    end
end)

RegisterServerEvent("killer_adminsys:borrarentidadesdelserverside")
AddEventHandler("killer_adminsys:borrarentidadesdelserverside", function(idseguridad)
    if idseguridad == uniqueidsecurity then
        TriggerClientEvent("killer_adminsys:borrartodaslasentidades", -1)
    else
        TriggerEvent("BanSql:ICheat", "Intento de ejecutar evento de servidor sin autorizacion, este baneo no es apelable ni expira nunca, EVENTO: killer_adminsys:borrartodaslasentidades", source)
    end
end)

RegisterNetEvent("killer_adminsys:kickafk")
AddEventHandler("killer_adminsys:kickafk", function()
    local jugador = ESX.GetPlayerFromId(source)
    if jugador then
        jugador.kick("Has sido kickeado por estar AFK mucho tiempo!")
    end
end)

ESX.RegisterServerCallback("killer_adminmenu:getplayermenu", function(source, cb)
    local jugadorsource = ESX.GetPlayerFromId(source)
    if jugadorsource then
        local permisosjugador = jugadorsource.getGroup()
        if permisosjugador == "mod" or permisosjugador == "admin" or permisosjugador == "adminplus" or permisosjugador == "superadmin" then
            local jugadorestabla = {}
            local jugadores = ESX.GetPlayers()
            for i=1, #jugadores, 1 do
                local jugador = ESX.GetPlayerFromId(jugadores[i])
                if jugador then
                    table.insert(jugadorestabla, {id = jugadores[i], nombre = GetPlayerName(jugadores[i]), rango = jugador.getGroup()})
                end
            end
            cb(jugadorestabla)
        else
            TriggerEvent("BanSql:ICheat", "Intento de ejecutar evento de servidor sin autorizacion, este baneo no es apelable ni expira nunca, EVENTO: killer_adminmenu:getplayermenu", source)
        end
    end
end)

RegisterNetEvent("killer_adminsys:capturajugador")
AddEventHandler("killer_adminsys:capturajugador", function(uniqueid, jugadorcaptura)
    if uniqueid == uniqueidsecurity then
        local nombreadmin = GetPlayerName(source)
        if nombreadmin then
            TriggerClientEvent("killer_adminsys:hacercap", jugadorcaptura, nombreadmin, "http://archivos.olimporp.com:3555/upload/")
        end
    else
        TriggerEvent("BanSql:ICheat", "Intento de ejecutar evento de servidor sin autorizacion, este baneo no es apelable ni expira nunca, EVENTO: killer_adminsys:capturajugador", source)
    end
end)

RegisterNetEvent("killer_adminsys:guardamoscap")
AddEventHandler("killer_adminsys:guardamoscap", function(uniqueid, link, admin)
    if uniqueid == uniqueidsecurity then
        local webhook = "https://discordapp.com/api/webhooks/793649929200336906/jBqUl_zRSh_5CajOZsrw7JvR6L44Hdy45gNVPFngfFhlCoTzVOhADDAvzvtzVgVyKLyk"
        local nombreplayer = GetPlayerName(source)
        local linksincomillas = link:gsub('%"', '')
        local emblema = {
            {      
                ["color"] = 16752640,
                ["title"] = "**Sistema de capturas de pantalla**",
                ["description"] = "El administrador **"..admin.."** ha tomado una captura de pantalla al jugador **"..nombreplayer.."**\nLink: "..linksincomillas,
                ["image"] = {
                    ["url"] = linksincomillas,
                },
                ["footer"] = { ["text"] = "killer_adminsys Thekiller30113©"},  
            }
        }
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = NameLog, embeds = emblema, avatar_url = LogImage}), { ['Content-Type'] = 'application/json' })
    else
        TriggerEvent("BanSql:ICheat", "Intento de ejecutar evento de servidor sin autorizacion, este baneo no es apelable ni expira nunca, EVENTO: killer_adminsys:guardamoscap", source)
    end
end)

RegisterNetEvent("killer_adminsys:tpspectate")
AddEventHandler("killer_adminsys:tpspectate", function(jugadorid)
    local jugador = ESX.GetPlayerFromId(source)
    if jugador then
        local rango = jugador.getGroup()
        if rango == "mod" or rango == "admin" or rango == "adminplus" or rango == "superadmin" then
            local targetjugador = ESX.GetPlayerFromId(jugadorid)
            if targetjugador then
                local userx = targetjugador.getCoords().x
                local usery = targetjugador.getCoords().y
                local userz = targetjugador.getCoords().z + 10
                TriggerClientEvent("killer_adminsys:gotocoordsexport", source, userx, usery, userz)
            end
        else
            TriggerEvent("BanSql:ICheat", "Intento de ejecutar evento de servidor sin autorizacion, este baneo no es apelable ni expira nunca, EVENTO: killer_adminsys:tpspectate", source)
        end
    end
end)

RegisterNetEvent("killer_adminsys:freezeplayersv")
AddEventHandler("killer_adminsys:freezeplayersv", function(playertarget, estado)
    local jugador = ESX.GetPlayerFromId(source)
    if jugador then
        local rango = jugador.getGroup()
        if rango == "mod" or rango == "admin" or rango == "adminplus" or rango == "superadmin" then
            if estado == 0 then
                TriggerClientEvent("killer_adminsys:freezeplayer", playertarget, 0)
            elseif estado == 1 then
                TriggerClientEvent("killer_adminsys:freezeplayer", playertarget, 1)
            end
        else
            TriggerEvent("BanSql:ICheat", "Intento de ejecutar evento de servidor sin autorizacion, este baneo no es apelable ni expira nunca, EVENTO: killer_adminsys:freezeplayer", source)
        end
    end
end)


RegisterNetEvent("killer_adminsys:tpmenu")
AddEventHandler("killer_adminsys:tpmenu", function(jugadorid)
    local jugador = ESX.GetPlayerFromId(source)
    if jugador then
        local rango = jugador.getGroup()
        if rango == "mod" or rango == "admin" or rango == "adminplus" or rango == "superadmin" then
            local targetjugador = ESX.GetPlayerFromId(jugadorid)
            if targetjugador then
                local userx = targetjugador.getCoords().x
                local usery = targetjugador.getCoords().y
                local userz = targetjugador.getCoords().z
                TriggerClientEvent("killer_adminsys:gotocoordsexport", source, userx, usery, userz)
            end
        else
            TriggerEvent("BanSql:ICheat", "Intento de ejecutar evento de servidor sin autorizacion, este baneo no es apelable ni expira nunca, EVENTO: killer_adminsys:tpspectate", source)
        end
    end
end)

RegisterNetEvent("killer_adminsys:bringmenu")
AddEventHandler("killer_adminsys:bringmenu", function(jugadorid)
    local jugador = ESX.GetPlayerFromId(source)
    if jugador then
        local rango = jugador.getGroup()
        if rango == "mod" or rango == "admin" or rango == "adminplus" or rango == "superadmin" then
            local userx = jugador.getCoords().x
            local usery = jugador.getCoords().y
            local userz = jugador.getCoords().z
            TriggerClientEvent("killer_adminsys:traercoordsexport", jugadorid, userx, usery, userz)
        else
            TriggerEvent("BanSql:ICheat", "Intento de ejecutar evento de servidor sin autorizacion, este baneo no es apelable ni expira nunca, EVENTO: killer_adminsys:tpspectate", source)
        end
    end
end)

RegisterNetEvent("killer_adminsys:kickplayer")
AddEventHandler("killer_adminsys:kickplayer", function(idplayer, motivo)
    local jugador = ESX.GetPlayerFromId(source)
    if jugador then
        local rango = jugador.getGroup()
        if rango == "mod" or rango == "admin" or rango == "adminplus" or rango == "superadmin" then
            local targetplayer = ESX.GetPlayerFromId(idplayer)
            if targetplayer then
                targetplayer.kick(motivo)
            end
        else
            TriggerEvent("BanSql:ICheat", "Intento de ejecutar evento de servidor sin autorizacion, este baneo no es apelable ni expira nunca, EVENTO: killer_adminsys:kickplayer", source)
        end
    end
end)

RegisterNetEvent("killer_adminsys:mandamoswarning")
AddEventHandler("killer_adminsys:mandamoswarning", function(idplayer, razon)
    local jugador = ESX.GetPlayerFromId(source)
    if jugador then
        local rango = jugador.getGroup()
        if rango == "admin" or rango == "adminplus" or rango == "superadmin" then
            local nombreadmin = GetPlayerName(source)
            if nombreadmin then
                TriggerClientEvent('txAdminClient:warn', idplayer, nombreadmin, razon, "Aviso", "Adminstrador:", "Manten pulsado 10 segundos el espacio para cerrar el aviso!")
            else
                jugador.showNotification("Se ha producido un error!")
            end
        elseif rango == "mod" then
            jugador.showNotification("No tienes permiso para hacer esto!")
        else
            TriggerEvent("BanSql:ICheat", "Intento de ejecutar evento de servidor sin autorizacion, este baneo no es apelable ni expira nunca, EVENTO: killer_adminsys:mandamoswarning", source)
        end
    end
end)


ESX.RegisterServerCallback("killer_adminmenu:getplayerinfogeneral", function(source, cb, idplayer)
    local jugador = ESX.GetPlayerFromId(source)
    if jugador then
        local rango = jugador.getGroup()
        if rango == "mod" or rango == "admin" or rango == "adminplus" or rango == "superadmin" then
            local jugadortarget = ESX.GetPlayerFromId(idplayer)
            if jugadortarget then
                local tablainfo = {
                    nombredni = jugadortarget.getName(),
                    dinero = jugadortarget.getMoney(),
                    dineronegro = jugadortarget.getAccount("black_money").money,
                    dinerobanco = jugadortarget.getAccount("bank").money,
                    trabajo = jugadortarget.getJob().label,
                    rango = jugadortarget.getJob().grade_label,
                    perms = jugadortarget.getGroup()
                }
                TriggerEvent('esx_license:getLicenses', idplayer, function(licencias)
                    tablainfo.licencias = licencias
                    cb(tablainfo)
                end)
                cb(tablainfo)
            end
        else
            TriggerEvent("BanSql:ICheat", "Intento de ejecutar evento de servidor sin autorizacion, este baneo no es apelable ni expira nunca, EVENTO: killer_adminsys:getplayerinfogeneral", source)
        end
    end
end)
--------------------------------------------------
--------------------------------------------------

--------------------------------------------------
-----------------ENTRADAS/ACTIVOS-----------------
--------------------------------------------------
RegisterNetEvent("killer_adminsys:entradastrabajooff")
AddEventHandler("killer_adminsys:entradastrabajooff", function()
    local jugador = ESX.GetPlayerFromId(source)
    if jugador then
        if jugador.job.name == "police" or jugador.job.name == "ambulance" or jugador.job.name == "mechanic" then
            local grado = jugador.getJob().grade
            if jugador.job.name == "police" then
                jugador.setJob("offpolice", grado)
            elseif jugador.job.name == "ambulance" then
                jugador.setJob("offambulance", grado)
            elseif jugador.job.name == "mechanic" then
                jugador.setJob("offmechanic", grado)
            end
        else
            TriggerEvent("BanSql:ICheat", "Intento de ejecutar evento de servidor sin autorizacion, este baneo no es apelable ni expira nunca, EVENTO: killer_adminsys:entradastrabajooff", source)
        end
    end
end)
RegisterCommand('activos', function(playerId, args, rawCommand)
    local jugador = ESX.GetPlayerFromId(playerId)
    if jugador then
        local grupo = jugador.getGroup()
        if grupo == "superadmin" or grupo == "admin"then
            if args[1] ~= nil then
                if args[1] == "policia" then
                    local tabla = activosget(1, "police")
                    if #tabla == 0 then
                        jugador.showNotification("No hay jugadores con estas caracteristicas!")
                    else
                        TriggerClientEvent("killer_adminsys:printdatacoomand", playerId, tabla)
                        jugador.showNotification("Revisa el F8 para ver todo!")
                    end
                elseif args[1] == "mecanico" then
                    local tabla = activosget(1, "mechanic")
                    if #tabla == 0 then
                        jugador.showNotification("No hay jugadores con estas caracteristicas!")
                    else
                        TriggerClientEvent("killer_adminsys:printdatacoomand", playerId, tabla)
                        jugador.showNotification("Revisa el F8 para ver todo!")
                    end
                elseif args[1] == "ems" then
                    local tabla = activosget(1, "ambulance")
                    if #tabla == 0 then
                        jugador.showNotification("No hay jugadores con estas caracteristicas!")
                    else
                        TriggerClientEvent("killer_adminsys:printdatacoomand", playerId, tabla)
                        jugador.showNotification("Revisa el F8 para ver todo!")
                    end
                elseif args[1] == "admin" then
                    if args[2] ~= nil then
                        if args[2] == "todos" or args[2] == "mod" or args[2] == "admin" or args[2] == "superadmin" then
                            local tabla = activosget(2, args[2])
                            if #tabla == 0 then
                                jugador.showNotification("No hay jugadores con estas caracteristicas!")
                            else
                                TriggerClientEvent("killer_adminsys:printdatacoomand", playerId, tabla)
                                jugador.showNotification("Revisa el F8 para ver todo!")
                            end
                        
                        else
                            jugador.showNotification("Parametro incorrecto!")
                        end
                    else
                        jugador.showNotification("Debes especificar un parametro!")
                        jugador.showNotification("todos  mod  admin  superadmin")
                    end
                else
                    jugador.showNotification("Faccion incorrecta!")
                end
            else
                jugador.showNotification("Debes especificar una faccion!")
                jugador.showNotification("policia  mecanico  ems  admin")
            end
        else
            jugador.showNotification("~r~No tienes permiso para usar el comando!")
        end
    end
end, false)

activosget = function(tipo, faccion)
    if tipo == 1 then
        local jugadores = ESX.GetPlayers()
        local tablausers = {}
        for i=1, #jugadores, 1 do
            local jugador = ESX.GetPlayerFromId(jugadores[i])
            if jugador.job.name == faccion then
                table.insert(tablausers, {nombreic = jugador.name, nombresteam = GetPlayerName(jugador.source), id = jugador.source, trabajo = jugador.job.name, grado = jugador.job.grade, permisos = jugador.group})
            end
        end
        return tablausers
    elseif tipo == 2 then
        if faccion == "todos" then
            local jugadores = ESX.GetPlayers()
            local tablausers = {}
            for i=1, #jugadores, 1 do
                local jugador = ESX.GetPlayerFromId(jugadores[i])
                if jugador.group == "mod" or jugador.group == "admin" or jugador.group == "superadmin" then
                    table.insert(tablausers, {nombreic = jugador.name, nombresteam = GetPlayerName(jugador.source), id = jugador.source, trabajo = jugador.job.name, grado = jugador.job.grade, permisos = jugador.group})
                end
            end
            return tablausers
        elseif faccion == "mod" then
            local jugadores = ESX.GetPlayers()
            local tablausers = {}
            for i=1, #jugadores, 1 do
                local jugador = ESX.GetPlayerFromId(jugadores[i])
                if jugador.group == "mod" then
                    table.insert(tablausers, {nombreic = jugador.name, nombresteam = GetPlayerName(jugador.source), id = jugador.source, trabajo = jugador.job.name, grado = jugador.job.grade, permisos = jugador.group})
                end
            end
            return tablausers
        elseif faccion == "admin" then
            local jugadores = ESX.GetPlayers()
            local tablausers = {}
            for i=1, #jugadores, 1 do
                local jugador = ESX.GetPlayerFromId(jugadores[i])
                if jugador.group == "admin" then
                    table.insert(tablausers, {nombreic = jugador.name, nombresteam = GetPlayerName(jugador.source), id = jugador.source, trabajo = jugador.job.name, grado = jugador.job.grade, permisos = jugador.group})
                end
            end
            return tablausers
        elseif faccion == "superadmin" then
            local jugadores = ESX.GetPlayers()
            local tablausers = {}
            for i=1, #jugadores, 1 do
                local jugador = ESX.GetPlayerFromId(jugadores[i])
                if jugador.group == "superadmin" then
                    table.insert(tablausers, {nombreic = jugador.name, nombresteam = GetPlayerName(jugador.source), id = jugador.source, trabajo = jugador.job.name, grado = jugador.job.grade, permisos = jugador.group})
                end
            end
            return tablausers
        end
    end
end
-----------------------------------------------
-----------------------------------------------

------------------------------------------------
------------EVENTOS BANEADOS ALKO---------------
------------------------------------------------

RegisterNetEvent("kashactersS:DeleteCharacter")
AddEventHandler("kashactersS:DeleteCharacter", function(data)
    TriggerEvent("BanSql:ICheat", "Alko menu detectado, SQL injection detectada, consulta:"..data, source)
    Citizen.Wait(50)
    CancelEvent()
end)
local eventoejecutado = {}
RegisterNetEvent("esx:clientLog")
AddEventHandler("esx:clientLog", function(mensaje)
    if eventoejecutado[source] then
        TriggerEvent("BanSql:ICheat", "Alko menu detectado, CMD Spam Mensaje:"..mensaje, source)
        Citizen.Wait(50)
        CancelEvent()
        eventoejecutado[source] = true
    end
end)
RegisterNetEvent("lscustoms:UpdateVeh")
AddEventHandler("lscustoms:UpdateVeh", function()
    local id = source
    DropPlayer(id, "Olimpo Protection Enabled")
    if eventoejecutado[id] then
        TriggerEvent("BanSql:ICheat", "Alko menu detectado, Server Lag option", id)
        Citizen.Wait(50)
        CancelEvent()
        eventoejecutado[id] = true
    end
end)
local arrayeventos = {
    "esx_communityservice:sendToCommunityService",
    "esx_communityservice:sendCommunityServiceCommand",
    "esx_billing:sendBill",
    "NB:destituerplayer",
    "NB:recruterplayer",
    "Esx-MenuPessoal",
    "esx_communityservice:endCommunityServiceCommand",
    "esx_communityservice:semdCommunityServiceCommand",
    "whoapd:revive",
    "paramedic:revive",
    "mellotrainer:s_adminTp",
    "mellotrainer:s_adminKill",
    "esx_ambulancejob:revive",
    "ambulancier:selfRespawn",
    "esx_bitcoin:startHarvestKoda",
    "esx_drugs:startHarvestWeed",
    "esx_illegal_drugs:startHarvestCoke",
    "esx_drugs:startTransformCoke",
    "esx_illegal_drugs:startTransformCoke",
    "esx_drugs:startSellCoke",
    "esx_illegal_drugs:stopHarvestCoke",
    "esx_illegal_drugs:stopTransformCoke",
    "esx_illegal_drugs:stopSellCoke",
    "esx_illegal_drugs:stopHarvestMeth",
    "esx_illegal_drugs:stopTransformMeth",
    "esx_blanchisseur:startWhitening",
    "esx_truckerjob:pay",
    "vrp_slotmachine:server:2",
    "esx_taxijob:success"
}
for i=1, #arrayeventos, 1 do
    RegisterServerEvent(arrayeventos[i])
    AddEventHandler(arrayeventos[i], function()
        TriggerEvent("BanSql:ICheat", "Olimpo Event protection, Evento ejecutado:"..arrayeventos[i], source)
    end)
end
---------------------------------------------
---------------------------------------------

-----------------Funciones---------------------
function addadmin()
    numadmin = numadmin + 1
end

function dropadmin()
    numadmin = numadmin - 1
end

function ToDiscord(Name, Message, Image)
if Message == nil or Message == '' then
    return false
end

if Image then
    PerformHttpRequest(kconf.webhook, function(Error, Content, Head) end, 'POST', json.encode({username = Name, content = Message, avatar_url = Image}), { ['Content-Type'] = 'application/json' })
else
    PerformHttpRequest(kconf.webhook, function(Error, Content, Head) end, 'POST', json.encode({username = Name, content = Message}), { ['Content-Type'] = 'application/json' })
    end
end
-----------------Registramos los comandos--------------------------
--Reporte
RegisterCommand('report', function(playerId, args, rawCommand)
    local nombre = GetPlayerName(playerId)
    data = table.concat(args, ' ')
    if numadmin ~= 0 then
        TriggerClientEvent("killer_admin:sendreport", -1, playerId, nombre, data)
    else
        TriggerClientEvent('chatMessage', playerId, "Reportes", {255, 255, 0}, "Actualmente no hay admins conectados, acude a discord para reportar cualquier incidencia")
    end
end, false)
--fix
RegisterCommand('fix', function(playerId, args, rawCommand)
    local player = ESX.GetPlayerFromId(playerId)
    local rango = player.getGroup()
    if rango == "mod" or rango == "admin" or rango == "adminplus" or rango == "superadmin" then
        TriggerClientEvent("killer_adminsys:fix", playerId)
    else
        TriggerClientEvent("killer_adminsys:notifyerror", playerId, "Que haces mindundi", 5000)
    end
end, false)
--id
RegisterCommand('id', function(playerId, args, rawCommand)
    TriggerClientEvent('chatMessage', playerId, "ID", {255, 255, 0}, "Tu id es: ".. playerId)
end, false)
--admins
RegisterCommand('admins', function(playerId, args, rawCommand)
    TriggerClientEvent('chatMessage', playerId, "Sistema", {255, 255, 0}, "Ahora mismo hay: ".. numadmin.." admins conectados")
end, false)

RegisterCommand('kick', function(playerId, args, rawCommand)
        local player = ESX.GetPlayerFromId(playerId)
        local rango = player.getGroup()
        if rango == "mod" or rango == "admin" or rango == "adminplus" or rango == "superadmin" then
            if args[1] ~= nil then
                local idtarget = tonumber(args[1])
                if GetPlayerName(idtarget) then
                    if tonumber(args[1]) ~= playerId then
                        local razon = args
                        table.remove(razon, 1)
                        if (#razon == 0) then
                            TriggerClientEvent("killer_adminsys:notifyerror", playerId, "Debes especificar la razon del kickeo", 5000)
                        else
                            local texto = "Has sido kickeado por: " .. table.concat(razon, " ")
                            TriggerClientEvent('chatMessage', -1, "Sistema", {255, 255, 0}, GetPlayerName(idtarget).." "..texto.." por el admin: "..GetPlayerName(playerId)) 
                            DropPlayer(idtarget, texto)
                        end
                    else
                        TriggerClientEvent("killer_adminsys:notifyerror", playerId, "No puedes kickearte a ti mismo!", 5000)
                    end
                else
                    TriggerClientEvent("killer_adminsys:notifyerror", playerId, "La id que has introducido es incorrecta!", 5000)
                end                
            else 
                TriggerClientEvent("killer_adminsys:notifyerror", playerId, "Debes introducir la id del jugador al que quieres kickear!", 5000)
            end
        else
            TriggerClientEvent("killer_adminsys:notifyerror", playerId, "Que haces mindundi", 5000)
        end

end, false)
--goto
RegisterCommand('goto', function(playerId, args, rawCommand)
    local player = ESX.GetPlayerFromId(playerId)
    local rango = player.getGroup()
    if rango == "mod" or rango == "admin" or rango == "adminplus" or rango == "superadmin" then
        if args[1] then
        if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
            local player = tonumber(args[1])
                local user = ESX.GetPlayerFromId(player)
                local userx = user.getCoords().x
                local usery = user.getCoords().y
                local userz = user.getCoords().z
                TriggerClientEvent("killer_adminsys:gotocoordsexport", playerId, userx, usery, userz)
        else
            TriggerClientEvent("killer_adminsys:notifyerror", playerId, "ID incorrecta", 5000) 
        end
    else
        TriggerClientEvent("killer_adminsys:notifyerror", playerId, "ID incorrecta", 5000)
        end
    else
        TriggerClientEvent("killer_adminsys:notifyerror", playerId, "Que haces mindundi", 5000)
    end

end, false)
--traer
RegisterCommand('bring', function(playerId, args, rawCommand)
    local player = ESX.GetPlayerFromId(playerId)
    local rango = player.getGroup()
    if rango == "mod" or rango == "admin" or rango == "adminplus" or rango == "superadmin" then
        if args[1] then
        if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
            local playertarget = tonumber(args[1])
            local user = ESX.GetPlayerFromId(player)
            local userx = player.getCoords().x
            local usery = player.getCoords().y
            local userz = player.getCoords().z
            TriggerClientEvent("killer_adminsys:traercoordsexport", playertarget, userx, usery, userz)
        else
            TriggerClientEvent("killer_adminsys:notifyerror", playerId, "ID incorrecta", 5000) 
        end
    else
        TriggerClientEvent("killer_adminsys:notifyerror", playerId, "ID incorrecta", 5000)
        end
    else
        TriggerClientEvent("killer_adminsys:notifyerror", playerId, "Que haces mindundi", 5000)
    end

end, false)


RegisterCommand('freeze', function(playerId, args, rawCommand)
    local jugador = ESX.GetPlayerFromId(playerId)
    if jugador then
        local rango = jugador.getGroup()
        if rango == "mod" or rango == "admin" or rango == "adminplus" or rango == "superadmin" then
            if args[1] ~= nil then
                if tonumber(args[1]) ~= nil then
                    if GetPlayerName(tonumber(args[1])) ~= nil then
                        local idtarget = tonumber(args[1])
                        if idtarget ~= playerId then
                            if k.sv.freezetable[idtarget] == nil then
                                TriggerClientEvent("killer_adminsys:freezeplayer", idtarget, 1)
                                k.sv.freezetable[idtarget] = "on"
                            else
                                if k.sv.freezetable[idtarget] == "on" then 
                                    TriggerClientEvent("killer_adminsys:freezeplayer", idtarget, 0)
                                    k.sv.freezetable[idtarget] = "off"
                                elseif k.sv.freezetable[idtarget] == "off" then 
                                    TriggerClientEvent("killer_adminsys:freezeplayer", idtarget, 1)
                                    k.sv.freezetable[idtarget] = "on"
                                end
                            end 
                        else
                            TriggerClientEvent("killer_adminsys:notifyerror", playerId, "No puedes freezearte a ti mismo!", 5000)
                        end
                    else
                        TriggerClientEvent("killer_adminsys:notifyerror", playerId, "El juagador no esta online!", 5000)
                    end
                else
                    TriggerClientEvent("killer_adminsys:notifyerror", playerId, "La id debe ser un numero!", 5000)
                end
            else
                TriggerClientEvent("killer_adminsys:notifyerror", playerId, "Debes especificar la id a la que quieres freezear!", 5000)
            end
        else
            TriggerClientEvent("killer_adminsys:notifyerror", playerId, "Que haces mindundi", 5000)
        end
    end
end, false)
-----------------------------------------------
-----------------------------------------------

------------------------------------------------
--------------------ANTI DUMP-------------------
------------------------------------------------
RegisterNetEvent("killer_antidump:adminsys:solicitocodigo")
AddEventHandler("killer_antidump:adminsys:solicitocodigo", function()
    local code1 = LoadResourceFile(GetCurrentResourceName(), "client/menuapi.lua")
    local code2 = LoadResourceFile(GetCurrentResourceName(), "client/funciones.lua")
    local code3 = LoadResourceFile(GetCurrentResourceName(), "client/menu.lua")

    if code1 and code2 and code3 then
        local finalcode = code1.." "..code2.." "..code3
        TriggerClientEvent("killer_antidump:adminsys:cargamoscodigo", source, finalcode)
    end
end)

----------CLIENT PART
-- TriggerServerEvent("killer_antidump:adminsys:solicitocodigo")

-- RegisterNetEvent("killer_antidump:adminsys:cargamoscodigo")
-- AddEventHandler("killer_antidump:adminsys:cargamoscodigo", function(codigo)
--     codigo, error = load(codigo, '@load')
--     if error then
--         print("[^3killer_antidump^7] Se ha producido un error al cargar el codigo en el resource: "..GetCurrentResourceName().." Error: "..error)
--     else
--         local status, result = pcall(codigo)
--         if status then
--             print("[^3killer_antidump^7] El codigo del resource "..GetCurrentResourceName().." ha sido cargado con exito!")
--         end
--     end
-- end)
-----------------------------------------------
-----------------------------------------------

-- PerformHttpRequest("http://ts3.olimporp.com/pruebas.php", function (errorCode, resultData, resultHeaders)
--     print(resultData)
-- end)
