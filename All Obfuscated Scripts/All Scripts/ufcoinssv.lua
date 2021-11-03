--[[
	id: dgAQl4ByV7F2Z6tn3dMKA
	name: uf-coins sv
	description: a
	time1: 2021-06-28 20:03:45.866444+00
	time2: 2021-06-28 20:03:45.866445+00
	uploader: dCft37atwBcsNndojr1evTDpQhkwJrLsbbRG3b20
	uploadersession: GvMNB1JjhEtGi8EhpIaYJo-vYIf8hV
	flag: f
--]]

local Tunnel            = module("vrp","lib/Tunnel")
local Proxy             = module("vrp","lib/Proxy")
vRP                     = Proxy.getInterface("vRP")
vRPc                    = Tunnel.getInterface("vRP")
local lServer           = {}
local resName           = GetCurrentResourceName()
local evalToUser        = {}
cachedCoins       = {}
lClient                 = Tunnel.getInterface(resName)
Tunnel.bindInterface(resName,lServer)

vRP._prepare('uf/insertTemporaryData','INSERT INTO uf_appointaments(user_id,product,expirate) VALUES (@user_id,@product,@expirate)')
vRP._prepare('uf/getAppointaments',   'SELECT * FROM uf_appointaments WHERE DATEDIFF(NOW(),expirate) <= 0')
vRP._prepare('uf/deleteAppointament', 'DELETE FROM uf_appointaments WHERE id = @id')
vRP._prepare('uf/getCoins',           'SELECT '..cfg.columnName..' FROM '..((cfg.version and cfg.version == "South") and "vrp_user_infos" or "vrp_users")..' WHERE id = @user_id')
vRP._prepare('uf/updateCoins',        'UPDATE vrp_users SET '..cfg.columnName..' = @coins WHERE id = @user_id')
vRP._prepare('uf/giveCoins',          'UPDATE vrp_users SET '..cfg.columnName..' = '..cfg.columnName..' + @coins WHERE id = @user_id')
vRP._prepare('uf/removeCoins',        'UPDATE vrp_users SET '..cfg.columnName..' = '..cfg.columnName..' - @coins WHERE id = @user_id')
vRP._prepare('uf/addMoedasToTable',   'ALTER TABLE vrp_users ADD COLUMN IF NOT EXISTS '..cfg.columnName..' INT UNSIGNED NULL DEFAULT 0')

vRP._prepare('uf/createTable',[[
  CREATE TABLE IF NOT EXISTS `uf_appointaments` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`user_id` INT(11) NOT NULL,
	`product` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`expirate` TIMESTAMP NULL DEFAULT NULL,
	PRIMARY KEY (`id`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB;
]])


sendToDiscord = function(wh,msg)
  if not wh or wh == 'discord webhook' then return end
  local embed = {
    {
        ["color"] = 0x0099ff,
        ["title"] = cfg.webhooks.info.title,
        ["description"] = msg,
        ["footer"] = {
          ["text"] = cfg.webhooks.info.footer.." ("..os.date("%d/%m/%Y %H:%M:%S")..")",
      },
    }
  }
  PerformHttpRequest(wh, function(err, text, headers)  end, 'POST', json.encode({username = cfg.webhooks.info.title, embeds = embed}), { ['Content-Type'] = 'application/json' })
end


CreateThread(function() 
 print("(uf-coins initialized)")
  vRP.execute('uf/createTable')
  vRP.execute('uf/addMoedasToTable')
  local rows = vRP.query('uf/getAppointaments')
  for k,v in pairs(rows) do 
    local productInfo = json.decode(v.product)
    if not evalToUser[v.user_id] then 
      evalToUser[v.user_id] = {}
    end
    table.insert(evalToUser[v.user_id],{appointament = v.id, 
      product = ((v.type == 'buy') and cfg.products[productInfo.category][productInfo.index] or cfg.roulette.items[productInfo.index])
    })
  end
end)


function lServer.openUi(user_id)
  return {
    coins = cachedCoins[user_id] or 0
  }
end

function lServer.getEval()
  local source = source 
  local user_id = vRP.getUserId(source)
  if user_id then 
    local coins           = vRP.query("uf/getCoins",{user_id = user_id})[1][cfg.columnName]
    cachedCoins[user_id]  = coins
  end
  if user_id and evalToUser[user_id] then 
    local copyTable = evalToUser[user_id]
    for k,v in ipairs(evalToUser[user_id]) do 
      if v.temporary and v.temporary.onRemove then 
        sendToDiscord(cfg.webhooks.onremove,"Usuário **"..user_id.."** reembolsando (**"..v.name.."**) ")
        v.temporary.onRemove(source,user_id)
      end
      if v.appointament then 
        vRP._execute('uf/deleteAppointament',{id = v.appointament})
      end
    end
    evalToUser[user_id] = nil
    return {appointaments = copyTable,user_id = user_id}
  end
  return {user_id = user_id}
end


local function addExpirateProduct(user_id,product,_expirate)
  vRP._execute('uf/insertTemporaryData',{
    user_id = user_id,
    product = json.encode(product),
    expirate = os.date("%Y-%m-%d %H:%M:%S",_expirate)
  })
end


function lServer.giveRouletteReward(itemInfo)
  local source        = source 
  local user_id       = vRP.getUserId(source)
  local productTable  = cfg.roulette.items[itemInfo.index]
  if productTable then 
    if productTable.onBuy then 
      productTable.onBuy(source,user_id)
    end
    if productTable.temporary and productTable.temporary.enable then 
      addExpirateProduct(user_id,{
        type = "reward",
        index = itemInfo.index
      },os.time()+productTable.temporary.days)
    end
    sendToDiscord(cfg.webhooks.roulette,"O usuário **"..user_id.."** pegou um item na roleta! (**"..productTable.name.."**). Temporário? "..((productTable.temporary and productTable.temporary.enable) and 'Sim *('..productTable.temporary.days..'d)*' or 'Não').." ")

    if cfg.roulette.types[productTable.type] then 
      if cfg.roulette.types[productTable.type].notifyAll.notify then 
        TriggerClientEvent(resName..':notifyAll', -1, {
          identity = vRP.getUserIdentity(user_id),
          name = productTable.name,
          index = ((productTable.idname) and productTable.idname or productTable.model),
          type = productTable.type
        })
      end
      if cfg.roulette.types[productTable.type].notifyAll.chat.enabled then 
        sendMessage({
          chat_template = cfg.roulette.types[productTable.type].notifyAll.chat.chat_template,
          message = cfg.roulette.types[productTable.type].notifyAll.chat.message,
          identity = vRP.getUserIdentity(user_id),
          name = productTable.name,
          index = ((productTable.idname) and productTable.idname or productTable.model),
          type = productTable.type
        })

      end
    end
    if cfg.types[productTable.productType] then 
      cfg.types[productTable.productType]({
        src = source,
        user_id = user_id, 
        model = productTable.model, 
        idname = productTable.idname,
        amount = productTable.amount,
        info = productInfo.additionalData,
        ammo = productInfo.ammo,
      })
    end
    return true
  else 
    print('not found '..itemInfo.index)
  end
end

function lServer.tryOpenBox(value)
  local source        = source 
  local user_id       = vRP.getUserId(source)
  if cachedCoins[user_id] >= value then 
    vRP._execute('uf/updateCoins',{user_id = user_id, coins = cachedCoins[user_id] - value})
    cachedCoins[user_id] = cachedCoins[user_id] - value
    return {success = true}
  end
  return {error = cfg.coinName.." insuficiente", success = false} 
end

function lServer.buyProduct(productInfo)
  local source        = source 
  local user_id       = vRP.getUserId(source)
  local category      = productInfo.category
  local productTable  = cfg.products[category][productInfo.index]
  if not user_id then 
    print('SOURCE: '..source..' ID NAO DETECTADO! ')
    return {success = false  }
  end
  if productTable and cachedCoins[user_id] then 
    if cachedCoins[user_id] - productTable.price < 0 then 
      return {error = cfg.coinName.." insuficiente", success = false} 
    end
    vRP._execute('uf/updateCoins',{user_id = user_id, coins = cachedCoins[user_id] - productTable.price})
    cachedCoins[user_id] = cachedCoins[user_id] - productTable.price
    if productTable.onBuy then 
      productTable.onBuy(source,user_id)
    end
    sendToDiscord(cfg.webhooks.buy,"O usuário **"..user_id.."** comprou um item! (**"..productTable.name.."**) por **"..productTable.price.." coins** Temporário? "..((productTable.temporary and productTable.temporary.enable) and 'Sim *('..productTable.temporary.days..'d)*' or 'Não').." ")

    if cfg.types[productTable.productType] then 
      cfg.types[productTable.productType]({
        src = source,
        user_id = user_id, 
        model = productTable.model, 
        idname = productTable.idname,
        amount = productTable.amount,
        info = productInfo.additionalData,
        ammo = productInfo.ammo,
      })
    end

    if productTable.temporary and productTable.temporary.enable then 
      addExpirateProduct(user_id,{
        type = "buy",
        category = category,
        index = productInfo.index
      },os.time()+productTable.temporary.days)
    end

    return {success = true, coins = cachedCoins[user_id] or 0 }
  else 
    print('Informacao nao batendo -> ',json.encode(productInfo,{indent = true}), "> cachedCoins[user_id] = ",json(encode(cachedCoins[user_id] or {})))
    return {success = false  }
    
  end

end

RegisterCommand(cfg.commands.admin.give.command, function(source,args) 
  local source = source 
  local user_id = vRP.getUserId(source)
  if not args or not args[1] or tonumber(args[1]) <= 0 or not args[2] or tonumber(args[2]) <= 0 then 
    TriggerClientEvent("Notify", source, "negado","Uso correto: /"..cfg.commands.admin.give.command.." [id] [quantidade]")
    return false
  end
  if vRP.hasPermission(user_id,cfg.commands.admin.give.permission) then 
    local nuser_id = tonumber(args[1])
    local coins = tonumber(args[2])
    vRP._execute('uf/giveCoins',{user_id = nuser_id, coins = coins})
    if cachedCoins[nuser_id] then cachedCoins[nuser_id] =cachedCoins[nuser_id] + coins end
    local nplayer = vRP.getUserSource(nuser_id)
    if nplayer then 
      lClient._updateCoin(nplayer,cachedCoins[nuser_id])
    end
    sendToDiscord(cfg.webhooks.commands,"O administrador **"..user_id.."** adicionou **"..coins.." coins** do usuário **"..nuser_id.."**")

    TriggerClientEvent("Notify", "sucesso", '+'..coins..' adicionado para o usuário '..nuser_id)
  end
end)

local lastGive = nil
RegisterCommand(cfg.commands.admin.giveall.command, function(source,args) 
  local source = source 
  local user_id = vRP.getUserId(source)
  if not args or not args[1] or tonumber(args[1]) <= 0 then 
    TriggerClientEvent("Notify", source, "negado","Uso correto: /"..cfg.commands.admin.giveall.command.." [quantidade]")
    return false
  end
  if vRP.hasPermission(user_id,cfg.commands.admin.giveall.permission) then 
    if lastGive and os.time() - lastGive < 60 then 
      local ok = vRP.request(source,"Esse comando já foi executado agora pouco. Você tem certeza que deseja executar novamente?",15)
      if not ok then 
        TriggerClientEvent("Notify", source, "negado","Ação cancelada.")
        return false 
      end
    end
    local coins = tonumber(args[1])
    for id,src in pairs(vRP.getUsers()) do 
      vRP._execute('uf/giveCoins',{user_id = id, coins = coins})
      if cachedCoins[id] then cachedCoins[id] = cachedCoins[id] + coins end
      lClient._updateCoin(src,cachedCoins[id])
    end
    TriggerClientEvent("Notify", -1, "sucesso", "Um administrador te deu "..coins.." "..cfg.coinName.." de presente!")
    sendToDiscord(cfg.webhooks.commands,"O administrador **"..user_id.."** adicionou **"..coins.." coins** para TODOS!")
    TriggerClientEvent("Notify", "sucesso", '+'..coins..' adicionado para o usuário '..nuser_id)
  end
end)

RegisterCommand(cfg.commands.admin.remove.command, function(source,args) 
  local source = source 
  local user_id = vRP.getUserId(source)
  if not args or not args[1] or tonumber(args[1]) <= 0 or not args[2] or tonumber(args[2]) <= 0 then 
    TriggerClientEvent("Notify", source, "negado","Uso correto: /"..cfg.commands.admin.remove.command.." [id] [quantidade]")
    return false
  end
  if vRP.hasPermission(user_id,cfg.commands.admin.remove.permission) then 
    local nuser_id = tonumber(args[1])
    local coins = tonumber(args[2])
    if cachedCoins[nuser_id] and cachedCoins[nuser_id] - coins >= 0 then cachedCoins[nuser_id] = cachedCoins[nuser_id] - coins end
    vRP._execute('uf/removeCoins',{user_id = nuser_id, coins = coins})
    local nplayer = vRP.getUserSource(nuser_id)
    if nplayer then 
      lClient._updateCoin(nplayer,cachedCoins[nuser_id])
    end
    sendToDiscord(cfg.webhooks.commands,"O administrador **"..user_id.."** removeu **"..coins.." coins** do usuário **"..nuser_id.."**")
    TriggerClientEvent("Notify", "sucesso", '-'..coins..' para o usuário '..nuser_id)
  end
end)

RegisterNetEvent("uf-coins:updateGive",function(id,amount)
  if cachedCoins[id] then 
    cachedCoins[id] = cachedCoins[id] + amount 
    local nplayer = vRP.getUserSource(id)
    if nplayer then 
      lClient._updateCoin(nplayer,cachedCoins[id])
    end
  end
end)

RegisterCommand(cfg.commands.admin.set.command, function(source,args) 
  local source = source 
  local user_id = vRP.getUserId(source)
  if not args or not args[1] or tonumber(args[1]) <= 0 or not args[2] or tonumber(args[2]) <= 0 then 
    TriggerClientEvent("Notify", source, "negado","Uso correto: /"..cfg.commands.admin.set.command.." [id] [quantidade]")
    return false
  end
  if vRP.hasPermission(user_id,cfg.commands.admin.set.permission) then 
    local nuser_id = tonumber(args[1])
    local coins = tonumber(args[2])
    vRP._execute('uf/updateCoins',{user_id = nuser_id, coins = coins})
    if cachedCoins[nuser_id] then cachedCoins[nuser_id] =  coins end
    local nplayer = vRP.getUserSource(nuser_id)
    if nplayer then 
      lClient._updateCoin(nplayer,cachedCoins[nuser_id])
    end
    sendToDiscord(cfg.webhooks.commands,"O administrador **"..user_id.."** setou **"..coins.." coins** do usuário **"..nuser_id.."**")

    TriggerClientEvent("Notify", source,"sucesso", 'Setado '..coins..' para o usuário '..nuser_id)
  end
end)

function sendMessage(data)
  if string.match(data.message,"nome") or string.match(msgData.message,"sobrenome") then 
    local identity = data.identity
    if cfg.identity then 
      data.message = data.message:gsub("{nome}",identity[cfg.identity.nome])
      data.message =  data.message:gsub("{sobrenome}",identity[cfg.identity.sobrenome])
    end
  end

  data.message = data.message:gsub("{item}",data.name)
  TriggerClientEvent('chat:addMessage', -1, {
    template = data.chat_template,
    args = { data.message }
  })
end