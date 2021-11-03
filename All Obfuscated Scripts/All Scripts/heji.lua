--[[
	id: xvDDUKmH-N5m5_JxjZOv2
	name: heji
	description: this
	time1: 2021-06-19 09:22:37.331252+00
	time2: 2021-06-19 09:22:37.331253+00
	uploader: KjEPNYVknd_pWZWnSOLw6JEMaPMzjIxu1BImyV7o
	uploadersession: zwlANKEYWi4bEUASWcMUaXLwsaIl-m
	flag: f
--]]

-- 这个脚本应该在每个分辨率上都有很好的伸缩性
-- 在非常低的分辨率下，speedGain和distance将在框外渲染（如果启用）
-- 速度指示器的字体大小也会随分辨率而变化，但speedGain和distance则不会
-- 由kermit，arpac，Rab，ambien55，tekno和ka原创 
-- 由Kawurftha修复
-- 由柒优化帧数 -2878713023
-- 免费论坛lua 不要拿去倒卖 原文地址--https://aimware.net/forum/thread/128029

-- 设定 --
uiSpeed = true -- 启用速度指示器
uiGraph = false -- 启用速度图
uiGraphJumps = false -- 速度图显示跳跃

uiGraphWidth = 200 -- 速度图形宽度（最小值：0，最大值：700，默认值：250）
uiGraphMaxY = 400 -- 速度图形最大速度（最小值：0，最大值：5000，默认值：400）

bMakeGraphScalableWithResolution = false -- 导致忽略uiGraphWidth和uiGraphMaxY，而是根据屏幕大小动态计算图形大小

bRenderBoxGlobal = false -- 在图形周围渲染一个长方体。需要启用分辨率的bmakraphScalable才能工作
boxColor = {255, 255, 255, 100} -- rgba格式的方框颜色

uiGraphCompression = 4 -- 速度图压缩
uiGraphFreq = 0 -- 速度图延迟（最小值：0，最大值：150，默认值：0）
uiGraphSpread = 10 -- 速度图传播（最小：0，最大50，默认值10）
uiGraphAlpha = 255 -- 速度图alpha（最小值：0，最大值：255，默认值：255）

bRainbowColor = false -- 彩虹色主开关
bRainbowCurve = false -- 将图形曲线颜色更改为彩虹
bRainbowBox = false -- 将boxColor变量更改为彩虹
bRainbowIndicator = false -- 将速度指示器颜色更改为彩虹

-- 设定结束 --
local font1 = draw.CreateFont("Trebuchet MS", 17, 1000)
local font2 = draw.CreateFont("Trebuchet MS", 25, 800)

lastVel = 0
tickPrev = 0
history = {} -- 在运行脚本时更改上述变量时将其设置为空（如果您实现gui）
lastGraph = 0

jumpTime = 0
jumping = false
jumpPos = nil
landPos = nil
jumpSpeed = nil

lastJump = 0
graphSetJump = false
graphSetLand = false

text = nil

lastYaw = 0

last_realtime = globals.RealTime()
FL_ONGROUND = bit.lshift(1,0)
FL_PARTIALGROUND = bit.lshift(1,18)

local function get_local_player()
    local player = entities.GetLocalPlayer()
    if player == nil then return end
    if (not player:IsAlive()) then
        player = player:GetPropEntity("m_hObserverTarget")
    end
    return player
end

local function round(number, decimals)
    local power = (10 ^ decimals)
    return (math.floor(number * power) / power)
end

local function colour(dist)
    if dist >= 235 then
        return {255, 137, 34}
    elseif dist >= 230 then
        return {255, 33, 33}
    elseif dist >= 227 then
        return {57, 204, 96}
    elseif dist >= 225 then
        return {91, 225, 255}
    else
        return {170, 170, 170}
    end
end

local function speedgraph(vel, x, y, tickNow, bShouldRenderBox)
    if(bShouldRenderBox and bRenderBoxGlobal) then
        draw.Color(boxColor[1], boxColor[2], boxColor[3], boxColor[4])
        
        if(bRainbowColor and bRainbowBox) then
            draw.Color( (math.sin(globals.RealTime()) * 255), (math.cos(globals.RealTime()) * 255), (math.tan(globals.RealTime()) * 255), 255)
        end

        draw.OutlinedRect(x - (x * 0.13), y - (y * 0.1582), x + (x * 0.1325), y + (y * 0.0011454753722795)) -- 第一个“ y”是故意偏离的一点，因此您可以通过选中框来分辨最大速度和0速度之间的差异
    end

    local sx, sy = draw.GetScreenSize()

    local alpha = uiGraphAlpha
    local graphMaxY = uiGraphMaxY
    local w = uiGraphWidth
    
    if(bMakeGraphScalableWithResolution) then
        graphMaxY = (sy * 0.37)
        w = (sx * 0.1302083)
    end

    local graphCompression = uiGraphCompression

    local graphFreq = uiGraphFreq
    local graphSpread = (uiGraphSpread / 10)

    x = x - (w / 2)

    if(jumpSpeed == nil) then
        jumpSpeed = 0
    end

    if (lastGraph + graphFreq < tickNow) then
        local temp = {}
        temp.vel = math.min(vel, graphMaxY)
        if graphSetJump then
            graphSetJump = false
            temp.jump = true
            temp.jumpSpeed = jumpSpeed
            temp.jumpPos = jumpPos
        end

        if graphSetLand then
            graphSetLand = false
            temp.landed = true
            temp.landPos = landPos
        end

        table.insert(history, temp)
        lastGraph = tickNow
    end

    local over = #history - w / graphSpread
    if over > 0 then
        table.remove(history, 1)
    end

    for i = 2, #history, 1 do
        local val = history[i].vel
        local prevVal = history[i].vel

        local curX = x + ((i * graphSpread))
        local prevX = x + ((i - 1) * graphSpread)

        local curY = y - (val / graphCompression)
        local prevY = y - (prevVal / graphCompression)

        if (uiGraphJumps) then
            if history[i].jump then
                local index

                for q = i + 1, #history, 1 do
                    if history[q].jump then
                        index = q
                        break
                    end

                    if history[q].landed then
                        index = q
                        break
                    end
                end

                local above = 13

                if index then
                    if history[index].landPos and history[index].landPos[1] then
                        local jSpeed = history[i].jumpSpeed
                        local lSpeed = history[index].vel

                        local speedGain = lSpeed - jSpeed

                        if speedGain > -100 then
                            local jPos = history[i].jumpPos[1]
                            local lPos = history[index].landPos[1]
                        
                            

                            distX = (lPos.x - jPos.x)
                            distY = (lPos.y - jPos.y)
                            
                           

                            local distance = math.sqrt( (distX ^ 2) + (distY ^ 2) ) + 32

                            if distance > 150 then
                                local jumpX = curX - 1
                                local jumpY = curY

                                local landX = x + (index * graphSpread)
                                local landY = y - (history[index].vel / graphCompression)

                                local topY = landY - above
                                if topY > jumpY or topY > jumpY - above then
                                    topY = jumpY - above
                                end

                                draw.Color(255, 255, 255, math.max(alpha - 55, 50))
                                
                                if(bRainbowColor and bRainbowCurve) then
                                    draw.Color( (math.sin(globals.RealTime()) * 255), (math.cos(globals.RealTime()) * 255), (math.tan(globals.RealTime()) * 255), alpha)
                                end
                                
                                draw.Line(jumpX, jumpY, jumpX, topY)
                                draw.Line(landX, topY, landX, landY)

                                

                                text = speedGain > 0 and "+" or ""
                                text = text .. math.floor(speedGain+0.5)

                                local middleX = ((jumpX + landX) / 2) - 10

                                draw.Color(255, 255, 255, alpha)
                                draw.Text(middleX, topY - 13, text)

                                local ljColour = colour(distance)
                                draw.Color(ljColour[1], ljColour[2], ljColour[3], alpha)
                                draw.Text(middleX, topY , "(" .. math.floor(distance+0.5) .. ")")
                            end
                        end
                    end
                end
            end
        end 

        draw.Color(255, 255, 255, alpha)
        draw.SetFont(font1)
        if(bRainbowColor and bRainbowCurve) then
            draw.Color( (math.sin(globals.RealTime()) * 255), (math.cos(globals.RealTime()) * 255), (math.tan(globals.RealTime()) * 255), alpha)
        end
        draw.Line(prevX, prevY, curX, curY)
    end
end

callbacks.Register("Draw", function()
    draw.SetFont(font2)
    if not uiSpeed and not uiGraph then
        return
    end
    
    if get_local_player() == nil then return end

    local sx, sy = draw.GetScreenSize()

    local flags = get_local_player():GetPropInt("m_fFlags")
    if flags == nil then return end
    local onground = bit.band(flags, 1) ~= 0
    
    local movetype = get_local_player():GetPropInt("m_iMoveState") -- 这不是获取“ movetype”的正确方法
    
    if movetype == 2 then -- 在梯子上移动并滑行
        jumping = false
        landPos = {nil, nil, nil}
        graphSetLand = true
        return
    end
    
    if not onground and not jumping then
        local x, y, z = get_local_player():GetAbsOrigin()
        if x == nil then return end

        local vx = get_local_player():GetPropFloat("localdata", "m_vecVelocity[0]")
        local vy = get_local_player():GetPropFloat("localdata", "m_vecVelocity[1]")
        
        if vx == nil then return end

        graphSetJump = true
        jumping = true
        jumpPos = {x, y, z}
        jumpSpeed = math.floor(math.min(10000, math.sqrt(vx*vx + vy*vy) + 0.5))

        local thisTick = globals.TickCount()
        lastJump = thisTick

        if last_realtime + 4 < globals.RealTime() then
            if lastJump == thisTick then
                jumpSpeed = nil
            end
            last_realtime = globals.RealTime()
        end
    end

    if jumping and onground then
        local x, y, z = get_local_player():GetAbsOrigin()
        if x == nil then return end

        jumping = false
        landPos = {x, y, z}
        graphSetLand = true
    end
    

    if (get_local_player() == nil) then return end

    local vx = get_local_player():GetPropFloat("localdata", "m_vecVelocity[0]")
    local vy = get_local_player():GetPropFloat("localdata", "m_vecVelocity[1]")
        
    if vx ~= nil then
        local velocity = math.floor(math.min(10000, math.sqrt(vx*vx + vy*vy) + 0.5))

        local x = (sx / 2)
        local y = (sy / 1.2)

        if (uiSpeed) then
            local r, g, b = 255, 255, 255

            if lastVel < velocity then
                r, g, b = 30, 255, 109
            end

            if lastVel == velocity then
                r, g, b = 138,43,226
            end

            if lastVel > velocity then
                r, g, b = 255, 119, 119
            end

            local text = velocity
        
            if jumpSpeed then
                text = text .. " (" .. jumpSpeed .. ")"
            end

            draw.Color(r, g, b, 255)
            
            if(bRainbowColor and bRainbowIndicator) then
                draw.Color((math.sin(globals.RealTime()) * 255), (math.cos(globals.RealTime()) * 255), (math.tan(globals.RealTime()) * 255), 255)
            end
            
            if(velocity == 0) then
                draw.Text(x - (x * 0.0275), y, text)
            else
                draw.Text(x - (x * 0.0520), y, text)
            end
        end

        local tickNow = globals.TickCount()
        if (uiGraph) then
            if(bMakeGraphScalableWithResolution == false) then-- 如果图形大小是手动设置的，那么不要渲染长方体，因为它会被破坏
                
                speedgraph(velocity, x, y - (y*0.03), tickNow, false)
            else
                speedgraph(velocity, x, y - (y*0.03), tickNow, true)
            end
            
        end

        if tickPrev + 5 < tickNow then
            lastVel = velocity
            tickPrev = tickNow
        end
    end
end)

client.AllowListener("player_connect_full");
callbacks.Register("FireGameEvent", function(event)
    tickPrev = globals.TickCount()
    lastGraph = globals.TickCount()
end)
local drawetxtShadow_x = gui.Slider( gui.Reference( "Visuals" , "Local"  ), "drawetxtShadow_x", "X", 400 , 0 , 100 );local drawetxtShadow_y = gui.Slider( gui.Reference( "Visuals" , "Local"  ), "drawetxtShadow_y", "Y", 100 , 0 , 100 );drawetxtShadow_x:SetInvisible( true );drawetxtShadow_y:SetInvisible( true );

--[[
Working on aimware leg shaking
Source code from https://aimware.net/forum/thread/144904
Recoding qi
]]

--gui
local legshaking = gui.Checkbox(gui.Reference("Misc","Movement","Other"),"legfucker","legshaking", false)
local legshakingtime = gui.Slider(gui.Reference("Misc","Movement","Other"), "legshaking.time", "legshaking Interval time", 0.00, 0.00, 0.2, 0.01)

--var
local time = globals.CurTime()
local state = true

--function

local function Onlegshaking()
    if globals.CurTime() > time then
        state = not state
        time = globals.CurTime() + legshakingtime:GetValue()
        entities.GetLocalPlayer():SetPropInt(0, "m_flPoseParameter")
    end
    gui.SetValue("misc.slidewalk", state)
end

--callbacks
callbacks.Register("Draw", function()

    if entities.GetLocalPlayer() and legshaking:GetValue() then 
        entities.GetLocalPlayer():SetPropInt(1, "m_flPoseParameter")
        Onlegshaking()
    end
end)
--end

--[[
Working on aimware picture circle
by qi
]]

--gui
local X, Y = draw.GetScreenSize()
local Enemy_information_Reference = gui.Reference("Misc", "General", "Extra")
local Enemy_information_Enable = gui.Checkbox(Enemy_information_Reference, "enemyinformation", "Enemy information watermark", 0)
local Enemy_information_Clr = gui.ColorPicker(Enemy_information_Enable, "clr", "clr", 169, 251, 255, 100)
local Enemy_information_Clr2 = gui.ColorPicker(Enemy_information_Enable, "clr2", "clr2", 171, 77, 255, 100)
local Enemy_information_X = gui.Slider(Enemy_information_Enable, "x", "x", 400, 0, X)
local Enemy_information_Y = gui.Slider(Enemy_information_Enable, "y", "y", 400, 0, Y)

Enemy_information_X:SetInvisible(true)
Enemy_information_Y:SetInvisible(true)
--var
local font = draw.CreateFont("Verdana", 12)
local renderer = {}
local MENU = gui.Reference("MENU")
local tX, tY, offsetX, offsetY, _drag

--function

--renderer text
renderer.text = function(x, y, clr, shadow, string, font, flags)

    local alpha = 255
    local textW, textH = draw.GetTextSize(string)

    if font ~= nil then
        draw.SetFont(font)
    end

    if clr[4] ~= nil then
        alpha = clr[4]
    end

    if flags == "c" then
        x = x - (textW / 2)
    elseif flags == "l" then
        x = x - textW
    elseif flags == "r" then
        x = x + textW
    end

    if shadow then
        draw.Color(0, 0, 0, alpha)
        draw.Text(x + 1, y + 1, string)
    end

    draw.Color(clr[1], clr[2], clr[3], alpha)
	draw.Text(x, y, string)
    alpha = nil
    x, y = nil
end

--renderer rectangle
renderer.rectangle = function(x, y, w, h, clr, fill, radius)

    local alpha = 255

    if clr[4] ~= nil then
        alpha = clr[4]
    end

    draw.Color(clr[1], clr[2], clr[3], alpha)

    if fill then
        draw.FilledRect(x, y, x + w, y + h)
    else
        draw.OutlinedRect(x, y, x + w, y + h)
    end

    if fill == "shadow" then
        draw.ShadowRect(x, y, x + w, y + h, radius)
    end

    alpha = nil
end


--renderer line
renderer.line = function(x, y, w, h, clr)

    local alpha = 255

    if clr[4] ~= nil then
        alpha = clr[4]
    end

    draw.Color(clr[1], clr[2], clr[3], alpha)
    draw.Line(x, y, x + w, y + h)
    alpha = nil
end

--Mouse drag
local function is_inside(a, b, x, y, w, h) 
    return 
    a >= x and a <= w and b >= y and b <= h 
end
local function drag_menu(x, y, w, h)
    if not MENU:IsActive() then
        return tX, tY
    end
    local mouse_down = input.IsButtonDown(1)
    if mouse_down then
        local X, Y = input.GetMousePos()
        if not _drag then
            local w, h = x + w, y + h
            if is_inside(X, Y, x, y, w, h) then
                offsetX, offsetY = X - x, Y - y
                _drag = true
            end
        else
            tX, tY = X - offsetX, Y - offsetY
            Enemy_information_X:SetValue(tX) 
            Enemy_information_Y:SetValue(tY)
        end
    else
        _drag = false
    end
    return tX, tY
end

--Let drag position save
local function PositionSave()
    if tX ~= Enemy_information_X:GetValue() or tY ~= Enemy_information_Y:GetValue() then
        tX, tY = Enemy_information_X:GetValue(), Enemy_information_Y:GetValue()
    end
end

local function getenemy()
    local enemy = {}
    local lp = entities.GetLocalPlayer()
    if lp ~= nil then
      local players = entities.FindByClass("CCSPlayer")
        for i = 1, #players do
            local players = players[i]
            local name = players:GetName()
            if players:GetTeamNumber() ~= lp:GetTeamNumber() then
                table.insert(enemy, players)
            end
        end
    end 
    return enemy
end

local function string_len(var, frequency)
    if string.len(var) > frequency then
        var = string.match(var, [[.....]])
        var = var.."..."
    end
    return var
end

local function Ondraw(enemy)
    
    local x, y = drag_menu(tX, tY, 400, 100)

    local r, g, b, a = Enemy_information_Clr:GetValue()
    local r2, g2, b2, a2 = Enemy_information_Clr2:GetValue()
    local i = 0
    for index, players in pairs(enemy) do
        i = index
    end
    renderer.rectangle(x, y, 400, 20 + (i * 20), {r, g, b, a}, "shadow", 5)

    renderer.line(x, y + 15, 400, 0, {r2, g2, b2, a2})
    renderer.line(x + 45, y + 15, 0, 5 + (i * 20), {r2, g2, b2, a2})
    renderer.line(x + 85, y + 15, 0, 5 + (i * 20), {r2, g2, b2, a2})
    renderer.line(x + 135, y + 15, 0, 5 + (i * 20), {r2, g2, b2, a2})
    renderer.line(x + 175, y + 15, 0, 5 + (i * 20), {r2, g2, b2, a2})

    renderer.text(x + 10, y + 4, {255, 255, 255, 255}, true, "名字", font)
    renderer.text(x + 50, y + 4, {255, 255, 255, 255}, true, "血量", font)
    renderer.text(x + 95, y + 4, {255, 255, 255, 255}, true, "钱", font)
    renderer.text(x + 137, y + 4, {255, 255, 255, 255}, true, "护甲", font)
    renderer.text(x + 250, y + 4, {255, 255, 255, 255}, true, "武器", font)
    
    for index, players in pairs(enemy) do

        local ActiveWeapon = players:GetPropEntity("m_hActiveWeapon"):GetName()
        local Weapon = players:GetPropEntity("m_hMyWeapons", "002"):GetName()
        local Weapon2 = players:GetPropEntity("m_hMyWeapons", "001"):GetName()
        local Weapon3 = players:GetPropEntity("m_hMyWeapons", "000"):GetName()

        if ActiveWeapon then
            ActiveWeapon = string.match(ActiveWeapon, [[weapon_(.+)]])
        else
            ActiveWeapon = ""
        end

        if Weapon then
            Weapon = string.match(Weapon, [[weapon_(.+)]]).." , "
        else
            Weapon = ""
        end

        if Weapon2 then
            Weapon2= string.match(Weapon2, [[weapon_(.+)]]).." , "
        else
            Weapon2 = ""
        end

        if Weapon3 then
            Weapon3= string.match(Weapon3, [[weapon_(.+)]])
        else
            Weapon3 = ""
        end

        local health = players:GetHealth()
        
        if health > 75 then --Multiple blood colors
            hpr, hpg, hpb = 134, 200, 134
        elseif health > 60 then
            hpr, hpg, hpb = 171, 151, 106 
        elseif health > 40 then
            hpr, hpg, hpb = 190, 90, 90 
        elseif health > 20 then
            hpr, hpg, hpb = 200, 0, 60
        elseif health >= 0 then
            hpr, hpg, hpb = 255, 0, 0
        end
        
        if players:IsAlive() then
            IsAlive = 'true'
        else
            IsAlive = 'nil'
        end

        renderer.text(x + 5, y + (index * 20) + 5, {255, 255, 255, 255}, true, string_len(players:GetName(), 5), font)
        renderer.text(x + 50, y + (index * 20) + 5, {hpr, hpg, hpb, 255}, true, health.."hp", font)
        renderer.text(x + 92, y + (index * 20) + 5, {255, 255, 118, 255}, true, "$"..players:GetProp("m_iAccount"), font)
        renderer.text(x + 155, y + (index * 20) + 5, {255, 255, 255, 255}, true, IsAlive, font, "c")
        renderer.text(x + 185, y + (index * 20) + 5, {255, 255, 255, 255}, true, ActiveWeapon.."     "..Weapon..Weapon2..Weapon3, font)

    end

end


callbacks.Register("Draw", function()
    if entities.GetLocalPlayer() and Enemy_information_Enable:GetValue() then
        PositionSave()
        Ondraw(getenemy())
    end

end)

-- 简易汉化 不加汉化信息了 
-- 需要更多免费汉化Lua请加群 1093993910


function gradient(x1, y1, x2, y2, left)
    local w = x2 - x1
    local h = y2 - y1

    for i = 0, w do
        local a = (i / w) * 200

        draw.Color(0, 0, 0, a)
        if left then
            draw.FilledRect(x1 + i, y1, x1 + i + 1, y1 + h)
        else
            draw.FilledRect(x1 + w - i, y1, x1 + w - i + 1, y1 + h)
        end
    end
end

local frame_rate = 0.0
local get_abs_fps = function()
    frame_rate = 0.9 * frame_rate + (1.0 - 0.9) * globals.AbsoluteFrameTime()
    return math.floor((1.0 / frame_rate) + 0.5)
end


local kills  = {}
local deaths = {}

local function KillDeathCount(event)

    local local_player = client.GetLocalPlayerIndex( );
    local INDEX_Attacker = client.GetPlayerIndexByUserID( event:GetInt( 'attacker' ) );
    local INDEX_Victim = client.GetPlayerIndexByUserID( event:GetInt( 'userid' ) );

    if (event:GetName( ) == "client_disconnect") or (event:GetName( ) == "begin_new_match") then
        kills = {}
        deaths = {}
    end

    if event:GetName( ) == "player_death" then
        if INDEX_Attacker == local_player then
            kills[#kills + 1] = {};
        end
        
        if (INDEX_Victim == local_player) then
            deaths[#deaths + 1] = {};
        end

    end
end

function paint_traverse()
    local x, y = draw.GetScreenSize()
    local centerX = x / 2

    --left
    gradient(centerX - 200, y - 20, centerX - 51, y, 0, true)
    gradient(centerX - 200, y - 20, centerX - 51, y - 19, true)
   
    --middle
    draw.Color(0, 0, 0, 200)
    draw.FilledRect(centerX - 50, y - 20, centerX + 50, y)

    draw.Color(0, 0, 0, 255)
    draw.FilledRect(centerX - 50, y - 20, centerX + 50, y - 19)

    --right
    gradient(centerX + 50, y - 20, centerX + 200, y, false)
    gradient(centerX + 50, y - 20, centerX + 200, y - 19, false)

    --fps
    draw.Color(255, 255, 255, 255)
    draw.Text(centerX - 20, y - 15, get_abs_fps())

    draw.Color(200, 255, 0, 255)
    draw.Text(centerX + 10, y - 15, "FPS")

    --kills
    draw.Color(255, 255, 255, 255)
    draw.Text(centerX - 73, y - 15, #kills)

    draw.Color(255, 100, 0, 255)
    draw.Text(centerX - 55, y - 15, "击杀")

    --deaths
    draw.Color(255, 255, 255, 255)
    draw.Text(centerX + 47, y - 15, #deaths)

    draw.Color(255, 50, 50, 255)
    draw.Text(centerX + 65, y - 15, "死亡")
end

client.AllowListener( "player_death" );
client.AllowListener( "client_disconnect" );
client.AllowListener( "begin_new_match" );
callbacks.Register( "FireGameEvent", "KillDeathCount", KillDeathCount);
callbacks.Register("Draw", "paint_traverse", paint_traverse);

--圆环绘制By 柒
local thickness = gui.Slider(gui.Reference("Visuals" , "Local" , "Helper"), "x", "血量指示器厚度", 5 , 0 , 100);
--alpha 一个简单的动画
local function alpha_stop(val, min, max)
    if val < min then return min end
    if val > max then return max end
    return val;
end
--Circular 圆环函数
local function Circular(x, y, radius, number, thickness)--x, y, 半径, 循环次数, 厚度 

    if thickness > radius then
        thickness = radius
    end

    for steps = 1, number, 1 do   

        local sin_cur = math.sin(math.rad(steps))
        local sin_old = math.sin(math.rad(steps - 1))
        local cos_cur = math.cos(math.rad(steps))
        local cos_old = math.cos(math.rad(steps - 1))
        local cur_point = nil
        local old_point = nil
        local cur_point = {x + sin_cur * radius, y + cos_cur * radius}    
        local old_point = {x + sin_old * radius, y + cos_old * radius}
        local cur_point2 = nil
        local old_point2 = nil
        local cur_point2 = {x + sin_cur * (radius - thickness), y + cos_cur * (radius - thickness)}    
        local old_point2 = {x + sin_old * (radius - thickness), y + cos_old * (radius - thickness)}

        draw.Triangle(cur_point[1], cur_point[2], old_point[1], old_point[2], old_point2[1], old_point2[2])
        draw.Triangle(cur_point2[1], cur_point2[2], old_point2[1], old_point2[2], cur_point[1], cur_point[2])   
    
    end

end

--环形血量护甲指示器 By An

function hudthing()
    if entities.GetLocalPlayer() ~= nil then
        local x, y = draw.GetScreenSize()
        local hp = entities.GetLocalPlayer():GetProp("m_iHealth")
        local armor = entities.GetLocalPlayer():GetProp("m_ArmorValue")

        local money = entities.GetLocalPlayer():GetProp("m_iAccount");
        local inBuyZone = entities.GetLocalPlayer():GetProp("m_bInBuyZone")
        local haskit = entities.GetLocalPlayer():GetProp("m_bHasDefuser")
        local team = entities.GetLocalPlayer():GetProp("m_iTeamNum")
        client.SetConVar("hidehud", 8200, true)
        local font = draw.CreateFont("Arial", 26, 555)
        draw.SetFont(font)

        if hp > 0 then 
            draw.Color(255, 255, 255, 235)
            draw.TextShadow(50,y-50, "HP")
            draw.Color(159, 202, 43, 255) 
            draw.TextShadow(90,y-50, hp) 
        end

        if hp == 100 then
            draw.Color(20,20, 20,135)
            Circular(160, y-42, 13, 360, thickness:GetValue())
            draw.Color(159, 202, 43, 255) 
            Circular(160, y-42, 13, hp*3.6, thickness:GetValue()) 
        elseif hp > 0 then
            draw.Color(20,20, 20,135)
            Circular(150, y-42, 13, 360, thickness:GetValue())
            draw.Color(159, 202, 43, 255) 
            Circular(150, y-42, 13, hp*3.6, thickness:GetValue()) 
        end

        if armor > 0 then
            draw.Color(255, 255, 255, 235)
            draw.TextShadow(200, y-50, "ARMOR")
            draw.Color(52, 152, 219, 255)
            draw.TextShadow(300, y-50, armor)
        end
        if armor == 100 then
            draw.Color(20,20, 20,135)
            Circular(370, y-42, 13, 360, thickness:GetValue()) 
            draw.Color(52, 152, 219, 255)
            Circular(370, y-42, 13, armor*3.6, thickness:GetValue()) 
        elseif armor > 0 then
            draw.Color(20,20, 20,135)
            Circular(360, y-42, 13, 360, thickness:GetValue()) 
            draw.Color(52, 152, 219, 255)
            Circular(360, y-42, 13, armor*3.6, thickness:GetValue()) 
        end
    end 
end

callbacks.Register("Draw", "aaa", hudthing);

--Vote revealer by Cheeseot, improved upon & ported to V5 by Dracer

local activeVotes = {};
local font = draw.CreateFont('Arial', 14, 14);
local votecolor = {};
local animend = 0;
local votername = ""
local votetype = 0
local votetarget = ""
local enemyvote = 0
local yescount = 0
local nocount = 0
local voteresult = 0
local displayed = 0
local g_Group = gui.Groupbox(gui.Reference("MISC", "Enhancement"), "Vote Revealer", 327,315, 297)
local g_BroadcastMode = gui.Combobox(g_Group, "msc_voterevealer_broadcast", "Vote Revealer Broadcast Mode", "Off", "Broadcast Team", "Broadcast All", "Broadcast Console")
local g_Draw = gui.Checkbox(g_Group, "msc_voterevealer_draw", "Vote Revealer Draw", false)
local g_DrawVotes = gui.Checkbox(g_Group, "msc_voterevealer_drawvotes", "Vote Revealer Draw Votes", false)
g_Draw:SetValue(true)
g_DrawVotes:SetValue(true)

local timer = timer or {}
local timers = {}

local function timerCreate(name, delay, times, func)

  table.insert(timers, {["name"] = name, ["delay"] = delay, ["times"] = times, ["func"] = func, ["lastTime"] = globals.RealTime()})

end

local function timerRemove(name)

  for k,v in pairs(timers or {}) do

    if (name == v["name"]) then table.remove(timers, k) end

  end

end

local function timerTick()

  for k,v in pairs(timers or {}) do

    if (v["times"] <= 0) then table.remove(timers, k) end

    if (v["lastTime"] + v["delay"] <= globals.RealTime()) then
      timers[k]["lastTime"] = globals.RealTime()
      timers[k]["times"] = timers[k]["times"] - 1
      v["func"]()
    end

  end

end

callbacks.Register( "Draw", "timerTick", timerTick);

local function startTimer()
  timerCreate("sleep", 4, 1, function() animend = 1; enemyvote = 0; voteresult = 0; displayed = 0 end)
end

local function getVoteEnd(um)
  if gui.GetValue("misc.master") == false then return end
  if um:GetID() == 47 or um:GetID() == 48 then
    startTimer()
    yescount = 0
    nocount = 0
    enemyvote = 2

    if um:GetID() == 47 then
      voteresult = 1
      if (g_BroadcastMode:GetValue() == 1) then
        client.ChatTeamSay("Vote Passed")
      elseif (g_BroadcastMode:GetValue() == 2) then
        client.ChatSay("Vote Passed")
      elseif (g_BroadcastMode:GetValue() == 3) then
        print("Vote Passed")
      end
    end
    if um:GetID() == 48 then
      voteresult = 2
      if (g_BroadcastMode:GetValue() == 1) then
        client.ChatTeamSay("Vote Failed")
      elseif (g_BroadcastMode:GetValue() == 2) then
        client.ChatSay("Vote Failed")
      elseif (g_BroadcastMode:GetValue() == 3) then
        print("Vote Failed")
      end
    end
  end

  if um:GetID() == 46 then
    local localPlayer = entities.GetLocalPlayer();
    local team = um:GetInt(1)
    local idx = um:GetInt(2)
    votetype = um:GetInt(3)
    votetarget = um:GetString(5)
    votername = client.GetPlayerNameByIndex(idx)
    if localPlayer:GetTeamNumber() ~= team and votetype ~= 1 then
      enemyvote = 1
      displayed = 1
    end

    if votetype == 0 then
      votetypename = "kick player: "
    elseif votetype == 6 then
      votetypename = "Surrender"
    elseif votetype == 13 then
      votetypename = "Call a timeout"
    end

    if (g_BroadcastMode:GetValue() == 1) then
      client.ChatTeamSay(votername .. " wants to " .. votetypename .. votetarget)
    elseif (g_BroadcastMode:GetValue() == 2) then
      client.ChatSay(votername .. " wants to " .. votetypename .. votetarget)
    elseif (g_BroadcastMode:GetValue() == 3) then
      print(votername .. " wants to " .. votetypename .. votetarget)
    end
  end
  end;

  callbacks.Register("DispatchUserMessage", getVoteEnd)

  -- Vote revealer by Cheeseot


  local function add(time, ...)
    table.insert(activeVotes, {
      ["text"] = { ... },
      ["time"] = time,
      ["delay"] = globals.RealTime() + time,
      ["color"] = {votecolor, {10, 10, 10}},
      ["x_pad"] = -11,
      ["x_pad_b"] = -11,
    })
  end

  local function getMultiColorTextSize(lines)
    local fw = 0
    local fh = 0;
    for i = 1, #lines do
      draw.SetFont(font);
      local w, h = draw.GetTextSize(lines[i][4])
      fw = fw + w
      fh = h;
    end
    return fw, fh
  end

  local function drawMultiColorText(x, y, lines)
    local x_pad = 0
    for i = 1, #lines do
      local line = lines[i];
      local r, g, b, msg = line[1], line[2], line[3], line[4]
      draw.SetFont(font);
      draw.Color(r, g, b, 255);
      draw.Text(x + x_pad, y, msg);
      local w, _ = draw.GetTextSize(msg)
      x_pad = x_pad + w
    end
  end

  local function showVotes(count, color, text, layer)
    local y = 650 + (42 * (count - 1));
    local w, h = getMultiColorTextSize(text)
    local mw = w < 50 and 50 or w
    if globals.RealTime() < layer.delay then
      if layer.x_pad < mw then layer.x_pad = layer.x_pad + (mw - layer.x_pad) * 0.05 end
      if layer.x_pad > mw then layer.x_pad = mw end
      if layer.x_pad > mw / 1.09 then
        if layer.x_pad_b < mw - 6 then
          layer.x_pad_b = layer.x_pad_b + ((mw - 6) - layer.x_pad_b) * 0.05
        end
      end
      if layer.x_pad_b > mw - 6 then
        layer.x_pad_b = mw - 6
      end
    elseif animend == 1 then
      if layer.x_pad_b > -11 then
        layer.x_pad_b = layer.x_pad_b - (((mw - 5) - layer.x_pad_b) * 0.05) + 0.01
      end
      if layer.x_pad_b < (mw - 11) and layer.x_pad >= 0 then
        layer.x_pad = layer.x_pad - (((mw + 1) - layer.x_pad) * 0.05) + 0.01
      end
      if layer.x_pad < 0 then
        table.remove(activeVotes, count)
      end
    end
    local c1 = color[1]
    local c2 = color[2]
    local a = 255;
    if(g_DrawVotes:GetValue()) then
      draw.Color(c1[1], c1[2], c1[3], a);
      draw.FilledRect(layer.x_pad - layer.x_pad, y, layer.x_pad + 28, (h + y) + 20);
      draw.Color(c2[1], c2[2], c2[3], a);
      draw.FilledRect(layer.x_pad_b - layer.x_pad, y, layer.x_pad_b + 22, (h + y) + 20);
      drawMultiColorText(layer.x_pad_b - mw + 18, y + 9, text)
    end
  end

  -- Vote revealer by Cheeseot


  local function voteCast(e)
    if gui.GetValue("misc.master") == false then return end
    if (e:GetName() == "vote_cast") then
      timerRemove("sleep")
      animend = 0;
      local index = e:GetInt("entityid");
      local vote = e:GetInt("vote_option");
      local name = client.GetPlayerNameByIndex(index)

      local votearray = {};
      local namearray = {};
      if vote == 0 then
        votearray = { 150, 185, 1, "是" }
        namearray = { 150, 185, 1, name }
        votecolor = { 150, 185, 1}
        yescount = yescount + 1
      elseif vote == 1 then
        votearray = { 185, 20, 1, "否" }
        namearray = { 185, 20, 1, name }
        votecolor = { 185, 20, 1}
        nocount = nocount + 1
      else
        votearray = { 150, 150, 150, "??" }
        namearray = { 150, 150, 150, name }
        votecolor = { 150, 150, 150}
      end

      if (g_BroadcastMode:GetValue() == 1) then
        client.ChatTeamSay(name .. " 投票: " .. votearray[4])
      elseif (g_BroadcastMode:GetValue() == 2) then
        client.ChatSay(name .. " 投票: " .. votearray[4])
      elseif (g_BroadcastMode:GetValue() == 3) then
        print(name .. " 投票: " .. votearray[4])
      end

      add(3,
      namearray,
      { 255, 255, 255, " 投票: " },
      votearray,
      { 255, 255, 255, "   " });
    end
    end;

    callbacks.Register('FireGameEvent', voteCast)

    local function makeVote()
      for index, votes in pairs(activeVotes) do
        showVotes(index, votes.color, votes.text, votes)
      end
      end;

      callbacks.Register('Draw', makeVote)

      client.AllowListener("vote_cast")


      local function drawVote()
        if gui.GetValue("misc.master") == false then return end
        local font2 = draw.CreateFont('msyh', 20, 20);
        draw.SetFont(font2)
        local votetypename = ""
        if(g_Draw:GetValue()) then
          if enemyvote == 1 then
            if votetype == 0 then
              votetypename = "踢出玩家: "
            elseif votetype == 6 then
              votetypename = "投降"
            elseif votetype == 13 then
              votetypename = "暂停"
            else return
            end
            draw.Color(255,150,0,255)
            draw.FilledRect(0, 525, draw.GetTextSize(votername .. " 选择 " .. votetypename .. votetarget) + 30, 625)
            draw.Color(10,10,10,255)
            draw.FilledRect(0, 525, draw.GetTextSize(votername .. " 选择 " .. votetypename .. votetarget) + 20, 625)
            draw.Color(150,185,1,255)
            draw.Text(5 + (draw.GetTextSize(votername .. " 选择 " .. votetypename .. votetarget) / 2) - 25 - (draw.GetTextSize("  Yes")), 595, yescount .. " Yes")
            draw.Color(185,20,1,255)
            draw.Text(5 + (draw.GetTextSize(votername .. " 选择 " .. votetypename .. votetarget) / 2) + 25 , 595, nocount .. " No")
            draw.Color(255,150,0,255)
            draw.Text(5, 550, votername)
            draw.Color(255,255,255,255)
            draw.Text(draw.GetTextSize(votername .. " ") + 5, 550, "选择 ")
            if votetype == 0 then draw.Color(255,255,255,255) else draw.Color(255,150,0,255) end
            draw.Text(draw.GetTextSize(votername .. " 选择 ") + 5, 550, votetypename)
            draw.Color(255,150,0,255)
            draw.Text(draw.GetTextSize(votername .. " 选择 " .. votetypename) + 5, 550, votetarget)
          elseif enemyvote == 2 and displayed == 1 then
            if voteresult == 1 then
              draw.Color(150,185,1,255)
              draw.FilledRect(0, 525, draw.GetTextSize(votername .. " 选择 " .. votetypename .. votetarget) + 30, 625)
              draw.Color(10,10,10,255)
              draw.FilledRect(0, 525, draw.GetTextSize(votername .. " 选择 " .. votetypename .. votetarget) + 20, 625)
              draw.Color(150,185,1,255)
              draw.Text(5, 575 - 10 , "投票通过.")
            elseif voteresult == 2 then
              draw.Color(185,20,1,255)
              draw.FilledRect(0, 525, draw.GetTextSize("投票失败.") + 110, 625)
              draw.Color(10,10,10,255)
              draw.FilledRect(0, 525, draw.GetTextSize("投票失败.") + 100, 625)
              draw.Color(185,20,1,255)
              draw.Text(50, 575 - 10, "投票失败.")
            end
          end
        end
      end

      callbacks.Register("Draw", drawVote)

      local function reset()
        if entities.GetLocalPlayer() == nil then
          enemyvote = 0;
          activeVotes = {};
          displayed = 0;
        end
      end
      callbacks.Register("Draw", reset)


local Font = draw.CreateFont("Microsoft Tai Le",22, 2000)--("Verdana", 24, 700)
local Font2 = draw.CreateFont("Marlett", 35, 700)
--local Font2 = draw.CreateFont("Marlett", 35, 700)

local screenW, screenH = draw.GetScreenSize()
local guiSet = gui.SetValue
local guiGet = gui.GetValue
local baim = 1;

 ------------------------------------------------ Window 
local Window = gui.Window( "semirageWindow", "暴力演技 Helper Ten汉化 ", 150, 150, 530, 700  )
Window:SetOpenKey( 45 )

--local TAB=gui.Tab(gui.Reference("Misc"), "semirage", "Extra")
local GROUPBOX_MAIN=gui.Groupbox(Window, "暴力演技多功能", 10, 10, 300)

local GROUPBOX_AIMBOT=gui.Groupbox(Window, "静默范围", 320, 380, 200)
 
local GROUPBOX_MISC=gui.Groupbox(Window, "杂项",320, 10, 200)--320, 10, 200
-----------------------------------------------------------Menu Items---------------------------------------------------------------
 
local KEYBOX_SWITCHBOT = gui.Keybox( GROUPBOX_MAIN, "switchBot", "合法暴力切换", 0 )
KEYBOX_SWITCHBOT:SetDescription("合法演技和暴力演技切换")

local KEYBOX_INVERTER=gui.Keybox(GROUPBOX_MAIN, "inverter", "假身切换", 0)
KEYBOX_INVERTER:SetDescription("假身左右切换")

local KEYBOX_AWSWITCH=gui.Keybox(GROUPBOX_MAIN, "awswitch", "凹凸按键", 0)
KEYBOX_AWSWITCH:SetDescription("绑定凹凸按键")

local KEYBOX_BAIM=gui.Keybox(GROUPBOX_MAIN, "baimkey", "强制攻击身体", 0)
KEYBOX_BAIM:SetDescription("绑定按键")
 

 
local KEYBOX_RESOLVERSWITCH=gui.Keybox(GROUPBOX_MAIN, "resolverswitch", "手动解析", 0)
KEYBOX_RESOLVERSWITCH:SetDescription("绑定按键手动开启/关闭解析")

  
local CHECKBOX_ALL = gui.Checkbox(GROUPBOX_MAIN, "IndicatorsALL", "开启暴力演技Helper", 0)


local IndX = gui.Slider(GROUPBOX_MAIN, "IndX", " 左右移动", 0, 0, screenW)
local IndY = gui.Slider(GROUPBOX_MAIN, "IndY", "上下移动", screenH/4*3, 0, screenH)

local ArrowX = gui.Slider(GROUPBOX_MAIN, "ArrowX", "假身指示器箭头上下移动", 1000, 0, screenW)
local ArrowY = gui.Slider(GROUPBOX_MAIN, "ArrowY", "假身指示器箭头左右移动", 526, 0, screenW)
--gui.Slider( parent, varname, name, value, min, max )

 
 
 
 -----------------------------------------------------------misc Things Menu---------------------------------------------------------------

local sniper_crosshair = gui.Checkbox(GROUPBOX_MISC, "sniper_crosshair", "狙击准星", false)

local aspect_ratio_check = gui.Checkbox(GROUPBOX_MISC, "aspect_ratio_check", "屏幕纵横比", false);
local ASPECT_SLIDER = gui.Slider( GROUPBOX_MISC, "aspectratio", "Aspect Ratio", 100, 1, 199)--gui.Combobox( GROUPBOX_MISC, "aspectratio", "Aspect Ratio", "OFF", "1.0", "1.5", "2.0" )
 


local SLIDER_VIEW = gui.Slider( GROUPBOX_MISC, "lua_fov_slider_view", "视野变换", 60, 0, 180 )
local SLIDER_VIEWX = gui.Slider( GROUPBOX_MISC, "lua_fov_slider_viewX", "手臂左右偏移", 1, -40, 40 )
local SLIDER_VIEWY = gui.Slider( GROUPBOX_MISC, "lua_fov_slider_viewY", "手臂前后偏移", 1, -40, 40 )
local SLIDER_VIEWZ = gui.Slider( GROUPBOX_MISC, "lua_fov_slider_viewZ", "手臂上下偏移", -1, -40, 40 ) 

 
-----------------------------------------------------------Aimbot things menu ---------------------------------------------------------------

local chk_dynfov = gui.Checkbox(GROUPBOX_AIMBOT, "chk_dynfov", "动态静默", false)
local sld_minfov = gui.Slider(GROUPBOX_AIMBOT, "sld_minfov", "最低FOV", 4, 0, 30)
local sld_maxfov = gui.Slider(GROUPBOX_AIMBOT, "sld_maxfov", "最大FOV", 10, 0, 30)
 -----------------------------------------------------------Indicators---------------------------------------------------------------

function indicatorsMala()

    if not entities.GetLocalPlayer() or not entities.GetLocalPlayer():IsAlive() then return end

    draw.SetFont(Font)

    if gui.GetValue( "rbot.master" ) then
          
     --baim indicator
    if CHECKBOX_ALL:GetValue() then 
        if (baim%2 == 0) then
            draw.Color(0, 255, 0, 255)
            draw.TextShadow(IndX:GetValue(), IndY:GetValue() - 20, "强制攻击身体开启")
        elseif (baim%2 == 1) then
            draw.Color(255, 0, 0, 255)
            draw.TextShadow(IndX:GetValue(), IndY:GetValue() - 20, "强制攻击身体关闭")
        end
    end

    --awall indicator
    if CHECKBOX_ALL:GetValue() then 
        if awtggl then
            draw.Color(0, 255, 0, 255)
            draw.TextShadow(IndX:GetValue(), IndY:GetValue() - 40, "凹凸开启")
        else
            draw.Color(255, 0, 0, 255)
            draw.TextShadow(IndX:GetValue(), IndY:GetValue() - 40, "凹凸关闭")
        end
    end

    -- resolver indicator

    if CHECKBOX_ALL:GetValue() then 
        if (gui.GetValue( "rbot.accuracy.posadj.resolver")) then 
            draw.Color( 0, 255, 0, 255)
            draw.TextShadow(IndX:GetValue(), IndY:GetValue() - 60, "解析器开启")
        else
            draw.Color(255, 0, 0, 255)
            draw.TextShadow(IndX:GetValue(), IndY:GetValue() - 60, "解析器关闭")
        end 
    end

    --dsc inv indicator
    if CHECKBOX_ALL:GetValue() then
        if invrtr then
            draw.Color(0,255,0,255)
            draw.TextShadow(IndX:GetValue(), IndY:GetValue() - 80, "假身方位:右")
        else
            draw.Color(0,255,0,255)
            draw.TextShadow(IndX:GetValue(), IndY:GetValue() - 80, "假身方位:左")
        end
    end

    --fov indicator
    if CHECKBOX_ALL:GetValue() then
        
        draw.Color(255,255,255,255)
        draw.TextShadow(IndX:GetValue(), IndY:GetValue() - 100, "静默: ")

        draw.Color(255,255,255,255)
        draw.TextShadow(IndX:GetValue() + 40, IndY:GetValue() - 100, gui.GetValue( "rbot.aim.target.fov" ))
        

    end
 end
if CHECKBOX_ALL:GetValue() then --legit / rage indicator

    if switchB then 

       draw.Color(100,100,255,255)
        draw.TextShadow(IndX:GetValue(), IndY:GetValue() - 120, "合法")
    else
        draw.Color(100,100,255,255)
        draw.TextShadow(IndX:GetValue(), IndY:GetValue() - 120, "暴力")
    end

end
 
 

end


callbacks.Register("Draw", "semiragehelper", indicatorsMala)
callbacks.Register("Draw", function()
 
    IndX:SetInvisible(not CHECKBOX_ALL:GetValue())
    IndY:SetInvisible(not CHECKBOX_ALL:GetValue())
ArrowX:SetInvisible(not CHECKBOX_ALL:GetValue())
ArrowY:SetInvisible(not CHECKBOX_ALL:GetValue())
end)
-------------------------------------------------AA inverter Arrow
 


function arrow()

    if not entities.GetLocalPlayer() or not entities.GetLocalPlayer():IsAlive() then return end

    if not gui.GetValue( "rbot.master" ) then return end

    draw.SetFont( Font2 )
     

        if CHECKBOX_ALL:GetValue() then
            if invrtr then

                draw.Color(0,0,0,150)
                draw.TextShadow(ArrowX:GetValue() ,ArrowY:GetValue(), "►")

                draw.Color(255,255,255,255)
                draw.TextShadow( ArrowX:GetValue() - 120,ArrowY:GetValue(), "◄")

               -- draw.Color(255,0,0,255)
                --draw.TextShadow(ArrowX:GetValue() ,ArrowY:GetValue(), "4")
                --draw.TextShadow(ArrowX:GetValue() ,ArrowY:GetValue(), "a")
            else

                draw.Color(255,255,255,255)
                draw.TextShadow(ArrowX:GetValue() ,ArrowY:GetValue(), "►")

                draw.Color(0,0,0,150)
                draw.TextShadow( ArrowX:GetValue() - 120,ArrowY:GetValue(), "◄")

               
                
                --draw.Color(255,0,0,255)
               -- draw.TextShadow(ArrowX:GetValue() - 120 , ArrowY:GetValue(), "3")
               -- draw.TextShadow(ArrowX:GetValue() - 120 , ArrowY:GetValue(), "b")
                
            end
        end
    
    end
    callbacks.Register("Draw", "semiragehelper", arrow)
--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------Function---------------------------------------------------------------

-------------------------------------------------------- Toggle Awall

function awswitch()


    
    if KEYBOX_AWSWITCH:GetValue() ~= 0 then
        if input.IsButtonPressed(KEYBOX_AWSWITCH:GetValue()) then
            awtggl = not awtggl
        end
        if awtggl then
            
            gui.SetValue( "rbot.hitscan.mode.asniper.autowall", 1)
            gui.SetValue( "rbot.hitscan.mode.hpistol.autowall", 1)
            gui.SetValue( "rbot.hitscan.mode.lmg.autowall", 1)
            gui.SetValue( "rbot.hitscan.mode.pistol.autowall", 1)
            gui.SetValue( "rbot.hitscan.mode.shotgun.autowall", 1)
            gui.SetValue( "rbot.hitscan.mode.smg.autowall", 1)
            gui.SetValue( "rbot.hitscan.mode.scout.autowall", 1)
            gui.SetValue( "rbot.hitscan.mode.sniper.autowall", 1)
            gui.SetValue( "rbot.hitscan.mode.rifle.autowall", 1)

            gui.SetValue( "lbot.weapon.vis.asniper.autowall", 1)
            gui.SetValue( "lbot.weapon.vis.hpistol.autowall", 1)
            gui.SetValue( "lbot.weapon.vis.lmg.autowall", 1)
            gui.SetValue( "lbot.weapon.vis.pistol.autowall", 1)
            gui.SetValue( "lbot.weapon.vis.shotgun.autowall", 1)
            gui.SetValue( "lbot.weapon.vis.smg.autowall", 1)
            gui.SetValue( "lbot.weapon.vis.scout.autowall", 1)
            gui.SetValue( "lbot.weapon.vis.sniper.autowall", 1)
            gui.SetValue( "lbot.weapon.vis.rifle.autowall", 1)

        else
            gui.SetValue( "rbot.hitscan.mode.asniper.autowall", 0)
            gui.SetValue( "rbot.hitscan.mode.hpistol.autowall", 0)
            gui.SetValue( "rbot.hitscan.mode.lmg.autowall", 0)
            gui.SetValue( "rbot.hitscan.mode.pistol.autowall", 0)
            gui.SetValue( "rbot.hitscan.mode.shotgun.autowall", 0)
            gui.SetValue( "rbot.hitscan.mode.smg.autowall", 0)
            gui.SetValue( "rbot.hitscan.mode.scout.autowall", 0)
            gui.SetValue( "rbot.hitscan.mode.sniper.autowall", 0)
            gui.SetValue( "rbot.hitscan.mode.rifle.autowall", 0)

            gui.SetValue( "lbot.weapon.vis.asniper.autowall", 0)
            gui.SetValue( "lbot.weapon.vis.hpistol.autowall", 0)
            gui.SetValue( "lbot.weapon.vis.lmg.autowall", 0)
            gui.SetValue( "lbot.weapon.vis.pistol.autowall", 0)
            gui.SetValue( "lbot.weapon.vis.shotgun.autowall", 0)
            gui.SetValue( "lbot.weapon.vis.smg.autowall", 0)
            gui.SetValue( "lbot.weapon.vis.scout.autowall", 0)
            gui.SetValue( "lbot.weapon.vis.sniper.autowall", 0)
            gui.SetValue( "lbot.weapon.vis.rifle.autowall", 0)

        end
    end
end

callbacks.Register("Draw", "semiragehelper", awswitch)

-------------------------------------------------------- AA inverter

function finverter()
    --gui.SetValue( "rbot.antiaim.extra.advconfig", 1 )
    gui.SetValue( "rbot.antiaim.advanced.pitch", off)
     
    if KEYBOX_INVERTER:GetValue() ~= 0 then
        if input.IsButtonPressed(KEYBOX_INVERTER:GetValue()) then
            invrtr = not invrtr
        end
        if invrtr then
           
            --gui.SetValue("rbot.antiaim.fakeyawstyle", 1)
            gui.SetValue("rbot.antiaim.base", 0)
            gui.SetValue( "rbot.antiaim.base.rotation", -58 )
            gui.SetValue( "rbot.antiaim.base.lby", 139 )
        else
            gui.SetValue("rbot.antiaim.base", 0)
            gui.SetValue( "rbot.antiaim.base.rotation", 58 )
            gui.SetValue( "rbot.antiaim.base.lby", -139 )
            
           -- gui.SetValue("rbot.antiaim.fakeyawstyle", 2)

        end
    end
end

callbacks.Register("Draw", "semiragehelper", finverter)

 function switchBot()

    if KEYBOX_SWITCHBOT:GetValue() ~= 0 then
        if input.IsButtonPressed(KEYBOX_SWITCHBOT:GetValue()) then
            switchB = not switchB
        end
        if switchB then
            
            gui.SetValue("lbot.master", 1)
            gui.SetValue("rbot.master", 0)
        else
            gui.SetValue("lbot.master", 0)

            gui.SetValue("rbot.master", 1)

        end
    end

 end
callbacks.Register("Draw", "semiragehelper", switchBot)

--------------------------------------------------toggle resolver
function rslvSwitch()


    if KEYBOX_RESOLVERSWITCH:GetValue() ~= 0 then
        if input.IsButtonPressed(KEYBOX_RESOLVERSWITCH:GetValue()) then
           rslrswt = not rslrswt
        end
        if rslrswt then
            
            gui.SetValue("rbot.accuracy.posadj.resolver", 0)

        else

            gui.SetValue("rbot.accuracy.posadj.resolver", 1)

        end
    end

end

callbacks.Register( "Draw", "semiragehelper", rslvSwitch)


--------------------------------------------------Dynamic Fov(Pasted but nvm)


local viewangles;

local function dynamicfov_logic()
local pLocal = entities.GetLocalPlayer()

if not chk_dynfov:GetValue() then return end
if not pLocal then return end
if not pLocal:GetAbsOrigin() then return end

local dynamicfov_new_fov = gui.GetValue("rbot.aim.target.fov")
local players = entities.FindByClass("CCSPlayer")
local enemy_players = {}

local min_fov = sld_minfov:GetValue()
local max_fov = sld_maxfov:GetValue()

if min_fov > max_fov then
local store_min_fov = min_fov
min_fov = max_fov
max_fov = store_min_fov
end

for i = 1, #players do
if players[i]:GetPropInt("m_iTeamNum") ~= entities.GetLocalPlayer():GetPropInt("m_iTeamNum") and not players[i]:IsDormant() then
table.insert(enemy_players, players[i])
end
end

if #enemy_players ~= 0 then
local own_hitbox = pLocal:GetHitboxPosition(0)
local own_x, own_y, own_z = own_hitbox.x, own_hitbox.y, own_hitbox.z
closest_enemy = nil
local closest_distance = math.huge

for i = 1, #enemy_players do
local enemy = enemy_players[i]
local enemy_x, enemy_y, enemy_z = enemy:GetHitboxPosition(0).x, enemy:GetHitboxPosition(0).y, enemy:GetHitboxPosition(0).z
local x = enemy_x - own_x
local y = enemy_y - own_y
local z = enemy_z - own_z

local yaw = (math.atan2(y, x) * 180 / math.pi)
local pitch = -(math.atan2(z, math.sqrt(math.pow(x, 2) + math.pow(y, 2))) * 180 / math.pi)

end

if closest_enemy ~= nil then
local closest_enemy_x, closest_enemy_y, closest_enemy_z = closest_enemy:GetHitboxPosition(0).x, closest_enemy:GetHitboxPosition(0).y, closest_enemy:GetHitboxPosition(0).z
            local real_distance = math.sqrt(math.pow(own_x - closest_enemy_x, 2) + math.pow(own_y - closest_enemy_y, 2) + math.pow(own_z - closest_enemy_z, 2))

            dynamicfov_new_fov = max_fov - ((max_fov - min_fov) * (real_distance - 250) / 1000)
end
if (dynamicfov_new_fov > max_fov) then
            dynamicfov_new_fov = max_fov
        elseif dynamicfov_new_fov < min_fov then
            dynamicfov_new_fov = min_fov
        end

        dynamicfov_new_fov = math.floor(dynamicfov_new_fov + 0.5)

        if (dynamicfov_new_fov > closest_distance) then
            bool_in_fov = true
        else
            bool_in_fov = false
        end
    else
        dynamicfov_new_fov = min_fov
        bool_in_fov = false
    end

    if dynamicfov_new_fov ~= old_fov then
        gui.SetValue("rbot.aim.target.fov", dynamicfov_new_fov)
    end
end

callbacks.Register("Draw", "dynfov", dynamicfov_logic)

callbacks.Register("Draw", function()
sld_minfov:SetInvisible(not chk_dynfov:GetValue())
sld_maxfov:SetInvisible(not chk_dynfov:GetValue())
end)



--------------------------------------------Sniper Crosshair


function spr_crs()

    local player_local = entities.GetLocalPlayer();

   
 if not entities.GetLocalPlayer() or not entities.GetLocalPlayer():IsAlive() then return end
 

        if sniper_crosshair:GetValue() then 
        
            client.SetConVar( "weapon_debug_spread_show", 3, true )

        else

            client.SetConVar( "weapon_debug_spread_show", 0, true )

        end
     
end

callbacks.Register( "Draw", "spr_crs", spr_crs )

------------------------------------------------Baim On Key


function OnlybaimEnable()
    baimauto = guiGet("rbot.hitscan.points.asniper.scale")
    baimsniper = guiGet("rbot.hitscan.points.sniper.scale")
    baimpistol = guiGet("rbot.hitscan.points.pistol.scale")
    baimrevolver = guiGet("rbot.hitscan.points.hpistol.scale")
    baimsmg = guiGet("rbot.hitscan.points.smg.scale")
    baimrifle = guiGet("rbot.hitscan.points.rifle.scale")
    baimshotgun = guiGet("rbot.hitscan.points.shotgun.scale")
    baimscout = guiGet("rbot.hitscan.points.scout.scale")
    baimlmg = guiGet("rbot.hitscan.points.lmg.scale")

    gui.Command('rbot.hitscan.points.asniper.scale 0 0 0 0 5 0 0 0 ')
    gui.Command('rbot.hitscan.points.sniper.scale 0 0 0 0 5 0 0 0')
    gui.Command('rbot.hitscan.points.pistol.scale 0 0 0 0 5 0 0 0')
    gui.Command('rbot.hitscan.points.hpistol.scale 0 0 0 0 5 0 0 0')
    gui.Command('rbot.hitscan.points.smg.scale 0 0 0 0 5 0 0 0')
    gui.Command('rbot.hitscan.points.rifle.scale 0 0 0 0 5 0 0 0')
    gui.Command('rbot.hitscan.points.shotgun.scale 0 0 0 0 5 0 0 0')
    gui.Command('rbot.hitscan.points.scout.scale 0 0 0 0 5 0 0 0')
    gui.Command('rbot.hitscan.points.lmg.scale  0 0 0 0 5 0 0 0')
end

function OnlybaimDisable()
    gui.Command('rbot.hitscan.points.asniper.scale ' ..baimauto)
    gui.Command('rbot.hitscan.points.sniper.scale ' ..baimsniper)
    gui.Command('rbot.hitscan.points.pistol.scale ' ..baimpistol)
    gui.Command('rbot.hitscan.points.hpistol.scale ' ..baimrevolver)
    gui.Command('rbot.hitscan.points.smg.scale ' ..baimsmg)
    gui.Command('rbot.hitscan.points.rifle.scale ' ..baimrifle)
    gui.Command('rbot.hitscan.points.shotgun.scale ' ..baimshotgun)
    gui.Command('rbot.hitscan.points.scout.scale ' ..baimscout)
    gui.Command('rbot.hitscan.points.lmg.scale ' ..baimlmg)
end


function BaimOnKey()
    if KEYBOX_BAIM:GetValue() == 0 then return end
        if(input.IsButtonPressed(KEYBOX_BAIM:GetValue())) then
            baim = baim + 1;
        elseif(input.IsButtonDown) then
        -- do nothing
        end
        if(input.IsButtonReleased(KEYBOX_BAIM:GetValue())) then
                if (baim%2 == 0) then
    
                        OnlybaimEnable()
                        baim = 0;
                elseif (baim%2 == 1) then
                        OnlybaimDisable()
                        baim = 1;
                end
          
        end 
    
end
callbacks.Register( "Draw", "BaimOnKey", BaimOnKey )


-----------------------------------------------ViewModel FOV Changer
 

callbacks.Register( "Draw", function()
    if(entities.GetLocalPlayer() ~= nil and engine.GetServerIP() ~= nil and engine.GetMapName() ~= nil) then
        local a = 0
        local player_local = entities.GetLocalPlayer();
        local scoped = player_local:GetProp("m_bIsScoped")
 
          
        client.SetConVar("viewmodel_fov", SLIDER_VIEW:GetValue(), true)
        client.SetConVar("viewmodel_offset_x", SLIDER_VIEWX:GetValue(), true);
        client.SetConVar("viewmodel_offset_y", SLIDER_VIEWY:GetValue(), true);
        client.SetConVar("viewmodel_offset_z", SLIDER_VIEWZ:GetValue() + a, true);
    end
end)	

-----------------------------------------------aspect ratio 
local aspect_ratio_table = {};
 
 
 
local function gcd(m, n) while m ~= 0 do m, n = math.fmod(n, m), m; end return n end

local function set_aspect_ratio(aspect_ratio_multiplier)
local screen_width, screen_height = draw.GetScreenSize(); local aspectratio_value = (screen_width*aspect_ratio_multiplier)/screen_height;
if aspect_ratio_multiplier == 1 or not aspect_ratio_check:GetValue() then aspectratio_value = 0; end
client.SetConVar( "r_aspectratio", tonumber(aspectratio_value), true); end

local function on_aspect_ratio_changed()
local screen_width, screen_height = draw.GetScreenSize();
for i=1, 200 do local i2=i*0.01; i2 = 2 - i2; local divisor = gcd(screen_width*i2, screen_height); if screen_width*i2/divisor < 100 or i2 == 1 then aspect_ratio_table = screen_width*i2/divisor .. ":" .. screen_height/divisor; end end
local aspect_ratio = ASPECT_SLIDER:GetValue()*0.01; aspect_ratio = 2 - aspect_ratio; set_aspect_ratio(aspect_ratio); end
callbacks.Register('Draw', "does shit" ,on_aspect_ratio_changed)
--水印 --
callbacks.Register( "Draw", function()
    local screenW, screenH = draw.GetScreenSize()
    local r = math.floor(math.sin(globals.RealTime() * 1) * 100 + 127);
    local g = math.floor(math.sin(globals.RealTime() * 1 + 2) * 100 + 127);
    local b = math.floor(math.sin(globals.RealTime() * 1 + 4) * 100 + 127);
    draw.Color(r, g, b, 255);
    draw.TextShadow(0, screenH - 200, "By Ten Semirage" )
end)



