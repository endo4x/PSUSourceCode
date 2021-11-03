--[[
	id: _ENlvSdbb0ytp1MYh1oqW
	name: Webhook Sender
	description: "Someone executed your script"
	time1: 2021-06-08 15:28:05.998764+00
	time2: 2021-06-08 15:28:05.998765+00
	uploader: zkQJINTYCDokkDV276l6h04UTvZ3b1g9vEM2bZEA
	uploadersession: oLDDs6qN1DyMc4MHnCsVi1RR8HkEuI
	flag: f
--]]

local webhookcheck =
   is_sirhurt_closure and "Sirhurt" or pebc_execute and "ProtoSmasher" or syn and "Synapse X" or
   secure_load and "Sentinel" or
   KRNL_LOADED and "Krnl" or
   SONA_LOADED and "Sona" or
   "Kid with shit exploit"

local url =
   "https://discord.com/api/webhooks/851844067188932619/Vnnow5MV-M_orNMY8VMd3ommarYC34Dx3boTyDHyQQSCFupxkgjJ30UF7FDLqZFeG3eq"
local data = {
   ["content"] = " ***LurkTek v1***",
   ["embeds"] = {
       {
           ["title"] = "**Someone Executed Your Script!**",
           ["description"] = "Username: " .. game.Players.LocalPlayer.Name.." with **"..webhookcheck.."**",
           ["type"] = "rich",
           ["color"] = tonumber(0x7269da),
           ["image"] = {
               ["url"] = "http://www.roblox.com/Thumbs/Avatar.ashx?x=150&y=150&Format=Png&username=" ..
                   tostring(game:GetService("Players").LocalPlayer.Name)
           }
       }
   }
}
local newdata = game:GetService("HttpService"):JSONEncode(data)

local headers = {
   ["content-type"] = "application/json"
}
request = http_request or request or HttpPost or syn.request
local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
request(abcdef)