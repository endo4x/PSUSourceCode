--[[
	id: tzNgELxdbMSZVk4PBMVYb
	name: Can-taserlimit-client
	description: Can-taserlimit-client
	time1: 2021-05-18 02:57:29.192287+00
	time2: 2021-05-18 02:57:29.192288+00
	uploader: 0lXSC9Q-U1coaa_LJ3Y4z0ksSbDtOnFnk-FHONUw
	uploadersession: bT8lPMVQRr9_avVe8cLBcyHEwpKwPL
	flag: f
--]]

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)


maxTaserKart = 2 
yenilemekomutu = "taseryenile" 
uzunTazerZaman = true 
uzunTazerSaniye = 40 


local kalantaserkart = maxTaserKart


-- AddEventHandler('can:silahsorgu', function()
--     local taserModel = GetHashKey("WEAPON_STUNGUN")
--     local ped = GetPlayerPed(-1)

--     if GetSelectedPedWeapon(ped) == taserModel  then -- print("Taser kartusu kalan = " .. kalantaserkart)
--         TriggerEvent('can:tasermesleksorgu', function()
--         end)
--     else
--         TriggerEvent('notification', 'elinde taser yok. ', 2)
--         end
-- end)

AddEventHandler('can:tasermesleksorgu', function()
    if PlayerData.job and PlayerData.job.name == 'police' or  PlayerData.job and PlayerData.job.name == 'sheriff' or PlayerData.job and PlayerData.job.name == 'offpolice' or  PlayerData.job and PlayerData.job.name == 'offsheriff' then
    ExecuteCommand('me Kartuşu taserin ucundan söker.')    
    TriggerEvent('pogressBar:drawBar', 4000, 'Kartuş yenileniyor.', function()
        -- print('Geri dönüş Test')
    end)
    Citizen.Wait(4000)
    ExecuteCommand('me Yeni kartuşu tekrardan taserin ucuna takar')
    TriggerEvent('notification', 'Kartusun yenilendi. ', 1) 
    kalantaserkart = maxTaserKart
    print('do++')
    -- TriggerServerEvent('can:taseritemsil')

else
    TriggerEvent('notification', 'Polis,sheriff ve sasp değilsin.. ', 2)
end
end)

AddEventHandler('can:mermisorgu', function()
    -- kalantaserkart = maxTaserKart
if kalantaserkart ~= maxTaserKart then
    TriggerEvent('can:tasermesleksorgu', function()
    end)
else
    TriggerEvent('notification', 'Mermin full! ', 2)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = GetPlayerPed(-1)
        local taserModel = GetHashKey("WEAPON_STUNGUN")

        if GetSelectedPedWeapon(ped) == taserModel then
            if IsPedShooting(ped) then
                kalantaserkart = kalantaserkart - 1
                -- print(" Taser kartusu kalan = " .. kalantaserkart)
                -- TriggerEvent("pNotify:SendNotification", {text = 'Taser kartuşu kalan '..kalantaserkart })
                TriggerEvent('notification', 'Taser kartuşu kalan '..kalantaserkart, 1)


            end
        end

        if kalantaserkart <= 0 then
            if GetSelectedPedWeapon(ped) == taserModel then
                SetPlayerCanDoDriveBy(ped, false)
                DisablePlayerFiring(ped, true)
                if IsControlPressed(0, 106) then
                    -- ShowNotification("~y~Kartusun kalmadı kartusu yenilemek için/" .. yenilemekomutu)
                    TriggerEvent('notification', 'Kartusun kalmadı kartusu yenilemek icin/ '..yenilemekomutu, 2)
                end
            else
                -- Do nothing
            end
        end

        if uzunTazerZaman then
            SetPedMinGroundTimeForStungun(ped, uzunTazerSaniye * 1000)
        end
    end
end)


RegisterCommand(yenilemekomutu, function(source, args, rawCommand)
    local taserModel = GetHashKey("WEAPON_STUNGUN")
    local ped = GetPlayerPed(-1)

    if GetSelectedPedWeapon(ped) == taserModel  then 
        TriggerEvent('can:mermisorgu', function()
        -- print("Çalışıyor la")
        -- TriggerEvent('can:taseritemsorgu', function()
        -- end)
        print('olmlu')
        end)
    else
        TriggerEvent('notification', 'Elinde taser yok. ', 2)
        end
    end)