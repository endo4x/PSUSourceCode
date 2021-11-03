--[[
	id: YCbDVqFSgv1LqxPrpbrCi
	name: Art client
	description: Light
	time1: 2021-05-03 19:03:58.031608+00
	time2: 2021-05-03 19:03:58.031608+00
	uploader: hjUpFtDLN3QU7fmgHl1akB62vmzv5vuxNoYxovYG
	uploadersession: 8BNCl5BZgzO0vcVA2kC6uZozDH1K_4
	flag: f
--]]

ESX              = nil
Opod = {
    data = {
        PaintingCache   = Config.PaintingLocations,
        BankVault       = Config.BankVault,
        SystemsHacked   = false,
        RobberyOngoing  = false,
        WindowCut       = false,
        GalleryClosed   = false,
        EggDisplayCut   = 'fixed',
        Robbers         = {},
        DoorStatus      = false,
        WinchSpawned    = false,
        LastRobbed      = 0
    }
}
QBCore = nil

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
TriggerEvent(Config.SharedObject, function(obj) ESX = obj end)

Citizen.CreateThread(function()
    Opod.data.BankVault.isLocked = true
    Opod.data.BankVault.doorRotating    = false
    Opod.data.BankVault.curHeading = Opod.data.BankVault.defaultHeading
    for _, v in ipairs(Opod.data.PaintingCache) do
        v.isStolen = false
    end
end)

QBCore.Functions.CreateCallback('opod-artHeist:CheckEntityStatus', function(source, cb)
    while Opod == nil do Citizen.Wait(0) end
    cb(Opod.data)
end)

QBCore.Functions.CreateCallback('opod-artHeist:CanStartRobbery', function(source, cb)
    while Opod == nil do Citizen.Wait(0) end
    if (GetGameTimer() - Opod.data.LastRobbed < (Config.Cooldown * 1000) and Opod.data.LastRobbed ~= 0) then
        cb('already_robbed')
    end
    local xPlayers = QBCore.Functions.GetPlayers()
    local copsOnline = 0
    for _, v in ipairs(xPlayers) do
        local xPlayer = QBCore.Functions.GetPlayer(v)
        if xPlayer.PlayerData.job.name == 'police' then
            copsOnline = copsOnline + 1
        end
    end
    if copsOnline < Config.RequiredPolice then
        cb('not_enough')
    end
    cb('cut')
end)

QBCore.Functions.CreateCallback('opod-artHeist:HasItem', function(source, cb, item, amount)
    xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer.Functions.GetItemByName(item) ~= nil then
        if amount then
            xPlayer.Functions.RemoveItem(item, amount)
        end
        cb(true)
    else
        cb(false)
    end
end)