--[[
	id: pMjcjiWYe6PVP3BoksMTv
	name: cia
	description: asd
	time1: 2021-06-03 18:22:59.507339+00
	time2: 2021-06-03 18:22:59.507339+00
	uploader: 7Vk2U3wbWee9e1aaWoX05IZFUUrGlGg3pzjDlVdi
	uploadersession: ZixYShBkqwItvMdgTu7s_189BjcO16
	flag: f
--]]

QBCore = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if QBCore == nil then
            TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
            Citizen.Wait(200)
        end
    end
end)


local cooldown = false
local ishacked = false 
-- Code

local function onDone(success) 
    TriggerEvent('mhacking:hide')
    if success then 
        QBCore.Functions.Notify("لقد تصديت للهجمة")
        TriggerServerEvent("TheMission:cia:server:successhack")
    else
        ishacked = true 
        QBCore.Functions.Notify("لقد فشلت وتم تعقبك من قبل الشرطة  ") 
        TriggerServerEvent("TheMission:cia:server:failedhack")
    end
end

RegisterNetEvent("TheMission:cia:client:starthack")
AddEventHandler("TheMission:cia:client:starthack", function(playerId)

    if not hacked then 
        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasphone)
            if hasphone then 
                if cooldown then 
               TriggerServerEvent("wsh:server:notify", playerId, "لا يمكنك فعل هذا الاجراء حاول في وقت اخر")

                else 
					TriggerServerEvent('wsh:server:notify', playerId , "جاري اختراق جوال المجرم")
                    cooldown = true 
                    TriggerEvent("mhacking:show")
                    TriggerEvent("mhacking:start", math.random(5, 9), math.random(10, 15), onDone) --

                    Citizen.Wait(60000 * Config.Cooldown) 


					
                    cooldown = false 
                end
            else
                TriggerServerEvent('wsh:server:notify', playerId , "الشخص لا يتملك جوال")
                print(source)
            end
        end, "phone")
    end
end)


local DutyBlips = {}
RegisterNetEvent('TheMission:cia:client:UpdateBlips')
AddEventHandler('TheMission:cia:client:UpdateBlips', function(idd)
    QBCore.Functions.Notify("تم تحديد الموقع")
    local id = GetPlayerFromServerId(idd)
    if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
        CreateDutyBlips(id, "The Tracker", nil, idd) --
    end
end)

RegisterNetEvent('TheMission:cia:client:NOTUpdateBlips')
AddEventHandler('TheMission:cia:client:NOTUpdateBlips', function(idd)
	QBCore.Functions.Notify("لقد نجح المجرم في تصدي الهجمة")
end)


function CreateDutyBlips(playerId, playerLabel, playerJob, idd)
	local ped = GetPlayerPed(playerId)
	local blip = GetBlipFromEntity(ped)
	if not DoesBlipExist(blip) then
		blip = AddBlipForEntity(ped)
		SetBlipSprite(blip, 1)
		ShowHeadingIndicatorOnBlip(blip, true)
		SetBlipRotation(blip, math.ceil(GetEntityHeading(ped)))
        SetBlipScale(blip, 1.0)
        SetBlipColour(blip, 1) --
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(playerLabel)
        EndTextCommandSetBlipName(blip)
		
		table.insert(DutyBlips, {blip = blip, id = idd})
	end
end

RegisterNetEvent('TheMission:cia:client:removeblip')
AddEventHandler('TheMission:cia:client:removeblip', function(idd)
    for k, v in pairs(DutyBlips) do 
        if idd == v.id then 
            RemoveBlip(v.blip)
            v = nil
            break  
        end
    end
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0.3 * (60000))
        if ishacked then 
			QBCore.Functions.TriggerCallback('TM-cia:server:hasphone', function(HasItems)  
			if HasItems then
            else
                ishacked = false 
                TriggerServerEvent("TheMission:cia:server:unhack")
            end
		end)
        end
    end
end)

local radioMenu = false

function enableRadio(enable)
  if enable then
    SetNuiFocus(enable, enable)
    PhonePlayIn()
    SendNUIMessage({
      type = "open",
    })
    radioMenu = enable
  end
end

RegisterNetEvent('TM-CIA:use')
AddEventHandler('TM-CIA:use', function()
  enableRadio(true)
end)

RegisterNUICallback('escape', function(data, cb)
    SetNuiFocus(false, false)
    radioMenu = false
    PhonePlayOut()
    cb('ok')
  end)

  RegisterNUICallback('joinRadio', function(data, cb)
    local _source = source
    TriggerServerEvent("TheMission:cia:server:track", data.channel)
  end)

  ---------------- animation

  local myPedId = nil

local phoneProp = 0
local phoneModel = `prop_phone_proto`


local currentStatus = 'out'
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
		Citizen.Wait(1)
	end
	phoneProp = Citizen.InvokeNative(0x509D5878EB39E842,phoneModel, 1.0, 1.0, 1.0, 1, 1, 0)

	local bone = GetPedBoneIndex(myPedId, 28422)
	AttachEntityToEntity(phoneProp, myPedId, bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
end

function deletePhone()
	if phoneProp ~= 0 then
		Citizen.InvokeNative(0xAE3CBE5BF394C9C9 , Citizen.PointerValueIntInitialized(phoneProp))
		phoneProp = 0
	end
end


function PhonePlayAnim(status, freeze, force)
	if currentStatus == status and force ~= true then
		return
	end

	myPedId = PlayerPedId()
	local freeze = freeze or false

	local dict = "cellphone@"
	if IsPedInAnyVehicle(myPedId, false) then
		dict = "anim@cellphone@in_car@ps"
	end
	loadAnimDict(dict)

	local anim = ANIMS[dict][currentStatus][status]
	if currentStatus ~= 'out' then
		StopAnimTask(myPedId, lastDict, lastAnim, 1.0)
	end
	local flag = 50
	if freeze == true then
		flag = 14
	end
	TaskPlayAnim(myPedId, dict, anim, 3.0, -1, -1, flag, 0, false, false, false)

	if status ~= 'out' and currentStatus == 'out' then
		Citizen.Wait(380)
		newPhoneProp()
	end

	lastDict = dict
	lastAnim = anim
	lastIsFreeze = freeze
	currentStatus = status

	if status == 'out' then
		Citizen.Wait(180)
		deletePhone()
		StopAnimTask(myPedId, lastDict, lastAnim, 1.0)
	end

end

function PhonePlayOut()
	PhonePlayAnim('out')
end

function PhonePlayText()
	PhonePlayAnim('text')
end

function PhonePlayCall (freeze)
	Citizen.CreateThread(function()
		while IsInCall() and Call ~= nil and not Call.Hold do
			if not IsEntityPlayingAnim(PlayerPedId(), 'cellphone@', 'cellphone_text_to_call', 3) then
				PhonePlayAnim('call', freeze, true)
			end
			Citizen.Wait(1000)
		end
	end)
end

function PhoneCallToText()
	PhonePlayAnim('text', false, true)
end

function PhonePlayIn() 
	if currentStatus == 'out' then
		PhonePlayText()
	end
end

function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(1)
	end
end