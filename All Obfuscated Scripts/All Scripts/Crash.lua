--[[
	id: pBe0nmqp1l79DiC2E6owz
	name: Crash
	description: It'll crash you, that's it.
	time1: 2021-04-30 19:45:39.509795+00
	time2: 2021-04-30 19:45:39.509795+00
	uploader: 2527
	uploadersession: O_HwIKU09KEwF7S-Mnhb3xsVzPYmNz
	flag: t
--]]


local badmeta = {
    __index = function(self)
        os.date("%#", os.time())
        self["nuts"] = "balls"

        return self["nuts"]
    end,
    __newindex = function(self)
        self["nuts"] = "balls"

        return self["nuts"]
    end,
    __eq = function() return math.huge == math.huge end,
    __mul = function() return math.huge ^ math.huge * math.huge, nil end,
    __lt = function() return math.huge < math.huge end,
    __le = function() return math.huge <= math.huge end
}

if getfenv then
    setmetatable(getfenv(), badmeta)
    getfenv()["balls"] = "fart"
    print(getfenv()["balls"], getfenv()["balls"] == "nuts", getfenv()["balls"] * getfenv()["balls"], getfenv()["balls"] < getfenv()["balls"], getfenv()["balls"] <= getfenv()["balls"])
else
    setmetatable(_G, badmeta)
    print(_G["balls"], _G["balls"] == "nuts", _G["balls"] * _G["balls"], _G["balls"] < _G["balls"], _G["balls"] <= _G["balls"])
end

print(7 * 7 * 23 * 39 * 389 * 839 * 39843 * 38493 * 483 / 33 / 43 / 324 / 234 / 3 * 7374329423432 / 34342)