--[[
	id: eye7Yz_2K1tLGogFlwv9w
	name: psu
	description: psu
	time1: 2021-05-06 00:43:33.008307+00
	time2: 2021-05-06 00:43:33.008308+00
	uploader: kUkTOL37Z_pljmMWprHM33zRuAnu1SjVlzRLXH-Q
	uploadersession: 2thCVY6KxT39gAp3dbufDY88XejIKb
	flag: f
--]]

-----------------------------------------------------------------------------------------------------------------------------------------
-- HOTKEY
-----------------------------------------------------------------------------------------------------------------------------------------	
if Config.keyToOpenMenu.enabled then
	Citizen.CreateThread(function()
		while true do
			Wait(5)
			if IsControlJustPressed(0, Config.keyToOpenMenu.key) then
				openUI()
			end
		end
	end)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------	
if Config.commandToOpenMenu.enabled then
	RegisterCommand(Config.commandToOpenMenu.command, function()
		openUI()
	end)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIP
-----------------------------------------------------------------------------------------------------------------------------------------	
if Config.locationToOpenMenu.enabled then
	Citizen.CreateThread(function()
		local timer = 3000
		while true do
			timer = 3000
			for k,mark in pairs(Config.locationToOpenMenu.locations) do
				local x,y,z = table.unpack(mark)
				local distance = #(GetEntityCoords(PlayerPedId()) - vector3(x,y,z))
				if distance <= 20.0 then
					timer = 5
					DrawMarker(21,x,y,z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
					if distance <= 2.0 then
						DrawText3D2(x,y,z-0.6, Lang[Config.lang]['open'], 0.40)
						if IsControlJustPressed(0,38) then
							openUI()
						end
					end
				end
			end
			Wait(timer)
		end
	end)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D2(x, y, z, text, scale)
	if text then
		local onScreen, _x, _y = World3dToScreen2d(x, y, z)
		local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
		SetTextScale(scale, scale) SetTextFont(4)
		SetTextProportional(1)
		SetTextEntry("STRING")
		SetTextCentre(true)
		SetTextColour(255, 255, 255, 215) AddTextComponentString(text)
		DrawText(_x, _y)
		local factor = (string.len(text)) / 700
		DrawRect(_x, _y + 0.0150, 0.095 + factor, 0.03, 41, 11, 41, 100)
	end
end

RegisterNetEvent("ecommerce:Notify")
AddEventHandler("ecommerce:Notify", function(type,msg)
	-- Você pode mudar a notificação como desejar
	prefix = ""
	if type == "negado" then
		prefix = "~r~"
    elseif type == "importante" then
		prefix = "~y~"
    elseif type == "sucesso" then
        prefix = "~g~"
    end
	SetNotificationTextEntry("STRING")
	AddTextComponentString(prefix..msg)
	DrawNotification(false, false)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMATION
-----------------------------------------------------------------------------------------------------------------------------------------
local myPedId = nil
local phoneProp = nil
local phoneModel = "prop_v_m_phone_o1s"
local currentStatus = "out"
local lastDict = nil
local lastAnim = nil
local lastIsFreeze = false

local ANIMS = {
	['cellphone@'] = {
		['out'] = {
			['text'] = 'cellphone_text_in',
			['call'] = 'cellphone_call_listen_base',
		},
		['text'] = {
			['out'] = 'cellphone_text_out',
			['text'] = 'cellphone_text_in',
			['call'] = 'cellphone_text_to_call',
		},
		['call'] = {
			['out'] = 'cellphone_call_out',
			['text'] = 'cellphone_call_to_text',
			['call'] = 'cellphone_text_to_call',
		}
	},
	['anim@cellphone@in_car@ps'] = {
		['out'] = {
			['text'] = 'cellphone_text_in',
			['call'] = 'cellphone_call_in',
		},
		['text'] = {
			['out'] = 'cellphone_text_out',
			['text'] = 'cellphone_text_in',
			['call'] = 'cellphone_text_to_call',
		},
		['call'] = {
			['out'] = 'cellphone_horizontal_exit',
			['text'] = 'cellphone_call_to_text',
			['call'] = 'cellphone_text_to_call',
		}
	}
}

function newPhoneProp()
	deletePhone()
	RequestModel(phoneModel)
	while not HasModelLoaded(phoneModel) do
		Citizen.Wait(10)
	end
	phoneProp = CreateObject(GetHashKey(phoneModel),1.0,1.0,1.0,1,1,0)
	SetEntityCollision(phoneProp,false,false)
	AttachEntityToEntity(phoneProp,myPedId,GetPedBoneIndex(myPedId,28422),0.0,0.0,0.0,0.0,0.0,0.0,1,1,0,0,2,1)
	Citizen.InvokeNative(0xAD738C3085FE7E11,phoneProp,true,true)
end

function deletePhone()
	TriggerEvent("binoculos")
	if DoesEntityExist(phoneProp) then
		DetachEntity(phoneProp,true,true)
		Citizen.InvokeNative(0xAD738C3085FE7E11,phoneProp,true,true)
		SetEntityAsNoLongerNeeded(Citizen.PointerValueIntInitialized(phoneProp))
		DeleteEntity(phoneProp)
		phoneProp = nil
	end
end

function PhonePlayAnim(status,freeze,force)
	if status ~= 'out' and currentStatus == 'out' then
		TriggerEvent("DeletarObjeto")
	end

	if currentStatus == status and force ~= true then
		return
	end

	myPedId = PlayerPedId()
	local freeze = freeze or false

	local dict = "cellphone@"
	if IsPedInAnyVehicle(myPedId,false) then
		dict = "anim@cellphone@in_car@ps"
	end
	loadAnimDict(dict)

	local anim = ANIMS[dict][currentStatus][status]
	if currentStatus ~= 'out' then
		StopAnimTask(myPedId,lastDict,lastAnim,1.0)
	end

	local flag = 50
	if freeze == true then
		flag = 14
	end
	TaskPlayAnim(myPedId,dict,anim,3.0,-1,-1,flag,0,false,false,false)

	if status ~= 'out' and currentStatus == 'out' then
		Citizen.Wait(380)
		newPhoneProp()
		TriggerEvent("status:celular",true)
		SetCurrentPedWeapon(myPedId,GetHashKey("WEAPON_UNARMED"),true)
	end

	lastDict = dict
	lastAnim = anim
	lastIsFreeze = freeze
	currentStatus = status

	if status == 'out' then
		Citizen.Wait(180)
		deletePhone()
		StopAnimTask(myPedId,lastDict,lastAnim,1.0)
		TriggerEvent("status:celular",false)
	end
end

function PhonePlayOut()
	PhonePlayAnim('out')
end

function PhonePlayText()
	PhonePlayAnim('text')
end

function PhonePlayCall(freeze)
	PhonePlayAnim('call',freeze)
end

function PhonePlayIn()
	if currentStatus == 'out' then
		PhonePlayText()
	end
end

function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(10)
	end
end
