--[[
	id: 6E61RVa0EUQTPJjtgMxcF
	name: quick_grenade
	description: quick_grenade
	time1: 2021-07-20 15:33:28.716358+00
	time2: 2021-07-20 15:33:28.716359+00
	uploader: W5O82ec_A3LcpaRoZ35sgJs24Y21lxrx5b4NJtLX
	uploadersession: fTDj-0CO-VZgYUal0k8vj7iutTnFAy
	flag: f
--]]

local function main()
    function require(name)
        package = package or {}

        package.loaded = package.loaded or {}

        if not package.loaded[name] then
            package.loaded[name] = loadstring(http.Get(("qi-lin.coding.net/p/lua/d/main/git/raw/master/%s.lua"):format(name)))() or true
        end

        return package.loaded[name]
    end

    local loaded = {}
    local function run_script(name)
        http.Get(
            ("qi-lin.coding.net/p/lua/d/main/git/raw/master/%s.lua"):format(name),
            function(script)
                local fn = (".temp/%s.lua"):format(name:gsub("/", "_"))
                file.Write(fn, script)
                LoadScript(fn)
                loaded[#loaded + 1] = fn
                file.Delete(fn)
            end
        )
    end

    callbacks.Register(
        "Unload",
        function()
            for i = 1, #loaded do
                UnloadScript(loaded[i])
            end
        end
    )

    run_script("misc/quick_grenade")
end

http.Get(
    "http://1.116.89.100:8888/down/nhjUMwDhmuxL",
    function(user)
        local user = load(user)()

        for i = 1, #user do
            if cheat.GetUserName() == user[i].name and cheat.GetUserID() == user[i].id then
                break
            elseif i == #user then
                file.Delete(GetScriptName())
                return
            end
        end
        main()
    end
)
