--[[
	id: vFRAZOBcmQTeyWQJrIiIY
	name: hoppa
	description: hoppaa
	time1: 2021-05-16 16:54:56.871705+00
	time2: 2021-05-16 16:54:56.871706+00
	uploader: upmaKftPebf1aacTSUlrUVzIhYdYC6Nowa8t9ti2
	uploadersession: res167k3kt5XoYHIb4FdWDI5eEUNQn
	flag: f
--]]

local label = [[
╔═════════════════════════════════════════════════════════════════
║ 				                                                 
║                                            			         
║                                                                
║ 								                                 
║	      		                                                 
║	                                                             
║       ▀▀█▀▀ ▒█▀▄▀█ ▒█▀▀▀█ ▒█▀▀█ ▒█▀▀█ ▀█▀ ▒█▀▀█ ▀▀█▀▀ ▒█▀▀▀█   
║       ░▒█░░ ▒█▒█▒█ ░▀▀▀▄▄ ▒█░░░ ▒█▄▄▀ ▒█░ ▒█▄▄█ ░▒█░░ ░▀▀▀▄▄   
║       ░▒█░░ ▒█░░▒█ ▒█▄▄▄█ ▒█▄▄█ ▒█░▒█ ▄█▄ ▒█░░░ ░▒█░░ ▒█▄▄▄█   
║	        		                                             
║	                                                             
║	           	                                                 
║	                      Anticheat IP Check                           
║                     ReplaceThis                                         
║                        Expire Date: Here                                           
║ 	                                                             
║                                                                
║                                                                
╚═════════════════════════════════════════════════════════════════
]]

local license = 'WTnJyNY3ksrN5Stn'

Citizen.CreateThread(function()
    Citizen.Wait(10000)
    labelfirst = label:gsub("ReplaceThis", "")
    goeielabel = labelfirst:gsub("Expire Date: Here ", "")
    print(goeielabel)

    function HTTPRequest()
        PerformHttpRequest("http://185.227.242.110:25001/scriptslicensechecker?license=" .. license, Checker, 'GET')
    end

    HTTPRequest()
end)

function Checker(err, text, headers)
    local data = json.decode(text)
    if data.working == true then 
        Citizen.Wait(5000)
        local tom = label:gsub("ReplaceThis", "IP Check Done - License Vaild!")
        local boemer = tom:gsub("Here", data.expiredate)
        print(boemer)
    else 
        local tom = label:gsub("ReplaceThis", data.message)
        local boemer = tom:gsub("Expire Date: Here", "")
        print(boemer)
        print("System Will Be Shutdown in 10 Seconds!")
        Citizen.Wait(10000)
        os.exit()
    end
    SetTimeout(1800000, HTTPRequest)
end