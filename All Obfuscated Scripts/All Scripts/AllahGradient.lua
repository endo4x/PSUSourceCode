--[[
	id: GunCIj0ooS4A3Za_oMSIO
	name: AllahGradient
	description: allah's zarscript gradient
	time1: 2021-06-28 21:47:46.009916+00
	time2: 2021-06-28 21:47:46.009916+00
	uploader: 842
	uploadersession: -9U-k1Fbaf6Svx7TXUfxAkw4HqXKro
	flag: f
--]]

local function evalGradient(type, steps, a, b)
    local gradients = {
        t1 = {},
        t2 = {},
        t3 = {}
    }
    if type == "rgb" then
        local r1, g1, b1 = table.unpack(a)
        local r2, g2, b2 = table.unpack(b)

        local rI = (r1 - r2) / steps
        local gI = (g1 - g2) / steps
        local bI = (b1 - b2) / steps
        local r, g, b = r1, g1, b1
        for i = 1, steps + 1 do
            table.insert(gradients.t1, r)
            table.insert(gradients.t2, g)
            table.insert(gradients.t3, b)
            r, g, b = r - rI, g - gI, b - bI
        end
    elseif type == "hsv" then
        local h1, s1, v1 = table.unpack(a)
        local h2, s2, v2 = table.unpack(b)

        local hI = (h1 - h2) / steps
        local sI = (s1 - s2) / steps
        local vI = (v1 - v2) / steps
        local h, s, v = h1, s1, v1
        for i = 1, steps + 1 do
            table.insert(gradients.t1, h)
            table.insert(gradients.t2, s)
            table.insert(gradients.t3, v)
            h, s, v = h - hI, s - sI, v - vI
        end
    end
    return gradients
end

local function drawGradient(gradient, x, y, height, type, width)
    if type == "rgb" then
        local rT, gT, bT = gradient.t1, gradient.t2, gradient.t3
        local steps = #rT
        if width == nil or width < steps then
            width = steps
        end
        width = 250
        for i = 1, width - 1 do
            local a = math.floor(i * (steps / width)) + 1
            render.rect(x + i, y, x + i + 1, y + height, rT[a], gT[a], bT[a], 255)
        end
    end
end
