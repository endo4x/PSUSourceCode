--[[
	id: 9whCnAupPp-nStC-tVkXa
	name: loader test
	description: test of aw lua loader (all)
	time1: 2021-07-21 01:28:15.912408+00
	time2: 2021-07-21 01:28:15.912409+00
	uploader: hnNPbegf_x_KvNuAW01zweMZHwhh0U5EzinSZ3El
	uploadersession: Nx2o45AL5P5r1ISXrL-UIBiNYAkliT
	flag: f
--]]

local lex = {}

function lex.log(type, text)

    print("[ALL][" .. type .. "][" .. os.date('%Y-%m-%d | %H:%M:%S') .. "][" .. text .. "]")

end

function lex.onLoad()

    -- basic security check
    if _VERSION ~= 'Lua 5.1' then
        return
    end

    local keys = {
        'TKsPGmid', -- json library
        'ASkFv4NZ',  -- db
        'f1UZASCB', -- lua
        'z87indPW', --\\ START junk
        'I0zKYZ11',
        'BS0NbFuU',
        'Jl7lVQqq',
        'PrxAtBUz',
        'TYJxMMs3',
        'RPhrgOfg',
        'Wxq7YK6P',
        'h6vbzOxo',
        'f1jJrbNb',
        'YXaSqhzu',
        '9DgGyNcr',
        'exaFOmE3',
        'kafIk4WE'  --\\ END junk
    }

    local jsonutil = file.Open('loaderutil01.lua', 'w')
    jsonutil:Write(http.Get('https://pastebin.com/raw/' .. keys[1]))   -- json library
    jsonutil:Close()                  -- creates the json library file for temporary use
                                        -- could load json file from web but is unstable that way for some reason
    LoadScript('loaderutil01.lua')    -- load the json library

    local info = cheat.GetUserID() -- aimware id
    local db = http.Get('https://pastebin.com/raw/' .. keys[2])              -- our database, i use random var names for security
    local shit = http.Get('https://pastebin.com/raw/' .. keys[math.random(4, 16)])
    http.Get('https://api.hashify.net/hash/md5/hex?value=' .. info, function(response) -- encode steamids in md5 so if the database is compromised the users steamIDS are somewhat safe
        local packed = json.decode(response) -- our response being processed by the json library
        local hash = packed['Digest']
        if db:find(hash) then
            lex.log("Auth", "Authorization Successful @ " .. hash)         -- successfully authorized, safe to load script

            local temp = file.Open('.hash_stored.lua', 'w')
            temp:Write(http.Get('https://pastebin.com/raw/' .. keys[3]))
            temp:Close()
            LoadScript('.hash_stored.lua')
            file.Delete('.hash_stored.lua')
        else
            lex.log("Auth", "Authorization Failed @ " .. hash)
        end
        return
    end)

    UnloadScript('loaderutil01.lua')    -- unload json library
    file.Delete('loaderutil01.lua')     -- delete the file so that it doesnt take up any space on the users system
end

lex.onLoad()