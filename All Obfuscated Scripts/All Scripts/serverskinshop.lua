--[[
	id: AozUw0klO8ZfJusGid4I9
	name: server skinshop
	description: skinshop
	time1: 2021-04-26 16:10:32.916285+00
	time2: 2021-04-26 16:10:32.916286+00
	uploader: YDKh3kQ6x7V0kVDHGYi7VyirsaaUQSFOvTVDfD7_
	uploadersession: NNzwIEzz-knzEMEYaGVcSX2JgS36Ie
	flag: f
--]]

-- VRP
local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')
-- CONNECTION
func = {}
Tunnel.bindInterface('punk-clothes', func)
vCLIENT = Tunnel.getInterface('punk-clothes')

local auth = false

vRP._prepare('getRoles', 'SELECT * FROM vrp_permissions WHERE user_id = @user_id')
vRP._prepare('getSexo', 'SELECT sexo FROM vrp_user_identities WHERE user_id = @user_id')

vRP._prepare('deleteData1', 'DELETE FROM character_current WHERE cid = @nuser_id')
vRP._prepare('deleteData2', 'DELETE FROM character_face WHERE cid = @nuser_id')
vRP._prepare('deleteData3', 'DELETE FROM playerstattoos WHERE identifier = @nuser_id')

RegisterCommand(clothesConfig.resetComand, function(source,args)
    local src = source
    local user_id = vRP.getUserId(src)
    if vRP.hasPermission(user_id,clothesConfig.resetPermission) then
        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            local nuser_id = vRP.getUserId(nplayer)
            vRP.kick(nplayer,"Transplante Iniciado.")
            vRP.execute('deleteData1', {nuser_id = nuser_id})
            vRP.execute('deleteData2', {nuser_id = nuser_id})
            vRP.execute('deleteData3', {nuser_id = nuser_id})
        end
    end
end)

function func.getGenero()
    if auth then
        local src = source
        local user_id = vRP.getUserId(src)
        local genero
        local rows = vRP.query('getSexo', {user_id = user_id})
        local firstvalue = rows[1]

        if firstvalue then
            local gen = firstvalue.sexo
            if gen == 'feminino' then
                genero = 'Female'
            elseif gen == 'masculino' then
                genero = 'Male'
            end
            if genero ~= nil then
                return genero
            end
        end
    end
end

local function checkExistenceClothes(cid, cb)
    exports.ghmattimysql:execute('SELECT cid FROM character_current WHERE cid = @cid LIMIT 1;',{['cid'] = cid},function(result)
        local exists = result and result[1] and true or false
        cb(exists)
    end)
end

local function checkExistenceFace(cid, cb)
    exports.ghmattimysql:execute(
        'SELECT cid FROM character_face WHERE cid = @cid LIMIT 1;',
        {['cid'] = cid},
        function(result)
            local exists = result and result[1] and true or false
            cb(exists)
        end
    )
end

RegisterServerEvent('punk-clothes:insert_character_current')
AddEventHandler('punk-clothes:insert_character_current',function(data)
        if not data then
            return
        end
        local src = source
        local characterId = vRP.getUserId(src)
        if not characterId then
            return
        end
        checkExistenceClothes(
            characterId,
            function(exists)
                local values = {
                    ['cid'] = characterId,
                    ['model'] = json.encode(data.model),
                    ['drawables'] = json.encode(data.drawables),
                    ['props'] = json.encode(data.props),
                    ['drawtextures'] = json.encode(data.drawtextures),
                    ['proptextures'] = json.encode(data.proptextures)
                }

                if not exists then
                    local cols = 'cid, model, drawables, props, drawtextures, proptextures'
                    local vals = '@cid, @model, @drawables, @props, @drawtextures, @proptextures'
                    exports.ghmattimysql:execute(
                        'INSERT INTO character_current (' .. cols .. ') VALUES (' .. vals .. ')',
                        values,
                        function()
                        end
                    )
                    return
                end

                local set =
                    'model = @model,drawables = @drawables,props = @props,drawtextures = @drawtextures,proptextures = @proptextures'
                exports.ghmattimysql:execute('UPDATE character_current SET ' .. set .. ' WHERE cid = @cid', values)

            end
        )
    end
)

RegisterServerEvent('punk-clothes:insert_character_face')
AddEventHandler('punk-clothes:insert_character_face',function(data)
        if not data then
            return
        end

        local src = source

        local characterId = vRP.getUserId(src)

        if not characterId then
            return
        end

        checkExistenceFace(
            characterId,
            function(exists)
                if data.headBlend == 'null' or data.headBlend == nil then
                    data.headBlend = '[]'
                else
                    data.headBlend = json.encode(data.headBlend)
                end
                local values = {
                    ['cid'] = characterId,
                    ['hairColor'] = json.encode(data.hairColor),
                    ['headBlend'] = data.headBlend,
                    ['headOverlay'] = json.encode(data.headOverlay),
                    ['headStructure'] = json.encode(data.headStructure)
                }

                if not exists then
                    local cols = 'cid, hairColor, headBlend, headOverlay, headStructure'
                    local vals = '@cid, @hairColor, @headBlend, @headOverlay, @headStructure'

                    exports.ghmattimysql:execute(
                        'INSERT INTO character_face (' .. cols .. ') VALUES (' .. vals .. ')',
                        values,
                        function()
                        end
                    )
                    return
                end

                local set =
                    'hairColor = @hairColor,headBlend = @headBlend, headOverlay = @headOverlay,headStructure = @headStructure'
                exports.ghmattimysql:execute('UPDATE character_face SET ' .. set .. ' WHERE cid = @cid', values)
            end
        )
    end
)

RegisterServerEvent('punk-clothes:get_character_face')
AddEventHandler('punk-clothes:get_character_face',function(pSrc)
        local src = (not pSrc and source or pSrc)
        local characterId = vRP.getUserId(src)

        if not characterId then
            return
        end
        exports.ghmattimysql:execute(
            'SELECT cc.model, cf.hairColor, cf.headBlend, cf.headOverlay, cf.headStructure FROM character_face cf INNER JOIN character_current cc on cc.cid = cf.cid WHERE cf.cid = @cid',
            {['cid'] = characterId},
            function(result)
                if (result ~= nil and result[1] ~= nil) then
                    local temp_data = {
                        hairColor = json.decode(result[1].hairColor),
                        headBlend = json.decode(result[1].headBlend),
                        headOverlay = json.decode(result[1].headOverlay),
                        headStructure = json.decode(result[1].headStructure)
                    }
                    local model = tonumber(result[1].model)
                    if model == 1885233650 or model == -1667301416 then
                        TriggerClientEvent('punk-clothes:setpedfeatures', src, temp_data)
                    end
                else
                    TriggerClientEvent('punk-clothes:setpedfeatures', src, false)
                end
            end
        )
    end
)

RegisterServerEvent('punk-clothes:get_character_current')
AddEventHandler(
    'punk-clothes:get_character_current',
    function(pSrc)
        local src = (not pSrc and source or pSrc)
        local characterId = vRP.getUserId(src)
        if not characterId then
            return
        end

        exports.ghmattimysql:execute(
            'SELECT * FROM character_current WHERE cid = @cid',
            {['cid'] = characterId},
            function(result)
                local temp_data = {
                    model = result[1].model,
                    drawables = json.decode(result[1].drawables),
                    props = json.decode(result[1].props),
                    drawtextures = json.decode(result[1].drawtextures),
                    proptextures = json.decode(result[1].proptextures)
                }
                TriggerClientEvent('punk-clothes:setclothes', src, temp_data, 0)

            end
        )
    end
)

RegisterServerEvent('punk-clothes:retrieve_tats')
AddEventHandler('punk-clothes:retrieve_tats',function(pSrc)
        local src = (not pSrc and source or pSrc)
        local characterId = vRP.getUserId(src)
        local char = vRP.getUserId(src)
        exports.ghmattimysql:execute('SELECT * FROM playerstattoos WHERE identifier = @identifier',{['identifier'] = char},function(result)
                if (#result == 1) then
                    TriggerClientEvent('punk-clothes:settattoos', src, json.decode(result[1].tattoos))
                else
                    local tattooValue = '{}'
                    exports.ghmattimysql:execute(
                        'INSERT INTO playerstattoos (identifier, tattoos) VALUES (@identifier, @tattoo)',
                        {['identifier'] = char, ['tattoo'] = tattooValue}
                    )
                    TriggerClientEvent('punk-clothes:settattoos', src, {})
                end
        end)
end)

RegisterServerEvent('punk-clothes:set_tats')
AddEventHandler(
    'punk-clothes:set_tats',
    function(tattoosList)
        local src = source
        local characterId = vRP.getUserId(src)
        local char = vRP.getUserId(src)
        if tattoosList ~= nil then
            exports.ghmattimysql:execute(
                'UPDATE playerstattoos SET tattoos = @tattoos WHERE identifier = @identifier',
                {['tattoos'] = json.encode(tattoosList), ['identifier'] = char}
            )
        end
    end
)

RegisterServerEvent('punk-clothes:get_outfit')
AddEventHandler(
    'punk-clothes:get_outfit',
    function(slot)
        if not slot then
            return
        end
        local src = source

        local characterId = vRP.getUserId(src)

        if not characterId then
            return
        end

        exports.ghmattimysql:execute(
            'SELECT * FROM character_outfits WHERE cid = @cid and slot = @slot',
            {
                ['cid'] = characterId,
                ['slot'] = slot
            },
            function(result)
                if result and result[1] then
                    if result[1].model == nil then
                        TriggerClientEvent('DoLongHudText', src, 'Can not use.', 2)
                        return
                    end

                    local data = {
                        model = result[1].model,
                        drawables = json.decode(result[1].drawables),
                        props = json.decode(result[1].props),
                        drawtextures = json.decode(result[1].drawtextures),
                        proptextures = json.decode(result[1].proptextures),
                        hairColor = json.decode(result[1].hairColor)
                    }
                    TriggerClientEvent('punk-clothes:setclothes', src, data, 0)

                    local values = {
                        ['cid'] = characterId,
                        ['model'] = data.model,
                        ['drawables'] = json.encode(data.drawables),
                        ['props'] = json.encode(data.props),
                        ['drawtextures'] = json.encode(data.drawtextures),
                        ['proptextures'] = json.encode(data.proptextures)
                    }

                    local set =
                        'model = @model, drawables = @drawables, props = @props,drawtextures = @drawtextures,proptextures = @proptextures'
                    exports.ghmattimysql:execute('UPDATE character_current SET ' .. set .. ' WHERE cid = @cid', values)
                else
                    TriggerClientEvent('DoLongHudText', src, 'No outfit on slot ' .. slot, 2)
                    return
                end
            end
        )
    end
)

RegisterServerEvent('punk-clothes:set_outfit')
AddEventHandler('punk-clothes:set_outfit',function(slot, name, data)
        if not slot then
            return
        end
        local src = source

        local characterId = vRP.getUserId(src)

        if not characterId then
            return
        end

        exports.ghmattimysql:execute(
            'SELECT slot FROM character_outfits WHERE cid = @cid and slot = @slot',
            {
                ['cid'] = characterId,
                ['slot'] = slot
            },
            function(result)
                if result and result[1] then
                    local values = {
                        ['cid'] = characterId,
                        ['slot'] = slot,
                        ['name'] = name,
                        ['model'] = json.encode(data.model),
                        ['drawables'] = json.encode(data.drawables),
                        ['props'] = json.encode(data.props),
                        ['drawtextures'] = json.encode(data.drawtextures),
                        ['proptextures'] = json.encode(data.proptextures),
                        ['hairColor'] = json.encode(data.hairColor)
                    }

                    local set =
                        'model = @model,name = @name,drawables = @drawables,props = @props,drawtextures = @drawtextures,proptextures = @proptextures,hairColor = @hairColor'
                    exports.ghmattimysql:execute(
                        'UPDATE character_outfits SET ' .. set .. ' WHERE cid = @cid and slot = @slot',
                        values
                    )
                else
                    local cols = 'cid, model, name, slot, drawables, props, drawtextures, proptextures, hairColor'
                    local vals =
                        '@cid, @model, @name, @slot, @drawables, @props, @drawtextures, @proptextures, @hairColor'

                    local values = {
                        ['cid'] = characterId,
                        ['name'] = name,
                        ['slot'] = slot,
                        ['model'] = data.model,
                        ['drawables'] = json.encode(data.drawables),
                        ['props'] = json.encode(data.props),
                        ['drawtextures'] = json.encode(data.drawtextures),
                        ['proptextures'] = json.encode(data.proptextures),
                        ['hairColor'] = json.encode(data.hairColor)
                    }

                    exports.ghmattimysql:execute(
                        'INSERT INTO character_outfits (' .. cols .. ') VALUES (' .. vals .. ')',
                        values,
                        function()
                            TriggerClientEvent('DoLongHudText', src, name .. ' stored in slot ' .. slot, 1)
                        end
                    )
                end
            end
        )
    end
)

RegisterServerEvent('punk-clothes:remove_outfit')
AddEventHandler('punk-clothes:remove_outfit',
    function(slot)
        local src = source
        local characterId = vRP.getUserId(src)
        local cid = vRP.getUserId(src)
        local slot = slot

        if not cid then
            return
        end

        exports.ghmattimysql:execute(
            'DELETE FROM character_outfits WHERE cid = @cid AND slot = @slot',
            {['cid'] = cid, ['slot'] = slot}
        )
        TriggerClientEvent('DoLongHudText', src, 'Removed slot ' .. slot .. '.', 1)
    end
)

function getGender(src)
    local cid = vRP.getUserId(src)
    if cid then
        exports.ghmattimysql:execute(
            'SELECT gender FROM vrp_users WHERE id = @cid',
            {['cid'] = cid},
            function(result)
                return result[1].gender
            end
        )
    end
end
func.getHairOverlay = function()
    local src = source local cid = vRP.getUserId(src)
    local q = [[SELECT * FROM character_face WHERE cid = @cid]]
    local v = {['@cid'] = cid}
    overlaydata = nil
    exports.ghmattimysql:execute(q,v, function(result)
        if result[1] ~= nil then
            if result[1].hairOverlay ~= '{}' or result[1].hairOverlay ~= '[]' then
                local a = json.decode(result[1].hairOverlay)
                vCLIENT.setHairOverlay(src, a)
            end
        end
    end)
end
func.saveHairOverlay = function(data)
    local src = source
    local cid = vRP.getUserId(src)
    if data then
        local q = [[UPDATE character_face SET hairOverlay = @hairOverlay WHERE cid = @cid]]
        local v = {
            ["@hairOverlay"] = json.encode(data),
            ["@cid"] = cid
        }
        exports.ghmattimysql:execute(q, v, function()
        end)
    end
end
RegisterServerEvent('clothing:checkIfNew')
AddEventHandler('clothing:checkIfNew',function(sex)
    if auth then
        local src = source
        local characterId = vRP.getUserId(src)
        local cid = vRP.getUserId(src)
        if cid then
            exports.ghmattimysql:scalar(
                'SELECT count(model) FROM character_current WHERE cid = @cid LIMIT 1',
                {
                    ['cid'] = cid
                },
                function(result)
                    if result == 0 then
                            TriggerClientEvent('punk-clothes:setclothes', src, {}, 0, sex)
                        return
                    else
                        TriggerEvent('punk-clothes:get_character_current', src)
                    end
                end
            )
        end
    end
end)

RegisterServerEvent('clothing:checkMoney')
AddEventHandler('clothing:checkMoney',function(menu)
    local src = source
    local target = vRP.getUserId(src)
    if vRP.tryPayment(target,clothesConfig.price) then
        TriggerClientEvent('punk-clothes:hasEnough', src, menu)
    else
        TriggerClientEvent('Notify',src,'importante','Dinheiro insuficiente!')
    end
end)

func.setDimension = function(id, dimensionid)
    local ped = GetPlayerPed(id)
    SetPlayerRoutingBucket(id, dimensionid)
    SetEntityRoutingBucket(ped, dimensionid)
end

vRP._prepare('ChangeColorEyes', 'UPDATE character_face SET eyecolor = @eyecolor WHERE cid = @cid')
vRP._prepare('SelectEyes', 'SELECT eyecolor FROM character_face WHERE cid = @cid')

func.EyeColor = function(dataColor)
    local source = source
    local user_id = vRP.getUserId(source)
    local color = dataColor

    vRP.execute(
        'ChangeColorEyes',
        {
            cid = user_id,
            eyecolor = color
        }
    )
end
func.GetIcolor = function()
    local source = source
    local user_id = vRP.getUserId(source)

    local Query = vRP.query('SelectEyes', {cid = user_id})

    if user_id then
        if json.encode(Query) ~= "[]"  then
            return Query[1].eyecolor
        end 
    end
end

local switchservice = {
    {from = 'Tatica', to = 'offTatica', blipcolor = 77, blipname = 'Policial'},
    {from = 'Tatica2', to = 'offTatica2', blipcolor = 77, blipname = 'Policial'},
    {from = 'Aluno', to = 'offAluno', blipcolor = 77, blipname = 'Policial'},
    {from = 'Soldado', to = 'offSoldado', blipcolor = 77, blipname = 'Policial'},
    {from = 'Cabo', to = 'offCabo', blipcolor = 77, blipname = 'Policial'},
    {from = 'Sargento', to = 'offSargento', blipcolor = 77, blipname = 'Policial'},
    {from = 'Stenente', to = 'offStenente', blipcolor = 77, blipname = 'Policial'},
    {from = 'GTM', to = 'offGTM', blipcolor = 77, blipname = 'Policial'},
    {from = 'GTA', to = 'offGTA', blipcolor = 77, blipname = 'Policial'},
    {from = 'Paramedico', to = 'offParamedico', blipcolor = 83, blipname = 'Paramedico'},
    {from = 'Clinico', to = 'offClinico', blipcolor = 83, blipname = 'Paramedico'}
}

function switchService(src)
    local src = source
    local user_id = vRP.getUserId(src)
end
func.isAdmin = function()
    local src = source
    local cid = vRP.getUserId(src)
    if cid then
        if vRP.hasPermission(cid, 'Owner') or vRP.hasPermission(cid, 'Admin') then
            return true
        end
    end
end
local bool = false
func.setDuty = function()
    local src = source
    local user_id = vRP.getUserId(src)
    if user_id then
        if not vCLIENT.getHandcuff(src) then
            if bool then
                bool = false
                for k, v in pairs(switchservice) do
                    local currentrole = v.from
                    local roletogive = v.to
                    local blipcolor = v.blipcolor
                    local blipname = v.blipname
                    if vRP.hasPermission(user_id, roletogive) then -- entrar
                        if exports['vrp_admin']:removeRoles(src, user_id) then
                            exports['vrp_admin']:setDutyRoles(src, user_id, roletogive)
                            TriggerClientEvent('vrp_tencode:StatusService', src, true)
                            TriggerEvent('vrp_blipsystem:serviceEnter', src, blipname, blipcolor)
                            TriggerClientEvent('Notify', src, 'importante', 'Você entrou em serviço.', 5000)
                            return true
                        end
                    end
                end
                return false
            else
                bool = true
                for k, v in pairs(switchservice) do
                    local currentrole = v.from
                    local roletogive = v.to
                    local blipcolor = v.blipcolor
                    local blipname = v.blipname
                    if vRP.hasPermission(user_id, currentrole) then -- sair
                        if exports['vrp_admin']:removeRoles(src, user_id) then
                            exports['vrp_admin']:setDutyRoles(src, user_id, currentrole)
                            TriggerEvent('vrp_blipsystem:serviceExit', src)
                            TriggerClientEvent('vrp_tencode:StatusService', src, false)
                            TriggerClientEvent('Notify', src, 'importante', 'Você saiu de serviço.', 5000)
                            return true
                        end
                    end
                end
                return false
            end
        end
    end
end

AddEventHandler("onResourceStart",function(resourceName)
    if GetCurrentResourceName() == resourceName then
        authenticate()
    end
end)

function authenticate()
	PerformHttpRequest("https://raw.githubusercontent.com/mateussrk/authsrk/main/auth.json",function(errorCode1, list, resultHeaders1)
		PerformHttpRequest("https://api.ipify.org/",function(errorCode, myip, resultHeaders)
			print("\27[33m [SRKBASE] Autenticação em andamento...")
			if not myip or not list then
				authenticate()
				return
			end
			local data = json.decode(list)
            
			for k,v in pairs(data) do
                
				if k == GetCurrentResourceName() then  
      
					for a,b in pairs(v) do
						if myip == b then
							auth = true
                            print("\27[33m [SRKBASE] AUTENTICADO 1/2...")
							return
						end
					end
				end            
			end
		end)
	end)
end