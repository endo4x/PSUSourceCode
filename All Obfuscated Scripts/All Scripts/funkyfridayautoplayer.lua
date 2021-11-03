--[[
	id: Pg6PMQK_RH5T5eTJoMFj6
	name: funky-friday-auto-player
	description: ok
	time1: 2021-04-29 01:05:06.969715+00
	time2: 2021-04-29 01:05:06.969715+00
	uploader: U1578-8W-zWxYja5nqxTXt1tF2CdIm4GfB-ouFKO
	uploadersession: 9lpN8dGVUFH5jgY4eX7hH_f63d-Fo9
	flag: f
--]]

local framework;
local funcs = {}

local islclosure = islclosure or is_l_closure
local getinfo = getinfo or debug.getinfo
local getupvalues = getupvalues or debug.getupvalues
local getconstants = getconstants or debug.getconstants

for i, v in next, getgc(true) do
    if type(v) == 'table' and rawget(v, 'GameUI') then
        framework = v;
    end

    if type(v) == 'function' and islclosure(v) then
        local info = getinfo(v);
        if info.name == '' then continue end
        
        if info.source:match('%.Arrows$') then
            local constants = getconstants(v);
            if table.find(constants, 'Right') and table.find(constants, 'NewThread') then
                funcs.KeyDown = v;
            elseif table.find(constants, 'Multiplier') and table.find(constants, 'MuteVoices') then
                funcs.KeyUp = v;
            end
        end
    end

    if framework and funcs.KeyUp and funcs.KeyDown then break end
end

if type(framework) ~= 'table' or (not rawget(framework, 'UI')) then
    return game.Players.LocalPlayer:Kick('Failed to locate framework.')
elseif (not (funcs.KeyDown and funcs.KeyUp)) then
    return game.Players.LocalPlayer:Kick('Failed to locate key functions.')
end


local marked = {}
local map = { [0] = 'Left', [1] = 'Down', [2] = 'Up', [3] = 'Right', }
local keys = { Up = Enum.KeyCode.W; Down = Enum.KeyCode.S; Left = Enum.KeyCode.A; Right = Enum.KeyCode.D; }

-- https://eryn.io/gist/3db84579866c099cdd5bb2ff37947cec
-- bla bla spawn and wait are bad 
-- can also use bindables for the fastspawn idc

local runService = game:GetService('RunService')

local fastWait, fastSpawn do
    function fastWait(t)
        local d = 0;
        while d < t do
            d += runService.RenderStepped:wait()
        end
    end

    function fastSpawn(f)
        coroutine.wrap(f)()
    end
end

while runService.RenderStepped:wait() do
    for _, arrow in next, framework.UI.ActiveSections do
        if arrow.Side ~= framework.UI.CurrentSide then continue end -- ignore the opponent's arrows
        if marked[arrow] then continue end -- ignore marked arrows so we dont spam them
        
        local index = arrow.Data.Position % 4
        local position = map[index] -- % 4 because the right side numbers are 4, 5, 6, 7 and are not in the key map
        if (not position) then continue end -- oh well the position got eaten

        local distance = (1 - math.abs(arrow.Data.Time - framework.SongPlayer.CurrentlyPlaying.TimePosition)) * 100 -- get the "distance" or whatever
        if distance >= 95 then -- if above a certain threshold, we do this
            marked[arrow] = true; -- mark the arrow
            fastSpawn(function()
                funcs.KeyDown(position)
                if arrow.Data.Length > 0 then
                    fastWait(arrow.Data.Length) -- usually these are held long enough
                else
                    fastWait(0.1) -- wait a tiny bit of time so the fucking animations play and you dont get called out as bad :)
                end
                funcs.KeyUp(position)
                marked[arrow] = nil
            end)
        end
    end
end