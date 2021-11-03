--[[
	id: pmEJ-ozqaYeOIIujffbZh
	name: test
	description: test
	time1: 2021-06-30 14:33:25.67365+00
	time2: 2021-06-30 14:33:25.673651+00
	uploader: 8kOnmlWT91Tj7N60yzYe4KBB9bxP4-VPgOjxRTr3
	uploadersession: 9S7HqAZaY8kR-7kzAvMBhqn87R_i29
	flag: f
--]]

function initScript()



PUT RUNNING CODE HERE



end

-- Main Driver Code (Authoriza -> initScript)
PerformHttpRequest("http://ip.42.pl/raw", function (errorCode, resultData, resultHeaders)
    if errorCode==200 then
    	current_ip = tostring(resultData)

    	if current_ip then
    		PerformHttpRequest("https://geekbuddys.se/applications/nexus/interface/licenses/?info&key=" .. Config.LicenseKey, function (errorCode, resultData, resultHeaders)
			    if errorCode==200 then
			    	if string.find(tostring(resultData), '"ip":"') then
			    		if string.find(tostring(resultData), current_ip) then
				            print("License is Verified!")
				            initScript()
				        else
				        	print("License is Unverified!")
				        end
			        else
			        	print("Looks Like LicenseKey has not been activated!")
			        	print("Activating Now with IP: " .. current_ip)
			        	PerformHttpRequest("https://geekbuddys.se/applications/nexus/interface/licenses/?activate&key=" .. Config.LicenseKey, function (errorCode, resultData, resultHeaders)
						    if errorCode==200 then
						    	if string.find(tostring(resultData), '"response":"OKAY"') then
						    		print("Activation Successful!, Thank you purchasing!")
						    		print("Initializing Script...")
						    		initScript()
						        else
						        	print("[Geekbuddys] Looks like your licensekey is malformed or expired, Contact Geekbuddys.se!")						        	
						        end
						    else
						    	print("[Geekbuddys] Faild to connect to licenses server.")
						    end
						end)
			        end			        
			    else
			    	print("[Geekbuddys] Faild to connect to licenses server.")
			    end
			end)
		else
			print("[Geekbuddys] Faild to get your server ip.")
		end
    else
    	print("[Geekbuddys] Failed to connect IP check server.")
    end
end)