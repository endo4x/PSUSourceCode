--[[
	id: JpkdGZwmqKSkPo2AVjwMy
	name: TEST
	description: TEST
	time1: 2021-05-16 21:32:28.338017+00
	time2: 2021-05-16 21:32:28.338017+00
	uploader: yFuO9AUbJGW07Jo7Is2wUObT1KJgzp0XpjOnvFOg
	uploadersession: SaNbJNrRe4q-Y2jTBUF_DTOmfKKGaG
	flag: f
--]]

ESX = nil
TriggerEvent('esx:getSharedObjectac', function(obj) ESX = obj end)

RegisterCommand('anuncio', function(source, args, rawCommand)
        local msg = table.concat(args, " ")
        if source == 0 then
        TriggerClientEvent('notificaciones:aviso', -1, msg) 
    else
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.getGroup() == "superadmin" then
            TriggerClientEvent('notificaciones:aviso', -1, msg) 
        else
            xPlayer.showNotification("No tienes permisos para enviar anuncions.","error")
        end
    end

end)