--[[
	id: tJbjCuXFCNs-vxelhx5Fl
	name: 534564
	description: 3543
	time1: 2021-06-11 21:45:16.213925+00
	time2: 2021-06-11 21:45:16.213926+00
	uploader: d8EWlDT4PMRavyWovXahxCimsEWFBSD5OUmmJ3P3
	uploadersession: Vi7ZxVHDLrqvkHKzCf-kf38NKihILy
	flag: f
--]]

local type = type
local setmetatable = setmetatable
local tostring = tostring
local a = math.pi
local b = math.min
local c = math.max
local d = math.deg
local e = math.rad
local f = math.sqrt
local g = math.sin
local h = math.cos
local i = math.atan
local j = math.acos
local k = math.fmod
local l = {}
l.__index = l
function Vector3(m, n, o)
    if type(m) ~= "number" then
        m = 0.0
    end
    if type(n) ~= "number" then
        n = 0.0
    end
    if type(o) ~= "number" then
        o = 0.0
    end
    m = m or 0.0
    n = n or 0.0
    o = o or 0.0
    return setmetatable({x = m, y = n, z = o}, l)
end
function l.__eq(p, q)
    return p.x == q.x and p.y == q.y and p.z == q.z
end
function l.__unm(p)
    return Vector3(-p.x, -p.y, -p.z)
end
function l.__add(p, q)
    local r = type(p)
    local s = type(q)
    if r == "table" and s == "table" then
        return Vector3(p.x + q.x, p.y + q.y, p.z + q.z)
    elseif r == "table" and s == "number" then
        return Vector3(p.x + q, p.y + q, p.z + q)
    elseif r == "number" and s == "table" then
        return Vector3(p + q.x, p + q.y, p + q.z)
    end
end
function l.__sub(p, q)
    local r = type(p)
    local s = type(q)
    if r == "table" and s == "table" then
        return Vector3(p.x - q.x, p.y - q.y, p.z - q.z)
    elseif r == "table" and s == "number" then
        return Vector3(p.x - q, p.y - q, p.z - q)
    elseif r == "number" and s == "table" then
        return Vector3(p - q.x, p - q.y, p - q.z)
    end
end
function l.__mul(p, q)
    local r = type(p)
    local s = type(q)
    if r == "table" and s == "table" then
        return Vector3(p.x * q.x, p.y * q.y, p.z * q.z)
    elseif r == "table" and s == "number" then
        return Vector3(p.x * q, p.y * q, p.z * q)
    elseif r == "number" and s == "table" then
        return Vector3(p * q.x, p * q.y, p * q.z)
    end
end
function l.__div(p, q)
    local r = type(p)
    local s = type(q)
    if r == "table" and s == "table" then
        return Vector3(p.x / q.x, p.y / q.y, p.z / q.z)
    elseif r == "table" and s == "number" then
        return Vector3(p.x / q, p.y / q, p.z / q)
    elseif r == "number" and s == "table" then
        return Vector3(p / q.x, p / q.y, p / q.z)
    end
end
function l.__tostring(p)
    return "( " .. p.x .. ", " .. p.y .. ", " .. p.z .. " )"
end
function l:clear()
    self.x = 0.0
    self.y = 0.0
    self.z = 0.0
end
function l:unpack()
    return self.x, self.y, self.z
end
function l:length_2d_sqr()
    return self.x * self.x + self.y * self.y
end
function l:length_sqr()
    return self.x * self.x + self.y * self.y + self.z * self.z
end
function l:length_2d()
    return f(self:length_2d_sqr())
end
function l:length()
    return f(self:length_sqr())
end
function l:dot(t)
    return self.x * t.x + self.y * t.y + self.z * t.z
end
function l:cross(t)
    return Vector3(self.y * t.z - self.z * t.y, self.z * t.x - self.x * t.z, self.x * t.y - self.y * t.x)
end
function l:dist_to(t)
    return (t - self):length()
end
function l:is_zero(u)
    u = u or 0.001
    if self.x < u and self.x > -u and self.y < u and self.y > -u and self.z < u and self.z > -u then
        return true
    end
    return false
end
function l:normalize()
    local v = self:length()
    if v <= 0.0 then
        return 0.0
    end
    self.x = self.x / v
    self.y = self.y / v
    self.z = self.z / v
    return v
end
function l:normalize_no_len()
    local v = self:length()
    if v <= 0.0 then
        return
    end
    self.x = self.x / v
    self.y = self.y / v
    self.z = self.z / v
end
function l:normalized()
    local v = self:length()
    if v <= 0.0 then
        return Vector3()
    end
    return Vector3(self.x / v, self.y / v, self.z / v)
end
function clamp(w, x, y)
    if w < x then
        return x
    elseif w > y then
        return y
    end
    return w
end
function normalize_angle(z)
    local A
    local B
    B = tostring(z)
    if B == "nan" or B == "inf" then
        return 0.0
    end
    if z >= -180.0 and z <= 180.0 then
        return z
    end
    A = k(k(z + 360.0, 360.0), 360.0)
    if A > 180.0 then
        A = A - 360.0
    end
    return A
end
function vector_to_angle(C)
    local v
    local D
    local E
    v = C:length()
    if v > 0.0 then
        D = d(i(-C.z, v))
        E = d(i(C.y, C.x))
    else
        if C.x > 0.0 then
            D = 270.0
        else
            D = 90.0
        end
        E = 0.0
    end
    return Vector3(D, E, 0.0)
end
function angle_forward(z)
    local F = g(e(z.x))
    local G = h(e(z.x))
    local H = g(e(z.y))
    local I = h(e(z.y))
    return Vector3(G * I, G * H, -F)
end
function angle_right(z)
    local F = g(e(z.x))
    local G = h(e(z.x))
    local H = g(e(z.y))
    local I = h(e(z.y))
    local J = g(e(z.z))
    local K = h(e(z.z))
    return Vector3(-1.0 * J * F * I + -1.0 * K * -H, -1.0 * J * F * H + -1.0 * K * I, -1.0 * J * G)
end
function angle_up(z)
    local F = g(e(z.x))
    local G = h(e(z.x))
    local H = g(e(z.y))
    local I = h(e(z.y))
    local J = g(e(z.z))
    local K = h(e(z.z))
    return Vector3(K * F * I + -J * -H, K * F * H + -J * I, K * G)
end
function get_FOV(L, M, N)
    local O
    local P
    local Q
    local R
    P = angle_forward(L)
    Q = (N - M):normalized()
    R = j(P:dot(Q) / Q:length())
    return c(0.0, d(R))
end
local S,
    T,
    U,
    V,
    W,
    X,
    Y,
    Z,
    _,
    a0,
    a1,
    a2,
    a3,
    a4,
    a5,
    a6,
    a7,
    a8,
    a9,
    aa,
    ab,
    ac,
    ad,
    ae,
    af,
    ag,
    ah,
    tonumber,
    unpack,
    pairs,
    type =
    client.camera_angles,
    client.latency,
    client.screen_size,
    client.set_event_callback,
    entity.get_local_player,
    entity.get_player_resource,
    entity.get_player_weapon,
    entity.get_prop,
    entity.hitbox_position,
    entity.is_alive,
    globals.chokedcommands,
    globals.curtime,
    globals.tickcount,
    globals.tickinterval,
    math.abs,
    math.ceil,
    math.floor,
    math.max,
    math.min,
    renderer.gradient,
    renderer.indicator,
    renderer.load_svg,
    renderer.measure_text,
    renderer.rectangle,
    renderer.text,
    renderer.texture,
    table.insert,
    tonumber,
    unpack,
    pairs,
    type
local ai =
    (function()
    local a = {}
    local b, c, d, e, f, g, h, i, j, k, l, m, n, o
    local p = {__index = {drag = function(self, ...)
                local q, r = self:get()
                local s, t = a.drag(q, r, ...)
                if q ~= s or r ~= t then
                    self:set(s, t)
                end
                return s, t
            end, set = function(self, q, r)
                local j, k = client.screen_size()
                ui.set(self.x_reference, q / j * self.res)
                ui.set(self.y_reference, r / k * self.res)
            end, get = function(self)
                local j, k = client.screen_size()
                return ui.get(self.x_reference) / self.res * j, ui.get(self.y_reference) / self.res * k
            end}}
    function a.new(u, v, w, x)
        x = x or 10000
        local j, k = client.screen_size()
        local y = ui.new_slider("LUA", "A", u .. " window position", 0, x, v / j * x)
        local z = ui.new_slider("LUA", "A", "\n" .. u .. " window position y", 0, x, w / k * x)
        ui.set_visible(y, false)
        ui.set_visible(z, false)
        return setmetatable({name = u, x_reference = y, y_reference = z, res = x}, p)
    end
    client.set_event_callback(
        "paint",
        function()
            c = ui.is_menu_open()
            f, g = d, e
            d, e = ui.mouse_position()
            i = h
            h = client.key_state(0x01) == true
            m = l
            l = {}
            o = n
            n = false
            j, k = client.screen_size()
        end
    )
    function a.drag(q, r, A, B, C, D, E)
        if c and i ~= nil then
            if (not i or o) and h and f > q and g > r and f < q + A and g < r + B then
                n = true
                q, r = q + d - f, r + e - g
                if not D then
                    q = math.max(0, math.min(j - A, q))
                    r = math.max(0, math.min(k - B, r))
                end
                if E then
                end
            end
        end
        table.insert(l, {q, r, A, B})
        return q, r, A, B
    end
    return a
end)()
local aj =
    (function()
    local function a(b, c, d, e)
        c = c or ""
        d = d or 1
        e = e or #b
        local f = ""
        for g = d, e do
            f = f .. c .. tostring(b[g])
        end
        return f
    end
    local function h(b, i)
        for g = 1, #b do
            if b[g] == i then
                return true
            end
        end
        return false
    end
    local function j(k, ...)
        if not k then
            error(a({...}), 3)
        end
    end
    local function l(b)
        local m, n = false, false
        for o, k in pairs(b) do
            if type(o) == "number" then
                m = true
            else
                n = true
            end
        end
        return m, n
    end
    local p = globals.realtime()
    local q = {}
    local r = {}
    local s = {}
    local function t(b)
        local u = false
        for o, k in pairs(b) do
            if getmetatable(k) == s then
                u = true
            end
        end
        return u
    end
    local function v(k, w)
        return k ~= q[w].default
    end
    local function x(k)
        return #k > 0
    end
    function s.__index(w, o)
        if q[w] ~= nil and type(o) == "string" and o:sub(1, 1) ~= "_" then
            return q[w][o] or r[o]
        end
    end
    function s.__call(w, ...)
        local y = {...}
        if globals.realtime() == p and #y == 1 and type(y[1]) == "table" then
            local z = {}
            local A = y[1]
            local B = false
            local C = false
            local D = {}
            for o, k in pairs(A) do
                if type(o) ~= "number" then
                    D[o] = k
                    C = true
                end
            end
            if A[1] ~= nil and (type(A[1]) ~= "table" or not t(A[1])) then
                D[1] = A[1]
                B = true
                if type(D[1]) ~= "table" then
                    D[1] = {D[1]}
                end
            end
            if C then
                table.insert(z, D)
            end
            for g = B and 2 or 1, #A do
                if t(A[g]) then
                    table.insert(z, A[g])
                end
            end
            for g = 1, #z do
                local E = z[g]
                local k
                if E[1] ~= nil then
                    k = E[1]
                end
                for o, F in pairs(E) do
                    if o ~= 1 then
                        w:add_children(F, k, o)
                    end
                end
            end
            return w
        end
        if #y == 0 then
            return w:get()
        else
            local G, H = pcall(ui.set, y[1].reference, select(2, unpack(y)))
        end
    end
    function s.__tostring(w)
        return "Menu item: " .. w.tab .. " - " .. w.container .. " - " .. w.name
    end
    function r.new(I, J, K, L, ...)
        local y = {...}
        local M, N
        local O
        if type(I) == "function" and I ~= ui.reference then
            for o, k in pairs(ui) do
                if k == I and o:sub(1, 4) == "new_" then
                    O = o:sub(5, -1)
                end
            end
            local G
            G, M = pcall(I, J, K, L, unpack(y))
            if not G then
                error(M, 2)
            end
            N = I == ui.reference
        else
            M = I
            N = true
        end
        if O == nil then
            local k = {pcall(ui.get, M)}
            if k[1] == false then
                O = "button"
            else
                k = {select(2, unpack(k))}
                if #k == 1 then
                    local P = type(k[1])
                    if P == "string" then
                        local G = pcall(ui.set, M, nil)
                        ui.set(M, k[1])
                        O = G and "textbox" or "combobox"
                    elseif P == "number" then
                        local G = pcall(ui.set, M, -9999999999999999)
                        ui.set(M, k[1])
                        O = G and "listbox" or "slider"
                    elseif P == "boolean" then
                        O = "checkbox"
                    elseif P == "table" then
                        O = "multiselect"
                    end
                elseif #k >= 2 and type(k[1]) == "boolean" and type(k[2]) == "number" then
                    O = "hotkey"
                elseif #k == 4 then
                    if
                        type(k[1]) == "number" and type(k[2]) == "number" and type(k[3]) == "number" and
                            type(k[4]) == "number"
                     then
                        O = "color_picker"
                    end
                end
            end
        end
        local Q
        if N == false and O ~= nil then
            if O == "slider" then
                Q = y[3] or y[1]
            elseif O == "combobox" then
                Q = y[1][1]
            elseif O == "checkbox" then
                Q = false
            end
        end
        local w = {}
        q[w] = {
            tab = J,
            container = K,
            name = L,
            reference = M,
            type = O,
            default = Q,
            visible = true,
            ui_callback = nil,
            callbacks = {},
            is_gamesense_reference = N,
            children_values = {},
            children_callbacks = {}
        }
        if N == false and O ~= nil then
            if O == "slider" then
                q[w].min = y[1]
                q[w].max = y[2]
            elseif O == "combobox" or O == "multiselect" or O == "listbox" then
                q[w].values = y[1]
            end
        end
        return setmetatable(w, s)
    end
    function r:set(...)
        local R = {...}
        local ak = q[self]
        local al = {pcall(ui.set, ak.reference, unpack(R))}
    end
    function r:get()
        local ak = q[self]
        return ui.get(ak.reference)
    end
    function r:contains(k)
        local ak = q[self]
        if ak.type == "multiselect" then
            return h(ui.get(ak.reference), k)
        elseif ak.type == "combobox" then
            return ui.get(ak.reference) == k
        else
            error(string.format("Invalid type %s for contains", ak.type), 2)
        end
    end
    function r:as_keys()
        local ak = q[self]
        if ak.type == "multiselect" then
            local k = ui.get(ak.reference)
            local f = {}
            for g = 1, #k do
                f[k[g]] = true
            end
            return f
        elseif ak.type == "combobox" then
            return {[ui.get(ak.reference)] = true}
        else
            error(string.format("Invalid type %s for as_keys", ak.type), 2)
        end
    end
    function r:set_visible(am)
        local ak = q[self]
        if ak == nil then
            error("Invalid ui element", 2)
        end
        ui.set_visible(ak.reference, am)
        ak.visible = am
    end
    function r:set_default(k)
        q[self].default = k
        self:set(k)
    end
    function r:add_children(an, ao, o)
        local ak = q[self]
        local ap = type(ao) == "function"
        if ao == nil then
            ao = true
            if ak.type == "boolean" then
                ao = true
            elseif ak.type == "combobox" then
                ap = true
                ao = v
            elseif ak.type == "multiselect" then
                ap = true
                ao = x
            end
        end
        if getmetatable(an) == s then
            an = {an}
        end
        for aq, F in pairs(an) do
            if ap then
                q[F].parent_visible_callback = ao
            else
                q[F].parent_visible_value = ao
            end
            self[o or F.reference] = F
        end
        r._process_callbacks(self)
    end
    function r:add_callback(ar)
        local ak = q[self]
        table.insert(ak.callbacks, ar)
        r._process_callbacks(self)
    end
    r.set_callback = r.add_callback
    function r:_process_callbacks()
        local ak = q[self]
        if ak.ui_callback == nil then
            local ar = function(M, as)
                local k = self:get()
                local at = ak.combo_elements
                if at ~= nil and #at > 0 then
                    local au
                    for g = 1, #at do
                        local av = at[g]
                        if #av > 0 then
                            local aw = {}
                            for g = 1, #av do
                                if h(k, av[g]) then
                                    table.insert(aw, av[g])
                                end
                            end
                            if #aw > 1 then
                                au = au or k
                                for g = #aw, 1, -1 do
                                    if h(ak.value_prev, aw[g]) and #aw > 1 then
                                        table.remove(aw, g)
                                    end
                                end
                                local ax = aw[1]
                                for g = #au, 1, -1 do
                                    if au[g] ~= ax and h(av, au[g]) then
                                        table.remove(au, g)
                                    end
                                end
                            elseif #aw == 0 and not (av.required == false) then
                                au = au or k
                                if ak.value_prev ~= nil then
                                    for g = 1, #ak.value_prev do
                                        if h(av, ak.value_prev[g]) then
                                            table.insert(au, ak.value_prev[g])
                                            break
                                        end
                                    end
                                end
                            end
                        end
                    end
                    if au ~= nil then
                        self:set(au)
                    end
                    ak.value_prev = k
                    k = au or k
                end
                for o, F in pairs(self) do
                    local ay = q[F]
                    local az = false
                    if ak.visible then
                        if ay.parent_visible_callback ~= nil then
                            az = ay.parent_visible_callback(k, self, F)
                        elseif ak.type == "multiselect" then
                            local aA = type(ay.parent_visible_value)
                            for g = 1, #k do
                                if aA and h(ay.parent_visible_value, k[g]) or ay.parent_visible_value == k[g] then
                                    az = true
                                    break
                                end
                            end
                        elseif type(ay.parent_visible_value) == "table" then
                            az = ay.parent_visible_value[k] or h(ay.parent_visible_value, k)
                        else
                            az = k == ay.parent_visible_value
                        end
                    end
                    ui.set_visible(ay.reference, az)
                    ay.visible = az
                    if ay.ui_callback ~= nil then
                        ay.ui_callback(F)
                    end
                end
                for g = 1, #ak.callbacks do
                    ak.callbacks[g]()
                end
            end
            ui.set_callback(ak.reference, ar)
            ak.ui_callback = ar
        end
        ak.ui_callback()
    end
    local aB = {}
    local aC = {__index = function(aq, o)
            if aB[o] then
                return aB[o]
            end
            local aD = o
            if aD:sub(1, 4) ~= "new_" then
                aD = "new_" .. aD
            end
            if ui[aD] ~= nil then
                local aE = ui[aD]
                return function(self, L, ...)
                    local y = {...}
                    local at = {}
                    local aF = aD:sub(5, -1)
                    local aG = "Cannot create a " .. aF .. ": "
                    local w
                    if aE == ui.new_textbox and L == nil then
                        L = "\n"
                    end
                    L = (self.prefix or "") .. L .. (self.suffix or "")
                    if aE == ui.new_slider then
                        local aH, aI, aJ, aK, aL, aM, aN = unpack(y)
                        if type(aJ) == "table" then
                            local aO = aJ
                            aJ = aO.default
                            aK = aO.show_tooltip
                            aL = aO.unit
                            aM = aO.scale
                            aN = aO.tooltips
                        end
                        if aJ ~= nil then
                        end
                        if aL ~= nil then
                        end
                        aJ = aJ or nil
                        if aK == nil then
                            aK = true
                        end
                        aL = aL or nil
                        aM = aM or 1
                        aN = aN or nil
                        w = r.new(ui.new_slider, self.tab, self.container, L, aH, aI, aJ, aK, aL, aM, aN)
                    elseif aE == ui.new_combobox or aE == ui.new_multiselect or aE == ui.new_listbox then
                        local aP = {...}
                        if #aP == 1 and type(aP[1]) == "table" then
                            aP = aP[1]
                        end
                        if aE == ui.new_multiselect then
                            local aQ = {}
                            for g = 1, #aP do
                                local I = aP[g]
                                if type(I) == "table" then
                                    table.insert(at, I)
                                    for aR = 1, #I do
                                        table.insert(aQ, I[aR])
                                    end
                                else
                                    table.insert(aQ, I)
                                end
                            end
                            aP = aQ
                        end
                        for g = 1, #aP do
                            local I = aP[g]
                        end
                        if aE == ui.new_multiselect then
                            local G
                            G, w = pcall(r.new, ui.new_multiselect, self.tab, self.container, L, aP)
                            if not G then
                                error(w, 2)
                            end
                        end
                    elseif aE == ui.new_hotkey then
                        if y[1] == nil then
                            y[1] = false
                        end
                        local aS = unpack(y)
                    elseif aE == ui.new_button then
                        local ar = unpack(y)
                    elseif aE == ui.new_color_picker then
                        local aT, aU, aV, aW = unpack(y)
                    end
                    if w == nil then
                        local G
                        G, w = pcall(r.new, aE, self.tab, self.container, L, ...)
                        if not G then
                            error(w, 2)
                        end
                    end
                    self[q[w].reference] = w
                    if #at > 0 then
                        q[w].combo_elements = at
                        local aX = {}
                        for g = 1, #at do
                            if not at[g].required == false then
                                table.insert(aX, at[g][1])
                            end
                        end
                        w:set(aX)
                        q[w].value_prev = aX
                        r._process_callbacks(w)
                    end
                    return w
                end
            end
        end}
    local aY = {
        RAGE = {"Aimbot", "Other"},
        AA = {"Anti-aimbot angles", "Fake lag", "Other"},
        LEGIT = {"Weapon type", "Aimbot", "Triggerbot", "Other"},
        VISUALS = {"Player ESP", "Other ESP", "Colored models", "Effects"},
        MISC = {"Miscellaneous", "Settings", "Lua", "Other"},
        SKINS = {"Weapon skin", "Knife options", "Glove options"},
        PLAYERS = {"Players", "Adjustments"},
        LUA = {"A", "B"}
    }
    for J, aZ in pairs(aY) do
        aY[J] = {}
        for g = 1, #aZ do
            aY[J][aZ[g]:lower()] = true
        end
    end
    function aB.new(J, K)
        J = J:upper()
        return setmetatable({tab = J, container = K, items = {}}, aC)
    end
    function aB.reference(J, K, L)
        if L == nil and type(J) == "table" and getmetatable(J) == aC then
            L = K
            J, K = J.tab, J.container
        end
        local a_ = {pcall(ui.reference, J, K, L)}
        j(a_[1] == true, "Cannot reference a Gamesense menu item: the menu item does not exist.")
        local b0 = {select(2, unpack(a_))}
        local b1 = {}
        for g = 1, #b0 do
            local M = b0[g]
            local w = r.new(M, J, K, L)
            table.insert(b1, w)
        end
        return unpack(b1)
    end
    local b2 =
        setmetatable(
        {},
        {__index = function(aq, o)
                if ui[o] ~= nil and o ~= "new_string" and (o == ui.reference or o:sub(1, 4) == "new_") then
                    return function(...)
                        local G, f = pcall(ui[o], ...)
                        if not G then
                            error(f, 2)
                        end
                        return r.new(f, ...)
                    end
                end
            end}
    )
    return setmetatable(
        aB,
        {__call = function(aq, ...)
                return aB.new(...)
            end, __index = function(aq, b3)
                return r[b3] or b2[b3] or ui[b3]
            end}
    )
end)()
function math.round(b4, b5)
    local b6 = 10 ^ (b5 or 0)
    return math.floor(b4 * b6 + 0.5) / b6
end
local b7 = {}
b7.__index = b7
local function b8(p, y, r)
    p = type(p) == "number" and math.min(90, math.max(-90, p)) or 0
    y = type(y) == "number" and math.min(180, math.max(-180, y)) or 0
    r = type(r) == "number" and math.min(180, math.max(-180, r)) or 0
    return setmetatable({p = p, y = y, r = r}, b7)
end
local b9 = require("ffi")
local ba
do
    local bb, bc =
        client.find_signature("client_panorama.dll", "\x55\x8B\xEC\x83\xEC\x08\x8B\x15\xCC\xCC\xCC\xCC\x0F\x57")
    if bb and bc ~= nil then
        local bd = b9.typeof("bool(__thiscall*)(float, float, float, float, float, float, short);")
        ba = b9.cast(bd, bc)
    end
end
function math.round(b4, b5)
    local b6 = 10 ^ (b5 or 0)
    return math.floor(b4 * b6 + 0.5) / b6
end
local be = {}
local b7 = {__index = be}
b7.__call = function(b8, bf, bg, bh)
    bf = bf or b8.p
    bg = bg or b8.y
    bh = bh or b8.r
    b8.p = bf
    b8.y = bg
    b8.r = bh
end
local function b8(p, y, r)
    return setmetatable({p = p or 0, y = y or 0, r = r or 0}, b7)
end
function be:set(p, y, r)
    p = p or self.p
    y = y or self.y
    r = r or self.r
    self.p = p
    self.y = y
    self.r = r
end
function be:offset(p, y, r)
    p = self.p + p or 0
    y = self.y + y or 0
    r = self.r + r or 0
    self.p = self.p + p
    self.y = self.y + y
    self.r = self.r + r
end
function be:clone()
    return setmetatable({p = self.p, y = self.y, r = self.r}, b7)
end
function be:clone_offset(p, y, r)
    p = self.p + p or 0
    y = self.y + y or 0
    r = self.r + r or 0
    return b8(self.p + p, self.y + y, self.r + r)
end
function be:clone_set(p, y, r)
    p = p or self.p
    y = y or self.y
    r = r or self.r
    return b8(p, y, r)
end
function be:unpack()
    return self.p, self.y, self.r
end
function be:nullify()
    self.p = 0
    self.y = 0
    self.r = 0
end
function b7.__tostring(bi)
    return string.format("%s, %s, %s", bi.p, bi.y, bi.r)
end
function b7.__concat(bi)
    return string.format("%s, %s, %s", bi.p, bi.y, bi.r)
end
function b7.__add(bi, bj)
    if type(bi) == "number" then
        return b8(bi + bj.p, bi + bj.y, bi + bj.r)
    end
    if type(bj) == "number" then
        return b8(bi.p + bj, bi.y + bj, bi.r + bj)
    end
    return b8(bi.p + bj.p, bi.y + bj.y, bi.r + bj.r)
end
function b7.__sub(bi, bj)
    if type(bi) == "number" then
        return b8(bi - bj.p, bi - bj.y, bi - bj.r)
    end
    if type(bj) == "number" then
        return b8(bi.p - bj, bi.y - bj, bi.r - bj)
    end
    return b8(bi.p - bj.p, bi.y - bj.y, bi.r - bj.r)
end
function b7.__mul(bi, bj)
    if type(bi) == "number" then
        return b8(bi * bj.p, bi * bj.y, bi * bj.r)
    end
    if type(bj) == "number" then
        return b8(bi.p * bj, bi.y * bj, bi.r * bj)
    end
    return b8(bi.p * bj.p, bi.y * bj.y, bi.r * bj.r)
end
function b7.__div(bi, bj)
    if type(bi) == "number" then
        return b8(bi / bj.p, bi / bj.y, bi / bj.r)
    end
    if type(bj) == "number" then
        return b8(bi.p / bj, bi.y / bj, bi.r / bj)
    end
    return b8(bi.p / bj.p, bi.y / bj.y, bi.r / bj.r)
end
function b7.__pow(bi, bj)
    if type(bi) == "number" then
        return b8(math.pow(bi, bj.p), math.pow(bi, bj.y), math.pow(bi, bj.r))
    end
    if type(bj) == "number" then
        return b8(math.pow(bi.p, bj), math.pow(bi.y, bj), math.pow(bi.r, bj))
    end
    return b8(math.pow(bi.p, bj.p), math.pow(bi.y, bj.y), math.pow(bi.r, bj.r))
end
function b7.__mod(bi, bj)
    if type(bi) == "number" then
        return b8(bi % bj.p, bi % bj.y, bi % bj.r)
    end
    if type(bj) == "number" then
        return b8(bi.p % bj, bi.y % bj, bi.r % bj)
    end
    return b8(bi.p % bj.p, bi.y % bj.y, bi.r % bj.r)
end
function b7.__unm(bi)
    return b8(-bi.p, -bi.y, -bi.r)
end
function be:round_zero()
    self.p = math.floor(self.p + 0.5)
    self.y = math.floor(self.y + 0.5)
    self.r = math.floor(self.r + 0.5)
end
function be:round(b5)
    self.p = math.round(self.p, b5)
    self.y = math.round(self.y, b5)
    self.r = math.round(self.r, b5)
end
function be:round_base(bk)
    self.p = bk * math.round(self.p / bk)
    self.y = bk * math.round(self.y / bk)
    self.r = bk * math.round(self.r / bk)
end
function be:rounded_zero()
    return b8(math.floor(self.p + 0.5), math.floor(self.y + 0.5), math.floor(self.r + 0.5))
end
function be:rounded(b5)
    return b8(math.round(self.p, b5), math.round(self.y, b5), math.round(self.r, b5))
end
function be:rounded_base(bk)
    return b8(bk * math.round(self.p / bk), bk * math.round(self.y / bk), bk * math.round(self.r / bk))
end
local bl = {}
local bm = {__index = bl}
bm.__call = function(bn, bo, bg, bp)
    bo = bo or bn.x
    bg = bg or bn.y
    bp = bp or bn.z
    bn.x = bo
    bn.y = bg
    bn.z = bp
end
local function bn(x, y, z)
    return setmetatable({x = x or 0, y = y or 0, z = z or 0}, bm)
end
function bl:set(bo, bg, bp)
    bo = bo or self.x
    bg = bg or self.y
    bp = bp or self.z
    self.x = bo
    self.y = bg
    self.z = bp
end
function bl:offset(bq, br, bs)
    bq = bq or 0
    br = br or 0
    bs = bs or 0
    self.x = self.x + bq
    self.y = self.y + br
    self.z = self.z + bs
end
function bl:clone()
    return setmetatable({x = self.x, y = self.y, z = self.z}, bm)
end
function bl:clone_offset(bq, br, bs)
    bq = bq or 0
    br = br or 0
    bs = bs or 0
    return setmetatable({x = self.x + bq, y = self.y + br, z = self.z + bs}, bm)
end
function bl:clone_set(bo, bg, bp)
    bo = bo or self.x
    bg = bg or self.y
    bp = bp or self.z
    return bn(bo, bg, bp)
end
function bl:unpack()
    return self.x, self.y, self.z
end
function bl:nullify()
    self.x = 0
    self.y = 0
    self.z = 0
end
function bm.__tostring(bi)
    return string.format("%s, %s, %s", bi.x, bi.y, bi.z)
end
function bm.__concat(bi)
    return string.format("%s, %s, %s", bi.x, bi.y, bi.z)
end
function bm.__eq(bi, bj)
    return bi.x == bj.x and bi.y == bj.y and bi.z == bj.z
end
function bm.__lt(bi, bj)
    if type(bi) == "number" then
        return bi < bj.x or bi < bj.y or bi < bj.z
    end
    if type(bj) == "number" then
        return bi.x < bj or bi.y < bj or bi.z < bj
    end
    return bi.x < bj.x or bi.y < bj.y or bi.z < bj.z
end
function bm.__le(bi, bj)
    if type(bi) == "number" then
        return bi <= bj.x or bi <= bj.y or bi <= bj.z
    end
    if type(bj) == "number" then
        return bi.x <= bj or bi.y <= bj or bi.z <= bj
    end
    return bi.x <= bj.x or bi.y <= bj.y or bi.z <= bj.z
end
function bm.__add(bi, bj)
    if type(bi) == "number" then
        return bn(bi + bj.x, bi + bj.y, bi + bj.z)
    end
    if type(bj) == "number" then
        return bn(bi.x + bj, bi.y + bj, bi.z + bj)
    end
    return bn(bi.x + bj.x, bi.y + bj.y, bi.z + bj.z)
end
function bm.__sub(bi, bj)
    if type(bi) == "number" then
        return bn(bi - bj.x, bi - bj.y, bi - bj.z)
    end
    if type(bj) == "number" then
        return bn(bi.x - bj, bi.y - bj, bi.z - bj)
    end
    return bn(bi.x - bj.x, bi.y - bj.y, bi.z - bj.z)
end
function bm.__mul(bi, bj)
    if type(bi) == "number" then
        return bn(bi * bj.x, bi * bj.y, bi * bj.z)
    end
    if type(bj) == "number" then
        return bn(bi.x * bj, bi.y * bj, bi.z * bj)
    end
    return bn(bi.x * bj.x, bi.y * bj.y, bi.z * bj.z)
end
function bm.__div(bi, bj)
    if type(bi) == "number" then
        return bn(bi / bj.x, bi / bj.y, bi / bj.z)
    end
    if type(bj) == "number" then
        return bn(bi.x / bj, bi.y / bj, bi.z / bj)
    end
    return bn(bi.x / bj.x, bi.y / bj.y, bi.z / bj.z)
end
function bm.__pow(bi, bj)
    if type(bi) == "number" then
        return bn(math.pow(bi, bj.x), math.pow(bi, bj.y), math.pow(bi, bj.z))
    end
    if type(bj) == "number" then
        return bn(math.pow(bi.x, bj), math.pow(bi.y, bj), math.pow(bi.z, bj))
    end
    return bn(math.pow(bi.x, bj.x), math.pow(bi.y, bj.y), math.pow(bi.z, bj.z))
end
function bm.__mod(bi, bj)
    if type(bi) == "number" then
        return bn(bi % bj.x, bi % bj.y, bi % bj.z)
    end
    if type(bj) == "number" then
        return bn(bi.x % bj, bi.y % bj, bi.z % bj)
    end
    return bn(bi.x % bj.x, bi.y % bj.y, bi.z % bj.z)
end
function bm.__unm(bi)
    return bn(-bi.x, -bi.y, -bi.z)
end
function bl:length2_squared()
    return self.x * self.x + self.y * self.y
end
function bl:length2()
    return math.sqrt(self:length2_squared())
end
function bl:length_squared()
    return self.x * self.x + self.y * self.y + self.z * self.z
end
function bl:length()
    return math.sqrt(self:length_squared())
end
function bl:dot_product(b)
    return self.x * b.x + self.y * b.y + self.z * b.z
end
function bl:cross_product(b)
    return bn(self.y * b.z - self.z * b.y, self.z * b.x - self.x * b.z, self.x * b.y - self.y * b.x)
end
function bl:distance2(bt)
    return (bt - self):length2()
end
function bl:distance(bt)
    return (bt - self):length()
end
function bl:distance_x(bt)
    return math.abs(self.x - bt.x)
end
function bl:distance_y(bt)
    return math.abs(self.y - bt.y)
end
function bl:distance_z(bt)
    return math.abs(self.z - bt.z)
end
function bl:in_range(bt, bu)
    return self:distance(bt) <= bu
end
function bl:round_zero()
    self.x = math.floor(self.x + 0.5)
    self.y = math.floor(self.y + 0.5)
    self.z = math.floor(self.z + 0.5)
end
function bl:round(b5)
    self.x = math.round(self.x, b5)
    self.y = math.round(self.y, b5)
    self.z = math.round(self.z, b5)
end
function bl:round_base(bk)
    self.x = bk * math.round(self.x / bk)
    self.y = bk * math.round(self.y / bk)
    self.z = bk * math.round(self.z / bk)
end
function bl:rounded_zero()
    return bn(math.floor(self.x + 0.5), math.floor(self.y + 0.5), math.floor(self.z + 0.5))
end
function bl:rounded(b5)
    return bn(math.round(self.x, b5), math.round(self.y, b5), math.round(self.z, b5))
end
function bl:rounded_base(bk)
    return bn(bk * math.round(self.x / bk), bk * math.round(self.y / bk), bk * math.round(self.z / bk))
end
function bl:normalize()
    local bv = self:length()
    if bv ~= 0 then
        self.x = self.x / bv
        self.y = self.y / bv
        self.z = self.z / bv
    else
        self.x = 0
        self.y = 0
        self.z = 1
    end
end
function bl:normalized_length()
    return self:length()
end
function bl:normalized()
    local bv = self:length()
    if bv ~= 0 then
        return bn(self.x / bv, self.y / bv, self.z / bv)
    else
        return bn(0, 0, 1)
    end
end
function bl:to_screen(bw)
    local x, y = renderer.world_to_screen(self.x, self.y, self.z)
    if x == nil or y == nil then
        return nil
    end
    if bw == true then
        local bx, by = client.screen_size()
        if x < 0 or x > bx or y < 0 or y > by then
            return nil
        end
    end
    return bn(x, y)
end
function bl:magnitude()
    return math.sqrt(math.pow(self.x, 2) + math.pow(self.y, 2) + math.pow(self.z, 2))
end
function bl:angle_to(bt)
    local bz = bn(bt.x - self.x, bt.y - self.y, bt.z - self.z)
    local bA = math.deg(math.atan2(bz.y, bz.x))
    local bB = math.sqrt(bz.x * bz.x + bz.y * bz.y)
    local bC = math.deg(math.atan2(-bz.z, bB))
    return b8(bC, bA)
end
function bl:lerp(bt, bD)
    return self + (bt - self) * bD
end
local function bE(bF, bt, m, n)
    return bn((bF.x * n + bt.x * m) / (m + n), (bF.y * n + bt.y * m) / (m + n), (bF.z * n + bt.z * m) / (m + n))
end
function bl:trace_line_to(bt, bG)
    bG = bG or -1
    return client.trace_line(bG, self.x, self.y, self.z, bt.x, bt.y, bt.z)
end
function bl:trace_line_impact(bt, bG)
    bG = bG or -1
    local bH, bI = client.trace_line(bG, self.x, self.y, self.z, bt.x, bt.y, bt.z)
    local bJ = self:lerp(bt, bH)
    return bH, bI, bJ
end
function bl:trace_line_skip_indices(bt, bK, bL)
    bK = bK or 10
    local bH, bI = 0, -1
    local bJ = self
    local i = 0
    while bK >= i and bH < 1 and (bI > -1 and bL(bI) or bJ == self) do
        bH, bI, bJ = bJ:trace_line_impact(bt, bI)
        i = i + 1
    end
    return self:distance(bJ) / self:distance(bt), bI, bJ
end
function bl:trace_line_skip_class(bt, bM, bN)
    local bO = function(bP, bQ)
        local bR = entity.get_classname(bP) or ""
        for i in 1, #bQ do
            if bR == bQ[i] then
                return true
            end
        end
        return false
    end
    local bS = self:angle_to(bt)
    local bT = bS:to_forward_vector()
    local bU = self
    while true do
        local bH, bV = bU:trace_line_to(bt)
        if bH == 1 and bV == -1 then
            return 1, -1
        else
            if bO(bV, bM) then
                bU = bE(self, bt, bH, 1 - bH)
                bU = bU + bT * bN
            else
                return bH, bV, self:lerp(bt, bH)
            end
        end
    end
end
function bl:trace_bullet_to(bt, bI)
    return client.trace_bullet(bI, self.x, self.y, self.z, bt.x, bt.y, bt.z)
end
function bl:closest_ray_point(bW, bX)
    local bY = self - bW
    local bT = bX - bW
    local bv = bT:length()
    bT:normalize()
    local bZ = bY:dot_product(bT)
    if bZ < 0 then
        return bW
    elseif bZ > bv then
        return bX
    end
    return bW + bT * bZ
end
function bl:ray_divided(bX, b_)
    return (self * b_ + bX) / (1 + b_)
end
function bl:ray_segmented(bX, c0)
    local c1 = {}
    for i = 0, c0 do
        c1[i] = bE(self, bX, i, c0 - i)
    end
    return c1
end
function bl:ray(bX, c2)
    c2 = c2 or 128
    local c0 = {}
    local c3 = self:distance(bX) / c2
    local b8 = self:angle_to(bX)
    local bT = b8:to_forward_vector()
    for i = 1, c2 do
        table.insert(c0, self + bT * c3 * i)
    end
    local c4 = bn(0, 0, 0)
    local c5 = bn(0, 0, 0)
    local c6 = false
    local c7 = false
    for i = 1, #c0 do
        c4 = c0[i]:to_screen()
        if c4 ~= nil then
            c6 = true
            break
        end
    end
    for i = #c0, 1, -1 do
        c5 = c0[i]:to_screen()
        if c5 ~= nil then
            c7 = true
            break
        end
    end
    if c6 and c7 then
        return c4, c5
    end
    return nil
end
function bl:ray_intersects_smoke(bX)
    if ba == nil then
        error("Unsafe scripts must be allowed in order to use vector_c:ray_intersects_smoke")
    end
    return ba(self.x, self.y, self.z, bX.x, bX.y, bX.z, 1)
end
function bl:inside_polygon2(c8)
    local c9 = false
    local ca = #c8
    local j = ca
    for i = 1, ca do
        if c8[i].y < self.y and c8[j].y >= self.y or c8[j].y < self.y and c8[i].y >= self.y then
            if c8[i].x + (self.y - c8[i].y) / (c8[j].y - c8[i].y) * (c8[j].x - c8[i].x) < self.x then
                c9 = not c9
            end
        end
        j = i
    end
    return c9
end
function bl:draw_circle(cb, r, g, b, a, cc, cd, ce, cf, bD)
    local cc = cc ~= nil and cc or 3
    local cd = cd ~= nil and cd or 1
    local ce = ce ~= nil and ce or false
    local cf = cf ~= nil and cf or 0
    local bD = bD ~= nil and bD or 1
    local cg, ch
    for ci = cf, bD * 360, cc do
        local cj = math.rad(ci)
        local ck, cl, cm = cb * math.cos(cj) + self.x, cb * math.sin(cj) + self.y, self.z
        local cn, co = renderer.world_to_screen(ck, cl, cm)
        if cn ~= nil and cg ~= nil then
            for i = 1, cd do
                local i = i - 1
                renderer.line(cn, co - i, cg, ch - i, r, g, b, a)
            end
            if ce then
                local cp = a / 255 * 160
                renderer.line(cn, co - cd, cg, ch - cd, 16, 16, 16, cp)
                renderer.line(cn, co + 1, cg, ch + 1, 16, 16, 16, cp)
            end
        end
        cg, ch = cn, co
    end
end
function bl:min(cq)
    self.x = math.min(cq, self.x)
    self.y = math.min(cq, self.y)
    self.z = math.min(cq, self.z)
end
function bl:max(cq)
    self.x = math.max(cq, self.x)
    self.y = math.max(cq, self.y)
    self.z = math.max(cq, self.z)
end
function bl:minned(cq)
    return bn(math.min(cq, self.x), math.min(cq, self.y), math.min(cq, self.z))
end
function bl:maxed(cq)
    return bn(math.max(cq, self.x), math.max(cq, self.y), math.max(cq, self.z))
end
function be:to_forward_vector()
    local cr = function(cs)
        return cs * math.pi / 180
    end
    local ct = math.sin(cr(self.p))
    local cu = math.cos(cr(self.p))
    local cv = math.sin(cr(self.y))
    local cw = math.cos(cr(self.y))
    return bn(cu * cw, cu * cv, -ct)
end
function be:to_up_vector()
    local cr = function(cs)
        return cs * math.pi / 180
    end
    local ct = math.sin(cr(self.p))
    local cu = math.cos(cr(self.p))
    local cv = math.sin(cr(self.y))
    local cw = math.cos(cr(self.y))
    local cx = math.sin(cr(self.r))
    local cy = math.cos(cr(self.r))
    return bn(cy * ct * cw + cx * cv, cy * ct * cv + cx * cw * -1, cy * cu)
end
function be:to_right_vector()
    local cr = function(cs)
        return cs * math.pi / 180
    end
    local ct = math.sin(cr(self.p))
    local cu = math.cos(cr(self.p))
    local cv = math.sin(cr(self.y))
    local cw = math.cos(cr(self.y))
    local cx = math.sin(cr(self.r))
    local cy = math.cos(cr(self.r))
    return bn(cx * ct * cw * -1 + cy * cv, cx * ct * cv * -1 + -1 * cy * cw, -1 * cx * cu)
end
function be:to_backward_vector()
    local cr = function(cs)
        return cs * math.pi / 180
    end
    local ct = math.sin(cr(self.p))
    local cu = math.cos(cr(self.p))
    local cv = math.sin(cr(self.y))
    local cw = math.cos(cr(self.y))
    return -bn(cu * cw, cu * cv, -ct)
end
function be:to_left_vector()
    local cr = function(cs)
        return cs * math.pi / 180
    end
    local ct = math.sin(cr(self.p))
    local cu = math.cos(cr(self.p))
    local cv = math.sin(cr(self.y))
    local cw = math.cos(cr(self.y))
    local cx = math.sin(cr(self.r))
    local cy = math.cos(cr(self.r))
    return -bn(cx * ct * cw * -1 + cy * cv, cx * ct * cv * -1 + -1 * cy * cw, -1 * cx * cu)
end
function be:to_down_vector()
    local cr = function(cs)
        return cs * math.pi / 180
    end
    local ct = math.sin(cr(self.p))
    local cu = math.cos(cr(self.p))
    local cv = math.sin(cr(self.y))
    local cw = math.cos(cr(self.y))
    local cx = math.sin(cr(self.r))
    local cy = math.cos(cr(self.r))
    return -bn(cy * ct * cw + cx * cv, cy * ct * cv + cx * cw * -1, cy * cu)
end
function be:fov_to(bF, bt)
    local cz = self:to_forward_vector()
    local cA = (bt - bF):normalized()
    local cB = math.acos(cz:dot_product(cA) / cA:length())
    return math.max(0.0, math.deg(cB))
end
function be:bearing(b5)
    local bA = 180 - self.y + 90
    local cs = (bA % 360 + 360) % 360
    cs = cs > 180 and cs - 360 or cs
    return math.round(cs + 180, b5)
end
function be:start_degrees()
    local bA = self.y
    local cs = (bA % 360 + 360) % 360
    cs = cs > 180 and cs - 360 or cs
    return cs + 180
end
function be:normalize()
    local bC = self.p
    if bC < -89 then
        bC = -89
    elseif bC > 89 then
        bC = 89
    end
    local bA = self.y
    while bA > 180 do
        bA = bA - 360
    end
    while bA < -180 do
        bA = bA + 360
    end
    return b8(bC, bA, 0)
end
function be:normalized()
    if self.p < -89 then
        self.p = -89
    elseif self.p > 89 then
        self.p = 89
    end
    local bA = self.y
    while bA > 180 do
        bA = bA - 360
    end
    while bA < -180 do
        bA = bA + 360
    end
    self.y = bA
    self.r = 0
end
function bl.draw_polygon(c8, r, g, b, a, c0)
    for cC, cD in pairs(c8) do
        local cE = c8[cC + 1]
        if cE == nil then
            cE = c8[1]
        end
        local cF, cG = cD:ray(cE, c0 or 64)
        if cF ~= nil and cG ~= nil then
            renderer.line(cF.x, cF.y, cG.x, cG.y, r, g, b, a)
        end
    end
end
function bl.eye_position(bI)
    local cH = bn(entity.get_origin(bI))
    local cI = entity.get_prop(bI, "m_flDuckAmount") or 0
    cH.z = cH.z + 46 + (1 - cI) * 18
    return cH
end
function b7:clone()
    return b8(self.p, self.y, self.r)
end
function b7:unpack()
    return self.p, self.y, self.r
end
function b7:nullify()
    self.p = 0
    self.y = 0
    self.r = 0
end
function b7:round_zero()
    self.p = math.floor(self.p + 0.5)
    self.y = math.floor(self.y + 0.5)
    self.r = math.floor(self.r + 0.5)
end
function b7:round(b5)
    self.p = math.round(self.p, b5)
    self.y = math.round(self.y, b5)
    self.r = math.round(self.r, b5)
end
function b7:round_base(bk)
    self.p = bk * math.round(self.p / bk)
    self.y = bk * math.round(self.y / bk)
    self.r = bk * math.round(self.r / bk)
end
function b7:rounded_zero()
    return b8(math.floor(self.p + 0.5), math.floor(self.y + 0.5), math.floor(self.r + 0.5))
end
function b7:rounded(b5)
    return b8(math.round(self.p, b5), math.round(self.y, b5), math.round(self.r, b5))
end
function b7:rounded_base(bk)
    return b8(bk * math.round(self.p / bk), bk * math.round(self.y / bk), bk * math.round(self.r / bk))
end
function b7.__tostring(bi)
    return string.format("%s, %s, %s", bi.p, bi.y, bi.r)
end
function b7.__concat(bi)
    return string.format("%s, %s, %s", bi.p, bi.y, bi.r)
end
function b7.__eq(bi, bj)
    if type(bi) == "number" then
        return bi == bj.p and bi == bj.y and bi == bj.r
    end
    if type(bj) == "number" then
        return bi.p == bj and bi.y == bj and bi.r == bj
    end
    return bi.p == bj.p and bi.y == bj.y and bi.r == bj.r
end
function b7.__lt(bi, bj)
    if type(bi) == "number" then
        return bi < bj.p and bi < bj.y and bi < bj.r
    end
    if type(bj) == "number" then
        return bi.p < bj and bi.y < bj and bi.r < bj
    end
    return bi.p < bj.p and bi.y < bj.y and bi.r < bj.r
end
function b7.__le(bi, bj)
    if type(bi) == "number" then
        return bi <= bj.p and bi <= bj.y and bi <= bj.r
    end
    if type(bj) == "number" then
        return bi.p <= bj and bi.y <= bj and bi.r <= bj
    end
    return bi.p <= bj.p and bi.y <= bj.y and bi.r <= bj.r
end
function b7.__add(bi, bj)
    if type(bi) == "number" then
        return b8(bi + bj.p, bi + bj.y, bi + bj.r)
    end
    if type(bj) == "number" then
        return b8(bi.p + bj, bi.y + bj, bi.r + bj)
    end
    return b8(bi.p + bj.p, bi.y + bj.y, bi.r + bj.r)
end
function b7.__sub(bi, bj)
    if type(bi) == "number" then
        return b8(bi - bj.p, bi - bj.y, bi - bj.r)
    end
    if type(bj) == "number" then
        return b8(bi.p - bj, bi.y - bj, bi.r - bj)
    end
    return b8(bi.p - bj.p, bi.y - bj.y, bi.r - bj.r)
end
function b7.__mul(bi, bj)
    if type(bi) == "number" then
        return b8(bi * bj.p, bi * bj.y, bi * bj.r)
    end
    if type(bj) == "number" then
        return b8(bi.p * bj, bi.y * bj, bi.r * bj)
    end
    return b8(bi.p * bj.p, bi.y * bj.y, bi.r * bj.r)
end
function b7.__div(bi, bj)
    if type(bi) == "number" then
        return b8(bi / bj.p, bi / bj.y, bi / bj.r)
    end
    if type(bj) == "number" then
        return b8(bi.p / bj, bi.y / bj, bi.r / bj)
    end
    return b8(bi.p / bj.p, bi.y / bj.y, bi.r / bj.r)
end
function b7.__pow(bi, bj)
    if type(bi) == "number" then
        return b8(math.pow(bi, bj.p), math.pow(bi, bj.y), math.pow(bi, bj.r))
    end
    if type(bj) == "number" then
        return b8(math.pow(bi.p, bj), math.pow(bi.y, bj), math.pow(bi.r, bj))
    end
    return b8(math.pow(bi.p, bj.p), math.pow(bi.y, bj.y), math.pow(bi.r, bj.r))
end
function b7.__mod(bi, bj)
    if type(bi) == "number" then
        return b8(bi % bj.p, bi % bj.y, bi % bj.r)
    end
    if type(bj) == "number" then
        return b8(bi.p % bj, bi.y % bj, bi.r % bj)
    end
    return b8(bi.p % bj.p, bi.y % bj.y, bi.r % bj.r)
end
function b7.__unm()
    self.p = -self.p
    self.y = -self.y
    self.r = -self.r
end
local bm = {}
bm.__index = bm
local function bn(x, y, z)
    x = type(x) == "number" and x or 0
    y = type(y) == "number" and y or 0
    z = type(z) == "number" and z or 0
    return setmetatable({x = x, y = y, z = z}, bm)
end
local function cJ(bI)
    local cK, cL, cM, cN, a = entity.get_bounding_box(bI)
    if a == 0 then
        return nil
    end
    return {left = cK, top = cL, right = cM, bottom = cN, alpha = a}
end
local function cO(bI, cP)
    local x, y, z = entity.hitbox_position(bI, cP)
    if x == nil or y == nil or z == nil then
        return nil
    end
    return bn(x, y, z)
end
function bm:clone()
    return bn(self.x, self.y, self.z)
end
function bm:unpack()
    return self.x, self.y, self.z
end
function bm:nullify()
    self.x = 0
    self.y = 0
    self.z = 0
end
function bm.__tostring(bi)
    return string.format("%s, %s, %s", bi.x, bi.y, bi.z)
end
function bm.__concat(bi)
    return string.format("%s, %s, %s", bi.x, bi.y, bi.z)
end
function bm.__eq(bi, bj)
    return bi.x == bj.x and bi.y == bj.y and bi.z == bj.z
end
function bm.__lt(bi, bj)
    if type(bi) == "number" then
        return bi < bj.x and bi < bj.y and bi < bj.z
    end
    if type(bj) == "number" then
        return bi.x < bj and bi.y < bj and bi.z < bj
    end
    return bi.x < bj.x and bi.y < bj.y and bi.z < bj.z
end
function bm.__le(bi, bj)
    if type(bi) == "number" then
        return bi <= bj.x and bi <= bj.y and bi <= bj.z
    end
    if type(bj) == "number" then
        return bi.x <= bj and bi.y <= bj and bi.z <= bj
    end
    return bi.x <= bj.x and bi.y <= bj.y and bi.z <= bj.z
end
function bm.__add(bi, bj)
    if type(bi) == "number" then
        return bn(bi + bj.x, bi + bj.y, bi + bj.z)
    end
    if type(bj) == "number" then
        return bn(bi.x + bj, bi.y + bj, bi.z + bj)
    end
    return bn(bi.x + bj.x, bi.y + bj.y, bi.z + bj.z)
end
function bm.__sub(bi, bj)
    if type(bi) == "number" then
        return bn(bi - bj.x, bi - bj.y, bi - bj.z)
    end
    if type(bj) == "number" then
        return bn(bi.x - bj, bi.y - bj, bi.z - bj)
    end
    return bn(bi.x - bj.x, bi.y - bj.y, bi.z - bj.z)
end
function bm.__mul(bi, bj)
    if type(bi) == "number" then
        return bn(bi * bj.x, bi * bj.y, bi * bj.z)
    end
    if type(bj) == "number" then
        return bn(bi.x * bj, bi.y * bj, bi.z * bj)
    end
    return bn(bi.x * bj.x, bi.y * bj.y, bi.z * bj.z)
end
function bm.__div(bi, bj)
    if type(bi) == "number" then
        return bn(bi / bj.x, bi / bj.y, bi / bj.z)
    end
    if type(bj) == "number" then
        return bn(bi.x / bj, bi.y / bj, bi.z / bj)
    end
    return bn(bi.x / bj.x, bi.y / bj.y, bi.z / bj.z)
end
function bm.__pow(bi, bj)
    if type(bi) == "number" then
        return bn(math.pow(bi, bj.x), math.pow(bi, bj.y), math.pow(bi, bj.z))
    end
    if type(bj) == "number" then
        return bn(math.pow(bi.x, bj), math.pow(bi.y, bj), math.pow(bi.z, bj))
    end
    return bn(math.pow(bi.x, bj.x), math.pow(bi.y, bj.y), math.pow(bi.z, bj.z))
end
function bm.__mod(bi, bj)
    if type(bi) == "number" then
        return bn(bi % bj.x, bi % bj.y, bi % bj.z)
    end
    if type(bj) == "number" then
        return bn(bi.x % bj, bi.y % bj, bi.z % bj)
    end
    return bn(bi.x % bj.x, bi.y % bj.y, bi.z % bj.z)
end
function bm.__unm(bi)
    return bn(-bi.x, -bi.y, -bi.z)
end
function bm:length2_squared()
    return self.x * self.x + self.y * self.y
end
function bm:length2()
    return math.sqrt(self:length2_squared())
end
function bm:length_squared()
    return self.x * self.x + self.y * self.y + self.z * self.z
end
function bm:length()
    return math.sqrt(self:length_squared())
end
function bm:dot_product(cQ)
    return self.x * cQ.x + self.y * cQ.y + self.z * cQ.z
end
function bm:cross_product(cQ)
    return bm(self.y * cQ.z - self.z * cQ.y, self.z * cQ.x - self.x * cQ.z, self.x * cQ.y - self.y * cQ.x)
end
function bm:distance2(cQ)
    return (cQ - self):length2()
end
function bm:distance(cQ)
    return (cQ - self):length()
end
function bm:distanceX(cQ)
    return math.abs(self.x - cQ.x)
end
function bm:distanceY(cQ)
    return math.abs(self.y - cQ.y)
end
function bm:distanceZ(cQ)
    return math.abs(self.z - cQ.z)
end
function bm:in_range(cQ, bu)
    return self:distance(cQ) <= bu
end
function bm:round_zero()
    self.x = math.floor(self.x + 0.5)
    self.y = math.floor(self.y + 0.5)
    self.z = math.floor(self.z + 0.5)
end
function bm:round(b5)
    self.x = math.round(self.x, b5)
    self.y = math.round(self.y, b5)
    self.z = math.round(self.z, b5)
end
function bm:round_base(bk)
    self.x = bk * math.round(self.x / bk)
    self.y = bk * math.round(self.y / bk)
    self.z = bk * math.round(self.z / bk)
end
function bm:rounded_zero()
    return bn(math.floor(self.x + 0.5), math.floor(self.y + 0.5), math.floor(self.z + 0.5))
end
function bm:rounded(b5)
    return bn(math.round(self.x, b5), math.round(self.y, b5), math.round(self.z, b5))
end
function bm:rounded_base(bk)
    return bn(bk * math.round(self.x / bk), bk * math.round(self.y / bk), bk * math.round(self.z / bk))
end
function bm:normalize()
    local bv = self:length()
    if bv ~= 0 then
        self.x = self.x / bv
        self.y = self.y / bv
        self.z = self.z / bv
    else
        self.x = 0
        self.y = 0
        self.z = 1
    end
end
function bm:normalized_length()
    return self:length()
end
function bm:normalized()
    local bv = self:length()
    if bv ~= 0 then
        return bn(self.x / bv, self.y / bv, self.z / bv)
    else
        return bn(0, 0, 1)
    end
end
function bm:to_screen()
    local x, y = renderer.world_to_screen(self.x, self.y, self.z)
    if x == nil or y == nil then
        return nil
    end
    return bn(x, y)
end
function bm:magnitude()
    return math.sqrt(math.pow(self.x, 2) + math.pow(self.y, 2) + math.pow(self.z, 2))
end
function bm:angle_to(cQ)
    local bz = bn(cQ.x - self.x, cQ.y - self.y, cQ.z - self.z)
    if bz.x == 0 and bz.y == 0 then
        return b8(bz.z > 0 and 270 or 90, 0)
    else
        local bA = math.deg(math.atan2(bz.y, bz.x))
        local bB = math.sqrt(bz.x * bz.x + bz.y * bz.y)
        local bC = math.deg(math.atan2(-bz.z, bB))
        return b8(bC, bA)
    end
end
function bm:trace_line_to(cQ, bG)
    bG = bG or 0
    return client.trace_line(bG, self.x, self.y, self.z, cQ.x, cQ.y, cQ.z)
end
function bm:trace_bullet_to(cR, cQ)
    return client.trace_bullet(cR, self.x, self.y, self.z, cQ.x, cQ.y, cQ.z)
end
function b7:to_unit_vector()
    local cr = function(cs)
        return cs * math.pi / 180
    end
    local ct = math.sin(cr(self.p))
    local cu = math.cos(cr(self.p))
    local cv = math.sin(cr(self.y))
    local cw = math.cos(cr(self.y))
    local cx = math.sin(cr(self.r))
    local cy = math.cos(cr(self.r))
    local cS = bn(cu * cw, cu * cv, -ct)
    local cT = bn(cx * ct * cw * -1 + cy * cv, cx * ct * cv * -1 + -1 * cy * cw, -1 * cx * cu)
    local cU = bn(cy * ct * cw + cx * cv, cy * ct * cv + cx * cw * -1, cy * cu)
    return {forward = cS, right = cT, up = cU, backward = -cS, left = -cT, bottom = -cU}
end
function b7:to_forward_vector()
    local cr = function(cs)
        return cs * math.pi / 180
    end
    local ct = math.sin(cr(self.p))
    local cu = math.cos(cr(self.p))
    local cv = math.sin(cr(self.y))
    local cw = math.cos(cr(self.y))
    return bn(cu * cw, cu * cv, -ct)
end
function b7:to_up_vector()
    local cr = function(cs)
        return cs * math.pi / 180
    end
    local ct = math.sin(cr(self.p))
    local cu = math.cos(cr(self.p))
    local cv = math.sin(cr(self.y))
    local cw = math.cos(cr(self.y))
    local cx = math.sin(cr(self.r))
    local cy = math.cos(cr(self.r))
    return bn(cy * ct * cw + cx * cv, cy * ct * cv + cx * cw * -1, cy * cu)
end
function b7:to_right_vector()
    local cr = function(cs)
        return cs * math.pi / 180
    end
    local ct = math.sin(cr(self.p))
    local cu = math.cos(cr(self.p))
    local cv = math.sin(cr(self.y))
    local cw = math.cos(cr(self.y))
    local cx = math.sin(cr(self.r))
    local cy = math.cos(cr(self.r))
    return bn(cx * ct * cw * -1 + cy * cv, cx * ct * cv * -1 + -1 * cy * cw, -1 * cx * cu)
end
function b7:to_backward_vector()
    local cr = function(cs)
        return cs * math.pi / 180
    end
    local ct = math.sin(cr(self.p))
    local cu = math.cos(cr(self.p))
    local cv = math.sin(cr(self.y))
    local cw = math.cos(cr(self.y))
    return -bn(cu * cw, cu * cv, -ct)
end
function b7:to_left_vector()
    local cr = function(cs)
        return cs * math.pi / 180
    end
    local ct = math.sin(cr(self.p))
    local cu = math.cos(cr(self.p))
    local cv = math.sin(cr(self.y))
    local cw = math.cos(cr(self.y))
    local cx = math.sin(cr(self.r))
    local cy = math.cos(cr(self.r))
    return -bn(cx * ct * cw * -1 + cy * cv, cx * ct * cv * -1 + -1 * cy * cw, -1 * cx * cu)
end
function b7:to_down_vector()
    local cr = function(cs)
        return cs * math.pi / 180
    end
    local ct = math.sin(cr(self.p))
    local cu = math.cos(cr(self.p))
    local cv = math.sin(cr(self.y))
    local cw = math.cos(cr(self.y))
    local cx = math.sin(cr(self.r))
    local cy = math.cos(cr(self.r))
    return -bn(cy * ct * cw + cx * cv, cy * ct * cv + cx * cw * -1, cy * cu)
end
local ffi = require "ffi"

ffi.cdef [[	
    typedef void*( __thiscall* get_client_entity_fn_87692764296 )( void*, int );

	struct CCSGOPlayerAnimstate_67813985419 {
		char pad[ 3 ];
		char m_bForceWeaponUpdate; //0x4
		char pad1[ 91 ];
		void* m_pBaseEntity; //0x60
		void* m_pActiveWeapon; //0x64
		void* m_pLastActiveWeapon; //0x68
		float m_flLastClientSideAnimationUpdateTime; //0x6C
		int m_iLastClientSideAnimationUpdateFramecount; //0x70
		float m_flAnimUpdateDelta; //0x74
		float m_flEyeYaw; //0x78
		float m_flPitch; //0x7C
		float m_flGoalFeetYaw; //0x80
		float m_flCurrentFeetYaw; //0x84
		float m_flCurrentTorsoYaw; //0x88
		float m_flUnknownVelocityLean; //0x8C
		float m_flLeanAmount; //0x90
		char pad2[ 4 ];
		float m_flFeetCycle; //0x98
		float m_flFeetYawRate; //0x9C
		char pad3[ 4 ];
		float m_fDuckAmount; //0xA4
		float m_fLandingDuckAdditiveSomething; //0xA8
		char pad4[ 4 ];
		float m_vOriginX; //0xB0
		float m_vOriginY; //0xB4
		float m_vOriginZ; //0xB8
		float m_vLastOriginX; //0xBC
		float m_vLastOriginY; //0xC0
		float m_vLastOriginZ; //0xC4
		float m_vVelocityX; //0xC8
		float m_vVelocityY; //0xCC
		char pad5[ 4 ];
		float m_flUnknownFloat1; //0xD4
		char pad6[ 8 ];
		float m_flUnknownFloat2; //0xE0
		float m_flUnknownFloat3; //0xE4
		float m_flUnknown; //0xE8
		float m_flSpeed2D; //0xEC
		float m_flUpVelocity; //0xF0
		float m_flSpeedNormalized; //0xF4
		float m_flFeetSpeedForwardsOrSideWays; //0xF8
		float m_flFeetSpeedUnknownForwardOrSideways; //0xFC
		float m_flTimeSinceStartedMoving; //0x100
		float m_flTimeSinceStoppedMoving; //0x104
		bool m_bOnGround; //0x108
		bool m_bInHitGroundAnimation; //0x109
		float m_flTimeSinceInAir; //0x10A
		float m_flLastOriginZ; //0x10E
		float m_flHeadHeightOrOffsetFromHittingGroundAnimation; //0x112
		float m_flStopToFullRunningFraction; //0x116
		char pad7[ 4 ]; //0x11A
		float m_flMagicFraction; //0x11E
		char pad8[ 60 ]; //0x122
		float m_flWorldForce; //0x15E
		char pad9[ 462 ]; //0x162
		float m_flMaxYaw; //0x334
	};
]]

local entity_list = ffi.cast(ffi.typeof("void***"), client.create_interface("client.dll", "VClientEntityList003"))

local get_client_entity = ffi.cast("get_client_entity_fn_87692764296", entity_list[0][3])
local plist_set, plist_get = plist.set, plist.get
local dragging_2 = (function()
    local a = {}
    local b, c, d, e, f, g, h, i, j, k, l, m, n, o, dg
    local p = {__index = {drag = function(self, ...)
                local q, r = self:get()
                local s, t = a.drag(q, r, ...)
                if q ~= s or r ~= t then
                    self:set(s, t)
                end
                return s, t
            end, set = function(self, q, r)
                local j, k = client.screen_size()
                ui.set(self.x_reference, q / j * self.res)
                ui.set(self.y_reference, r / k * self.res)
            end, get = function(self)
                local j, k = client.screen_size()
                return ui.get(self.x_reference) / self.res * j, ui.get(self.y_reference) / self.res * k
            end}}
    function a.new(u, v, w, x)
        x = x or 10000
        local j, k = client.screen_size()
        local y = ui.new_slider("LUA", "A", u .. " window position 2", 0, x, v / j * x)
        local z = ui.new_slider("LUA", "A", "\n" .. u .. " window position y 2", 0, x, w / k * x)
        ui.set_visible(y, false)
        ui.set_visible(z, false)
        return setmetatable({name = u, x_reference = y, y_reference = z, res = x}, p)
    end
    function a.drag(q, r, A, B, C, D, E)
        if globals.framecount() ~= b then
            c = ui.is_menu_open()
            f, g = d, e
            d, e = ui.mouse_position()
            i = h
            h = client.key_state(0x01) == true
            m = l
            l = {}
            o = n
            n = false
            j, k = client.screen_size()
        end
        if c and i ~= nil then
            if (not i or o) and h and f > q and g > r and f < q + A and g < r + B then
                n = true
                q, r = q + d - f, r + e - g
                if not D then
                    q = math.max(0, math.min(j - A, q))
                    r = math.max(0, math.min(k - B, r))
                end
            end
            if f >= q and g >= r and f <= q + A and g <= r + B then
                dg = true
            else
                dg = false
            end
        else
            f, g, d, e = 0, 0, 0, 0
            dg = false
        end
        table.insert(l, {q, r, A, B})
        return q, r, A, B
    end
    function a.match()
        return dg
    end
    return a
end)()
local Enableresolver = ui.new_hotkey("RAGE", "Other", "Epoch resolver")
local hk_dragger = dragging_2.new("Resolver Indicators", 500, 600)
local draw_indicator = ui.new_checkbox("Rage", "Other", "Draw Resolver Angles")
local indicator_color = ui.new_color_picker("Rage", "Other", "Global Color C_S", 0, 255, 255, 255)
local draw = ui.new_checkbox("RAGE", "Other", "Draw points")
local Resetlist = ui.reference("Players", "Players", "Reset all")

local death_invert = {}
local antibrute = {}
local tries = {}
local resolved = {}
local high_delta = {}
local Headshot = {}

local function vec_3(_x, _y, _z)
    return {x = _x or 0, y = _y or 0, z = _z or 0}
end
local function get_max_feet_yaw(player)
    local player_ptr = ffi.cast("void***", get_client_entity(entity_list, player))
    local animstate_ptr = ffi.cast("char*", player_ptr) + 0x3914
    local state = ffi.cast("struct CCSGOPlayerAnimstate_67813985419**", animstate_ptr)[0]
    local eye_angles = vec_3(entity.get_prop(player, "m_angEyeAngles"))

    local duckammount = state.m_fDuckAmount
    local speedfraction = math.max(0, math.min(state.m_flFeetSpeedForwardsOrSideWays, 1.))
    local speedfactor = math.max(0, math.max(1, state.m_flFeetSpeedUnknownForwardOrSideways))
    local unk1 = ((state.m_flStopToFullRunningFraction * -0.30000001) - 0.19999999) * speedfraction
    local unk2 = unk1 + 1

    if duckammount > 0 then
        unk2 = unk2 + ((duckammount * speedfactor) * (0.5 - unk2))
    end

    return (state.m_flMaxYaw) * unk2
end

local function extrapolate(player, x, y, z)
    local xv, yv, zv = entity.get_prop(player, "m_vecVelocity")
    local new_x = x + globals.tickinterval() * xv
    local new_y = y + globals.tickinterval() * yv
    local new_z = z + globals.tickinterval() * zv
    return new_x, new_y, new_z
end

function on_aim_fire(e)
    if not ui.get(Enableresolver) then
        return
    end
    if antibrute[e.target] == nil then
        antibrute[e.target] = false
    end
    if tries[e.target] == nil then
        tries[e.target] = 0
    end
    client.color_log(
        135,
        206,
        250,
        "[Epoch] Ŀ��:" ..
            entity.get_player_name(e.target) ..
                ", �˺�:" ..
                    e.damage ..
                        string.format("������:%d", e.hit_chance) ..
                            ", �Զ���ͷ:" ..
                                (antibrute[e.target] and "��" or "��") ..
                                    ", ������תAA:" ..
                                        (death_invert[e.target] and "��" or "��") ..
                                            ", �����:" .. (high_delta[e.target] and "��" or "��")
    )
end

local function on_player_hurt(e)
    if not ui.get(Enableresolver) then
        return
    end
    local attacker_id = client.userid_to_entindex(e.attacker)
    if attacker_id == nil then
        return
    end

    if attacker_id ~= entity.get_local_player() then
        return
    end
    if e.hitgroup ~= 0 then
        resolved[client.userid_to_entindex(e.userid)] = true
        tries[client.userid_to_entindex(e.userid)] = 0
        client.color_log(
            135,
            206,
            250,
            "[Epoch] success resolved " ..
                entity.get_player_name(client.userid_to_entindex(e.userid)) ..
                    ", resolved angles:" .. plist_get(client.userid_to_entindex(e.userid), "Force body yaw value")
        )

        if
            e.dmg_health >= entity.get_prop(client.userid_to_entindex(e.userid), "m_iHealth") and
                death_invert[client.userid_to_entindex(e.userid)] == true
         then
            plist_set(
                client.userid_to_entindex(e.userid),
                "Force body yaw value",
                plist_get(client.userid_to_entindex(e.userid), "Force body yaw value") * -1
            )
            client.color_log(
                135,
                206,
                250,
                "[Epochzer] try to flip angle " .. entity.get_player_name(client.userid_to_entindex(e.userid))
            )
        end
    end
end

local function on_player_join(e)
    if not ui.get(Enableresolver) then
        return
    end
    if client.userid_to_entindex(e.userid) == entity.get_local_player() then
        resolved = {}
    elseif entity.is_enemy(client.userid_to_entindex(e.userid)) then
        resolved[client.userid_to_entindex(e.userid)] = false
    end
end

-- 111111 saughter
local function Reset()
    ui.set(Resetlist, true)
    death_invert = {}
    antibrute = {}
    tries = {}
    resolved = {}
    high_delta = {}
    Headshot = {}
end

--client.set_event_callback('aim_fire', on_aim_fire)

client.set_event_callback("player_hurt", on_player_hurt)
client.set_event_callback("player_join", on_player_join)
ui.set_callback(Enableresolver, Reset)
client.set_event_callback(
    "paint_ui",
    function(e)
        if not entity.is_alive(entity.get_local_player()) or not ui.get(Enableresolver) then
            return
        end

        local active_players = 0
        local x, y = hk_dragger:get()
        local player = entity.get_players(true)
        local weapon_r, weapon_g, weapon_b, weapon_a = ui.get(indicator_color)
        local alpha = 1 + math.sin(math.abs(-math.pi + globals.realtime() % (math.pi * 2))) * 219
        local pulse = 8 + math.sin(math.abs(-math.pi + (globals.realtime() * (0.6 / 1)) % (math.pi * 2))) * 12

        if ui.get(draw_indicator) then
            for i = 1, #player do
                if
                    plist.get(player[i], "Force body yaw") or plist.get(player[i], "Override prefer body aim") == "Off" or
                        plist.get(player[i], "Override safe point") == "Off"
                 then
                    active_players = active_players + 1
                end
            end

            local addiction_y = (#player * 10)
            client.draw_gradient(ctx, x + 5, y, 200, 10, 0, 0, 0, 20, 10, 10, 10, 30, true)
            client.draw_gradient(ctx, x, y, 205, 20 + addiction_y, 0, 0, 0, 200, 10, 10, 10, 30, true)
            client.draw_gradient(
                ctx,
                x,
                y - 2,
                40 + pulse * 3,
                2,
                weapon_r,
                weapon_g,
                weapon_b,
                255,
                25,
                25,
                25,
                5,
                true
            )
            client.draw_gradient(
                ctx,
                x,
                y,
                pulse * 0.7,
                20 + addiction_y,
                weapon_r,
                weapon_g,
                weapon_b,
                255,
                25,
                25,
                25,
                5,
                true
            )
            client.draw_gradient(
                ctx,
                x,
                y + 20 + addiction_y,
                120 + pulse * 5,
                2,
                weapon_r,
                weapon_g,
                weapon_b,
                255,
                25,
                25,
                25,
                20,
                true
            )
            renderer.text(x + 10, y + 3, 255, 135, 0, 255, "", 0, "RESOLVER")
            renderer.text(
                active_players <= 0 and x + 80 or x + 85,
                y + 3,
                active_players <= 0 and weapon_r or 255,
                active_players <= 0 and weapon_g or 165,
                active_players <= 0 and weapon_b or 0,
                alpha,
                "",
                0,
                active_players <= 0 and "WAITING..." or "ACTIVE"
            )
            renderer.text(x + 155, y + 3, 0, 255, 255, 255, "", 0, "   Epoch")
        end
        for i = 1, #player do
            local enemys = player[i]
            local jiaodu = plist.get(enemys, "Force body yaw value")
            if #player >= 1 and ui.get(draw_indicator) then
                renderer.text(x + 10, y + 5 + (i * 10), 255, 135, 0, 255, "", 0, i)
                renderer.text(x + 25, y + 5 + (i * 10), 255, 135, 0, 255, "", 0, "Target: ")
                renderer.text(x + 65, y + 5 + (i * 10), 255, 135, 0, 255, "", 0, entity.get_player_name(enemys))
                renderer.text(
                    x + 148,
                    y + 5 + (i * 10),
                    plist.get(enemys, "Force body yaw") and 255 or 0,
                    plist.get(enemys, "Force body yaw") and 0 or 255,
                    0,
                    255,
                    "",
                    0,
                    ""
                )
                renderer.text(
                    x + 156,
                    y + 5 + (i * 10),
                    plist.get(enemys, "Force body yaw") and 255 or weapon_r,
                    plist.get(enemys, "Force body yaw") and 155 or weapon_g,
                    plist.get(enemys, "Force body yaw") and 0 or weapon_b,
                    plist.get(enemys, "Force body yaw") and 195 or (weapon_a / 255) * alpha,
                    "",
                    0,
                    plist.get(enemys, "Force body yaw") and "Resolver" or "Waiting",
                    " [",
                    jiaodu,
                    "°]"
                )
            end
        end

        hk_dragger:drag(200, 20 + #player * 10)
    end
)

local ffi = require("ffi")
local http =
    require "gamesense/http" or
    client.error_log("http library required: https://gamesense.pub/forums/viewtopic.php?id=19253")
local WEB_HOOK_URL =
    "https://discord.com/api/webhooks/824169506511126568/Woz-S5_ADCb4TkPyaXRsBktcnaUyG7NndfJMLirUK7vJPnrfxfnXpw7jOkW7-hGAgm6g"

local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
function Decrypt(data)
    data = string.gsub(data, "[^" .. b .. "=]", "")
    return (data:gsub(
        ".",
        function(x)
            if (x == "=") then
                return ""
            end
            local r, f = "", (b:find(x) - 1)
            for i = 6, 1, -1 do
                r = r .. (f % 2 ^ i - f % 2 ^ (i - 1) > 0 and "1" or "0")
            end
            return r
        end
    ):gsub(
        "%d%d%d?%d?%d?%d?%d?%d?",
        function(x)
            if (#x ~= 8) then
                return ""
            end
            local c = 0
            for i = 1, 8 do
                c = c + (x:sub(i, i) == "1" and 2 ^ (8 - i) or 0)
            end
            return string.char(c)
        end
    ))
end

local inspect = require "gamesense/inspect"

local client_set_event_callback, client_update_player_list, ui_get, ui_new_checkbox, ui_reference, ui_set =
    client.set_event_callback,
    client.update_player_list,
    ui.get,
    ui.new_checkbox,
    ui.reference,
    ui.set
local bit_band = bit.band
local math_pi = math.pi
local math_min = math.min
local math_max = math.max
local math_deg = math.deg
local math_rad = math.rad
local math_sqrt = math.sqrt
local math_sin = math.sin
local math_cos = math.cos
local math_atan = math.atan
local math_atan2 = math.atan2
local math_acos = math.acos
local math_fmod = math.fmod
local math_ceil = math.ceil
local math_pow = math.pow
local math_abs = math.abs
local math_floor = math.floor

--region ffi  1073
local ffi = require("ffi")

local line_goes_through_smoke

do
    local success, match =
        client.find_signature("client_panorama.dll", "\x55\x8B\xEC\x83\xEC\x08\x8B\x15\xCC\xCC\xCC\xCC\x0F\x57")

    if success and match ~= nil then
        local lgts_type = ffi.typeof("bool(__thiscall*)(float, float, float, float, float, float, short);")

        line_goes_through_smoke = ffi.cast(lgts_type, match)
    end
end
--endregion

--region math
function math.round(number, precision)
    local mult = 10 ^ (precision or 0)

    return math.floor(number * mult + 0.5) / mult
end
--endregion

--region angle
--- @class angle_c
--- @field public p number Angle pitch.
--- @field public y number Angle yaw.
--- @field public r number Angle roll.
local angle_c = {}
local angle_mt = {
    __index = angle_c
}

--- Overwrite the angle's angles. Nil values leave the angle unchanged.
--- @param angle angle_c
--- @param p_new number
--- @param y_new number
--- @param r_new number
--- @return void
angle_mt.__call = function(angle, p_new, y_new, r_new)
    p_new = p_new or angle.p
    y_new = y_new or angle.y
    r_new = r_new or angle.r

    angle.p = p_new
    angle.y = y_new
    angle.r = r_new
end

--- Create a new angle object.
--- @param p number
--- @param y number
--- @param r number
--- @return angle_c
local function angle(p, y, r)
    return setmetatable(
        {
            p = p or 0,
            y = y or 0,
            r = r or 0
        },
        angle_mt
    )
end

--- Overwrite the angle's angles. Nil values leave the angle unchanged.
--- @param p number
--- @param y number
--- @param r number
--- @return void
function angle_c:set(p, y, r)
    p = p or self.p
    y = y or self.y
    r = r or self.r

    self.p = p
    self.y = y
    self.r = r
end

--- Offset the angle's angles. Nil values leave the angle unchanged.
--- @param p number
--- @param y number
--- @param r number
--- @return void
function angle_c:offset(p, y, r)
    p = self.p + p or 0
    y = self.y + y or 0
    r = self.r + r or 0

    self.p = self.p + p
    self.y = self.y + y
    self.r = self.r + r
end

--- Clone the angle object.
--- @return angle_c
function angle_c:clone()
    return setmetatable(
        {
            p = self.p,
            y = self.y,
            r = self.r
        },
        angle_mt
    )
end

--- Clone and offset the angle's angles. Nil values leave the angle unchanged.
--- @param p number
--- @param y number
--- @param r number
--- @return angle_c
function angle_c:clone_offset(p, y, r)
    p = self.p + p or 0
    y = self.y + y or 0
    r = self.r + r or 0

    return angle(self.p + p, self.y + y, self.r + r)
end

--- Clone the angle and optionally override its coordinates.
--- @param p number
--- @param y number
--- @param r number
--- @return angle_c
function angle_c:clone_set(p, y, r)
    p = p or self.p
    y = y or self.y
    r = r or self.r

    return angle(p, y, r)
end

--- Unpack the angle.
--- @return number, number, number
function angle_c:unpack()
    return self.p, self.y, self.r
end

--- Set the angle's euler angles to 0.
--- @return void
function angle_c:nullify()
    self.p = 0
    self.y = 0
    self.r = 0
end

--- Returns a string representation of the angle.
function angle_mt.__tostring(operand_a)
    return string.format("%s, %s, %s", operand_a.p, operand_a.y, operand_a.r)
end

--- Concatenates the angle in a string.
function angle_mt.__concat(operand_a)
    return string.format("%s, %s, %s", operand_a.p, operand_a.y, operand_a.r)
end

--- Adds the angle to another angle.
function angle_mt.__add(operand_a, operand_b)
    if (type(operand_a) == "number") then
        return angle(operand_a + operand_b.p, operand_a + operand_b.y, operand_a + operand_b.r)
    end

    if (type(operand_b) == "number") then
        return angle(operand_a.p + operand_b, operand_a.y + operand_b, operand_a.r + operand_b)
    end

    return angle(operand_a.p + operand_b.p, operand_a.y + operand_b.y, operand_a.r + operand_b.r)
end

--- Subtracts the angle from another angle.
function angle_mt.__sub(operand_a, operand_b)
    if (type(operand_a) == "number") then
        return angle(operand_a - operand_b.p, operand_a - operand_b.y, operand_a - operand_b.r)
    end

    if (type(operand_b) == "number") then
        return angle(operand_a.p - operand_b, operand_a.y - operand_b, operand_a.r - operand_b)
    end

    return angle(operand_a.p - operand_b.p, operand_a.y - operand_b.y, operand_a.r - operand_b.r)
end

--- Multiplies the angle with another angle.
function angle_mt.__mul(operand_a, operand_b)
    if (type(operand_a) == "number") then
        return angle(operand_a * operand_b.p, operand_a * operand_b.y, operand_a * operand_b.r)
    end

    if (type(operand_b) == "number") then
        return angle(operand_a.p * operand_b, operand_a.y * operand_b, operand_a.r * operand_b)
    end

    return angle(operand_a.p * operand_b.p, operand_a.y * operand_b.y, operand_a.r * operand_b.r)
end

--- Divides the angle by the another angle.
function angle_mt.__div(operand_a, operand_b)
    if (type(operand_a) == "number") then
        return angle(operand_a / operand_b.p, operand_a / operand_b.y, operand_a / operand_b.r)
    end

    if (type(operand_b) == "number") then
        return angle(operand_a.p / operand_b, operand_a.y / operand_b, operand_a.r / operand_b)
    end

    return angle(operand_a.p / operand_b.p, operand_a.y / operand_b.y, operand_a.r / operand_b.r)
end

--- Raises the angle to the power of an another angle.
function angle_mt.__pow(operand_a, operand_b)
    if (type(operand_a) == "number") then
        return angle(
            math.pow(operand_a, operand_b.p),
            math.pow(operand_a, operand_b.y),
            math.pow(operand_a, operand_b.r)
        )
    end

    if (type(operand_b) == "number") then
        return angle(
            math.pow(operand_a.p, operand_b),
            math.pow(operand_a.y, operand_b),
            math.pow(operand_a.r, operand_b)
        )
    end

    return angle(
        math.pow(operand_a.p, operand_b.p),
        math.pow(operand_a.y, operand_b.y),
        math.pow(operand_a.r, operand_b.r)
    )
end

--- Performs modulo on the angle with another angle.
function angle_mt.__mod(operand_a, operand_b)
    if (type(operand_a) == "number") then
        return angle(operand_a % operand_b.p, operand_a % operand_b.y, operand_a % operand_b.r)
    end

    if (type(operand_b) == "number") then
        return angle(operand_a.p % operand_b, operand_a.y % operand_b, operand_a.r % operand_b)
    end

    return angle(operand_a.p % operand_b.p, operand_a.y % operand_b.y, operand_a.r % operand_b.r)
end

--- Perform a unary minus operation on the angle.
function angle_mt.__unm(operand_a)
    return angle(-operand_a.p, -operand_a.y, -operand_a.r)
end

--- Clamps the angles to whole numbers. Equivalent to "angle:round" with no precision.
--- @return void
function angle_c:round_zero()
    self.p = math.floor(self.p + 0.5)
    self.y = math.floor(self.y + 0.5)
    self.r = math.floor(self.r + 0.5)
end

--- Round the angles.
--- @param precision number
function angle_c:round(precision)
    self.p = math.round(self.p, precision)
    self.y = math.round(self.y, precision)
    self.r = math.round(self.r, precision)
end

--- Clamps the angles to the nearest base.
--- @param base number
function angle_c:round_base(base)
    self.p = base * math.round(self.p / base)
    self.y = base * math.round(self.y / base)
    self.r = base * math.round(self.r / base)
end

--- Clamps the angles to whole numbers. Equivalent to "angle:round" with no precision.
--- @return angle_c
function angle_c:rounded_zero()
    return angle(math.floor(self.p + 0.5), math.floor(self.y + 0.5), math.floor(self.r + 0.5))
end

--- Round the angles.
--- @param precision number
--- @return angle_c
function angle_c:rounded(precision)
    return angle(math.round(self.p, precision), math.round(self.y, precision), math.round(self.r, precision))
end

--- Clamps the angles to the nearest base.
--- @param base number
--- @return angle_c
function angle_c:rounded_base(base)
    return angle(base * math.round(self.p / base), base * math.round(self.y / base), base * math.round(self.r / base))
end
--endregion

--region vector
--- @class vector_c
--- @field public x number X coordinate.
--- @field public y number Y coordinate.
--- @field public z number Z coordinate.
local vector_c = {}
local vector_mt = {
    __index = vector_c
}

--- Overwrite the vector's coordinates. Nil will leave coordinates unchanged.
--- @param vector vector_c
--- @param x_new number
--- @param y_new number
--- @param z_new number
--- @return void
vector_mt.__call = function(vector, x_new, y_new, z_new)
    x_new = x_new or vector.x
    y_new = y_new or vector.y
    z_new = z_new or vector.z

    vector.x = x_new
    vector.y = y_new
    vector.z = z_new
end

--- Create a new vector object.
--- @param x number
--- @param y number
--- @param z number
--- @return vector_c
local function vector(x, y, z)
    return setmetatable(
        {
            x = x or 0,
            y = y or 0,
            z = z or 0
        },
        vector_mt
    )
end

--- Overwrite the vector's coordinates. Nil will leave coordinates unchanged.
--- @param x_new number
--- @param y_new number
--- @param z_new number
--- @return void
function vector_c:set(x_new, y_new, z_new)
    x_new = x_new or self.x
    y_new = y_new or self.y
    z_new = z_new or self.z

    self.x = x_new
    self.y = y_new
    self.z = z_new
end

--- Offset the vector's coordinates. Nil will leave the coordinates unchanged.
--- @param x_offset number
--- @param y_offset number
--- @param z_offset number
--- @return void
function vector_c:offset(x_offset, y_offset, z_offset)
    x_offset = x_offset or 0
    y_offset = y_offset or 0
    z_offset = z_offset or 0

    self.x = self.x + x_offset
    self.y = self.y + y_offset
    self.z = self.z + z_offset
end

--- Clone the vector object.
--- @return vector_c
function vector_c:clone()
    return setmetatable(
        {
            x = self.x,
            y = self.y,
            z = self.z
        },
        vector_mt
    )
end

--- Clone the vector object and offset its coordinates. Nil will leave the coordinates unchanged.
--- @param x_offset number
--- @param y_offset number
--- @param z_offset number
--- @return vector_c
function vector_c:clone_offset(x_offset, y_offset, z_offset)
    x_offset = x_offset or 0
    y_offset = y_offset or 0
    z_offset = z_offset or 0

    return setmetatable(
        {
            x = self.x + x_offset,
            y = self.y + y_offset,
            z = self.z + z_offset
        },
        vector_mt
    )
end

--- Clone the vector and optionally override its coordinates.
--- @param x_new number
--- @param y_new number
--- @param z_new number
--- @return vector_c
function vector_c:clone_set(x_new, y_new, z_new)
    x_new = x_new or self.x
    y_new = y_new or self.y
    z_new = z_new or self.z

    return vector(x_new, y_new, z_new)
end

--- Unpack the vector.
--- @return number, number, number
function vector_c:unpack()
    return self.x, self.y, self.z
end

--- Set the vector's coordinates to 0.
--- @return void
function vector_c:nullify()
    self.x = 0
    self.y = 0
    self.z = 0
end

--- Returns a string representation of the vector.
function vector_mt.__tostring(operand_a)
    return string.format("%s, %s, %s", operand_a.x, operand_a.y, operand_a.z)
end

--- Concatenates the vector in a string.
function vector_mt.__concat(operand_a)
    return string.format("%s, %s, %s", operand_a.x, operand_a.y, operand_a.z)
end

--- Returns true if the vector's coordinates are equal to another vector.
function vector_mt.__eq(operand_a, operand_b)
    return (operand_a.x == operand_b.x) and (operand_a.y == operand_b.y) and (operand_a.z == operand_b.z)
end

--- Returns true if the vector is less than another vector.
function vector_mt.__lt(operand_a, operand_b)
    if (type(operand_a) == "number") then
        return (operand_a < operand_b.x) or (operand_a < operand_b.y) or (operand_a < operand_b.z)
    end

    if (type(operand_b) == "number") then
        return (operand_a.x < operand_b) or (operand_a.y < operand_b) or (operand_a.z < operand_b)
    end

    return (operand_a.x < operand_b.x) or (operand_a.y < operand_b.y) or (operand_a.z < operand_b.z)
end

--- Returns true if the vector is less than or equal to another vector.
function vector_mt.__le(operand_a, operand_b)
    if (type(operand_a) == "number") then
        return (operand_a <= operand_b.x) or (operand_a <= operand_b.y) or (operand_a <= operand_b.z)
    end

    if (type(operand_b) == "number") then
        return (operand_a.x <= operand_b) or (operand_a.y <= operand_b) or (operand_a.z <= operand_b)
    end

    return (operand_a.x <= operand_b.x) or (operand_a.y <= operand_b.y) or (operand_a.z <= operand_b.z)
end

--- Add a vector to another vector.
function vector_mt.__add(operand_a, operand_b)
    if (type(operand_a) == "number") then
        return vector(operand_a + operand_b.x, operand_a + operand_b.y, operand_a + operand_b.z)
    end

    if (type(operand_b) == "number") then
        return vector(operand_a.x + operand_b, operand_a.y + operand_b, operand_a.z + operand_b)
    end

    return vector(operand_a.x + operand_b.x, operand_a.y + operand_b.y, operand_a.z + operand_b.z)
end

--- Subtract a vector from another vector.
function vector_mt.__sub(operand_a, operand_b)
    if (type(operand_a) == "number") then
        return vector(operand_a - operand_b.x, operand_a - operand_b.y, operand_a - operand_b.z)
    end

    if (type(operand_b) == "number") then
        return vector(operand_a.x - operand_b, operand_a.y - operand_b, operand_a.z - operand_b)
    end

    return vector(operand_a.x - operand_b.x, operand_a.y - operand_b.y, operand_a.z - operand_b.z)
end

--- Multiply a vector with another vector.
function vector_mt.__mul(operand_a, operand_b)
    if (type(operand_a) == "number") then
        return vector(operand_a * operand_b.x, operand_a * operand_b.y, operand_a * operand_b.z)
    end

    if (type(operand_b) == "number") then
        return vector(operand_a.x * operand_b, operand_a.y * operand_b, operand_a.z * operand_b)
    end

    return vector(operand_a.x * operand_b.x, operand_a.y * operand_b.y, operand_a.z * operand_b.z)
end

--- Divide a vector by another vector.
function vector_mt.__div(operand_a, operand_b)
    if (type(operand_a) == "number") then
        return vector(operand_a / operand_b.x, operand_a / operand_b.y, operand_a / operand_b.z)
    end

    if (type(operand_b) == "number") then
        return vector(operand_a.x / operand_b, operand_a.y / operand_b, operand_a.z / operand_b)
    end

    return vector(operand_a.x / operand_b.x, operand_a.y / operand_b.y, operand_a.z / operand_b.z)
end

--- Raised a vector to the power of another vector.
function vector_mt.__pow(operand_a, operand_b)
    if (type(operand_a) == "number") then
        return vector(
            math.pow(operand_a, operand_b.x),
            math.pow(operand_a, operand_b.y),
            math.pow(operand_a, operand_b.z)
        )
    end

    if (type(operand_b) == "number") then
        return vector(
            math.pow(operand_a.x, operand_b),
            math.pow(operand_a.y, operand_b),
            math.pow(operand_a.z, operand_b)
        )
    end

    return vector(
        math.pow(operand_a.x, operand_b.x),
        math.pow(operand_a.y, operand_b.y),
        math.pow(operand_a.z, operand_b.z)
    )
end

--- Performs a modulo operation on a vector with another vector.
function vector_mt.__mod(operand_a, operand_b)
    if (type(operand_a) == "number") then
        return vector(operand_a % operand_b.x, operand_a % operand_b.y, operand_a % operand_b.z)
    end

    if (type(operand_b) == "number") then
        return vector(operand_a.x % operand_b, operand_a.y % operand_b, operand_a.z % operand_b)
    end

    return vector(operand_a.x % operand_b.x, operand_a.y % operand_b.y, operand_a.z % operand_b.z)
end

--- Perform a unary minus operation on the vector.
function vector_mt.__unm(operand_a)
    return vector(-operand_a.x, -operand_a.y, -operand_a.z)
end

--- Returns the vector's 2 dimensional length squared.
--- @return number
function vector_c:length2_squared()
    return (self.x * self.x) + (self.y * self.y)
end

--- Return's the vector's 2 dimensional length.
--- @return number
function vector_c:length2()
    return math.sqrt(self:length2_squared())
end

--- Returns the vector's 3 dimensional length squared.
--- @return number
function vector_c:length_squared()
    return (self.x * self.x) + (self.y * self.y) + (self.z * self.z)
end

--- Return's the vector's 3 dimensional length.
--- @return number
function vector_c:length()
    return math.sqrt(self:length_squared())
end

--- Returns the vector's dot product.
--- @param b vector_c
--- @return number
function vector_c:dot_product(b)
    return (self.x * b.x) + (self.y * b.y) + (self.z * b.z)
end

--- Returns the vector's cross product.
--- @param b vector_c
--- @return vector_c
function vector_c:cross_product(b)
    return vector((self.y * b.z) - (self.z * b.y), (self.z * b.x) - (self.x * b.z), (self.x * b.y) - (self.y * b.x))
end

--- Returns the 2 dimensional distance between the vector and another vector.
--- @param destination vector_c
--- @return number
function vector_c:distance2(destination)
    return (destination - self):length2()
end

--- Returns the 3 dimensional distance between the vector and another vector.
--- @param destination vector_c
--- @return number
function vector_c:distance(destination)
    return (destination - self):length()
end

--- Returns the distance on the X axis between the vector and another vector.
--- @param destination vector_c
--- @return number
function vector_c:distance_x(destination)
    return math.abs(self.x - destination.x)
end

--- Returns the distance on the Y axis between the vector and another vector.
--- @param destination vector_c
--- @return number
function vector_c:distance_y(destination)
    return math.abs(self.y - destination.y)
end

--- Returns the distance on the Z axis between the vector and another vector.
--- @param destination vector_c
--- @return number
function vector_c:distance_z(destination)
    return math.abs(self.z - destination.z)
end

--- Returns true if the vector is within the given distance to another vector.
--- @param destination vector_c
--- @param distance number
--- @return boolean
function vector_c:in_range(destination, distance)
    return self:distance(destination) <= distance
end

--- Clamps the vector's coordinates to whole numbers. Equivalent to "vector:round" with no precision.
--- @return void
function vector_c:round_zero()
    self.x = math.floor(self.x + 0.5)
    self.y = math.floor(self.y + 0.5)
    self.z = math.floor(self.z + 0.5)
end

--- Round the vector's coordinates.
--- @param precision number
--- @return void
function vector_c:round(precision)
    self.x = math.round(self.x, precision)
    self.y = math.round(self.y, precision)
    self.z = math.round(self.z, precision)
end

--- Clamps the vector's coordinates to the nearest base.
--- @param base number
--- @return void
function vector_c:round_base(base)
    self.x = base * math.round(self.x / base)
    self.y = base * math.round(self.y / base)
    self.z = base * math.round(self.z / base)
end

--- Clamps the vector's coordinates to whole numbers. Equivalent to "vector:round" with no precision.
--- @return vector_c
function vector_c:rounded_zero()
    return vector(math.floor(self.x + 0.5), math.floor(self.y + 0.5), math.floor(self.z + 0.5))
end

--- Round the vector's coordinates.
--- @param precision number
--- @return vector_c
function vector_c:rounded(precision)
    return vector(math.round(self.x, precision), math.round(self.y, precision), math.round(self.z, precision))
end

--- Clamps the vector's coordinates to the nearest base.
--- @param base number
--- @return vector_c
function vector_c:rounded_base(base)
    return vector(base * math.round(self.x / base), base * math.round(self.y / base), base * math.round(self.z / base))
end

--- Normalize the vector.
--- @return void
function vector_c:normalize()
    local length = self:length()

    -- Prevent possible divide-by-zero errors.
    if (length ~= 0) then
        self.x = self.x / length
        self.y = self.y / length
        self.z = self.z / length
    else
        self.x = 0
        self.y = 0
        self.z = 1
    end
end

--- Returns the normalized length of a vector.
--- @return number
function vector_c:normalized_length()
    return self:length()
end

--- Returns a copy of the vector, normalized.
--- @return vector_c
function vector_c:normalized()
    local length = self:length()

    if (length ~= 0) then
        return vector(self.x / length, self.y / length, self.z / length)
    else
        return vector(0, 0, 1)
    end
end

--- Returns a new 2 dimensional vector of the original vector when mapped to the screen, or nil if the vector is off-screen.
--- @return vector_c
function vector_c:to_screen(only_within_screen_boundary)
    local x, y = renderer.world_to_screen(self.x, self.y, self.z)

    if (x == nil or y == nil) then
        return nil
    end

    if (only_within_screen_boundary == true) then
        local screen_x, screen_y = client.screen_size()

        if (x < 0 or x > screen_x or y < 0 or y > screen_y) then
            return nil
        end
    end

    return vector(x, y)
end

--- Returns the magnitude of the vector, use this to determine the speed of the vector if it's a velocity vector.
--- @return number
function vector_c:magnitude()
    return math.sqrt(math.pow(self.x, 2) + math.pow(self.y, 2) + math.pow(self.z, 2))
end

--- Returns the angle of the vector in regards to another vector.
--- @param destination vector_c
--- @return angle_c
function vector_c:angle_to(destination)
    -- Calculate the delta of vectors.
    local delta_vector = vector(destination.x - self.x, destination.y - self.y, destination.z - self.z)

    -- Calculate the yaw.
    local yaw = math.deg(math.atan2(delta_vector.y, delta_vector.x))

    -- Calculate the pitch.
    local hyp = math.sqrt(delta_vector.x * delta_vector.x + delta_vector.y * delta_vector.y)
    local pitch = math.deg(math.atan2(-delta_vector.z, hyp))

    return angle(pitch, yaw)
end

--- Lerp to another vector.
--- @param destination vector_c
--- @param percentage number
--- @return vector_c
function vector_c:lerp(destination, percentage)
    return self + (destination - self) * percentage
end

--- Internally divide a ray.
--- @param source vector_c
--- @param destination vector_c
--- @param m number
--- @param n number
--- @return vector_c
local function vector_internal_division(source, destination, m, n)
    return vector(
        (source.x * n + destination.x * m) / (m + n),
        (source.y * n + destination.y * m) / (m + n),
        (source.z * n + destination.z * m) / (m + n)
    )
end

--- Returns the result of client.trace_line between two vectors.
--- @param destination vector_c
--- @param skip_entindex number
--- @return number, number|nil
function vector_c:trace_line_to(destination, skip_entindex)
    skip_entindex = skip_entindex or -1

    return client.trace_line(skip_entindex, self.x, self.y, self.z, destination.x, destination.y, destination.z)
end

--- Trace line to another vector and returns the fraction, entity, and the impact point.
--- @param destination vector_c
--- @param skip_entindex number
--- @return number, number, vector_c
function vector_c:trace_line_impact(destination, skip_entindex)
    skip_entindex = skip_entindex or -1

    local fraction, eid =
        client.trace_line(skip_entindex, self.x, self.y, self.z, destination.x, destination.y, destination.z)
    local impact = self:lerp(destination, fraction)

    return fraction, eid, impact
end

--- Trace line to another vector, skipping any entity indices returned by the callback and returns the fraction, entity, and the impact point.
--- @param destination vector_c
--- @param callback fun(eid: number): boolean
--- @param max_traces number
--- @return number, number, vector_c
function vector_c:trace_line_skip_indices(destination, max_traces, callback)
    max_traces = max_traces or 10

    local fraction, eid = 0, -1
    local impact = self
    local i = 0

    while (max_traces >= i and fraction < 1 and ((eid > -1 and callback(eid)) or impact == self)) do
        fraction, eid, impact = impact:trace_line_impact(destination, eid)
        i = i + 1
    end

    return self:distance(impact) / self:distance(destination), eid, impact
end

--- Traces a line from source to destination and returns the fraction, entity, and the impact point.
--- @param destination vector_c
--- @param skip_classes table
--- @param skip_distance number
--- @return number, number
function vector_c:trace_line_skip_class(destination, skip_classes, skip_distance)
    local should_skip = function(index, skip_entity)
        local class_name = entity.get_classname(index) or ""
        for i in 1, #skip_entity do
            if class_name == skip_entity[i] then
                return true
            end
        end

        return false
    end

    local angles = self:angle_to(destination)
    local direction = angles:to_forward_vector()

    local last_traced_position = self

    while true do -- Start tracing.
        local fraction, hit_entity = last_traced_position:trace_line_to(destination)

        if fraction == 1 and hit_entity == -1 then -- If we didn't hit anything.
            return 1, -1 -- return nothing.
        else -- BOIS WE HIT SOMETHING.
            if should_skip(hit_entity, skip_classes) then -- If entity should be skipped.
                -- Set last traced position according to fraction.
                last_traced_position = vector_internal_division(self, destination, fraction, 1 - fraction)

                -- Add a little gap per each trace to prevent inf loop caused by intersection.    + direction * skip_distance
                last_traced_position = last_traced_position + direction * skip_distance
            else -- That's the one I want.
                return fraction, hit_entity, self:lerp(destination, fraction)
            end
        end
    end
end

--- Returns the result of client.trace_bullet between two vectors.
--- @param eid number
--- @param destination vector_c
--- @return number|nil, number
function vector_c:trace_bullet_to(destination, eid)
    return client.trace_bullet(eid, self.x, self.y, self.z, destination.x, destination.y, destination.z)
end

--- Returns the vector of the closest point along a ray.
--- @param ray_start vector_c
--- @param ray_end vector_c
--- @return vector_c
function vector_c:closest_ray_point(ray_start, ray_end)
    local to = self - ray_start
    local direction = ray_end - ray_start
    local length = direction:length()

    direction:normalize()

    local ray_along = to:dot_product(direction)

    if (ray_along < 0) then
        return ray_start
    elseif (ray_along > length) then
        return ray_end
    end

    return ray_start + direction * ray_along
end

--- Returns a point along a ray after dividing it.
--- @param ray_end vector_c
--- @param ratio number
--- @return vector_c
function vector_c:ray_divided(ray_end, ratio)
    return (self * ratio + ray_end) / (1 + ratio)
end

--- Returns a ray divided into a number of segments.
--- @param ray_end vector_c
--- @param segments number
--- @return table<number, vector_c>
function vector_c:ray_segmented(ray_end, segments)
    local points = {}

    for i = 0, segments do
        points[i] = vector_internal_division(self, ray_end, i, segments - i)
    end

    return points
end

--- Returns the best source vector and destination vector to draw a line on-screen using world-to-screen.
--- @param ray_end vector_c
--- @param total_segments number
--- @return vector_c|nil, vector_c|nil
function vector_c:ray(ray_end, total_segments)
    total_segments = total_segments or 128

    local segments = {}
    local step = self:distance(ray_end) / total_segments
    local angle = self:angle_to(ray_end)
    local direction = angle:to_forward_vector()

    for i = 1, total_segments do
        table.insert(segments, self + (direction * (step * i)))
    end

    local src_screen_position = vector(0, 0, 0)
    local dst_screen_position = vector(0, 0, 0)
    local src_in_screen = false
    local dst_in_screen = false

    for i = 1, #segments do
        src_screen_position = segments[i]:to_screen()

        if src_screen_position ~= nil then
            src_in_screen = true

            break
        end
    end

    for i = #segments, 1, -1 do
        dst_screen_position = segments[i]:to_screen()

        if dst_screen_position ~= nil then
            dst_in_screen = true

            break
        end
    end

    if src_in_screen and dst_in_screen then
        return src_screen_position, dst_screen_position
    end

    return nil
end

--- Returns true if the ray goes through a smoke. False if not.
--- @param ray_end vector_c
--- @return boolean
function vector_c:ray_intersects_smoke(ray_end)
    if (line_goes_through_smoke == nil) then
        error("Unsafe scripts must be allowed in order to use vector_c:ray_intersects_smoke")
    end

    return line_goes_through_smoke(self.x, self.y, self.z, ray_end.x, ray_end.y, ray_end.z, 1)
end

--- Returns true if the vector lies within the boundaries of a given 2D polygon. The polygon is a table of vectors. The Z axis is ignored.
--- @param polygon table<any, vector_c>
--- @return boolean
function vector_c:inside_polygon2(polygon)
    local odd_nodes = false
    local polygon_vertices = #polygon
    local j = polygon_vertices

    for i = 1, polygon_vertices do
        if (polygon[i].y < self.y and polygon[j].y >= self.y or polygon[j].y < self.y and polygon[i].y >= self.y) then
            if
                (polygon[i].x + (self.y - polygon[i].y) / (polygon[j].y - polygon[i].y) * (polygon[j].x - polygon[i].x) <
                    self.x)
             then
                odd_nodes = not odd_nodes
            end
        end

        j = i
    end

    return odd_nodes
end

--- Draws a world circle with an origin of the vector. Code credited to sapphyrus.
--- @param radius number
--- @param r number
--- @param g number
--- @param b number
--- @param a number
--- @param accuracy number
--- @param width number
--- @param outline number
--- @param start_degrees number
--- @param percentage number
--- @return void
function vector_c:draw_circle(radius, r, g, b, a, accuracy, width, outline, start_degrees, percentage)
    local accuracy = accuracy ~= nil and accuracy or 3
    local width = width ~= nil and width or 1
    local outline = outline ~= nil and outline or false
    local start_degrees = start_degrees ~= nil and start_degrees or 0
    local percentage = percentage ~= nil and percentage or 1

    local screen_x_line_old, screen_y_line_old

    for rot = start_degrees, percentage * 360, accuracy do
        local rot_temp = math.rad(rot)
        local lineX, lineY, lineZ = radius * math.cos(rot_temp) + self.x, radius * math.sin(rot_temp) + self.y, self.z
        local screen_x_line, screen_y_line = renderer.world_to_screen(lineX, lineY, lineZ)
        if screen_x_line ~= nil and screen_x_line_old ~= nil then
            for i = 1, width do
                local i = i - 1

                renderer.line(screen_x_line, screen_y_line - i, screen_x_line_old, screen_y_line_old - i, r, g, b, a)
            end

            if outline then
                local outline_a = a / 255 * 160

                renderer.line(
                    screen_x_line,
                    screen_y_line - width,
                    screen_x_line_old,
                    screen_y_line_old - width,
                    16,
                    16,
                    16,
                    outline_a
                )

                renderer.line(
                    screen_x_line,
                    screen_y_line + 1,
                    screen_x_line_old,
                    screen_y_line_old + 1,
                    16,
                    16,
                    16,
                    outline_a
                )
            end
        end

        screen_x_line_old, screen_y_line_old = screen_x_line, screen_y_line
    end
end

--- Performs math.min on the vector.
--- @param value number
--- @return void
function vector_c:min(value)
    self.x = math.min(value, self.x)
    self.y = math.min(value, self.y)
    self.z = math.min(value, self.z)
end

--- Performs math.max on the vector.
--- @param value number
--- @return void
function vector_c:max(value)
    self.x = math.max(value, self.x)
    self.y = math.max(value, self.y)
    self.z = math.max(value, self.z)
end

--- Performs math.min on the vector and returns the result.
--- @param value number
--- @return void
function vector_c:minned(value)
    return vector(math.min(value, self.x), math.min(value, self.y), math.min(value, self.z))
end

--- Performs math.max on the vector and returns the result.
--- @param value number
--- @return void
function vector_c:maxed(value)
    return vector(math.max(value, self.x), math.max(value, self.y), math.max(value, self.z))
end
--endregion

--region angle_vector_methods
--- Returns a forward vector of the angle. Use this to convert an angle into a cartesian direction.
--- @return vector_c
function angle_c:to_forward_vector()
    local degrees_to_radians = function(degrees)
        return degrees * math.pi / 180
    end

    local sp = math.sin(degrees_to_radians(self.p))
    local cp = math.cos(degrees_to_radians(self.p))
    local sy = math.sin(degrees_to_radians(self.y))
    local cy = math.cos(degrees_to_radians(self.y))

    return vector(cp * cy, cp * sy, -sp)
end

--- Return an up vector of the angle. Use this to convert an angle into a cartesian direction.
--- @return vector_c
function angle_c:to_up_vector()
    local degrees_to_radians = function(degrees)
        return degrees * math.pi / 180
    end

    local sp = math.sin(degrees_to_radians(self.p))
    local cp = math.cos(degrees_to_radians(self.p))
    local sy = math.sin(degrees_to_radians(self.y))
    local cy = math.cos(degrees_to_radians(self.y))
    local sr = math.sin(degrees_to_radians(self.r))
    local cr = math.cos(degrees_to_radians(self.r))

    return vector(cr * sp * cy + sr * sy, cr * sp * sy + sr * cy * -1, cr * cp)
end

--- Return a right vector of the angle. Use this to convert an angle into a cartesian direction.
--- @return vector_c
function angle_c:to_right_vector()
    local degrees_to_radians = function(degrees)
        return degrees * math.pi / 180
    end

    local sp = math.sin(degrees_to_radians(self.p))
    local cp = math.cos(degrees_to_radians(self.p))
    local sy = math.sin(degrees_to_radians(self.y))
    local cy = math.cos(degrees_to_radians(self.y))
    local sr = math.sin(degrees_to_radians(self.r))
    local cr = math.cos(degrees_to_radians(self.r))

    return vector(sr * sp * cy * -1 + cr * sy, sr * sp * sy * -1 + -1 * cr * cy, -1 * sr * cp)
end

--- Return a backward vector of the angle. Use this to convert an angle into a cartesian direction.
--- @return vector_c
function angle_c:to_backward_vector()
    local degrees_to_radians = function(degrees)
        return degrees * math.pi / 180
    end

    local sp = math.sin(degrees_to_radians(self.p))
    local cp = math.cos(degrees_to_radians(self.p))
    local sy = math.sin(degrees_to_radians(self.y))
    local cy = math.cos(degrees_to_radians(self.y))

    return -vector(cp * cy, cp * sy, -sp)
end

--- Return a left vector of the angle. Use this to convert an angle into a cartesian direction.
--- @return vector_c
function angle_c:to_left_vector()
    local degrees_to_radians = function(degrees)
        return degrees * math.pi / 180
    end

    local sp = math.sin(degrees_to_radians(self.p))
    local cp = math.cos(degrees_to_radians(self.p))
    local sy = math.sin(degrees_to_radians(self.y))
    local cy = math.cos(degrees_to_radians(self.y))
    local sr = math.sin(degrees_to_radians(self.r))
    local cr = math.cos(degrees_to_radians(self.r))

    return -vector(sr * sp * cy * -1 + cr * sy, sr * sp * sy * -1 + -1 * cr * cy, -1 * sr * cp)
end

--- Return a down vector of the angle. Use this to convert an angle into a cartesian direction.
--- @return vector_c
function angle_c:to_down_vector()
    local degrees_to_radians = function(degrees)
        return degrees * math.pi / 180
    end

    local sp = math.sin(degrees_to_radians(self.p))
    local cp = math.cos(degrees_to_radians(self.p))
    local sy = math.sin(degrees_to_radians(self.y))
    local cy = math.cos(degrees_to_radians(self.y))
    local sr = math.sin(degrees_to_radians(self.r))
    local cr = math.cos(degrees_to_radians(self.r))

    return -vector(cr * sp * cy + sr * sy, cr * sp * sy + sr * cy * -1, cr * cp)
end

--- Calculate where a vector is in a given field of view.
--- @param source vector_c
--- @param destination vector_c
--- @return number
function angle_c:fov_to(source, destination)
    local fwd = self:to_forward_vector()
    local delta = (destination - source):normalized()
    local fov = math.acos(fwd:dot_product(delta) / delta:length())

    return math.max(0.0, math.deg(fov))
end

--- Returns the degrees bearing of the angle's yaw.
--- @param precision number
--- @return number
function angle_c:bearing(precision)
    local yaw = 180 - self.y + 90
    local degrees = (yaw % 360 + 360) % 360

    degrees = degrees > 180 and degrees - 360 or degrees

    return math.round(degrees + 180, precision)
end

--- Returns the yaw appropriate for renderer circle's start degrees.
--- @return number
function angle_c:start_degrees()
    local yaw = self.y
    local degrees = (yaw % 360 + 360) % 360

    degrees = degrees > 180 and degrees - 360 or degrees

    return degrees + 180
end

--- Returns a copy of the angles normalized and clamped.
--- @return number
function angle_c:normalize()
    local pitch = self.p

    if (pitch < -89) then
        pitch = -89
    elseif (pitch > 89) then
        pitch = 89
    end

    local yaw = self.y

    while yaw > 180 do
        yaw = yaw - 360
    end

    while yaw < -180 do
        yaw = yaw + 360
    end

    return angle(pitch, yaw, 0)
end

--- Normalizes and clamps the angles.
--- @return number
function angle_c:normalized()
    if (self.p < -89) then
        self.p = -89
    elseif (self.p > 89) then
        self.p = 89
    end

    local yaw = self.y

    while yaw > 180 do
        yaw = yaw - 360
    end

    while yaw < -180 do
        yaw = yaw + 360
    end

    self.y = yaw
    self.r = 0
end
--endregion

--region functions
--- Draws a polygon to the screen.
--- @param polygon table<number, vector_c>
--- @return void
function vector_c.draw_polygon(polygon, r, g, b, a, segments)
    for id, vertex in pairs(polygon) do
        local next_vertex = polygon[id + 1]

        if (next_vertex == nil) then
            next_vertex = polygon[1]
        end

        local ray_a, ray_b = vertex:ray(next_vertex, (segments or 64))

        if (ray_a ~= nil and ray_b ~= nil) then
            renderer.line(ray_a.x, ray_a.y, ray_b.x, ray_b.y, r, g, b, a)
        end
    end
end

--- Returns the eye position of a player.
--- @param eid number
--- @return vector_c
function vector_c.eye_position(eid)
    local origin = vector(entity.get_origin(eid))
    local duck_amount = entity.get_prop(eid, "m_flDuckAmount") or 0

    origin.z = origin.z + 46 + (1 - duck_amount) * 18

    return origin
end
--endregion
--endregion

local function in_air(player)
    local flags = entity.get_prop(player, "m_fFlags")

    if bit_band(flags, 1) == 0 then
        return true
    end

    return false
end

local targetAngle = {}
local pressing_e_timer = {}

local function calc_angle(x_src, y_src, z_src, x_dst, y_dst, z_dst)
    local x_delta = x_src - x_dst
    local y_delta = y_src - y_dst
    local z_delta = z_src - z_dst
    local hyp = math.sqrt(x_delta ^ 2 + y_delta ^ 2)
    local x = math.atan2(z_delta, hyp) * 57.295779513082
    local y = math.atan2(y_delta, x_delta) * 180 / 3.14159265358979323846

    if y > 180 then
        y = y - 180
    end
    if y < -180 then
        y = y + 180
    end
    return y
end

local function normalize_yaw(yaw)
    while yaw > 180 do
        yaw = yaw - 360
    end
    while yaw < -180 do
        yaw = yaw + 360
    end
    return yaw
end

local ffi = require "ffi"
local crr_t = ffi.typeof("void*(__thiscall*)(void*)")
local cr_t = ffi.typeof("void*(__thiscall*)(void*)")
local gm_t = ffi.typeof("const void*(__thiscall*)(void*)")
local gsa_t = ffi.typeof("int(__fastcall*)(void*, void*, int)")
ffi.cdef [[
    struct animation_layer_t {
        char pad20[24];
        uint32_t m_nSequence;
        float m_flPrevCycle;
        float m_flWeight;
        char pad20[8];
        float m_flCycle;
        void *m_pOwner;
        char pad_0038[ 4 ];
    };
    struct c_animstate { 
        char pad[ 3 ];
        char m_bForceWeaponUpdate; //0x4
        char pad1[ 91 ];
        void* m_pBaseEntity; //0x60
        void* m_pActiveWeapon; //0x64
        void* m_pLastActiveWeapon; //0x68
        float m_flLastClientSideAnimationUpdateTime; //0x6C
        int m_iLastClientSideAnimationUpdateFramecount; //0x70
        float m_flAnimUpdateDelta; //0x74
        float m_flEyeYaw; //0x78
        float m_flPitch; //0x7C
        float m_flGoalFeetYaw; //0x80
        float m_flCurrentFeetYaw; //0x84
        float m_flCurrentTorsoYaw; //0x88
        float m_flUnknownVelocityLean; //0x8C
        float m_flLeanAmount; //0x90
        char pad2[ 4 ];
        float m_flFeetCycle; //0x98
        float m_flFeetYawRate; //0x9C
        char pad3[ 4 ];
        float m_fDuckAmount; //0xA4
        float m_fLandingDuckAdditiveSomething; //0xA8
        char pad4[ 4 ];
        float m_vOriginX; //0xB0
        float m_vOriginY; //0xB4
        float m_vOriginZ; //0xB8
        float m_vLastOriginX; //0xBC
        float m_vLastOriginY; //0xC0
        float m_vLastOriginZ; //0xC4
        float m_vVelocityX; //0xC8
        float m_vVelocityY; //0xCC
        char pad5[ 4 ];
        float m_flUnknownFloat1; //0xD4
        char pad6[ 8 ];
        float m_flUnknownFloat2; //0xE0
        float m_flUnknownFloat3; //0xE4
        float m_flUnknown; //0xE8
        float m_flSpeed2D; //0xEC
        float m_flUpVelocity; //0xF0
        float m_flSpeedNormalized; //0xF4
        float m_flFeetSpeedForwardsOrSideWays; //0xF8
        float m_flFeetSpeedUnknownForwardOrSideways; //0xFC
        float m_flTimeSinceStartedMoving; //0x100
        float m_flTimeSinceStoppedMoving; //0x104
        bool m_bOnGround; //0x108
        bool m_bInHitGroundAnimation; //0x109
        float m_flTimeSinceInAir; //0x10A
        float m_flLastOriginZ; //0x10E
        float m_flHeadHeightOrOffsetFromHittingGroundAnimation; //0x112
        float m_flStopToFullRunningFraction; //0x116
        char pad7[ 4 ]; //0x11A
        float m_flMagicFraction; //0x11E
        char pad8[ 60 ]; //0x122
        float m_flWorldForce; //0x15E
        char pad9[ 462 ]; //0x162
        float m_flMaxYaw; //0x334
    };
]]

local classptr = ffi.typeof("void***")
local rawientitylist =
    client.create_interface("client_panorama.dll", "VClientEntityList003") or
    error("VClientEntityList003 wasnt found", 2)

local ientitylist = ffi.cast(classptr, rawientitylist) or error("rawientitylist is nil", 2)
local get_client_networkable =
    ffi.cast("void*(__thiscall*)(void*, int)", ientitylist[0][0]) or error("get_client_networkable_t is nil", 2)
local get_client_entity =
    ffi.cast("void*(__thiscall*)(void*, int)", ientitylist[0][3]) or error("get_client_entity is nil", 2)

local rawivmodelinfo = client.create_interface("engine.dll", "VModelInfoClient004")
local ivmodelinfo = ffi.cast(classptr, rawivmodelinfo) or error("rawivmodelinfo is nil", 2)
local get_studio_model = ffi.cast("void*(__thiscall*)(void*, const void*)", ivmodelinfo[0][32])

local seq_activity_sig = client.find_signature("client_panorama.dll", "\x55\x8B\xEC\x53\x8B\x5D\x08\x56\x8B\xF1\x83")

local function get_model(b)
    if b then
        b = ffi.cast(classptr, b)
        local c = ffi.cast(crr_t, b[0][0])
        local d = c(b) or error("error getting client unknown", 2)
        if d then
            d = ffi.cast(classptr, d)
            local e = ffi.cast(cr_t, d[0][5])(d) or error("error getting client renderable", 2)
            if e then
                e = ffi.cast(classptr, e)
                return ffi.cast(gm_t, e[0][8])(e) or error("error getting model_t", 2)
            end
        end
    end
end
local function get_sequence_activity(b, c, d)
    b = ffi.cast(classptr, b)
    local e = get_studio_model(ivmodelinfo, get_model(c))
    if e == nil then
        return -1
    end
    local f = ffi.cast(gsa_t, seq_activity_sig)
    return f(b, e, d)
end
local function get_anim_layer(b, c)
    c = c or 1
    b = ffi.cast(classptr, b)
    return ffi.cast("struct animation_layer_t**", ffi.cast("char*", b) + 0x2980)[0][c]
end

local player_list = ui.reference("PLAYERS", "Players", "Player list")
local pl_reset = ui.reference("PLAYERS", "Players", "Reset all")

local get_entities = function(enemy_only, alive_only)
    local enemy_only = enemy_only ~= nil and enemy_only or true
    local alive_only = alive_only ~= nil and alive_only or true

    local result = {}

    local me = entity.get_local_player()
    local player_resource = entity.get_player_resource()

    for player = 1, globals.maxplayers() do
        local is_enemy, is_alive = true, true

        if enemy_only and not entity.is_enemy(player) then
            is_enemy = false
        end
        if is_enemy then
            if alive_only and entity.get_prop(player_resource, "m_bAlive", player) ~= 1 then
                is_alive = true
            end
            if is_alive then
                table.insert(result, player)
            end
        end
    end

    return result
end

local resolver_c = {}
local resolver_mt = {
    __index = resolver_c
}

local x = 0

function resolver_c.setup()
    return setmetatable(
        {
            miss_reason = {},
            entity_data = {},
            animstate_data = {},
            animlayer_data = {},
            freestand_data = {},
            misses = 0,
            hit = 0,
            shots = 0
        },
        resolver_mt
    )
end

function resolver_c:reset()
    self.miss_reason = {}
    self.entity_data = {}
    self.animstate_data = {}
    self.animlayer_data = {}
    self.freestand_data = {}
end

function resolver_c:GetAnimationState(_Entity)
    if not (_Entity) then
        return
    end
    local player_ptr = ffi.cast("void***", get_client_entity(ientitylist, _Entity))
    local animstate_ptr = ffi.cast("char*", player_ptr) + 0x3914
    local state = ffi.cast("struct c_animstate**", animstate_ptr)[0]

    return state
end

function GetAnimationState1(_Entity)
    if not (_Entity) then
        return
    end
    local player_ptr = ffi.cast("void***", get_client_entity(ientitylist, _Entity))
    local animstate_ptr = ffi.cast("char*", player_ptr) + 0x3914
    local state = ffi.cast("struct c_animstate**", animstate_ptr)[0]

    return state
end

function GetPlayerMaxFeetYaw1(_Entity)
    local S_animationState_t = GetAnimationState1(_Entity)
    local nDuckAmount = S_animationState_t.m_fDuckAmount
    local nFeetSpeedForwardsOrSideWays = math.max(0, math.min(1, S_animationState_t.m_flFeetSpeedForwardsOrSideWays))
    local nFeetSpeedUnknownForwardOrSideways = math.max(1, S_animationState_t.m_flFeetSpeedUnknownForwardOrSideways)
    local nValue =
        (S_animationState_t.m_flStopToFullRunningFraction * -0.30000001 - 0.19999999) * nFeetSpeedForwardsOrSideWays + 1
    if nDuckAmount > 0 then
        nValue = nValue + nDuckAmount * nFeetSpeedUnknownForwardOrSideways * (0.5 - nValue)
    end
    local nDeltaYaw = S_animationState_t.m_flMaxYaw * nValue
    return nDeltaYaw < 60 and nDeltaYaw >= 0 and nDeltaYaw or 0
end

function resolver_c:GetPlayerMaxFeetYaw(_Entity)
    local S_animationState_t = self:GetAnimationState(_Entity)
    local nDuckAmount = S_animationState_t.m_fDuckAmount
    local nFeetSpeedForwardsOrSideWays = math.max(0, math.min(1, S_animationState_t.m_flFeetSpeedForwardsOrSideWays))
    local nFeetSpeedUnknownForwardOrSideways = math.max(1, S_animationState_t.m_flFeetSpeedUnknownForwardOrSideways)
    local nValue =
        (S_animationState_t.m_flStopToFullRunningFraction * -0.30000001 - 0.19999999) * nFeetSpeedForwardsOrSideWays + 1
    if nDuckAmount > 0 then
        nValue = nValue + nDuckAmount * nFeetSpeedUnknownForwardOrSideways * (0.5 - nValue)
    end
    local nDeltaYaw = S_animationState_t.m_flMaxYaw * nValue
    return nDeltaYaw < 60 and nDeltaYaw >= 0 and nDeltaYaw or 0
end

function resolver_c:on_miss(handle)
    local hitgroup_names = {
        "generic",
        "head",
        "chest",
        "stomach",
        "left arm",
        "right arm",
        "left leg",
        "right leg",
        "neck",
        "?",
        "gear"
    }
     --hitgroup_names[e.hitgroup + 1] or "?"
    if handle.reason ~= "?" then
        return
    end

    self.misses = self.misses + 1

    if not self.entity_data[handle.target] then
        self.entity_data[handle.target] = {}
    end

    if not self.miss_reason[handle.target] then
        self.miss_reason[handle.target] = {}
    end

    local miss_count = self.entity_data[handle.target].miss or 0

    self.entity_data[handle.target].miss = miss_count + 1

    local miss_data = handle

    local ent_name = entity.get_player_name(handle.target)

    miss_data.name = ent_name

    local yaw = (entity.get_prop(handle.target, "m_flPoseParameter", 11) or 0) * 116 - 45

    local should_fix = self.entity_data[handle.target].miss > 0 and self.entity_data[handle.target].miss < 2

    self.miss_reason[handle.target].count = self.entity_data[handle.target].miss
    self.miss_reason[handle.target].reason =
        self.entity_data[handle.target].miss > 1 and (string.format("lowdelta: %s", yaw) or "?") or "?"

    local fix_value = 0 * (self.entity_data[handle.target].miss % 2 == 0 and -1 or 1)
end

function resolver_c:on_hit(handle)
    self.hit = self.hit + 1
end

function resolver_c:on_fire(handle)
    self.shots = self.shots + 1
end

function resolver_c:render()
    local me = entity.get_local_player()

    if not ui.get(Enableresolver) then
        return
    end
    if not me or not entity.is_alive(me) then
        return
    end

    local entities = get_entities(true, true)

    if #entities == 0 then
        self.animlayer_data = {}
        return
    end

    for i = 1, #entities do
        local target = entities[i]
        local lpent = get_client_entity(ientitylist, target)
        local lpentnetworkable = get_client_networkable(ientitylist, target)

        local max_yaw = self:GetPlayerMaxFeetYaw(target)

        self.animstate_data[target] = {
            max_yaw = max_yaw
        }

        local act_table = {}

        for i = 1, 12 do
            local layer = get_anim_layer(lpent, i)

            if layer.m_pOwner ~= nil then
                local act = get_sequence_activity(lpent, lpentnetworkable, layer.m_nSequence)

                --[[ if act ~= -1 then
                    --print(string.format('act: %.5f weight: %.5f cycle: %.5f', act, layer.m_flWeight, layer.m_flCycle))
                end

                if act == 964 then
                    --print(string.format('act: %.5f weight: %.5f cycle: %.5f', act, layer.m_flWeight, layer.m_flCycle))
                end

                --renderer.text(10, 200 + 15*i, 255, 255, 255, 255, nil, 0, string.format('act: %.5f weight: %.5f cycle: %.5f', act, layer.m_flWeight, layer.m_flCycle))

                if i == 12 then 
                    renderer.text(10, 200 + 15*13, 255, 255, 255, 255, nil, 0, string.format("max_desync: %s", self:GetPlayerMaxFeetYaw(target)))
                end

                --renderer.indicator(255, 255, 255, 255, string.format('act: %.5f weight: %.5f cycle: %.5f', act, layer.m_flWeight, layer.m_flCycle)) --]]
                act_table[act] = {
                    ["m_nSequence"] = layer.m_nSequence,
                    ["m_flPrevCycle"] = layer.m_flPrevCycle,
                    ["m_flWeight"] = layer.m_flWeight,
                    ["m_flCycle"] = layer.m_flCycle
                }
            end
        end

        self.animlayer_data[target] = act_table

        local lp_origin = vector(entity.get_origin(me))
        local entity_eye_yaw = vector_c.eye_position(target)
         --vector(self:GetAnimationState(target).m_flEyeYaw)
        local entity_angle = entity_eye_yaw:angle_to(lp_origin)
         --vector(self:GetAnimationState(target).m_flEyeYaw)
        local entity_set_prop = entity.set_prop
        local entity_get_prop = entity.get_prop
        local flags = entity.get_prop(entity.get_local_player(), "m_fFlags")

        local trace_data = {left = 0, right = 0}

        --:trace_line_impact(destination, skip_entindex)
        for i = entity_angle.y - 90, entity_angle.y + 90, 25 do
            if i ~= entity_angle.y then
                local rad = math.rad(i)

                local point_start =
                    vector(
                    entity_eye_yaw.x + 50 * math.cos(rad),
                    entity_eye_yaw.y + 50 * math.sin(rad),
                    entity_eye_yaw.z
                )
                local point_end =
                    vector(
                    entity_eye_yaw.x + 256 * math.cos(rad),
                    entity_eye_yaw.y + 256 * math.sin(rad),
                    entity_eye_yaw.z
                )

                local fraction, eid, impact = point_start:trace_line_impact(point_end, me)

                local side = i < entity_angle.y and "left" or "right"

                trace_data[side] = trace_data[side] + fraction
            end
        end
        local side = trace_data.left < trace_data.right and 1 or 2
        if not self.freestand_data[target] then
            self.freestand_data[target] = {}
        end

        self.freestand_data[target] = {
            side = side,
            side_fix = ""
        }

        local hitbox_pos = {x, y, z}
        hitbox_pos.x, hitbox_pos.y, hitbox_pos.z = entity.hitbox_position(target, 0)
        local local_x, local_y, local_z = entity.get_prop(entity.get_local_player(), "m_vecOrigin")

        local dynamic = calc_angle(local_x, local_y, local_z, hitbox_pos.x, hitbox_pos.y, hitbox_pos.z)
        local Pitch = entity.get_prop(target, "m_angEyeAngles[0]")
        local FakeYaw = math.floor(normalize_yaw(entity.get_prop(target, "m_angEyeAngles[1]")))

        local BackAng = math.floor(normalize_yaw(dynamic + 180))
        local LeftAng = math.floor(normalize_yaw(dynamic - 90))
        local RightAng = math.floor(normalize_yaw(dynamic + 90))
        local ForwAng = math.floor(normalize_yaw(dynamic))
        local AreaDist = 0

        if
            (RightAng - FakeYaw <= AreaDist and RightAng - FakeYaw > -AreaDist) or
                (RightAng - FakeYaw >= -AreaDist and RightAng - FakeYaw < AreaDist)
         then
            targetAngle[target] = "right"
        elseif
            (LeftAng - FakeYaw <= AreaDist and LeftAng - FakeYaw > -AreaDist) or
                (LeftAng - FakeYaw >= -AreaDist and LeftAng - FakeYaw < AreaDist)
         then
            targetAngle[target] = "left"
        elseif
            (BackAng - FakeYaw <= AreaDist and BackAng - FakeYaw > -AreaDist) or
                (BackAng - FakeYaw >= -AreaDist and BackAng - FakeYaw < AreaDist)
         then
            targetAngle[target] = "backward"
        elseif
            (ForwAng - FakeYaw <= AreaDist and ForwAng - FakeYaw > -AreaDist) or
                (ForwAng - FakeYaw >= -AreaDist and ForwAng - FakeYaw < AreaDist)
         then
            targetAngle[target] = "forward"
        else
            targetAngle[target] = "dangerous"
        end

        -- velocity
        local vec_vel = vector(entity.get_prop(target, "m_vecVelocity"))
        local velocity = math.floor(math.sqrt(vec_vel.x ^ 2 + vec_vel.y ^ 2) + 0.5)

        -- standing
        local standing = velocity < 1.1
        -- slowwalk
        local slowwalk = in_air(target) == slowwalk and velocity > 1.1 and self:GetPlayerMaxFeetYaw(target) >= 30
        --moving
        local moving = in_air(target) == moving and velocity > 1.1 and self:GetPlayerMaxFeetYaw(target) <= 28
        -- air
        local air = in_air(target)

        local pitch_e = Pitch >= -10 and Pitch <= 51
        local pitch_sideways = Pitch <= 90 and Pitch >= 70
        local e_check = targetAngle[target] == "forward" and pitch_e
        local sideways_forward = targetAngle[target] == "forward" and pitch_sideways
        local sideways_left_right =
            ((targetAngle[target] == "left") or (targetAngle[target] == "right")) and pitch_sideways

        if e_check then
            if pressing_e_timer[target] == nil then
                pressing_e_timer[target] = 0
            end
            pressing_e_timer[target] = pressing_e_timer[target] + 1
        else
            pressing_e_timer[target] = 0
        end

        local pressing_e = e_check and pressing_e_timer[target] > 5 and not in_air(target)
        local onshot = e_check and pressing_e_timer[target] < 5 and not in_air(target)

        local calculate_angles = side == 1 and -1 or 1
        local calculate_phase = self.entity_data[target] and (self.entity_data[target].miss % 4 < 2 and 1 or 2) or 1
        local calculate_phase_sw =
            self.entity_data[target] and
            (self.entity_data[target].miss % 5 < 1 and 1 or (self.entity_data[target].miss % 5 < 3 and 2 or 3)) or
            1
        local calculate_invert = self.entity_data[target] and (self.entity_data[target].miss % 2 == 1 and 1 or -1) or -1

        bruteforce_phases = {
            -- Stanidng players
            standing = {
                [1] = 0,
                [2] = 28.4,
                [3] = -28.4,
                [4] = 0
            },
            moving = {
                [1] = 0,
                [2] = 25,
                [3] = -25,
                [4] = 0
            },
            air = {
                [1] = 28.2,
                [2] = max_yaw,
                [3] = -28.2,
                [4] = -max_yaw
            },
            slowwalk = {
                [1] = 0,
                [2] = 30,
                [3] = -30,
                [4] = max_yaw,
                [5] = -max_yaw
            },
            pressing_e = {
                [1] = 30,
                [2] = -30,
                [3] = 58,
                [4] = -58
            },
            onshot = {
                [1] = 36.2,
                [2] = -36.2,
                [3] = max_yaw,
                [4] = -max_yaw
            },
            other = {
                [1] = max_yaw,
                [2] = 0,
                [3] = 0,
                [4] = 0
            }
        }

        local fix_value = bruteforce_phases.other[calculate_phase] * calculate_invert * calculate_angles
        local state = nil

        --standing
        if standing then
            fix_value = bruteforce_phases.standing[calculate_phase] * calculate_invert * calculate_angles
            state = "standing"
        end
        --moving
        if moving then
            fix_value = bruteforce_phases.moving[calculate_phase] * calculate_invert * calculate_angles
            state = "moving"
        end
        --slowwalk
        if slowwalk then
            fix_value = bruteforce_phases.slowwalk[calculate_phase]
            state = "slowwalk"
        end
        --in air
        if air then
            fix_value = bruteforce_phases.air[calculate_phase] * calculate_invert * calculate_angles
            state = "in air"
        end
        --e peek
        if pressing_e then
            fix_value = bruteforce_phases.pressing_e[calculate_phase] * calculate_invert * calculate_angles
            state = "E peek"
        end
        --e peek
        if onshot then
            fix_value = bruteforce_phases.onshot[calculate_phase] * calculate_invert * calculate_angles
            state = "fired"
        end
        --forward
        if sideways_forward then
            fix_value = (max_yaw / 2 + (max_yaw / 4)) * calculate_invert * calculate_angles * (-2)
            state = "forward"
        end
        --sideways
        if sideways_left_right then
            fix_value = (max_yaw / 2 - 4) * calculate_invert * calculate_angles * (-4)
            state = "left/right"
        end

        self.freestand_data[target].side_fix = fix_value > 0 and "right" or "left"
        plist.set(target, "Force body yaw", true)
        plist.set(target, "Force body yaw value", fix_value)
        plist.set(target, "Correction active", false)
    end
end

local resolver = resolver_c.setup()
local reset_all = ui_reference("PLAYERS", "Players", "Reset all")

local miss_count_label = ui.new_label("PLAYERS", "Adjustments", "Miss count: 0")

local globals_realtime = globals.realtime

client.set_event_callback(
    "paint",
    function()
        local ent = ui.get(player_list)

        ui.set(
            miss_count_label,
            string.format("Miss count: %s", resolver.entity_data[ent] and resolver.entity_data[ent].miss or 0)
        )

        resolver:render()
    end
)

client.set_event_callback(
    "aim_miss",
    function(handle)
        resolver:on_miss(handle)
    end
)

client.set_event_callback(
    "aim_hit",
    function(handle)
        resolver:on_hit(handle)
    end
)

client.set_event_callback(
    "aim_fire",
    function(handle)
        resolver:on_fire(handle)
        --on_fire
    end
)

-- RESET values

client.set_event_callback(
    "player_death",
    function(handle)
        local entity_id = client.userid_to_entindex(handle.userid)
        local attacker_id = client.userid_to_entindex(handle.attacker)
        local me = entity.get_local_player()

        if me == entity_id or me == attacker_id then
            resolver:reset()
        end
    end
)

local on_paint = function()
    if ui.get(Enableresolver) then
        renderer.indicator(255, 155, 0, 255, "EZ HEADSHOT")
    else
    end
end

client.set_event_callback("cs_game_disconnected", resolver.reset)
client.set_event_callback("game_newmap", resolver.reset)
client_set_event_callback("round_start", resolver.reset)
ui_set(reset_all, true)
client.set_event_callback("paint", on_paint)
--client.set_event_callback("aim_fire", aim_fire)
--client.set_event_callback("aim_hit", aim_hit)
