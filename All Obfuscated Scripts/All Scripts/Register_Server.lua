--[[
	id: xlJSOjl9XbTLmAPMOfIlD
	name: Register_Server
	description: Register_Server
	time1: 2021-07-18 21:06:25.489653+00
	time2: 2021-07-18 21:06:25.489654+00
	uploader: jwSAFiyGDZZngdEUyC9KXjXc3kZsqwbIcIgS4G-8
	uploadersession: nL5L49evOF_jJlNEUrxixZuZeT-pDw
	flag: f
--]]

ESX = nil
TriggerEvent('esx:getShilovepizzaaredObjilovepizzaect', function(obj) ESX = obj end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(3000)

    --TriggerClientEvent('nui:on', -1)
	end 

  RegisterServerEvent('register:set')
  AddEventHandler('register:set', function(data)
    local identifiersource = GetPlayerIdentifiers(source)[2]
    local identifier = identifiersource:gsub("license:", "")

    local xPlayer = ESX.GetPlayerFromId(source)

    local sex = 'm'
    if data.sex == 'M' then
      sex = 'm'
    end
    if data.sex == 'F' then
      sex = 'f'
    end

    MySQL.Async.execute('UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `height` = @height WHERE identifier = @identifier', {
      ['@identifier']		= identifier,
      ['@firstname']		= data.firstname,
      ['@lastname']		= data.lastname,
      ['@dateofbirth']	= data.dateofbirth,
      ['@sex']			= sex,
      ['@height']			= data.height
    }, function(rowsChanged)
      if rowsChanged > 0 then
        TriggerClientEvent('nui:off', xPlayer.source)
      else

      end
    end)
  end)

  ESX.RegisterServerCallback('register:check', function(source, callback)
    local identifiersource = GetPlayerIdentifiers(source)[2]
    local identifier = identifiersource:gsub("license:", "")

    MySQL.Async.fetchAll('SELECT identifier, firstname, lastname, dateofbirth, sex, height FROM `users` WHERE `identifier` = @identifier', {
      ['@identifier'] = identifier
    }, function(result)
      if result[1] ~= nil then

        if result[1].firstname == nil then
          callback(false)
        else
          callback(true)
        end

      else  
        callback(false)
      end
    end)
    
  end)

end)