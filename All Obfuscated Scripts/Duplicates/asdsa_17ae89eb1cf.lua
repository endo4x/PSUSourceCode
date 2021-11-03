--[[
	id: W1dGlCapSJcOJBcBbAdnz
	name: asdsa
	description: asdas
	time1: 2021-06-27 20:43:17.015473+00
	time2: 2021-06-27 20:43:17.015473+00
	uploader: LhfN9iiK9Db2cecrEBQespoIkKzZpz8P_ZcpxLuZ
	uploadersession: v7bIprDd2NEUA7q2xGB8-JtbxObRXg
	flag: f
--]]

ESX                = nil
ResourceName = GetCurrentResourceName()
CurrentGang = {}
SkinInUse = {}
IsLeader = {}

ShowGang = {}
ShowInvite = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent(ResourceName ..':sv:loadconfig')
AddEventHandler(ResourceName .. ':sv:loadconfig', function()
    TriggerClientEvent(ResourceName ..':cl:loadconfig',source, Config,GetSteamID(source))
    GetCurrentGang(GetSteamID(source),source)
end)

RegisterServerEvent('er_gang:sv:kick')
AddEventHandler('er_gang:sv:kick', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.kick(Config['kick'])
end)

function CheckTokenKey(token,source) 
    local xPlayer = ESX.GetPlayerFromId(source)
    if not (Config['Tokenkey'] == token) then
        xPlayer.kick(Config['kick'])
        return false
    end
    return true
end

RegisterServerEvent('er_gang:sv:JoinGang')
AddEventHandler('er_gang:sv:JoinGang', function(token,src)
    local _source = source
    if not CheckTokenKey(token,source) then return end
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('er_gang:cl:InviteAccept',src,Config['Tokenkey'])

      MySQL.Async.fetchAll('SELECT slot FROM er_gang WHERE gangname = @gangname', {
            ['@gangname'] = CurrentGang[src] 
        }, function(result)
            local data = json.decode(result[1].slot)
            if data.current == data.maximum then
                TriggerClientEvent("pNotify:SendNotification",source,
                {text = " <center> แก๊งเต็มแล้ว </center>",
                type = "alert", timeout = 5000, 
                layout = "bottomCenter"})
                TriggerClientEvent("pNotify:SendNotification",src,
                {text = " <center> แก๊งของคุณเต็มแล้ว </center>",
                type = "alert", timeout = 5000, 
                layout = "bottomCenter"})
                TriggerClientEvent('er_gang:cl:InviteAccept',src,Config['Tokenkey'])
                ShowInvite[src] = nil
                UpdateAllPlayerShowInvite()
                return
            else
                local newdata = {current = data.current + 1,maximum = data.maximum}
                MySQL.Async.execute('UPDATE er_gang SET slot = @slot WHERE gangname = @gangname', {
                    ['@gangname'] = CurrentGang[src],
                    ['@slot'] =json.encode(newdata)
                })
                MySQL.Async.execute('UPDATE users SET gangname = @gangname WHERE identifier = @identifier', {
                    ['@gangname'] = CurrentGang[src],
                    ['@identifier'] = xPlayer.identifier
                })

              
            end
           
        end)
      
        local ganglis = {sid=xPlayer.identifier ,name=xPlayer.getName()}
        MySQL.Async.fetchAll('SELECT ganglist FROM er_gang WHERE gangname = @gangname', {
            ['@gangname'] = CurrentGang[src] 
        }, function(result)
            local data = json.decode(result[1].ganglist)

            local newdata = data
            table.insert(newdata, ganglis)

            MySQL.Async.execute('UPDATE er_gang SET ganglist = @ganglist WHERE gangname = @gangname', {
                ['@gangname'] = CurrentGang[src],
                ['@ganglist'] =json.encode(newdata)
            })
        end)
        TriggerClientEvent("pNotify:SendNotification",source,
        {text = " <center> เข้าแก๊งเรียบร้อยแล้ว </center>",
        type = "alert", timeout = 5000, 
        layout = "bottomCenter"})
        TriggerClientEvent("pNotify:SendNotification",src,
        {text = " <center> ผู้เล่นเข้าแก๊งเรียบร้อยแล้ว </center>",
        type = "alert", timeout = 5000, 
        layout = "bottomCenter"})
        CurrentGang[source] = CurrentGang[src]
        IsLeader[source] = false
        TriggerClientEvent('er_gang:cl:SendCurrentGang',source,Config['Tokenkey'],CurrentGang[source],IsLeader[source])        
        local massage = '' .. xPlayer.name .. ' เข้าแก๊ง ' .. CurrentGang[src] .. ' Gang '
        TriggerEvent('mslogs:senddiscord', massage , color, source, "https://discord.com/api/webhooks/836077628855156797/zZOsc8BtKNaAvA88nH28dXRp0O78xPQTSWdricDWehyACNgOVpJFGqJeaVSayfbnKghU" )

      

      
        ShowInvite[src] = nil
        UpdateAllPlayerShowInvite()
    
end)
RegisterServerEvent('er_gang:sv:ShowInvite')
AddEventHandler('er_gang:sv:ShowInvite', function(token,coord)
    if not CheckTokenKey(token,source) then return end
    local xPlayer = ESX.GetPlayerFromId(source)
    ShowInvite[source] = {src=source,sid=GetSteamID(source),coord=coord,gangname=CurrentGang[source],name=xPlayer.getName()}
    UpdateAllPlayerShowInvite()
end)
RegisterServerEvent('er_gang:sv:DeleteShowInvite')
AddEventHandler('er_gang:sv:DeleteShowInvite', function(token)
    if not CheckTokenKey(token,source) then return end
    ShowInvite[source] = nil
    UpdateAllPlayerShowInvite()
end)
RegisterServerEvent('er_gang:sv:ShowGang')
AddEventHandler('er_gang:sv:ShowGang', function(token,coord)
  
       if not CheckTokenKey(token,source) then return end
       local xPlayer = ESX.GetPlayerFromId(source)
    ShowGang[source] = {coord=coord,gangname=CurrentGang[source],name=xPlayer.getName()}
    UpdateAllPlayerShowGang()
end)

RegisterServerEvent('er_gang:sv:DeleteShowGang')
AddEventHandler('er_gang:sv:DeleteShowGang', function(token)
       if not CheckTokenKey(token,source) then return end
    ShowGang[source] = nil
    UpdateAllPlayerShowGang()
end)

RegisterServerEvent('er_gang:sv:UpgradeSlot')
AddEventHandler('er_gang:sv:UpgradeSlot', function(token)
    local _source = source
    if not CheckTokenKey(token,source) then return end
    if not IsLeader[source] then
        TriggerClientEvent("pNotify:SendNotification",source,
        {text = " <center> คุณไม่ใช่หัวหน้าแก๊ง </center>",
        type = "alert", timeout = 5000, 
        layout = "bottomCenter"})
        return
    end
    local xPlayer = ESX.GetPlayerFromId(source)
    local perm_item = xPlayer.getInventoryItem(Config['Upgrade'].item)
    if perm_item.count > 0 then
        MySQL.Async.fetchAll('SELECT slot FROM er_gang WHERE gangname = @gangname', {
            ['@gangname'] = CurrentGang[_source] 
        }, function(result)
            local data = json.decode(result[1].slot)
            local newdata = {current = data.current,maximum = data.maximum + Config['Upgrade'].add}
            MySQL.Async.execute('UPDATE er_gang SET slot = @slot WHERE gangname = @gangname', {
                ['@gangname'] = CurrentGang[_source],
                ['@slot'] =json.encode(newdata)
            })
        end)
      
        xPlayer.removeInventoryItem(Config['Upgrade'].item, 1)

        TriggerClientEvent('er_gang:cl:UpgradeSlotSuccess',_source,Config['Tokenkey'])
        TriggerClientEvent("pNotify:SendNotification",_source,
        {text = " <center> อัพเกรด slot เรียบร้อยแล้ว</center>",
        type = "success", timeout = 5000, 
        layout = "bottomCenter"})
        return
    else
        TriggerClientEvent("pNotify:SendNotification",_source,
        {text = " <center> คุณไม่มีไอเทมอัพเกรด slot </center>",
        type = "alert", timeout = 5000, 
        layout = "bottomCenter"})
        return
    end

end)

function UpdateAllPlayerShowGang()
    TriggerClientEvent('er_gang:cl:ShowGangData',-1,Config['Tokenkey'],ShowGang)
end

function UpdateAllPlayerShowInvite()
    TriggerClientEvent('er_gang:cl:ShowInviteData',-1,Config['Tokenkey'],ShowInvite)
end


RegisterServerEvent('er_gang:sv:GetGangData')
AddEventHandler('er_gang:sv:GetGangData', function(token)
    -- print('GetGangData')
   
    local src = source
   
    if not CheckTokenKey(token,source) then return end
    if CurrentGang[src] == 'none' then
      
        TriggerClientEvent('er_gang:cl:NoGang',source,Config['Tokenkey'])
        return
      
    end
    MySQL.Async.fetchAll('SELECT * FROM er_gang WHERE gangname = @gangname', {
        		['@gangname'] = CurrentGang[src] 
    }, function(result)
        -- print(json.encode(result[1]))
        TriggerClientEvent('er_gang:cl:SendGangData',src, Config['Tokenkey'],result[1])
    
    end)
   

end)



RegisterServerEvent('er_gang:sv:CreateGang')
AddEventHandler('er_gang:sv:CreateGang', function(token,gangnamed)
    local _source = source
    if not CheckTokenKey(token,source) then return end
   

    local xPlayer = ESX.GetPlayerFromId(source)

    if CurrentGang[source] == 'none' then
    else
    TriggerClientEvent("pNotify:SendNotification",source,
        {text = " <center> คุณมีแก๊งอยู่แล้ว </center>",
        type = "alert", timeout = 5000, 
        layout = "bottomCenter"})
        return
    end
    local perm_item = xPlayer.getInventoryItem(Config['CreateGang'])
    if perm_item.count > 0 then

    else
        TriggerClientEvent("pNotify:SendNotification",source,
        {text = " <center> คุณไม่มีไอเทมสร้างแก๊ง </center>",
        type = "alert", timeout = 5000, 
        layout = "bottomCenter"})
        TriggerClientEvent('er_gang:cl:ResetCreateGang',_source,Config['Tokenkey'])
        return
    end


    MySQL.Async.fetchAll('SELECT gangname FROM er_gang WHERE gangname = @gangname', {
		['@gangname'] = gangnamed
	}, function(result)
        if result[1] == nil then
            local slot = {current = 1,maximum = 10}
            local skin = {female = {torso1=1,torso2=0}, male = {torso1=1,torso2=0}}
            local leader = {sid=xPlayer.identifier,name=xPlayer.getName()}
            local ganglis = {{sid=xPlayer.identifier ,name=xPlayer.getName()}}
            MySQL.Async.execute('INSERT INTO er_gang (gangname, leader, slot, gangskin, ganglist) VALUES (@gangname, @leader, @slot, @gangskin, @ganglist)', {
                ['@gangname'] = gangnamed,
                ['@leader'] = json.encode(leader),
                ['@slot'] = json.encode(slot),
                ['@gangskin'] = json.encode(skin),
                ['@ganglist'] = json.encode(ganglis)
            }, function(rowsChanged)
                MySQL.Async.execute('UPDATE users SET gangname = @gangname WHERE identifier = @identifier', {
                    ['@gangname'] = gangnamed,
                    ['@identifier'] = xPlayer.identifier
                })
               
                
                TriggerClientEvent("pNotify:SendNotification",_source,
                {text = " <center> สร้างแก๊งสำเร็จ </center>",
                type = "success", timeout = 5000, 
                layout = "bottomCenter"})

            end)
            CurrentGang[_source] = gangnamed
            IsLeader[_source] = true
            TriggerClientEvent('er_gang:cl:SendCurrentGang',_source,Config['Tokenkey'],CurrentGang[_source],IsLeader[_source])  
            TriggerClientEvent('er_gang:cl:GangCreateSuccessful',_source,Config['Tokenkey'])
            xPlayer.removeInventoryItem(Config['CreateGang'], 1)
        else
            TriggerClientEvent('er_gang:cl:GangCreateDupName',_source,Config['Tokenkey'])
        end
	
	end)

end)
RegisterServerEvent('er_gang:sv:LeaveGang')
AddEventHandler('er_gang:sv:LeaveGang', function(token)
    local _source = source
    if not CheckTokenKey(token,source) then return end
    CurrentGang[source] = 'none'
    MySQL.Async.execute('UPDATE users SET gangname = @gangnameupdate WHERE gangname = @gangname', {
        ['@gangname'] = CurrentGang[source],
        ['@gangnameupdate'] = 'none'
    })
    MySQL.Async.fetchAll('SELECT ganglist FROM er_gang WHERE gangname = @gangname', {
		['@gangname'] = gangname
	}, function(result)
        local ganglist = json.decode(result[1].ganglist)
        local newganglist = ganglist
        for k,v in pairs(ganglist) do
            if v.sid == sid then
                table.remove(newganglist, k)
                -- newganglist[k] = nil
                MySQL.Async.execute('UPDATE er_gang SET ganglist = @ganglist WHERE gangname = @gangname', {
                    ['@gangname'] = CurrentGang[_source],
                    ['@ganglist'] = json.encode(newganglist)
                })
                MySQL.Async.fetchAll('SELECT slot FROM er_gang WHERE gangname = @gangname', {
                    ['@gangname'] = CurrentGang[_source] 
                }, function(result)
                    local data = json.decode(result[1].slot)
                    local newdata = {current = data.current - 1,maximum = data.maximum}
                    MySQL.Async.execute('UPDATE er_gang SET slot = @slot WHERE gangname = @gangname', {
                        ['@gangname'] = CurrentGang[_source],
                        ['@slot'] =json.encode(newdata)
                    })
                end)
                return
            end
        end

	
	end)
  
end)


RegisterServerEvent('er_gang:sv:DeleteGang')
AddEventHandler('er_gang:sv:DeleteGang', function(token)
    local _source = source
       if not CheckTokenKey(token,source) then return end
    local tempcurrent = CurrentGang[source]
    if not IsLeader[source] then
        TriggerClientEvent("pNotify:SendNotification",source,
        {text = " <center> คุณไม่ใช่หัวหน้าแก๊ง </center>",
        type = "alert", timeout = 5000, 
        layout = "bottomCenter"})
        return
    end

    MySQL.Async.execute('UPDATE users SET gangname = @gangnameupdate WHERE gangname = @gangname', {
        ['@gangname'] = tempcurrent,
        ['@gangnameupdate'] = 'none'
    })
    MySQL.Async.fetchAll('SELECT ganglist FROM er_gang WHERE gangname = @gangname', {
		['@gangname'] = tempcurrent
	}, function(result)
    
       local ganglist = json.decode(result[1].ganglist)
       for k,vg in pairs(ganglist) do
        for k,v in pairs(CurrentGang) do
            if GetSteamID(k) == vg.sid then
                CurrentGang[k] = 'none'
                TriggerClientEvent('er_gang:cl:GotKickOut',k,Config['Tokenkey'])
                TriggerClientEvent("pNotify:SendNotification",k,
                {text = " <center> แก๊งถูกยุบทิ้งลงแล้ว </center>",
                type = "alert", timeout = 5000, 
                layout = "bottomCenter"})
            end
        
        end

       end
       MySQL.Async.execute('DELETE FROM er_gang WHERE gangname = @gangname', {
        ['@gangname'] = tempcurrent,
    })
	end)
  
    CurrentGang[_source] = 'none'
    IsLeader[_source] = false
    TriggerClientEvent("pNotify:SendNotification",_source,
    {text = " <center> ลบแก๊งเสร็จแล้ว </center>",
    type = "success", timeout = 5000, 
    layout = "bottomCenter"})
    TriggerClientEvent('er_gang:cl:ResetCreateGang',_source,Config['Tokenkey'])

    

end)
RegisterServerEvent('er_gang:sv:KickOut')
AddEventHandler('er_gang:sv:KickOut', function(token,sid)
    local _source = source
       if not CheckTokenKey(token,source) then return end
    if not IsLeader[_source] then
        TriggerClientEvent("pNotify:SendNotification",source,
        {text = " <center> คุณไม่ใช่หัวหน้าแก๊ง </center>",
        type = "alert", timeout = 5000, 
        layout = "bottomCenter"})
        return
    end

    if GetSteamID(_source) == sid then
        TriggerClientEvent("pNotify:SendNotification",_source,
                {text = " <center> คุณไม่สามารถเตะตัวเองออกจากแก๊งได้ </center>",
                type = "alert", timeout = 5000, 
                layout = "bottomCenter"})
                TriggerClientEvent('er_gang:cl:UpgradeSlotSuccess',_source,Config['Tokenkey'])
        return
    end

    for k,v in pairs(CurrentGang) do
        if GetSteamID(k) == sid then
            MySQL.Async.execute('UPDATE users SET gangname = @gangnameupdate WHERE identifier = @identifier', {
                ['@identifier'] = sid,
                ['@gangnameupdate'] = 'none'
            })
            CurrentGang[k] = 'none'
            TriggerClientEvent("pNotify:SendNotification",k,
                {text = " <center> คุณถูกเตะออกจากแก๊งแล้ว </center>",
                type = "alert", timeout = 5000, 
                layout = "bottomCenter"})
                local massage = '' .. GetSteamID(k) .. ' ถูกเตะออกจากแก๊ง ' .. CurrentGang[_source] .. ' Gang '
                TriggerEvent('mslogs:senddiscord', massage , color, source, "https://discord.com/api/webhooks/836077859072114748/VaycHbKfNK_JSYJO5ac53pJNgJfoX70FaFyK8FI1jYbTriA1e_53VvNtuGXADkMAseT9" )
            
            TriggerClientEvent('er_gang:cl:GotKickOut',k,Config['Tokenkey'])
            
        end

    end
    TriggerClientEvent("pNotify:SendNotification",_source,
    {text = " <center> คุณได้เตะเขาออกจากแก๊งเรียบร้อยแล้ว </center>",
    type = "success", timeout = 5000, 
    layout = "bottomCenter"})

    

    MySQL.Async.fetchAll('SELECT ganglist FROM er_gang WHERE gangname = @gangname', {
		['@gangname'] = CurrentGang[_source]
	}, function(result)
        local ganglist = json.decode(result[1].ganglist)
        local newganglist = ganglist
        for k,v in pairs(ganglist) do
            if v.sid == sid then
        
                table.remove(newganglist, k)
                -- newganglist[k] = nil
            end
        end
        MySQL.Async.execute('UPDATE er_gang SET ganglist = @ganglist WHERE gangname = @gangname', {
            ['@gangname'] = CurrentGang[_source],
            ['@ganglist'] = json.encode(newganglist)
        })
        MySQL.Async.fetchAll('SELECT slot FROM er_gang WHERE gangname = @gangname', {
            ['@gangname'] = CurrentGang[_source] 
        }, function(result)
            local data = json.decode(result[1].slot)
            local newdata = {current = data.current - 1,maximum = data.maximum}
            MySQL.Async.execute('UPDATE er_gang SET slot = @slot WHERE gangname = @gangname', {
                ['@gangname'] = CurrentGang[_source],
                ['@slot'] =json.encode(newdata)
            })
        end)

	
	end)

      
end)

  



-- MySQL.ready(function()

-- end)
-- ESX.RegisterServerCallback('esx_skin:getPlayerSkin', function(source, cb)
-- 	local xPlayer = ESX.GetPlayerFromId(source)

-- 	MySQL.Async.fetchAll('SELECT skin FROM users WHERE identifier = @identifier', {
-- 		['@identifier'] = xPlayer.identifier
-- 	}, function(users)
-- 		local user, skin = users[1]

-- 		local jobSkin = {
-- 			skin_male   = xPlayer.job.skin_male,
-- 			skin_female = xPlayer.job.skin_female
-- 		}

-- 		if user.skin then
-- 			skin = json.decode(user.skin)
-- 		end

-- 		cb(skin, jobSkin)
-- 	end)
-- end)

function GetCurrentGang(identifier,source)
    
    MySQL.Async.fetchAll('SELECT gangname FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(result)
        CurrentGang[source] = result[1].gangname
        if CurrentGang[source] == 'none' then
            IsLeader[source] = false
            TriggerClientEvent('er_gang:cl:SendCurrentGang',source,Config['Tokenkey'],CurrentGang[source],IsLeader[source])  
            return
        end
   
        MySQL.Async.fetchAll('SELECT leader FROM er_gang WHERE gangname = @gangname', {
            ['@gangname'] =  CurrentGang[source]
        }, function(x)
            local data = json.decode(x[1].leader)
            if data and data.sid then
                if data.sid == identifier then
                    IsLeader[source] = true
                else
                    IsLeader[source] = false
                end
            else
                IsLeader[source] = false
        end
            TriggerClientEvent('er_gang:cl:SendCurrentGang',source,Config['Tokenkey'],CurrentGang[source],IsLeader[source])        
        end)
    end)
end

RegisterCommand(Config['Command'].SetSkin , function(source, args, rawCommand)
     
   if not IsLeader[source] then
    TriggerClientEvent("pNotify:SendNotification",source,
    {text = " <center> คุณไม่ใช่หัวหน้าแก๊ง </center>",
    type = "alert", timeout = 5000, 
    layout = "bottomCenter"})
    return
   end

   if CurrentGang[source] == 'none' then
    TriggerClientEvent("pNotify:SendNotification",source,
    {text = " <center> คุณไม่มีแก๊ง </center>",
    type = "alert", timeout = 5000, 
    layout = "bottomCenter"})
    return
   else
   

    local sex = tostring(args[1])
    local arg2 = tonumber(args[2])
    local arg3 = tonumber(args[3])
    if not (type(arg2) == "number") then
        TriggerClientEvent("pNotify:SendNotification",source,
        {text = " <center> ใช้คำสั่งไม่ถูกต้อง </center>",
        type = "alert", timeout = 5000, 
        layout = "bottomCenter"})
        return
    end

    if not (type(arg3) == "number") then
        TriggerClientEvent("pNotify:SendNotification",source,
        {text = " <center> ใช้คำสั่งไม่ถูกต้อง </center>",
        type = "alert", timeout = 5000, 
        layout = "bottomCenter"})
        return
    end



    if sex == 'male' then
        MySQL.Async.fetchAll('SELECT gangskin FROM er_gang WHERE gangname = @gangname', {
            ['@gangname'] = CurrentGang[source]
        }, function(result)
            local CurrentGangSkin = json.decode(result[1].gangskin)          
            local new = {female = {torso1=CurrentGangSkin.female.torso1,torso2=CurrentGangSkin.female.torso2}, male = {torso1=arg2,torso2=arg3}}
            MySQL.Async.execute('UPDATE er_gang SET gangskin = @gangskin WHERE gangname = @gangname', {
                ['@gangskin'] = json.encode(new),
                ['@gangname'] = CurrentGang[source]
            })
        end)

        

    elseif sex == 'female' then
        MySQL.Async.fetchAll('SELECT gangskin FROM er_gang WHERE gangname = @gangname', {
            ['@gangname'] = CurrentGang[source]
        }, function(result)
            local CurrentGangSkin = json.decode(result[1].gangskin)
            local new = {male = {torso1=CurrentGangSkin.male.torso1,torso2=CurrentGangSkin.male.torso2}, female = {torso1=arg2,torso2=arg3}}
            MySQL.Async.execute('UPDATE er_gang SET gangskin = @gangskin WHERE gangname = @gangname', {
                ['@gangskin'] = json.encode(new),
                ['@gangname'] = CurrentGang[source]
            })
        end)

    else
    TriggerClientEvent("pNotify:SendNotification",source,
    {text = " <center> ใช้คำสั่งไม่ถูกต้อง </center>",
    type = "alert", timeout = 5000, 
    layout = "bottomCenter"})
    return
    end
   
  
    TriggerClientEvent("pNotify:SendNotification",source,
    {text = " <center> เซ็ตชุดแก๊งสำเร็จแล้ว </center>",
    type = "success", timeout = 5000, 
    layout = "bottomCenter"})
   end
    


end, false) 

RegisterCommand(Config['Command'].Invite , function(source, args, rawCommand)
    if not IsLeader[source] then
        TriggerClientEvent("pNotify:SendNotification",source,
        {text = " <center> คุณไม่ใช่หัวหน้าแก๊ง </center>",
        type = "alert", timeout = 5000, 
        layout = "bottomCenter"})
        return
    end

end, false) 

RegisterCommand(Config['Command'].UseGangSkin , function(source, args, rawCommand)
    local _source = source
    if CurrentGang[source] == 'none' then
        TriggerClientEvent("pNotify:SendNotification",source,
        {text = " <center> คุณไม่มีแก๊ง </center>",
        type = "alert", timeout = 5000, 
        layout = "bottomCenter"})
        return
    end
	MySQL.Async.fetchAll('SELECT skin FROM users WHERE identifier = @identifier', {
		['@identifier'] = GetSteamID(_source)
	}, function(users)
		local skin = json.decode(users[1].skin)
        if SkinInUse[_source] == nil then
            SkinInUse[_source] = false
        end
        if  SkinInUse[_source] then
           
            TriggerClientEvent('skinchanger:loadSkin',_source, skin)
            SkinInUse[_source] = false
        else

       
        if skin.sex == 0 then
            MySQL.Async.fetchAll('SELECT gangskin FROM er_gang WHERE gangname = @gangname', {
                ['@gangname'] = CurrentGang[_source]
            }, function(result)
            
                local CurrentGangSkin = json.decode(result[1].gangskin)
                TriggerClientEvent('skinchanger:loadSkin',source, {sex = 0,torso_1=CurrentGangSkin.male.torso1,torso_2=CurrentGangSkin.male.torso2})

            end)
        elseif skin.sex == 1 then
            MySQL.Async.fetchAll('SELECT gangskin FROM er_gang WHERE gangname = @gangname', {
                ['@gangname'] = CurrentGang[_source]
            }, function(result)
                local CurrentGangSkin = json.decode(result[1].gangskin)
                TriggerClientEvent('skinchanger:loadSkin',_source, {sex = 1,torso_1=CurrentGangSkin.female.torso1,torso_2=CurrentGangSkin.female.torso2})

            end)
        end
        end
	end)

   

end, false) 
   

function GetSteamID(src)
	local sid = GetPlayerIdentifiers(src)[1] or false

	if (sid == false or sid:sub(1,5) ~= "steam") then
		return false
	end

	return sid
end


RegisterServerEvent('mslogs:senddiscord')
AddEventHandler('mslogs:senddiscord', function(text, color, src, discord_webhook)
    sendToDiscord(text, color, src, discord_webhook)
end)

function sendToDiscord(name, color, src, discord_webhook)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    local ids = ExtractIdentifiers(src)

    local connect = {
          {
              ["color"] = color,
              ["title"] = "**".. name .."**",
              ["description"] = "Identifier:** ".. identifiers.steam .."**\nLink Steam: **https://steamcommunity.com/profiles/".. tonumber(ids.steam:gsub("steam:", ""),16) .."**\n Rockstar: **".. identifiers.license .."**\n Discord: <@".. ids.discord:gsub("discord:", "") .."> |  Discord ID: **".. identifiers.discord .."** \n IP Address: **".. GetPlayerEndpoint(src) .."**",
              ["footer"] = {
                  ["text"] = "เวลา: ".. os.date ("%X") .." - ".. os.date ("%x") .."",
              },
          }
      }
    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
  end



function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end