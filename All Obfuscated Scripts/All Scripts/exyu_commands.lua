--[[
	id: CFhJ4Yxj_d5a8X8frTd-r
	name: exyu_commands
	description: exyu_commands
	time1: 2021-05-19 13:45:21.24933+00
	time2: 2021-05-19 13:45:21.24933+00
	uploader: AZtTUxhQ9cLj3tqhYw_Q7zf5zhr9A-0KAU3uOmnL
	uploadersession: TT9GadOnTA0JWZJ3I8nk7ShWk10ZN0
	flag: f
--]]

ESX = nil
_CreateThread = CreateThread
_print = print
cachedVozilo = nil

local lockLoop = true
local drawNotifikacije = true

commands = {
    -- simple commands
    ['fix'] = {call = Fix, text = "Popravi vozilo"},
    ['gorivo'] = {call = Gorivo, text = "Napuni rezervoar vozila"},
    ['operi'] = {call = OcistiAuto, text = "Ocisti vozilo"},
    ['revive'] = {call = Revive, text = "Ozivi se"},
    ['food'] = {call = Nahrani, text = "Najedi se"},
    ['helti'] = {call = Nahiluj, text = "Napuni hp i najedi se"},
    ['unlock'] = {call = Unlock, text = "Otkljucaj najblizi auto"},
    ['notifikacije'] = {call = Notifikacije, text = "Ukljuci/iskljuci XYZ notifikacije"},
    ['fulltune'] = {call = FullTune, text = "Full tune vozilo u kom sedis"},
    ['skin'] = {call = Skin, text = "Otvori skin meni"},
    ['karakter'] = {call = Register, text = "Otvori register meni"},
    -- ['setvozilo'] = {call = Vozilo_Set, text = "Prisvoji/dupliraj vozilo u kojem trenutno sedis"},
    -- ['zapamtivozilo'] = {call = Vozilo_Zapamti, text = "Zapamti model vozila za sledecu kupovinu"},
    ['sellvozilo'] = {call = Vozilo_Sell, text = "Prodaj vozilo u kome sedis za 50% manje"},
    ['lockloop'] = {call = function() lockLoop = false end, text = "Iskljuci mogucnost otkljucavanja vozila dugmetom"},

    -- droge
    ['kskupi'] = {call = KokainSkupi, hasArgs = true, text = "Skupi odredjenu kolicinu kokaina (//kskupi [broj])"},

    -- complex commands
    ['getsalon'] = {
        call = GetSalon, 
        hasArgs = true,
        text = "Ispisuje listu vozila iz salona u konzoli"
    },
    -- ['setjob'] = {
    --     call = Zaposli, 
    --     hasArgs = true,
    --     text = "Podesi posao iz biroa"
    -- },
    ['bdeposit'] = {
        call = BankaStavi, 
        hasArgs = true,
        text = "Stavi novac u banku"
    },
    ['bwithdraw'] = {
        call = BankaPodigni, 
        hasArgs = true,
        text = "Podigni novac iz banke"
    },
    ['silentvozilo'] = {
        call = Vozilo_Silent, 
        hasArgs = true,
        text = "Kupi vozilo po imenu modela (bez spawnovanja)"
    },
    ['kupivozilo'] = {
        call = Vozilo_Kupi, 
        hasArgs = true,
        text = "Kupi vozilo po imenu modela (imitira autosalon)"
    },
    ['item'] = {
        call = DajItem, 
        hasArgs = true,
        text = "Daj sebi item (//item ime kolicina)"
    },
    ['fk'] = {
        call = DajItem, 
        params = {"fixkit", 1},
        text = "Daj sebi alat za popravku",
    },
}

_CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)ESX = obj end)
        Citizen.Wait(100)
    end

    _print('Ucitavanje XYZ API-a!')

    InitCommandSystem()
end)

function InitCommandSystem()
    Wait(3000)

    while ExecuteCommand == nil do
        Wait(0)
    end

    while commands == nil do
        print('Commands not loaded!')
        Wait(150)
    end
    
    if not DefaultExecuteCommand then
        DefaultExecuteCommand = ExecuteCommand
    end

    ExecuteCommand = function(commandString)
        if commandString:sub(1, 1) == '/' then
            local rawCmd = commandString:sub(2)
            local rawArgs = GetArgs(rawCmd)

            for cmdName, cmd in pairs(commands) do
                if cmdName == rawArgs[1] then
                    if cmd.hasArgs then
                        local cmdInput = rawCmd:sub(cmdName:len() + 2)
                        local cmdArgs = GetArgs(cmdInput)                            
                        cmd.call(table.unpack(cmdArgs))
                    elseif cmd.params then
                        cmd.call(table.unpack(cmd.params))
                    else
                        cmd.call()
                    end
                    return
                end
            end
            
            local s, e = load(input)
            if s then
                s()
            else
                print("ERROR:" .. e)
            end
        else
            DefaultExecuteCommand(commandString)
        end
    end

    for k,v in pairs(commands) do
        print(('Dodata nova komanda: %s | %s'):format(k, v.text))
        TriggerEvent('chat:addSuggestion', '//' .. k, v.text, {})
    end

    _print(('Ucitano %d komandi!'):format(tlen(commands)))
end

function Fix()
    TriggerEvent('esx_mechanicjob:onFixkit')
end

function Gorivo()
    SetVehicleFuelLevel(GetVeh(), 70.0)
end

function OcistiAuto()
    SetVehicleDirtLevel(GetVeh(), 0.0)
end

function Revive()
    TriggerEvent('esx_ambulancejob:revive')
end

function Register()
    TriggerEvent('esx_identity:showRegisterIdentity')
end

function Skin()
    TriggerEvent('esx_skin:openSaveableMenu')
end

function BankaPodigni(amount)
    TriggerServerEvent('bank:withdraw', tonumber(amount))
end

function BankaStavi(amount)
    print('Deposited $' .. amount)
    TriggerServerEvent('bank:deposit', tonumber(amount))
end

function Nahrani()
	TriggerEvent('esx_status:set', 'hunger', 1000000)
	TriggerEvent('esx_status:set', 'thirst', 1000000)
end

function Nahiluj()
    TriggerEvent('esx_basicneeds:healPlayer')
end

function DajItem(item, count)
	TriggerServerEvent('energy_blackmarket:kupiItem', item, count, 'Kafic')
end

function KokainSkupi(puta)
    for i=0, puta do
        TriggerServerEvent('balkankings_met:uzmihemikalije')
        Wait(150)
    end
end

function Vozilo_Sell()
	ESX.TriggerServerCallback('d3x_vehicleshop:resellVehicle', function(vehicleSold)
		if vehicleSold then
			ESX.ShowNotification('~g~Vozilo prodato!')
		else
			ESX.ShowNotification('~r~Vozilo nije prodato!')
		end
	end, GetVehicleNumberPlateText(GetVeh()), GetEntityModel(GetVeh()))
end

function Unlock()
	local veh = ESX.Game.GetClosestVehicle(GetEntityCoords(PlayerPedId()))
	SetVehicleDoorsLocked(veh, 1)
	SetVehicleDoorsLockedForAllPlayers(veh, false)
	SetVehicleDoorsLockedForPlayer(veh, PlayerId(), false)
	if veh ~= nil then
        _drawNotification(('~b~Vozilo %s otkljucano!'):format(GetVehicleNumberPlateText(veh)))
		_print(('Vozilo %s otkljucano!'):format(GetVehicleNumberPlateText(veh)))
	end
end

local IsControlJustReleased = IsControlJustReleased
_CreateThread(function()
    while lockLoop do
        Wait(2)
        if IsControlJustReleased(0, 243) then
            Unlock()
        end
    end
end)

function FullTune()
	local props = {
		modEngine       = 3,
		modBrakes       = 2,
		modTransmission = 2,
		modSuspension   = 3,
        modArmor        = 4,
		modTurbo        = true,
	}

	ESX.Game.SetVehicleProperties(GetVeh(), props)
end

function GetSalon(category)
	ESX.TriggerServerCallback('d3x_vehicleshop:getVehicles', function(vehicles)
        for i=1, #vehicles, 1 do
            local vehicle = vehicles[i]
            print(('%s | %s | %s | %s'):format(vehicle.category, vehicle.name, vehicle.model, vehicle.hash))
        end
	end)
end

function Vozilo_Zapamti()
    cachedVozilo = GetVehiclePedIsIn(PlayerPedId())
end

-- function Vozilo_Set(plates)
--     if not ESX then return end
--     local veh = GetVehiclePedIsIn(PlayerPedId())
--     local props = ESX.Game.GetVehicleProperties(veh)
--     local newPlate = GeneratePlate()

--     if plates then 
--         newPlate = plates 
--     end

--     props.plate = newPlate
--     ESX.Game.SetVehicleProperties(veh, props)
--     TriggerServerEvent('prod_vozila:dodeliVozilo', props, 1)
--     _print('Vozilo setovano!')
-- end

function Vozilo_Kupi(model, n1, n2, n3, n4, n5) -- izvorno iz skripte da bi proces kupovine izgledao isto
    if not ESX then return end

    local name = string.format('%s %s %s %s %s', n1 or '', n2 or '', n3 or '', n4 or '', n5 or '')
	local playerPed = PlayerPedId()

	ESX.Game.SpawnVehicle(model, { x = -29.16, y = -1082.18, z = 26.62 }, 62.11, function (vehicle)
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		local newPlate = GeneratePlate()
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		vehicleProps.plate = newPlate

		SetVehicleNumberPlateText(vehicle, newPlate)
		TriggerServerEvent('d3x_vehicleshop:setVehicleOwned', vehicleProps,	name)
		ESX.ShowNotification('Kupio si ~g~vozilo ~s~sa tablicama ~b~' .. newPlate)
	end)
end

function Vozilo_Silent(model, n1, n2, n3, n4, n5) 
    if not ESX then return end

    local name = string.format('%s %s %s %s %s', n1 or '', n2 or '', n3 or '', n4 or '', n5 or '')

    if IsPedInAnyVehicle(PlayerPedId(), false) then
        model = GetEntityModel(GetVeh())
        print(model)
        print(GetVehicleNumberPlateText(GetVeh()))
    end

    ESX.Game.SpawnLocalVehicle(model, vector3(0.0, 0.0, 0.0), 0.0, function(veh)
        local props = ESX.Game.GetVehicleProperties(veh)
        local newPlate = GeneratePlate()

        props.plate = newPlate
        ESX.Game.SetVehicleProperties(veh, props)
        TriggerServerEvent('d3x_vehicleshop:setVehicleOwned', props, name)
        ESX.ShowNotification('Kupio si ~g~vozilo ~s~sa tablicama ~b~' .. newPlate)
        ESX.Game.DeleteVehicle(veh)
    end)
end

-- in game utility functions

-- gui funkcije
function Notifikacije()
    drawNotifikacije = not drawNotifikacije
end

function _drawNotification(text)
    if not drawNotifikacije then return; end
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

-- autosalon izvorne funkcije
---------------------------------------------------

local NumberCharset = {}
local Charset = {}

Config = {}
Config.PlateLetters  = 3
Config.PlateNumbers  = 3
Config.PlateUseSpace = true

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GeneratePlate()
	local generatedPlate
	local doBreak = false

	while true do
		Citizen.Wait(2)
		math.randomseed(GetGameTimer())
		if Config.PlateUseSpace then
			generatedPlate = string.upper(GetRandomLetter(Config.PlateLetters) .. ' ' .. GetRandomNumber(Config.PlateNumbers))
		else
			generatedPlate = string.upper(GetRandomLetter(Config.PlateLetters) .. GetRandomNumber(Config.PlateNumbers))
		end

		ESX.TriggerServerCallback('d3x_vehicleshop:isPlateTaken', function (isPlateTaken)
			if not isPlateTaken then
				doBreak = true
			end
		end, generatedPlate)

		if doBreak then
			break
		end
	end

	return generatedPlate
end

-- mixing async with sync tasks
function IsPlateTaken(plate)
	local callback = 'waiting'

	ESX.TriggerServerCallback('d3x_vehicleshop:isPlateTaken', function(isPlateTaken)
		callback = isPlateTaken
	end, plate)

	while type(callback) == 'string' do
		Citizen.Wait(0)
	end

	return callback
end

function GetRandomNumber(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end

-- local GetPed = PlayerPedId

function GetVeh()
    return GetVehiclePedIsIn(PlayerPedId())
end

-- syntax functions for easier coding
function GetArgs(s)
    result = {};
    for match in (s.." "):gmatch("(.-)".." ") do
        table.insert(result, match);
    end
    return result;
end

function tlen(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end