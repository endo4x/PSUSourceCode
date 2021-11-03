--[[
	id: FZAjamxbk61w3B5w_FTCs
	name: Mercyx_cable > Client
	description: Mercyx_cable
	time1: 2021-07-07 15:22:18.841561+00
	time2: 2021-07-07 15:22:18.841561+00
	uploader: 4U3SqFeGZ4g1L1zp7GBTUYt76bjfjNDx_uU9aA4E
	uploadersession: PNwXjudvMKuT0JWDqC_-yx2uLzOkCr
	flag: f
--]]

ESX = nil
local Cooling = {}
local delay = 0
local bid = {}
local Overnet = nil
script_name = GetCurrentResourceName()
Shelterx = {}
SOAIZJAISJUZGAYSGPSAKZIOAHSIZA=nil;
Shelterx.police = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent(Config.esx_routers['client_shared_obj'], function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

    Citizen.Wait(2000)
    TriggerServerEvent(script_name .. ':server:getConnectedPlayers')
end)


RegisterNetEvent(script_name..'client:Verify:Receive')
AddEventHandler(script_name..'client:Verify:Receive', function(a)
	SOAIZJAISJUZGAYSGPSAKZIOAHSIZA=a 
end)

Shelterx.Init=function()
    Wait(500)
    if SOAIZJAISJUZGAYSGPSAKZIOAHSIZA then 
		Shelterx.Inited()
        print(('^2[%s]^7 ^0Verify Success^7'):format(script_name))
    else 
        print(('^1[%s] Verify Error^7'):format(script_name))
    end 
end;

Citizen.CreateThread(function()
    local b=GetGameTimer()
    while SOAIZJAISJUZGAYSGPSAKZIOAHSIZA==nil and GetGameTimer() -b <=30*1000 do 
        TriggerServerEvent(script_name..'server:Verify:Request')
		Wait(300)
    end;
    Shelterx.Init()
end)

RegisterNetEvent(script_name .. ':client:getConnectedPlayers')
AddEventHandler(script_name .. ':client:getConnectedPlayers', function(connectedPlayers,cacheCement)
    UpdatePlayerTable(connectedPlayers)
    Shelterx.cache(cacheCement)
end)

RegisterNetEvent(script_name .. ':updateConnectedPlayers')
AddEventHandler(script_name .. ':updateConnectedPlayers', function(connectedPlayers)
	UpdatePlayerTable(connectedPlayers)
end)

UpdatePlayerTable = function (connectedPlayers)
	local formattedPlayerList, num = {}, 1
    local ems, police, foodpanda, mechanic, cardealer, estate, players = 0, 0, 0, 0, 0, 0, 0

    for k,v in pairs(connectedPlayers) do       
		if v.job == 'police' then
			police = police + 1
        end
    end
    Shelterx.police = police
end

Shelterx.Inited = function()
    Citizen.CreateThread(function()
        Citizen.Wait(100)
        while true do
            local sleepThread = 1000
            local ply = PlayerPedId()
            local coords = GetEntityCoords(ply)
            for i = 1, #Config.CementAvailable do
                local x = GetClosestObjectOfType(coords, Config.Phase, Config.CementAvailable[i], false, false, false)
                local entity = nil
                if DoesEntityExist(x) then
                    entity = x
                    Plant    = GetEntityCoords(entity)
                    sleepThread = 5
                    netid = GetEntityCoords(entity)
                    if Cooling[netid] and Cooling[netid] > GetGameTimer() then
                        DrawText3D(Plant.x, Plant.y, Plant.z + 1.5, Config.translate.DrawTextOffline )  
                    else
                        DrawText3D(Plant.x, Plant.y, Plant.z + 1.5, Config.translate.DrawTextOnline )  
                    end
                    local lPed = GetPlayerPed(-1)   
                    if IsControlJustReleased(0, Config.Keys ) and delay < GetGameTimer() and not IsPedInAnyVehicle(lPed, false) and IsPedOnFoot(lPed) then
                        if not Cooling[netid] or Cooling[netid] and Cooling[netid] < GetGameTimer() then
                            if bid[netid] and bid[netid] > GetGameTimer() then
                                pNotify(Config.translate.Stealing)
                                Citizen.Wait(500)
                            else
                                delay = GetGameTimer() + 1000
                                local far = false
                                for k,v in pairs(Config.ThisFar) do
                                    if(GetDistanceBetweenCoords(coords, v.x , v.y , v.z , true) < v.range) then
                                        pNotify(Config.translate.Faroff)
                                        far = true
                                    end
                                end
                                if not far then
                                    if Config.InTown.enable then
                                        v = Config.InTown.Pos
                                        if(GetDistanceBetweenCoords(coords, v.x , v.y , v.z , true) < v.range) then
                                            TriggerEvent(script_name..':fetchStarting', 'Pick' , { i = netid , m = Config.Minigame})
                                            Overnet = netid
                                        else
                                            pNotify(Config.translate.City)
                                        end
                                    else
                                        TriggerEvent(script_name..':fetchStarting', 'Pick' , { i = netid , m = Config.Minigame})
                                        Overnet = netid
                                    end
                                end
                            end
                        else
                            pNotify(Config.translate.Stolen)
                            Citizen.Wait(500)
                        end
                    end
                end
            end
            Citizen.Wait(sleepThread)
        end
    end)
end

RegisterNetEvent(script_name .. ":fetchStarting")
AddEventHandler(script_name .. ":fetchStarting", function(index , source)
    Config.Function[index](source)
end)

RegisterNetEvent(script_name..":fetchCement")
AddEventHandler(script_name..":fetchCement", function(netid, src)
	if src ~= GetPlayerServerId(PlayerId()) then
		bid[netid] = GetGameTimer() + Config.TimeDuration
	end
end)

RegisterNetEvent(script_name..":fetchCooldown")
AddEventHandler(script_name..":fetchCooldown", function(netid, time)
	Cooling[netid] = GetGameTimer() + (time * 1000)
end)

RegisterCommand(Config.Command, function()    ---- เอาไว้ Debug กรณี Nui ค้าง
	SetNuiFocus(false, false)        
end)

-- เมื่อมินิเกมล้มเหลว
RegisterNUICallback('Error', function()
	SetNuiFocus(false, false)
    Overnet = nil
    pNotify(Config.translate.Error)
end)

-- เมื่อมินิเกม สำเร็จ
RegisterNUICallback('Success', function()
	SetNuiFocus(false, false)
    TriggerEvent(script_name..':fetchStarting', 'Pick' , { i = Overnet , m = false})

end)

Shelterx.cache = function(cacheCement)
    for k,v in pairs(cacheCement) do
        Cooling[k] = GetGameTimer() + (Config.Cooling * 1000)
    end
end

DrawText3D = function(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
  
	local scale = 0.45
   
	if onScreen then
		SetTextScale(scale, scale)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 370
        DrawRect(_x, _y + 0.0150, 0.030 + factor , 0.030, 170, 170, 170, 80)
	end
end

pNotify = function(f)
    exports.pNotify:SendNotification({
        text = f,
        type = 'success',
        timeout = 3000,
        layout = 'bottomcenter',
        queue = 'global'
    }) 
end

Shelterx.Police = function()
    return Shelterx.police
end


