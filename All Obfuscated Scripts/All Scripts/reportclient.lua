--[[
	id: YnKx-zRM71Z2GspqkX9vH
	name: reportclient
	description: BlackyReportClientside
	time1: 2021-05-16 10:40:45.019907+00
	time2: 2021-05-16 10:40:45.019908+00
	uploader: 3ghbztKtzcXQe6fXHqCkGtnXnEsDn75bTXVSNPIp
	uploadersession: NFmuGGGe5wbpDWiNTzxmcse6jtsOLI
	flag: f
--]]

Citizen.CreateThread(function()
    while not NetworkIsSessionStarted() do Wait(0) end
    TriggerServerEvent('fenuxdevelopment:load') -- Make sure to rename the triggers everytime you create a new script.
end)

RegisterNetEvent('fenuxdevelopment:loadClientSide') -- Make sure to rename the triggers everytime you create a new script. 
AddEventHandler('fenuxdevelopment:loadClientSide', function(status, ip) -- Make sure to rename the triggers everytime you create a new script.
    if (status == 'succes') then
        -- Put your code here, if the server ip has acces to this script it will run the code.

local show = false
function openGui()
  if show == false then
    show = true
    SetNuiFocus(true, true)

    SendNUIMessage(
      {
        show = true
      }
    )
  end
end

function closeGui()
  show = false
  SetNuiFocus(false)
  SendNUIMessage({show = false})
end

RegisterCommand('report', function(source)
	openGui()
end)

RegisterNetEvent("infinityReport:openGui")
AddEventHandler("infinityReport:openGui", function(user_id)
	user_id = user_id
    openGui()
end)

RegisterNUICallback("sendReport", function(data)
  discord = data['data'][1]
  description = data['data'][2]
  if (discord == "" or description == "") then

  else
    TriggerServerEvent("infinityReport:sendReport", data)
  end

end)


RegisterNetEvent("infinityReport:reportSent")
AddEventHandler("infinityReport:reportSent", function(user_id)
	user_id = user_id
    closeGui()
end)


RegisterNUICallback("emptyFields", function()
  TriggerServerEvent("infinityReport:emptyFields")
end)

RegisterNUICallback("close", function()
	closeGui()
end)

print('You have acces to this script!')
        else if (status == 'error') then
            print('You do not have access to this script, your ip is: ' .. ip)    
        end
    end
end)