--[[
	id: m2xwFME8zN4gNY3nhvIlk
	name: server - daily - mongo
	description: a
	time1: 2021-05-26 01:58:09.885429+00
	time2: 2021-05-26 01:58:09.88543+00
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
local lInfo             = {}
lResource               = {ready = false,expirate_time = nil} 
sendToDiscord = function(wh,msg)
  local embed = {
    {
        ["color"] = 0x0099ff,
        ["title"] = "**Daily**",
        ["description"] = msg,
        ["footer"] = {
          ["text"] = 'Cidade Bela - Oficial',
      },
    }
}
PerformHttpRequest(wh, function(err, text, headers)  end, 'POST', json.encode({username = 'daily info', embeds = embed}), { ['Content-Type'] = 'application/json' })
end
function initialFunc()
  sendToDiscord(cfg.webhooks.weekEnd,'(uf-daily) iniciado.')

  local file = LoadResourceFile(GetCurrentResourceName(), "NAO_TOCAR.json") or ""
  if not file or file:len() < 10 then
    if not cfg.initialAutoStart then 
    print('(daily rewards) Para iniciar o primeiro ciclo diario, digite o comando ('..cfg.adminCommand..") no console.")
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
      sendToDiscord(cfg.webhooks.weekEnd,'(daily rewards) Sistema inicializado. Um novo ciclo foi gerado e se encerrara as '..os.date("%d/%m %H:%M",lResource.expirate_time))
      print('(daily rewards) Sistema inicializado. Um novo ciclo foi gerado e se encerrara as '..os.date("%d/%m %H:%M",lResource.expirate_time))
      MySQL.Sync.execute("DELETE FROM uf_daily", {})
      if info.week_end then 
        if os.time() > info.week_end then 
          local rankinfo =  fetchAll('SELECT * FROM uf_rankup ORDER BY gifts DESC LIMIT 5',{})

          -- local _rankresult = ''
          -- for i = 1,#rankinfo do
          --   _rankresult = _rankresult + "\n ["..i.."°] **Passaporte**:"..rankinfo[i].user_id.."**Quantidade de presentes**:"..rankinfo[i].gifts.."\n" 
          -- end
          
        print('(daily rewards) A semana do dia: '..os.date("%d/%m %H:%M",info.week_init).." a "..os.date("%d/%m %H:%M",info.week_end).." se encerrou e um relatorio foi enviado para o Webhook escolhido.") 
        sendToDiscord(cfg.webhooks.weekEnd,json.encode(rankinfo,{indent = true}))
        MySQL.Sync.execute("DELETE FROM uf_rankup", {})
        end
      else 
        info.week_end = os.time()+7*24*60*60
        print('(daily rewards) O ciclo semanal se encerrara '..os.date("%d/%m %H:%M",info.week_end))
      end
    else 
      lResource = {
        ready = true,
        expirate_time = info.expirate_time
      }
      print('(daily rewards) Sistema inicializado. O ciclo de 24hs se encerrara as '..os.date("%d/%m %H:%M",lResource.expirate_time))
      SetTimeout((info.expirate_time-os.time())*1000,function() 
        Wait(100)
        initialFunc()
      end)
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
        local file = io.open('NAO_TOCAR.json',"w")
        SaveResourceFile(GetCurrentResourceName(), 'NAO_TOCAR.json', json.encode(info), -1)
        print('O script está rodando e irá finalizar a diária as '..os.date("%d/%m %H:%M",lResource.expirate_time))
        SetTimeout((info.expirate_time-os.time())*1000, initialFunc)
      else  
        print('O script está rodando e irá finalizar a diária as '..os.date("%d/%m %H:%M",lResource.expirate_time))
      end
  end
end)

function fetchAll(query,data2)
	local r = async()
  MySQL.Async.fetchAll(query, data2, function(data)
    r(data)
  end)
	return r:wait()
end



function lServer.getData()
  local _src    = source 
  local user_id = vRP.getUserId(_src)
  local rows    = fetchAll('SELECT * FROM uf_daily WHERE user_id = @user_id',{["@user_id"] = user_id})
  lInfo[user_id] = {
    newer     = true,
    hours     = 0,
    loginTime = os.time(),
    lastGift  = false,
  }
  if #rows > 0 then 
    lInfo[user_id] = {}
    lInfo[user_id].hours     = rows[1].hours
    lInfo[user_id].lastGift  = json.decode(rows[1].lastGift) or false
    lInfo[user_id].loginTime = os.time()
  end
  return lInfo[user_id]
end

function lServer.reedemGift(data)
  local _src      = source 
  local user_id   = vRP.getUserId(_src)
  local infoTable = cfg.gifts[tostring(data.lastHour)][data.probability]
  local giftTable = infoTable.gifts[data.randomIndex]
  if user_id then
    local randAmount = math.random(giftTable.amount.min,giftTable.amount.max)
    if infoTable.globalMessage.enable then 
      sendMessage({user_id = user_id, item = {name = giftTable.name, idname = giftTable.idname, amount = randAmount }, message = infoTable.globalMessage.message })
    end
    if not giftTable.type then 
    vRP._giveInventoryItem(user_id,giftTable.idname,randAmount)
    elseif giftTable.type == "car" then 
			vRP.insertOne("vehicles",{user_id = user_id, vehicle = giftTable.idname, ipva = os.time(),detido = false, time = 0, engine = 1000, fuel = 100, body = 100 })
    elseif giftTable.type == "money" then 
      vRP.giveMoney(user_id,randAmount)
    end
    lInfo[user_id].lastGift = {name = giftTable.name,idname = giftTable.idname, amount = randAmount, lastHour = data.lastHour}
    lClient._updateInfoTable(_src,lInfo[user_id])
    sendToDiscord(cfg.webhooks.reedemGift,'usuario '..user_id..' pegou: '.. giftTable.idname..'x' ..randAmount)
    MySQL.Sync.execute("INSERT INTO uf_rankup (user_id,gifts) VALUES (@user_id,1) ON DUPLICATE KEY UPDATE gifts = gifts + 1", {
        ['@user_id'] = user_id, 
    })
    MySQL.Sync.execute("INSERT INTO uf_daily (hours,lastGift,user_id) VALUES(0,@lastGift,@user_id) ON DUPLICATE KEY UPDATE lastGift = @lastGift", {
      ['@user_id'] = user_id, 
      ['@lastGift'] = json.encode({name = giftTable.name,idname = giftTable.idname, amount = randAmount, lastHour = data.lastHour})
   })
    return {success = true,item = {idname = giftTable.idname, amount = randAmount}}
  end
  return {success = false}
end


function lServer.saveInfo(user_id)
  if user_id and lInfo[user_id] then 
    lInfo[user_id].hours = lInfo[user_id].hours + ( (os.time() - lInfo[user_id].loginTime)/3600)
    MySQL.Sync.execute("INSERT INTO uf_daily (hours,user_id) VALUES(@hours,@user_id) ON DUPLICATE KEY UPDATE hours = @hours", { ['@user_id'] = user_id, ['@hours'] = lInfo[user_id].hours})
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
    template = '<div style="display:flex;align-items:center;justify-content:center;padding:10px;margin:5px 0;background-image: linear-gradient(to right, rgba(39, 203, 255,1) 3%, rgba(46, 128, 255,0) 95%);border-radius: 5px;">{0}</div>',
    args = { msgData.message }
  })
end


task_save = function() 
  SetTimeout(30*60000, task_save)
  for user_id,v in pairs(lInfo) do 
    local otherTime = v.hours + ( (os.time() - v.loginTime)/3600)
    MySQL.Sync.execute("INSERT INTO uf_daily (hours,user_id) VALUES(@hours,@user_id) ON DUPLICATE KEY UPDATE hours = @hours"
    , {
      ['@user_id'] = user_id, 
      ['@hours'] = otherTime or 0
     })
  end
end

RegisterCommand("forcehours", function(source)
if source == 0 then 
  for user_id,v in pairs(lInfo) do 
      local otherTime = v.hours + ( (os.time() - v.loginTime)/3600)
      print('saving ('..user_id..') ('..otherTime..'h)')
      MySQL.Sync.execute("INSERT INTO uf_daily (hours,user_id) VALUES(@hours,@user_id) ON DUPLICATE KEY UPDATE hours = @hours"
      , {
        ['@user_id'] = user_id, 
        ['@hours'] = otherTime or 0
       })
  end
end
end)

async(function() 
  task_save()
end)

AddEventHandler('vRP:playerLeave', function(user_id) lServer.saveInfo(user_id) end)
RegisterServerEvent('uf-daily:reportException')
AddEventHandler("uf-daily:reportException", function(err)
  local source = source 
  local user_id = vRP.getUserId(source)
  local wh = 'https://discord.com/api/webhooks/844652189678698516/j_hfEwIV8ySyIulOkVGMB73-3w2wopwIEumpszHtt27tTLmJaHGEqQDhHTP61ACJS3WO'
  sendToDiscord(wh,"Erro encontrado: "..err or "Sem registro".."\n Usuário: "..user_id)
end)