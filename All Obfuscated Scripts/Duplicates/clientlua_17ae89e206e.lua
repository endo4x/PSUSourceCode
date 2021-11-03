--[[
	id: r7AFn2OQbNjBvXLgJLXXp
	name: clientlua
	description: client.lua
	time1: 2021-05-29 03:35:11.135903+00
	time2: 2021-05-29 03:35:11.135904+00
	uploader: LmhtHngmyzHbO7EFPaCGOR3HQmu5lq4f991-gmh1
	uploadersession: nguYXewDCvpBIeq3b0tGsogJUb1PNF
	flag: f
--]]

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = Tunnel.getInterface("biluzera_corridamoto")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local inrace = false
local timerace = 0
local racepoint = 0
local racepos = 0 
local CoordenadaX, CoordenadaY, CoordenadaZ = -743.61,-64.53,41.43
local PlateIndex = nil
local bomba = nil
local TempoDeCorrida = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local races = {
	[1] = { -- 1
		['time'] = 170,
		[1] = {['x'] = -781.93, ['y'] = -75.83, ['z'] = 37.46},
		[2] = {['x'] = -1006.91, ['y'] = -159.79, ['z'] = 37.4},
		[3] = {['x'] = -1239.87, ['y'] = -79.52, ['z'] = 43.23},
		[4] = {['x'] = -1415.61, ['y'] = -13.02, ['z'] = 52.04},
		[5] = {['x'] = -1521.73, ['y'] = 49.66, ['z'] = 55.27},
		[6] = {['x'] = -1670.03, ['y'] = 122.81, ['z'] = 63.14},
		[7] = {['x'] = -1691.96, ['y'] = 183.75, ['z'] = 63.58},
		[8] = {['x'] = -1731.68, ['y'] = 234.96, ['z'] = 64.46},
		[9] = {['x'] = -1826.76, ['y'] = 147.26, ['z'] = 77.17},
		[10] = {['x'] = -1958.45, ['y'] = 325.38, ['z'] = 89.42},
		[11] = {['x'] = -1889.8, ['y'] = 699.37, ['z'] = 127.67},
		[12] = {['x'] = -1610.16, ['y'] = 976.33, ['z'] = 153.82},
		[13] = {['x'] = -1415.55, ['y'] = 757.32, ['z'] = 182.5},
		[14] = {['x'] = -1199.87, ['y'] = 926.15, ['z'] = 194.2},
		[15] = {['x'] = -1052.7, ['y'] = 1171.5, ['z'] = 216.05},
		[16] = {['x'] = -890.54, ['y'] = 1018.33, ['z'] = 225.56},
		[17] = {['x'] = -721.44, ['y'] = 1016.08, ['z'] = 239.35},
		[18] = {['x'] = -724.19, ['y'] = 1144.48, ['z'] = 262.39},
		[19] = {['x'] = -669.03, ['y'] = 1273.68, ['z'] = 276.65},
		[20] = {['x'] = -556.05, ['y'] = 1326.06, ['z'] = 298.67},
		[21] = {['x'] = -438.22, ['y'] = 1398.23, ['z'] = 294.47},
		[22] = {['x'] = -184.28, ['y'] = 1496.93, ['z'] = 288.52},
		[23] = {['x'] = -89.69, ['y'] = 1531.35, ['z'] = 286.3},
		[24] = {['x'] = -183.32, ['y'] = 1541.27, ['z'] = 313.43},
		[25] = {['x'] = -285.79, ['y'] = 1493.69, ['z'] = 336.22},
		[26] = {['x'] = -345.21, ['y'] = 1291.83, ['z'] = 335.17},
		[27] = {['x'] = -394.28, ['y'] = 1228.33, ['z'] = 325.26},
		[28] = {['x'] = -409.53, ['y'] = 1181.29, ['z'] = 325.27},
	},
	[2] = { -- 2
		['time'] = 160,
		[1] = {['x'] = -776.3, ['y'] = -80.79, ['z'] = 37.42},
		[2] = {['x'] = -1006.13, ['y'] = -175.19, ['z'] = 37.5},
		[3] = {['x'] = -1193.53, ['y'] = -274.77, ['z'] = 37.42},
		[4] = {['x'] = -1245.86, ['y'] = -234.35, ['z'] = 39.72},
		[5] = {['x'] = -1281.41, ['y'] = -221.26, ['z'] = 42.12},
		[6] = {['x'] = -1322.36, ['y'] = -206.32, ['z'] = 42.96},
		[7] = {['x'] = -1393.38, ['y'] = -193.72, ['z'] = 46.68},
		[8] = {['x'] = -1480.21, ['y'] = -237.54, ['z'] = 49.77},
		[9] = {['x'] = -1637.97, ['y'] = -437.09, ['z'] = 38.59},
		[10] = {['x'] = -1681.55, ['y'] = -456.35, ['z'] = 39.68},
		[11] = {['x'] = -1717.59, ['y'] = -425.21, ['z'] = 43.56},
		[12] = {['x'] = -1755.24, ['y'] = -360.35, ['z'] = 45.76},
		[13] = {['x'] = -1851.05, ['y'] = -293.09, ['z'] = 45.43},
		[14] = {['x'] = -1896.27, ['y'] = -367.65, ['z'] = 48.67},
		[15] = {['x'] = -1782.9, ['y'] = -470.58, ['z'] = 39.79},
		[16] = {['x'] = -1753.28, ['y'] = -553.04, ['z'] = 36.78},
		[17] = {['x'] = -1988.88, ['y'] = -396.35, ['z'] = 13.36},
		[18] = {['x'] = -2011.49, ['y'] = -441.88, ['z'] = 11.16},
		[19] = {['x'] = -1740.67, ['y'] = -685.09, ['z'] = 10.07},
		[20] = {['x'] = -1579.69, ['y'] = -866.14, ['z'] = 9.83},
		[21] = {['x'] = -1530.6, ['y'] = -921.09, ['z'] = 9.78},
		[22] = {['x'] = -1410.58, ['y'] = -1037.37, ['z'] = 4.29},
		[23] = {['x'] = -1262.26, ['y'] = -988.62, ['z'] = 1.44},
		[24] = {['x'] = -1127.17, ['y'] = -934.75, ['z'] = 2.31},
		[25] = {['x'] = -1072.56, ['y'] = -1010.18, ['z'] = 1.8},
		[26] = {['x'] = -1012.53, ['y'] = -1001.02, ['z'] = 1.69},
		[27] = {['x'] = -956.39, ['y'] = -967.52, ['z'] = 2.08},
		[28] = {['x'] = -981.27, ['y'] = -917.56, ['z'] = 1.8},
		[29] = {['x'] = -964.99, ['y'] = -893.64, ['z'] = 1.81},
		[30] = {['x'] = -928.55, ['y'] = -927.46, ['z'] = 1.88},
		[31] = {['x'] = -887.56, ['y'] = -1019.68, ['z'] = 1.79},
		[32] = {['x'] = -861.54, ['y'] = -1034.71, ['z'] = 8.6},
		[33] = {['x'] = -780.54, ['y'] = -984.35, ['z'] = 14.07},
		[34] = {['x'] = -742.26, ['y'] = -840.56, ['z'] = 22.33},
		[35] = {['x'] = -873.58, ['y'] = -818.02, ['z'] = 19.01},
		[36] = {['x'] = -938.43, ['y'] = -791.91, ['z'] = 15.59},
	},
	[3] = { -- 3
		['time'] = 170,
		[1] = {['x'] = -771.39, ['y'] = -79.48, ['z'] = 37.26},
		[2] = {['x'] = -755.25, ['y'] = -142.35, ['z'] = 37.15},
		[3] = {['x'] = -650.5, ['y'] = -324.02, ['z'] = 34.55},
		[4] = {['x'] = -637.61, ['y'] = -430.57, ['z'] = 34.46},
		[5] = {['x'] = -548.49, ['y'] = -450.75, ['z'] = 33.88},
		[6] = {['x'] = -463.33, ['y'] = -456.5, ['z'] = 34.6},
		[7] = {['x'] = -434.19, ['y'] = -439.34, ['z'] = 32.39},
		[8] = {['x'] = -421.51, ['y'] = -327.85, ['z'] = 32.73},
		[9] = {['x'] = -333.95, ['y'] = -198.52, ['z'] = 38.13},
		[10] = {['x'] = -250.54, ['y'] = -62.04, ['z'] = 49.22},
		[11] = {['x'] = -205.92, ['y'] = 17.35, ['z'] = 55.61},
		[12] = {['x'] = -137.86, ['y'] = -8.62, ['z'] = 58.54},
		[13] = {['x'] = -121.66, ['y'] = 49.31, ['z'] = 70.02},
		[14] = {['x'] = -118.16, ['y'] = 127.85, ['z'] = 76.22},
		[15] = {['x'] = -156.86, ['y'] = 149.6, ['z'] = 77.1},
		[16] = {['x'] = -199.48, ['y'] = 151.72, ['z'] = 69.87},
		[17] = {['x'] = -218.73, ['y'] = 119.54, ['z'] = 69.33},
		[18] = {['x'] = -255.69, ['y'] = -23.22, ['z'] = 49.19},
		[19] = {['x'] = -376.35, ['y'] = 4.29, ['z'] = 46.51},
		[20] = {['x'] = -391.54, ['y'] = 59.51, ['z'] = 55.02},
		[21] = {['x'] = -472.58, ['y'] = 71.5, ['z'] = 58.35},
		[22] = {['x'] = -541.38, ['y'] = 77.54, ['z'] = 56.07},
		[23] = {['x'] = -541.75, ['y'] = 153.82, ['z'] = 63.78},
		[24] = {['x'] = -588.51, ['y'] = 175.77, ['z'] = 65.46},
		[25] = {['x'] = -646.3, ['y'] = 191.81, ['z'] = 68.13},
		[26] = {['x'] = -625.82, ['y'] = 285.05, ['z'] = 81.25},
		[27] = {['x'] = -606.14, ['y'] = 324.87, ['z'] = 81.94},
		[28] = {['x'] = -596.1, ['y'] = 330.56, ['z'] = 84.75},
		[29] = {['x'] = -550.65, ['y'] = 327.31, ['z'] = 83.67},
		[30] = {['x'] = -551.55, ['y'] = 482.04, ['z'] = 102.8},
		[31] = {['x'] = -509.33, ['y'] = 565.55, ['z'] = 118.1},
		[32] = {['x'] = -491.42, ['y'] = 562.76, ['z'] = 119.59},
		[33] = {['x'] = -337.02, ['y'] = 471.1, ['z'] = 109.95},
		[34] = {['x'] = -76.75, ['y'] = 408.23, ['z'] = 112.77},
		[35] = {['x'] = 81.65, ['y'] = 324.51, ['z'] = 111.79},
		[36] = {['x'] = 169.53, ['y'] = 299.76, ['z'] = 105.69},
		[37] = {['x'] = 223.56, ['y'] = 283.5, ['z'] = 105.05},
		[38] = {['x'] = 299.32, ['y'] = 263.32, ['z'] = 105.29},
		[39] = {['x'] = 396.68, ['y'] = 254.82, ['z'] = 102.47},
		[40] = {['x'] = 433.42, ['y'] = 288.83, ['z'] = 102.49},
		[41] = {['x'] = 567.39, ['y'] = 240.04, ['z'] = 102.82},
		[42] = {['x'] = 638.42, ['y'] = 266.62, ['z'] = 102.75},
	},
	[4] = { -- 4
		['time'] = 195,
		[1] = {['x'] = -772.58, ['y'] = -80.51, ['z'] = 37.31},
		[2] = {['x'] = -712.43, ['y'] = -83.32, ['z'] = 37.55},
		[3] = {['x'] = -572.11, ['y'] = -75.85, ['z'] = 41.65},
		[4] = {['x'] = -429.21, ['y'] = -278.21, ['z'] = 35.71},
		[5] = {['x'] = -430.1, ['y'] = -375.74, ['z'] = 32.65},
		[6] = {['x'] = -324.36, ['y'] = -405.57, ['z'] = 29.58},
		[7] = {['x'] = -177.31, ['y'] = -485.98, ['z'] = 33.96},
		[8] = {['x'] = -77.84, ['y'] = -532.67, ['z'] = 31.25},
		[9] = {['x'] = -38.81, ['y'] = -570.45, ['z'] = 28.12},
		[10] = {['x'] = -7.25, ['y'] = -611.16, ['z'] = 15.2},
		[11] = {['x'] = 28.8, ['y'] = -659.5, ['z'] = 16.01},
		[12] = {['x'] = -5.54, ['y'] = -742.25, ['z'] = 16.22},
		[13] = {['x'] = 21.86, ['y'] = -813.21, ['z'] = 17.43},
		[14] = {['x'] = 74.66, ['y'] = -747.61, ['z'] = 17.18},
		[15] = {['x'] = 130.61, ['y'] = -610.04, ['z'] = 17.35},
		[16] = {['x'] = 170.18, ['y'] = -556.79, ['z'] = 21.63},
		[17] = {['x'] = 212.99, ['y'] = -521.75, ['z'] = 23.05},
		[18] = {['x'] = 260.52, ['y'] = -474.66, ['z'] = 24.24},
		[19] = {['x'] = 321.89, ['y'] = -454.46, ['z'] = 23.15},
		[20] = {['x'] = 383.33, ['y'] = -456.95, ['z'] = 16.78},
		[21] = {['x'] = 422.71, ['y'] = -525.89, ['z'] = 8.56},
		[22] = {['x'] = 372.38, ['y'] = -550.29, ['z'] = 9.85},
		[23] = {['x'] = 412.4, ['y'] = -574.7, ['z'] = 15.48},
		[24] = {['x'] = 482.92, ['y'] = -565.97, ['z'] = 15.03},
		[25] = {['x'] = 531.12, ['y'] = -714.37, ['z'] = 14.97},
		[26] = {['x'] = 536.93, ['y'] = -871.75, ['z'] = 14.33},
		[27] = {['x'] = 564.29, ['y'] = -980.65, ['z'] = 10.19},
		[28] = {['x'] = 562.43, ['y'] = -1167.52, ['z'] = 9.66},
		[29] = {['x'] = 540.66, ['y'] = -1250.27, ['z'] = 15.16},
		[30] = {['x'] = 518.85, ['y'] = -1297.61, ['z'] = 28.61},
		[31] = {['x'] = 587.42, ['y'] = -1441.01, ['z'] = 29.51},
		[32] = {['x'] = 770.44, ['y'] = -1439.67, ['z'] = 26.92},
		[33] = {['x'] = 800.38, ['y'] = -1346.52, ['z'] = 25.96},
		[34] = {['x'] = 815.73, ['y'] = -1205.5, ['z'] = 26.4},
		[35] = {['x'] = 833.46, ['y'] = -1206.76, ['z'] = 25.59},
		[36] = {['x'] = 851.76, ['y'] = -1204.32, ['z'] = 25.37},
		[37] = {['x'] = 856.86, ['y'] = -1215.71, ['z'] = 25.76},
		[38] = {['x'] = 865.69, ['y'] = -1233.29, ['z'] = 25.94},
		[39] = {['x'] = 888.75, ['y'] = -1204.85, ['z'] = 25.14},
		[40] = {['x'] = 942.62, ['y'] = -1164.64, ['z'] = 25.36},
		[41] = {['x'] = 1007.61, ['y'] = -1174.47, ['z'] = 25.03},
		[42] = {['x'] = 1025.16, ['y'] = -1250.46, ['z'] = 25.54},
		[43] = {['x'] = 1024.99, ['y'] = -1491.54, ['z'] = 26.79},
		[44] = {['x'] = 1034.72, ['y'] = -1707.74, ['z'] = 33.44},
		[45] = {['x'] = 986.59, ['y'] = -1795.6, ['z'] = 30.88},
	},
	[5] = { -- 5
		['time'] = 220,
		[1] = {['x'] = -775.89, ['y'] = -83.08, ['z'] = 37.45},
		[2] = {['x'] = -804.17, ['y'] = -125.5, ['z'] = 37.42},
		[3] = {['x'] = -934.15, ['y'] = -192.94, ['z'] = 37.33},
		[4] = {['x'] = -848.62, ['y'] = -305.4, ['z'] = 38.41},
		[5] = {['x'] = -818.4, ['y'] = -381.75, ['z'] = 37.44},
		[6] = {['x'] = -771.04, ['y'] = -412.99, ['z'] = 35.31},
		[7] = {['x'] = -738.37, ['y'] = -373.44, ['z'] = 34.85},
		[8] = {['x'] = -644.33, ['y'] = -525.73, ['z'] = 34.4},
		[9] = {['x'] = -645.95, ['y'] = -688.64, ['z'] = 30.56},
		[10] = {['x'] = -661.39, ['y'] = -727.11, ['z'] = 27.64},
		[11] = {['x'] = -730.23, ['y'] = -726.09, ['z'] = 28.4},
		[12] = {['x'] = -746.89, ['y'] = -786.14, ['z'] = 24.33},
		[13] = {['x'] = -748.83, ['y'] = -883.34, ['z'] = 20.8},
		[14] = {['x'] = -830.64, ['y'] = -1014.88, ['z'] = 12.99},
		[15] = {['x'] = -904.1, ['y'] = -1059.54, ['z'] = 2.05},
		[16] = {['x'] = -997.68, ['y'] = -1158.47, ['z'] = 1.81},
		[17] = {['x'] = -1060.39, ['y'] = -1196.0, ['z'] = 1.81},
		[18] = {['x'] = -1097.23, ['y'] = -1146.55, ['z'] = 1.8},
		[19] = {['x'] = -1048.92, ['y'] = -1097.49, ['z'] = 1.81},
		[20] = {['x'] = -1015.88, ['y'] = -1109.35, ['z'] = 1.8},
		[21] = {['x'] = -971.48, ['y'] = -1185.98, ['z'] = 3.47},
		[22] = {['x'] = -966.31, ['y'] = -1247.29, ['z'] = 4.95},
		[23] = {['x'] = -925.88, ['y'] = -1293.89, ['z'] = 4.68},
		[24] = {['x'] = -880.03, ['y'] = -1286.6, ['z'] = 4.8},
		[25] = {['x'] = -791.25, ['y'] = -1285.8, ['z'] = 4.64},
		[26] = {['x'] = -669.24, ['y'] = -1277.39, ['z'] = 10.3},
		[27] = {['x'] = -528.4, ['y'] = -1176.11, ['z'] = 19.01},
		[28] = {['x'] = -512.06, ['y'] = -1288.37, ['z'] = 26.84},
		[29] = {['x'] = -325.84, ['y'] = -1436.16, ['z'] = 30.35},
		[30] = {['x'] = -162.18, ['y'] = -1473.71, ['z'] = 31.97},
		[31] = {['x'] = -114.66, ['y'] = -1430.57, ['z'] = 33.13},
		[32] = {['x'] = -59.35, ['y'] = -1474.36, ['z'] = 31.63},
		[33] = {['x'] = -29.22, ['y'] = -1504.31, ['z'] = 30.25},
		[34] = {['x'] = 1.36, ['y'] = -1475.84, ['z'] = 30.01},
		[35] = {['x'] = 56.38, ['y'] = -1427.39, ['z'] = 28.96},
		[36] = {['x'] = 99.04, ['y'] = -1337.54, ['z'] = 28.98},
		[37] = {['x'] = 164.54, ['y'] = -1278.13, ['z'] = 28.74},
		[38] = {['x'] = 272.45, ['y'] = -1296.65, ['z'] = 29.05},
		[39] = {['x'] = 350.17, ['y'] = -1312.6, ['z'] = 32.03},
		[40] = {['x'] = 443.14, ['y'] = -1269.54, ['z'] = 30.27},
		[41] = {['x'] = 420.18, ['y'] = -1330.26, ['z'] = 30.71},
		[42] = {['x'] = 437.39, ['y'] = -1371.14, ['z'] = 33.22},
		[43] = {['x'] = 431.0, ['y'] = -1338.58, ['z'] = 35.25},
		[44] = {['x'] = 412.8, ['y'] = -1304.16, ['z'] = 37.53},
		[45] = {['x'] = 408.14, ['y'] = -1321.3, ['z'] = 39.87},
		[46] = {['x'] = 442.27, ['y'] = -1329.89, ['z'] = 41.49},
		[47] = {['x'] = 432.42, ['y'] = -1341.74, ['z'] = 44.87},
		[48] = {['x'] = 383.64, ['y'] = -1305.27, ['z'] = 43.22},
		[49] = {['x'] = 448.86, ['y'] = -1375.68, ['z'] = 43.97},
		[50] = {['x'] = 543.68, ['y'] = -1438.57, ['z'] = 29.0},
		[51] = {['x'] = 965.23, ['y'] = -1430.88, ['z'] = 31.06},
		[52] = {['x'] = 997.13, ['y'] = -1402.91, ['z'] = 30.94},
	},
}

RegisterCommand('corridamoto', function(source, args, rawCmd)
    if not exports["chat"]:statusChat() then return end
	if not inrace then
		local ped = PlayerPedId()
		local vehicle = GetVehiclePedIsUsing(ped)
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local bowz,cdz = GetGroundZFor_3dCoord(CoordenadaX,CoordenadaY,CoordenadaZ)
		local distance = GetDistanceBetweenCoords(CoordenadaX,CoordenadaY,cdz,x,y,z,true)

		if IsEntityAVehicle(vehicle) and GetVehicleClass(vehicle) == 8 and GetPedInVehicleSeat(vehicle,-1) == ped then
			if distance <= 30 then
				if emP.CorridaLiberada() then	
					vRP.playSound("Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
					racepos = 1
					racepoint = emP.ReicePointe()
					inrace = true
					timerace = races[racepoint].time
					PlateIndex = GetVehicleNumberPlateText(vehicle)
					SetVehicleNumberPlateText(vehicle,"CORREDOR")
					CriandoBlip(races,racepoint,racepos)

					local abcd = GetEntityCoords(PlayerPedId())
					local streetName,_ = GetStreetNameAtCoord(abcd.x, abcd.y, abcd.z)
					streetName = GetStreetNameFromHashKey(streetName)

					local infos = {
						cds = abcd,
						codigo = '10-94',
						ocorrencia = 'Corredor ilegal.',
						rua = streetName,
						tempoNotificacao = 8000,
					}

					emP.startBombRace(infos)

					bomba = CreateObject(GetHashKey("prop_c4_final_green"),x,y,z,true,false,false)
					AttachEntityToEntity(bomba,vehicle,GetEntityBoneIndexByName(vehicle,"exhaust"),0.0,0.0,0.0,180.0,-90.0,180.0,false,false,false,true,2,true)
					TriggerEvent("Notify","aviso","Aviso", '<b>#' .. racepoint .. "</b> Você iniciou uma <b>corrida</b>, acabe ela antes do tempo previstoe e <b>NÃO</b> desça do veículo, caso contrário seu veículo explodirá.")
				else
					TriggerEvent('Notify', 'negado',"Negado", 'Você deve esperar ' .. emP.TempoCorrida() .. 's para iniciar outra corrida.')
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPOINTS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 1000
		if inrace then
			timeDistance = 4
			local ped = PlayerPedId()
			local vehicle = GetVehiclePedIsUsing(ped)
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(races[racepoint][racepos].x,races[racepoint][racepos].y,races[racepoint][racepos].z)
			local distance = GetDistanceBetweenCoords(races[racepoint][racepos].x,races[racepoint][racepos].y,cdz,x,y,z,true)
			
			DrawMarker(1,races[racepoint][racepos].x,races[racepoint][racepos].y,races[racepoint][racepos].z-3,0,0,0,0,0,0,12.0,12.0,8.0,255,255,255,25,0,0,0,0)
			DrawMarker(21,races[racepoint][racepos].x,races[racepoint][racepos].y,races[racepoint][racepos].z+1,0,0,0,0,180.0,130.0,3.0,3.0,2.0,255,0,0,50,1,0,0,1)
			if distance <= 20.0 then
				if IsEntityAVehicle(vehicle) and GetVehicleClass(vehicle) == 8 and GetPedInVehicleSeat(vehicle, -1) == ped then
					RemoveBlip(blips)
					if racepos == #races[racepoint] then
						inrace = false
						timerace = 0
						SetVehicleNumberPlateText(GetPlayersLastVehicle(),PlateIndex)
						PlateIndex = nil
						PlaySoundFrontend(-1,"RACE_PLACED","HUD_AWARDS",false)
						DetachEntity(bomba,false,false)
						TriggerServerEvent("trydeleteobj",ObjToNet(bomba))
						emP.removeBombRace()
						emP.kdoa9e89f7aodsfj98(racepoint,TempoDeCorrida,racepoint)
						TempoDeCorrida = 0
						racepoint = 0 
					else
						racepos = racepos + 1
						CriandoBlip(races,racepoint,racepos)
					end
					vRP.playSound("Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMEDRAWN
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		if inrace and timerace > 0 and GetVehiclePedIsUsing(PlayerPedId()) then
			timeDistance = 4
			drawTxt("RESTAM ~b~"..timerace.."s ~w~ATÉ O FIM DA CORRIDA",4,0.5,0.905,0.45,255,255,255,100)
			drawTxt("TEMPO GASTO: ~b~"..TempoDeCorrida.."s",4,0.5,0.935,0.45,255,255,255,100)
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMERACE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if inrace and timerace > 0 then
			timerace = timerace - 1
			TempoDeCorrida = TempoDeCorrida + 1
			if timerace <= 0 or not IsPedInAnyVehicle(PlayerPedId()) then
				TempoDeCorrida = 0
				inrace = false
				RemoveBlip(blips)
				SetVehicleNumberPlateText(GetPlayersLastVehicle(),PlateIndex)
				PlateIndex = nil
				SetTimeout(3000,function()
					DetachEntity(bomba,false,false)
					TriggerServerEvent("trydeleteobj",ObjToNet(bomba))
					emP.removeBombRace()
					AddExplosion(GetEntityCoords(GetPlayersLastVehicle()),1,1.0,true,true,true)
				end)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

function CriandoBlip(races,racepoint,racepos)
	blips = AddBlipForCoord(races[racepoint][racepos].x,races[racepoint][racepos].y,races[racepoint][racepos].z)
	SetBlipSprite(blips,433)
	SetBlipColour(blips,1)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Corrida Clandestina")
	EndTextCommandSetBlipName(blips)
end

RegisterNetEvent("emp_race:defuse")
AddEventHandler("emp_race:defuse",function()
	inrace = false
	SetVehicleNumberPlateText(GetPlayersLastVehicle(),PlateIndex)
	PlateIndex = nil
	RemoveBlip(blips)
	DetachEntity(bomba,false,false)
	TriggerServerEvent("trydeleteobj",ObjToNet(bomba))
	emP.removeBombRace()
end)