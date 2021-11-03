--[[
	id: VvLLchkfmstr8ky9Wzomd
	name: esx sellvehicles - server side
	description: server side m3rd most3ml
	time1: 2021-07-07 19:29:37.960176+00
	time2: 2021-07-07 19:29:37.960184+00
	uploader: MJ8luLrubA2NZFT6vtvVlPabE_k6SPkxygttv6VR
	uploadersession: 8g13hNJNxeRu_fZqSKRFHuLolbLqk8
	flag: f
--]]

ESX = nil

TriggerEvent("esx:getSharedObject", function(response)
    ESX = response
end)

local VehiclesForSale = 0

--Send the message to your discord server
function sendToDiscord (name,message,color)
  local DiscordWebHook = Config.Webhook
  -- Modify here your discordWebHook username = name, content = message,embeds = embeds

local embeds = {
    {
        ["title"]=message,
        ["type"]="rich",
        ["color"] =color,
        ["footer"]=  {
            ["text"]= "المعارض المستعملة",
       },
    }
}

  if message == nil or message == '' then return FALSE end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

ESX.RegisterServerCallback("esx-qalle-sellvehicles:retrieveVehicles", function(source, cb)
	local src = source
	local identifier = ESX.GetPlayerFromId(src)["identifier"]

    MySQL.Async.fetchAll("SELECT seller, vehicleProps, price, info, name, priceold, levelold FROM vehicles_for_sale", {}, function(result)
        local vehicleTable = {}

        VehiclesForSale = 0

        if result[1] ~= nil then
            for i = 1, #result, 1 do
                VehiclesForSale = VehiclesForSale + 1

				local seller = false

				if result[i]["seller"] == identifier then
					seller = true
				end

                table.insert(vehicleTable, { ["price"] = result[i]["price"], ["info"] = result[i]["info"], ["vehProps"] = json.decode(result[i]["vehicleProps"]), ["owner"] = seller, ["priceold"] = result[i]["priceold"], ["levelold"] = result[i]["levelold"] , ["name"] = result[i]["name"] })
            end
        end

        cb(vehicleTable)
    end)
end)


ESX.RegisterServerCallback("esx-qalle-sellvehicles:isVehicleValid", function(source, cb, vehicleProps, price, info)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
    
    local plate = vehicleProps["plate"]

	local isFound = false

	RetrievePlayerVehicles(xPlayer.identifier, function(ownedVehicles)

		for id, v in pairs(ownedVehicles) do

			if Trim(plate) == Trim(v.plate) and #Config.VehiclePositions ~= VehiclesForSale then
  
                local resultTwo = MySQL.Sync.fetchAll('SELECT name, priceold, levelold FROM owned_vehicles WHERE plate = @plate', {
			    ['@plate'] = plate
		        })
  
                MySQL.Async.execute("INSERT INTO vehicles_for_sale (seller, vehicleProps, price, info, name , priceold , levelold) VALUES (@sellerIdentifier, @vehProps, @vehPrice, @vehInfo, @vehName, @vehPriceold, @vehLevelold)",
                    {
						["@sellerIdentifier"] = xPlayer["identifier"],
                        ["@vehProps"] = json.encode(vehicleProps),
                        ["@vehPrice"] = price,
						["@vehInfo"] = info,
						["@vehName"] = resultTwo[1].name,
						["@vehPriceold"] = resultTwo[1].priceold,
						["@vehLevelold"] = resultTwo[1].levelold
                    }
                )

				MySQL.Async.execute('DELETE FROM owned_vehicles WHERE plate = @plate', { ["@plate"] = plate})
				
                TriggerClientEvent("esx-qalle-sellvehicles:refreshVehicles", -1)	

				isFound = true
				sendToDiscord((' المعارض المستعملة '), GetPlayerName(source) .. " Put The Vehicle  ".. plate .. " For Sale For ".. price.."$",56108)					
				break

			end		

		end

		cb(isFound)

	end)
end)

ESX.RegisterServerCallback("esx-qalle-sellvehicles:buyVehicle", function(source, cb, vehProps, price)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src) 
	local price = price
	local plate = vehProps["plate"]
	local money = xPlayer.getAccount()

	MySQL.Async.fetchAll('SELECT * FROM vehicles_for_sale WHERE vehicleProps LIKE "%' .. plate .. '%"', {}, function(result)
		if result[1] ~= nil then
			if price == result[1].price or result[1].seller == xPlayer.identifier then
				if xPlayer.getAccount("bank")["money"] >= price or price == 0 then
					xPlayer.removeAccountMoney("bank", price)

					MySQL.Async.execute("INSERT INTO owned_vehicles (plate, owner, vehicle,name, priceold, levelold) VALUES (@plate, @identifier, @vehProps, @vehName, @vehPriceold, @vehLevelold)",
					{
						["@plate"] = plate,
						["@identifier"] = xPlayer.identifier,
						["@vehProps"] = result[1].vehicleProps,
						["@vehName"] = result[1].name,
						["@vehPriceold"] = result[1].priceold,
						["@vehLevelold"] = result[1].levelold				
					})

					TriggerClientEvent("esx-qalle-sellvehicles:refreshVehicles", -1)
					UpdateCash(result[1].seller, price)
					MySQL.Async.execute('DELETE FROM vehicles_for_sale WHERE vehicleProps LIKE "%' .. plate .. '%"', {})

					cb(true)
					sendToDiscord((' المعارض المستعملة '), GetPlayerName(source) .. " Bought The Vehicle ".. plate .. " For ".. price.."$",56108)	
				else
					cb(false, money)
				end
			else
				DropPlayer(src, "Cheat engine detected") -- Add your anti cheat detection here.
			end
		else
			print("Car not found in sql, possible cheat from : " .. GetPlayerName(src))
		end
	end)
end)

function RetrievePlayerVehicles(newIdentifier, cb)
	local identifier = newIdentifier

	local yourVehicles = {}

	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @identifier AND Type = @Type", {['@identifier'] = identifier, ['@Type'] = 'car'}, function(result) 

		for id, values in pairs(result) do

			local vehicle = json.decode(values.vehicle)
			local plate = values.plate

			table.insert(yourVehicles, { vehicle = vehicle, plate = plate })
		end

		cb(yourVehicles)

	end)
end

function UpdateCash(identifier, cash)
	local xPlayer = ESX.GetPlayerFromIdentifier(identifier)

	if xPlayer ~= nil then
		xPlayer.addAccountMoney("bank", cash)

		TriggerClientEvent("esx:showNotification", xPlayer.source, "$ " .. cash .." ﻞﺑﺎﻘﻣ ﻚﺘﺒﻛﺮﻣ ﺀﺍﺮﺷ ﻢﺗ")
	else
		MySQL.Async.fetchAll('SELECT bank FROM users WHERE identifier = @identifier', { ["@identifier"] = identifier }, function(result)
			if result[1]["bank"] ~= nil then
				MySQL.Async.execute("UPDATE users SET bank = @newBank WHERE identifier = @identifier",
					{
						["@identifier"] = identifier,
						["@newBank"] = result[1]["bank"] + cash
					}
				)
			end
		end)
	end
end

Trim = function(word)
	if word ~= nil then
		return word:match("^%s*(.-)%s*$")
	else
		return nil
	end
end