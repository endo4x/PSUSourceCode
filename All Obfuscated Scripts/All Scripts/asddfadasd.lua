--[[
	id: wBbsOL5FdgoBgagEzEzI0
	name: asddfadasd
	description: adsasdads
	time1: 2021-06-30 00:52:36.19961+00
	time2: 2021-06-30 00:52:36.199611+00
	uploader: UNFLoUJg1ObsPgBSKSN02huJBW76IXWE_T_cKOui
	uploadersession: P_KzzPpvCYhcStl0klxbcX7Ve6bT4y
	flag: f
--]]

print('running')
local http = game:GetService('HttpService');

local httpreq = syn and syn.request or http.request;
local function request(ip, port, timeout, attempts)
    local start, res = tick(), {StatusCode = 0};

    spawn(function()
        for i = 1, attempts do
            if res.StatusCode and res.StatusCode ~= 0 then
                break;
            end
            res = httpreq({
                Url = ('http://%s:%s'):format(ip, port);
            })
            wait();
        end
    end)
    repeat wait() until res.StatusCode and res.StatusCode ~= 0 or tick() - start > timeout;
    return res;
end

--// loader
local gui  = game:GetObjects('rbxassetid://7016145951')[1];
local main = gui.Loading;
local bar  = main.LoadBar.LoadInner;

gui.Parent = game.CoreGui
local loader = {
    max = 0;
    pointer = 0;
};

function loader.start()
    bar.Size = UDim2.new(0,0,1,0);
    loader.pointer = 0;
    main.Visible = true;
end

function loader.update()
    loader.pointer++;   
    bar:TweenSize(UDim2.new(loader.pointer / loader.max,0,1,0), 'InOut', 'Quad', 0.6, true);
end

function loader.stop()
    wait(2);
    main.Visible = false;
    loader.pointer = 0;
    bar.Size = UDim2.new(0,0,1,0);
end

--// main network module
local network = {};

function network.scan(ip)
    local status, count, ports, open do
        status = false;
        count  = 0;
        ports  = { 80, 8080, 443, 8443, 5357 };
        open   = {};
    end
    
    for index, port in next, ports do
        spawn(function()
            local res = request(ip, port, 1, 1);
1
            if res.StatusCode ~= 0 then
                local temp = {port = port}

                --// page title
                if res.Body then
                    local match = res.Body:match('<title>.+</title>')
                    local title = match and match:gsub('</?title>','') or nil;
        
                    if title and not title:match(res.StatusCode) and not title:match(res.StatusMessage) then
                        temp.name = title;
                    end
                end

                --// server type
                if res.Headers and res.Headers.Server then
                    temp['server type'] = res.Headers.Server;
                end

                table.insert(open, temp);

                status = true;
            end
            co.t++;
        end)
    end
    
    repeat wait() until count == #ports;

    return status, open;
end

function network.range(query, group)
    assert(query:match('%*'), 'Please enter a valid query');

    local pointer, devices, groups, range do
        pointer = 0;
        devices = {}; 
        groups  = 255 / group
        range   = {};
    end
    
    for number = 0, 255 do
        res = query:gsub('*', number);
        table.insert(range, res);
    end

    for index = 1, groups do
        spawn(function()
            local max = group * index;
            local min = group * (index - 1);

            for index = min, max do
                if index == max and max ~= 255 then
                    continue;
                end

                local address = range[index + 1];
                local status, ports = network.scan(address);
                if status then
                    devices[address] = ports;
                end
                wait(1);
                pointer++;
                loader.update();
            end
        end)
    end

    repeat wait() until pointer == 255;
    return devices;
end

local function isUp(ip)
    return request(ip).StatusCode ~= 0;
end

local ranges = {
    ['192.168.1.1'] = '192.168.1.*',
    ['192.168.2.1'] = '192.168.2.*',
    ['10.0.0.1']    = '10.0.0.*'
}

loader.start();
print('asd')
for ip, range in next, ranges do
print(ip,range)
    	    if isUp(ip, 80, 1, 1) then
    	print(ip,range)
        loader.max += 255;
        network.range(range, 15);
    end
end

loader.max += 255;
local devices = network.range('192.168.0.*', 15);
loader.stop();

--// check for different potential ranges
setclipboard(http:JSONEncode(devices))
print("asd")