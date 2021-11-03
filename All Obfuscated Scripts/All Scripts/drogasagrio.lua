--[[
	id: pVTsShYiqw4TLuFov6Ks-
	name: drogas agrio
	description: drugs
	time1: 2021-07-22 18:47:06.100159+00
	time2: 2021-07-22 18:47:06.10016+00
	uploader: VVNt0cj-hz2CH5jkESZw-kkH85LAm5IYdVDsmdWe
	uploadersession: 8Jd9DLXQYEfzu5DDIJNeydUIF5Nmsi
	flag: f
--]]

Config = {}

Config.Locale = 'es'

Config.Delays = {
	WeedProcessing = 1000 * 10,
	MethProcessing = 1000 * 10,
	CokeProcessing = 1000 * 10,
	lsdProcessing = 1000 * 10,
	HeroinProcessing = 1000 * 10,
	thionylchlorideProcessing = 1000 * 10,
}

Config.DrugDealerItems = {
	heroin = math.random(70,220),
	marijuana = math.random(300,530),
	meth = math.random(279,330),
	coke = math.random(400,830),
	lsd = math.random(350,630),
}

Config.ChemicalsConvertionItems = {
	hydrochloric_acid = 0,
	sodium_hydroxide = 0,
	sulfuric_acid = 0,
	lsa = 0,
}

Config.ChemicalsLicenseEnabled = false --Will Enable or Disable the need for a Chemicals License.
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
	WeedField = {coords = vector3(2326.54, 6643.53, 5.45), name = _U('blip_WeedFarm'), color = 25, sprite = 496, radius = 100.0},
	WeedProcessing = {coords = vector3(-2511.42, 3616.06, 13.68), name = _U('blip_weedprocessing'), color = 25, sprite = 496, radius = 100.0},
	
	--methvector3(397.24, -1103.84, -104.94),
	--WIPE--MethProcessing = {coords = vector3(397.24, -1103.84, -104.94), name = _U('blip_methprocessing'), color = 25, sprite = 496, radius = 0.0},
	--WIPE--HydrochloricAcidFarm = {coords = vector3(397.24, -1103.84, -104.94), name = _U('blip_HydrochloricAcidFarm'), color = 25, sprite = 496, radius = 7.0},

	--SulfuricAcidFarm = {coords = vector3(3333.34, 5160.22, 18.31), name = _U('blip_SulfuricAcidFarm'), color = 25, sprite = 496, radius = 7.0},
	--WIPE--SulfuricAcidFarm = {coords = vector3(397.24, -1103.84, -104.94), name = _U('blip_SulfuricAcidFarm'), color = 25, sprite = 496, radius = 7.0},

	--SodiumHydroxide
	--WIPE--SodiumHydroxideFarm = {coords = vector3(397.24, -1103.84, -104.94), name = _U('blip_SodiumHydroxideFarm'), color = 25, sprite = 496, radius = 7.0},
	
	--Chemicals
	ChemicalsField = {coords = vector3(-555.28, 5322.46, 73.6), name = _U('blip_ChemicalsFarm'), color = 25, sprite = 496, radius = 7.0},
	ChemicalsConvertionMenu = {coords = vector3(752.51, 4174.92, 40.08), name = _U('blip_ChemicalsProcessing'), color = 25, sprite = 496, radius = 7.0},
	
	--Coke
	CokeField = {coords = vector3(227.26, 7415.05, 18.68), name = _U('blip_CokeFarm'), color = 25, sprite = 496, radius = 20.0},
	CokeProcessing = {coords = vector3(3540.64, 3676.01, 20.93), name = _U('blip_Cokeprocessing'),color = 25, sprite = 496, radius = 15.0},
	
	--LSD
	lsdProcessing = {coords = vector3(1011.46, -2895.51, 39.17), name = _U('blip_lsdprocessinds'),color = 25, sprite = 496, radius = 20.0},
	--WIPE--thionylchlorideProcessing = {coords = vector3(1903.98, 4922.70, 48.16), name = _U('blip_lsdprocessing'),color = 25, sprite = 496, radius = 20.0},
	
	--Heroin
	HeroinField = {coords = vector3(3471.66, 2589.45, 15.8), name = _U('blip_heroinfield'), color = 25, sprite = 496, radius = 20},
	HeroinProcessing = {coords = vector3(3726.92, 4539.89, 21.81), name = _U('blip_heroinprocessing'), color = 25, sprite = 496, radius = 100.0},

	--Weed
	--WeedField = {coords = vector3(538.94, 5765.93, 662.45), name = _U('blip_WeedFarm'), color = 25, sprite = 496, radius = 100.0},
	--WeedProcessing = {coords = vector3(-2511.42, 3616.06, 13.68), name = _U('blip_weedprocessing'), color = 25, sprite = 496, radius = 100.0},

	--DrugDealer
	DrugDealer = {coords = vector3(3088.44, -4691.63, 27.21), name = _U('blip_drugdealer'), color = 6, sprite = 378, radius = 25.0},
	
	--License
	--WIPE--LicenseShop = {coords = vector3(707.17, -962.5, 30.4), name = _U('blip_lsdprocessing'),color = 25, sprite = 496, radius = 20.0},
	
	--MoneyWash
	--WIPE--MoneyWash = {coords = vector3(1131.35, -3196.62, -39.67), name = _U('blip_drugdealer'), color = 6, sprite = 378, radius = 25.0},
}
