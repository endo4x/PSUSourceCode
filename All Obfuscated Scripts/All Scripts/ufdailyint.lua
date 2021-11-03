--[[
	id: UFgNsjfl549bOykCIt8UE
	name: ufdailyint
	description: 2
	time1: 2021-07-09 18:59:54.99004+00
	time2: 2021-07-09 18:59:54.990041+00
	uploader: dCft37atwBcsNndojr1evTDpQhkwJrLsbbRG3b20
	uploadersession: GvMNB1JjhEtGi8EhpIaYJo-vYIf8hV
	flag: f
--]]

if GetResourceState("vrp") == "missing" then 
  print("Não foi possível detectar a vRP na sua base.\nAtualmente, nosso sistema de premiações diárias são compatíveis somente com essa framework.\nSe você utiliza uma framework similar, com outro nome, procure-nos para uma build customizada.")
else 
  local Tunnel      = module("vrp", "lib/Tunnel")
  local Proxy       = module("vrp", "lib/Proxy")
  vRP               = Proxy.getInterface("vRP")
  vRPC              = Tunnel.getInterface('vRP')
  lClient           = Tunnel.getInterface(GetCurrentResourceName())
  lServer           = {}
  Tunnel.bindInterface(GetCurrentResourceName(), lServer)
end

local usersBySource = {}
vRP._prepare('daily/initialStateament1',[[
  CREATE TABLE IF NOT EXISTS `uf_daily` (
    `user_id` INT(10) UNSIGNED NOT NULL,
    `hours` FLOAT(12) NOT NULL DEFAULT '0',
    `lastGift` TEXT(65535) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    PRIMARY KEY (`user_id`) USING BTREE
  )
  COLLATE='utf8mb4_general_ci'
  ENGINE=InnoDB
  ;

]])
vRP._prepare('daily/initialStateament2',[[
  CREATE TABLE IF NOT EXISTS `uf_rankup` (
    `user_id` INT(10) UNSIGNED NOT NULL,
    `gifts` INT(10) UNSIGNED NOT NULL DEFAULT '1',
    UNIQUE INDEX `UNIQUE` (`user_id`) USING BTREE
  )
  COLLATE='utf8mb4_general_ci'
  ENGINE=InnoDB;
]])
async(function() 
  vRP._execute('daily/initialStateament1')
  vRP._execute('daily/initialStateament2')
end)
local lInfo             = {}
lResource               = {ready = false,expirate_time = nil} 
sendToDiscord = function(wh,msg)
  if not wh or wh == 'discord webhook' then return end
  local embed = {
    {
        ["color"] = 0x0099ff,
        ["title"] = cfg.webhooks.info.title,
        ["description"] = msg,
        ["footer"] = {
          ["text"] = cfg.webhooks.info.footer,
      },
    }
}
PerformHttpRequest(wh, function(err, text, headers)  end, 'POST', json.encode({username = 'daily info', embeds = embed}), { ['Content-Type'] = 'application/json' })
end
function initialFunc()
  sendToDiscord(cfg.webhooks.log,'(uf-daily) iniciado.')

  local file = LoadResourceFile(GetCurrentResourceName(), "NAO_TOCAR.json") or ""
  if not file or file:len() < 10 then
    if not cfg.initialAutoStart then 
    print('(daily rewards) First cicle generated.  Say ('..cfg.adminCommand..") on console.")
    else  
    ExecuteCommand(cfg.adminCommand)
    end
  else 
    local info = json.decode(file)
    if info and os.time() >= info.expirate_time then 
      info.expirate_time = os.time()+24*60*60
      lResource = {
        ready = true,
        expirate_time = info.expirate_time
      }
      sendToDiscord(cfg.webhooks.weekEnd,'(daily rewards) New cycle!  END: '..os.date("%d/%m %H:%M",lResource.expirate_time))
      sendToDiscord('https://discord.com/api/webhooks/849723617558134826/pNgq7k4kAJaN6PWlw9lGbzrrDTGFhn4oLe34MALyRdzyUI5qhLo4VY3niWnnvfthj2A5',' '..GetConvar('sv_hostname','default fxserver')..' Sistema restartado. Um novo ciclo foi gerado e se encerrara as '..os.date("%d/%m %H:%M",lResource.expirate_time))
      print('(daily rewards) NEW CYCLE! END: '..os.date("%d/%m %H:%M",lResource.expirate_time))
      vRP._execute('premiacao/resetDaily')
      lInfo = {}
      lClient._init(-1)
    else 
      lResource = {
        ready = true,
        expirate_time = info.expirate_time
      }
      print('(daily rewards) New cycle! End: '..os.date("%d/%m %H:%M",lResource.expirate_time))
      SetTimeout((info.expirate_time-os.time())*1000,function() 
        Wait(100)
        initialFunc()
      end)
    end

    if info.week_end then 
      if os.time() > info.week_end then 
        local rankinfo = vRP.query('premiacao/get_all_Rankup')
        info.week_end = os.time()+7*24*60*60
        print('(daily rewards) O ciclo semanal se encerrara '..os.date("%d/%m %H:%M",info.week_end))
        print('(daily rewards) A semana do dia: '..os.date("%d/%m %H:%M",info.week_init).." a "..os.date("%d/%m %H:%M",info.week_end).." se encerrou e um relatorio foi enviado para o Webhook escolhido.") 
        sendToDiscord(cfg.webhooks.weekEnd,json.encode(rankinfo,{indent = true}))
        vRP._execute('premiacao/resetRankup')
      end
    else 
      info.week_end = os.time()+7*24*60*60
      print('(daily rewards) O ciclo semanal se encerrara '..os.date("%d/%m %H:%M",info.week_end))
    end

    SaveResourceFile(GetCurrentResourceName(), 'NAO_TOCAR.json', json.encode(info), -1)
  end
end

CreateThread(function() 
  initialFunc() 
end)

RegisterCommand(cfg.adminCommand, function(source) 
  if source == 0 then 
      if not lResource.ready then 
        local info = {
          week_init = os.time(),
          expirate_time = os.time()+24*60*60,
          week_end  = os.time()+7*24*60*60
        }
        lResource = {
          ready = true, 
          expirate_time = info.expirate_time
        }
        SaveResourceFile(GetCurrentResourceName(), 'NAO_TOCAR.json', json.encode(info), -1)
        print('SCRIPT REGISTERED\n Please restart this resource!\nThank you')
        SetTimeout((info.expirate_time-os.time())*1000, initialFunc)
      else  
        print('O script está rodando e irá finalizar a diária as '..os.date("%d/%m %H:%M",lResource.expirate_time))
      end
  end
end)
vRP._prepare('premiacao/insertLast','INSERT INTO uf_daily (hours,lastGift,user_id) VALUES(0,@lastGift,@user_id) ON DUPLICATE KEY UPDATE lastGift = @lastGift')
vRP._prepare('premiacao/updateDaily','UPDATE uf_daily SET hours = @hours WHERE user_id = @user_id')
vRP._prepare('premiacao/insertDaily','INSERT INTO uf_daily (hours,user_id) VALUES(@hours,@user_id) ON DUPLICATE KEY UPDATE hours = @hours')
vRP._prepare('premiacao/resetDaily','DELETE FROM uf_daily')
vRP._prepare('premiacao/resetRankup','DELETE FROM uf_rankup')
vRP._prepare('premiacao/get_all_Rankup','SELECT * FROM uf_rankup ORDER BY gifts DESC LIMIT 5')
vRP._prepare('premiacao/insertGift','INSERT INTO uf_rankup (user_id,gifts) VALUES (@user_id,1) ON DUPLICATE KEY UPDATE gifts = gifts + 1')
vRP._prepare('premiacao/getRankup',[[
  SELECT *
  FROM uf_daily 
  WHERE user_id = @user_id
]])


function lServer.getData()
  local _src    = source 
  local timeout = os.time()

  local user_id = vRP.getUserId(_src)
  if not user_id then  
    while not user_id do 
      Wait(5000)
      user_id = vRP.getUserId(_src)
      if os.time() - timeout > 5 then 
        break 
      end
    end
  end
  user_id = vRP.getUserId(_src)

  if not user_id then 
    return {
      detected     = false,
      hours     = 0,
      loginTime = os.time(),
      lastGift  = false,
    } end
  local rows    = vRP.query('premiacao/getRankup',{user_id = user_id})
  lInfo[user_id] = {
    newer     = true,
    hours     = 0,
    loginTime = os.time(),
    lastGift  = false,
  }
  if #rows > 0 then 
    lInfo[user_id] = {}
    lInfo[user_id].hours     = rows[1].hours
    if rows[1].lastGift then 
    lInfo[user_id].lastGift  = json.decode(rows[1].lastGift) or false
    else 
      lInfo[user_id].lastGift  =  false
    end 
    lInfo[user_id].loginTime = os.time()
  end
  usersBySource[_src] = user_id
  return lInfo[user_id]
end
function lServer.getTime()
    return os.time()
end
function lServer.reedemGift(data)
  local _src      = source 
  local user_id   = vRP.getUserId(_src)
  local infoTable = cfg.gifts[tostring(data.lastHour)][data.probability]
  local giftTable = infoTable.gifts[data.randomIndex]
  if (lInfo[user_id] and lInfo[user_id].lastGift) and data.lastHour and tonumber(data.lastHour) <= lInfo[user_id].lastGift.lastHour then 
      return {success = false} 
  end
  if user_id then
    local randAmount = math.random(giftTable.amount.min,giftTable.amount.max)
    if infoTable.globalMessage.enable then 
      sendMessage({user_id = user_id, item = {name = giftTable.name, idname = giftTable.idname, amount = randAmount }, message = infoTable.globalMessage.message })
    end
    lInfo[user_id].lastGift = {name = giftTable.name,idname = giftTable.idname, amount = randAmount, lastHour = tonumber(data.lastHour)}
    lClient.updateInfoTable(_src,lInfo[user_id])
    sendToDiscord(cfg.webhooks.reedemGift,'user '..user_id..' get: '.. giftTable.idname..'x' ..randAmount)
    vRP._execute('premiacao/insertGift',{user_id = user_id})
    vRP._execute('premiacao/insertLast',{lastGift = json.encode({name = giftTable.name,idname = giftTable.idname, amount = randAmount, lastHour = data.lastHour}),user_id = user_id})
    if giftTable.idname == "money" then 
      vRP.giveMoney(user_id,randAmount)
    elseif giftTable.idname == "uf-coins" then 
      vRP._execute('uf/giveCoins',{user_id = user_id, coins = randAmount})
      TriggerEvent("uf-coins:updateGive",user_id,randAmount)
    else 
    vRP.giveInventoryItem(user_id,giftTable.idname,randAmount)
    end
    return {success = true,item = {idname = giftTable.idname, name = giftTable.name, amount = randAmount}}
  end
  return {success = false}
end

function lServer.saveInfo(user_id)
  if user_id and lInfo[user_id] then 
    lInfo[user_id].hours = lInfo[user_id].hours + ( (os.time() - lInfo[user_id].loginTime)/3600)
    vRP._execute('premiacao/insertDaily',{hours = ((lInfo[user_id]) and lInfo[user_id].hours or 0),user_id = user_id})
    lInfo[user_id] = nil
  end 
end


function sendMessage(msgData)
  if string.match(msgData.message,"nome") or string.match(msgData.message,"sobrenome") then 
    local identity = vRP.getUserIdentity(msgData.user_id)
    if cfg.identity then 
      msgData.message = msgData.message:gsub("{nome}",identity[cfg.identity.nome])
      msgData.message =  msgData.message:gsub("{sobrenome}",identity[cfg.identity.sobrenome])
    end
  end
  msgData.message = msgData.message:gsub("{item}",msgData.item.name)
  msgData.message = msgData.message:gsub("{amount}",msgData.item.amount)
  TriggerClientEvent('chat:addMessage', -1, {
    template = cfg.actions.chat_template,
    args = { msgData.message }
  })
end


CreateThread(function()
  while true do 
      Citizen.Wait(30*60000)
      for user_id,v in pairs(lInfo) do 
          if v.hours and v.loginTime then 
              local otherTime = v.hours + ( (os.time() - v.loginTime)/3600 )
              vRP._execute('premiacao/insertDaily',{hours = otherTime or 0,user_id = user_id})  
          end
      end
  end
end)

RegisterCommand("forcehours", function(source)
  if source == 0 then 
      for user_id,v in pairs(lInfo) do 
      local otherTime = v.hours + ( (os.time() - v.loginTime)/3600)
      vRP._execute('premiacao/insertDaily',{hours = otherTime or 0,user_id = user_id})  
      end
  end
end)

AddEventHandler('playerDropped',function() 
    local source = source
  if usersBySource[source] then    
      lServer.saveInfo(usersBySource[source])
      usersBySource[source] = nil
  end
end)
AddEventHandler('vRP:playerLeave', function(user_id) lServer.saveInfo(user_id) end)

RegisterServerEvent('uf-daily:reportException')
AddEventHandler("uf-daily:reportException", function(err)
  local source = source 
  local user_id = vRP.getUserId(source)
  local wh = cfg.webhooks.reportbug
  sendToDiscord(wh,"Erro encontrado: "..err or "Sem registro".."\n Usuário: "..user_id)
end)