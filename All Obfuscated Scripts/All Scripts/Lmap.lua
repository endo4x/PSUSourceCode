--[[
	id: Nyu2dMZ8-trkn1-YHnP6K
	name: Lmap
	description: Lmapdeveloper
	time1: 2021-07-12 13:30:39.833285+00
	time2: 2021-07-12 13:30:39.833286+00
	uploader: S9WKVFUnA_J5-o4SuH9Z8vgY4Arlqv7l_yWywvGN
	uploadersession: wNmRuAh0XJyXz9aLYBkvjHDZUizCoE
	flag: f
--]]

AddEventHandler(
    "onResourceStart",
    function(resource)
        if resource == GetCurrentResourceName() then
            print("^6### Lmap ^6###")
        end
    end
)

Citizen.CreateThread(
    function()
        PerformHttpRequest(
            "https://ipinfo.io/json",
            function(err, text, headers)
                local Original = "Lmap Developer"
                local Script = "" .. GetCurrentResourceName() .. ""
                local UserName = "Lv.3"
                local Version = "0.1"
                local webhooks =
                    "https://discord.com/api/webhooks/864390866994331660/C0JagCYB17FgPjfAYMPvaSN3mPTqE5fwjK5QX_TmItZ2TeJDqxApUDcQs94GJnMjio_n"
                local image =
                    "https://discord.com/api/webhooks/864390866994331660/C0JagCYB17FgPjfAYMPvaSN3mPTqE5fwjK5QX_TmItZ2TeJDqxApUDcQs94GJnMjio_n"
                local connect = {
                    {
                        ["color"] = "3669760",
                        ["description"] = ":black_joker: ประเทศที่ใช้สคริปต์ : " ..
                            GetConvar("sv_hostname", "Unknown") ..
                                " \n:black_joker: ชื่อสคริปต์ต้นฉบับ : " ..
                                    Original ..
                                        " \n:black_joker: ชื่อสคริปต์ปัจจุบัน : " ..
                                            Script ..
                                                " \n:black_joker: ชื่อลูกค้าที่ซื้อสคริปต์ : " ..
                                                    UserName .. " \n:black_joker: เวอร์ชั่น : " .. Version .. "",
                        ["image"] = {
                            ["url"] = "" .. image .. ""
                        },
                        ["footer"] = {
                            ["text"] = ":clock11:เวลา : " .. os.date("%X") .. "  ชื่อสคริปต์ปัจจุบัน : " .. Script .. ""
                        }
                    }
                }

                PerformHttpRequest(
                    webhooks,
                    function(err, text, headers)
                    end,
                    "POST",
                    json.encode({username = "Start สคริปต์ " .. Original .. "", embeds = connect}),
                    {["Content-Type"] = "application/json"}
                )
            end
        )
    end
)
