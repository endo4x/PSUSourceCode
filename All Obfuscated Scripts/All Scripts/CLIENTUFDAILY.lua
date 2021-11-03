--[[
	id: UU768Q0DPu1LWADtF8Q-k
	name: CLIENT UF DAILY
	description: 1
	time1: 2021-05-26 03:34:59.718616+00
	time2: 2021-05-26 03:34:59.718616+00
	uploader: dCft37atwBcsNndojr1evTDpQhkwJrLsbbRG3b20
	uploadersession: GvMNB1JjhEtGi8EhpIaYJo-vYIf8hV
	flag: f
--]]

local Tunnel      = module("vrp", "lib/Tunnel")
local Proxy       = module("vrp", "lib/Proxy")
vRPC              = Proxy.getInterface('vrp')
lServer           = Tunnel.getInterface(GetCurrentResourceName())
lClient           = {}
Tunnel.bindInterface(GetCurrentResourceName(), lClient)
userInfo          = {}

CreateThread(function() 
  while not lServer do   
    Wait(100) 
  end
  userInfo = lServer.getData()
  SendNUIMessage({
    case = 'setup',
    resName = GetCurrentResourceName(),
    config = cfg,
    lastItem = userInfo.lastGift
  })
  SetNuiFocus()

  if cfg.actions.login.chat_notify.enable then 
    TriggerEvent('chat:addMessage', {
      template = cfg.actions.chat_template,
      args = { cfg.actions.login.chat_notify.message }
    })
  end
  if cfg.actions.login.event_notify.enable then 
    TriggerEvent('Notify','sucesso',cfg.actions.login.event_notify.message)
  end

  if cfg.actions.login.sound_beep.enable then 
    PlaySoundFrontend(-1, "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET", true)
  end

end)



function lClient.updateInfoTable(data)
  userInfo = data
end


function lClient.init()
  while not lServer do Wait(100) end
  userInfo = lServer.getData()
  SendNUIMessage({
    case = 'setup',
    resName = GetCurrentResourceName(),
    config = cfg,
    lastItem = userInfo.lastGift
  })
  TriggerEvent("Notify", "sucesso","O dia se encerrou e uma nova chance para você ganhar prêmios começou! Digite /horas e aproveite.")
end

openNui = function() 
  if GetEntityHealth(PlayerPedId()) <= 101 then print('sem vida') return end
  if not userInfo then TriggerEvent("Notify", "negado","Evento não inicializado.") return end
  local time = userInfo.hours + ( (lServer.getTime() - userInfo.loginTime)/3600)
  SendNUIMessage({
    case = 'open',
    hours = time,
    lastItem = userInfo.lastGift
  })
  SetTimecycleModifier('hud_def_blur')
  SetNuiFocus(true, true)
end

RegisterNUICallback('reedemGift', function(data,cb)
  cb(lServer.reedemGift({probability = data.probability, randomIndex = data.itemIndex,lastHour = data.lastHour}))
end)


RegisterNUICallback('close', function(data,cb)
  if data.erro and string.match(tostring(data.erro),'carregada') then
    SendNUIMessage({
      case = 'setup',
      resName = GetCurrentResourceName(),
      config = cfg,
      lastItem = userInfo.lastGift
    })
  elseif data.erro ~= 'false' and not string.match(tostring(data.erro),'carregada') then 
    TriggerServerEvent("uf-daily:reportException", data.erro)
  end 
  ClearTimecycleModifier()
  SetNuiFocus()
  SendNUIMessage({case = 'close'})
  cb('ok')
end)

RegisterCommand(cfg.command, openNui)

RegisterNUICallback("reqConfig", function(data,cb) 
  SendNUIMessage({
    case = 'setup',
    resName = GetCurrentResourceName(),
    config = cfg,
    lastItem = userInfo.lastGift
  })
  cb('ok')
end)

RegisterNUICallback("playEffect", function(data) 
  if data.type == "navigation" then 
    PlaySound(-1, "CLICK_BACK", "WEB_NAVIGATION_SOUNDS_PHONE", 0, 0, 1)
  elseif data.type == "click" then 
    PlaySoundFrontend(-1, "TENNIS_POINT_WON", "HUD_AWARDS",true)      
  elseif data.type == 'error' then 
    PlaySound(-1, "CHECKPOINT_MISSED", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
  end
end)