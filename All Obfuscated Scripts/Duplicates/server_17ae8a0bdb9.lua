--[[
	id: U-Vefc3MBPEzlBht8Aj_n
	name: 空投server
	description: 無
	time1: 2021-07-12 13:22:39.929804+00
	time2: 2021-07-12 13:22:39.929805+00
	uploader: oW9rbd1CZo8Mosx5oY0HpYNrASGDwwul2meTmkKF
	uploadersession: JDCYv5Zink7bBsAlMSNMTsuYS3uS7q
	flag: f
--]]

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
----------------------------------------------------------------------------
local creatairboxtime = false --創建空投計時器
local creatairboxtime2 = false --當拿取玩家空投遠離空投圈外的計時器
local airboxdeltime = false --刪除計時器
local AirBoxCrateTime = false --關閉空投生成計時器
local airboxcratetime = false --全部玩家顯示空投生成文字(預設為關閉)
local OpenAllPlayerInRang = false  --圈內顯示預設關閉
local ShowAirBoxBlip = false --顯示空投點(預設為關閉)
local CreateAirBoxOk = false --空投創建成功(預設為關閉)
local airboxPreset = false --空投初始化開啟(預設為關閉)
local ShowAirBoxMarker = false --全部玩家顯示空投光圈成功(預設為關閉)
local ShowAirBoxSearch = false --全部玩家顯示拿取空投(預設為關閉)
local ShowAirBoxTakeBlip = false --全部玩家顯示空投被拿閃點(預設為關閉)
local airboxtakenameopen = false --全部玩家顯示空投拿取玩家名稱
local boxX = nil --空投X座標
local boxY = nil --空投Y座標
local boxZ = nil --空投Z座標
------------[空投拿取區域]----------------------------
local ShowAirBoxTake = false
local TakeAirBoxPlayer = {} --搶空投的玩家
local delAirBoxPlayer = {} --死掉的玩家
local airboxtakename = nil
local airboxtakesteam16 = nil
-------------[階段開關]----------------------------
local AirBoxStage = false
local AirBoxStage1 = false
local airbox1 = false --階段1
local airbox2 = false --階段2
local airbox3 = false --階段3
----------------------------------------------------------------------------
AddEventHandler('onResourceStart', function(resource)
    airboxPreset = true --初始化開啟
    OpenAllPlayerInRang = true  --圈內顯示開啟
    creatairboxtime = true
end)
------------------------------[function區域]---------------------------------
function secondsToClock(seconds)
	local seconds, hours, mins, secs = seconds, 0, 0, 0

	if seconds <= 0 then
		return 0, 0,seconds
	else
		local hours = math.floor(seconds / 3600)
		local mins = math.floor(seconds / 60 - (hours * 60))
		local secs = math.floor(seconds - hours * 3600 - mins * 60)

		return hours,mins,secs
	end
end
------------------------------[創建空投計時器區域]----------------------------
--第一
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if creatairboxtime then
            createboxTimer = Config.createboxtime / 1000
            while creatairboxtime do
                Citizen.Wait(1000)
                if createboxTimer > 0 then
                    createboxTimer = createboxTimer - 1
                    --print(_U('respawn_bleedout_in',secondsToClock(createboxTimer)))
                    TriggerEvent("esx_airbox:showcreateboxtime",_U('respawn_bleedout_in',secondsToClock(createboxTimer)),createboxTimer)
                end
                if createboxTimer == 0 then
                    creatairboxtime = false
                    local rand = math.random(#Config.airboxDrop)
                    boxX = Config.airboxDrop[rand][1]
                    boxY = Config.airboxDrop[rand][2]
                    boxZ = Config.airboxDrop[rand][3]
                    print("空投創建成功")
                    airboxPreset = false --初始化關閉
                    CreateAirBoxOk = true --顯示空投已生成
                    ShowAirBoxBlip = true --顯示空投點
                    ShowAirBoxMarker = true --顯示空投光圈
                    ShowAirBoxSearch = true --顯示所有玩家拿取
                    AirBoxCrateTime = true --開啟空投生成計時器
                    airboxcratetime = true --全部玩家顯示空投生成文字
                    airboxdeltime = true --開啟空投消失計時器
                    airbox1 = true
                    AirBoxStage = true
                end
            end
        end
    end
end)
--第二 當拿取空投遠離空投圈
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if creatairboxtime2 then
            createboxTimer = Config.createboxtime2 / 1000
            while creatairboxtime2 do
                Citizen.Wait(1000)
                if createboxTimer > 0 then
                    createboxTimer = createboxTimer - 1
                    --print(_U('respawn_bleedout_in',secondsToClock(createboxTimer)))
                    TriggerEvent("esx_airbox:showcreateboxtime",_U('respawn_bleedout_in',secondsToClock(createboxTimer)),createboxTimer)
                end
                if createboxTimer == 0 then
                    creatairboxtime2 = false
                    local rand = math.random(#Config.airboxDrop)
                    boxX = Config.airboxDrop[rand][1]
                    boxY = Config.airboxDrop[rand][2]
                    boxZ = Config.airboxDrop[rand][3]
                    print("空投創建成功")
                    CreateAirBoxOk = true --顯示空投已生成
                    ShowAirBoxBlip = true --顯示空投點
                    ShowAirBoxMarker = true --顯示空投光圈
                    ShowAirBoxSearch = true --顯示所有玩家拿取
                    AirBoxCrateTime = true --開啟空投生成計時器
                    airboxcratetime = true --全部玩家顯示空投生成文字
                    airboxdeltime = true --開啟空投消失計時器
                    airbox1 = true
                    AirBoxStage = true
                end
            end
        end
    end
end)
------------------------------[創建空投生成計時器區域]----------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if AirBoxCrateTime then
            airboxcrateTime = Config.airboxcrateokTime / 1000
            while AirBoxCrateTime do
                Citizen.Wait(1000)
                if airboxcrateTime > 0 then
                    airboxcrateTime = airboxcrateTime + 1
                    --print(_U('respawn_bleedout_in',secondsToClock(airboxcrateTime)))
                    TriggerEvent("esx_airbox:showairboxcratetime",_U('respawn_bleedout_in',secondsToClock(airboxcrateTime)),airboxcrateTime)
                end
            end
        end
    end
end)
--------------------------------------------------[空投刪除計時器]------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if airboxdeltime then
            delairboxTimer = Config.delboxtime / 1000
            while airboxdeltime do
                Citizen.Wait(1000)
                if delairboxTimer > 0 then
                    delairboxTimer = delairboxTimer - 1
                    --print(_U('respawn_bleedout_in',secondsToClock(delairboxTimer)))
                    TriggerEvent("esx_airbox:showdelboxtime",_U('respawn_bleedout_in',secondsToClock(delairboxTimer)),delairboxTimer)
                end
                if delairboxTimer == 5 then
                    ShowAirBoxSearch = false
                elseif delairboxTimer == 0 then
                    airboxdeltime = false
                    airboxPreset = true
                    creatairboxtime = true
                    print("空投正在消失")
                end
            end
        end
    end
end)
------------------------------------------------[階段計時器]--------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if airbox1 then
            airboxStageTimer = Config.AirBoxStage1Timer / 1000
            while airbox1 do
                Citizen.Wait(1000)
                if airboxStageTimer > 0 then
                    airboxStageTimer = airboxStageTimer - 1
                    --print(_U('respawn_bleedout_in',secondsToClock(airboxStageTimer)))
                    TriggerEvent("esx_airbox:showairboxstagetime",_U('respawn_bleedout_in',secondsToClock(airboxStageTimer)),airboxStageTimer)
                end
                if airboxStageTimer == 0 then
                    airbox1 = false
                    airbox2 = true
                    print("空投階段正再變更(2)")
                end
            end
        end
        if airbox2 then
            airboxStageTimer = Config.AirBoxStage2Timer / 1000
            while airbox2 do
                Citizen.Wait(1000)
                if airboxStageTimer > 0 then
                    airboxStageTimer = airboxStageTimer - 1
                    --print(_U('respawn_bleedout_in',secondsToClock(airboxStageTimer)))
                    TriggerEvent("esx_airbox:showairboxstagetime",_U('respawn_bleedout_in',secondsToClock(airboxStageTimer)),airboxStageTimer)
                end
                if airboxStageTimer == 0 then
                    airbox2 = false
                    AirBoxStage1 = true
                    print("空投階段正再變更(3)")
                end
            end
        end
    end
end)
----------------[一般迴圈區域]
--空投初始化開啟
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        if airboxPreset then
            AirBoxCrateTime = false
            ShowAirBoxBlip = false --關閉空投點
            ShowAirBoxTakeBlip = false --關閉拿取空投點
            ShowAirBoxMarker = false --關閉空投光圈
            ShowAirBoxTake = false --全部玩家顯示空投尚未拿取
            ShowAirBoxSearch = false --全部玩家拿取關閉
            CreateAirBoxOk = false --顯示尚未生成
            AirBoxStage = false --階段關閉
            airboxcratetime = false --關閉顯示空投生成時間
            airboxtakenameopen = false --關閉顯示拿取空投玩家名稱
            airbox1 = false
            airbox2 = false
            AirBoxStage1 = false
            boxX = nil
            boxY = nil
            boxZ = nil
            TakeAirBoxPlayer = {} --搶空投的玩家
            delAirBoxPlayer = {} --死掉的玩家
        end
    end
end)

--圈內顯示開啟
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        if OpenAllPlayerInRang then
            TriggerEvent("esx_airbox:OpenAllPlayerInRang",-1)
        end
    end
end)

--空投生成開啟
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        if CreateAirBoxOk then
            TriggerEvent("esx_airbox:SetAllAirBoxCrateOpen",-1)
        else
            TriggerEvent("esx_airbox:SetAllAirBoxCrateOff",-1)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.BlipUpdateTime)
        --顯示空投點
        if ShowAirBoxBlip then
            TriggerEvent("esx_airbox:ShowAirBoxBlip",boxX,boxY,boxZ) --顯示空投點
        else
            TriggerEvent("esx_airbox:ShowdelAirBoxBlip",-1) --刪除空投點
        end
        --顯示被拿空投點
        if ShowAirBoxTakeBlip then
            TriggerEvent("esx_airbox:SetAirBoxTakeBlip",TakeAirBoxPlayer) --顯示拿取空投點
        else
            TriggerEvent("esx_airbox:ShowdelTakeAirBoxBlip",-1) --刪除拿取空投點
            TakeAirBoxPlayer = {}
        end
    end
end)

--顯示光圈
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        if ShowAirBoxMarker then
            TriggerEvent("esx_airbox:SetAllAirBoxBlip",boxX,boxY,boxZ) --設定空投位置給全部玩家
            TriggerEvent("esx_airbox:OpenPlayerAirBoxMarker",-1) --全部玩家顯示光圈
        else
            TriggerEvent("esx_airbox:OffPlayerAirBoxMarker",-1) --全部玩家關閉光圈
        end
    end
end)

--顯示拿取空投
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        if ShowAirBoxSearch then
            TriggerEvent("esx_airbox:SetAllPlayerOpenSearch",-1) --全部玩家拿取開啟
        else
            TriggerEvent("esx_airbox:SetAllPlayerOffSearch",-1) --全部玩家拿取關閉
        end
    end
end)

--顯示空投已經領取
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        if ShowAirBoxTake then
            TriggerEvent("esx_airbox:SetAllAirBoxTake",-1) --全部玩家顯示空投已領取
        else
            TriggerEvent("esx_airbox:SetAllAirBoxNoTake",-1) --全部玩家顯示空投未領取
        end
    end
end)

--顯示空投拿取玩家名稱
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        if airboxtakenameopen then
            TriggerEvent("esx_airbox:SetAllAirBoxTakeNameOpen",-1) --空投拿取玩家顯示名稱開啟
            TriggerEvent("esx_airbox:SetAllAirBoxTakeName",airboxtakename) --全部玩家設定拿取空投玩家的名稱
        else
            TriggerEvent("esx_airbox:SetAllAirBoxTakeNameOff",-1) --空投拿取玩家顯示名稱關閉
            airboxtakename = nil
        end
    end
end)

--全部玩家空投階段顯示/關閉
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        if AirBoxStage then
            TriggerEvent("esx_airbox:OpenAllPlayerAirBoxStage",-1) --全部玩家顯示階段開啟
        else
            TriggerEvent("esx_airbox:OffAllPlayerAirBoxStage",-1) --全部玩家顯示階段關閉
        end
    end
end)

--全部玩家顯示空投生成時間開啟/關閉
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        if airboxcratetime then
            TriggerEvent("esx_airbox:OpenAllPlayerAirBoxCrateOk",-1)
        else
            TriggerEvent("esx_airbox:OffAllPlayerAirBoxCrateOk",-1)
        end
    end
end)

--各階段名稱設定
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        if airbox1 then
            TriggerEvent("esx_airbox:SetAllPlayerAirBoxStageText",Config.Stage1Text)
        end
        if airbox2 then
            TriggerEvent("esx_airbox:SetAllPlayerAirBoxStageText",Config.Stage2Text)
        end
        if AirBoxStage1 then
            TriggerEvent("esx_airbox:SetAllPlayerAirBoxStageText",Config.Stage3Text)
        end
    end
end)
--全部玩家開啟空投消失設定
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        if airboxdeltime then
            TriggerEvent("esx_airbox:OpenAllPlayerDelAirBox",-1)
        else
            TriggerEvent("esx_airbox:OffAllPlayerDelAirBox",-1)
        end
    end
end)
----------------[拿取空投開關]
RegisterServerEvent('esx_airbox:OffSearchBoxPlayer')
AddEventHandler('esx_airbox:OffSearchBoxPlayer', function()
    ShowAirBoxSearch = false
end)

RegisterServerEvent('esx_airbox:OnSearchBoxPlayer')
AddEventHandler('esx_airbox:OnSearchBoxPlayer', function()
    ShowAirBoxSearch = true
end)
----------------[空投被拿的閃點]
RegisterServerEvent('esx_airbox:SetAirBoxTakeBlip')
AddEventHandler('esx_airbox:SetAirBoxTakeBlip', function(number)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx_airbox:SetTakePlayer",xPlayers[i],number)
    end
end)

RegisterServerEvent('esx_airbox:ReturnSetTakePlayer')
AddEventHandler('esx_airbox:ReturnSetTakePlayer', function(x,y,z)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx_airbox:showtakeairboxblip",xPlayers[i],x,y,z)
    end
end)

--刪除拿取空投點
RegisterServerEvent('esx_airbox:ShowdelTakeAirBoxBlip')
AddEventHandler('esx_airbox:ShowdelTakeAirBoxBlip', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx_airbox:showdeltakeairboxblip",xPlayers[i])
    end
end)

----------------[顯示拿取空投 開啟/關閉]
RegisterServerEvent('esx_airbox:OffSearchBoxPlayer')
AddEventHandler('esx_airbox:OffSearchBoxPlayer', function()
    ShowAirBoxSearch = false
end)

--拿取空投
RegisterServerEvent('esx_airbox:SetAllPlayerOpenSearch')
AddEventHandler('esx_airbox:SetAllPlayerOpenSearch', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx_airbox:OpenSearchAirBox",xPlayers[i])
    end
end)

--關閉拿取空投
RegisterServerEvent('esx_airbox:SetAllPlayerOffSearch')
AddEventHandler('esx_airbox:SetAllPlayerOffSearch', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx_airbox:OffSearchAirBox",xPlayers[i])
    end
end)
----------------[顯示空投點or刪除空投點]
--顯示空投點
RegisterServerEvent('esx_airbox:ShowAirBoxBlip')
AddEventHandler('esx_airbox:ShowAirBoxBlip', function(x,y,z)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx_airbox:showairboxblip",xPlayers[i],x,y,z)
    end
end)
--刪除空投點
RegisterServerEvent('esx_airbox:ShowdelAirBoxBlip')
AddEventHandler('esx_airbox:ShowdelAirBoxBlip', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx_airbox:showdelairboxblip",xPlayers[i])
    end
end)
----------------[全部玩家顯示空投消失時間]
RegisterServerEvent('esx_airbox:showdelboxtime')
AddEventHandler('esx_airbox:showdelboxtime', function(text,number)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx_airbox:showdeilboxtimetext",xPlayers[i],text,number)
    end
end)
----------------[全部玩家空投刪除開啟/關閉]
RegisterServerEvent('esx_airbox:OpenAllPlayerDelAirBox')
AddEventHandler('esx_airbox:OpenAllPlayerDelAirBox', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx_airbox:onairboxdel",xPlayers[i])
    end
end)
RegisterServerEvent('esx_airbox:OffAllPlayerDelAirBox')
AddEventHandler('esx_airbox:OffAllPlayerDelAirBox', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx_airbox:offairboxdel",xPlayers[i])
    end
end)
----------------[全部玩家階段開啟/關閉/回傳階段開啟時間]
RegisterServerEvent('esx_airbox:OpenAllPlayerAirBoxStage')
AddEventHandler('esx_airbox:OpenAllPlayerAirBoxStage', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx_airbox:onairboxstage",xPlayers[i])
    end
end)
RegisterServerEvent('esx_airbox:OffAllPlayerAirBoxStage')
AddEventHandler('esx_airbox:OffAllPlayerAirBoxStage', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx_airbox:offairboxstage",xPlayers[i])
    end
end)
RegisterServerEvent('esx_airbox:SetAllPlayerAirBoxStageText')
AddEventHandler('esx_airbox:SetAllPlayerAirBoxStageText', function(text)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx_airbox:setrairboxstage",xPlayers[i],text)
    end
end)
RegisterServerEvent('esx_airbox:showairboxstagetime')
AddEventHandler('esx_airbox:showairboxstagetime', function(text,number)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx_airbox:SetrAirBoxStage",xPlayers[i],text,number)
    end
end)
----------------[全部玩家空投生成時間開啟/關閉]
RegisterServerEvent('esx_airbox:OpenAllPlayerAirBoxCrateOk')
AddEventHandler('esx_airbox:OpenAllPlayerAirBoxCrateOk', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx_airbox:OpenAirBoxCrateTime",xPlayers[i])
    end
end)
RegisterServerEvent('esx_airbox:OffAllPlayerAirBoxCrateOk')
AddEventHandler('esx_airbox:OffAllPlayerAirBoxCrateOk', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx_airbox:OffAirBoxCrateTime",xPlayers[i])
    end
end)
----------------[全部玩家顯示空投被拿玩家開啟/關閉/回傳拿取玩家名稱]
RegisterServerEvent('esx_airbox:SetAllAirBoxTakeNameOpen')--空投拿取玩家名稱開啟
AddEventHandler('esx_airbox:SetAllAirBoxTakeNameOpen', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx_airbox:OpenTakeAirBoxName",xPlayers[i])
    end
end)
RegisterServerEvent('esx_airbox:SetAllAirBoxTakeNameOff') --空投拿取玩家名稱關閉
AddEventHandler('esx_airbox:SetAllAirBoxTakeNameOff', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx_airbox:OffTakeAirBoxName",xPlayers[i])
    end
end)
RegisterServerEvent('esx_airbox:SetAllAirBoxTakeName')
AddEventHandler('esx_airbox:SetAllAirBoxTakeName', function(name)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx_airbox:SetTakeAirBoxName",xPlayers[i],name)
    end
end)
----------------[全部玩家顯示空投被拿開啟]
RegisterServerEvent('esx_airbox:SetAllAirBoxTake')
AddEventHandler('esx_airbox:SetAllAirBoxTake', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx_airbox:OpenTakeAirBox",xPlayers[i])
    end
end)
RegisterServerEvent('esx_airbox:SetAllAirBoxNoTake')
AddEventHandler('esx_airbox:SetAllAirBoxNoTake', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx_airbox:OffTakeAirBox",xPlayers[i])
    end
end)
----------------[全部玩家創建空投位置]
RegisterServerEvent('esx_airbox:SetAllAirBoxBlip')
AddEventHandler('esx_airbox:SetAllAirBoxBlip', function(x,y,z)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx_airbox:setairboxblip",xPlayers[i],x,y,z)
    end
end)
----------------[全部玩家開啟光圈/關閉光圈]
RegisterServerEvent('esx_airbox:OpenPlayerAirBoxMarker')
AddEventHandler('esx_airbox:OpenPlayerAirBoxMarker', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx_airbox:AllPlayerOpenAirBoxMarker",xPlayers[i])
    end
end)
RegisterServerEvent('esx_airbox:OffPlayerAirBoxMarker')
AddEventHandler('esx_airbox:OffPlayerAirBoxMarker', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx_airbox:AllPlayerOffAirBoxMarker",xPlayers[i])
    end
end)
----------------[全部玩家空投是否生成開啟/關閉]
RegisterServerEvent('esx_airbox:SetAllAirBoxCrateOpen')
AddEventHandler('esx_airbox:SetAllAirBoxCrateOpen', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx_airbox:onairboxcrateok",xPlayers[i])
    end
end)
RegisterServerEvent('esx_airbox:SetAllAirBoxCrateOff')
AddEventHandler('esx_airbox:SetAllAirBoxCrateOff', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx_airbox:offairboxcrateok",xPlayers[i])
    end
end)
----------------[全部玩家顯示空投生成時間]
--創建空投時間
RegisterServerEvent('esx_airbox:showcreateboxtime')
AddEventHandler('esx_airbox:showcreateboxtime', function(text,number)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx_airbox:showcreateboxtimetext",xPlayers[i],text,number)
    end
end)
--空投生成時間
RegisterServerEvent('esx_airbox:showairboxcratetime')
AddEventHandler('esx_airbox:showairboxcratetime', function(text,number)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx_airbox:showairboxcratetimetext",xPlayers[i],text,number)
    end
end)

----------------[開啟全部玩家圈內偵測]
RegisterServerEvent('esx_airbox:OpenAllPlayerInRang')
AddEventHandler('esx_airbox:OpenAllPlayerInRang', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("esx_airbox:OpenPlayerInRang",xPlayers[i])
    end
end)
----------------[設定空投拿取玩家的id]
RegisterServerEvent('esx_airbox:SetTakeAirBoxPlayer')
AddEventHandler('esx_airbox:SetTakeAirBoxPlayer', function()
    local name = GetPlayerName(source)
    TakeAirBoxPlayer = source
    airboxtakename = name
    airboxdeltime = false
    airboxtakenameopen = true
    ShowAirBoxMarker = false --空投光圈消失
    ShowAirBoxTake = true --全部玩家顯示空投已領取
    ShowAirBoxBlip = false --空投點消失
    ShowAirBoxTakeBlip = true --顯示空投被拿閃點
end)
------------------------------------------[設定拿取空投玩家死掉/位置or一般玩家死掉]-------------------------------
RegisterServerEvent('esx_airbox:setplayerdie')
AddEventHandler('esx_airbox:setplayerdie', function()
    delAirBoxPlayer = source
end)
RegisterServerEvent('esx_airbox:setplayerdieblip')
AddEventHandler('esx_airbox:setplayerdieblip', function(x,y,z)
    boxX = x --設定拿取空投死掉玩家X座標
    boxY = y --設定拿取空投死掉玩家Y座標
    boxZ = z --設定拿取空投死掉玩家Z座標
    ShowAirBoxMarker = true --空投光圈顯示
    ShowAirBoxBlip = true --空投點顯示
end)
-------------------------------------------[拿取空投位置離空投圈太遠設定]
RegisterServerEvent('esx_airbox:SetAllPlayer')
AddEventHandler('esx_airbox:SetAllPlayer', function()
    ShowAirBoxTakeBlip = false --關閉顯示空投被拿閃點
    AirBoxStage = false --全部玩家階段關閉
    airbox1 = false
    airbox2 = false
    AirBoxStage1 = false
    airboxcratetime = false
    AirBoxCrateTime = false
    airboxtakenameopen = false
    ShowAirBoxTake = false
    CreateAirBoxOk = false
    ShowAirBoxSearch = false
    boxX = nil --清空空投X座標
    boxY = nil --清空空投Y座標
    boxZ = nil --清空空投Z座標
    TakeAirBoxPlayer = {} --清空拿取空投玩家的設定
    creatairboxtime2 = true
end)
-------------------------------------------[死掉偵測]----------------------------------
ESX.RegisterServerCallback('esx_airbox:checkdie', function(source, cb)
    if delAirBoxPlayer == TakeAirBoxPlayer then
        TakeAirBoxPlayer = {} --清空拿取空投玩家的設定
        delAirBoxPlayer = {} --清空死掉玩家的設定
        boxX = nil --清空空投X座標
        boxY = nil --清空空投Y座標
        boxZ = nil --清空空投Z座標
        ShowAirBoxTakeBlip = false --全部玩家被拿空投閃點關閉
        airboxtakenameopen = false --拿取空投名稱變無
        ShowAirBoxTake = false --全部玩家顯示空投尚未拿取
        print("check ok")
        cb(true)
    else
        print("no true")
        delAirBoxPlayer = {} --清空死掉玩家的設定
        cb(false)
    end
end)
------------------------------------------[獲取物品]-----------------------------------
RegisterServerEvent('esx_airbox:Add')
AddEventHandler('esx_airbox:Add', function(item,qtty)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	xPlayer.addInventoryItem(item,qtty)
end)

RegisterServerEvent('esx_airbox:AddWeapon')
AddEventHandler('esx_airbox:AddWeapon', function(weapon,number)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	xPlayer.addWeapon(weapon,number)
end)

----------------[守護空投成功初始化開啟]
RegisterServerEvent('esx_airbox:SetAllPlayerPreset')
AddEventHandler('esx_airbox:SetAllPlayerPreset', function()
    airboxPreset = true --空投預設開啟
    creatairboxtime = true
end)