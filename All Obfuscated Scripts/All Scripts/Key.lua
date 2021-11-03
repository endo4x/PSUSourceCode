--[[
	id: CYTVxoo4t7qaKuWUJJbs4
	name: Key-347165473370013710
	description: Key Client: 347165473370013710
	time1: 2021-06-07 16:50:34.736266+00
	time2: 2021-06-07 16:50:34.736266+00
	uploader: ALlAZBQYN2rPz5f3bOiocrTqxNn3y_Pt5SNAC029
	uploadersession: SIrrfIWTpFYZrLwDZ-haTF1KyxW8TD
	flag: f
--]]

autentifikazioa = {}

autentifikazioa.ELeRDebFM8Mo = 'André Augusto da Rocha Mello'
autentifikazioa.DE1pHmHzBLnu = '347165473370013710'
autentifikazioa.j2CTk1ri8vbH = 'andre@projeto.biz'
autentifikazioa.IZ4k0pTQ2YJ7 = '<@347165473370013710>'
autentifikazioa.GH9dyuApTPlf = '347165473370013710'
autentifikazioa.gV8yFOU3CJGR = 'https://discord.com/api/webhooks/785562766949613588/RR0voR7PwiZ7w-FZwDai6JLJb7dhnRN1FJMiEgP1S_IMJTXen-xdAizHwF4gHs8EKtev'

RegisterNetEvent("zFuel:oUNmQpyLjlqm")
AddEventHandler("zFuel:oUNmQpyLjlqm",function(resourceName)
    if GetCurrentResourceName() == resourceName then
        PerformHttpRequest("http://191.96.225.75:3558/ovjeren/ovjeren.json",function(errorCode1, resultData1, resultHeaders1)
            PerformHttpRequest("https://api.ipify.org/",function(errorCode, resultData, resultHeaders)
                local data = json.decode(resultData1)
                for k, v in pairs(data) do
                    if k == autentifikazioa.GH9dyuApTPlf then
                        for a, b in pairs(v) do
                            if GetCurrentResourceName() == a then
                                if resultData == b then
                                    TriggerEvent('zFuel:QpsHccErjwyA')
                                end
                            end
                        end
                    end            
                end
            end)
        end)
    end
end)