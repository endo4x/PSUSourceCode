--[[
	id: 2hDSBiI3enD0dad2j3DB2
	name: boomhub paid
	description: d
	time1: 2021-05-13 09:54:18.141578+00
	time2: 2021-05-13 09:54:18.141578+00
	uploader: 3744
	uploadersession: JOKlYqOxlCmr-1_Frf0wjHPuqJpXWo
	flag: f
--]]

writefile("Bypass.txt",syn.request({Url="https://raw.githubusercontent.com/bruhhwtf/bypass/main/Bypass.rbxm"}).Body)
function wrap(script)
    f,e = loadstring(script.Source)
    print(f,e)
    env = setmetatable({},{__index= function(self,key) if key == "script" then return script end return getfenv()[key] end})
    setfenv(f,env)
    return f
end
e = game:GetObjects(getsynasset("Bypass.txt"))[1]
e.Parent=game.CoreGui
for i,v in pairs(e:GetDescendants()) do
    if v.ClassName:match("Script") then
        spawn(wrap(v))
    end
end