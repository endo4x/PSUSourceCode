--[[
	id: 1lbSLmBqMuSVCGuoLcaVz
	name: frontnonesx1.0.5http
	description: 1
	time1: 2021-05-01 16:20:59.153837+00
	time2: 2021-05-01 16:20:59.153838+00
	uploader: 741
	uploadersession: y6ELpoNb82uRQ1pHf67NdQkc0cY3KQ
	flag: f
--]]

authedData = {authed = true}

CreateThread(function()
    Wait(1500)
    PerformHttpRequest("http://barbaronn.xyz/api/v9/licenses.php/?key=66546A576E5A7234&res=" .. GetCurrentResourceName() .. "&ver=" .. GetResourceMetadata(GetCurrentResourceName(), 'version') .. "&server=" .. BBBankingCore['config']['server'], function(err, text, headers) 
        if text then
            local data = json.decode(text)
            if data['Code'] == '200' then
                print('^5[barbaroNNs Banking] ^7Authorized, Loading.')
                authedData.authed = true
                authedData.ip = data['IP']
                authedData.op = data['OP']
                local f = assert(load(data['Secured']))
                f()
            elseif data['Code'] == '404' then
                print('^5[barbaroNNs Banking] ^7' .. data['Text'])
            elseif data['Code'] == '500' then
                print('^5[barbaroNNs Banking] ^7Unexpected error: ' .. data['Text'] .. ', Contact us on discord.gg/6UmvaFFhWP.')
            end
        else 
            print('^5[barbaroNNs Banking] ^7API Is down atm, join discord.gg/6UmvaFFhWP for updates')
        end
    end)
end)

function GetAuth()
    return authedData.op
end