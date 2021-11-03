--[[
	id: DIvOwT8VaN-IfLiePpq40
	name: asdf
	description: asdf
	time1: 2021-05-15 11:39:31.761457+00
	time2: 2021-05-15 11:39:31.761458+00
	uploader: 286
	uploadersession: nQYa-6eonv5yHPW7T8Z_lyYTwblgs2
	flag: f
--]]


local old;
old = replaceclosure(game.HttpGet, function(self, url, bool)
    if url:match("Private") then return old(self, url, bool) end
    return old(self, url, bool)
end)

local hwid = "POG"
local dickKey = "VHbggCX5A5Z6GzEfxHZqR6A5kgcMyJHQ"
local urlbase = "^https?://.+/"
local res;
---------- crack Pog ----------
replaceclosure(syn.request, function(b)
    if b.Url:match(urlbase .. "Xenonhub") then
        res = {
            Key = _G.Keys,
            Blacklist = "False",
            Hwid = hwid,
            Random = b.Url:split('&random=')[2]
        }
        return {Body = syn.crypt.base64.encode(game:GetService("HttpService"):JSONEncode(res))}
    elseif b.Url:match(urlbase .. "Hwid") then
        return {StatusMessage = "OK", Success = true, StatusCode = 200, Body = hwid}
    elseif b.Url:match(urlbase .. "whitelist") then
        return {Body = syn.crypt.custom.hash('sha512', dickKey .. res.Key .. res.Hwid .. b.Url:match("&ran=(.+)&") .. dickKey)}
    end
    return {Body = ""}
end)

---------------- change ui ----------------
local mt = getrawmetatable(game)
local old = mt.__newindex

setreadonly(mt, false)
mt.__newindex = newcclosure(function(o, k, v)
    if type(v) == "string" then
        if v:match("Xenon") then
            return old(o, k, "SHITSCRIPT-XENON")
        end
    end
    return old(o, k, v)
end)
setreadonly(mt, true)
loadstring(game:HttpGet('https://xenonhub.net/raw/script'))(); --MADE BY POLAR
