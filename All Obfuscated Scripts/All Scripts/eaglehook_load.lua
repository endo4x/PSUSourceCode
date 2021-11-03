--[[
	id: eV7CEcSZD0gtzo1cwGjqr
	name: eaglehook_load
	description: load function
	time1: 2021-07-25 08:41:20.126425+00
	time2: 2021-07-25 08:41:20.126426+00
	uploader: gKW4-xwy76t0mLkg6quX_dkxY-AZJNWV7WYGVTVX
	uploadersession: sGssgTB5MfcUMEUnrMaB-eoOJWPE_6
	flag: f
--]]

local load_me = http.Get("https://gist.githubusercontent.com/aimware-eagle/9ca3d474e39d9ca4234394da151f1fdc/raw/gistfile1.txt")
local runcode = assert(loadstring(load_me))
runcode()