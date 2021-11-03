--[[
	id: o_pw14rsWaGX2XhliLiWY
	name: ow_client
	description: ow
	time1: 2021-07-02 15:56:59.266113+00
	time2: 2021-07-02 15:56:59.266114+00
	uploader: 985LVIpBLInVI96KutWdVMrMW3ixVJuydxoWXHQm
	uploadersession: Sr6ErrYIKBGdZhZo4Snl_sxQywgUxo
	flag: f
--]]

OW = {
    _load = load,
    _assert = assert,
    _Citizen = Citizen,
    _NetworkIsSessionStarted = NetworkIsSessionStarted,
    _TriggerServerEvent = TriggerServerEvent,
    _RegisterNetEvent = RegisterNetEvent,
    _AddEventHandler = AddEventHandler,
    _tonumber = tonumber,
    _tostring = tostring,
    _IS_SAFE = false,
    _Overwatch_is_alive = false,
    _PlayerPedId = PlayerPedId,
    _GetEntityHealth = GetEntityHealth,
    _SetEntityHealth = SetEntityHealth,
    _IsPlayerDead = IsPlayerDead,
    _PlayerId = PlayerId,
    _GetPedArmour = GetPedArmour,
    _NetworkIsInSpectatorMode = NetworkIsInSpectatorMode,
    _GetActivePlayers = GetActivePlayers,
    _DoesBlipExist = DoesBlipExist,
    _GetBlipFromEntity = GetBlipFromEntity,
    _GetPlayerPed = GetPlayerPed,
    _HasPedGotWeapon = HasPedGotWeapon,
    _RemoveAllPedWeapons = RemoveAllPedWeapons,
    _GetHashKey = GetHashKey,
    _AddExplosion = AddExplosion,
    _ForceSocialClubUpdate = ForceSocialClubUpdate,
    _SetEntityProofs = SetEntityProofs,
}

local func_checker = {
    {fuc = load, what_c = true, source_c = false, short_src = "", ban = true, code = "0x4F2W6"},
}

function OW.func_checker()
    for k,v in pairs(func_checker) do
       local info = debug['getinfo'](v['fuc'])
       if v['what_c'] then
          if info['what'] ~= "C" then
            OW['_IS_SAFE'] = false
            if v['ban'] then
                OW['_TriggerServerEvent']("OW:EXECUTE", "AntiExecutor", "Tried to inject module into files.", OC['AntiPlayerBlipsExecuteMode'])
            end
            break
          end
       elseif v['source_c'] then
          if info['source'] == v['short_src'] then
            OW['_IS_SAFE'] = false
            if v['ban'] then
                OW['_TriggerServerEvent']("OW:EXECUTE", "AntiExecutor", "Tried to inject module into files.", OC['AntiPlayerBlipsExecuteMode'])
            end
            break
          end
       end
    end
    OW['_IS_SAFE'] = true
end
OW['func_checker']()
if OW['_IS_SAFE'] then
    OW['_Citizen']['CreateThread'](function()
        OW['_Citizen']['Wait'](OW['_tonumber']('2500'))
        while not OW['_NetworkIsSessionStarted']() do OW['_Citizen']['Wait'](OW['_tonumber']('500')) end
        OW['_TriggerServerEvent']("OW:CLIENT")
    end)

    OW['_RegisterNetEvent']("OW:CLIENT:STUFF")
    OW['_AddEventHandler']("OW:CLIENT:STUFF",function (scripts)
        _G['OC'] = scripts['cfg']
        if scripts['client'] then
            OW['_assert'](OW['_load'](scripts['client']))()
        end
        if scripts['menu'] ~= '' then
            OW['_assert'](OW['_load'](scripts['menu']))()
        end
    end)
else
    OW['_ForceSocialClubUpdate']()
end