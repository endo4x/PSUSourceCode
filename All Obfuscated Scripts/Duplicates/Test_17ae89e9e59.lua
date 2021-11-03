--[[
	id: YGxnwo3H0ap4Ul67B6kqP
	name: Test
	description: Test script
	time1: 2021-06-04 09:45:39.420449+00
	time2: 2021-06-04 09:45:39.42045+00
	uploader: MgbJT9auzxmWnDF_f3hes6VfOnfDGGos0N48G5OP
	uploadersession: Bz01rp-G2typERVxQXMvN29vBYf1dF
	flag: f
--]]

local t = string.byte
local f = string.char
local c = string.sub
local u = table.concat
local Z = math.ldexp
local F = getfenv or function()
        return _ENV
    end
local l = setmetatable
local i = select
local r = table.unpack
local h = tonumber
local function s(t)
    local e, o, a = "", "", {}
    local d = 256
    local n = {}
    for l = 0, d - 1 do
        n[l] = f(l)
    end
    local l = 1
    local function i()
        local e = h(c(t, l, l), 36)
        l = l + 1
        local o = h(c(t, l, l + e - 1), 36)
        l = l + e
        return o
    end
    e = f(i())
    a[1] = e
    while l < #t do
        local l = i()
        if n[l] then
            o = n[l]
        else
            o = e .. c(e, 1, 1)
        end
        n[d] = e .. c(o, 1, 1)
        a[#a + 1], e, d = o, o, d + 1
    end
    return table.concat(a)
end
local d =
    s(
    "1X1Z2752761Z21I27625621725V26422D217275257217131Z22M27G1Z25427N22327G24J25927622X27527T1Z27D27W1Z24J25B27N22L27N25621F27D22D21F27527P27522F27S27U27528127T22Z28022Z28225621N28A21N2752521327D22227K1Z24Y27C26427R27524Z27J1Z2941Z25321F1J29828C1Z25721F28C22329F2561B27D2231B28U1J29O29D29G29I29E27525924R2642932A022K2842752862752112761X21H27622S21Y22F22O22E22922921Y22522F23521Y2282242AI21S21Y23121U22621Y1X21B27622821S22922222B22F23322421U21Z21Y21Z1X21D27623B2B421W21W21Y2292342BL22D2BL22U2BP2AM2AZ27622521U22F2222242251P21U22E22F2231E1X21327623821U22222F1Y2771Z22R24S22R2CF27621A27A29227F28D27N28G28228I1Z28K2591R2801R28227I27521Y28729222128728929329F25228R29328T1Z24Z27622327629B27529K27H1Z27K2DK27H21729J27N2A51Z2A71Z1W2AA2B02752B22B42B62B82BA2BC1X2A927521U2282282BL22F2C82762272B921Z1Y2BF27525A2CP2D927D2242DC27Z26422827625B21N28C22H2DG25A2DE2232DG25628W29328Z25229N29329Q29A29729927I2DR2DW29W2DO1Z2ER29O2872FB2232FD2FF29P27525329727M2DT27K22J27N2522922282DW2F21Z2202DG2DX2DZ2122AA21827622Q21Z21Z2BR2AL22F22Z21U22521Z2272BL1X2792752C022O2272222GP2AO2AQ2AS21Y23422F21U2292EI29F1Z2AO21W22222822F2BL2312AF2GO2BT2CN2752BW2BY2C01P2HJ2HB22F2C72AC2752AE2AG2AI2AK2AM2H52AR2292AT2AV2AX1Z"
)
local n = bit and bit.bxor or function(l, e)
        local o, n = 1, 0
        while l > 0 and e > 0 do
            local c, a = l % 2, e % 2
            if c ~= a then
                n = n + o
            end
            l, e, o = (l - c) / 2, (e - a) / 2, o * 2
        end
        if l < e then
            l = e
        end
        while l > 0 do
            local e = l % 2
            if e > 0 then
                n = n + o
            end
            l, o = (l - e) / 2, o * 2
        end
        return n
    end
local function e(o, l, e)
    if e then
        local l = (o / 2 ^ (l - 1)) % 2 ^ ((e - 1) - (l - 1) + 1)
        return l - l % 1
    else
        local l = 2 ^ (l - 1)
        return (o % (l + l) >= l) and 1 or 0
    end
end
local l = 1
local function o()
    local o, c, a, e = t(d, l, l + 3)
    o = n(o, 35)
    c = n(c, 35)
    a = n(a, 35)
    e = n(e, 35)
    l = l + 4
    return (e * 16777216) + (a * 65536) + (c * 256) + o
end
local function a()
    local e = n(t(d, l, l), 35)
    l = l + 1
    return e
end
local function h()
    local l = o()
    local n = o()
    local c = 1
    local o = (e(n, 1, 20) * (2 ^ 32)) + l
    local l = e(n, 21, 31)
    local e = ((-1) ^ e(n, 32))
    if (l == 0) then
        if (o == 0) then
            return e * 0
        else
            l = 1
            c = 0
        end
    elseif (l == 2047) then
        return (o == 0) and (e * (1 / 0)) or (e * (0 / 0))
    end
    return Z(e, l - 1023) * (c + (o / (2 ^ 52)))
end
local s = o
local function Z(e)
    local o
    if (not e) then
        e = s()
        if (e == 0) then
            return ""
        end
    end
    o = c(d, l, l + e - 1)
    l = l + e
    local e = {}
    for l = 1, #o do
        e[l] = f(n(t(c(o, l, l)), 35))
    end
    return u(e)
end
local l = o
local function f(...)
    return {...}, i("#", ...)
end
local function B()
    local t = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
    local l = {0, 0}
    local c = {}
    local d = {t, nil, l, nil, c}
    for e = 1, o() do
        l[e - 1] = B()
    end
    for a = 1, o() do
        local c = n(o(), 156)
        local o = n(o(), 104)
        local n = e(c, 1, 2)
        local l = e(o, 1, 11)
        local l = {l, e(c, 3, 11), nil, nil, o}
        if (n == 0) then
            l[3] = e(c, 12, 20)
            l[5] = e(c, 21, 29)
        elseif (n == 1) then
            l[3] = e(o, 12, 33)
        elseif (n == 2) then
            l[3] = e(o, 12, 32) - 1048575
        elseif (n == 3) then
            l[3] = e(o, 12, 32) - 1048575
            l[5] = e(c, 21, 29)
        end
        t[a] = l
    end
    local l = o()
    local o = {0, 0, 0, 0, 0, 0}
    for n = 1, l do
        local e = a()
        local l
        if (e == 3) then
            l = (a() ~= 0)
        elseif (e == 1) then
            l = h()
            if math.fmod(l, 1) == .0 then
                l = math.floor(l)
            end
        elseif (e == 2) then
            l = Z()
        end
        o[n] = l
    end
    d[2] = o
    d[4] = a()
    return d
end
local function u(l, e, t)
    local n = l[1]
    local e = l[2]
    local o = l[3]
    local l = l[4]
    return function(...)
        local c = n
        local d = e
        local B = o
        local n = l
        local Z = f
        local e = 1
        local a = -1
        local h = {}
        local f = {...}
        local i = i("#", ...) - 1
        local l = {}
        local o = {}
        for l = 0, i do
            if (l >= n) then
                h[l - n] = f[l + 1]
            else
                o[l] = f[l + 1]
            end
        end
        local l = i - n + 1
        local l
        local n
        while true do
            l = c[e]
            n = l[1]
            if n <= 16 then
                if n <= 7 then
                    if n <= 3 then
                        if n <= 1 then
                            if n > 0 then
                                local h
                                local s
                                local u
                                local f
                                local n
                                local A, i
                                local n
                                o[l[2]] = d[l[3]]
                                e = e + 1
                                l = c[e]
                                o[l[2]] = t[d[l[3]]]
                                e = e + 1
                                l = c[e]
                                n = l[2]
                                A, i = {o[n]()}
                                i = n + l[5] - 2
                                f = 0
                                for l = n, i do
                                    f = f + 1
                                    o[l] = A[f]
                                end
                                a = i
                                e = e + 1
                                l = c[e]
                                u = l[3]
                                s = o[u]
                                for l = u + 1, l[5] do
                                    s = s .. o[l]
                                end
                                o[l[2]] = s
                                e = e + 1
                                l = c[e]
                                n = l[2]
                                h = {}
                                f = 0
                                i = n + l[3] - 1
                                for l = n + 1, i do
                                    f = f + 1
                                    h[f] = o[l]
                                end
                                o[n](r(h, 1, i - n))
                                a = n
                                e = e + 1
                                l = c[e]
                                o[l[2]] = t[d[l[3]]]
                                e = e + 1
                                l = c[e]
                                o[l[2]] = d[l[3]]
                                e = e + 1
                                l = c[e]
                                n = l[2]
                                h = {}
                                f = 0
                                i = n + l[3] - 1
                                for l = n + 1, i do
                                    f = f + 1
                                    h[f] = o[l]
                                end
                                o[n](r(h, 1, i - n))
                                a = n
                                e = e + 1
                                l = c[e]
                                e = e + l[3]
                            else
                                if (o[l[2]] == o[l[5]]) then
                                    e = e + 1
                                else
                                    e = e + l[3]
                                end
                            end
                        elseif n > 2 then
                            local e = l[2]
                            local c = {}
                            local n = 0
                            local l = e + l[3] - 1
                            for l = e + 1, l do
                                n = n + 1
                                c[n] = o[l]
                            end
                            o[e](r(c, 1, l - e))
                            a = e
                        else
                            local n
                            local s, n
                            local f
                            local n
                            local h
                            local i
                            t[d[l[3]]] = o[l[2]]
                            e = e + 1
                            l = c[e]
                            o[l[2]] = t[d[l[3]]]
                            e = e + 1
                            l = c[e]
                            o[l[2]] = t[d[l[3]]]
                            e = e + 1
                            l = c[e]
                            o[l[2]] = o[l[3]]
                            e = e + 1
                            l = c[e]
                            i = l[2]
                            h = {}
                            n = 0
                            f = i + l[3] - 1
                            for l = i + 1, f do
                                n = n + 1
                                h[n] = o[l]
                            end
                            s, f = Z(o[i](r(h, 1, f - i)))
                            f = f + i - 1
                            n = 0
                            for l = i, f do
                                n = n + 1
                                o[l] = s[n]
                            end
                            a = f
                            e = e + 1
                            l = c[e]
                            i = l[2]
                            h = {}
                            n = 0
                            f = a
                            for l = i + 1, f do
                                n = n + 1
                                h[n] = o[l]
                            end
                            s = {o[i](r(h, 1, f - i))}
                            f = i + l[5] - 2
                            n = 0
                            for l = i, f do
                                n = n + 1
                                o[l] = s[n]
                            end
                            a = f
                            e = e + 1
                            l = c[e]
                            o[l[2]]()
                            a = i
                        end
                    elseif n <= 5 then
                        if n == 4 then
                            o[l[2]]()
                            a = A
                        else
                            local e = l[2]
                            local c = {}
                            local n = 0
                            local l = e + l[3] - 1
                            for l = e + 1, l do
                                n = n + 1
                                c[n] = o[l]
                            end
                            o[e](r(c, 1, l - e))
                            a = e
                        end
                    elseif n == 6 then
                        t[d[l[3]]] = o[l[2]]
                    else
                        o[l[2]] = d[l[3]]
                    end
                elseif n <= 11 then
                    if n <= 9 then
                        if n == 8 then
                            local n = l[2]
                            local d = {}
                            local e = 0
                            local c = a
                            for l = n + 1, c do
                                e = e + 1
                                d[e] = o[l]
                            end
                            local c = {o[n](r(d, 1, c - n))}
                            local l = n + l[5] - 2
                            e = 0
                            for l = n, l do
                                e = e + 1
                                o[l] = c[e]
                            end
                            a = l
                        else
                            o[l[2]] = u(B[l[3]], nil, t)
                        end
                    elseif n == 10 then
                        local n = l[2]
                        local c = {}
                        local e = 0
                        local l = n + l[3] - 1
                        for l = n + 1, l do
                            e = e + 1
                            c[e] = o[l]
                        end
                        local c, l = Z(o[n](r(c, 1, l - n)))
                        l = l + n - 1
                        e = 0
                        for l = n, l do
                            e = e + 1
                            o[l] = c[e]
                        end
                        a = l
                    else
                        o[l[2]] = o[l[3]]
                    end
                elseif n <= 13 then
                    if n == 12 then
                        o[l[2]] = t[d[l[3]]]
                    else
                        o[l[2]] = (l[3] ~= 0)
                    end
                elseif n <= 14 then
                    if (o[l[2]] == o[l[5]]) then
                        e = e + 1
                    else
                        e = e + l[3]
                    end
                elseif n == 15 then
                    t[d[l[3]]] = o[l[2]]
                else
                    local n = l[3]
                    local e = o[n]
                    for l = n + 1, l[5] do
                        e = e .. o[l]
                    end
                    o[l[2]] = e
                end
            elseif n <= 25 then
                if n <= 20 then
                    if n <= 18 then
                        if n > 17 then
                            local s
                            local u
                            local A, n
                            local i
                            local f
                            local h
                            local n
                            n = l[2]
                            h = {}
                            f = 0
                            i = n + l[3] - 1
                            for l = n + 1, i do
                                f = f + 1
                                h[f] = o[l]
                            end
                            o[n](r(h, 1, i - n))
                            a = n
                            e = e + 1
                            l = c[e]
                            o[l[2]] = t[d[l[3]]]
                            e = e + 1
                            l = c[e]
                            o[l[2]] = d[l[3]]
                            e = e + 1
                            l = c[e]
                            o[l[2]] = t[d[l[3]]]
                            e = e + 1
                            l = c[e]
                            n = l[2]
                            A, i = {o[n]()}
                            i = n + l[5] - 2
                            f = 0
                            for l = n, i do
                                f = f + 1
                                o[l] = A[f]
                            end
                            a = i
                            e = e + 1
                            l = c[e]
                            u = l[3]
                            s = o[u]
                            for l = u + 1, l[5] do
                                s = s .. o[l]
                            end
                            o[l[2]] = s
                            e = e + 1
                            l = c[e]
                            n = l[2]
                            h = {}
                            f = 0
                            i = n + l[3] - 1
                            for l = n + 1, i do
                                f = f + 1
                                h[f] = o[l]
                            end
                            o[n](r(h, 1, i - n))
                            a = n
                            e = e + 1
                            l = c[e]
                            o[l[2]] = t[d[l[3]]]
                            e = e + 1
                            l = c[e]
                            o[l[2]] = d[l[3]]
                            e = e + 1
                            l = c[e]
                            o[l[2]] = t[d[l[3]]]
                        else
                            o[l[2]]()
                            a = A
                        end
                    elseif n == 19 then
                        local e = l[2]
                        local c, n = {o[e]()}
                        local n = e + l[5] - 2
                        local l = 0
                        for e = e, n do
                            l = l + 1
                            o[e] = c[l]
                        end
                        a = n
                    else
                        do
                            return
                        end
                    end
                elseif n <= 22 then
                    if n == 21 then
                        local e = l[2]
                        local c, n = {o[e]()}
                        local n = e + l[5] - 2
                        local l = 0
                        for e = e, n do
                            l = l + 1
                            o[e] = c[l]
                        end
                        a = n
                    else
                        do
                            return
                        end
                    end
                elseif n <= 23 then
                    local n = l[2]
                    local d = {}
                    local e = 0
                    local c = a
                    for l = n + 1, c do
                        e = e + 1
                        d[e] = o[l]
                    end
                    local c = {o[n](r(d, 1, c - n))}
                    local l = n + l[5] - 2
                    e = 0
                    for l = n, l do
                        e = e + 1
                        o[l] = c[e]
                    end
                    a = l
                elseif n == 24 then
                    e = e + l[3]
                else
                    local n = l[3]
                    local e = o[n]
                    for l = n + 1, l[5] do
                        e = e .. o[l]
                    end
                    o[l[2]] = e
                end
            elseif n <= 29 then
                if n <= 27 then
                    if n > 26 then
                        o[l[2]] = u(B[l[3]], nil, t)
                    else
                        o[l[2]] = (l[3] ~= 0)
                    end
                elseif n == 28 then
                    if o[l[2]] then
                        e = e + 1
                    else
                        e = e + l[3]
                    end
                else
                    o[l[2]] = o[l[3]]
                end
            elseif n <= 31 then
                if n > 30 then
                    local n = l[2]
                    local c = {}
                    local e = 0
                    local l = n + l[3] - 1
                    for l = n + 1, l do
                        e = e + 1
                        c[e] = o[l]
                    end
                    local c, l = Z(o[n](r(c, 1, l - n)))
                    l = l + n - 1
                    e = 0
                    for l = n, l do
                        e = e + 1
                        o[l] = c[e]
                    end
                    a = l
                else
                    o[l[2]] = t[d[l[3]]]
                end
            elseif n <= 32 then
                o[l[2]] = d[l[3]]
            elseif n == 33 then
                if o[l[2]] then
                    e = e + 1
                else
                    e = e + l[3]
                end
            else
                e = e + l[3]
            end
            e = e + 1
        end
    end
end
return u(B(), {}, F())()
