--[[
	id: ONsmO3sJQ-be_2ztN0JlZ
	name: hentai
	description: sdsds
	time1: 2021-06-09 01:56:12.549961+00
	time2: 2021-06-09 01:56:12.549962+00
	uploader: zkQJINTYCDokkDV276l6h04UTvZ3b1g9vEM2bZEA
	uploadersession: oLDDs6qN1DyMc4MHnCsVi1RR8HkEuI
	flag: f
--]]

--run this and then check your workspace folder :trol:
local Endpoint = "https://nekos.life/api/v2/img/"
local Choices = {
    "yuri", -- Type = GIF or IMAGE
    "boobs", -- Type = GIF OR IMAGE
    "nsfw_neko_gif", -- Type = GIF
    "lewdk", -- Type = GIF or IMAGE
    "Random_hentai_gif", -- Type = GIF
    "hentai", -- TYPE = GIF or IMAGE
    "pussy_jpg" -- TYPE = IMAGE
}
local x = 1
local http = game:GetService("HttpService")

while wait() do
    local Type = Choices[math.random(1, 7)]
    x = x + 1
    local body =
        syn.request(
        {
            Url = Endpoint .. Type
        }
    ).Body
    local Decoded = http:JSONDecode(body)
    local URL = Decoded.url
    if URL:find(".gif") or (".Gif") then
        writefile(tostring(x) .. "_" .. Type .. ".gif", game:HttpGet(URL))
    elseif URL:find(".png") or (".jpg") then
        writefile(tostring(x) .. "_" .. Type .. ".png", game:HttpGet(URL))
    else
        warn("IMAGE INVALID. POSSIBLE ERROR")
    end
end
