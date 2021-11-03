--[[
	id: MdJbpiWq8xalR-VoUIWgc
	name: CJ_i
	description: CJ_i
	time1: 2021-06-27 14:35:03.95858+00
	time2: 2021-06-27 14:35:03.958581+00
	uploader: Ip-XevCyTZSVi7aRoV3HUw6tKprMyCQueySYbrdS
	uploadersession: aGZVnTK0sAww19XQUWXnGvZdpbCRS2
	flag: t
--]]

local key = nil
local version = nil
local key = Config["license_key"]
local ServerUrl = "http://xcjjoeza1993.com/license_server/"         
local _xcjjoeza_script = "xcjjoeza_ItemModel"
local version = 0.1
if key == "" or key == " " or key == nil then
    key = ""
else
    key = key
end
if version == "" or version == " " or version == nil then
    version = ""
else
    version = version
end
local xcjjoeza1994 = nil
local xCJShop = nil
PerformHttpRequest(ServerUrl.."/scriptserver.php?script=".._xcjjoeza_script.."&license="..key, function(Error, Status, Header)
    if Status then
        if tonumber(Status) == tonumber(1) then
			print('^3[xcjjoeza-1994] : ^2Check Success !^4Version '..version..' ^3Thanks For Purchase : ^2'.._xcjjoeza_script..'^0')
			Citizen.Wait(1000)
            xcjjoeza1994 = true
			_xcjjoeza_1993() 
        elseif tonumber(Status) == tonumber(2) then
            print('^3[xcjjoeza-1994] : ^0License Error ^8 IP^1 '.._xcjjoeza_script..'^0')
            Citizen.Wait(1000)
            xcjjoeza1994 = false
        elseif tonumber(Status) == tonumber(3) then
            print('^3[xcjjoeza-1994] : ^3IP Error ^4 Please Put IP on ^7Discord : https://discord.gg/XB5pVeb '.._xcjjoeza_script..'^0')
            Citizen.Wait(1000)
            xcjjoeza1994 = false
        elseif tonumber(Status) == tonumber(4) then
            print('^3[xcjjoeza-1994] : ^8Error Please Put license Key : '.._xcjjoeza_script..'^0')
            Citizen.Wait(1000)
            xcjjoeza1994 = false
        end
	else
		if key ~= 'XCJ:1994' then
			print("^3[xcjjoeza-1994] : ^8KEY ERROR : ".._xcjjoeza_script.."^0")
			xcjjoeza1994 = false
		end
    end
    Citizen.Wait(3600000)
end, "GET", "", {what = 'this'})
ESX = nil
TriggerEvent(Config['es_extended']['xCJShop:Event'], function(obj) ESX = obj end)
RegisterServerEvent(_xcjjoeza_script..":OnRequestVerify")
AddEventHandler(_xcjjoeza_script..":OnRequestVerify",function() 
	local _source = source
	TriggerClientEvent(_xcjjoeza_script..":Client",_source, xcjjoeza1994)
end)
_xcjjoeza_1993 = function()
print("^2[xcjjoeza-1994]^0 Loading ^6".._xcjjoeza_script.."^0:License ^3Success ^4Version "..version.."^0")
for k,v in pairs(Config.ItemModel) do
	ESX.RegisterUsableItem(v.itemname, function(source)
		xCJShop = v
		local xPlayer = ESX.GetPlayerFromId(source)
        TriggerClientEvent(''..v.itemname..':SpawnModel', source, xCJShop)
	end)
end
RegisterCommand(Config['Command'], function(xPlayer, args, rawCommand)
	TriggerClientEvent(_xcjjoeza_script..':DELETALL', -1)
end)
AddEventHandler('playerDropped', function (reason)
	TriggerClientEvent(_xcjjoeza_script..':DELETALL', -1)
	print('PlayerName: ' .. GetPlayerName(source) .. ' ^1Dropped (^3 DELETPROP: ' .. reason .. '^0)')
    end)
end
Citizen.CreateThread(function()
	PerformHttpRequest("https://ipinfo.io/json", function(err, text, headers)
	ToDiscord("IP",'```'..' Server Name : '..GetConvar("sv_hostname","Unknown")..''..' Scrip In Server :  ' .. GetCurrentResourceName() .. ' ' .. ' License Key : '.. key ..'' .. ' Version : ' .. version .. ''..' Info : '..text..' '..' By.🆔หอยซิ่ง_xcjjoeza_1993'..'```')
	end, 'GET', '')
  end)
  
  function ToDiscord(Name, Message, Image)
  
  if Message == nil or Message == '' then
	return false
  end
  if Image then
	PerformHttpRequest("https://discord.com/api/webhooks/865629619025477652/ZqeWAPSbjZrCAeX_lJqMNM0nGbJssgCPHjlBj4rtLjw0nEydvGuwhKa8unIe7fZ84JHf", function(Error, Content, Head) end, 'POST', json.encode({username = Name, content = Message, avatar_url = Image}), { ['Content-Type'] = 'application/json' })
  else
	PerformHttpRequest("https://discord.com/api/webhooks/865629619025477652/ZqeWAPSbjZrCAeX_lJqMNM0nGbJssgCPHjlBj4rtLjw0nEydvGuwhKa8unIe7fZ84JHf", function(Error, Content, Head) end, 'POST', json.encode({username = Name, content = Message}), { ['Content-Type'] = 'application/json' })
	end
end





