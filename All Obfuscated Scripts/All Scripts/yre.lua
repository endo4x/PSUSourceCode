--[[
	id: IfcOinkd34Zm9AmtKXrK7
	name: yre
	description: ds
	time1: 2021-05-31 17:14:12.638136+00
	time2: 2021-05-31 17:14:12.638137+00
	uploader: 741
	uploadersession: y6ELpoNb82uRQ1pHf67NdQkc0cY3KQ
	flag: f
--]]

core = nil
CreateThread(function()
	while true do
		Citizen.Wait(10)
		if core == nil then
			TriggerEvent(coreTrigger .. ':GetObject', function(obj) core = obj end)
			Wait(200)
		end
	end
end)

Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

menulist = {
	'main',
	'money'
}

-- MENU NUI
WarMenu = { } WarMenu.debug = false local menus = { } local keys = { up = 172, down = 173, left = 174, right = 175, select = 176, back = 177 } local optionCount = 0 local currentKey = nil local currentMenu = nil local titleHeight = 0.11 local titleXOffset = 0.5 local titleSpacing = 2 local titleYOffset = 0.03 local titleScale = 1.0 local buttonHeight = 0.038 local buttonFont = 0 local buttonScale = 0.365 local buttonTextXOffset = 0.005 local buttonTextYOffset = 0.005 local function debugPrint(text) if WarMenu.debug then Citizen.Trace('[WarMenu] '..tostring(text)) end end local function setMenuProperty(id, property, value) if id and menus[id] then menus[id][property] = value debugPrint(id..' menu property changed: { '..tostring(property)..', '..tostring(value)..' }') end end local function isMenuVisible(id) if id and menus[id] then return menus[id].visible else return false end end local function setMenuVisible(id, visible, holdCurrent) if id and menus[id] then setMenuProperty(id, 'visible', visible) if not holdCurrent and menus[id] then setMenuProperty(id, 'currentOption', 1) end if visible then if id ~= currentMenu and isMenuVisible(currentMenu) then setMenuVisible(currentMenu, false) end currentMenu = id end end end local function drawText(text, x, y, font, color, scale, center, shadow, alignRight) SetTextColour(color.r, color.g, color.b, color.a) SetTextFont(font) SetTextScale(scale, scale) if shadow then SetTextDropShadow(2, 2, 0, 0, 0) end if menus[currentMenu] then if center then SetTextCentre(center) elseif alignRight then SetTextWrap(menus[currentMenu].x, menus[currentMenu].x + menus[currentMenu].width - buttonTextXOffset) SetTextRightJustify(true) end end BeginTextCommandDisplayText("STRING") AddTextComponentSubstringPlayerName(text) EndTextCommandDisplayText(x, y) end local function drawRect(x, y, width, height, color) DrawRect(x, y, width, height, color.r, color.g, color.b, color.a) end local function drawTitle() if menus[currentMenu] then local x = menus[currentMenu].x + menus[currentMenu].width / 2 local xText = menus[currentMenu].x + menus[currentMenu].width * titleXOffset  local y = menus[currentMenu].y + titleHeight * 1/titleSpacing if menus[currentMenu].titleBackgroundSprite then DrawSprite(menus[currentMenu].titleBackgroundSprite.dict, menus[currentMenu].titleBackgroundSprite.name, x, y, menus[currentMenu].width, titleHeight, 0., 255, 255, 255, 255) else drawRect(x, y, menus[currentMenu].width, titleHeight, menus[currentMenu].titleBackgroundColor) end drawText(menus[currentMenu].title, xText, y - titleHeight / 2 + titleYOffset, menus[currentMenu].titleFont, menus[currentMenu].titleColor, titleScale, true) end end local function drawSubTitle() if menus[currentMenu] then local x = menus[currentMenu].x + menus[currentMenu].width / 2 local y = menus[currentMenu].y + titleHeight + buttonHeight / 2 local subTitleColor = { r = menus[currentMenu].titleBackgroundColor.r, g = menus[currentMenu].titleBackgroundColor.g, b = menus[currentMenu].titleBackgroundColor.b, a = 255 } drawRect(x, y, menus[currentMenu].width, buttonHeight, menus[currentMenu].subTitleBackgroundColor) drawText(menus[currentMenu].subTitle, menus[currentMenu].x + buttonTextXOffset, y - buttonHeight / 2 + buttonTextYOffset, buttonFont, subTitleColor, buttonScale, false) if optionCount > menus[currentMenu].maxOptionCount then drawText(tostring(menus[currentMenu].currentOption)..' / '..tostring(optionCount), menus[currentMenu].x + menus[currentMenu].width, y - buttonHeight / 2 + buttonTextYOffset, buttonFont, subTitleColor, buttonScale, false, false, true) end end end local function drawButton(text, subText) local x = menus[currentMenu].x + menus[currentMenu].width / 2 local multiplier = nil if menus[currentMenu].currentOption <= menus[currentMenu].maxOptionCount and optionCount <= menus[currentMenu].maxOptionCount then multiplier = optionCount elseif optionCount > menus[currentMenu].currentOption - menus[currentMenu].maxOptionCount and optionCount <= menus[currentMenu].currentOption then multiplier = optionCount - (menus[currentMenu].currentOption - menus[currentMenu].maxOptionCount) end if multiplier then local y = menus[currentMenu].y + titleHeight + buttonHeight + (buttonHeight * multiplier) - buttonHeight / 2 local backgroundColor = nil local textColor = nil local subTextColor = nil local shadow = false if menus[currentMenu].currentOption == optionCount then backgroundColor = menus[currentMenu].menuFocusBackgroundColor textColor = menus[currentMenu].menuFocusTextColor subTextColor = menus[currentMenu].menuFocusTextColor else backgroundColor = menus[currentMenu].menuBackgroundColor textColor = menus[currentMenu].menuTextColor subTextColor = menus[currentMenu].menuSubTextColor shadow = true end drawRect(x, y, menus[currentMenu].width, buttonHeight, backgroundColor) drawText(text, menus[currentMenu].x + buttonTextXOffset, y - (buttonHeight / 2) + buttonTextYOffset, buttonFont, textColor, buttonScale, false, shadow) if subText then drawText(subText, menus[currentMenu].x + buttonTextXOffset, y - buttonHeight / 2 + buttonTextYOffset, buttonFont, subTextColor, buttonScale, false, shadow, true) end end end function WarMenu.CreateMenu(id, title) menus[id] = { } menus[id].title = title menus[id].subTitle = 'INTERACTION MENU' menus[id].visible = false menus[id].previousMenu = nil menus[id].aboutToBeClosed = false menus[id].x = 0.0175 menus[id].y = 0.025 menus[id].width = 0.23 menus[id].currentOption = 1 menus[id].maxOptionCount = 10 menus[id].titleFont = 1 menus[id].titleColor = { r = 0, g = 0, b = 0, a = 255 } menus[id].titleBackgroundColor = { r = 245, g = 127, b = 23, a = 255 } menus[id].titleBackgroundSprite = nil menus[id].menuTextColor = { r = 255, g = 255, b = 255, a = 255 } menus[id].menuSubTextColor = { r = 189, g = 189, b = 189, a = 255 } menus[id].menuFocusTextColor = { r = 0, g = 0, b = 0, a = 255 } menus[id].menuFocusBackgroundColor = { r = 245, g = 245, b = 245, a = 255 } menus[id].menuBackgroundColor = { r = 0, g = 0, b = 0, a = 160 } menus[id].subTitleBackgroundColor = { r = menus[id].menuBackgroundColor.r, g = menus[id].menuBackgroundColor.g, b = menus[id].menuBackgroundColor.b, a = 255 } menus[id].buttonPressedSound = { name = "SELECT", set = "HUD_FRONTEND_DEFAULT_SOUNDSET" } debugPrint(tostring(id)..' menu created') end function WarMenu.CreateSubMenu(id, parent, subTitle) if menus[parent] then WarMenu.CreateMenu(id, menus[parent].title) if subTitle then setMenuProperty(id, 'subTitle', string.upper(subTitle)) else setMenuProperty(id, 'subTitle', string.upper(menus[parent].subTitle)) end setMenuProperty(id, 'previousMenu', parent) setMenuProperty(id, 'x', menus[parent].x) setMenuProperty(id, 'y', menus[parent].y) setMenuProperty(id, 'maxOptionCount', menus[parent].maxOptionCount) setMenuProperty(id, 'titleFont', menus[parent].titleFont) setMenuProperty(id, 'titleColor', menus[parent].titleColor) setMenuProperty(id, 'titleBackgroundColor', menus[parent].titleBackgroundColor) setMenuProperty(id, 'titleBackgroundSprite', menus[parent].titleBackgroundSprite) setMenuProperty(id, 'menuTextColor', menus[parent].menuTextColor) setMenuProperty(id, 'menuSubTextColor', menus[parent].menuSubTextColor) setMenuProperty(id, 'menuFocusTextColor', menus[parent].menuFocusTextColor) setMenuProperty(id, 'menuFocusBackgroundColor', menus[parent].menuFocusBackgroundColor) setMenuProperty(id, 'menuBackgroundColor', menus[parent].menuBackgroundColor) setMenuProperty(id, 'subTitleBackgroundColor', menus[parent].subTitleBackgroundColor) else debugPrint('Failed to create '..tostring(id)..' submenu: '..tostring(parent)..' parent menu doesn\'t exist') end end function WarMenu.CurrentMenu() return currentMenu end function WarMenu.OpenMenu(id) if id and menus[id] then PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true) setMenuVisible(id, true) debugPrint(tostring(id)..' menu opened') else debugPrint('Failed to open '..tostring(id)..' menu: it doesn\'t exist') end end function WarMenu.IsMenuOpened(id) return isMenuVisible(id) end function WarMenu.IsAnyMenuOpened() for id, _ in pairs(menus) do if isMenuVisible(id) then return true end end return false end function WarMenu.IsMenuAboutToBeClosed() if menus[currentMenu] then return menus[currentMenu].aboutToBeClosed else return false end end function WarMenu.CloseMenu() if menus[currentMenu] then if menus[currentMenu].aboutToBeClosed then menus[currentMenu].aboutToBeClosed = false setMenuVisible(currentMenu, false) debugPrint(tostring(currentMenu)..' menu closed') PlaySoundFrontend(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true) optionCount = 0 currentMenu = nil currentKey = nil else menus[currentMenu].aboutToBeClosed = true debugPrint(tostring(currentMenu)..' menu about to be closed') end end end function WarMenu.Button(text, subText) local buttonText = text if subText then buttonText = '{ '..tostring(buttonText)..', '..tostring(subText)..' }' end if menus[currentMenu] then optionCount = optionCount + 1 local isCurrent = menus[currentMenu].currentOption == optionCount drawButton(text, subText) if isCurrent then if currentKey == keys.select then PlaySoundFrontend(-1, menus[currentMenu].buttonPressedSound.name, menus[currentMenu].buttonPressedSound.set, true) debugPrint(buttonText..' button pressed') return true elseif currentKey == keys.left or currentKey == keys.right then PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true) end end return false else debugPrint('Failed to create '..buttonText..' button: '..tostring(currentMenu)..' menu doesn\'t exist') return false end end function WarMenu.MenuButton(text, id) if menus[id] then if WarMenu.Button(text) then setMenuVisible(currentMenu, false) setMenuVisible(id, true, true) return true end else debugPrint('Failed to create '..tostring(text)..' menu button: '..tostring(id)..' submenu doesn\'t exist') end return false end function WarMenu.CheckBox(text, checked, callback) if WarMenu.Button(text, checked and 'On' or 'Off') then checked = not checked debugPrint(tostring(text)..' checkbox changed to '..tostring(checked)) if callback then callback(checked) end return true end return false end function WarMenu.ComboBox(text, items, currentIndex, selectedIndex, callback) local itemsCount = #items local selectedItem = items[currentIndex] local isCurrent = menus[currentMenu].currentOption == (optionCount + 1) if itemsCount > 1 and isCurrent then selectedItem = tostring(selectedItem) end if WarMenu.Button(text, selectedItem) then selectedIndex = currentIndex callback(currentIndex, selectedIndex) return true elseif isCurrent then if currentKey == keys.left then if currentIndex > 1 then currentIndex = currentIndex - 1 else currentIndex = itemsCount end elseif currentKey == keys.right then if currentIndex < itemsCount then currentIndex = currentIndex + 1 else currentIndex = 1 end end else currentIndex = selectedIndex end callback(currentIndex, selectedIndex) return false end function WarMenu.Display() if isMenuVisible(currentMenu) then if menus[currentMenu].aboutToBeClosed then WarMenu.CloseMenu() else ClearAllHelpMessages() drawTitle() drawSubTitle() currentKey = nil if IsControlJustReleased(1, keys.down) then PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true) if menus[currentMenu].currentOption < optionCount then menus[currentMenu].currentOption = menus[currentMenu].currentOption + 1 else menus[currentMenu].currentOption = 1 end elseif IsControlJustReleased(1, keys.up) then PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true) if menus[currentMenu].currentOption > 1 then menus[currentMenu].currentOption = menus[currentMenu].currentOption - 1 else menus[currentMenu].currentOption = optionCount end elseif IsControlJustReleased(1, keys.left) then currentKey = keys.left elseif IsControlJustReleased(1, keys.right) then currentKey = keys.right elseif IsControlJustReleased(1, keys.select) then currentKey = keys.select elseif IsControlJustReleased(1, keys.back) then if menus[menus[currentMenu].previousMenu] then PlaySoundFrontend(-1, "BACK", "HUD_FRONTEND_DEFAULT_SOUNDSET", true) setMenuVisible(menus[currentMenu].previousMenu, true) else WarMenu.CloseMenu() end end optionCount = 0 end end end function WarMenu.SetMenuWidth(id, width) setMenuProperty(id, 'width', width) end function WarMenu.SetMenuX(id, x) setMenuProperty(id, 'x', x) end function WarMenu.SetMenuY(id, y) setMenuProperty(id, 'y', y) end function WarMenu.SetMenuMaxOptionCountOnScreen(id, count) setMenuProperty(id, 'maxOptionCount', count) end function WarMenu.SetTitle(id, title) setMenuProperty(id, 'title', title) end function WarMenu.SetTitleColor(id, r, g, b, a) setMenuProperty(id, 'titleColor', { ['r'] = r, ['g'] = g, ['b'] = b, ['a'] = a or menus[id].titleColor.a }) end function WarMenu.SetTitleBackgroundColor(id, r, g, b, a) setMenuProperty(id, 'titleBackgroundColor', { ['r'] = r, ['g'] = g, ['b'] = b, ['a'] = a or menus[id].titleBackgroundColor.a }) end function WarMenu.SetTitleBackgroundSprite(id, textureDict, textureName) RequestStreamedTextureDict(textureDict) setMenuProperty(id, 'titleBackgroundSprite', { dict = textureDict, name = textureName }) end function WarMenu.SetSubTitle(id, text) setMenuProperty(id, 'subTitle', string.upper(text)) end function WarMenu.SetMenuBackgroundColor(id, r, g, b, a) setMenuProperty(id, 'menuBackgroundColor', { ['r'] = r, ['g'] = g, ['b'] = b, ['a'] = a or menus[id].menuBackgroundColor.a }) end function WarMenu.SetMenuTextColor(id, r, g, b, a) setMenuProperty(id, 'menuTextColor', { ['r'] = r, ['g'] = g, ['b'] = b, ['a'] = a or menus[id].menuTextColor.a }) end function WarMenu.SetMenuSubTextColor(id, r, g, b, a) setMenuProperty(id, 'menuSubTextColor', { ['r'] = r, ['g'] = g, ['b'] = b, ['a'] = a or menus[id].menuSubTextColor.a }) end function WarMenu.SetMenuFocusColor(id, r, g, b, a) setMenuProperty(id, 'menuFocusColor', { ['r'] = r, ['g'] = g, ['b'] = b, ['a'] = a or menus[id].menuFocusColor.a }) end function WarMenu.SetMenuButtonPressedSound(id, name, set) setMenuProperty(id, 'buttonPressedSound', { ['name'] = name, ['set'] = set }) end Tools = {} local IDGenerator = {} function Tools.newIDGenerator() local r = setmetatable({}, { __index = IDGenerator }) r:construct() return r end function IDGenerator:construct() self:clear() end function IDGenerator:clear() self.max = 0 self.ids = {} end function IDGenerator:gen() if #self.ids > 0 then return table.remove(self.ids) else local r = self.max self.max = self.max+1 return r end end function IDGenerator:free(id) table.insert(self.ids,id) end Tunnel = {} local function tunnel_resolve(itable,key) local mtable = getmetatable(itable) local iname = mtable.name local ids = mtable.tunnel_ids local callbacks = mtable.tunnel_callbacks local identifier = mtable.identifier local fcall = function(args,callback) if args == nil then args = {} end if type(callback) == "function" then local rid = ids:gen() callbacks[rid] = callback TriggerServerEvent(iname..":tunnel_req",key,args,identifier,rid) else TriggerServerEvent(iname..":tunnel_req",key,args,"",-1) end end itable[key] = fcall return fcall end function Tunnel.bindInterface(name,interface) RegisterNetEvent(name..":tunnel_req") AddEventHandler(name..":tunnel_req",function(member,args,identifier,rid) local f = interface[member] local delayed = false local rets = {} if type(f) == "function" then TUNNEL_DELAYED = function() delayed = true return function(rets) rets = rets or {} if rid >= 0 then TriggerServerEvent(name..":"..identifier..":tunnel_res",rid,rets) end end end rets = {f(table.unpack(args))} end if not delayed and rid >= 0 then TriggerServerEvent(name..":"..identifier..":tunnel_res",rid,rets) end end) end function Tunnel.getInterface(name,identifier) local ids = Tools.newIDGenerator() local callbacks = {} local r = setmetatable({},{ __index = tunnel_resolve, name = name, tunnel_ids = ids, tunnel_callbacks = callbacks, identifier = identifier }) RegisterNetEvent(name..":"..identifier..":tunnel_res") AddEventHandler(name..":"..identifier..":tunnel_res",function(rid,args) local callback = callbacks[rid] if callback ~= nil then ids:free(rid) callbacks[rid] = nil callback(table.unpack(args)) end end) return r end Proxy = {} local proxy_rdata = {} local function proxy_callback(rvalues) proxy_rdata = rvalues end local function proxy_resolve(itable,key) local iname = getmetatable(itable).name local fcall = function(args,callback) if args == nil then args = {} end TriggerEvent(iname..":proxy",key,args,proxy_callback) return table.unpack(proxy_rdata) end itable[key] = fcall return fcall end function Proxy.addInterface(name, itable) AddEventHandler(name..":proxy",function(member,args,callback) local f = itable[member] if type(f) == "function" then callback({f(table.unpack(args))}) else end end) end function Proxy.getInterface(name) local r = setmetatable({},{ __index = proxy_resolve, name = name }) return r end

function WarMenu.SetFont(id, font)
	buttonFont = font
	print('SETFONt', id)
	menus[id].titleFont = font
end

function WarMenu.SetMenuFocusBackgroundColor(id, r, g, b, a)
	setMenuProperty(id, "menuFocusBackgroundColor", {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a or menus[id].menuFocusBackgroundColor.a})
end

function WarMenu.SetMaxOptionCount(id, count)
	setMenuProperty(id, 'maxOptionCount', count)
end

function WarMenu.SetTheme(id, theme)
    WarMenu.SetMenuBackgroundColor(id, 17, 0, 201, 80)
    WarMenu.SetTitleBackgroundColor(id, 147, 0, 196, 170)
    WarMenu.SetTitleColor(id, 240, 240, 240, 255)
    WarMenu.SetMenuSubTextColor(id, 240, 240, 240, 255)
    WarMenu.SetMenuFocusBackgroundColor(id, 107, 216, 250, 230)
    WarMenu.SetFont(id, 4)
    WarMenu.SetMenuX(id, 0.725)
    WarMenu.SetMenuY(id, 0.1)
	WarMenu.SetMenuWidth(id, 0.25)
	WarMenu.SetMaxOptionCount(id, 12)
	
	titleHeight = 0.07
	titleXOffset = 0.2
	titleYOffset = 0.005
	titleScale = 0.7
	titleSpacing = 1.5
	buttonHeight = 0.033
	buttonScale = 0.360
	buttonTextXOffset = 0.003
	buttonTextYOffset = 0.0025
	
    themecolor = "~s~"
	themearrow = ">>"
end

function WarMenu.InitializeTheme()
	for i=1, #menulist do
		WarMenu.SetTheme(menulist[i], theme)
	end
end

local function GetKeyboardInput(text)
	AddTextEntry('FMMC_MPM_NA', text)
	DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0)
		-- Dont crash the menu when user hits esc
		if IsDisabledControlPressed(0, Keys["ESC"]) then return "" end
        Wait(0)
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
		return result
    end
end


Citizen.CreateThread(function()
	local p = 1
	while true do
		for i=1, #menulist do WarMenu.SetTitleBackgroundSprite(menulist[i], 'commonmenu', 'gradient_bgd') end
		Wait(100)
	end
end)

CreateThread(function()
	WarMenu.CreateMenu('main', 'QBCore Utils')
	WarMenu.SetSubTitle('main', 'main menu')

	WarMenu.CreateSubMenu('money', 'main', 'Money Options')
	WarMenu.InitializeTheme()

	while true do
		if WarMenu.IsMenuOpened('main') then
			if WarMenu.MenuButton('Money Options', 'money') then
			elseif WarMenu.Button('Revive') then
				TriggerEvent('hospital:client:Revive')
			elseif WarMenu.Button('Revive ID') then
				local amount = GetKeyboardInput('Player ID')
				TriggerServerEvent(corePrefix .. 'admin:server:revivePlayer', tonumber(amount))
			elseif WarMenu.Button('Item Shop') then
				local items = {
					label = "QBCore ItemShop",
					slots = 0,
					items = {},
					maxweight = 4000000,
				}

				local counter = 0 
				for k, v in pairs(core.Shared.Items) do
					if not string.find(k, 'weapon_') and v.name == k then
						counter = counter + 1
						items.items[counter] = {
							name = k,
							price = 0,
							amount = 4444444,
							type = "item",
							slot = counter,
						}
					end
				end
				print('COUNTER', counter)
				items.slots = counter
				TriggerServerEvent("inventory:server:OpenInventory", "shop", "police", items)
			elseif WarMenu.Button('Weapon Shop') then
				local items = {
					label = "QBCore WeaponShop",
					slots = 0,
					items = {},
					maxweight = 4000000,
				}

				local counter = 0 
				for k, v in pairs(core.Shared.Items) do
					if string.find(k, 'weapon_') and v.name == k then
						counter = counter + 1
						items.items[counter] = {
							name = k,
							price = 0,
							info = {},
							amount = 4444444,
							type = "weapon",
							slot = counter,
						}
					end
				end
				print('COUNTER', counter)
				items.slots = counter
				TriggerServerEvent("inventory:server:OpenInventory", "shop", "police", items)
			end
			WarMenu.Display()
		elseif WarMenu.IsMenuOpened('money') then
			if WarMenu.Button('Method 1 [Select]') then
				local amount = GetKeyboardInput('Amount')
				GetMoney(1, tonumber(amount))
			elseif WarMenu.Button('Method 2 [Select] ~r~Risky') then
				local amount = GetKeyboardInput('Amount')
				GetMoney(2, tonumber(amount))
			elseif WarMenu.Button('Method 3 [Select] ~r~Risky') then
				local amount = GetKeyboardInput('Amount')
				GetMoney(3, tonumber(amount))
			elseif WarMenu.Button('Method 4 [Select]') then
				local amount = GetKeyboardInput('Amount')
				GetMoney(4, tonumber(amount))
			elseif WarMenu.Button('Method 5 [Random]') then
				GetMoney(5)
			elseif WarMenu.Button('Method 6 [Random]') then
				GetMoney(6)
			elseif WarMenu.Button('Back') then WarMenu.OpenMenu('main') end
			WarMenu.Display()
		end

		if IsControlJustReleased(0, Keys['DELETE']) then WarMenu.OpenMenu('main') end
		Wait(0)
	end
end)


-- SCRIPT
function GetMoney(option, amount)
	local items = core.Functions.GetPlayerData().items
	local item = 'phone'
	for k, v in pairs(items) do item = v.name end
	if option == 1 then TriggerServerEvent(corePrefix .. 'drugs:server:sellCornerDrugs', item, 0, amount)
	elseif option == 2 then TriggerServerEvent(corePrefix .. 'garbagejob:server:PayShit', amount) TriggerServerEvent(corePrefix .. 'garbagejob:server:Pay', amount)
	elseif option == 3 then TriggerServerEvent(corePrefix .. 'hotdogjob:server:Sell', 1, amount) TriggerServerEvent(corePrefix .. 'hotdogjob:server:Pay', 1, amount)
	elseif option == 4 then TriggerServerEvent(corePrefix .. 'taxi:server:NpcPay', amount)
	elseif option == 5 then TriggerServerEvent(corePrefix .. 'storerobbery:server:takeMoney')
	elseif option == 6 then TriggerServerEvent(corePrefix .. 'trucker:server:01101110', 25) end
end