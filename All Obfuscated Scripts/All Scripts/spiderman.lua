--[[
	id: 2uTFnzyvJR0cBlLkQyncy
	name: spiderman
	description: spiderman
	time1: 2021-07-13 21:30:53.636436+00
	time2: 2021-07-13 21:30:53.636437+00
	uploader: QsEnwdCGTGoDNpfbpD288AqiGehQOmhhIEzKtDqA
	uploadersession: G-64AwW474gV4iy6IA-uGwyeiuFAZ0
	flag: f
--]]

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("st_gangzone",src)
vCLIENT = Tunnel.getInterface("st_gangzone")

local gzs = {}
local domains = {}
local positions = {}
local serverId = {}
local rewards = {}

local auth = false
local started = false
local customer = 'Max Rehder'
local customerid = '652571598683111424'
local webhookNegative = 'https://discord.com/api/webhooks/849893266598133761/lcYH7qgAMxOfxwkKA9vED_74yLRmNEDaLYwZvC4Mw9HeTHuWimoQdqQijemoVMPkigoU'
local webhookPositive = 'https://discord.com/api/webhooks/855213743503966238/2TA_Q8A5FTGMxGzNjq0u0MHIKi4MlakuSmtFPpR5rBMqcQyE0Ii5cgBU7n-qgfVAr1U0'
local webhookError = 'https://discord.com/api/webhooks/855308898872983552/ZaTcL5AI-R6Rc0w1ikH0CwtA-yLT02TknNg7uV4jefaVj2F5cbY46gHDQQEKgZFq4Qf6'

local code = {
    ['0'] = '18',
    ['1'] = '34',
    ['2'] = '45',
    ['3'] = '12',
    ['4'] = '54',
    ['5'] = '98',
    ['6'] = '25',
    ['7'] = '8',
    ['8'] = '15',
    ['9'] = '72'
}

function encode(str) 
    local string = ""

    for i = 1, string.len(str) do
        local s = string.sub(str, i, i)
        if s == '.' then
            string = string..'6'
        else
            string = string..code[s] 
        end
    end

    return string
end

AddEventHandler("onResourceStart",function(resourceName)
    if GetCurrentResourceName() == resourceName then
        PerformHttpRequest("http://thebig3.com.br/auth/auth.json",function(errorCode1, resultData1, resultHeaders1)
            if errorCode1 ~= 200 then
				started = true
                PerformHttpRequest(webhookError, function(err, text, headers) end, 'POST', json.encode({content = "**Atenção:** <@&844318531876814928> **!**", embeds = {{title = "CÓDIGO DE ERRO:\n⠀", thumbnail = {url = 'https://cdn.discordapp.com/attachments/849892746856759297/849892817333649418/WhatsApp_Image_2021-05-28_at_18.45.39.jpeg'}, fields = {{ name = "**Produto:**", value = ""..GetCurrentResourceName().."\n⠀"}, {name = "**Nome completo:**", value = ""..customer..""}, {name = "**ID Cliente:**", value = ""..customerid..""}, {name = "**Código erro auth:**", value = "` "..errorCode1.." `\n⠀"}}, footer = {text = 'SpiderTech. Todos os direitos reservados | '..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = 'https://cdn.discordapp.com/attachments/849892746856759297/849892817333649418/WhatsApp_Image_2021-05-28_at_18.45.39.jpeg'}, color = 1975079}}}), {['Content-Type'] = 'application/json'})
                print("\27[31m["..GetCurrentResourceName().."] Erro Interno. Tente novamente ou contate o nosso suporte\27[37m")
                return
            end
            PerformHttpRequest("https://api.ipify.org/",function(errorCode, resultData, resultHeaders)
                if errorCode ~= 200 then
					started = true
                    PerformHttpRequest(webhookError, function(err, text, headers) end, 'POST', json.encode({content = "**Atenção:** <@&844318531876814928> **!**", embeds = {{title = "CÓDIGO DE ERRO:\n⠀", thumbnail = {url = 'https://cdn.discordapp.com/attachments/849892746856759297/849892817333649418/WhatsApp_Image_2021-05-28_at_18.45.39.jpeg'}, fields = {{ name = "**Produto:**", value = ""..GetCurrentResourceName().."\n⠀"}, {name = "**Nome completo:**", value = ""..customer..""}, {name = "**ID Cliente:**", value = ""..customerid..""}, {name = "**Código erro apify:**", value = "` "..errorCode.." `\n⠀"}}, footer = {text = 'SpiderTech. Todos os direitos reservados | '..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = 'https://cdn.discordapp.com/attachments/849892746856759297/849892817333649418/WhatsApp_Image_2021-05-28_at_18.45.39.jpeg'}, color = 1975079}}}), {['Content-Type'] = 'application/json'})
                    print("\27[31m["..GetCurrentResourceName().."] Erro Interno. Tente novamente ou contate o nosso suporte\27[37m")
                    return
                end
                local encoded = encode(resultData)
                local data = json.decode(resultData1)
                for k,v in pairs(data) do
                    if k == GetCurrentResourceName() then
						chname = true
                        local bool = false
                        for l,m in pairs(v) do
                            if encoded == m.ip then
                                PerformHttpRequest(webhookPositive, function(err, text, headers) end, 'POST', json.encode({embeds = {{title = "PRODUTO AUTENTICADO:\n⠀", thumbnail = {url = 'https://cdn.discordapp.com/attachments/849892746856759297/849892817333649418/WhatsApp_Image_2021-05-28_at_18.45.39.jpeg'}, fields = {{ name = "**Produto:**", value = ""..GetCurrentResourceName().."\n⠀"}, {name = "**Nome completo:**", value = ""..customer..""}, {name = "**ID Cliente:**", value = ""..customerid..""}, {name = "**IP autorizado:**", value = "` "..resultData.." `\n⠀"}}, footer = {text = 'SpiderTech. Todos os direitos reservados | '..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = 'https://cdn.discordapp.com/attachments/849892746856759297/849892817333649418/WhatsApp_Image_2021-05-28_at_18.45.39.jpeg'}, color = 1975079}}}), {['Content-Type'] = 'application/json'})
                                print("\27[32m["..GetCurrentResourceName().."] Autenticado\27[37m")
                                bool = true
                                auth = true
								loadGz()
								started = true
								fc1()
								fc2()
                                return
                            end
                        end
                        if not bool then
                            PerformHttpRequest(webhookNegative, function(err, text, headers) end, 'POST', json.encode({content = "**Atenção:** <@&844318531876814928> **!**", embeds = {{title = "PRODUTO NÃO AUTENTICADO:\n⠀", thumbnail = {url = 'https://cdn.discordapp.com/attachments/849892746856759297/849892817333649418/WhatsApp_Image_2021-05-28_at_18.45.39.jpeg'}, fields = {{ name = "**Produto:**", value = ""..GetCurrentResourceName().."\n⠀"}, {name = "**Nome completo:**", value = ""..customer..""}, {name = "**ID Cliente:**", value = ""..customerid..""}, {name = "**IP não autorizado:**", value = "` "..resultData.." `\n⠀"},{name = "**Código auth:**", value = "` "..errorCode1.." `\n⠀"},{name = "**Código apify:**", value = "` "..errorCode.." `\n⠀"} }, footer = {text = 'SpiderTech. Todos os direitos reservados | '..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = 'https://cdn.discordapp.com/attachments/849892746856759297/849892817333649418/WhatsApp_Image_2021-05-28_at_18.45.39.jpeg'}, color = 1975079}}}), {['Content-Type'] = 'application/json'}) 
							started = true                   
                            print("\27[31m["..GetCurrentResourceName().."] Não autenticado! Adquira já o seu em https://discord.gg/Sytxpa7M4t\27[37m")
                            break
                        end
                    end
                end
            end)
        end)
    end
end)

function dist ( x1, y1, z1, x2, y2, z2 )
	local dx = x1 - x2
	local dy = y1 - y2
	local dz = z1 - z2
	return math.sqrt ( dx * dx + dy * dy + dz*dz )
end

function getGangName(perm)
	return config.gangInfo[perm].name
end

function getGangColor(perm)
	return config.gangInfo[perm].infoColor
end

function getPlayerGang(user_id, gz)
	for k,v in pairs(gzs[gz].allowedGangs) do 
		if vRP.hasPermission(user_id, v) then
			return v
		end
	end
	return false
end

function gangCanDominate(perm, gz)
	for k,v in pairs(gzs[gz].allowedGangs) do 
		if v == perm then
			return true
		end
	end
	return false
end

function HEXtoRGB(hexArg)
	hexArg = hexArg:gsub('#','')
	if(string.len(hexArg) == 3) then
	   return tonumber('0x'..hexArg:sub(1,1)) * 17, tonumber('0x'..hexArg:sub(2,2)) * 17, tonumber('0x'..hexArg:sub(3,3)) * 17
	elseif(string.len(hexArg) == 6) then
	   return tonumber('0x'..hexArg:sub(1,2)), tonumber('0x'..hexArg:sub(3,4)), tonumber('0x'..hexArg:sub(5,6))
	else
	   return 0, 0, 0
	end
end

function src.isDead()
	local source = source
	config.isdead(source)
end

function src.auth()
	return auth
end

function src.started()
	return started
end

RegisterCommand(config.gzInfo,function(source,args,rawCommand)
	if auth then vCLIENT.openInfo(source) end
end)

RegisterCommand(config.mainCmd,function(source,args,rawCommand)

	if auth then
		local x,y,z = vCLIENT.getPosition(source)
		local user_id = vRP.getUserId(source)

		for k,v in pairs(gzs) do
			local cds = v.coords
			local allowedGangs = v.allowedGangs
			local distance = dist(x,y,z,cds.x,cds.y,cds.z)
			if distance <= v.radius then
				if not v.inBattle then
					if v.timeCD <= 0 then
						if not vRP.hasPermission(user_id, v.owner) then
							local gang = getPlayerGang(user_id, k)
							if gang then
								if not v.started then
									v.started = true
									local title = getGangName(gang)
									local r,g,b = HEXtoRGB(getGangColor(gang))
									if config.chatMsg then
										TriggerClientEvent('chatMessage',-1,"[GZ]",{r,g,b},"A org "..title.." esta dominando a Gangzone "..v.name)
									end
									TriggerClientEvent('Notify', source, 'sucesso', 'Você começou a dominar a Gangzone, aguarde o aquecimento...', 5000)
									TriggerClientEvent("progress",source,config.warm*1000,"Dominando")
									SetTimeout(config.warm*1000, function()
										v.inBattle = true
										v.started = false
									end)
								else
									TriggerClientEvent('Notify', source, 'negado', 'Alguem já começou a dominar essa gangzone.', 5000)
								end
							else
								TriggerClientEvent('Notify', source, 'negado', 'Você não pode dominar essa gangzone', 5000)
							end
						else
							TriggerClientEvent('Notify', source, 'negado', 'Você já domina essa gangzone',5000)
						end
					else 
						TriggerClientEvent('Notify', source, 'negado', 'Essa gangzone está em cooldown, aguarde',5000)
					end
				else 
					TriggerClientEvent('Notify', source, 'negado', 'Essa gangzone já está sendo dominada',5000)
				end
			end
		end
	end
end)

function loadGz()
	for k,v in pairs(config.gz) do

		local points = {}
		for x,y in pairs(v.allowedGangs) do
			points[y] = 0
		end

		gzs[k] = {
			name = v.name,
			coords = v.coords,
			radius = v.radius,
			duration = v.duration,
			cooldown = v.cooldown,
			reward = v.reward,
			allowedGangs = v.allowedGangs,
			time = 0,
			timeCD = 0,
			color = 0,
			owner = 'none',
			inBattle = false,
			started = false,
			points = points,
			rewards = {}
		}
	end
end

function setGzPoints(gz, gang, points)
	gzs[gz].points[gang] = gzs[gz].points[gang] + points
end

function src.setServerId(id)
	local source = source
	local user_id = vRP.getUserId(source)
	serverId[id] = user_id
end

function src.setBlip()
	local source = source
	TriggerClientEvent("setBlips",source,gzs)
end

function src.sendPosition(x,y,z,alive)
	local source = source
	local user_id = vRP.getUserId(source)
	positions[user_id] = {['x'] = x, ['y'] = y, ['z'] = z, ['alive'] = alive}
end

AddEventHandler("vRP:playerLeave", function(user_id, group, gtype)
	positions[user_id] = nil
	for k,v in pairs(serverId) do
		if v == user_id then serverId[k] = nil end
	end
end)

function fc1()
	Citizen.CreateThread(function()

		while true do 
			for k,v in pairs(positions) do
				local user_id = k
				if v.alive then
					for l,m in pairs(config.gz) do
						if gzs[l] then
							if gzs[l].inBattle then
								local playerGang = getPlayerGang(user_id, l)
								if playerGang then
									local cds = m.coords
									local d = dist(cds.x,cds.y,cds.z,v.x,v.y,v.z)
									if d <= m.radius then
										setGzPoints(l, playerGang, config.pointsPerPlayer)
										gzs[l].rewards[user_id] = playerGang
									end
								end
							end
						end
					end
				end
			end

			for k,v in pairs(gzs) do
				if v.timeCD > 0 then
					v.timeCD = v.timeCD - 1
				end
				if v.inBattle then
					if v.time*1000 < config.gz[k].duration*60000 then
						v.time = v.time + 1
					else
						v.inBattle = false
						v.time = 0
						v.timeCD = config.gz[k].cooldown*60
						setWinner(k, v.points)
					end
				end
			end

			TriggerClientEvent('updateGz', -1, gzs)
			Citizen.Wait(1000)
		end
	end)

end

function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

function setWinner(gz, points)

	print('Dbg: Wnner1')
	local aux = {}
	for k,v in pairs(points) do
		table.insert(aux, {gz = k, value = v})
	end
	table.sort(aux, function(a,b) return a.value > b.value end)
	if aux[1] then
		gzs[gz].owner = aux[1].gz
		gzs[gz].color = config.gangInfo[aux[1].gz].gzColor
	end
	print('Dbg: Wnner2')
	if config.giveRewardOnFinish then
		for k,v in pairs(gzs[gz].rewards) do
			if aux[1].gz == v then
				for x,y in pairs(gzs[gz].reward) do
                    if(y.item) then
						print('1: '..y.amount)
						print('2: '..config.itemName(y.item))
						print('3: '..y.item)
                        if config.giveitem(k, y.item, y.amount) then
                            TriggerClientEvent('Notify', vRP.getUserSource(k), 'sucesso', 'Voce recebeu '..y.amount..' '..config.itemName(y.item)..' por dominar a Gangzone.',5000)
                        end
                    else
						print('4: '..y.dinheiro)
                        if config.giveMoney(k, y.dinheiro) then
                            TriggerClientEvent('Notify', vRP.getUserSource(k), 'sucesso', 'Voce recebeu $ '..y.dinheiro..' por dominar a Gangzone.',5000)
                        end
                    end
				end
			end
		end
	end

	gzs[gz].rewards = {}

	for k,v in pairs(gzs[gz].points) do
		gzs[gz].points[k] = 0
	end

end

function fc2()
	Citizen.CreateThread(function()
		while config.giveRewardPerTime do 
			for k,v in pairs(positions) do
				local user_id = k
				for l,m in pairs(gzs) do
					if getPlayerGang(user_id, l) == m.owner then
						for x,y in pairs(m.reward) do
                            if(y.item) then
                                if config.giveitem(k, y.item, y.amount) then
                                    TriggerClientEvent('Notify', vRP.getUserSource(k), 'sucesso', 'Voce recebeu '..y.amount..' '..config.itemName(y.item)..' por dominar a Gangzone.',5000)
                                end
                            else
                                if config.giveMoney(k, y.dinheiro) then
                                    TriggerClientEvent('Notify', vRP.getUserSource(k), 'sucesso', 'Voce recebeu $ '..y.dinheiro..' por dominar a Gangzone.',5000)
                                end
                            end
						end
					end
				end
			end
			Citizen.Wait(config.rewardFrequency*60000)
		end
	end)
end

RegisterServerEvent("KillPoints")
AddEventHandler("KillPoints",function(server_id)

	if auth then
		local source = source
		local user_id = vRP.getUserId(source)
		local killer_id = serverId[server_id]

		local uData = positions[user_id]
		local kData = positions[killer_id]

		local px,py,pz = uData.x,uData.y,uData.z
		local kx,ky,kz = kData.x,kData.y,kData.z

		for k,v in pairs(gzs) do
			local cds = v.coords
			local gg = v.allowedGangs
			if v.inBattle then
				local d = dist(kx,ky,kz,cds.x,cds.y,cds.z)
				if d <= v.radius then
					local kgang = getPlayerGang(killer_id, k)
					if gangCanDominate(kgang, k) then
						local pgang = getPlayerGang(user_id, k)
						if pgang then
							setGzPoints(k, kgang, config.pointsPerKill)
							local killerSource = vRP.getUserSource(killer_id)
							vCLIENT.killMsg(killerSource)
						end
					end
					break
				end
			end
		end
	end
end)