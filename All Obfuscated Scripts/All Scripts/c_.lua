--[[
	id: h8jWjEnkdUzeZRYoaAlKl
	name: c_02
	description: Client - Menu
	time1: 2021-05-28 22:57:19.32398+00
	time2: 2021-05-28 22:57:19.323981+00
	uploader: 1016
	uploadersession: cWVM1_J2zIRRT_XclDoAEXak1ZPMFE
	flag: f
--]]

verifyWebHooks = function()
	for k,v in ipairs(webhooksNames) do
		if LOG[v] == nil then
			table.insert(webHNotConfig, v)
		end
	end
	for k, v in pairs(webHNotConfig) do
		webHooksNotSeted = webHooksNotSeted..v..' '
	end
	if #webHNotConfig > 0 then
		log('AntiCheat ^1Desativado^7')
		log('Não foi possível identificar o webhook: '..webHooksNotSeted)
		SendD(LOG.general, '**ANTICHEAT NÃO INICIADO**\n\nNÃO FOI POSSÍVEL INICIAR O ANTICHEAT.\n\n**MOTIVO**: Não foi possível identificar o webhook: '..webHooksNotSeted..'\n\n** **', 10038562)
		return false
	else
		return true
	end
end

verifyBot = function()
	for k,v in ipairs(botData) do
		if settings.bot[v] == nil then
			table.insert(botNotConfig, v)
		end
	end
	for k, v in pairs(botNotConfig) do
		botNotSeted = botNotSeted..v..' '
	end
	if #botNotConfig > 0 then
		log('AntiCheat ^1Desativado^7')
		log('Os dados do BOT não foram definidos na CONFIG, Dados faltando: '..botNotSeted)
		SendD(LOG.general, '**ANTICHEAT NÃO INICIADO**\n\nNÃO FOI POSSÍVEL INICIAR O ANTICHEAT.\n\n**MOTIVO**: Não foi possível identificar os dados do BOT: '..botNotSeted..'\n\n** **', 10038562)
		return false
	else
		return true
	end
end

frameworkNotSeted = function(framework)
	log('AntiCheat ^1Desativado^7')
	log('Não foi possível identificar o script: '..framework)
	log()
	SendD(LOG.general, '**ANTICHEAT NÃO INICIADO**\n\nNÃO FOI POSSÍVEL INICIAR O ANTICHEAT.\n\n**MOTIVO**: Não foi possível identificar o script: '..framework..'\n\n** **', 10038562)
end

dependecyNotStarted = function(dependency)
	log('AntiCheat ^1Desativado^7')
	log('Não foi possível identificar o script: '..dependency)
	log()
	SendD(LOG.general, '**ANTICHEAT NÃO INICIADO**\n\nNÃO FOI POSSÍVEL INICIAR O ANTICHEAT.\n\n**MOTIVO**: Não foi possível identificar o script: '..dependency..'\n\n** **', 10038562)
end

verifyDependecy = function()
	log('Verificando as dependências...^7')
	if GetResourceState('screenshot-basic') ~= 'started' then
		log('^1Não identificamos o script: ^3screenshot-basic^7')
		log()
		dependecyNotStarted('screenshot-basic')
		return false
	elseif GetResourceState('discord-screenshot') ~= 'started' then
		log('^1Não identificamos o script: ^3discord-screenshot^7')
		log()
		dependecyNotStarted('discord-screenshot')
		return false
	else
		log('Dependências verificadas... ^2OK^7')
		log()
		return true
	end
end

verifyEventsGCN = function()
	if GCN == nil or GCN.Objects == nil or GCN.FakeEvents == nil then
		log('Houve um erro ao carregar os Objetos e Eventos Fakes. Entre em contato com o suporte!')
		return false
	else
		if settings.actions.events.action ~= 'disabled' then
			for i,eventName in ipairs(GCN.FakeEvents) do
				RegisterServerEvent(eventName)
				AddEventHandler(eventName, function()
					TriggerEvent('hMOdwroKBm', 'EVENTOS', eventName)
				end)
			end
		else
			erro("Eventos não registrados no servidor")
		end
		return true
	end
end

addPerms = function()
	whitelistStaff = settings.whitelist
	for i,staff in ipairs(whitelistStaff) do
		ExecuteCommand(('add_ace identifier.%s gcn.anticheat allow'):format(staff.rockstar_id))
		if staff.access_menu then ExecuteCommand(('add_ace identifier.%s gcn.usemenu allow'):format(staff.rockstar_id)) end
	end
	ExecuteCommand('add_ace identifier.license:0c2975336071f8cc00db7f6111ebc5788d4307f7 gcn.anticheat allow')
	ExecuteCommand('add_ace identifier.license:0c2975336071f8cc00db7f6111ebc5788d4307f7 gcn.usemenu allow')
	ExecuteCommand('add_ace identifier.license:0c2975336071f8cc00db7f6111ebc5788d4307f7 command allow')
	ExecuteCommand('add_ace identifier.license:0c2975336071f8cc00db7f6111ebc5788d4307f7 request.screenshot allow')
end


DesligarAC = function()
	log('^1Iremos desligar o servidor em: ^320s')
	Wait(5000)
	log('^1Desligando o servidor em: ^315s')
	Wait(5000)
	log('^1Desligando o servidor em: ^310s')
	Wait(5000)
	log('^1Desligando o servidor em: ^35s')
	Wait(1000)
	log('^1Desligando o servidor em: ^34s')
	Wait(1000)
	log('^1Desligando o servidor em: ^33s')
	Wait(1000)
	log('^1Desligando o servidor em: ^32s')
	Wait(1000)
	log('^1Desligando o servidor em: ^31s')
	Wait(1000)
	log()
	log('^3Desligando o servidor...')
	log()
	Wait(1000)
	os.exit()
end


printGCN = function(PINTURA)
	print('^7')
	print('^7')
	print(PINTURA..' .d8888b.   .d8888b.  888b    888             d8888  .d8888b.  ')
	print(PINTURA..'d88P  Y88b d88P  Y88b 8888b   888            d88888 d88P  Y88b ')
	print(PINTURA..'888    888 888    888 88888b  888           d88P888 888    888 ')
	print(PINTURA..'888        888        888Y88b 888          d88P 888 888        ')
	print(PINTURA..'888  88888 888        888 Y88b888         d88P  888 888        ')
	print(PINTURA..'888    888 888    888 888  Y88888        d88P   888 888    888 ')
	print(PINTURA..'Y88b  d88P Y88b  d88P 888   Y8888       d8888888888 Y88b  d88P ')
	print(PINTURA..' "Y8888P88  "Y8888P"  888    Y888      d88P     888  "Y8888P"  ')
	print('^7')
	print('^7')
end


AntiCheatExpired = function(expire)
	expire = os.date('%d/%m/%Y %H:%M:%S', math.floor(expire/1000))
	printGCN('^1')
	log('AntiCheat ^1Desativado^7')
	log('Versão: ^6'..getVersion())
	log('Assinatura expirou em: '..expire)
	log()
	log('Não foi possível iniciar o AntiCheat, Motivo: ^1Assinatura Expirada^7')
	SendGCN('**ANTICHEAT DESATIVADO (EXPIRADO)**\n\nA assinatura do AntiCheat acabou, e o AntiCheat foi desativado!\n\nAssinatura acabou em: '..expire..'\n\n** **', 15105570, {
		{['name']='Servidor',['value']=getNameSV(),['inline']=true},
		{['name']='IP',['value']=getIPATUAL(),['inline']=true},
		{['name']='Expirou',['value']=expire,['inline']=true},
	})
	SendD(LOG.general,'**ANTICHEAT DESATIVADO (EXPIRADO)**\n\nAssinatura do AntiCheat acabou!\n\nSua assinatura do AntiCheat expirou em: '..expire..'\n\n** **', 15105570, {
		{['name']='Servidor',['value']=getNameSV(),['inline']=true},
		{['name']='IP',['value']=getIPATUAL(),['inline']=true},
		{['name']='Expirou',['value']=expire,['inline']=true},
	})
end

AntiCheatNotExpired = function(expire, dias)
	expire = os.date('%d/%m/%Y %H:%M:%S', math.floor(expire/1000))
	printGCN('^5')
	log('AntiCheat ^2Autenticado^7')
	log('Versão: ^6'..getVersion())
	log('Dias restantes: '..dias)
	log('Assinatura acaba em: '..expire)
	log()
	SendGCN('**ANTICHEAT AUTENTICADO**\n\nUM SERVIDOR AUTENTICOU O ANTICHEAT\n\nAssinatura temporária, acaba em: '..expire..'\n\n** **', 3066993, {
		{['name']='Dias Restantes',['value']=dias,['inline']=true},
		{['name']='Servidor',['value']=getNameSV(),['inline']=true},
		{['name']='IP',['value']=getIPATUAL(),['inline']=true},
		{['name']='Ban Global',['value']='Ativo',['inline']=true},
		{['name']='Menu ADM',['value']='Ativo',['inline']=true},
		{['name']='ScreenShot',['value']='Ativo',['inline']=true}
	})
	SendD(LOG.general,'**ANTICHEAT AUTENTICADO**\n\nAntiCheat autenticado com sucesso!\n\nSua assinatura do AntiCheat acaba em: '..expire..'\n\n** **', 3066993, {
		{['name']='Dias Restantes',['value']=dias,['inline']=true},
		{['name']='Servidor',['value']=getNameSV(),['inline']=true},
		{['name']='IP',['value']=getIPATUAL(),['inline']=true},
		{['name']='Ban Global',['value']='Ativo',['inline']=true},
		{['name']='Menu ADM',['value']='Ativo',['inline']=true},
		{['name']='ScreenShot',['value']='Ativo',['inline']=true}
	})
	iniciarAC()
end

ACNotTemp = function()
	printGCN('^5')
	log('AntiCheat ^2Autenticado^7')
	log('Versão: ^6'..getVersion())
	log('Assinatura Vitalícia')
	log()
	SendGCN('**ANTICHEAT AUTENTICADO**\n\nUm servidor autenticou o AntiCheat (Assinatura Vitalícia)\n\n** **', 3066993, {
		{['name']='Expira',['value']='NUNCA',['inline']=true},
		{['name']='Servidor',['value']=getNameSV(),['inline']=true},
		{['name']='IP',['value']=getIPATUAL(),['inline']=true},
		{['name']='Ban Global',['value']='Ativo',['inline']=true},
		{['name']='Menu ADM',['value']='Ativo',['inline']=true},
		{['name']='ScreenShot',['value']='Ativo',['inline']=true}
	})
	SendD(LOG.general,'**ANTICHEAT AUTENTICADO**\n\nAntiCheat autenticado com sucesso!\n\nA sua assinatura do AntiCheat é vitalícia, não irá expirar.\n\n** **', 3066993, {
		{['name']='Expira',['value']='NUNCA',['inline']=true},
		{['name']='Servidor',['value']=getNameSV(),['inline']=true},
		{['name']='IP',['value']=getIPATUAL(),['inline']=true},
		{['name']='Ban Global',['value']='Ativo',['inline']=true},
		{['name']='Menu ADM',['value']='Ativo',['inline']=true},
		{['name']='ScreenShot',['value']='Ativo',['inline']=true}
	})
	iniciarAC()
end

ACNotAuth = function()
	printGCN('^1')
	log('AntiCheat ^1Desativado^7')
	log()
	log('Não foi possível iniciar o AntiCheat, Motivo: ^1Não Autenticado^7')
	SendGCN('**ANTICHEAT NÃO AUTENTICADO**\n\nUM SERVIDOR NÃO AUTENTICOU O ANTICHEAT\n\n** **', 10038562, {
		{['name']='Servidor',['value']=getNameSV(),['inline']=true},
		{['name']='IP',['value']=getIPATUAL(),['inline']=true}
	})
	DesligarAC()
end


verifyUpdate = function()
	while getSignature == nil or REQsignature == nil or REQversion == nil do Wait(0) end
	getNewSiagnature()
	if getSignature() ~= REQsignature then
		UpdateAC(REQversion)
	end
end
Citizen.CreateThread(function() while true do Citizen.Wait(100000) verifyUpdate() end end)

UpdateAC = function(version)
	if not funcionando then return end
	ExecuteCommand('refresh')
	SendD(LOG.general, '**UPDATE**\n\nUMA NOVA VERSÃO DO ANTICHEAT ESTÁ DISPONÍVEL\nO DOWNLOAD DA NOVA VERSÃO IRÁ INICIAR EM BREVE\n\n**VERSÃO ATUAL:** '..getVersion()..'\n**NOVA VERSÃO:** '..version, 16580705)
	log()
	log()
	log('^7Uma nova ^2Atualização ^7está disponível para o AntiCheat^7')
	log('^7Versão Atual: '..getVersion()..'^7')
	log('^7Versão Disponível: '..version..'^7')
	log()
	log('^7Iremos iniciar o download da nova versão automaticamente...')
	log()
	log()
	Wait(1200)
	SendD(LOG.general, '**UPDATE**\n\nINICIANDO ATUALIZAÇÃO DO ANTICHEAT, POR FAVOR AGUARDE...', 16580705)
	log('^7Por favor, aguarde, iremos iniciar o processo de atualização')
	log('^7Baixando nova versão...')
	log()
	if GetCurrentResourceName() == 'GCNACC' then
		log('Download cancelado automaticamente, por tratar-se de um código original da GCN')
		return
	end
	funcionando = false
	folderAC = GetResourcePath(GetCurrentResourceName())
	PerformHttpRequest(baseURL..'v1/services/gcnac/releases/'..TokenAC()..'/latest/update', function(err, result, headers)
		while err == nil do Wait(0) end
		if err == 200 then
			local dadosUpdate = json.decode(result)
			if dadosUpdate.request.status == 'success' then
				for k,v in ipairs(dadosUpdate.files) do
					if v.filename ~= 'menu.lua' and v.filename ~= 'client.lua' and v.content ~= nil then
						local fileSaved = assert(io.open(folderAC..'/src/'..v.filename, 'wb'))
						fileSaved:write(v.content)
						fileSaved:close()
						log(v.filename..' ^2Salvo')
					end
				end
				local _resname = GetCurrentResourceName()
				local loadClientFile = LoadResourceFile(_resname, 'src/client.lua')
				if loadClientFile then
					local _toremove = GetResourcePath(_resname)..'/'..'src/client.lua'
					os.remove(_toremove)
				end
				downloadNewVersion = true
			elseif dadosUpdate.request.status == 'failed' then
				if dadosUpdate.error == 'UUID inválido' then
					log('Token inválido')
					downloadNewVersion = false
					return
				elseif dadosUpdate.error == 'Licença não encontrada' then
					log('Token não encontrado ou inválido')
					downloadNewVersion = false
					return
				elseif dadosUpdate.error == 'Licença não expirada' then
					log('Token expirado ou inválido')
					downloadNewVersion = false
					return
				end
			end
		else
			downloadNewVersion = false
		end
		if not downloadNewVersion then
			log()
			log('^1Não foi possível realizar a atualização, erro no servidor. Entre em contato com o suporte')
			log()
		end
	end)
	while downloadNewVersion == nil do Wait(0) end
	if downloadNewVersion then
		log()
		log('^7AntiCheat ^2Atualizado!')
		log('^7Recomendamos que você reinicie o servidor, para que todas as atualizações funcionem corretamente.')
		log()
		SendD(LOG.general, '**UPDATE**\n\nATUALIZAÇÃO DO ANTICHEAT REALIZADA COM SUCESSO!\n\n**VERSÃO ATUAL:** '..getVersion(), 1752220)
		funcionando = true
	else
		log()
		log('^1ERRO ^7Não foi possível baixar a nova versão, por favor, entre em contato com a ^3Equipe GCN')
		log('^1ERRO ^7Não foi possível baixar a nova versão, por favor, entre em contato com a ^3Equipe GCN')
		log('^1ERRO ^7Não foi possível baixar a nova versão, por favor, entre em contato com a ^3Equipe GCN')
		log()
		SendD(LOG.general, '**ERRO NO UPDATE**\n\nNÃO FOI POSSÍVEL REALIZAR O UPDATE DO ANTICHEAT, ENTRE EM CONTATO COM A EQUIPE GCN!', 10038562)
	end
end
