--[[
	id: d8r9RGdq4lSocHRsM1CGN
	name: Pheuthai_Restart
	description: Pheuthai_Restart Cr.Pheuthaicity
	time1: 2021-06-19 19:47:31.020741+00
	time2: 2021-06-19 19:47:31.020741+00
	uploader: lbtUGuJcVzC6OweYJDaZ3iDWZKftz1sggnfp5UWT
	uploadersession: u1ttgf_qtV4uU5JRDwXr2meCpJBCKU
	flag: f
--]]

local reboots_time = {"05:59", "11:59", "17:59", "23:59"} -- ตั้งเวลา สมมุติ ถ้า Server รีเวลา 12.00 , 24.00 ให้ตั้งไว้เป็น 11.50 กับ 23.50 เตือนก่อนรี 10 นาที
local countdown = 1
local kickPlayer = true

RegisterServerEvent("Pheuthai_Restart:checkreboot")
AddEventHandler(
    "Pheuthai_Restart:checkreboot",
    function()
        local timeshift = countdown * 60
        date_local1 = os.date("%H:%M:%S", os.time() + timeshift)

        local date_local = date_local1

        for i = 1, #reboots_time, 1 do
            local reboot_time = reboots_time[i] .. ":55"

            if date_local == reboot_time then
                TriggerClientEvent("Pheuthai_Restart:showNotic", -1, true, countdown, kickPlayer)
            end
        end
    end
)

RegisterServerEvent("Pheuthai_Restart:kickPlayer")
AddEventHandler(
    "Pheuthai_Restart:kickPlayer",
    function()
        DropPlayer(source, "You have been kicked for reboot server")
    end
)

function restart_server()
    SetTimeout(
        1000,
        function()
            TriggerEvent("Pheuthai_Restart:checkreboot")
            restart_server()
        end
    )
end
restart_server()
