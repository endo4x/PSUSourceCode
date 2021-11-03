--[[
	id: -2oRpm38juXQMzwrwR_Aj
	name: drug script
	description: as
	time1: 2021-06-27 17:49:50.891683+00
	time2: 2021-06-27 17:49:50.891684+00
	uploader: 9D26QYAXY-_KkpZ_WxiDk_5EAkt05vWY7Nrua9im
	uploadersession: F_LNUIWFcWnqZAzNEkB2-YOIrDEeDw
	flag: f
--]]

Config = {}

Config.Locale = 'en'

Config.Delays = {
	WeedProcessing = 1000 * 10,
	MethProcessing = 1000 * 10,
	CokeProcessing = 1000 * 10,
	lsdProcessing = 1000 * 10,
	HeroinProcessing = 1000 * 10,
	thionylchlorideProcessing = 1000 * 10,
}

Config.DrugDealerItems = {
	heroin = 140,
	marijuana = 180,
	meth = 220,
	coke = 260,
	lsd = 300,
}

Config.ChemicalsConvertionItems = {
	hydrochloric_acid = 0,
	sodium_hydroxide = 0,
	sulfuric_acid = 0,
	lsa = 0,
}

Config.ChemicalsLicenseEnabled = true --Will Enable or Disable the need for a Chemicals License.
Config.MoneyWashLicenseEnabled = false --Will Enable or Disable the need for a MoneyWash License.

Config.LicensePrices = {
	weed_processing = {label = _U('license_weed'), price = 15000}
}

Config.Licenses = {
	moneywash = 75000,
	chemicalslisence = 100000,
}

Config.GiveBlack = true -- give black money? if disabled it'll give regular cash.

Config.CircleZones = {
	--Weed
	WeedField = {coords = vector3(4783.5629882812, -5026.4799804688, 28.027303695679), name = _U('blip_WeedFarm'), color = 25, sprite = 496, radius = 100.0},
	WeedProcessing = {coords = vector3(2329.12, 2571.86, 46.68), name = _U('blip_weedprocessing'), color = 25, sprite = 496, radius = 100.0},
	
	--meth
	MethProcessing = {coords = vector3(1390.33, 3608.5, 38.94), name = _U('blip_methprocessing'), color = 25, sprite = 496, radius = 0.0},
	HydrochloricAcidFarm = {coords = vector3(2724.12, 1583.03, 24.5), name = _U('blip_HydrochloricAcidFarm'), color = 25, sprite = 496, radius = 7.0},
	SulfuricAcidFarm = {coords = vector3(3333.34, 5160.22, 18.31), name = _U('blip_SulfuricAcidFarm'), color = 25, sprite = 496, radius = 5.0},
	SodiumHydroxideFarm = {coords = vector3(3617.04, 3738.73, 28.69), name = _U('blip_SodiumHydroxideFarm'), color = 25, sprite = 496, radius = 7.0},
	
	--Chemicals
	ChemicalsField = {coords = vector3(-1153.2272949219, -485.3528137207, 54.207233428955), name = _U('blip_ChemicalsFarm'), color = 25, sprite = 496, radius = 0.0},
	ChemicalsConvertionMenu = {coords = vector3(3718.8, 4533.45, 21.67), name = _U('blip_ChemicalsProcessing'), color = 25, sprite = 496, radius = 0.0},
	
	--Coke
	CokeField = {coords = vector3(5514.8247070312, -5704.505859375, 19.748857498169), name = _U('blip_CokeFarm'), color = 25, sprite = 496, radius = 20.0},
	CokeProcessing = {coords = vector3(1689.14, 3291.36, 41.15), name = _U('blip_Cokeprocessing'),color = 25, sprite = 496, radius = 20.0},
	
	--LSD
	lsdProcessing = {coords = vector3(91.26, 3749.31, 40.77), name = _U('blip_lsdprocessing'),color = 25, sprite = 496, radius = 20.0},
	thionylchlorideProcessing = {coords = vector3(1903.98, 4922.70, 48.16), name = _U('blip_lsdprocessing'),color = 25, sprite = 496, radius = 20.0},
	
	--Heroin
	HeroinField = {coords = vector3(2561.1567382812, -1943.6022949219, 34.095962524414), name = _U('blip_heroinfield'), color = 25, sprite = 496, radius = 20},
	HeroinProcessing = {coords = vector3(-65.43, 6243.36, 31.08), name = _U('blip_heroinprocessing'), color = 25, sprite = 496, radius = 100.0},

	--Crafting
	
	Crafting = {coords = vector3(-1784.0812988281, 413.10760498047, 113.653175354), name = "Преработка", color = 6, sprite = 378, radius = 25.0},

	--License
	LicenseShop = {coords = vector3(707.17, -962.5, 30.4), name = _U('blip_lsdprocessing'),color = 25, sprite = 496, radius = 20.0},
	
	--MoneyWash
	MoneyWash = {coords = vector3(8.84, -1103.8, -29.8), name = _U('blip_drugdealer'), color = 6, sprite = 378, radius = 25.0},
}
