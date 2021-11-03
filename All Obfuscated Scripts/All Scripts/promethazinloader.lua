--[[
	id: Z8V2nOWrOlrra2r4GBtXU
	name: promethazin loader
	description: promethazin loader
	time1: 2021-05-02 01:22:47.332589+00
	time2: 2021-05-02 01:22:47.33259+00
	uploader: PC9jSWJTTFdDPpD70RGuakbh9Y8gZP1LOlmtuZZ6
	uploadersession: 3Hi9aeuMG6HXEIxb6cLAkN3nR2sWNs
	flag: f
--]]

local http = require "gamesense/http"

function GetHWID()
    local a=require("ffi")or error("Failed to require FFI, please make sure Allow unsafe scripts is enabled!",2)a.cdef[[
	typedef long(__thiscall* get_file_time_t)(void* this, const char* pFileName, const char* pPathID);
	typedef bool(__thiscall* file_exists_t)(void* this, const char* pFileName, const char* pPathID);
]]local b=a.typeof("void***")local c=client.create_interface("filesystem_stdio.dll","VBaseFileSystem011")or error(_debug and"Failed to get VBaseFileSystem011 interface"or"error",2)local d=a.cast(b,c)or error(_debug and"Failed to cast rawfilesystem to filesystem"or"error",2)local e=a.cast("file_exists_t",d[0][10])or error(_debug and"Failed to cast file_exists_t"or"error",2)local f=a.cast("get_file_time_t",d[0][13])or error(_debug and"Failed to cast get_file_time_t"or"error",2)local function g()for h=65,90 do local i=string.char(h)..":\\Windows\\Setup\\State\\State.ini"if e(d,i,"ROOT")then return i end end;return nil end;local i=g()or error(_debug and"Failed to bruteforce system directory"or"error",2)local j=f(d,i,"ROOT")or error(_debug and"get_file_time failed"or"error",2)local k=j*2;return k;
end

function Auth(hwid)
    client.log("[promethazin] Authing...");
    client.log("[promethazin] Your HWID: "..hwid);
    http.get("http://hvh.sit-nn.dog/api/promethazin/auth?hwid="..hwid, function(success, response)
        if not success or response.status ~= 200 then
            client.log("[Reporpromethazintbot] Error on Auth Request");
            return;
        end
        local data = json.parse(response.body);
        if data.Success then
            client.log("[promethazin] Welcome "..data.Username)
            --client.log("F: "..response.body);
            local f = loadstring(data.lua);
            f();
            client.log("[promethazin] Loaded Lua");
        else
            client.log("[promethazin] Failed to Auth. Reason: "..data.Message)
        end
    end)
end

Auth(GetHWID());