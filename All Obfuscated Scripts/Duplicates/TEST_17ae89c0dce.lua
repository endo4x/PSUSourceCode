--[[
	id: P_0ki23OdqClhv8oJPRGW
	name: TEST
	description: TEST
	time1: 2021-07-06 16:39:45.468187+00
	time2: 2021-07-06 16:39:45.468188+00
	uploader: azg_ZKdl3lp6wXe-hp6pvE_gD2aBGfFJfID-Jue1
	uploadersession: cSF_9i4YQnM2cTVO2AJRmb3rZ1Nuyq
	flag: f
--]]

PerformHttpRequest(
    ServerUrl .. "/file/scriptserver.php?script=" .. resourceName .. "&license=" .. key,
    function(Error, Status, Header)
        if Status then
            if tonumber(Status) == tonumber(1) then
                print(
                    "^9ScriptName: ^3[" ..
                        resourceName .. "]^9 Version: ^3[" .. version .. "] ^9Credit: ^3[" .. Credit .. "]"
                )
                run1994 = true
                _run()
                PerformHttpRequest(
                    ServerUrl .. "/file/versionserver.php?script=" .. resourceName .. "&version=" .. version,
                    function(Error, versioncheck, Header)
                        if versioncheck then
                            if tonumber(versioncheck) == tonumber(1) then
                                print("VersionCheck: " .. resourceName .. " Is version Present ")
                            elseif tonumber(versioncheck) == tonumber(2) then
                                print("VersionCheck: Please update " .. resourceName .. " version New Now ")
                            end
                        end
                    end,
                    "GET",
                    "",
                    {what = "this"}
                )
            elseif tonumber(Status) == tonumber(2) then
                print("Ip Error " .. resourceName)
                run1994 = false
                Citizen.Wait(1000)
                StopResource(resourceName)
            elseif tonumber(Status) == tonumber(3) then
                print("license Error " .. resourceName)
                run1994 = false
                Citizen.Wait(1000)
                StopResource(resourceName)
            elseif tonumber(Status) == tonumber(4) then
                print("Error Please Input license Key " .. resourceName)
                run1994 = false
                Citizen.Wait(1000)
                StopResource(resourceName)
            end
        else
            print("Server Error ")
            run1994 = false
            StopResource(resourceName)
        end
    end,
    "GET",
    "",
    {what = "this"}
)
