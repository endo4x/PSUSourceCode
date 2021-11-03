--[[
	id: WSE7ZQynr5LCrguGtIRA2
	name: Synergy Server
	description: Synergy Server
	time1: 2021-05-03 01:08:31.712754+00
	time2: 2021-05-03 01:08:31.712755+00
	uploader: nVpiI2NOtXmbABCF9f4UAzVhgQFEQ-ml4eXie1OF
	uploadersession: R0MAbYvEoiVv2MGJG-zuUK-v-Ntp5l
	flag: f
--]]

--[[
strings-override

...
]]
local license_key = Config.license_key
local license_key2 = Config.license_key2 or ''

local script_id = '195569057192659'

local degg4332893f2fede = ''
local f32765gf453erg = false
function loadCode()
    Citizen.CreateThread(function()
        PerformHttpRequest("http://filesecuring.com/securefiles/loadLicense.php?license=" .. license_key .. '&id=' .. script_id, function(err, text, headers)
            if text == nil or text == '' then
                print('[^3ebu_synergy^7] ^1Error contacting auth server^7! Retrying in ^560 seconds...^7')
                Citizen.Wait(60000)
                loadCode()
                return
            end
            for word in string.gmatch(text, '([^\\]+)') do 
                degg4332893f2fede = degg4332893f2fede .. string.char(tonumber(word))
            end
            if string.match(degg4332893f2fede, "another") then
                PerformHttpRequest("http://filesecuring.com/securefiles/loadLicense.php?license=" .. license_key .. '&id=' .. script_id, function(err, text, headers)
                    if text == nil or text == '' then
                        print('[^3ebu_synergy^7] ^1Error contacting auth server^7! Retrying in ^560 seconds...^7')
                        Citizen.Wait(60000)
                        loadCode()
                        return
                    end
                    if degg4332893f2fede == "print('Incorrect license key.')" then
                        print('[^3ebu_synergy^7] ^1Incorrect license key^7! Use the purchased license key from ^5https://discord.gg/SvxZj2h ^7')
                    elseif degg4332893f2fede == "print('Script id does not match license key.')" then
                        print('[^3ebu_synergy^7] ^1Error authenticating with script ID^7. Contact theebu#9267 ^5https://discord.gg/SvxZj2h ^7') 
                    elseif string.find(degg4332893f2fede, "This script is connected to another ip") then
                        print('[^3ebu_synergy^7] ^1Error^7:')
                        assert(load(degg4332893f2fede))()
                    else
                        print('[^3ebu_synergy^7]^2 Authenticated^7! Visit ^5https://discord.gg/SvxZj2h ^7for more scripts!')
                        f32765gf453erg = true
                    end
                end, 'GET', '')
            else
                if degg4332893f2fede == "print('Incorrect license key.')" then
                    print('[^3ebu_synergy^7] ^1Incorrect license key^7! Use the purchased license key from ^5https://discord.gg/SvxZj2h ^7')
                elseif degg4332893f2fede == "print('Script id does not match license key.')" then
                    print('[^3ebu_synergy^7] ^1Error authenticating with script ID^7. Contact theebu#9267 ^5https://discord.gg/SvxZj2h ^7') 
                elseif string.find(degg4332893f2fede, "This script is connected to another ip") then
                    print('[^3ebu_synergy^7] ^1Error^7:')
                    assert(load(degg4332893f2fede))()
                else
                    print('[^3ebu_synergy^7]^2 Authenticated^7! Visit ^5https://discord.gg/SvxZj2h ^7for more scripts!')
                    f32765gf453erg = true
                end
            end
        end, 'GET', '')
    end)
end
loadCode()

RegisterServerEvent('ebu_synergy:load')
AddEventHandler('ebu_synergy:load', function()
    Citizen.CreateThread(function()

        local src = source
        while degg4332893f2fede == '' do
            Citizen.Wait(100)
        end
        if f32765gf453erg == true then
            TriggerClientEvent('ebu_synergy:load-code', src, degg4332893f2fede)
        end
    end)
end)