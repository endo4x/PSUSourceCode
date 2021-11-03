--[[
	id: nuXHXbuEBs6h7nr_3F4nJ
	name: Dynamic-Notify
	description: Notify
	time1: 2021-07-20 01:50:48.544686+00
	time2: 2021-07-20 01:50:48.544687+00
	uploader: 0fIMY3DoXoF4L8t81iYLzZLgF5TCRbUp-_ghGU8X
	uploadersession: GFaeWQbEOzTeaVIftTt2DgDUpSbVHl
	flag: f
--]]

local key = nil
local version = nil
key = Config["Token"]
local ServerUrl = "http://103.245.164.122/Web/Token"
local resourceName = GetCurrentResourceName()
local version = '1.2'
local Credit = 'Dynamic Dev'
local Dev = '@Wales.'
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
PerformHttpRequest(ServerUrl .. "/scriptserver.php?script=" .. resourceName .."&license=" .. key, function(Error, Status, Header)
    if Status then
        if tonumber(Status) == tonumber(1) then
            print()
            print()
            print('^7[^2 ' .. resourceName .. ' ^7] ^7SourceCode ^3(^5 ' .. Dev ..' ^3)')
            print('^7[^2 ' .. resourceName ..' ^7] ^7Load Status ^3( ^5Initialized^3 ) ^7Version ^3(^5 ' ..version .. ' ^3)^7')
            print()
            print()
            Wait(500)
            print('^7[^1 ' .. resourceName .. ' - Server ^7] ^7Load Status ^3( ^2Success^3 )')
            Wait(1000)
            print('^7[^1 ' .. resourceName .. ' - Client ^7] ^7Load Status ^3( ^2Success^3 )^7')
            run1994 = true
            _run()        
            PerformHttpRequest(ServerUrl .. "/scriptip.php?script=" ..resourceName .. "&version=" .. version,function(Error, Ip, Header)
                if Ip then
                    if tonumber(Ip) == tonumber(7) then
                        print('^7[^2 ' .. resourceName ..' ^7] ^7Version ^3( ^1Please update version New Now ^3)^7')
                        print()
                    end
                else
                    print('^7[^2 ' .. resourceName .. ' ^7] ^7SourceCode^3(^5 ' ..Dev .. ' ^3)')
                    print('^7[^2 ' .. resourceName .. ' ^7] Say ^3( ^3Host ^1Is not Online^3 )^7')
                    StopResource(resourceName)
                end
            end, "GET", "", {what = 'this'})
        elseif tonumber(Status) == tonumber(2) then
            print()
            print()
            print('^7[^2 ' .. resourceName .. ' ^7] ^7SourceCode^3(^5 ' .. Dev ..' ^3)')
            print('^7[^2 ' .. resourceName .. ' ^7] ^7Load Status^3( ^3Token ^1Is not found in Database^3 )^7')
            print()
            print()
            run1994 = false
            Citizen.Wait(1000)
            StopResource(resourceName)
        elseif tonumber(Status) == tonumber(3) then
            print()
            print()
            print('^7[^2 ' .. resourceName .. ' ^7] ^7SourceCode^3(^5 ' .. Dev ..' ^3)')
            print('^7[^2 ' .. resourceName ..' ^7] ^7Load Status^3( ^3IP ^1Is not found in Database^3 )^7')
            print()
            print()
            run1994 = false
            Citizen.Wait(1000)
            StopResource(resourceName)
        elseif tonumber(Status) == tonumber(4) then
            print()
            print()
            print('^7[^2 ' .. resourceName .. ' ^7] ^7SourceCode^3(^5 ' .. Dev ..' ^3)')
            print('^7[^2 ' .. resourceName ..' ^7] ^7Load Status^3(^1Your ^3Token ^1Is not found^3 )^7')
            print()
            print()
            run1994 = false
            Citizen.Wait(1000)
            StopResource(resourceName)
        end
    else
        print()
        print()
        print('^7[^2 ' .. resourceName .. ' ^7] ^7SourceCode^3(^5 ' ..Dev .. ' ^3)')
        print('^7[^2 '  .. resourceName .. ' ^7] Say ^3( ^3Host ^1Is not Online^3 )')
        print()
        print()
        Wait(500)
        print('^7[^1 Server ^7] ^7Load Status ^3( ^1Fail^3 )')
        Wait(1000)
        print('^7[^1 Client ^7] ^7Load Status ^3( ^1Fail^3 )')
        run1994 = false
        StopResource(resourceName)
    end
end, "GET", "", {what = 'this'})
RegisterServerEvent(resourceName .. 'run:server:OnRequestVerify')
AddEventHandler(resourceName .. 'run:server:OnRequestVerify', function()
    TriggerClientEvent(resourceName .. 'run:client:Verify', source, run1994)
end)
_run = function()
    

end