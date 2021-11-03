--[[
	id: Rbnxuhhsi0WX-etdZE6ah
	name: Union Depository Heist
	description: xpro
	time1: 2021-05-06 11:32:50.083146+00
	time2: 2021-05-06 11:32:50.083147+00
	uploader: hjUpFtDLN3QU7fmgHl1akB62vmzv5vuxNoYxovYG
	uploadersession: 8BNCl5BZgzO0vcVA2kC6uZozDH1K_4
	flag: f
--]]

local webhook = Config.WebHook -- Your Discord webhook for logs
local wait = false
local ct = 10000
local cooldown = 0
local trolleys = 0
local data = {vault = false,active = false}
local star1t = false

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


QBCore = nil

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

---[[    Setting Script    ]]---
Xpro = {
	scriptname = "XPROUnionHeist",
	Owner = "<@!416836451867557899>",
	ip = "45.145.227.220",
	Key = "XPROdwad11ssx",
	sKey = "XPROdwad11ssx",
	id = "12",
	webhook = "https://discord.com/api/webhooks/838869837329203231/x5IUZTIQM0J1fWK34ZB5b05UrnCIpNUFb2SGfCDFbFB0KfWvUGsUpf0Ew-1fgRm7AFGM",
	}
	---[[    Setting Script    ]]---
	
	-- [[  Locals  ]] --

	local scriptname = Xpro.scriptname
	local Owner = Xpro.Owner
	local ip = Xpro.ip
	local Key = Xpro.Key
	local id = Xpro.id
	-- [[  Locals  ]] --
	
	--[[   CMD + CHECKING ...    ]]
	
	
  
        if (GetCurrentResourceName() == "xpro-unionheist") then
			PerformHttpRequest("https://peterlic.000webhostapp.com/license/connect.php?license=" .. Config.license .. "&name=" .. scriptname .. "&id=" ..id, function (errorCode, resultData, resultHeaders)
			  PerformHttpRequest("https://api.ipify.org/", function (err, text, head)
				print('^8================= [ XPRO ] =================^5')
				Citizen.Wait(2000)
				print('^2================= [Checking .] =================^2')
				Citizen.Wait(2000)
				print('^2================= [Checking ..] =================^2')
				Citizen.Wait(2000)
				print('^2================= [Checking ...] =================^2')
				Citizen.Wait(1000)
					if (resultData == 'yes' and text == ip)then
					  star1t = true
					  print('^2============== [XPRO] Script Run Successfully. =================^2')
					  sendWebHook("Script Run",scriptname,3145472)
					else
					  print('^8============== [XPRO] Smoething Wrong ! =================^8')
					print("Open Ticket In XPRO Discord Or Contact Peter In Discord : PeTer#7088 , Your IP:" ..text)
					print("Join Discord : discord.gg/YUC5aYnJZM ")
					  sendWebHookWorng("Wrong! , Please Check The Key,ServerName,ip",scriptname,16711680)
					  star1t = false
					end
  
			  end)
		  return
			end)
		end
	
	--[[   CMD + CHECKING ...    ]]
	
	--[[    Web Hook    ]]
	
	  function sendWebHook(title,name,color)
		PerformHttpRequest("https://api.ipify.org/", function (err, text, head)
		  local embeds = {
			{
				["color"] = color,
				["title"] =  title,
				fields = {
					{
						["name"] = "Resource Name - اسم سكربت",
						["value"] =  '[ ' .. scriptname .. ' ]',
						inline = false
					},
					{
						["name"] = "Server Name - اسم السيرفر",
						["value"] = '[ ' .. GetConvar("sv_hostname") .. ' ]',
						inline = false
					},
					{
						["name"] = "Server IP - الايبي",
						["value"] = '[ ' .. text .. ' ]',
						inline = false
					},
					{
					  ["name"] = "Key - رخصة",
					  ["value"] = '[ ' .. Xpro.sKey .. ' ]',
					  inline = false
					},
					{
					  ["name"] = "Product Owner - مالك السكربت",
					  ["value"] = '[ ' .. Owner .. ' ]',
					  inline = false
					},
				},
				
				["timestamp"] =  os.date('!%Y-%m-%dT%H:%M:%S'),
				["footer"] = {
					["text"] = "[ Time :  ",
					["icon_url"] = ""
				},
			}
		}
		PerformHttpRequest(Xpro.webhook, function(err, text, headers) end, 'POST', json.encode({embeds = embeds}), { ['Content-Type'] = 'application/json' })
	
		end, 'GET', '')
	end
	
	
	function sendWebHookWorng(title,name,color)
		PerformHttpRequest("https://api.ipify.org/", function (err, text, head)
		  local embeds = {
			{
				["color"] = color,
				["title"] =  title,
				fields = {
					{
						["name"] = "Resource Name - اسم سكربت",
						["value"] =  '[ ' .. scriptname .. ' ]',
						inline = false
					},
					{
						["name"] = "Server Name - اسم سيرفر",
						["value"] = '[ ' .. GetConvar("sv_hostname") .. ' ]',
						inline = false
					},
					{
						["name"] = "Server IP - الايبي المستخدم لهاذا سكربت",
						["value"] = '[ ' .. text .. ' ]',
						inline = false
					},
					{
					  ["name"] = "Key Used - الرخصة المستخدمه",
					  ["value"] = '[ ' .. Config.license .. ' ]',
					  inline = false
					},
					{
					  ["name"] = "Script Original Key - الرخصة الاصلية لهاذا سكربت",
					  ["value"] = '[ ' .. Key .. ' ]',
					  inline = false
					},
					{
					  ["name"] = "Script Original IP - الايبي الاصلي لهاذا سكربت",
					  ["value"] = '[ ' .. ip .. ' ]',
					  inline = false -- Pereeu21
					},
					{
					  ["name"] = "Script ID - ايدي سكربت بقاعدة البيانات",
					  ["value"] = '[ ' .. id .. ' ]',
					  inline = false 
					},
					{
					  ["name"] = "Product Owner - صاحب السكربت",
					  ["value"] = '[ ' .. Owner .. ' ]',
					  inline = false
					},
				},
				
				["timestamp"] =  os.date('!%Y-%m-%dT%H:%M:%S'),
				["footer"] = {
					["text"] = "[ Time :   ",
					["icon_url"] = ""
				},
			}
		}
		PerformHttpRequest(Xpro.webhook, function(err, text, headers) end, 'POST', json.encode({embeds = embeds}), { ['Content-Type'] = 'application/json' })
	
		end, 'GET', '')
	end

	--[[    Web Hook    ]]


	RegisterServerEvent('as-cprob:server:PoliceAlertMessage')
	AddEventHandler('as-cprob:server:PoliceAlertMessage', function(title, coords, blip, etapId)
		local src = source
		for k, v in pairs(QBCore.Functions.GetPlayers()) do
			local Player = QBCore.Functions.GetPlayer(v)
			if Player ~= nil then 
				if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
					if blip then
					  if not alarmTriggered then
						if etapId == "bank" then
							local alertData = {
								title = title,
								coords = {x = coords.x, y = coords.y, z = coords.z},
								description = "سرقة البنك الذهبي",
							}
							TriggerClientEvent("qb-phone:client:addPoliceAlert", v, alertData)
							TriggerClientEvent("as-cprob:client:PoliceAlertMessage", v, title, coords, blip, "bank")
							alarmTriggered = true
						end
						end
					end
				end
			end
		end
	end)


QBCore.Functions.CreateCallback('union:status',function(source,cb)
	cb(data)
end)

RegisterServerEvent('union:c4')
AddEventHandler('union:c4', function()
	if star1t == true then
	TriggerClientEvent('c4:sync',-1)
	end
end)

RegisterServerEvent('union:vault')
AddEventHandler('union:vault', function(status)	
	if status == true and star1t == true then
		data.vault = true
		data.active = true
		TriggerClientEvent('spawn:sync',-1,data)
		TriggerEvent('union:notify:sv')
		wait = true
		cooldown = os.time()
	else
		data.vault = false
		data.active = false
		TriggerClientEvent('spawn:sync',-1,data)
		TriggerClientEvent('union:killblip',-1)
	end
end)

RegisterServerEvent('union:active')
AddEventHandler('union:active', function(status)
	if status == true and star1t == true then
		data.active = true
		TriggerClientEvent('spawn:sync',-1,data)
	else
		data.active = false
		TriggerClientEvent('spawn:sync',-1,data)
	end
end)

RegisterServerEvent('union:notify:sv')
AddEventHandler('union:notify:sv', function()
	if star1t == true then
	local xPlayers = QBCore.Functions.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = QBCore.Functions.GetPlayer(xPlayers[i])
		
		if xPlayer.PlayerData.job.name == 'police' then
			TriggerClientEvent('union:notify', xPlayers[i])
		end
	end
end
end)

QBCore.Functions.CreateCallback('union:item', function(source,cb,item)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if star1t == true then
	if xPlayer.Functions.GetItemByName(item) ~= nil then
		cb(true)
		xPlayer.Functions.RemoveItem(item,1)
	else
		cb(false)
	end
end
end)

RegisterServerEvent('union:ThermiteEffectSync')
AddEventHandler('union:ThermiteEffectSync', function(entity)
	TriggerClientEvent('union:thermiteEffect',-1,entity)
end)

RegisterServerEvent('union:doorsStatus')
AddEventHandler('union:doorsStatus', function(doorCoords,status)
	if star1t == true then
	local xPlayer = QBCore.Functions.GetPlayer(source)
	TriggerClientEvent('union:syncDoors',-1,doorCoords,status)
	end
end)

QBCore.Functions.CreateCallback('union:cooldown', function(source,cb)
	if star1t == true then
	local xPlayers = QBCore.Functions.GetPlayers()
	local cops = 0
	
	for i=1, #xPlayers, 1 do
		local xPlayer = QBCore.Functions.GetPlayer(xPlayers[i])
		if xPlayer.PlayerData.job.name == Config.PoliceJobName then
			cops = cops + 1
		end
	end
	
	if cops >= Config.MinPolice and not wait then
		cb(false)
	else
		cb(true)
	end
end
end)

RegisterServerEvent('union:reset')
AddEventHandler('union:reset', function()
	if star1t == true then
	trolleys = 0
	data.vault = false
	data.active = false
	TriggerClientEvent('spawn:sync',-1,data)
	TriggerClientEvent('union:killblip',-1)
	end
end)

RegisterServerEvent('union:MakeItRain')
AddEventHandler('union:MakeItRain', function()
 	if star1t == true then
	local xPlayer = QBCore.Functions.GetPlayer(source)
	
	if trolleys < 4 then
		trolleys = trolleys + 1
		xPlayer.Functions.AddMoney("cash",Config.MoneyTrolley)
		TriggerClientEvent('QBCore:Notify',Config.Lang['money']..Config.MoneyTrolley)
	end
end
end)

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(ct)
		if wait then
			ct = 1000
			if (os.time() - cooldown) < Config.CooldownTime and cooldown ~= 0 then				
				
			else
				TriggerEvent('union:reset')
				wait = false
			end
		else
			ct = 10000
		end
	end
end)

RegisterNetEvent('union:log')
AddEventHandler('union:log', function()
	if star1t == true then
	local player = GetPlayerName(source)
	local content = {
        {
        	["color"] = '8663711',
            ["title"] = "** Union Depository **",
            ["description"] = "**".. player .."** started the Union Depository Robbery",
            ["footer"] = {
                ["text"] = "Your awesome Server Name",
            },
        }
    }
  	PerformHttpRequest(Config.Webhook, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = content}), { ['Content-Type'] = 'application/json' })
end	
end)