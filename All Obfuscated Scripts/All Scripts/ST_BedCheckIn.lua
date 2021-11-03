--[[
	id: ssRwUILFIYC9q5HnEhHIN
	name: ST_BedCheckIn
	description: ST_BedCheckIn
	time1: 2021-07-07 18:12:02.777965+00
	time2: 2021-07-07 18:12:02.777965+00
	uploader: azg_ZKdl3lp6wXe-hp6pvE_gD2aBGfFJfID-Jue1
	uploadersession: cSF_9i4YQnM2cTVO2AJRmb3rZ1Nuyq
	flag: f
--]]

local key = nil
local version = nil
key = Config.UserLicense
local ServerUrl = "http://103.141.69.156/license_server"         -- เลข  ip VPS ตัวเอง
local resourceName = GetCurrentResourceName()
local version = '1.0'
local Credit = 'ST_DEVELOPER'
if key == "" or key == " " or key == nil then
    key = ""
else
    key = key
end
if version == "" or version == " " or version == nil then
    version = ""
else
    version = version
end
run1994 = nil
PerformHttpRequest(ServerUrl.."/scriptserver.php?script="..resourceName.."&license="..key, function(Error, Status, Header)
    if Status then
        if tonumber(Status) == tonumber(1) then
            print('\n^9ScriptName: ^3['..resourceName..']^9 Version: ^3['..version..'] ^9Credit: ^3['..Credit..']')
            run1994 = true
            _run()
            PerformHttpRequest(ServerUrl.."/scriptip.php?script="..resourceName.."&version="..version, function(Error, Ip, Header)
                if Ip then
                    if tonumber(Ip) == tonumber(6) then
                        print('VersionCheck: '..resourceName..' Is version Present ')
                    elseif tonumber(Ip) == tonumber(7) then
                        print('VersionCheck: Please update '..resourceName..' version New Now ')
                    end
                else
                    print("\nServer Error ")
                    StopResource(resourceName)
                end
            end, "GET", "", {what = 'this'})
        elseif tonumber(Status) == tonumber(2) then
            print('\nlicense Error '..resourceName)
            run1994 = false
            Citizen.Wait(1000)
            StopResource(resourceName)
        elseif tonumber(Status) == tonumber(3) then
            print('\nIP Error '..resourceName)
            run1994 = false
            Citizen.Wait(1000)
            StopResource(resourceName)
        elseif tonumber(Status) == tonumber(4) then
            print('\nError Please Input license Key '..resourceName)
            run1994 = false
            Citizen.Wait(1000)
            StopResource(resourceName)
        end
    else
        print("\nServer Error ")
        run1994 = false
        StopResource(resourceName)
    end
end, "GET", "", {what = 'this'})

RegisterServerEvent(
	"ST_BedCheckin:run:server:OnRequestVerify")
AddEventHandler(
	"ST_BedCheckin:run:server:OnRequestVerify",
	function() 
	    TriggerClientEvent("ST_BedCheckin:run:client:Verify", source, run1994)
    end
)

_run = function()
    ESX = nil

ST = GetCurrentResourceName()

TriggerEvent(
    "esx:getSharedObject",
    function(obj)
        ESX = obj
    end
)

RegisterServerEvent(ST .. "CheckMoney")
AddEventHandler(
    ST .. "CheckMoney",
    function()
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        TriggerClientEvent(ST .. "HaveMoney", source)
        xPlayer.removeMoney(100)
    end
)

end

