--[[
	id: jB9OSircRF7xcE9jmqfpN
	name: License key lua
	description: License key lua
	time1: 2021-05-24 02:35:56.061059+00
	time2: 2021-05-24 02:35:56.06106+00
	uploader: fBZ7JE4HlNXVYKdmQhUI8c0AeYPNu-IoVaUNGlsE
	uploadersession: MhzULNaGxjfRzpekKGntbkcuVgfNei
	flag: f
--]]

CreateThread(function()
setauthorized('false')
PerformHttpRequest('https://api.ipify.org/?format=json', function(err, text, headers)	
	local asd = json.decode(text)

    if asd.ip == '213.181.201.186' then
		print('^2 Hitelesités sikeres ^0')
		setauthorized('true')
    else
      print('^1 Valami probléma van a hitelesitéssel ^0')
	  setauthorized('false')
      --Wait(12000)
      --os.exit()
    end
end, 'GET', "")
end)

function setauthorized(ertek)
SaveResourceFile(GetCurrentResourceName(), "authorized/authorized.json", ertek, -1)
end

function getauthorized()
	local success = LoadResourceFile(GetCurrentResourceName(), "authorized/authorized.json")
	return success
end