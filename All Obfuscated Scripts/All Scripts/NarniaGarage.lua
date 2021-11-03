--[[
	id: WEgROMXHWO5IOwKgO3Won
	name: Narnia Garage
	description: Narnia Garage
	time1: 2021-06-07 14:54:39.745525+00
	time2: 2021-06-07 14:54:39.745526+00
	uploader: yycirKNQfSmTWKnRxllo0FJaoMUfjxG8vtycpQCm
	uploadersession: YROmhjXkQLUYRW5beJS1_AseYi7Mgc
	flag: f
--]]

print('Hello World!')AddEventHandler("onResourceStart", function(resourceName)
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