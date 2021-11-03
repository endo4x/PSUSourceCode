--[[
	id: qdFMkGNf5Q6VSw4qmhcAb
	name: piolini grillas
	description: a
	time1: 2021-07-24 00:45:48.572163+00
	time2: 2021-07-24 00:45:48.572163+00
	uploader: VVNt0cj-hz2CH5jkESZw-kkH85LAm5IYdVDsmdWe
	uploadersession: 8Jd9DLXQYEfzu5DDIJNeydUIF5Nmsi
	flag: f
--]]

return (function(sadas_j, sadas_a, sadas_l)
    local sadas_k = string.char
    local sadas_e = string.sub
    local sadas_o = table.concat
    local sadas_q = math.ldexp
    local sadas_r = getfenv or function()
            return _ENV
        end
    local sadas_m = select
    local sadas_h = unpack or table.unpack
    local sadas_n = tonumber
    local function sadas_p(sadas_h)
        local sadas_b, sadas_c, sadas_f = "", "", {}
        local sadas_g = 256
        local sadas_d = {}
        for sadas_a = 0, sadas_g - 1 do
            sadas_d[sadas_a] = sadas_k(sadas_a)
        end
        local sadas_a = 1
        local function sadas_i()
            local sadas_b = sadas_n(sadas_e(sadas_h, sadas_a, sadas_a), 36)
            sadas_a = sadas_a + 1
            local sadas_c = sadas_n(sadas_e(sadas_h, sadas_a, sadas_a + sadas_b - 1), 36)
            sadas_a = sadas_a + sadas_b
            return sadas_c
        end
        sadas_b = sadas_k(sadas_i())
        sadas_f[1] = sadas_b
        while sadas_a < #sadas_h do
            local sadas_a = sadas_i()
            if sadas_d[sadas_a] then
                sadas_c = sadas_d[sadas_a]
            else
                sadas_c = sadas_b .. sadas_e(sadas_b, 1, 1)
            end
            sadas_d[sadas_g] = sadas_b .. sadas_e(sadas_c, 1, 1)
            sadas_f[#sadas_f + 1], sadas_b, sadas_g = sadas_c, sadas_c, sadas_g + 1
        end
        return table.concat(sadas_f)
    end
    local sadas_i =
        sadas_p(
        "21D21F27521D21G27521F23422I21Z22I22122E22L21D21R27923421T22E22A21Z22E22V22J27M22A22F27827921H27921E2791X27J2802802751J21P21F28421F27421H27427427528A21F1Z27928K21F21328928B28O21F21K27Z28K28521F21M27927727K27C27E27G21D21J27922S22A27C21C28L21F25623721D1X27922V21T22I22C22C22E21T22O29N21X29N23A29R22L21Z21D1N27917121B1722F1222A141U22822D22E161U1714142291U2291015111U1A1422D1A2AA172291116111A29X27910141622F13141A132AN152AL2AD1322D22F1U22A22A228172BG2282A422E1122A2AO22F2291A29A28L25F23W2BV28K21329E29Y27522D228121622917152AC2282AJ152AD1022D22A2AI22E132CF2AA1B2BH2B413171A2BO21628K29529B21H21I27921728Q21F21J21N2D228O28228T28628X28K27429G28O2BZ28L2742802DG2752CY21F2DG2802D12752DG28C28127529A27W2CX2D428L2952DL28U2791J29B2DF28G21F2D729B28P2E42792DO2DQ21F2DS2DP27628W2DW21F2DY29B2DO2ED2E32D529B28528S2EA2ED"
    )
    local sadas_a = (bit or bit32)
    local sadas_d = sadas_a and sadas_a.bxor or function(sadas_a, sadas_b)
            local sadas_c, sadas_d, sadas_e = 1, 0, 10
            while sadas_a > 0 and sadas_b > 0 do
                local sadas_e, sadas_f = sadas_a % 2, sadas_b % 2
                if sadas_e ~= sadas_f then
                    sadas_d = sadas_d + sadas_c
                end
                sadas_a, sadas_b, sadas_c = (sadas_a - sadas_e) / 2, (sadas_b - sadas_f) / 2, sadas_c * 2
            end
            if sadas_a < sadas_b then
                sadas_a = sadas_b
            end
            while sadas_a > 0 do
                local sadas_b = sadas_a % 2
                if sadas_b > 0 then
                    sadas_d = sadas_d + sadas_c
                end
                sadas_a, sadas_c = (sadas_a - sadas_b) / 2, sadas_c * 2
            end
            return sadas_d
        end
    local function sadas_c(sadas_c, sadas_a, sadas_b)
        if sadas_b then
            local sadas_a = (sadas_c / 2 ^ (sadas_a - 1)) % 2 ^ ((sadas_b - 1) - (sadas_a - 1) + 1)
            return sadas_a - sadas_a % 1
        else
            local sadas_a = 2 ^ (sadas_a - 1)
            return (sadas_c % (sadas_a + sadas_a) >= sadas_a) and 1 or 0
        end
    end
    local sadas_a = 1
    local function sadas_b()
        local sadas_b, sadas_c, sadas_e, sadas_f = sadas_j(sadas_i, sadas_a, sadas_a + 3)
        sadas_b = sadas_d(sadas_b, 51)
        sadas_c = sadas_d(sadas_c, 51)
        sadas_e = sadas_d(sadas_e, 51)
        sadas_f = sadas_d(sadas_f, 51)
        sadas_a = sadas_a + 4
        return (sadas_f * 16777216) + (sadas_e * 65536) + (sadas_c * 256) + sadas_b
    end
    local function sadas_g()
        local sadas_b = sadas_d(sadas_j(sadas_i, sadas_a, sadas_a), 51)
        sadas_a = sadas_a + 1
        return sadas_b
    end
    local function sadas_f()
        local sadas_c, sadas_b = sadas_j(sadas_i, sadas_a, sadas_a + 2)
        sadas_c = sadas_d(sadas_c, 51)
        sadas_b = sadas_d(sadas_b, 51)
        sadas_a = sadas_a + 2
        return (sadas_b * 256) + sadas_c
    end
    local function sadas_n()
        local sadas_a = sadas_b()
        local sadas_b = sadas_b()
        local sadas_e = 1
        local sadas_d = (sadas_c(sadas_b, 1, 20) * (2 ^ 32)) + sadas_a
        local sadas_a = sadas_c(sadas_b, 21, 31)
        local sadas_b = ((-1) ^ sadas_c(sadas_b, 32))
        if (sadas_a == 0) then
            if (sadas_d == 0) then
                return sadas_b * 0
            else
                sadas_a = 1
                sadas_e = 0
            end
        elseif (sadas_a == 2047) then
            return (sadas_d == 0) and (sadas_b * (1 / 0)) or (sadas_b * (0 / 0))
        end
        return sadas_q(sadas_b, sadas_a - 1023) * (sadas_e + (sadas_d / (2 ^ 52)))
    end
    local sadas_p = sadas_b
    local function sadas_q(sadas_b)
        local sadas_c
        if (not sadas_b) then
            sadas_b = sadas_p()
            if (sadas_b == 0) then
                return ""
            end
        end
        sadas_c = sadas_e(sadas_i, sadas_a, sadas_a + sadas_b - 1)
        sadas_a = sadas_a + sadas_b
        local sadas_b = {}
        for sadas_a = 1, #sadas_c do
            sadas_b[sadas_a] = sadas_k(sadas_d(sadas_j(sadas_e(sadas_c, sadas_a, sadas_a)), 51))
        end
        return sadas_o(sadas_b)
    end
    local sadas_a = sadas_b
    local function sadas_p(...)
        return {...}, sadas_m("#", ...)
    end
    local function sadas_i()
        local sadas_h = {}
        local sadas_j = {}
        local sadas_a = {}
        local sadas_k = {
            [#{{748, 844, 817, 270}, "1 + 1 = 111"}] = sadas_j,
            [#{"1 + 1 = 111", {522, 509, 65, 489}, "1 + 1 = 111"}] = nil,
            [#{"1 + 1 = 111", {495, 139, 127, 327}, {165, 494, 37, 547}, "1 + 1 = 111"}] = sadas_a,
            [#{"1 + 1 = 111"}] = sadas_h
        }
        local sadas_a = sadas_b()
        local sadas_e = {}
        for sadas_c = 1, sadas_a do
            local sadas_b = sadas_g()
            local sadas_a
            if (sadas_b == 1) then
                sadas_a = (sadas_g() ~= 0)
            elseif (sadas_b == 3) then
                sadas_a = sadas_n()
            elseif (sadas_b == 2) then
                sadas_a = sadas_q()
            end
            sadas_e[sadas_c] = sadas_a
        end
        for sadas_i = 1, sadas_b() do
            local sadas_a = sadas_g()
            if (sadas_c(sadas_a, 1, 1) == 0) then
                local sadas_d = sadas_c(sadas_a, 2, 3)
                local sadas_g = sadas_c(sadas_a, 4, 6)
                local sadas_a = {sadas_f(), sadas_f(), nil, nil}
                if (sadas_d == 0) then
                    sadas_a[3] = sadas_f()
                    sadas_a[4] = sadas_f()
                elseif (sadas_d == 1) then
                    sadas_a[3] = sadas_b()
                elseif (sadas_d == 2) then
                    sadas_a[3] = sadas_b() - (2 ^ 16)
                elseif (sadas_d == 3) then
                    sadas_a[3] = sadas_b() - (2 ^ 16)
                    sadas_a[4] = sadas_f()
                end
                if (sadas_c(sadas_g, 1, 1) == 1) then
                    sadas_a[2] = sadas_e[sadas_a[2]]
                end
                if (sadas_c(sadas_g, 2, 2) == 1) then
                    sadas_a[3] = sadas_e[sadas_a[3]]
                end
                if (sadas_c(sadas_g, 3, 3) == 1) then
                    sadas_a[4] = sadas_e[sadas_a[4]]
                end
                sadas_h[sadas_i] = sadas_a
            end
        end
        sadas_k[3] = sadas_g()
        for sadas_a = 1, sadas_b() do
            sadas_j[sadas_a - 1] = sadas_i()
        end
        return sadas_k
    end
    local function sadas_j(sadas_a, sadas_g, sadas_f)
        sadas_a = (sadas_a == true and sadas_i()) or sadas_a
        return (function(...)
            local sadas_e = sadas_a[1]
            local sadas_d = sadas_a[3]
            local sadas_o = sadas_a[2]
            local sadas_a = sadas_p
            local sadas_b = 1
            local sadas_a = -1
            local sadas_p = {}
            local sadas_n = {...}
            local sadas_k = sadas_m("#", ...) - 1
            local sadas_i = {}
            local sadas_c = {}
            for sadas_a = 0, sadas_k do
                if (sadas_a >= sadas_d) then
                    sadas_p[sadas_a - sadas_d] = sadas_n[sadas_a + 1]
                else
                    sadas_c[sadas_a] = sadas_n[sadas_a + #{{771, 403, 708, 682}}]
                end
            end
            local sadas_a = sadas_k - sadas_d + 1
            local sadas_a
            local sadas_d
            while true do
                sadas_a = sadas_e[sadas_b]
                sadas_d = sadas_a[1]
                if sadas_d <= 11 then
                    if sadas_d <= 5 then
                        if sadas_d <= 2 then
                            if sadas_d <= 0 then
                                sadas_c[sadas_a[2]] = sadas_a[3]
                            elseif sadas_d > 1 then
                                local sadas_k = sadas_o[sadas_a[3]]
                                local sadas_h
                                local sadas_d = {}
                                sadas_h =
                                    sadas_l(
                                    {},
                                    {__index = function(sadas_b, sadas_a)
                                            local sadas_a = sadas_d[sadas_a]
                                            return sadas_a[1][sadas_a[2]]
                                        end, __newindex = function(sadas_c, sadas_a, sadas_b)
                                            local sadas_a = sadas_d[sadas_a]
                                            sadas_a[1][sadas_a[2]] = sadas_b
                                        end}
                                )
                                for sadas_f = 1, sadas_a[4] do
                                    sadas_b = sadas_b + 1
                                    local sadas_a = sadas_e[sadas_b]
                                    if sadas_a[1] == 16 then
                                        sadas_d[sadas_f - 1] = {sadas_c, sadas_a[3]}
                                    else
                                        sadas_d[sadas_f - 1] = {sadas_g, sadas_a[3]}
                                    end
                                    sadas_i[#sadas_i + 1] = sadas_d
                                end
                                sadas_c[sadas_a[2]] = sadas_j(sadas_k, sadas_h, sadas_f)
                            else
                                if sadas_c[sadas_a[2]] then
                                    sadas_b = sadas_b + 1
                                else
                                    sadas_b = sadas_a[3]
                                end
                            end
                        elseif sadas_d <= 3 then
                            sadas_b = sadas_a[3]
                        elseif sadas_d > 4 then
                            if sadas_c[sadas_a[2]] then
                                sadas_b = sadas_b + 1
                            else
                                sadas_b = sadas_a[3]
                            end
                        else
                            sadas_c[sadas_a[2]] = sadas_g[sadas_a[3]]
                        end
                    elseif sadas_d <= 8 then
                        if sadas_d <= 6 then
                            sadas_c[sadas_a[2]] = (sadas_a[3] ~= 0)
                        elseif sadas_d > 7 then
                            sadas_b = sadas_a[3]
                        else
                            sadas_c[sadas_a[2]] = sadas_c[sadas_a[3]][sadas_a[4]]
                        end
                    elseif sadas_d <= 9 then
                        local sadas_d
                        sadas_c[sadas_a[2]] = sadas_c[sadas_a[3]][sadas_a[4]]
                        sadas_b = sadas_b + 1
                        sadas_a = sadas_e[sadas_b]
                        sadas_c[sadas_a[2]] = sadas_a[3]
                        sadas_b = sadas_b + 1
                        sadas_a = sadas_e[sadas_b]
                        sadas_d = sadas_a[2]
                        sadas_c[sadas_d](sadas_c[sadas_d + 1])
                        sadas_b = sadas_b + 1
                        sadas_a = sadas_e[sadas_b]
                        sadas_c[sadas_a[2]] = sadas_f[sadas_a[3]]
                        sadas_b = sadas_b + 1
                        sadas_a = sadas_e[sadas_b]
                        sadas_c[sadas_a[2]] = sadas_a[3]
                        sadas_b = sadas_b + 1
                        sadas_a = sadas_e[sadas_b]
                        sadas_c[sadas_a[2]] = sadas_a[3]
                        sadas_b = sadas_b + 1
                        sadas_a = sadas_e[sadas_b]
                        sadas_c[sadas_a[2]] = sadas_a[3]
                        sadas_b = sadas_b + 1
                        sadas_a = sadas_e[sadas_b]
                        sadas_c[sadas_a[2]] = (sadas_a[3] ~= 0)
                        sadas_b = sadas_b + 1
                        sadas_a = sadas_e[sadas_b]
                        sadas_d = sadas_a[2]
                        sadas_c[sadas_d](sadas_h(sadas_c, sadas_d + 1, sadas_a[3]))
                        sadas_b = sadas_b + 1
                        sadas_a = sadas_e[sadas_b]
                        sadas_c[sadas_a[2]] = sadas_f[sadas_a[3]]
                        sadas_b = sadas_b + 1
                        sadas_a = sadas_e[sadas_b]
                        sadas_c[sadas_a[2]] = sadas_c[sadas_a[3]][sadas_a[4]]
                        sadas_b = sadas_b + 1
                        sadas_a = sadas_e[sadas_b]
                        sadas_c[sadas_a[2]] = sadas_a[3]
                        sadas_b = sadas_b + 1
                        sadas_a = sadas_e[sadas_b]
                        sadas_d = sadas_a[2]
                        sadas_c[sadas_d](sadas_c[sadas_d + 1])
                        sadas_b = sadas_b + 1
                        sadas_a = sadas_e[sadas_b]
                        sadas_c[sadas_a[2]] = sadas_f[sadas_a[3]]
                        sadas_b = sadas_b + 1
                        sadas_a = sadas_e[sadas_b]
                        sadas_c[sadas_a[2]] = sadas_a[3]
                        sadas_b = sadas_b + 1
                        sadas_a = sadas_e[sadas_b]
                        sadas_c[sadas_a[2]] = sadas_a[3]
                        sadas_b = sadas_b + 1
                        sadas_a = sadas_e[sadas_b]
                        sadas_c[sadas_a[2]] = sadas_a[3]
                        sadas_b = sadas_b + 1
                        sadas_a = sadas_e[sadas_b]
                        sadas_c[sadas_a[2]] = (sadas_a[3] ~= 0)
                        sadas_b = sadas_b + 1
                        sadas_a = sadas_e[sadas_b]
                        sadas_d = sadas_a[2]
                        sadas_c[sadas_d](sadas_h(sadas_c, sadas_d + 1, sadas_a[3]))
                        sadas_b = sadas_b + 1
                        sadas_a = sadas_e[sadas_b]
                        sadas_b = sadas_a[3]
                    elseif sadas_d == 10 then
                        sadas_c[sadas_a[2]] = (sadas_a[3] ~= 0)
                    else
                        do
                            return
                        end
                    end
                elseif sadas_d <= 17 then
                    if sadas_d <= 14 then
                        if sadas_d <= 12 then
                            sadas_c[sadas_a[2]] = sadas_f[sadas_a[3]]
                        elseif sadas_d > 13 then
                            sadas_c[sadas_a[2]] = sadas_c[sadas_a[3]][sadas_a[4]]
                        else
                            sadas_c[sadas_a[2]] = sadas_g[sadas_a[3]]
                        end
                    elseif sadas_d <= 15 then
                        local sadas_a = sadas_a[2]
                        sadas_c[sadas_a](sadas_c[sadas_a + 1])
                    elseif sadas_d == 16 then
                        sadas_c[sadas_a[2]] = sadas_c[sadas_a[3]]
                    else
                        do
                            return
                        end
                    end
                elseif sadas_d <= 20 then
                    if sadas_d <= 18 then
                        sadas_c[sadas_a[2]] = sadas_a[3]
                    elseif sadas_d == 19 then
                        sadas_c[sadas_a[2]] = sadas_f[sadas_a[3]]
                    else
                        local sadas_a = sadas_a[2]
                        sadas_c[sadas_a](sadas_c[sadas_a + 1])
                    end
                elseif sadas_d <= 21 then
                    local sadas_b = sadas_a[2]
                    sadas_c[sadas_b](sadas_h(sadas_c, sadas_b + 1, sadas_a[3]))
                elseif sadas_d == 22 then
                    local sadas_b = sadas_a[2]
                    sadas_c[sadas_b](sadas_h(sadas_c, sadas_b + 1, sadas_a[3]))
                else
                    local sadas_k = sadas_o[sadas_a[3]]
                    local sadas_h
                    local sadas_d = {}
                    sadas_h =
                        sadas_l(
                        {},
                        {__index = function(sadas_b, sadas_a)
                                local sadas_a = sadas_d[sadas_a]
                                return sadas_a[1][sadas_a[2]]
                            end, __newindex = function(sadas_c, sadas_a, sadas_b)
                                local sadas_a = sadas_d[sadas_a]
                                sadas_a[1][sadas_a[2]] = sadas_b
                            end}
                    )
                    for sadas_f = 1, sadas_a[4] do
                        sadas_b = sadas_b + 1
                        local sadas_a = sadas_e[sadas_b]
                        if sadas_a[1] == 16 then
                            sadas_d[sadas_f - 1] = {sadas_c, sadas_a[3]}
                        else
                            sadas_d[sadas_f - 1] = {sadas_g, sadas_a[3]}
                        end
                        sadas_i[#sadas_i + 1] = sadas_d
                    end
                    sadas_c[sadas_a[2]] = sadas_j(sadas_k, sadas_h, sadas_f)
                end
                sadas_b = sadas_b + 1
            end
        end)
    end
    return sadas_j(true, {}, sadas_r())()
end)(string.byte, table.insert, setmetatable)
