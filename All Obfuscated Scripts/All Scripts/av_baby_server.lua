--[[
	id: m3DzXb8GqjSWF145avvHh
	name: av_baby_server
	description: av_baby_server
	time1: 2021-06-22 13:36:14.404353+00
	time2: 2021-06-22 13:36:14.404353+00
	uploader: 0lXSC9Q-U1coaa_LJ3Y4z0ksSbDtOnFnk-FHONUw
	uploadersession: bT8lPMVQRr9_avVe8cLBcyHEwpKwPL
	flag: f
--]]

function getBabyPed(player)
    local ped = nil
    for i, id in ipairs(whitelisted) do
        for x, pid in ipairs(GetPlayerIdentifiers(player)) do
            if string.lower(pid) == string.lower(id.identifier) then
                ped = id.ped
            end
        end
    end
    return ped
end

RegisterCommand(
    "bebek:cagir",
    function(source, args)
        local model = getBabyPed(source)
        if model ~= nil then
            TriggerClientEvent("av_baby:spawn", source, model)
        else
            TriggerClientEvent("av_baby:notification", source, Config.Lang["not_whitelisted"])
        end
    end
)

whitelisted = {
    {identifier = 'steam:110000109ae536b', ped = 'Baby_1'}, -- Can
    {identifier = 'steam:1100001400a2149', ped = 'Baby_12'}, -- İrem
    {identifier = 'steam:110000109b24fb6', ped = 'Baby_12'} -- Alp

    
    -- {identifier = 'license:1244676646545', ped = 'Baby_1'}
}

