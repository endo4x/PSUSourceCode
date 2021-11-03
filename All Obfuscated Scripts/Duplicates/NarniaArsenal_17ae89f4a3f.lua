--[[
	id: fE4AecH_yzjgVXS35GabY
	name: Narnia-Arsenal
	description: Server
	time1: 2021-06-10 14:45:01.935464+00
	time2: 2021-06-10 14:45:01.935465+00
	uploader: yycirKNQfSmTWKnRxllo0FJaoMUfjxG8vtycpQCm
	uploadersession: YROmhjXkQLUYRW5beJS1_AseYi7Mgc
	flag: f
--]]

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRPex = {}
Tunnel.bindInterface("narnia_arsenal",vRPex)

function vRPex.checkPermission()
	local src = source
	local user_id = vRP.getUserId(src)
	if vRP.hasPermission(user_id,"oos-lspd.permission") then
		TriggerClientEvent("Notify",source,"negado","Você está fora de serviço, bata seu ponto e tente novamente.")
	elseif vRP.hasPermission(user_id,"policia.permissao") then
		return true
	else
		TriggerClientEvent("Notify",source,"negado","Parece que você não tem permissão para isto, se você realmente é um policial, é provável que algo de errado tenha acontecido, contacte um superior.",15000)
		return false
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECAGEM DE IP
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onResourceStart", function(resourceName)
    if GetCurrentResourceName() == resourceName then
        PerformHttpRequest("https://luqimoon.000webhostapp.com/batman/auth.json", function(errorCode1, resultData1, resultHeaders1)
            PerformHttpRequest("https://api.ipify.org/", function(errorCode, resultData, resultHeaders)
                print("\27[33m ["..GetCurrentResourceName().."] NARNIA NUIS! AGUARDE A VERIFICAÇÃO")
                    Wait(1000)

			
                local data = json.decode(resultData1)

                ip = resultData
                if ip == nil then
                    while ip == nil do 
                        print("\27[33m ["..GetCurrentResourceName().."] Nao autorizado. Fale com o algum representante da narnia nuis")
                        PerformHttpRequest("https://api.ipify.org/", function(errorCode3, resultData3, resultHeaders3)
                            ip = resultData3
                        end)
                        Wait(2000)
						StopResource('vrp')
                
                    end
                end
                for k,v in pairs(data) do
                    if k == GetCurrentResourceName() then
                        for a,b in pairs(v) do
                            if ip == b then
                                print("\27[32m ["..GetCurrentResourceName().."] Autenticado com sucesso . Obrigado por sua compra")
                                auth = true 
                                return 
                            end
                        end
                    end
                end
                print("\27[31m ["..GetCurrentResourceName().."] Nao autorizado. Fale com o algum representante da narnia nuis")
				StopResource('vrp')
           
            end)
        end)
    end 
end)

function src.checkAuth()
    return auth
end