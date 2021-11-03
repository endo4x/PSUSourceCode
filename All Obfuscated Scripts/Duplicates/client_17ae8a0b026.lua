--[[
	id: Fu4J5NgqJvurfUU1MeG1d
	name: 空投client
	description: 無
	time1: 2021-07-12 05:39:02.890992+00
	time2: 2021-07-12 05:39:02.890993+00
	uploader: oW9rbd1CZo8Mosx5oY0HpYNrASGDwwul2meTmkKF
	uploadersession: JDCYv5Zink7bBsAlMSNMTsuYS3uS7q
	flag: f
--]]

ESX = nil
local playout = false --圈外關閉
local rangtext = false -- 顯示圈內圈外
local rangout = false
local delrang = false --圈外設定
local setrang = true --圈內設定
local OpneTakeAirBox = false --空投是否被拿(預設為關閉)
local airboxcreatOK = false --空投是否開啟(預設為關閉)
local Showairboxcreat = false --靠近空投顯示光圈(預設為關閉)
local checkondeltime = false --顯示空投消失開啟(預設為關閉)
local showdeltime = false --顯示刪除文字刪除
local OpenSearch = false --靠近空投顯示拿取(預設為關閉)
local airboxX = nil --空投X座標
local airboxY = nil --空投Y座標
local airboxZ = nil --空投Z座標
local ReviveTime = 0 --階段時間(預設為0)
local servertime = false --生存計時器開啟
local ShowServerTime = "無" --生存計時器時間文字
local PlayerTakeAirBoxOpen = false --玩家拿取空投開起(預設為關閉)
-------------[階段開關]----------------------------
local AirBoxStage = false
local AirBoxStageTime = nil
local showairboxstage = false
local AirBoxStageText = "無"
--------------------[不知道的東東預設]
local isDead = false
local IsRevive = true
local CheckTakeAirBoxName = false
local checkonAirBoxCrateTime = false
local airboxtakename = "無"
local airboxcreattime = nil
local showdeltime = false
-------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
AddEventHandler('esx:onPlayerDeath', function(data)
    if playout then
        if airboxcreatOK then
            isDead = true
            IsRevive = false
        else
            isDead = true
        end
    end
end)
------------------------------------------[顯示空投圈]--------------------------------------
Citizen.CreateThread(function()
	for k,zone in pairs(Config.airbox) do
		CreateBlipCircle(zone.coords, zone.name, zone.radius, zone.color, zone.sprite)
	end
end)
-------------------------------------------[顯示復活點]----------------------------------------------
Citizen.CreateThread(function()
    if Config.ShowReviveBlip then
        for k, v in pairs(Config.revivePos) do
            reviveblip = AddBlipForCoord(v.x,v.y,v.z)
            SetBlipSprite(reviveblip, v.sprite)
            SetBlipColour(reviveblip, v.color)
            SetBlipScale(reviveblip, v.Scale)
            SetBlipDisplay(reviveblip, 4)
            SetBlipAsShortRange(reviveblip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("復活點")
            EndTextCommandSetBlipName(reviveblip)
        end
    end
end)
-------------------------------------------[拿取空投存活計時器]---------------------------------------
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
--守護空投計時器
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if airboxcreatOK then
            if servertime then
                PlayerServerTime = Config.ServerTime / 1000
                while servertime do
                    Citizen.Wait(1000)
                    if PlayerServerTime > 0 then
                        PlayerServerTime = PlayerServerTime - 1
                        print(_U('respawn_bleedout_in',secondsToClock(PlayerServerTime)))
                        TriggerEvent("esx_airbox:showservertime",_U('respawn_bleedout_in',secondsToClock(PlayerServerTime)),PlayerServerTime)
                    end
                    if PlayerServerTime == 0 then
                        servertime = false
                        ESX.ShowNotification('恭喜您守護空投成功')
                        if Config.additem then
                            local item = math.random(#Config.AddItem)
                            itemnumber = math.random(Config.AddSmailNumber,Config.AddMaxNumber)
                            TriggerServerEvent('esx_airbox:Add',Config.AddItem[item],itemnumber) --給予守護空投成功的物品
                        end
                        if Config.addweapon then
                            local weapon = math.random(#Config.AddWeapon)
                            TriggerServerEvent('esx_airbox:AddWeapon',Config.AddWeapon[weapon],Config.Weaponnumber) --給予守護空投成功的物品
                        end
                        TriggerServerEvent("esx_airbox:SetAllPlayerPreset")
                    end
                end
            end
        end
    end
end)

------------------------------------------[玩家生存顯示時間]------------------------------------------
RegisterNetEvent('esx_airbox:showservertime')
AddEventHandler('esx_airbox:showservertime', function(text,number)
    if number > 1 then
        showservertime = true
        ShowServerTime = text
    else
        showservertime = false
    end
end)
--------------------------------------------[創建空投座標]
RegisterNetEvent('esx_airbox:setairboxblip')
AddEventHandler('esx_airbox:setairboxblip', function(X,Y,Z)
    airboxX = X
    airboxY = Y
    airboxZ = Z
end)
--------------------------------------------[創建空投被拿玩家座標]
RegisterNetEvent('esx_airbox:SetTakePlayer')
AddEventHandler('esx_airbox:SetTakePlayer', function(number)
    local id = GetPlayerFromServerId(number)
    local ped = GetPlayerPed(id)
    local x, y, z = table.unpack(GetEntityCoords(ped, true))
    TriggerServerEvent('esx_airbox:ReturnSetTakePlayer',x,y,z)
end)
--------------------------------------------[階段開啟/關閉]------------------------------------------------------------
RegisterNetEvent('esx_airbox:onairboxstage')
AddEventHandler('esx_airbox:onairboxstage', function()
    AirBoxStage = true
end)
RegisterNetEvent('esx_airbox:offairboxstage')
AddEventHandler('esx_airbox:offairboxstage', function()
    AirBoxStageText = "無"
    AirBoxStage = false
end)
RegisterNetEvent('esx_airbox:SetrAirBoxStage')
AddEventHandler('esx_airbox:SetrAirBoxStage', function(text,number)
    if number > 1 then
        showairboxstage = true
        AirBoxStageTime = text
    else
        showairboxstage = false
    end
end)

RegisterNetEvent('esx_airbox:setrairboxstage')
AddEventHandler('esx_airbox:setrairboxstage', function(text)
    AirBoxStageText = text
end)
--------------------------------------------[顯示生成文字 開啟/關閉]--------------------------------------------------------------
RegisterNetEvent('esx_airbox:showcreateboxtimetext')
AddEventHandler('esx_airbox:showcreateboxtimetext', function(text,number)
    if number > 1 then
        showtime = true
        time = text
    else
        showtime = false
    end
end)
--------------------------------------------[顯示消失文字 開啟/關閉]--------------------------------------------------------------
RegisterNetEvent('esx_airbox:showdeilboxtimetext')
AddEventHandler('esx_airbox:showdeilboxtimetext', function(text,number)
    if number > 1 then
        showdeltime = true
        deltime = text
    else
        showdeltime = false
    end
end)
--------------------------------------------[顯示空投生成文字]----------------------------------------------------------
RegisterNetEvent('esx_airbox:showairboxcratetimetext')
AddEventHandler('esx_airbox:showairboxcratetimetext', function(text,number)
    if number > 1 then
        OpenAirBoxCrateTime = true
        airboxcreattime = text
    else
        OpenAirBoxCrateTime = false
    end
end)
RegisterNetEvent('esx_airbox:OpenAirBoxCrateTime')
AddEventHandler('esx_airbox:OpenAirBoxCrateTime', function()
    checkonAirBoxCrateTime = true
end)
RegisterNetEvent('esx_airbox:OffAirBoxCrateTime')
AddEventHandler('esx_airbox:OffAirBoxCrateTime', function()
    checkonAirBoxCrateTime = false
end)
---------------------------------------------[確認拿取空投玩家名稱開啟/關閉/設定拿取空投玩家的名稱]
RegisterNetEvent('esx_airbox:OpenTakeAirBoxName')
AddEventHandler('esx_airbox:OpenTakeAirBoxName', function()
    CheckTakeAirBoxName = true
end)
RegisterNetEvent('esx_airbox:OffTakeAirBoxName')
AddEventHandler('esx_airbox:OffTakeAirBoxName', function()
    CheckTakeAirBoxName = false
    airboxtakename = "無"
end)
RegisterNetEvent('esx_airbox:SetTakeAirBoxName')
AddEventHandler('esx_airbox:SetTakeAirBoxName', function(name)
    airboxtakename = name
end)
--------------------------------------------[空投是否拿取開啟/關閉]-----------------------------------------------------
RegisterNetEvent('esx_airbox:OpenTakeAirBox')
AddEventHandler('esx_airbox:OpenTakeAirBox', function()
    OpneTakeAirBox = true
end)
RegisterNetEvent('esx_airbox:OffTakeAirBox')
AddEventHandler('esx_airbox:OffTakeAirBox', function()
    OpneTakeAirBox = false
end)
--------------------------------------------[空投拿取開啟/關閉]---------------------------------------------------------
--全部玩家拿取空投
RegisterNetEvent('esx_airbox:OpenSearchAirBox')
AddEventHandler('esx_airbox:OpenSearchAirBox', function()
    OpenSearch = true
end)
--全部玩家禁止拿取空投
RegisterNetEvent('esx_airbox:OffSearchAirBox')
AddEventHandler('esx_airbox:OffSearchAirBox', function()
    OpenSearch = false
end)
--------------------------------------------[空投光圈開啟/關閉]---------------------------------------------------------
--全部玩家顯示空投光圈
RegisterNetEvent('esx_airbox:AllPlayerOpenAirBoxMarker')
AddEventHandler('esx_airbox:AllPlayerOpenAirBoxMarker', function()
    Showairboxcreat = true
end)
--全部玩家關閉空投光圈
RegisterNetEvent('esx_airbox:AllPlayerOffAirBoxMarker')
AddEventHandler('esx_airbox:AllPlayerOffAirBoxMarker', function()
    Showairboxcreat = false
end)
--------------------------------------------[空投生成開啟/關閉]---------------------------------------------------------
RegisterNetEvent('esx_airbox:onairboxcrateok')
AddEventHandler('esx_airbox:onairboxcrateok', function()
    airboxcreatOK = true
end)
RegisterNetEvent('esx_airbox:offairboxcrateok')
AddEventHandler('esx_airbox:offairboxcrateok', function()
    airboxcreatOK = false
end)
--------------------------------------------[空投刪除開啟/關閉]---------------------------------------------------------
RegisterNetEvent('esx_airbox:onairboxdel')
AddEventHandler('esx_airbox:onairboxdel', function()
    checkondeltime = true
end)
RegisterNetEvent('esx_airbox:offairboxdel')
AddEventHandler('esx_airbox:offairboxdel', function()
    checkondeltime = false
end)
--------------------------------------------[顯示圈內開啟]--------------------------------------------------------------
RegisterNetEvent('esx_airbox:OpenPlayerInRang')
AddEventHandler('esx_airbox:OpenPlayerInRang', function()
    OpenPlayerInRang = true
end)
----------------------------------------------[多項顯示文字]-------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if playout then
            if Config.Text then
                DrawText2(Config.Textname,0.43,0.100)
				DrawText2(Config.Textname1,0.45,0.130)
                DrawText2(Config.Textname2,0.44,0.160)
            end
            if AirBoxStage then --階段顯示
                if AirBoxStageText == Config.Stage1Text then
                    DrawTxt("死亡復活時間:~g~10秒",0.02, 0.72)
                    ReviveTime = Config.StageTime1 * 1000
                elseif AirBoxStageText == Config.Stage2Text then
                    DrawTxt("死亡復活時間:~g~15秒",0.02, 0.72)
                    ReviveTime = Config.StageTime2 * 1000
                elseif AirBoxStageText == Config.Stage3Text then
                    DrawTxt("死亡復活時間:~g~20秒",0.02, 0.72)
                    ReviveTime = Config.StageTime3 * 1000
                end
            end
            if showtime then --空投生成
                DrawTxt1("~r~空投生成時間剩下:"..time,0.40,0.060)
            end
            if OpneTakeAirBox then
                DrawTxt("空投是否被拿:~g~已經拿取",0.02, 0.51)
            else --空投尚未生成
                DrawTxt("空投是否被拿:~r~尚未拿取",0.02, 0.51)
            end
            if CheckTakeAirBoxName then
                DrawTxt("空投拿取玩家:"..airboxtakename,0.02, 0.69)
            else
                DrawTxt("空投拿取玩家:~r~無",0.02, 0.69)
            end
            if checkonAirBoxCrateTime then
                if OpenAirBoxCrateTime then
                    DrawTxt("空投生成時間:"..airboxcreattime,0.02, 0.54)
                end
            end
            if airboxcreatOK then --空投創建成功
                DrawText2("~b~=====[空投資訊]=====",0.02, 0.45)
                DrawTxt("空投是否生成:~g~已經生成",0.02, 0.48)
            else --空投尚未生成
                DrawText2("~b~=====[空投資訊]=====",0.02, 0.45)
                DrawTxt("空投是否生成:~r~尚未生成",0.02, 0.48)
            end
            if rangtext then --顯示您再圈內
                DrawText2("=====[玩家資訊]=====",0.02, 0.63)
                DrawTxt("是否再圈內:~g~您再圈內",0.02, 0.66)
                DrawText2("==================",0.02, 0.77)
            end
            if AirBoxStage then
                if showairboxstage then
                    DrawTxt("空投下一階段:"..AirBoxStageTime.."~r~秒",0.02, 0.60)
                end
                DrawTxt("空投目前階段:~g~"..AirBoxStageText,0.02, 0.57)
            end
            if servertime then
                if showservertime then
                    DrawTxt("生存剩餘時間:"..ShowServerTime,0.02, 0.75)
                end
            end
            if checkondeltime then
                if showdeltime then --空投消失
                    DrawTxt1("~r~空投尚未拿取將會在:"..deltime.."~r~秒後消失",0.38,0.060)
                end
            end
        end
        if rangout then
            if showtime then
                DrawTxt1("~r~空投將再:"..time.."~r~隨機掉落再空投圈內",0.33,0.090)
            end
        end
    end
end)
----------------------------------------------[靠近空投點顯示空投點/被創建靠近才會顯示]-------------------------------------------------------
Citizen.CreateThread(function ()
	while true do
	  	Citizen.Wait(0)
	 	local coords = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker = false
		local ped = PlayerPedId()
		local playerCoords = GetEntityCoords(ped)
        if Showairboxcreat then
            local distAIRBOXBLIP = GetDistanceBetweenCoords(airboxX,airboxY,airboxZ,playerCoords.x,playerCoords.y,playerCoords.z,true)--靠近進入點
            if distAIRBOXBLIP <= 200.0 then
                isInMarker = true
                if isInMarker then
                    DrawMarker(23, airboxX,airboxY,airboxZ + 0.15, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.2, 0, 0, 255, 200, false, true, 2, false, false, false, false)
                    DrawMarker(40, airboxX,airboxY,airboxZ + 1.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 0, 255, 200, false, true, 2, false, false, false, false)
                end
            else
                isInMarker = false
            end
        end
    end
end)
---------------------[未知]
Citizen.CreateThread(function ()
	while true do
	  	Citizen.Wait(0)
        if airboxcreatOK then
            for k,v in pairs(Config.airbox) do
                local ped = GetPlayerPed(-1)
                local playerCoords = GetEntityCoords(ped)
                local playerbox = GetDistanceBetweenCoords(v.coords,playerCoords.x,playerCoords.y,playerCoords.z,true)--靠近圈內
                if playerbox >= 200.0 then
                    if PlayerTakeAirBoxOpen then
                        ESX.ShowNotification('~g~您拿取空投離空投圈太遠\n空投正在重新生成\n請等待生成時間')
                        servertime = false
                        PlayerTakeAirBoxOpen = false
                        TriggerServerEvent("esx_airbox:SetAllPlayer")
                    end
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function ()
	while true do
	  	Citizen.Wait(0)
        if OpenPlayerInRang then
            for k,v in pairs(Config.airbox) do
                local ped = GetPlayerPed(-1)
                local playerCoords = GetEntityCoords(ped)
                local playerbox = GetDistanceBetweenCoords(v.coords,playerCoords.x,playerCoords.y,playerCoords.z,true)--靠近圈內
                if playerbox <= 200.0 then
                    if not DoesEntityExist(veh) then 
						local ped = GetPlayerPed(-1)
						if DoesEntityExist(ped) and not IsEntityDead(ped) then 
							local pos = GetEntityCoords(ped)
							if IsPedSittingInAnyVehicle(ped) then 
								local vehicle = GetVehiclePedIsIn(ped,false)
								if GetPedInVehicleSeat(vehicle,-1) == ped then 
									DeleteGivenVehicle(vehicle,numRetries)
								end 
							end 
						end 
					end
                    playout = true
                    rangtext = true
                    rangout = false
                    if setrang then
                        exports['progressBars']:startUI(1000, "進入空投區域!")
                        setrang = false
                        delrang = true
                    end
                elseif playerbox <= 300.0 then
                    playout = false
                    rangtext = false
                    rangout = true
                    if delrang then
                        exports['progressBars']:startUI(1000, "離開空投區域!")
                        delrang = false
                        setrang = true
                    end
                else
                    playout = false
                    rangtext = false
                end
            end
        end
    end
end)
-------------------------[拿取空投區域]----------------------------------------
Citizen.CreateThread(function()
    Citizen.Wait(0)
    while true do
        Citizen.Wait(0)
        if OpenSearch then
            local ped = GetPlayerPed(-1)
            local playerCoords = GetEntityCoords(ped)
            local OpenSearchBox = GetDistanceBetweenCoords(airboxX,airboxY,airboxZ,playerCoords.x,playerCoords.y,playerCoords.z,true)--靠近空投
            if OpenSearchBox <= 2.0 then
                ESX.ShowHelpNotification(_U('take_airbox'))
                if IsControlJustPressed(0, 38) then
                    if IsRevive then
                        OpenSearch = false
                        TriggerServerEvent("esx_airbox:OffSearchBoxPlayer")
                        FreezeEntityPosition(ped, true)
                        exports['progressBars']:startUI(3000, "正在拿取...")
                        Citizen.Wait(3000)
                        FreezeEntityPosition(ped, false)
                        TriggerServerEvent("esx_airbox:SetTakeAirBoxPlayer")
                        ESX.ShowNotification('~g~已經拿取\n請生存五分鐘')
                        servertime = true
                        PlayerTakeAirBoxOpen = true
                    end
                end
            end
        end
    end
end)
----------------------------------------------------[玩家圈內死亡]----------------------------------------------------------
Citizen.CreateThread(function ()
	while true do
        Citizen.Wait(0)
        if playout then
            for k,v in pairs(Config.airbox) do
                local ped = GetPlayerPed(-1)
                local playerCoords = GetEntityCoords(ped)
                local playerbox = GetDistanceBetweenCoords(v.coords,playerCoords.x,playerCoords.y,playerCoords.z,true)--靠近圈內
                if playerbox <= 200.0 then
                    if airboxcreatOK then
                        if isDead then
                            TriggerServerEvent('esx_airbox:setplayerdie')
                            onDeath(data)
                            isDead = false
                            IsRevive = true
                        end
                    else
                        if isDead then
                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), Config.society, Config.Billname, Config.amount)
                            onDeath1(data)
                            isDead = false
                        end
                    end
                end
            end
        end
    end
end)

function onDeath1(data)
    local ped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(ped)
    exports['progressBars']:startUI(10000, "等待復活!")
    Wait(10000)
    local point = math.random(#Config.revivePos)
    Teleport(Config.revivePos[point].x,Config.revivePos[point].y,Config.revivePos[point].z)
    print("teleok")
    TriggerEvent('esx_airbox:reviveplayer')
    SetEntityHealth(PlayerId(), Config.SpawnHealth)
end

function onDeath(data)
    local ped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(ped)
    ESX.TriggerServerCallback('esx_airbox:checkdie', function(success)
        if success then --拿空投玩家死亡區
            servertime = false
            TriggerServerEvent('esx_airbox:setplayerdieblip',playerCoords.x,playerCoords.y,playerCoords.z-1.0) --設定空投拿取玩家死掉的位置
            TriggerServerEvent("esx_airbox:OnSearchBoxPlayer") --全部玩家搜取空投開啟
        else
            TriggerServerEvent("esx_airbox:OnSearchBoxPlayer") --全部玩家搜取空投開啟
        end
    end)
    exports['progressBars']:startUI(ReviveTime, "等待復活!")
    Wait(ReviveTime)
    local point = math.random(#Config.revivePos)
    Teleport(Config.revivePos[point].x,Config.revivePos[point].y,Config.revivePos[point].z)
    print("teleok")
    TriggerEvent('esx_airbox:reviveplayer')
    SetEntityHealth(PlayerId(), Config.SpawnHealth)
end

function Teleport(x,y,z)
	fade()
	local playerPed = PlayerPedId()
	SetCoords(playerPed, x, y, z - 0.98)
	SetEntityHeading(playerPed, 0.0)
end

function fade()
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
end

function SetCoords(playerPed, x,y,z)
	SetEntityCoords(playerPed, x, y, z)
	Citizen.Wait(100)
	SetEntityCoords(playerPed, x, y, z)
end

------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('esx_airbox:reviveplayer')
AddEventHandler('esx_airbox:reviveplayer', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(50)
		end

		local formattedCoords = {
			x = ESX.Math.Round(coords.x, 1),
			y = ESX.Math.Round(coords.y, 1),
			z = ESX.Math.Round(coords.z, 1)
		}

		ESX.SetPlayerData('lastPosition', formattedCoords)

		TriggerServerEvent('esx:updateLastPosition', formattedCoords)

		RespawnPed(playerPed, formattedCoords, 0.0)

		StopScreenEffect('DeathFailOut')
		DoScreenFadeIn(800)
	end)
end)

function RespawnPed(ped, coords, heading)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z)
	ClearPedBloodDamage(ped)

	ESX.UI.Menu.CloseAll()
end

function DeleteGivenVehicle( veh, timeoutMax )
    local timeout = 0 

    SetEntityAsMissionEntity( veh, true, true )
    DeleteVehicle( veh )

    if ( DoesEntityExist( veh ) ) then
        while ( DoesEntityExist( veh ) and timeout < timeoutMax ) do 
            DeleteVehicle( veh )

            timeout = timeout + 1 
            Citizen.Wait( 500 )
        end 
    end 
end 

function GetVehicleInDirection( entFrom, coordFrom, coordTo )
	local rayHandle = StartShapeTestCapsule( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 5.0, 10, entFrom, 7 )
    local _, _, _, _, vehicle = GetShapeTestResult( rayHandle )
    
    if ( IsEntityAVehicle( vehicle ) ) then 
        return vehicle
    end 
end