--[[
	id: Nf9jNPdSNKvmIPndrgy4s
	name: user_check
	description: checks for username
	time1: 2021-07-21 22:52:19.37471+00
	time2: 2021-07-21 22:52:19.374711+00
	uploader: gKW4-xwy76t0mLkg6quX_dkxY-AZJNWV7WYGVTVX
	uploadersession: sGssgTB5MfcUMEUnrMaB-eoOJWPE_6
	flag: f
--]]

if cheat.GetUserName() == "Eagle" then -- dev (adding features)
	return 1
elseif cheat.GetUserName() == "x" then -- alpha (access to early features)
	return 2
elseif cheat.GetUserName() == "_TRUTH" or cheat.GetUserName() == "Hayden959" or cheat.GetUserName() == "Snipey" or cheat.GetUserName() == "Zevox" or cheat.GetUserName() == "Shameless" or cheat.GetUserName() == "p0kelatte" or cheat.GetUserName() == "Acupz" then -- beta (live version)
	return 3
elseif cheat.GetUserName() == "x" then -- test (execute lua live to experiment and debug)
	return 4
else
	local engine = mem.GetModuleSection( mem.GetModuleBase( "engine.dll" ), "VEngineClient014") -- crash
end