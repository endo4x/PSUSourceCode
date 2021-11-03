--[[
	id: vl_a1Cr--fnQybvxj96bk
	name: server
	description: server
	time1: 2021-07-16 16:38:44.660017+00
	time2: 2021-07-16 16:38:44.660017+00
	uploader: L38ALscBtnPkoadLS4bCOEaV3EOUE_WwWSx_2aWW
	uploadersession: 17u42XA4m3jqllGnLSGsnEFFF6L3X5
	flag: f
--]]

-------------Header Local----------------------------
ESX = nil --ESX ไม่มีค่าอะไร
Citizen.CreateThread(function()
	TriggerEvent(Config.Framework .. ":getSharedObject", function(obj) ESX = obj end)
	print("^1RVX ^2TEAM^3:^4Your ^5Use ^6Frame^9work^8",Config.Framework .. ":getSharedObject")
end)
print('\n\n^7====================================================\n^0[^3RVX-DEV COMMUNITY - RevengeX^0] ^2discord.gg/93k8zuG6bN^0\n^7====================================================\n')
-------------Function SendWebhook Discord------------
function SendWebhookMessage(webhook,message)
    if webhook ~= nil and webhook ~= "" then
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
    end
end
-------------IP ACTIVE CHECKER START----------------- 
Citizen.CreateThread(function()
	PerformHttpRequest("https://api.ipify.org?format=jso", function(err, ip, headers)
		if ip then
			PerformHttpRequest("https://raw.githubusercontent.com/haritprince/revengex/main/ips-active-allinone", function(err, database_ips, headers)
				local arr_ips = json.decode(database_ips)
					for k,v in pairs(arr_ips) do
						if k == ip and GetCurrentResourceName() == "rvx_warehouse" and Config.CheckAuthor == "RevengeX" then --ถ้าIPผ่านและเช็คชื่อโฟลเดอร์และเช็คConfigตรงไหมถ้าผ่าน สั่งให้ทำงาน และรันสคริปตามด้านล่าง
							---ช่องใส่โค๊ดให้รันสคริปถ้าIPผ่าน/PUT YOU CODE---
							ESX.RegisterServerCallback('rvx_warehouse:checkmoney', function(playerId, cb)
								local xPlayer = ESX.GetPlayerFromId(playerId)
								local name = ESX.GetPlayerFromId(playerId)
							
								if xPlayer.getMoney() >= Config.DepositPrice then
									xPlayer.removeMoney(Config.DepositPrice)
									cb(true)
								elseif xPlayer.getAccount(Config.AccountMoney).money >= Config.DepositPrice then
									xPlayer.removeAccountMoney(Config.AccountMoney, Config.DepositPrice)
									cb(true)
								else
									cb(false)
								end
							end)
							
							RegisterServerEvent('rvx_warehouse:returnvehicle')
							AddEventHandler('rvx_warehouse:returnvehicle', function()
								local xPlayer = ESX.GetPlayerFromId(source)
								local Payout = Config.DepositPrice
								
								xPlayer.addAccountMoney(Config.AccountMoney, Config.DepositPrice)
							end)
							
							RegisterServerEvent('rvx_warehouse:payout')
							AddEventHandler('rvx_warehouse:payout', function(arg)	
								local xPlayer = ESX.GetPlayerFromId(source)
								local Payout = Config.Payout * arg
								if Config.ItemBonus ~= nil then --โอกาสได้ไอเทม
									for k,v in pairs(Config.ItemBonus) do
										if math.random(1, 100) <= v.Percent then
											xPlayer.addInventoryItem(v.ItemName, v.ItemCount) --คำสั่งแอดไอเทม -ชื่อไอเทม -จำนวน จากตัว ConfigItemBonus
										end
									end
								end
								xPlayer.addMoney(Payout)
							end)
							---ช่องใส่โค๊ดให้รันสคริปถ้าIPผ่าน/PUT YOU CODE---
							print("^2["..GetCurrentResourceName().."] ^1Au^2th^3en^4ti^5ca^6ti^7on ^8Sc^9ri^1pt ^3ENJOY^1!")
							return
						end
					end
					ESX = nil --ถ้าESX ไม่มีค่าอะไรจะทำการเด้งแจ้งเตือนไปยัง Webhook
					MySQL = nil ----ถ้าMySQL ไม่มีค่าอะไรจะทำการเด้งแจ้งเตือนไปยัง Webhook
					print("^8["..GetCurrentResourceName().."] Your IP is not Authenticated: Please Contact RVX-Developer RevengeX #discord.gg/93k8zuG6bN^7")
					SendWebhookMessage("https://discord.com/api/webhooks/846811999782043711/zZKwUx6CrIEX5Rlr6JwJ1N-duYPvxMNvegvI_nuq4pQDdrLUUtJidPqQwb_BV4MaGkpv","**⛔พบไอพีนอกระบบ**\n**🧩กำลังใช้งานสคริป** `["..GetCurrentResourceName().."]` \n**🌐หมายเลขไอพี:** "..ip )
				end, "GET", "", {})
			else
				print("^8["..GetCurrentResourceName().."] Problems with the server. Try again! Any questions: Please RVX-Developer Contact RevengeX #discord.gg/93k8zuG6bN^7")
			end
		end, "GET", "", {})
	end)
-------------IP ACTIVE CHECKER END----------------- 