--[[
	id: 2dy9eIGCQESiNcGp5ubjC
	name: SomethingOnAir
	description: Nuthin
	time1: 2021-07-09 07:47:47.658859+00
	time2: 2021-07-09 07:47:47.658869+00
	uploader: COXUW49DHK6FDh9HINHWjvIEifB86bxGcfYj9jXs
	uploadersession: PWJHbo9Mk0TGPE0SYxj5B3ElVrZO6M
	flag: f
--]]

ESX                           = nil

local PlayerLoaded

Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(1)
    end
    
    PlayerLoaded = true
  end)
---------
function AHAH()
	return Config.SomethingOnAir.. ' ' ..Config.MartinXXG.. ' ' ..Config.SuriyaMQT
end 

function Secure(Keyget)
    if Keyget == Config.SomethingOnAir.. ' ' ..Config.MartinXXG.. ' ' ..Config.SuriyaMQT then
        return true
    else 
        return false
    end
end 