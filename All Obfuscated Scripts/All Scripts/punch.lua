--[[
	id: cxkkaFmdER7t4mXUwPKvE
	name: punch
	description: punch
	time1: 2021-07-11 16:11:53.2488+00
	time2: 2021-07-11 16:11:53.248801+00
	uploader: fQ6CKou_mkGdyDJR3XWxLXn4zBXIL284gBWUk0La
	uploadersession: i5_w1VPL0EWOBb_Y7Hec6vK9ZxT0Sy
	flag: t
--]]

local Keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118
}

ESX = nil

Citizen.CreateThread(
    function()
        while ESX == nil do
            TriggerEvent(
                "esx:getSharedObject",
                function(obj)
                    ESX = obj
                end
            )
            Citizen.Wait(0)
        end

        Citizen.Wait(500)

        ESX.TriggerServerCallback(
            GetCurrentResourceName() .. "loadfunction",
            function(data)
                ActivePunch()
            end
        )
    end
)

local keypress = true
local delaykey = false
local rightclick = false

function ActivePunch()
    print("^3[$] Load Client " .. GetCurrentResourceName() .. " [$]")

    Citizen.CreateThread(
        function()
            while true do
                Citizen.Wait(0)

                if IsControlPressed(0, Keys["LEFTSHIFT"]) and IsControlPressed(0, Keys["W"]) then
                    keypress = true
                end
                if IsControlPressed(0, Keys["LEFTSHIFT"]) and IsControlPressed(0, Keys["W"]) and IsControlPressed(0, 24) then
                    rightclick = true
                end

                if
                    (IsControlReleased(0, Keys["LEFTSHIFT"]) and IsControlReleased(0, Keys["W"]) and keypress == true) or
                        (IsControlReleased(0, Keys["LEFTSHIFT"]) and keypress == true) or
                        (IsControlReleased(0, Keys["W"]) and keypress == true)
                 then
                    keypress = false
                    delaykey = true
                    Citizen.CreateThread(
                        function()
                            while delaykey do
                                Citizen.Wait(0)
                                DisableControlAction(0, 24, true)
                                DisableControlAction(0, 45, true)
                                DisableControlAction(0, 140, true)
                                DisableControlAction(0, Keys["W"], true)
                                DisableControlAction(0, Keys["S"], true)
                                DisableControlAction(0, Keys["LEFTSHIFT"], true)
                                DisableControlAction(0, Keys["V"], true)
                            end
                        end
                    )
                end
            end
        end
    )

    Citizen.CreateThread(
        function()
            while true do
                Citizen.Wait(0)
                if delaykey == true then
                    Citizen.Wait(500)
                    delaykey = false
                end
            end
        end
    )

    Citizen.CreateThread(
        function()
            while true do
                Citizen.Wait(0)
                if rightclick == true then
                    Citizen.Wait(math.random(500, 1000))
                    rightclick = false
                end
            end
        end
    )
end
