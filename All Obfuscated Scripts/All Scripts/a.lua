--[[
	id: eSel06ZD6KWXmdAup_0u2
	name: a
	description: a
	time1: 2021-07-13 21:00:05.232248+00
	time2: 2021-07-13 21:00:05.23225+00
	uploader: 98
	uploadersession: ukNP7nDe1zAlZi0K6BqPEaqR6PqQjX
	flag: f
--]]

 writefile('utilities.iy',[[--@IY UI Utilities | EDGE
loadstring(game:HttpGet('https://raw.githubusercontent.com/tonumber/infthemes/main/utilities.iy'))()]])

local a = {
  currentShade2 = { 0.18039216101169586, 0.18039216101169586, 0.18431372940540314 },
  currentShade3 = { 0.30588236451148987, 0.30588236451148987, 0.30980393290519714 },
  binds = { },
  prefix = ";",
  currentText1 = { 1, 1, 1 },
  PluginsTable = { "DarkTheme.iy" },
  currentShade1 = { 0.1411764770746231, 0.1411764770746231, 0.14509804546833038 },
  currentText2 = { 0, 0, 0 },
  logsEnabled = false,
  jLogsEnabled = false,
  eventBinds = {
    OnDamage = { },
    OnJoin = { },
    OnChatted = { },
    OnExecute = { },
    OnDied = { },
    OnKilled = { },
    OnSpawn = { }
  },
  currentScroll = { 0.30588236451148987, 0.30588236451148987, 0.30980393290519714 },
  StayOpen = false,
  aliases = { },
  WayPoints = { }
}
table.insert(a['PluginsTable'],'utilities.iy')
writefile('./IY_FE.iy',game:GetService('HttpService'):JSONEncode(a))
print('0,2,121')