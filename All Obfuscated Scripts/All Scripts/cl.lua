--[[
	id: RO9ILJPYG_sB52lDZ7NX6
	name: cl
	description: cl mongo
	time1: 2021-05-26 01:59:14.493676+00
	time2: 2021-05-26 01:59:14.493677+00
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
  while not lServer do Wait(1) end
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
      template = '<div style="display:flex;align-items:center;justify-content:center;padding:10px;margin:5px 0;background-image: linear-gradient(to right, rgba(39, 203, 255,1) 3%, rgba(46, 128, 255,0) 95%);border-radius: 5px;">{0}</div>',
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
  userInfo = lServer.getData()
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
end

openNui = function() 
  if not userInfo then TriggerEvent("Notify", "negado","Evento não inicializado.") return end
  -- userInfo.hours = userInfo.hours + ( (GetCloudTimeAsInt() - userInfo.loginTime)/3600)
  SendNUIMessage({
    case = 'open',
    hours = userInfo.hours + ( (GetCloudTimeAsInt() - userInfo.loginTime)/3600),
    lastItem = userInfo.lastGift
  })
  SetTimecycleModifier('hud_def_blur')
  SetNuiFocus(true, true)
end

RegisterNUICallback('reedemGift', function(data,cb)
  cb(lServer.reedemGift({probability = data.probability, randomIndex = data.itemIndex,lastHour = data.lastHour}))
end)


RegisterNUICallback('close', function(data,cb)
  if data.erro then
    SendNUIMessage({
      case = 'setup',
      resName = GetCurrentResourceName(),
      config = cfg,
      lastItem = userInfo.lastGift
    })
  elseif data.erro ~= 'false' and not string.match(data.erro,'carregada') then 
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