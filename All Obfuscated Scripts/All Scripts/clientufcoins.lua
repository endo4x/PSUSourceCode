--[[
	id: l568vA5avItBbVs0p9xrm
	name: client - uf coins
	description: !
	time1: 2021-06-25 06:36:42.825863+00
	time2: 2021-06-25 06:36:42.825864+00
	uploader: dCft37atwBcsNndojr1evTDpQhkwJrLsbbRG3b20
	uploadersession: GvMNB1JjhEtGi8EhpIaYJo-vYIf8hV
	flag: f
--]]

local Tunnel        = module("vrp","lib/Tunnel")
local Proxy         = module("vrp","lib/Proxy")
local resName       = GetCurrentResourceName()
vRP                 = Proxy.getInterface("vRP")
lServer             = Tunnel.getInterface(resName)
local lClient       = {}
local uiStatus      = false 
Tunnel.bindInterface(resName,lClient)

local user_id,appointaments,selectedDict

local function requireData()
  selectedDict = ((GetEntityModel(PlayerPedId()) == 1885233650) and 'ANIM_CASINO_A@AMB@CASINO@GAMES@LUCKY7WHEEL@MALE' or 'ANIM_CASINO_A@AMB@CASINO@GAMES@LUCKY7WHEEL@FEMALE')
  if user_id then return false end;
  local data = lServer.getEval()
  if data.user_id then 
    user_id = data.user_id 
  else 
    SetTimeout(5000, requireData)
  end
  local appointaments = data.appointaments
  if appointaments then
    for k,v in ipairs(appointaments) do 
      if v.temporary.onRemove then 
        v.temporary.onRemove(nil,user_id)
      end
    end
  end
end

CreateThread(function() 
  while not lServer do 
    Wait(1000) 
  end 
  requireData()
  return;
end)


RegisterCommand(cfg.commands.openUi, function() 
  if not user_id then 
    TriggerEvent("Notify", "negado","Você não foi autenticado ainda.")
    return false 
  end
  if uiStatus then return false end 
  uiStatus = true 
  SetTimecycleModifier("hud_def_blur")
  local coin = lServer.openUi(user_id)
  SetNuiFocus(true,true)
  SetTimecycleModifierStrength(1.0)
  SendNUIMessage({
    event = 'open',
    coins = coin.coins
  })
end)

RegisterNUICallback("loadConfig", function(data,cb) 
  local info = cfg
  for k,v in pairs(info.roulette.items) do 
    info.roulette.items[k].position = k
    for i,u in pairs(v) do 
      if i == 'temporary' or type(u) == 'function' then   
        info.roulette.items[k][i] = nil 
      end
     end
   end
  for k,v in pairs(info.products) do 
    for i = 1,#info.products[k]  do 
        info.products[k][i].position = i
        for j,u in pairs(info.products[k][i]) do 
            if type(u) == "function" or j == 'temporary' then 
              info.products[k][i][j] = nil
            end
        end
    end
  end
  SendNUIMessage({
    event   = 'setup',
    config  =  json.encode(info)
  })
end)
RegisterNUICallback("close", function(data,cb) 
  if not data then 
    print(data)
  end
  ClearPedTasks(PlayerPedId())
  ClearTimecycleModifier()
  uiStatus = false 
  SetNuiFocus(false, false)
  cb('ok')
end)

RegisterNUICallback("playSound", function(data,cb) 
  
  if data.action == "buy" then 
    PlaySound(-1, "Event_Message_Purple","GTAO_FM_Events_Soundset", 0, 0, 1)
  elseif data.action == "error" then 
    if data.error then 
      TriggerEvent("Notify","negado",data.error)
    end
    PlaySound(-1, "Place_Prop_Fail", "DLC_Dmod_Prop_Editor_Sounds", 0, 0, 1)
  elseif data.action == "click" then 
    -- PlaySoundFrontend(-1, "TENNIS_POINT_WON", "HUD_AWARDS",true)      
    -- PlaySound(-1, "Event_Message_Purple","GTAO_FM_Events_Soundset", 0, 0, 1)
  elseif data.action == "select" then 
    PlaySound(-1, "CLICK_BACK", "WEB_NAVIGATION_SOUNDS_PHONE", 0, 0, 1)
  end
end)
RegisterNUICallback("rewardReedem", function(data,cb) 
  if(data.index) then 
    vRP._playAnim(false,{{selectedDict,"Win_Big"}},false)
    cb(lServer.giveRouletteReward({index = data.index}))
  end
end)

RegisterNUICallback("buyProduct", function(data,cb) 
  local retorno       = (lServer.buyProduct(data))
  local category      = data.category
  local productTable  = cfg.products[category][data.index]
  if retorno.success and productTable.onBuy then productTable.onBuy() end
  cb(retorno)
end)


RegisterNUICallback("tryOpenBox", function(data,cb) 
  vRP._playAnim(false,{{selectedDict,"SpinningIDLE_High"}},true)
  if(data.multiplier) then 
    local retorno = lServer.tryOpenBox(cfg.roulette.price * data.multiplier)
    if retorno.success then 
      vRP._playAnim(false,{{selectedDict,"SpinningIDLE_High"}},true)
    end
    cb(retorno)
  end
end)

function lClient.updateCoin(coins)
  SendNUIMessage({event = 'updateCoin', coins = coins})
end

RegisterNetEvent(resName..':notifyAll',function(data) 
  SendNUIMessage({
    event = 'notify',
    info = data,
    opened = uiStatus
  })
end)