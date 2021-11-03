--[[
	id: 4YBZf_53zC3LKShW-dJ1E
	name: Rakan_SpawnClient
	description: Client
	time1: 2021-05-27 18:43:28.527+00
	time2: 2021-05-27 18:43:28.527001+00
	uploader: 338
	uploadersession: M6JI_ewz98DfnVAErszqbtsD8vvcSc
	flag: f
--]]

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
		DrawMarker(30, -76.950881958008,6265.9248046875,31.366830825806, 0, 0, 0, 0, 0, 0, 1.0001,1.0001,1.0001, 0, 232, 255, 155, 0, 0, 0, 0, 0, 0, 0)
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -76.950881958008,6265.9248046875,31.366830825806, true ) < 2 then
		 if (IsControlJustReleased(1, 51)) then
			TriggerEvent("swt_notifications:Success","By Rakan#3431",""..Config.Settings.MarkText.."","right","3000",true)
			SetNuiFocus( true, true )
			SendNUIMessage({
				showPlayerMenu = true
			})
		 end
		end
	end
end)

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(10)
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -77.61,6232.67,39.41, true ) < 50 or GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -142.49,6173.14,37.4, true ) < 50 then
	else 
		TriggerServerEvent('RakanCheckPlayerStatus')
	end
end 
end)


-- TriggerServerEvent('RakanRevivePlayerNoti')

Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(10)
	  if (GetEntityHealth(GetPlayerPed(-1)) < Config.Settings.DieBlood) then
		if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -77.61,6232.67,39.41, true ) < 50) or (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -142.49,6173.14,37.4, true ) < 50) then
		ShowInfo(""..Config.Settings.DieNoti.."", 0)
			if (IsControlJustPressed(1,38)) and (GetEntityHealth(GetPlayerPed(-1)) < Config.Settings.DieBlood) then
				if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -77.61,6232.67,39.41, true ) < 50) or (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -142.49,6173.14,37.4, true ) < 50) then
				SetEntityHealth(GetPlayerPed(-1), 200)
				end
			end
			end
		end
	  end    
end)


RegisterCommand('oam', function(source, args, rawCommand)
		SetNuiFocus( true, true )
		SendNUIMessage({
			OpenAdminMenu2 = true
			})
end)

RegisterNUICallback('closeButton', function(data, cb)
	killTutorialMenu()
  	cb('ok')
end)

RegisterNUICallback('closeButtonAdmin', function(data, cb)
	KillAdminMenu()
  	cb('ok')
end)

RegisterNUICallback('RakanLogin', function(data, cb)
	TriggerServerEvent("RakanLogin")
  	cb('ok')
end)

RegisterNUICallback('RakanLoginFailed', function(data, cb)
	TriggerServerEvent("RakanLoginFailed")
  	cb('ok')
end)

RegisterNUICallback('RakanLogout', function(data, cb)
	TriggerServerEvent("RakanLogout")
  	cb('ok')
end)

RegisterNUICallback('RakanLogoutFailed', function(data, cb)
	TriggerServerEvent("RakanLogoutFailed")
  	cb('ok')
end)

RegisterNUICallback('RakanSendMessageAP', function(data, cb)
	TriggerServerEvent("RakanSendMessageAP", data.messagetop)
	local _source = source
	local smessage = data.messagetop
	TriggerEvent("swt_notifications:Success", "By Rakan#3431",smessage,"right","3000",true)
  	cb('ok')
end)

-- Functions 

function ShowInfo(text, state)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, state, 0, -1)
  end

function killTutorialMenu()
	SetNuiFocus( false )
			SendNUIMessage({
				showPlayerMenu = false
			})
end

function KillAdminMenu()
	SetNuiFocus( false )
			SendNUIMessage({
				OpenAdminMenu2 = false
			})
end

function SplitStr(inputstr, sep)
	if sep == nil then
			sep = "%s"
	end
	local t={}
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
			table.insert(t, str)
	end
	return t
end

function DrawText2(text)
	RegisterFontFile('A9eelsh') -- the name of your .gfx, without .gfx
	fontId = RegisterFontId('A9eelsh') -- the name from the .xml
	SetTextFont(fontId)
	SetTextProportional(0)
	SetTextScale(0.0, 0.40)
	SetTextDropshadow(0, 0, 0, 0, 0)
	SetTextEdge(0, 0, 0, 0, 0)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(0.70, 0.105)
end

function Draw3DText(x, y, z, text, font)
	local onScreen , _x, _y = World3dToScreen2d(x, y, z)
	local p = GetGameplayCamCoords()
	local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
	local scale = (1 / distance) * 2
	local fov = (1 / GetGameplayCamFov()) * 100
	local scale = scale * fov
	RegisterFontFile('A9eelsh') -- the name of your .gfx, without .gfx
	fontId = RegisterFontId('A9eelsh') -- the name from the .xml
	if onScreen then
	    SetTextScale(0.0, 0.35)
	    SetTextFont(fontId)
	    SetTextProportional(1)
	    SetTextColour(255, 255, 255, 255)
	    SetTextDropshadow(0, 0, 0, 0, 255)
	    SetTextEdge(2, 0, 0, 0, 150)
	    SetTextDropShadow()
	    SetTextOutline()
	    SetTextEntry("STRING")
	    SetTextCentre(1)
	    AddTextComponentString(text)
	    DrawText(_x,_y)
	end
end