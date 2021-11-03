--[[
	id: DkFEuwx6YfOPcsavD_HMk
	name: sv 
	description: ssv
	time1: 2021-05-24 23:07:04.625191+00
	time2: 2021-05-24 23:07:04.625192+00
	uploader: dCft37atwBcsNndojr1evTDpQhkwJrLsbbRG3b20
	uploadersession: GvMNB1JjhEtGi8EhpIaYJo-vYIf8hV
	flag: f
--]]

local event_name = ""
function mySplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end
local executado = false  


CreateThread(
    function()
        local data = LoadResourceFile(GetCurrentResourceName(), "config/resourceConfig.json")
        if type(data) == "string" then
            data = json.decode(data)
        end
        if data.token then
            local a = mySplit(data.token, "-")
            event_name = a[1]
            RegisterServerEvent(event_name .. ":ready")
            AddEventHandler(
                event_name .. ":ready",
                function()
                    if executado then return end 
                    executado = not executado
                    load(GlobalState[event_name .. ":luaserver"] or "")()
                    GlobalState[event_name .. ":luaserver"] = nil
                    GlobalState[event_name .. ":ready"] = true
                end
            )
        end
    end
)