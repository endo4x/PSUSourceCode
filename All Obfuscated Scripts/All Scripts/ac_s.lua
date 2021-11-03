--[[
	id: 1GYMeE13Nj6YP-suwBenZ
	name: ac_s
	description: obf
	time1: 2021-05-19 10:39:35.91693+00
	time2: 2021-05-19 10:39:35.91693+00
	uploader: pCh_NhSvXitERgk0T7a_Ikeznc7mCEm_O2gPBHyj
	uploadersession: F9lGpXdBUQ5swAcHJHzvsEJWUfllE7
	flag: f
--]]

local _blockedClientEvents = {
    "gcPhone:_internalAddMessage",
    "gcPhone:tchat_channel",
    "esx_mafiajob:confiscatPlayerItem",
    "lscustoms:payGarage",
    "vrp_slotmachine:server:2",
    "esx_jobs:caution",
    "give_back",
    "esx_fueldelivery:pay",
    "esx_carthief:pay",
    "esx_godirtyjob:pay",
    "esx_pizza:pay",
    "esx_ranger:pay",
    "esx_garbagejob:pay",
    "esx_truckerjob:pay",
    "AdminMenu:giveBank",
    "AdminMenu:giveCash",
    "esx_gopostaljob:pay",
    "esx_banksecurity:pay",
    "esx_slotmachine:sv:2",
    "esx:giveInventoryItem",
    "NB:recruterplayer",
    "esx_billing:sendBill",
    "esx_jailer:sendToJail",
    "esx_jail:sendToJail",
    "js:jailuser",
    "esx-qalle-jail:jaillayer",
    "esx_dmvschool:pay",
    "LegacyFuel:PayFuel",
    "OG_cuffs:cuffCheckNearest",
    "esx_tankerjob:pay",
    "esx_vehicletrunk:giveDirty",
    "gambling:spend",
    "AdminMenu:giveDirtyMoney",
    "esx_moneywash:deposit",
    "esx_moneywash:withdraw",
    "mission:completed",
    "truckerJob:success",
    "99kr-burglary:addMoney",
    "esx_jailer:unjailTime",
    "esx_ambulancejob:revive",
    "DiscordBot:playerDied",
    "hentailover:xdlol",
    "antilynx8:anticheat",
    "antilynxr6:detection",
    "esx_society:getOnlinePlayers",
    "antilynx8r4a:anticheat",
    "antilynxr4:detect",
    "js:jailuser",
    "ynx8:anticheat",
    "lynx8:anticheat",
    "adminmenu:allowall",
    "h:xd",
    "ljail:jailplayer",
    "adminmenu:setsalary",
    "adminmenu:cashoutall",
    "paycheck:bonus",
    "paycheck:salary",
    "HCheat:TempDisableDetection",
    "esx_drugs:processCannabis",
    "esx-qalle-hunting:reward",
    "esx-qalle-hunting:sell",
    "BsCuff:Cuff696999",
    "veh_SR:CheckMoneyForVeh",
    "esx_carthief:alertcops",
    "mellotrainer:adminTempBan",
    "mellotrainer:adminKick",
    "esx_society:putVehicleInGarage"
}

local Triggered = false

for _, eventName in pairs(_blockedClientEvents) do
    AddEventHandler(
        eventName,
        function()
            if Triggered == true then
                CancelEvent()
                return
            end
            TriggerServerEvent(
                "BlacklistAC:ClientDetection",
                "Blocked client event: `" .. eventName .. "`",
                "Blocked event",
                true
            )
            Triggered = true
        end
    )
end

RegisterNetEvent("BlacklistAC:ClearObjects")
AddEventHandler(
    "BlacklistAC:ClearObjects",
    function()
        local cObject = GetGamePool("CObject")
        for _, obj in pairs(cObject) do
            NetworkRequestControlOfEntity(obj)

            while not NetworkHasControlOfEntity(obj) do
                Wait(500)
            end
            DetachEntity(obj, 0, false)

            SetEntityCollision(object, false, false)
            SetEntityAlpha(obj, 0.0, true)
            SetEntityAsMissionEntity(obj, true, true)
            SetEntityAsNoLongerNeeded(obj)
            DeleteEntity(obj)
        end
    end
)

RegisterNetEvent("BlacklistAC:Blacklist:SetPlayerModel")
AddEventHandler(
    "BlacklistAC:Blacklist:SetPlayerModel",
    function()
        local defaultPed = "a_m_y_skater_01"
        RequestModel(defaultPed)
        while not HasModelLoaded(defaultPed) do
            Wait(500)
        end
        SetPlayerModel(PlayerId(), defaultPed)
        SetModelAsNoLongerNeeded(defaultPed)
        notification("Blacklisted Player Model")
    end
)

function notification(message)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(message)
    EndTextCommandThefeedPostTicker(true, false)
end

RegisterNetEvent("notify")
AddEventHandler(
    "notify",
    function(message)
        notification(message)
    end
)

AddEventHandler(
    "onClientResourceStop",
    function(resource)
        TriggerServerEvent(
            "BlacklistAC:ClientDetection",
            "Stopped resource: `" .. resource .. "`",
            "Invalid resource list",
            false
        )
    end
)

AddEventHandler(
    "onClientMapStart",
    function()
        TriggerEvent(
            "chat:addSuggestion",
            "/kick",
            "Kick specified player with optional reason",
            {
                {name = "Player ID", help = "Player Server ID"},
                {name = "reason", help = "Reason for kick"}
            }
        )
        TriggerEvent(
            "chat:addSuggestion",
            "/freeze",
            "Freeze specified player",
            {
                {name = "Player ID", help = "Player Server ID"}
            }
        )
    end
)
