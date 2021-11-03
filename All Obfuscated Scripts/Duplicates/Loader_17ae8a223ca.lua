--[[
	id: AzLzghGKZ2P8ZW_Ls40tW
	name: Loader
	description: 1.0.1
	time1: 2021-07-24 19:51:38.723264+00
	time2: 2021-07-24 19:51:38.723266+00
	uploader: 1161
	uploadersession: 8bb6vPAEu246Bk-5VdMlrrdLiVqpVA
	flag: f
--]]


local ffi = require 'ffi'
local function contains(table, val)
	if table == nil then return false end
	for i = 1, #table do
		if table[i] == val then
			return true
		end
	end
	return false
end

local convert_char_array_to_string = function(tbl_bytes)
    local str = ""
    for k, v in pairs(tbl_bytes) do
        str = str .. string.char(v)
    end
    return str
end

local convert_to_char_array = function(str)
    local bytes = {}
    for i=1, str:len() do
        local char = string.sub(str, i, i+1)

        bytes[#bytes + 1] = char:byte()
    end

    return bytes
end

local function vmt_entry(instance, index, type)
    return ffi.cast(type, (ffi.cast("void***", instance)[0])[index])
end

local function vmt_bind(module, interface, index, typestring)
    local instance = client.create_interface(module, interface) or error("invalid interface")
    local fnptr = vmt_entry(instance, index, ffi.typeof(typestring)) or error("invalid vtable")
    return function(...)
        return fnptr(instance, ...)
    end
end

local _Cache, _Client = {}, {}
do
	for key, value in pairs(_G.ui) do
		_Cache[key] = value
	end
	for key, value in pairs(_G.client) do
		_Client[key] = value
	end
end
local ui_element_c = {}
local ui_element_mt = {__index = ui_element_c}

function ui_element_c.new(name)
	return setmetatable({name = name, isLoaded = true, cacheUIObjects = setmetatable({}, {__index = _G.table}), cacheDelays = setmetatable({}, {__index = _G.table}), cacheCallbacks = setmetatable({}, {__index = _G.table}), _Cache = _Cache}, ui_element_mt)
end

ui_element_c.reference = _Cache.reference
ui_element_c.set_visible = _Cache.set_visible
ui_element_c.mouse_position = _Cache.mouse_position
ui_element_c.is_menu_open = _Cache.is_menu_open
ui_element_c.set = _Cache.set
ui_element_c.get = _Cache.get
ui_element_c.update = _Cache.update
ui_element_c.menu_size = _Cache.menu_size
ui_element_c.name = _Cache.name
ui_element_c.menu_position = _Cache.menu_position
ui_element_c.set_callback = _Cache.set_callback

function ui_element_c:new_callback(event_name, callback)
	local obj = {}
	obj.name = event_name
	obj.created_time = client.timestamp()
	obj.callback = callback
	obj.instance = _Client.set_event_callback(event_name, callback)
	self.cacheCallbacks:insert(obj)
	return obj.instance
end

function ui_element_c:new_delay(delay, callback, ...)
		local function ww(callbacks, ...)
			if self.isLoaded then
				callbacks(...)
			else
				local obj = {}
				obj.delay = delay
				obj.callback = callback
				obj.args = {...}
				self.cacheDelays:insert(obj)
			end
		end
		local _, instance = pcall(_Client.delay_call, delay, ww, callback, ...)
		return instance
end

function ui_element_c:new_button(tab, container, name, callback)
	local obj = {}
	obj.name = name
	obj.created_time = client.timestamp()
	obj.callback = callback
	obj.instance = _Cache.new_button(tab, container, name, callback)
	self.cacheUIObjects:insert(obj)
	return obj.instance
end
function ui_element_c:new_checkbox(tab, container, name)
	local obj = {}
	obj.name = name
	obj.created_time = client.timestamp()
	obj.instance = _Cache.new_checkbox(tab, container, name)
	self.cacheUIObjects:insert(obj)
	return obj.instance
end
function ui_element_c:new_color_picker(tab, container, name, ...)
	local obj = {}
	obj.name = name
	obj.created_time = client.timestamp()
	obj.instance = _Cache.new_color_picker(tab, container, name, ...)
	self.cacheUIObjects:insert(obj)
	return obj.instance
end
function ui_element_c:new_combobox(tab, container, name, ...)
	local obj = {}
	obj.name = name
	obj.created_time = client.timestamp()
	obj.items = {...}
	obj.instance = _Cache.new_combobox(tab, container, name, ...)
	self.cacheUIObjects:insert(obj)
	return obj.instance
end
function ui_element_c:new_hotkey(tab, container, name, ...)
	local obj = {}
	obj.name = name
	obj.created_time = client.timestamp()
	obj.instance = _Cache.new_hotkey(tab, container, name, ...)
	self.cacheUIObjects:insert(obj)
	return obj.instance
end
function ui_element_c:new_listbox(tab, container, name, ...)
	local obj = {}
	obj.name = name
	obj.created_time = client.timestamp()
	obj.items = {...}
	obj.instance = _Cache.new_listbox(tab, container, name, ...)
	self.cacheUIObjects:insert(obj)
	return obj.instance
end
function ui_element_c:new_multiselect(tab, container, name, ...)
	local obj = {}
	obj.name = name
	obj.created_time = client.timestamp()
	obj.items = {...}
	obj.instance = _Cache.new_multiselect(tab, container, name, ...)
	self.cacheUIObjects:insert(obj)
	return obj.instance
end
function ui_element_c:new_slider(tab, container, name, ...)
	local obj = {}
	obj.name = name
	obj.created_time = client.timestamp()
	obj.instance = _Cache.new_slider(tab, container, name, ...)
	self.cacheUIObjects:insert(obj)
	return obj.instance
end
function ui_element_c:new_string(name, default_value)
	local obj = {}
	obj.name = name
	obj.created_time = client.timestamp()
	obj.instance = _Cache.new_string(name, default_value)
	self.cacheUIObjects:insert(obj)
	return obj.instance
end
function ui_element_c:new_textbox(tab, container, name)
	local obj = {}
	obj.name = name
	obj.created_time = client.timestamp()
	obj.instance = _Cache.new_textbox(tab, container, name)
	self.cacheUIObjects:insert(obj)
	return obj.instance
end
function ui_element_c:new_label(tab, container, name)
	local obj = {}
	obj.name = name
	obj.created_time = client.timestamp()
	obj.instance = _Cache.new_label(tab, container, name)
	self.cacheUIObjects:insert(obj)
	return obj.instance
end

function ui_element_c:getCachedUIObjects()
	return self.cacheUIObjects
end
function ui_element_c:getCachedCallbacks()
	return self.cacheCallbacks
end
function ui_element_c:getOriginalUI()
	return _Cache
end
function ui_element_c:getOriginalClient()
	return _Client
end
function ui_element_c:getUI()
	return setmetatable({
		new_button = function(...)
			return self:new_button(...)
		end,
		new_checkbox = function(...)
			return self:new_checkbox(...)
		end,
		new_color_picker = function(...)
			return self:new_color_picker(...)
		end,
		new_combobox = function(...)
			return self:new_combobox(...)
		end,
		new_hotkey = function(...)
			return self:new_hotkey(...)
		end,
		new_listbox = function(...)
			return self:new_listbox(...)
		end,
		new_multiselect = function(...)
			return self:new_multiselect(...)
		end,
		new_slider = function(...)
			return self:new_slider(...)
		end,
		new_string = function(...)
			return self:new_string(...)
		end,
		new_textbox = function(...)
			return self:new_textbox(...)
		end,
		new_label = function(...)
			return self:new_label(...)
		end
	}, {__index = _Cache})
end
function ui_element_c:getClient()
	return setmetatable({
		set_event_callback = function(...)
			return self:new_callback(...)
		end,
		delay_call = function(...)
			return self:new_delay(...)
		end
	}, {__index = _Client})
end
function ui_element_c:unload()
	if self.isLoaded == true then
	else return end
	self.isLoaded = false
	for key, value in ipairs(self.cacheCallbacks) do
		if value.name and value.name == "shutdown" then
			pcall(value.callback)
		end
		pcall(_Client.unset_event_callback, value.name, value.callback)
	end
	for key, value in ipairs(self.cacheUIObjects) do
		_Cache.set_visible(value.instance, false)
	end
	self.cacheCallbacks = {}
	self.cacheUIObjects = {}
	self.cacheDelays = {}
end
function ui_element_c:halt()
	if self.isLoaded == true then
	else return end
	self.isLoaded = false
	for key, value in ipairs(self.cacheCallbacks) do
		pcall(_Client.unset_event_callback, value.name, value.callback)
	end
	for key, value in ipairs(self.cacheUIObjects) do
		_Cache.set_visible(value.instance, false)
	end
end
function ui_element_c:resume()
	if self.isLoaded == false then
	else return end
	self.isLoaded = true
	for key, value in ipairs(self.cacheCallbacks) do
		pcall(_Client.set_event_callback, value.name, value.callback)
	end
	for key, value in ipairs(self.cacheUIObjects) do
		_Cache.set_visible(value.instance, true)
	end
	for key, value in pairs(self.cacheDelays) do
		self:new_delay(value.delay, value.callback, unpack(value.args))
		self.cacheDelays:remove(key)
	end
end

local ui_manager_c = {}
local ui_manager_mt = {__index = ui_manager_c}

function ui_manager_c.new()
	return setmetatable({hooks = {}}, ui_manager_mt)
end

function ui_manager_c:create(hook_name)
	local hook = ui_element_c.new(hook_name)
	table.insert(self.hooks, hook)
	return hook
end

function ui_manager_c:loadstring(luaCode, chunkName)
	if not chunkName or string.len(chunkName) == 0 then
		return nil, "Empty Chunk Name"
	end

    local upvalue = tostring(load)
    local can_be_hooked = upvalue:match("builtin") == nil

    if can_be_hooked then
        error('Cant load module error code[0x000000001]', 2)
    end

	local err, luaInstance = pcall(load, luaCode, chunkName, "t", setmetatable({}, {__index = _G}))
	if err then
		local hook = self:create(chunkName)
		local luaEnv = getfenv(luaInstance)
		luaEnv.client = hook:getClient()
		luaEnv.ui = hook:getUI()
		return hook, luaInstance
	end
	return nil, luaInstance
end

local hook_manager = ui_manager_c.new()
package.ui_hook = function(hook_name)
	local hook = hook_manager:create(hook_name)
	return hook
end
package.ui_loadstring = function(luaCode, chunkName)
	return hook_manager:loadstring(luaCode, chunkName)
end

--region dependency: immune_http_1_0_0
--region ffi
ffi.cdef[[
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

]]

--convert_char_array_to_string
--convert_to_char_array

local steam_ctx_match = client.find_signature("client.dll", convert_char_array_to_string({ 255, 21, 204, 204, 204, 204, 185, 204, 204, 204, 204, 232, 204, 204, 204, 204, 106 })) or error("steam_ctx")
local steam_ctx = ffi.cast("steam_ctx_t**", ffi.cast("char*", steam_ctx_match) + 7)[0] or error("steam_ctx not found")
local steam_http = ffi.cast("void*", steam_ctx.steam_http) or error("steam_http error")
local steam_http_ptr = ffi.cast("void***", steam_http) or error("steam_http_ptr error")
local steam_http_vtable = steam_http_ptr[0] or error("steam_http_ptr was null")
local create_http_request = ffi.cast('create_http_request_t', steam_http_vtable[0])
local send_http_request = ffi.cast('send_http_request_t', steam_http_vtable[5])
local get_http_response_header_size = ffi.cast('get_http_response_header_size_t', steam_http_vtable[9])
local get_http_response_header_value = ffi.cast('get_http_response_header_value_t', steam_http_vtable[10])
local get_http_response_body_size = ffi.cast('get_http_response_body_size_t', steam_http_vtable[11])
local get_http_response_body_data = ffi.cast('get_http_response_body_data_t', steam_http_vtable[12])
local set_http_request_param = ffi.cast('set_http_request_param_t', steam_http_vtable[4])
local release_http_request = ffi.cast('release_http_request_t', steam_http_vtable[14])
local set_http_request_user_agent_info = ffi.cast('set_http_request_user_agent_info_t', steam_http_vtable[21])
--endregion
--region request
local request_c = {}
local request_mt = {__index = request_c}
--- Instantiate a request object.
function request_c.new(handle, url, callback)
	local properties = {
		handle = handle,
		url = url,
		callback = callback,
		ticks = 0
	}
	local request = setmetatable(properties, request_mt)
	return request
end
--endregion
--region response
local response_c = {}
local response_mt = {__index = response_c}
--- Instantiate a response object.
function response_c.new(state, body, headers)
	local properties = {
		state = state,
		body = body,
		header = {
			content_type = headers.content_type
		}
	}
	local response = setmetatable(properties, response_mt)
	return response
end
--- Returns true if the response is good. False if not.
function response_c:success()
	return self.state == 0
end
--endregion
--region http
local http_c = {
	state = {
		ok = 0,
		no_response = 1,
		timed_out = 2,
		unknown = 3
	}
}
local http_mt = {__index = http_c}
--- Instantiate an http object.
function http_c.new(options)
	local options = options or {}
	local properties = {
		requests = {},
		task_interval = options.task_interval or 0.5,
		timeout = options.timeout or 10
	}
	local http = setmetatable(properties, http_mt)
	-- Initiate task queue processing.
	http:_process_tasks()
	return http
end
--- HTTP add get request to queue.
function http_c:get(url, callback)
    -- Create an HTTP handle.
    local handle = create_http_request(steam_http, 1, url)

    -- Return if we cannot process the request.
    if (send_http_request(steam_http, handle, 0) == false) then
        return
    end

    -- Create a request object.
    local request = request_c.new(handle, url, callback)

    -- Add the request to the task queue.
    table.insert(self.requests, request)
end
--- HTTP add post request to queue.
function http_c:post(url, params, callback)
	-- Create an HTTP handle.
	local handle = create_http_request(steam_http, 3, url)
	-- Set all POST parameters on handle.
	for k, v in pairs(params) do
		set_http_request_param(steam_http, handle, k, v)
    end
	-- Return if we cannot process the request.
	if send_http_request(steam_http, handle, 0) == false then
		return
    end
	-- Create a request object.
	local request = request_c.new(handle, url, callback)
	-- Add the request to the task queue.
	table.insert(self.requests, request)
end
--- HTTP process task queue.
function http_c:_process_tasks()
	for request_id, request in ipairs(self.requests) do
		-- Request body size FFI.
		local body_size_ptr = ffi.new("uint32_t[1]")
		-- Process request.
		if (get_http_response_body_size(steam_http, request.handle, body_size_ptr) == true) then
			-- Set response body size.
			local body_size = body_size_ptr[0]
			-- If a body was gotten from request.
			if body_size > 0 then
				-- Body FFI.
				local body = ffi.new("char[?]", body_size)
				-- Get the response body.
				if (get_http_response_body_data(steam_http, request.handle, body, body_size) == true) then
					-- Remove request from queue.
					table.remove(self.requests, request_id)
                    -- Release HTTP request.
                    release_http_request(steam_http, request.handle)
					-- Fire the request callback.
					request.callback(response_c.new(
						http_c.state.ok,
						ffi.string(body, body_size),
						{
							content_type = http_c._get_header(request, "Content-Type")
						}
					))
				end
			else
				-- the server's response was empty.
				table.remove(self.requests, request_id)
				-- Release HTTP request.
				release_http_request(steam_http, request.handle)
				-- Fire the request callback.
				request.callback(response_c.new(
					http_c.state.no_response,
					nil,
					{}
				))
			end
		end
		-- Incremented tick count.
		local tick_incremented = request.ticks + 1
		-- Return a timed out response.
		if tick_incremented >= self.timeout then
			-- Remove request from queue.
			table.remove(self.requests, request_id)
			-- Release HTTP request.
			release_http_request(steam_http, request.handle)
			-- Fire the request callback.
			request.callback(response_c.new(
				http_c.state.timed_out,
				nil,
				{}
			))
		else
			-- Increment ticks.
			request.ticks = tick_incremented
		end
	end
	-- Repeat task queue processing.
	client.delay_call(self.task_interval, http_c._bind(self, '_process_tasks'))
end
--- HTTP get header.
function http_c._get_header(request, header)
	-- Header size FFI.
	local header_size_ptr = ffi.new("uint32_t[1]")
	-- Get the header.
	if (get_http_response_header_size(steam_http, request.handle, header, header_size_ptr)) then
		-- Header size.
		local header_size = header_size_ptr[0]
		-- Header buffer.
		local header_buffer = ffi.new("char[?]", header_size)
		-- Return header.
		if (get_http_response_header_value(steam_http, request.handle, header, header_buffer, header_size)) then
			return ffi.string(header_buffer, header_size)
		end
	end
	-- No header found.
	return nil
end
--- Binds object callbacks.
function http_c._bind(t, k)
	return function(...) return t[k](t, ...) end
end
--endregion
--endregion

-- end

local dragging = (function()local a={}local b,c,d,e,f,g,h,i,j,k,l,m,n,o;local p={__index={drag=function(self,...)local q,r=self:get()local s,t=a.drag(q,r,...)if q~=s or r~=t then self:set(s,t)end;return s,t end,set=function(self,q,r)local j,k=client.screen_size()ui.set(self.x_reference,q/j*self.res)ui.set(self.y_reference,r/k*self.res)end,get=function(self)local j,k=client.screen_size()return ui.get(self.x_reference)/self.res*j,ui.get(self.y_reference)/self.res*k end}}function a.new(u,v,w,x)x=x or 10000;local j,k=client.screen_size()local y=ui.new_slider("LUA","A",u.." window position",0,x,v/j*x)local z=ui.new_slider("LUA","A","\n"..u.." window position y",0,x,w/k*x)ui.set_visible(y,false)ui.set_visible(z,false)return setmetatable({name=u,x_reference=y,y_reference=z,res=x},p)end;function a.drag(q,r,A,B,C,D,E)if globals.framecount()~=b then c=ui.is_menu_open()f,g=d,e;d,e=ui.mouse_position()i=h;h=client.key_state(0x01)==true;m=l;l={}o=n;n=false;j,k=client.screen_size()end;if c and i~=nil then if(not i or o)and h and f>q and g>r and f<q+A and g<r+B then n=true;q,r=q+d-f,r+e-g;if not D then q=math.max(0,math.min(j-A,q))r=math.max(0,math.min(k-B,r))end end end;table.insert(l,{q,r,A,B})return q,r,A,B end;return a end)()
--notify lib
local notify = (function()
    local notify = {callback_registered = false, maximum_count = 7, data = {}, svg_texture = [[<svg id="Capa_1" enable-background="new 0 0 512 512" height="512" viewBox="0 0 512 512" width="512" xmlns="http://www.w3.org/2000/svg"><g><g><path d="m216.188 82.318h48.768v37.149h-48.768z" fill="#ffcbbe"/></g><g><path d="m250.992 82.318h13.964v37.149h-13.964z" fill="#fdad9d"/></g><g><ellipse cx="240.572" cy="47.717" fill="#ffcbbe" rx="41.682" ry="49.166" transform="matrix(.89 -.456 .456 .89 4.732 115.032)"/></g><g><path d="m277.661 28.697c-10.828-21.115-32.546-32.231-51.522-27.689 10.933 4.421 20.864 13.29 27.138 25.524 12.39 24.162 5.829 52.265-14.654 62.769-2.583 1.325-5.264 2.304-8.003 2.96 10.661 4.31 22.274 4.391 32.387-.795 20.483-10.504 27.044-38.607 14.654-62.769z" fill="#fdad9d"/></g><g><path d="m296.072 296.122h-111.001v-144.174c0-22.184 17.984-40.168 40.168-40.168h30.666c22.184 0 40.168 17.984 40.168 40.168v144.174z" fill="#95d6a4"/></g><g><path d="m256.097 111.78h-24.384c22.077 0 39.975 17.897 39.975 39.975v144.367h24.384v-144.367c0-22.077-17.897-39.975-39.975-39.975z" fill="#78c2a4"/></g><g><path d="m225.476 41.375c0-8.811 7.143-15.954 15.954-15.954h34.401c-13.036-21.859-38.163-31.469-57.694-21.453-19.846 10.177-26.623 36.875-15.756 60.503 12.755-.001 23.095-10.341 23.095-23.096z" fill="#756e78"/></g><g><path d="m252.677 25.421h23.155c-11.31-18.964-31.718-28.699-49.679-24.408 10.591 4.287 20.23 12.757 26.524 24.408z" fill="#665e66"/></g><g><path d="m444.759 453.15-28.194-9.144c-3.04-.986-5.099-3.818-5.099-7.014v-4.69l-2.986-8.22h-61.669l-2.986 8.22v34.22c0 8.628 6.994 15.622 15.622 15.622h81.993c5.94 0 10.755-4.815 10.755-10.755v-8.008c.001-4.662-3.002-8.793-7.436-10.231z" fill="#aa7a63"/></g><g><path d="m444.759 453.15-28.194-9.144c-3.04-.986-5.099-3.818-5.099-7.014v-4.69l-2.986-8.22h-25.91v12.911c0 3.196 2.059 6.028 5.099 7.014l28.194 9.144c4.434 1.438 7.437 5.569 7.437 10.23v8.008c0 5.94-4.815 10.755-10.755 10.755h28.896c5.94 0 10.755-4.815 10.755-10.755v-8.008c0-4.662-3.003-8.793-7.437-10.231z" fill="#986b54"/></g><g><path d="m343.827 344.798v87.505h67.64v-123.053c0-20.65-16.74-37.39-37.39-37.39h-189.006v33.212c0 19.014 15.414 34.428 34.428 34.428h119.03c2.926 0 5.298 2.372 5.298 5.298z" fill="#5766cb"/></g><g><path d="m382.571 309.25v123.052h28.896v-123.052c0-20.65-16.74-37.39-37.39-37.39h-28.896c20.65 0 37.39 16.74 37.39 37.39z" fill="#3d4fc3"/></g><g><g><path d="m437.268 512h-108.548c-8.244 0-14.928-6.684-14.928-14.928v-107.221c0-11.247-9.15-20.399-20.398-20.399h-123.543c-8.244 0-14.928-6.684-14.928-14.928v-150.17h-22.748c-8.244 0-14.928-6.684-14.928-14.928s6.684-14.928 14.928-14.928h37.676c8.244 0 14.928 6.684 14.928 14.928v150.17h108.616c27.71 0 50.254 22.545 50.254 50.255v92.293h93.619c8.244 0 14.928 6.684 14.928 14.928s-6.684 14.928-14.928 14.928z" fill="#756e78"/></g></g><g><g><path d="m437.268 482.144h-15.115c8.244 0 14.928 6.684 14.928 14.928s-6.683 14.928-14.928 14.928h15.115c8.244 0 14.928-6.684 14.928-14.928s-6.684-14.928-14.928-14.928z" fill="#665e66"/></g><g><path d="m328.534 389.851v83.296c0 4.969 4.028 8.997 8.997 8.997h6.118v-92.293c0-27.755-22.5-50.255-50.255-50.255h-15.114c27.71 0 50.254 22.545 50.254 50.255z" fill="#665e66"/></g><g><path d="m169.664 189.426v150.17h15.115v-150.17c0-8.244-6.684-14.928-14.928-14.928h-15.115c8.245 0 14.928 6.684 14.928 14.928z" fill="#665e66"/></g></g><g><g><path d="m171.702 511.498c-61.701 0-111.898-50.197-111.898-111.898s50.197-111.898 111.898-111.898 111.898 50.197 111.898 111.898-50.197 111.898-111.898 111.898zm0-193.94c-45.238 0-82.042 36.804-82.042 82.042s36.804 82.042 82.042 82.042 82.042-36.804 82.042-82.042-36.804-82.042-82.042-82.042z" fill="#756e78"/></g></g><g><g><path d="m243.485 313.833c16.3 19.444 26.131 44.485 26.131 71.783 0 61.701-50.197 111.898-111.898 111.898-27.298 0-52.339-9.831-71.783-26.131 20.543 24.504 51.364 40.115 85.767 40.115 61.701 0 111.898-50.197 111.898-111.898 0-34.403-15.61-65.225-40.115-85.767z" fill="#665e66"/></g></g><g><path d="m384.583 259.81 13.927 12.767c8.319 7.626 13.447 18.117 14.353 29.366l.509 6.316c.283 3.513-3.591 5.82-6.545 3.898l-45.845-29.834z" fill="#ffcbbe"/></g><g><path d="m413.372 308.259-.509-6.316c-.906-11.249-6.034-21.74-14.353-29.366l-13.927-12.767-7.744 7.387 5.869 5.38c8.319 7.626 13.447 18.117 14.353 29.366l.328 4.072 9.438 6.142c2.954 1.921 6.828-.386 6.545-3.898z" fill="#fdad9d"/></g><g><g><path d="m366.869 290.965c-1.448 1.448-3.783 1.589-5.341.26-8.038-6.857-18.146-10.594-28.827-10.594h-69.416c-31.072 0-56.26-25.188-56.26-56.26v-63.312c0-12.367 10.025-22.392 22.392-22.392 12.367 0 22.392 10.025 22.392 22.392v63.312c0 6.338 5.138 11.476 11.476 11.476h69.415c22.462 0 43.657 8.238 60.136 23.284 1.672 1.526 1.716 4.151.115 5.752z" fill="#95d6a4"/></g></g><g><path d="m392.836 259.13c-16.479-15.047-37.674-23.284-60.136-23.284h-69.416c-6.338 0-11.476-5.138-11.476-11.476v-63.312c0-12.367-10.025-22.392-22.392-22.392-3.429 0-6.676.773-9.581 2.151 5.315 4.094 8.743 10.518 8.743 17.746v74.508c0 6.338 5.138 11.476 11.476 11.476h69.416c22.462 0 43.657 8.238 60.136 23.284 1.672 1.526 1.716 4.151.115 5.752l-13.663 13.663c1.907 1.181 3.739 2.503 5.469 3.979 1.558 1.329 3.893 1.188 5.341-.26l26.082-26.082c1.602-1.602 1.558-4.226-.114-5.753z" fill="#78c2a4"/></g></g></svg>]]}
    local svg_size = { w = 20, h = 20}
    local svg = renderer.load_svg(notify.svg_texture, svg_size.w, svg_size.h)
    function notify:register_callback()
        if self.callback_registered then return end
        client.set_event_callback('paint_ui', function()
            local screen = {client.screen_size()}
            local color = {10, 10, 10}
            local d = 5;
            local data = self.data;
            for f = #data, 1, -1 do
                data[f].time = data[f].time - globals.frametime()
                local alpha, h = 255, 0;
                local _data = data[f]
                if _data.time < 0 then
                    table.remove(data, f)
                else
                    local time_diff = _data.def_time - _data.time;
                    local time_diff = time_diff > 1 and 1 or time_diff;
                    if _data.time < 0.5 or time_diff < 0.5 then
                        h = (time_diff < 1 and time_diff or _data.time) / 0.5;
                        alpha = h * 255;
                        if h < 0.2 then
                            d = d + 15 * (1.0 - h / 0.2)
                        end
                    end
                    local text_data = {renderer.measure_text("dc", _data.draw)}
                    local screen_data = {
                        screen[1] / 2 - text_data[1] / 2 + 3, screen[2] - screen[2] / 100 * 17.4 + d
                    }
                    renderer.rectangle(screen_data[1] - 30, screen_data[2] - 22, text_data[1] + 60, 2, 252, 131, 131, alpha)
                    renderer.rectangle(screen_data[1] - 29, screen_data[2] - 20, text_data[1] + 58, 29, color[1], color[2],color[3], alpha <= 135 and alpha or 135)
                    renderer.line(screen_data[1] - 30, screen_data[2] - 22, screen_data[1] - 30, screen_data[2] - 20 + 30, 252, 131, 131, alpha <= 50 and alpha or 50)
                    renderer.line(screen_data[1] - 30 + text_data[1] + 60, screen_data[2] - 22, screen_data[1] - 30 + text_data[1] + 60, screen_data[2] - 20 + 30, 252, 131, 131, alpha <= 50 and alpha or 50)
                    renderer.line(screen_data[1] - 30, screen_data[2] - 20 + 30, screen_data[1] - 30 + text_data[1] + 60, screen_data[2] - 20 + 30, 252, 131, 131, alpha <= 50 and alpha or 50)
                    renderer.text(screen_data[1] + text_data[1] / 2 + 10, screen_data[2] - 5, 255, 255, 255, alpha, 'dc', nil, _data.draw)
                    renderer.texture(svg, screen_data[1] - svg_size.w/2 - 5, screen_data[2] - svg_size.h/2 - 5, svg_size.w, svg_size.h, 255, 255, 255, alpha)
                    d = d - 50
                end
            end
            self.callback_registered = true
        end)
    end
    function notify:paint(time, text)
        local timer = tonumber(time) + 1;
        for f = self.maximum_count, 2, -1 do
            self.data[f] = self.data[f - 1]
        end
        self.data[1] = {time = timer, def_time = timer, draw = text}
        self:register_callback()
    end
    return notify
end)()


-- SURFACE
local surface = (function()
    local M = {}

    local ffi = require "ffi"
    local bit = require "bit"

    local bit_bor = bit.bor
    local ffi_string = ffi.string
    local ffi_cast = ffi.cast

    local function vmt_entry(instance, index, type)
    	return ffi.cast(type, (ffi.cast("void***", instance)[0])[index])
    end

    -- instance is bound to the callback as an upvalue
    local function vmt_bind(module, interface, index, typestring)
    	local instance = client.create_interface(module, interface) or error("invalid interface")
    	local success, typeof = pcall(ffi.typeof, typestring)
    	if not success then
    		error(typeof, 2)
    	end
    	local fnptr = vmt_entry(instance, index, typeof) or error("invalid vtable")
    	return function(...)
    		return fnptr(instance, ...)
    	end
    end

    -- instance will be passed to the function at runtime
    local function vmt_thunk(index, typestring)
    	local t = ffi.typeof(typestring)
    	return function(instance, ...)
    		assert(instance ~= nil)
    		if instance then
    			return vmt_entry(instance, index, t)(instance, ...)
    		end
    	end
    end

    local new_charbuffer = ffi.typeof("char[?]")
    local new_intptr = ffi.typeof("int[1]")
    local new_widebuffer = ffi.typeof("wchar_t[?]")

    -- localize
    local native_Localize_ConvertAnsiToUnicode 	= vmt_bind("localize.dll", "Localize_001", 15, "int(__thiscall*)(void*, const char*, wchar_t*, int)")
    local native_Localize_ConvertUnicodeToAnsi 	= vmt_bind("localize.dll", "Localize_001", 16, "int(__thiscall*)(void*, wchar_t*, char*, int)")
    local native_Localize_FindSafe 							= vmt_bind("localize.dll", "Localize_001", 12, "wchar_t*(__thiscall*)(void*, const char*)")

    -- surface
    local native_Surface_DrawSetColor 				= vmt_bind("vguimatsurface.dll", "VGUI_Surface031", 15, "void(__thiscall*)(void*, int, int, int, int)")
    local native_Surface_DrawFilledRect 			= vmt_bind("vguimatsurface.dll", "VGUI_Surface031", 16, "void(__thiscall*)(void*, int, int, int, int)")
    local native_Surface_DrawOutlinedRect 		= vmt_bind("vguimatsurface.dll", "VGUI_Surface031", 18, "void(__thiscall*)(void*, int, int, int, int)")
    local native_Surface_DrawLine 						= vmt_bind("vguimatsurface.dll", "VGUI_Surface031", 19, "void(__thiscall*)(void*, int, int, int, int)")
    local native_Surface_DrawPolyLine 				= vmt_bind("vguimatsurface.dll", "VGUI_Surface031", 20, "void(__thiscall*)(void*, int*, int*, int)")
    local native_Surface_DrawSetTextFont 			= vmt_bind("vguimatsurface.dll", "VGUI_Surface031", 23, "void(__thiscall*)(void*, unsigned long)")
    local native_Surface_DrawSetTextColor 		= vmt_bind("vguimatsurface.dll", "VGUI_Surface031", 25, "void(__thiscall*)(void*, int, int, int, int)")
    local native_Surface_DrawSetTextPos 			= vmt_bind("vguimatsurface.dll", "VGUI_Surface031", 26, "void(__thiscall*)(void*, int, int)")
    local native_Surface_DrawPrintText 				= vmt_bind("vguimatsurface.dll", "VGUI_Surface031", 28, "void(__thiscall*)(void*, const wchar_t*, int, int)")
    local native_Surface_DrawGetTextureId 		= vmt_bind("vguimatsurface.dll", "VGUI_Surface031", 34, "int(__thiscall*)(void*, const char*)") -- new
    local native_Surface_DrawGetTextureFile 	= vmt_bind("vguimatsurface.dll", "VGUI_Surface031", 35, "bool(__thiscall*)(void*, int, char*, int)") -- new
    local native_Surface_DrawSetTextureFile 	= vmt_bind("vguimatsurface.dll", "VGUI_Surface031", 36, "void(__thiscall*)(void*, int, const char*, int, bool)") -- new
    local native_Surface_DrawSetTextureRGBA 	= vmt_bind("vguimatsurface.dll", "VGUI_Surface031", 37, "void(__thiscall*)(void*, int, const wchar_t*, int, int)") -- new
    local native_Surface_DrawSetTexture 			= vmt_bind("vguimatsurface.dll", "VGUI_Surface031", 38, "void(__thiscall*)(void*, int)") -- new
    local native_Surface_DeleteTextureByID 		= vmt_bind("vguimatsurface.dll", "VGUI_Surface031", 39, "void(__thiscall*)(void*, int)") -- new
    local native_Surface_DrawGetTextureSize 	= vmt_bind("vguimatsurface.dll", "VGUI_Surface031", 40, "void(__thiscall*)(void*, int, int&, int&)") -- new
    local native_Surface_DrawTexturedRect 		= vmt_bind("vguimatsurface.dll", "VGUI_Surface031", 41, "void(__thiscall*)(void*, int, int, int, int)")
    local native_Surface_IsTextureIDValid 		= vmt_bind("vguimatsurface.dll", "VGUI_Surface031", 42, "bool(__thiscall*)(void*, int)") -- new
    local native_Surface_CreateNewTextureID 	= vmt_bind("vguimatsurface.dll", "VGUI_Surface031", 43, "int(__thiscall*)(void*, bool)") -- new
    local native_Surface_UnlockCursor 				= vmt_bind("vguimatsurface.dll", "VGUI_Surface031", 66, "void(__thiscall*)(void*)")
    local native_Surface_LockCursor 					= vmt_bind("vguimatsurface.dll", "VGUI_Surface031", 67, "void(__thiscall*)(void*)")
    local native_Surface_CreateFont 					= vmt_bind("vguimatsurface.dll", "VGUI_Surface031", 71, "unsigned int(__thiscall*)(void*)")
    local native_Surface_SetFontGlyph 				= vmt_bind("vguimatsurface.dll", "VGUI_Surface031", 72, "void(__thiscall*)(void*, unsigned long, const char*, int, int, int, int, unsigned long, int, int)")
    local native_Surface_GetTextSize 					= vmt_bind("vguimatsurface.dll", "VGUI_Surface031", 79, "void(__thiscall*)(void*, unsigned long, const wchar_t*, int&, int&)")
    local native_Surface_GetCursorPos 				= vmt_bind("vguimatsurface.dll", "VGUI_Surface031", 100, "unsigned int(__thiscall*)(void*, int*, int*)")
    local native_Surface_SetCursorPos					= vmt_bind("vguimatsurface.dll", "VGUI_Surface031", 101, "unsigned int(__thiscall*)(void*, int, int)")
    local native_Surface_DrawOutlinedCircle 	= vmt_bind("vguimatsurface.dll", "VGUI_Surface031", 103, "void(__thiscall*)(void*, int, int, int, int)")
    local native_Surface_DrawFilledRectFade 	= vmt_bind("vguimatsurface.dll", "VGUI_Surface031", 123, "void(__thiscall*)(void*, int, int, int, int, unsigned int, unsigned int, bool)")

    local function draw_print_text(text, localized)
    	if localized then
    		local cb_size = 1024
    		local char_buffer = new_charbuffer(cb_size)
    		native_Localize_ConvertUnicodeToAnsi(text, char_buffer, cb_size)

    		local test = ffi_string(char_buffer)
    		return native_Surface_DrawPrintText(text, test:len(), 0)
    	else
    		local wb_size = 1024
    		local wide_buffer = new_widebuffer(wb_size)

    		native_Localize_ConvertAnsiToUnicode(text, wide_buffer, wb_size)
    		return native_Surface_DrawPrintText(wide_buffer, text:len(), 0)
    	end
    end

    local function get_text_size(font, text)
    	local wide_buffer = new_widebuffer(1024)
    	local w_ptr = new_intptr()
    	local h_ptr = new_intptr()

    	native_Localize_ConvertAnsiToUnicode(text, wide_buffer, 1024)
    	native_Surface_GetTextSize(font, wide_buffer, w_ptr, h_ptr)

    	local w = tonumber(w_ptr[0])
    	local h = tonumber(h_ptr[0])

    	return w, h
    end

    --------------------------
    -- renderer functions --
    --------------------------

    -- cache fonts since we cant delete them, so if multiple scripts create the same font they get the same ID
    local font_cache = {}

    function M.create_font(windows_font_name, tall, weight, flags)
    	local flags_i = 0
    	local t = type(flags)
    	if t == "number" then
    		flags_i = flags
    	elseif t == "table" then
    		for i=1, #flags do
    			flags_i = flags_i + flags[i]
    		end
    	else
    		error("invalid flags type, has to be number or table")
    	end

    	local cache_key = string.format("%s\0%d\0%d\0%d", windows_font_name, tall, weight, flags_i)
    	if font_cache[cache_key] == nil then
    		font_cache[cache_key] = native_Surface_CreateFont()
    		native_Surface_SetFontGlyph(font_cache[cache_key], windows_font_name, tall, weight, 0, 0, bit_bor(flags_i), 0, 0)
    	end

    	return font_cache[cache_key]
    end

    function M.localize_string(str, buf_size)
    	local res = native_Localize_FindSafe(str)
    	local charbuffer = new_charbuffer(buf_size or 1024)
    	native_Localize_ConvertUnicodeToAnsi(res, charbuffer, buf_size or 1024)
    	return charbuffer and ffi_string(charbuffer) or nil
    end

    function M.draw_text(x, y, r, g, b, a, font, text)
    	native_Surface_DrawSetTextPos(x, y)
    	native_Surface_DrawSetTextFont(font)
    	native_Surface_DrawSetTextColor(r, g, b, a)
    	return draw_print_text(text, false)
    end

    function M.draw_localized_text(x, y, r, g, b, a, font, text)
    	native_Surface_DrawSetTextPos(x, y)
    	native_Surface_DrawSetTextFont(font)
    	native_Surface_DrawSetTextColor(r, g, b, a)

    	local localized_string = native_Localize_FindSafe(text)
    	return draw_print_text(localized_string, true)
    end

    function M.draw_line(x0, y0, x1, y1, r, g, b, a)
    	native_Surface_DrawSetColor(r, g, b, a)
    	return native_Surface_DrawLine(x0, y0, x1, y1)
    end

    function M.draw_filled_rect(x, y, w, h, r, g, b, a)
    	native_Surface_DrawSetColor(r, g, b, a)
    	return native_Surface_DrawFilledRect(x, y, x + w, y + h)
    end

    function M.draw_outlined_rect(x, y, w, h, r, g, b, a)
    	native_Surface_DrawSetColor(r, g, b, a)
    	return native_Surface_DrawOutlinedRect(x, y, x + w, y + h)
    end

    function M.draw_filled_outlined_rect(x, y, w, h, r0, g0, b0, a0, r1, g1, b1, a1)
    	native_Surface_DrawSetColor(r0, g0, b0, a0)
    	native_Surface_DrawFilledRect(x, y, x + w, y + h)
    	native_Surface_DrawSetColor(r1, g1, b1, a1)
    	return native_Surface_DrawOutlinedRect(x, y, x + w, y + h)
    end

    function M.draw_filled_gradient_rect(x, y, w, h, r0, g0, b0, a0, r1, g1, b1, a1, horizontal)
    	native_Surface_DrawSetColor(r0, g0, b0, a0)
    	native_Surface_DrawFilledRectFade(x, y, x + w, y + h, 255, 255, horizontal)

    	native_Surface_DrawSetColor(r1, g1, b1, a1)
    	return native_Surface_DrawFilledRectFade(x, y, x + w, y + h, 0, 255, horizontal)
    end

    function M.draw_outlined_circle(x, y, r, g, b, a, radius, segments)
    	native_Surface_DrawSetColor(r, g, b, a)
    	return native_Surface_DrawOutlinedCircle(x, y, radius, segments)
    end

    function M.draw_poly_line(x, y, r, g, b, a, count)
    	native_Surface_DrawSetColor(r, g, b, a)
    	return native_Surface_DrawPolyLine(new_intptr(x), new_intptr(y), count)
    end

    function M.test_font(x, y, r, g, b, a, font)
    	local _, height_offset = get_text_size(font, "a b c d e f g h i j k l m n o p q r s t u v w x y z")

    	M.draw_text(x, y, r, g, b, a, font, "a b c d e f g h i j k l m n o p q r s t u v w x y z 0 1 2 3 4 5 6 7 8 9 ß + # ä ö ü , . -")
    	M.draw_text(x, y + height_offset, r, g, b, a,  font, "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z = ! \" § $ % & / ( ) = ? { [ ] } \\ * ' _ : ; ~ ")
    end

    function M.get_text_size(font, text)
    	return get_text_size(font, text)
    end

    function M.set_mouse_pos(x, y)
    	return native_Surface_SetCursorPos(x, y)
    end

    function M.get_mouse_pos()
    	local x_ptr = new_intptr()
    	local y_ptr = new_intptr()

    	native_Surface_GetCursorPos(x_ptr, y_ptr)

    	local x = tonumber(x_ptr[0])
    	local y = tonumber(y_ptr[0])

    	return x, y
    end

    function M.unlock_cursor()
    	return native_Surface_UnlockCursor()
    end

    function M.lock_cursor()
    	return native_Surface_LockCursor()
    end

    function M.load_texture(filename)
    	local texture = native_Surface_CreateNewTextureID(false)
    	native_Surface_DrawSetTextureFile(texture, filename, true, true)

    	local wide_ptr = new_intptr()
    	local tall_ptr = new_intptr()
    	native_Surface_DrawGetTextureSize(texture, wide_ptr, tall_ptr)

    	local w = tonumber(wide_ptr[0])
    	local h = tonumber(tall_ptr[0])

    	return texture, w, h
    end

    -- fallback to built in renderer
    setmetatable(M, {
    	__index = renderer
    })

    return M
end)()
-- SURFACE

local menu = {}
local menu_mt = { __index = menu }
function menu:create(title, additional_information, suffix)
    return setmetatable({
        title = title,
        additional_information = additional_information,
        suffix = suffix,
        menu_drag = dragging.new(title, 150, 450),
        w = 300, h = 20,
        Verdana = surface.create_font("Calibri Bold", 26, 800, { 0x000 }),
        Corbel = surface.create_font("Microsoft Sans Serif", 13, 600, { 0x000 }),
        Corbel2 = surface.create_font("Microsoft Sans Serif", 13, 600, { 0x080 })
    }, menu_mt)
end

function menu:update(title, additional_information, suffix)
    self.title = title
    self.additional_information = additional_information
    self.suffix = suffix
end

function menu:mouse_in_region(x1, y1, x2, y2)
	local mouse_position = { ui.mouse_position() }
	if not ui.is_menu_open() then return false end
	return (mouse_position[1] >= x1 and mouse_position[1] <= (x1 + x2) and mouse_position[2] >= y1 and mouse_position[2] <= (y1 + y2) )
end


local VKey = {
	presses = 0,
	lastPresses = 0,
	toggled = false,
	released = false,
	LEFT_MOUSE = 1,
	RIGHT_MOUSE = 2,
	MIDDLE_MOUSE = 3,
	MOUSE_4 = 5,
	MOUSE_5 = 6,
	BACKSPACE = 8,
	TAB = 9,
	ENTER = 13,
	SHIFT = 16,
	CONTROL = 17,
	ALT = 18,
	PAUSE = 19,
	CAPS_LOCK = 20,
	ESCAPE = 27,
	SPACE = 32,
	PAGE_UP = 33,
	PAGE_DOWN = 34,
	PAGE_END = 35,
	HOME = 36,
	ARROW_LEFT = 37,
	ARROW_UP = 38,
	ARROW_RIGHT = 39,
	ARROW_DOWN = 40,
	INSERT = 45,
	DEL = 46,
	NUMROW_0 = 48,
	NUMROW_1 = 49,
	NUMROW_2 = 50,
	NUMROW_3 = 51,
	NUMROW_4 = 52,
	NUMROW_5 = 53,
	NUMROW_6 = 54,
	NUMROW_7 = 55,
	NUMROW_8 = 56,
	NUMROW_9 = 57,
	NUMROW_EQUALS = 61,
	A = 65,
	B = 66,
	C = 67,
	D = 68,
	E = 69,
	F = 70,
	G = 71,
	H = 72,
	I = 73,
	J = 74,
	K = 75,
	L = 76,
	M = 77,
	N = 78,
	O = 79,
	P = 80,
	Q = 81,
	R = 82,
	S = 83,
	T = 84,
	U = 85,
	V = 86,
	W = 87,
	X = 88,
	Y = 89,
	Z = 90,
	WIN_LEFT = 91,
	WIN_RIGHT = 92,
	APPS = 93,
	SLEEP = 95,
	NUMPAD_0 = 96,
	NUMPAD_1 = 97,
	NUMPAD_2 = 98,
	NUMPAD_3 = 99,
	NUMPAD_4 = 100,
	NUMPAD_5 = 101,
	NUMPAD_6 = 102,
	NUMPAD_7 = 103,
	NUMPAD_8 = 104,
	NUMPAD_9 = 105,
	NUMPAD_MUL = 106,
	NUMPAD_ADD = 107,
	NUMPAD_SUB = 109,
	NUMPAD_DECIMAL = 110,
	NUMPAD_DIV = 111,
	F1 = 112,
	F2 = 113,
	F3 = 114,
	F4 = 115,
	F5 = 116,
	F6 = 117,
	F7 = 118,
	F8 = 119,
	F9 = 120,
	F10 = 121,
	F11 = 122,
	F12 = 123,
	NUM_LOCK = 144,
	SCROLL_LOCK = 145,
	PUNCT_PERIOD = 190,
	PUNCT_FORWARD_SLASH = 191,
	PUNCT_TILDE = 192,
	PUNCT_COMMA = 188,
	PUNCT_LEFT_BRACE = 219,
	PUNCT_BACKWARD_SLASH = 220,
	PUNCT_RIGHT_BRACE = 221,
	PUNCT_QUOTES = 222,
}

local VKey_mt = { __index = VKey }

--- @param vKey number
--- @return VKey
function VKey:new(VKey)
	return setmetatable({
		vKey = VKey
	}, VKey_mt)
end

--- @return void
function VKey:update()
	local state = self.vKey and client.key_state(self.vKey) or false

	if self.lastState ~= state then
		self.lastState = state

		if state then
			self.presses = self.presses + 1
			self.toggled = not self.toggled
		end
	end
end

--- @return boolean
function VKey:isHeld()
	self:update()

	return self.vKey and client.key_state(self.vKey) or false
end

--- @return boolean
function VKey:isHit()
	self:update()

	if self.lastPresses ~= self.presses then
		self.lastPresses = self.presses

		return true
	end

	return false
end

--- @return boolean
function VKey:isToggled()
	self:update()

	return self.toggled
end

--- @return boolean
function VKey:isReleased()
	self:update()

	if self:isHeld() then
		self.released = false

		return false
	end

	if self.released == false then
		self.released = true

		return true
	end

	return false
end

function menu:render()
    local GLOBAL_ALPHA = 0
    local STYLE_UI = ui.new_string("exscord theme", "White")
    local mouse1 = VKey:new(1)
    client.set_event_callback("paint_ui", function()

        local STYLE = ui.get(STYLE_UI)

        -- STYLE SELECTION

        local styles = {
            ["Dark"] = {
                background = {
                    [1] = { r = 10, g = 10, b = 10 },
                    [2] = { r = 25, g = 25, b = 25 }
                },
                text = {
                    [1] = { r = 225, g = 225, b = 225 },
                    [2] = { r = 235, g = 235, b = 235 },
                    [3] = { r = 0, g = 150, b = 255 } 
                }
            },
            ["Dark Ocean"] = {
                background = {
                    [1] = { r = 9, g = 11, b = 16 },
                    [2] = { r = 15, g = 17, b = 26 }
                },
                text = {
                    [1] = { r = 225, g = 225, b = 225 },
                    [2] = { r = 235, g = 235, b = 235 },
                    [3] = { r = 0, g = 150, b = 255 } 
                }
            },
        }

        local color = styles[STYLE] or styles["Dark"]

        local frames = globals.frametime() * 8

        local opened = ui.is_menu_open()

        if opened then
    
            GLOBAL_ALPHA = GLOBAL_ALPHA + frames
    
            if GLOBAL_ALPHA > 1 then
                GLOBAL_ALPHA = 1
            end
    
        else
            GLOBAL_ALPHA = GLOBAL_ALPHA - frames
    
            if GLOBAL_ALPHA <= 0 then
                GLOBAL_ALPHA = 0
            end
        end

        self.menu_drag:drag(self.w, self.h)
        local x, y = self.menu_drag:get()
        --
        surface.draw_filled_rect(x, y, self.w, self.h, color.background[1].r, color.background[1].g, color.background[1].b, 255*GLOBAL_ALPHA)
        surface.draw_text(x + 5, y + 3, color.text[1].r, color.text[1].g, color.text[1].b, 255*GLOBAL_ALPHA, self.Corbel, "Information")
        surface.draw_text(x + self.w - 15, y + 3, color.text[1].r, color.text[1].g, color.text[1].b, 255*GLOBAL_ALPHA, self.Corbel, "X")
        --renderer.rectangle(x, y, self.w, self.h, 230, 230, 230, 255*GLOBAL_ALPHA)
        --renderer.text(x + 5, y + 3, 30, 30, 30, 255*GLOBAL_ALPHA, nil, 0, "Information")
        --renderer.text(x + self.w - 15, y + 3, 30, 30, 30, 255*GLOBAL_ALPHA, 'b', 0, 'X')
        --
        local additional_information_h = 0
        local info = {}
        for k, v in pairs(self.additional_information) do
            additional_information_h = additional_information_h + 15
        end
        surface.draw_filled_rect(x, y + self.h, self.w, additional_information_h + 56, color.background[2].r, color.background[2].g, color.background[2].b, 255*GLOBAL_ALPHA)
        --renderer.rectangle(x, y + self.h, self.w, additional_information_h + 56, 200, 200, 200, 255*GLOBAL_ALPHA)
        local title_size = { surface.get_text_size(self.Verdana, self.title) }
        surface.draw_text(x + 5 + self.w/2 - title_size[1]/2, y + self.h + 18 - title_size[2]/2, color.text[2].r, color.text[2].g, color.text[2].b, 255*GLOBAL_ALPHA, self.Verdana, self.title)
        --renderer.text(x + 5 + self.w/2, y + self.h + 18, 20, 20, 20, 255*GLOBAL_ALPHA, 'c+', 0, self.title)
        local text_y = 0
        for k, v in pairs(self.additional_information) do
            --local text_size = { renderer.measure_text('b', k) }
            local text_size = { surface.get_text_size(self.Corbel, k) }

            surface.draw_text(x + 5, y + self.h + text_y + 36, color.text[1].r, color.text[1].g, color.text[1].b, 255*GLOBAL_ALPHA, self.Corbel, k)
            surface.draw_text(x + text_size[1] + 10, y + self.h + text_y + 36, color.text[3].r, color.text[3].g, color.text[3].b, 255*GLOBAL_ALPHA, self.Corbel2, v)

            --renderer.text(x + 5, y + self.h + text_y + 36, 30, 30, 30, 255*GLOBAL_ALPHA, '', 0, k)
            --renderer.text(x + text_size[1] + 10, y + self.h + text_y + 36, 0, 255, 255, 255*GLOBAL_ALPHA, '', 0, v)
            text_y = text_y + 15
        end
        local suffix_size = { surface.get_text_size(self.Corbel, self.suffix) }
        surface.draw_text(x + 5 + self.w/2 - suffix_size[1]/2, y + self.h + 46 + text_y - suffix_size[2]/2, color.text[2].r, color.text[2].g, color.text[2].b, 255*GLOBAL_ALPHA, self.Corbel, self.suffix)
        --renderer.text(x + 5 + self.w/2, y + self.h + 46 + text_y, 20, 20, 20, 255*GLOBAL_ALPHA, 'cb', 0, self.suffix)
        surface.draw_filled_rect(x, y + self.h + additional_information_h + 56, self.w, 28, color.background[2].r, color.background[2].g, color.background[2].b, 255*GLOBAL_ALPHA)
        surface.draw_text(x + 5, y + self.h + 46 + text_y + 13, color.text[2].r, color.text[2].g, color.text[2].b, 255*GLOBAL_ALPHA, self.Corbel, "Style")
        local styles_count = 0
        for k, v in pairs(styles) do

            if self:mouse_in_region(x + 5 + select(1, surface.get_text_size(self.Corbel, "Style")) + 25*styles_count + 25 - 10, y + self.h + 46 + text_y + 20 - 10, 10*2, 10*2) and mouse1:isReleased() then
                ui.set(STYLE_UI, k)
            end

            renderer.circle_outline(x + 5 + select(1, surface.get_text_size(self.Corbel, "Style")) + 25*styles_count + 25, y + self.h + 46 + text_y + 20, styles[k].text[3].r, styles[k].text[3].g, styles[k].text[3].b, 255*GLOBAL_ALPHA, 10, 0, 1, 1)
            renderer.circle(x + 5 + select(1, surface.get_text_size(self.Corbel, "Style")) + 25*styles_count + 25, y + self.h + 46 + text_y + 20, styles[k].background[2].r, styles[k].background[2].g, styles[k].background[2].b, 255*GLOBAL_ALPHA, 9, 0, 1)
            styles_count = styles_count + 1
        end
    end)
end


local loader = {}
local loader_mt = { __index = loader }

function loader:setup()
    return setmetatable({
        username = "",
        password = "",
        hwid = "",
        title = "",
        http = http_c.new( { task_interval = 0.1, enable_debug = true, timeout = 25 } ),
        button_callback = nil,
        register = false,
        ui = {},
        scripts = {},
        formated_scripts = {},
        load_callback = nil,
        unload_callback = nil,
        autofill = database.read("exscord:database") or {},
		menu = menu:create("EXSCORD.TECH", {
			[""] = "",
		}, "Connecting to the server")
    }, loader_mt)
end

function loader:create_items()
    local items = {
        login_label = ui.new_label("LUA", "B", "> Login"),
        login = ui.new_textbox("LUA", "B", "exscord:login"),
        password_label = ui.new_label("LUA", "B", "> Password"),
        password = ui.new_textbox("LUA", "B", "exscord:password"),
        button = ui.new_button("LUA", "B", "Login", function() if type(self.button_callback) == "function" then self.button_callback() end end),
        register = ui.new_button("LUA", "B", "Register", function() if type(self.button_callback) == "function" then self.button_callback() end end),
        description = ui.new_label("LUA", "B", "    > Unknown")--,
        --script_list_label = ui.new_label("LUA", "B", "  > Scripts:"),
        --script_list = ui.new_listbox("LUA", "B", "exscord:scripts", self.scripts),
        --script_list_description = ui.new_label("LUA", "B", "  > Unknown"),
        --script_list_version = ui.new_label("LUA", "B", "  > Version: unknown"),
        --script_load = ui.new_button("LUA", "B", "Load", function() if type(self.load_callback) == "function" then self.load_callback() end end),
        --script_unload = ui.new_button("LUA", "B", "Unload", function() if type(self.unload_callback) == "function" then self.unload_callback() end end),
    }

    self.ui = items

    return self.ui
end

function loader:request(url, params, callback)

    local callback = type(params) ~= "function" and callback or params

    if type(params) ~= "table" and type(params) ~= "function" then
        error("Invalid arg[2], params must be a table")
    end

    local http = self.http

    local items = self.ui

    ui.set_visible(items.description, true)

    ui.set(items.description, "    > Connecting to the server")
    self:log("Connecting to the server")
	notify:paint(5, "exscord starting connecting to server")

    local url = url

    if type(params) == "table" then
        local new_params = {}

        for param_name, param in pairs(params) do
            table.insert(new_params, string.format("%s=%s", param_name, param))
        end

        url = string.format("%s?%s", url, table.concat(new_params, "&"))
    end

    http:get(url, function(response)

        local success, data = pcall( json.parse, response.body)

        if not success then
            ui.set(items.description, "    > Connection errors occurred")
            self:log("Connection errors occurred")
			notify:paint(5, "exscord connections errors occurred")
            callback()
            return
        end

        ui.set(items.description, "    > Successful connection")
        self:log("Successful connection")
		notify:paint(5, "exscord successfully connected to servers")

        callback(data)

    end)

end

function loader:update_script_list()

    local items = self.ui

    self.formated_scripts = {}

    for _, script in pairs(self.scripts) do
        local prefix = script.loaded and "☑" or "☐"
        table.insert(self.formated_scripts, string.format("%s %s", prefix, script.name))
    end

    ui.update(items.script_list, self.formated_scripts)

end

function loader:connect(params)

	self.menu:update("EXSCORD", {
		[""] = ""
	}, "Connecting to the server")

    local auto_form = self.autofill.login ~= nil and self.autofill.password ~= nil

    local indexes ={
        "login_label",
        "login",
        "password_label",
        "password",
        "button"
    }

    local ignore_list = { "script_load", "script_unload" }

    local params = params or { username = self.username, password = self.password, hwid = self.hwid }

    local items = self.ui

    self:request("https://exscord.tech/lua/", params, function(server_data)

        if server_data == nil then

            for item_index, item in pairs(items) do
                if not contains(ignore_list, item_index) then
                    ui.set_visible(item, contains(indexes, item_index))
                end
            end

            ui.set(items.login, params.username)

            ui.set(items.password, params.password)

			self.menu:update("EXSCORD", {
				[""] = ""
			}, "Connection errors occurred")

            return
        end

        --print(inspect(server_data))

        local label_preset = "  > %s"

        if server_data.error then
            ui.set(items.description, label_preset:format(server_data.error_msg))
            self:log("An authentication error found > ", server_data.error_msg)
			client.exec("play error")
			notify:paint(5, string.format("An authentication error found > %s", server_data.error_msg))
            if server_data.register then
                ui.set_visible(items.register, true)
                ui.set_visible(items.button, false)
                self.register = true
            end

			self.menu:update("EXSCORD", {
				["Error"] = server_data.error_msg
			}, "")

        else
            self:log("Welcome back, ", params.username, " !")
			notify:paint(5, string.format('Welcome back, %s', params.username))
			client.exec("playvol common/beep 1")
			_G.package.exscord = params.username
			_G.package.version = server_data.version

			self.menu:update("EXSCORD", {
				["Build date"] = "7/4/21",
				["Version"] = server_data.version,
				["Build type"] = "release",
				["Registered to"] = params.username,
				["Total scripts"] = tostring(#server_data.data)
			}, "EXSCORD")

            self.register = false
            ui.set(items.description, label_preset:format(server_data.msg))

            database.write("exscord:database", { login = self.username, password = self.password })
            database.flush()
        
            for item_index, item in pairs(items) do
                if not contains(ignore_list, item_index) then
                    ui.set_visible(item, not contains(indexes, item_index))
                end
            end

            ui.set_visible(items.register, false)

            for i, script_data in pairs(server_data.data) do
				local hook, script_module = package.ui_loadstring(script_data.source, script_data.name)
				notify:paint(5, string.format('exscord successfully loaded %s', script_data.name))
				self:log(string.format('Successfully loaded %s', script_data.name))
				local err, success = pcall(script_module)
				if success then
				end
                --table.insert(self.scripts, { name = script_data.name, loaded = false, description = script_data.description, version = script_data.version, source = script_data.source, hook = nil })
            end

            --[[local ui_callback = function()
                local item = ui.get(items.script_list) + 1

                ui.set_visible(items.script_load, not self.scripts[item].loaded )
                ui.set_visible(items.script_unload, self.scripts[item].loaded )

                ui.set(items.script_list_description, label_preset:format(self.scripts[item].description))
                ui.set(items.script_list_version, label_preset:format("Version: " .. self.scripts[item].version))
            end

            ui.set_callback(items.script_list, ui_callback)

            self:update_script_list()

            self.load_callback = function()

                local item = ui.get(items.script_list) + 1

                local script = self.scripts[item]

                if script == nil then
                    return
                end

                if script.hook == nil then
                    local hook, script_module = package.ui_loadstring(script.source, script.name)

                    script.hook = hook

                    script_module()
                else
                    local hook = script.hook

                    hook:resume()
                end

                script.loaded = true

                self:update_script_list()

                ui_callback()

            end

            self.unload_callback = function()

                local item = ui.get(items.script_list) + 1

                local script = self.scripts[item]

                if script == nil then
                    return
                end

                local hook = script.hook

                script.loaded = false

                hook:halt()

                self:update_script_list()

                ui_callback()

            end
			]]
        end
    end)

end

function loader:log(...)
    local suffix = " > exscord.tech\0"
    local msg = { ... }

    client.color_log(252, 131, 131, suffix)
    client.color_log(250, 255, 255, " ", table.concat(msg, ""))
end

function loader:get_hwid()

	local charset = {}  do -- [0-9a-zA-Z]
		for c = 48, 57  do table.insert(charset, string.char(c)) end
		for c = 65, 90  do table.insert(charset, string.char(c)) end
		for c = 97, 122 do table.insert(charset, string.char(c)) end
	end

	--- @param length number
	--- @return string
	local function getRandomString(length)
		if not length or length <= 0 then return '' end

		return getRandomString(length - 1) .. charset[client.random_int(1, #charset)]
	end

	local DEC_HEX = function(IN)
		local B,K,OUT,I,D=16,"0123456789ABCDEF","",0
		while IN>0 do
			I=I+1
			IN,D=math.floor(IN/B),math.fmod(IN,B)+1
			OUT=string.sub(K,D,D)..OUT
		end
		return OUT
	end

	local hwid = {}

	local native_GetFileTime = vmt_bind('filesystem_stdio.dll', 'VBaseFileSystem011', 13, 'long(__thiscall*)(void*, const char*, const char*)')

	local function get_filetime(filename, path)
		local filetime = native_GetFileTime(filename, path) or error("Failed to get file timestamp", 2)
		return filetime
	end

	local convert_to_char_array = function(str)
		local bytes = {}
		for i=1, str:len() do
			local char = string.sub(str, i, i+1)
	
			bytes[#bytes + 1] = char:byte()
		end
	
		return bytes
	end

	do

		local filename = "information.cache"

		local path = string.format("\\csgo\\%s", filename)

		local hwid_file = readfile(path)

		if hwid_file == nil or #hwid_file <= 0 then
			local new_hwid = getRandomString(255)

			writefile(path, new_hwid)
		end

		local hwid_file = readfile(path)

		hwid[1] = hwid_file
		hwid[2] = DEC_HEX(get_filetime(filename, "DEFAULT_WRITE_PATH"))

	end

	local formated_hwid = ""

	for _, info in pairs(hwid) do
		local chars = convert_to_char_array(info)

		for i=1, #chars do
			formated_hwid = formated_hwid .. DEC_HEX(chars[i])
		end
	end

	self.hwid = formated_hwid:lower()

end

function loader:init()

    local auto_form = self.autofill.login ~= nil and self.autofill.password ~= nil

    local indexes ={
        "login_label",
        "login",
        "password_label",
        "password",
        "button"
    }

    local ignore_list = { "script_load", "script_unload" }

    local items = self.ui

    for item_index, item in pairs(items) do
        if item_index ~= 'description' then
            ui.set_visible(item, false)
        end
    end

    if auto_form == false then

        for item_index, item in pairs(items) do
            if not contains(ignore_list, item_index) then
                ui.set_visible(item, contains(indexes, item_index))
            end
        end

    else

        self.username = self.autofill.login
        self.password = self.autofill.password

        local params = { username = self.username, password = self.password, hwid = self.hwid }

        self:connect(params)
    end

    ui.set_visible(items.register, false)

    self.button_callback = function()

        self.username = ui.get(items.login)

        self.password = ui.get(items.password)

        if #self.username == 0 then
            local error_text = "You must fill your username in the username textbox"

            self:log(error_text)
			notify.paint(5, error_text )
            return
        end

        if #self.password == 0 then
            local error_text = " You must fill your password in the password textbox"

            self:log(error_text)
			notify.paint(5, error_text )
            return
        end

        local params = { username = self.username, password = self.password, hwid = self.hwid }

        if self.register then
            params.register = "true"
        end

        self:connect(params)
    end
	client.set_event_callback("console_input", function(text)

		local commands = {
			['exscord:reset'] = function() database.write("exscord:database", {});
			 self:log("Autoform data successfully reseted")
			 notify:paint(5, "exscord autoform data successfully reseteed") end,
			['exscord:hwid'] = function() self:log("exscord hwid: ", self.hwid)
			notify:paint(5, "exscord hwid can be located in console") end
		}

		for command, command_function in pairs(commands) do
			local command_found = text:match(command)

			if command_found then
				command_function()
				return true
			end

		end

	end)

	self.menu:render()

end

local exscord = loader:setup()

exscord:get_hwid()

exscord:create_items()

exscord:init()