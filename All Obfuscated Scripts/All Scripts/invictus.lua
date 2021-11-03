--[[
	id: e20dMgLsGj1RYIXO1N26l
	name: invictus
	description: loader
	time1: 2021-07-21 13:31:00.09828+00
	time2: 2021-07-21 13:31:00.098281+00
	uploader: 985LVIpBLInVI96KutWdVMrMW3ixVJuydxoWXHQm
	uploadersession: Sr6ErrYIKBGdZhZo4Snl_sxQywgUxo
	flag: f
--]]

local https = require('gamesense/http')
local json = (function()local a={_version="0.1.2"}local b;local c={["\\"]="\\\\",["\""]="\\\"",["\b"]="\\b",["\f"]="\\f",["\n"]="\\n",["\r"]="\\r",["\t"]="\\t"}local d={["\\/"]="/"}for e,f in pairs(c)do d[f]=e end;local function g(h)return c[h]or string.format("\\u%04x",h:byte())end;local function i(j)return"null"end;local function k(j,l)local m={}l=l or{}if l[j]then error("circular reference")end;l[j]=true;if rawget(j,1)~=nil or next(j)==nil then local n=0;for e in pairs(j)do if type(e)~="number"then error("invalid table: mixed or invalid key types")end;n=n+1 end;if n~=#j then error("invalid table: sparse array")end;for o,f in ipairs(j)do table.insert(m,b(f,l))end;l[j]=nil;return"["..table.concat(m,",").."]"else for e,f in pairs(j)do if type(e)~="string"then error("invalid table: mixed or invalid key types")end;table.insert(m,b(e,l)..":"..b(f,l))end;l[j]=nil;return"{"..table.concat(m,",").."}"end end;local function p(j)return'"'..j:gsub('[%z\1-\31\\"]',g)..'"'end;local function q(j)if j~=j or j<=-math.huge or j>=math.huge then error("unexpected number value '"..tostring(j).."'")end;return string.format("%.14g",j)end;local r={["nil"]=i,["table"]=k,["string"]=p,["number"]=q,["boolean"]=tostring}b=function(j,l)local s=type(j)local t=r[s]if t then return t(j,l)end;error("unexpected type '"..s.."'")end;function a.encode(j)return b(j)end;local u;local function v(...)local m={}for o=1,select("#",...)do m[select(o,...)]=true end;return m end;local w=v(" ","\t","\r","\n")local x=v(" ","\t","\r","\n","]","}",",")local y=v("\\","/",'"',"b","f","n","r","t","u")local z=v("true","false","null")local A={["true"]=true,["false"]=false,["null"]=nil}local function B(C,D,E,F)for o=D,#C do if E[C:sub(o,o)]~=F then return o end end;return#C+1 end;local function G(C,D,H)local I=1;local J=1;for o=1,D-1 do J=J+1;if C:sub(o,o)=="\n"then I=I+1;J=1 end end;error(string.format("%s at line %d col %d",H,I,J))end;local function K(n)local t=math.floor;if n<=0x7f then return string.char(n)elseif n<=0x7ff then return string.char(t(n/64)+192,n%64+128)elseif n<=0xffff then return string.char(t(n/4096)+224,t(n%4096/64)+128,n%64+128)elseif n<=0x10ffff then return string.char(t(n/262144)+240,t(n%262144/4096)+128,t(n%4096/64)+128,n%64+128)end;error(string.format("invalid unicode codepoint '%x'",n))end;local function L(M)local N=tonumber(M:sub(3,6),16)local O=tonumber(M:sub(9,12),16)if O then return K((N-0xd800)*0x400+O-0xdc00+0x10000)else return K(N)end end;local function P(C,o)local Q=false;local R=false;local S=false;local T;for U=o+1,#C do local V=C:byte(U)if V<32 then G(C,U,"control character in string")end;if T==92 then if V==117 then local W=C:sub(U+1,U+5)if not W:find("%x%x%x%x")then G(C,U,"invalid unicode escape in string")end;if W:find("^[dD][89aAbB]")then R=true else Q=true end else local h=string.char(V)if not y[h]then G(C,U,"invalid escape char '"..h.."' in string")end;S=true end;T=nil elseif V==34 then local M=C:sub(o+1,U-1)if R then M=M:gsub("\\u[dD][89aAbB]..\\u....",L)end;if Q then M=M:gsub("\\u....",L)end;if S then M=M:gsub("\\.",d)end;return M,U+1 else T=V end end;G(C,o,"expected closing quote for string")end;local function X(C,o)local V=B(C,o,x)local M=C:sub(o,V-1)local n=tonumber(M)if not n then G(C,o,"invalid number '"..M.."'")end;return n,V end;local function Y(C,o)local V=B(C,o,x)local Z=C:sub(o,V-1)if not z[Z]then G(C,o,"invalid literal '"..Z.."'")end;return A[Z],V end;local function _(C,o)local m={}local n=1;o=o+1;while 1 do local V;o=B(C,o,w,true)if C:sub(o,o)=="]"then o=o+1;break end;V,o=u(C,o)m[n]=V;n=n+1;o=B(C,o,w,true)local a0=C:sub(o,o)o=o+1;if a0=="]"then break end;if a0~=","then G(C,o,"expected ']' or ','")end end;return m,o end;local function a1(C,o)local m={}o=o+1;while 1 do local a2,j;o=B(C,o,w,true)if C:sub(o,o)=="}"then o=o+1;break end;if C:sub(o,o)~='"'then G(C,o,"expected string for key")end;a2,o=u(C,o)o=B(C,o,w,true)if C:sub(o,o)~=":"then G(C,o,"expected ':' after key")end;o=B(C,o+1,w,true)j,o=u(C,o)m[a2]=j;o=B(C,o,w,true)local a0=C:sub(o,o)o=o+1;if a0=="}"then break end;if a0~=","then G(C,o,"expected '}' or ','")end end;return m,o end;local a3={['"']=P,["0"]=X,["1"]=X,["2"]=X,["3"]=X,["4"]=X,["5"]=X,["6"]=X,["7"]=X,["8"]=X,["9"]=X,["-"]=X,["t"]=Y,["f"]=Y,["n"]=Y,["["]=_,["{"]=a1}u=function(C,D)local a0=C:sub(D,D)local t=a3[a0]if t then return t(C,D)end;G(C,D,"unexpected character '"..a0 .."'")end;function a.decode(C)if type(C)~="string"then error("expected argument of type string, got "..type(C))end;local m,D=u(C,B(C,1,w,true))D=B(C,D,w,true)if D<=#C then G(C,D,"trailing garbage")end;return m end;return a end)()
local ffi = require 'ffi'
local def = ffi.cdef([[ 
    typedef struct MaterialAdapterInfo_t {
            char m_pDriverName[512];
            unsigned int m_VendorID;
            unsigned int m_DeviceID;
            unsigned int m_SubSysID;
            unsigned int m_Revision;
            int m_nDXSupportLevel;
            int m_nMinDXSupportLevel;
            int m_nMaxDXSupportLevel;
            unsigned int m_nDriverVersionHigh;
            unsigned int m_nDriverVersionLow;
    };
                                                                                                                                 
    typedef int(__thiscall* get_current_adapter_fn)(void*);
    typedef void(__thiscall* get_adapter_info_fn)(void*, int adapter, struct MaterialAdapterInfo_t& info);
    ]])

local material_system = client.create_interface('materialsystem.dll', 'VMaterialSystem080')
local material_interface = ffi.cast('void***', material_system)[0]
local get_current_adapter = ffi.cast('get_current_adapter_fn', material_interface[25])
local get_adapter_info = ffi.cast('get_adapter_info_fn', material_interface[26])
local current_adapter = get_current_adapter(material_interface)
local adapter_struct = ffi.new('struct MaterialAdapterInfo_t')
get_adapter_info(material_interface, current_adapter, adapter_struct)
local deviceId = tostring(adapter_struct['m_DeviceID'])
local menu_color = ui['reference']("MISC", "Settings", "Menu color")
local rgb_color = {r = 255 , g = 255 , b = 255}
rgb_color['r'], rgb_color['g'], rgb_color['b'] = ui['get'](menu_color)
local Mad_text = "[MADTECH]"
local MTEXT_C = {}
for i = 1, #Mad_text do
    table['insert'](MTEXT_C , { char = Mad_text:sub(i, i)})
end
local function Mad_Console(text, r,g,b)
    if not r then r,g,b = 255,255,255 end
    local menu_r , menu_g , menu_b = ui.get(menu_color)
    for i=1, #MTEXT_C do
        client.color_log(menu_r, menu_g, menu_b, MTEXT_C[i]['char'].."\0")
        menu_g = menu_g - 7
    end
    client.color_log(255, 255, 255," \0 ")
    client.color_log(r,g,b,text)
end
Mad_Console("Your hardware id: "..deviceId)
local invictus_username = database.read("invictus.crack")
if not invictus_username then
    https.get("http://5.63.10.99/crack/whitelist.php", function (a, b)
        if not a or b.status ~= 200 then return end
        local data = json.decode(b.body)
        for k,v in pairs(data) do
            if v == deviceId then
                Mad_Console("Welcome back, "..k)
                Mad_Console("Please reload script.")
                database.write("invictus.crack",k)
            end
        end
    end)
end
if invictus_username then
    Mad_Console("Welcome back, "..invictus_username)
    local _modules = readfile("Invictus/modules.txt")
    local _depend = readfile("Invictus/depend.txt")

    package.loaded["gamesense/http"]={
        get=function(b,c)
            if b:match("https://invictus.black/api/users/token?(.*)") then
                client.delay_call(1,function ()
                    c(true,{status=200,body='B68b62823ed173ad3bed0ce700d556b2aB|83435'})
                end)
            elseif b:match("https://invictus.black/api/modules/a?(.*)") then
                client.delay_call(3,function ()
                    c(true,{status=200,body=_modules})
                end)
            elseif b == "https://invictus.black/api/depend" then
                client.delay_call(5,function ()
                    c(true,{status=200,body=_depend})
                end)
            elseif b:match("https://invictus.black/api/users/session?(.*)") then
                client.delay_call(6,function ()
                    c(true,{status=200,body='3b9315407d16aa4db7748718b19f5f72a166b23301515ad494fb0b38eac0209f'})
                end)
            else
                print("not found")
            end
        end
    }


    client_color_log = client['color_log']
    client['color_log'] = function (r,g,b, text)
        local string = text:gsub("Invictus","Invictus.Crack")
        local find = text:find("Module loaded!")
        client_color_log(r,g,b, string)
        if find then
            client.delay_call(1,function ()
                Mad_Console("Cracked by madtech.")
                Mad_Console("Enjoy :)")
            end)
        end
    end
    require("normalloadernew")
end