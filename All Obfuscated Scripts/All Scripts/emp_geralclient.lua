--[[
	id: UdemI6GtblV7fJG06MmMW
	name: emp_geral client
	description: cd bela
	time1: 2021-06-08 02:27:22.973812+00
	time2: 2021-06-08 02:27:22.973813+00
	uploader: dCft37atwBcsNndojr1evTDpQhkwJrLsbbRG3b20
	uploadersession: GvMNB1JjhEtGi8EhpIaYJo-vYIf8hV
	flag: f
--]]

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("emp_geral")

_SetVehicleNumberPlateText = SetVehicleNumberPlateText
SetVehicleNumberPlateText = function(...)end
_CreateVehicle = CreateVehicle
CreateVehicle = function(...)
	local veh = _CreateVehicle(...)
	_SetVehicleNumberPlateText(veh,vRP.getRegistrationNumber())
	return veh
end






local blips = false
local servico = false
local servico_policia = false
local servico_motorista = false
local servico_pizza = false
local servico_motoboy = false
local servico_mercado = false
local servico_mecanico = false
local statusobjeto = {}
local compras_carregar = 0
local compras_entregar = 0
local tempo = 0
local propcaixa = {}
local selecionado = 0
local selecionado_ant = 0



local sleep
local sleep_cancel



local coordenadas = {
	[1] = { ['id'] = 'ifood', ['x'] = 155.07, ['y'] = -1434.76, ['z'] = 29.24, ['perm'] = "ifood.permissao", ['vmin'] = 500, ['vmax'] = 2000, ['vehicle'] = "Enduro" },
	[2] = { ['id'] = 'mercado', ['x'] = 68.34, ['y'] = -1569.87, ['z'] = 29.59, ['perm'] = "entregador.permissao", ['vmin'] = 250, ['vmax'] = 1250, ['vehicle'] = "Burrito" },
	[3] = { ['id'] = 'motoboy', ['x'] = -70.792198181152, ['y'] = -800.78161621094, ['z'] = 44.227333068848, ['perm'] = "motoboy.permissao", ['vmin'] = 250, ['vmax'] = 1250, ['vehicle'] = "Faggio" },
	[4] = { ['id'] = 'policia_city', ['x'] = 440.17, ['y'] = -975.67, ['z'] = 30.68, ['perm'] = "dono.permissao", ['vmin'] = 50, ['vmax'] = 200 },
	[5] = { ['id'] = 'policia_paleto', ['x'] = -451.43, ['y'] = 6008.90, ['z'] = 31.84 , ['perm'] = "dono.permissao", ['vmin'] = 50, ['vmax'] = 200 },
	[6] = { ['id'] = 'motorista_city', ['x'] = 453.48, ['y'] = -607.74, ['z'] = 28.57, ['perm'] = "dono.permissao", ['vmin'] = 250, ['vmax'] = 1550 }, 
	[7] = { ['id'] = 'motorista_paleto', ['x'] = -215.64, ['y'] = 6219.25, ['z'] = 31.5, ['perm'] = "dono.permissao", ['vmin'] = 250, ['vmax'] = 1550 },
	[8] = { ['id'] = 'mecanico_coleta', ['x'] = 854.55310058594, ['y'] = -2112.9233398438, ['z'] = 31.575096130371, ['perm'] = "mecanico.permissao", ['vmin'] = 100, ['vmax'] = 250 },
	[9] = { ['id'] = 'mecanico_producao', ['x'] = 853.33520507813, ['y'] = -2120.2282714844, ['z'] = 30.584861755371, ['perm'] = "mecanico.permissao", ['vmin'] = 100, ['vmax'] = 250 },
	[10] = { ['id'] = 'mecanico_pneu', ['x'] = 859.71691894531, ['y'] = -2123.197265625, ['z'] = 30.657766342163, ['perm'] = "mecanico.permissao", ['vmin'] = 100, ['vmax'] = 250 }
}



local locs_policia = {
	[1] = { ['x'] = 131.31, ['y'] = -1003.41, ['z'] = 28.71 }, 
	[2] = { ['x'] = -8.19, ['y'] = -952.76, ['z'] = 28.72 }, 
	[3] = { ['x'] = -124.4, ['y'] = -738.83, ['z'] = 33.97 }, 
	[4] = { ['x'] = 23.18, ['y'] = -299.82, ['z'] = 46.68 }, 
	[5] = { ['x'] = -80.89, ['y'] = -229.97, ['z'] = 44.12 }, 
	[6] = { ['x'] = -83.21, ['y'] = -133.63, ['z'] = 57.01 }, 
	[7] = { ['x'] = -376.88, ['y'] = 0.18, ['z'] = 46.33 }, 
	[8] = { ['x'] = -539.56, ['y'] = 13.12, ['z'] = 43.55 }, 
	[9] = { ['x'] = -861.28, ['y'] = -100.71, ['z'] = 37.25 }, 
	[10] = { ['x'] = -1281.11, ['y'] = -328.93, ['z'] = 36.06 }, 
	[11] = { ['x'] = -1645.01, ['y'] = -554.96, ['z'] = 32.93 }, 
	[12] = { ['x'] = -1705.79, ['y'] = -388.39, ['z'] = 46.32 }, 
	[13] = { ['x'] = -2167.69, ['y'] = -324.56, ['z'] = 12.45 }, 
	[14] = { ['x'] = -2064.13, ['y'] = -400.48, ['z'] = 10.68 }, 
	[15] = { ['x'] = -1386.22, ['y'] = -828.1, ['z'] = 18.39 }, 
	[16] = { ['x'] = -1258.71, ['y'] = -1050.39, ['z'] = 7.73 }, 
	[17] = { ['x'] = -1165.34, ['y'] = -1322.44, ['z'] = 4.4 }, 
	[18] = { ['x'] = -1099.29, ['y'] = -1314.13, ['z'] = 4.67 }, 
	[19] = { ['x'] = -787.29, ['y'] = -1135.33, ['z'] = 9.9 }, 
	[20] = { ['x'] = -658.72, ['y'] = -1437.33, ['z'] = 9.91 }, 
	[21] = { ['x'] = -730.32, ['y'] = -2385.78, ['z'] = 14.01 }, 
	[22] = { ['x'] = -506.71, ['y'] = -2149.25, ['z'] = 8.59 }, 
	[23] = { ['x'] = -142.5, ['y'] = -1927.44, ['z'] = 23.99 }, 
	[24] = { ['x'] = -239.94, ['y'] = -1845.59, ['z'] = 28.73 }, 
	[25] = { ['x'] = -361.99, ['y'] = -1815.51, ['z'] = 22.22 }, 
	[26] = { ['x'] = -265.16, ['y'] = -1453.04, ['z'] = 30.53 }, 
	[27] = { ['x'] = -124.86, ['y'] = -1382.61, ['z'] = 28.74 }, 
	[28] = { ['x'] = 132.05, ['y'] = -1381.79, ['z'] = 28.64 }, 
	[29] = { ['x'] = 218.8, ['y'] = -1147.23, ['z'] = 28.63 }, 
	[30] = { ['x'] = 280.06, ['y'] = -879.91, ['z'] = 28.94 }, 
	[31] = { ['x'] = 202.02, ['y'] = -817.52, ['z'] = 30.63 }, 
	[32] = { ['x'] = 305.55, ['y'] = -488.35, ['z'] = 43.08 }, 
	[33] = { ['x'] = 479.19, ['y'] = -339.52, ['z'] = 45.51 }, 
	[34] = { ['x'] = 648.06, ['y'] = -395.95, ['z'] = 42.0 }, 
	[35] = { ['x'] = 955.93, ['y'] = -303.82, ['z'] = 66.69 }, 
	[36] = { ['x'] = 1065.72, ['y'] = -500.42, ['z'] = 62.55 }, 
	[37] = { ['x'] = 1196.27, ['y'] = -741.93, ['z'] = 58.27 }, 
	[38] = { ['x'] = 1150.64, ['y'] = -931.41, ['z'] = 49.29 }, 
	[39] = { ['x'] = 805.29, ['y'] = -1002.27, ['z'] = 25.88 },
	[40] = { ['x'] = 789.92, ['y'] = -1415.17, ['z'] = 26.9 }, 
	[41] = { ['x'] = 504.98, ['y'] = -1216.04, ['z'] = 29.03 }, 
	[42] = { ['x'] = 503.45, ['y'] = -966.78, ['z'] = 27.03 },



	[43] = { ['x'] = -412.21, ['y'] = 6002.37, ['z'] = 31.17 }, 
	[44] = { ['x'] = -762.69, ['y'] = 5506.55, ['z'] = 34.75 }, 
	[45] = { ['x'] = -708.68, ['y'] = 5433.09, ['z'] = 44.56 }, 
	[46] = { ['x'] = -709.57, ['y'] = 5300.94, ['z'] = 71.69 }, 
	[47] = { ['x'] = -572.95, ['y'] = 5254.12, ['z'] = 70.04 }, 
	[48] = { ['x'] = -574.2, ['y'] = 5450.14, ['z'] = 60.52 }, 
	[49] = { ['x'] = -500.15, ['y'] = 5747.03, ['z'] = 48.31 }, 
	[50] = { ['x'] = -307.58, ['y'] = 6025.62, ['z'] = 31.77 }, 
	[51] = { ['x'] = 152.54, ['y'] = 6517.07, ['z'] = 31.18 }, 
	[52] = { ['x'] = 1028.89, ['y'] = 6480.93, ['z'] = 20.56 }, 
	[53] = { ['x'] = 1489.83, ['y'] = 6435.95, ['z'] = 21.87 }, 
	[54] = { ['x'] = 2528.07, ['y'] = 5400.32, ['z'] = 44.14 }, 
	[55] = { ['x'] = 2593.1, ['y'] = 5134.5, ['z'] = 44.33 }, 
	[56] = { ['x'] = 1972.56, ['y'] = 5140.56, ['z'] = 42.76 }, 
	[57] = { ['x'] = 1733.16, ['y'] = 4593.94, ['z'] = 40.5 }, 
	[58] = { ['x'] = 1453.72, ['y'] = 4501.05, ['z'] = 49.98 }, 
	[59] = { ['x'] = 824.2, ['y'] = 4424.81, ['z'] = 52.17 }, 
	[60] = { ['x'] = 498.08, ['y'] = 4314.52, ['z'] = 55.41 }, 
	[61] = { ['x'] = 159.13, ['y'] = 4421.58, ['z'] = 75.41 }, 
	[62] = { ['x'] = -227.33, ['y'] = 3877.26, ['z'] = 37.3 }, 
	[63] = { ['x'] = 113.11, ['y'] = 3424.78, ['z'] = 39.0 }, 
	[64] = { ['x'] = 916.13, ['y'] = 3532.2, ['z'] = 33.61 }, 
	[65] = { ['x'] = 1688.11, ['y'] = 3499.61, ['z'] = 36.03 }, 
	[66] = { ['x'] = 2029.44, ['y'] = 3759.51, ['z'] = 31.89 }, 
	[67] = { ['x'] = 1864.66, ['y'] = 3952.19, ['z'] = 32.65 }, 
	[68] = { ['x'] = 1582.01, ['y'] = 3724.29, ['z'] = 34.15 }, 
	[69] = { ['x'] = 938.06, ['y'] = 3636.31, ['z'] = 32.07 }, 
	[70] = { ['x'] = 411.18, ['y'] = 3491.25, ['z'] = 34.22 }, 
	[71] = { ['x'] = -120.25, ['y'] = 3630.95, ['z'] = 44.43 }, 
	[72] = { ['x'] = -202.92, ['y'] = 4206.0, ['z'] = 44.15 }, 
	[73] = { ['x'] = -703.0, ['y'] = 4400.04, ['z'] = 23.46 }, 
	[74] = { ['x'] = -1023.67, ['y'] = 4422.08, ['z'] = 25.57 }, 
	[75] = { ['x'] = -1348.62, ['y'] = 4471.77, ['z'] = 22.73 }, 
	[76] = { ['x'] = -1559.39, ['y'] = 4602.06, ['z'] = 20.11 }, 
	[77] = { ['x'] = -1495.97, ['y'] = 4985.22, ['z'] = 62.28 }, 
	[78] = { ['x'] = -781.91, ['y'] = 5486.34, ['z'] = 33.96 }, 
	[79] = { ['x'] = -615.6, ['y'] = 6079.34, ['z'] = 7.72 }, 
	[80] = { ['x'] = -315.78, ['y'] = 6216.54, ['z'] = 30.97 }, 
	[81] = { ['x'] = 59.5, ['y'] = 6618.77, ['z'] = 31.16 }, 
	[82] = { ['x'] = -166.38, ['y'] = 6372.5, ['z'] = 31.0 },
}



local locs_motorista = {
	[1] = { ['x'] = 309.95, ['y'] = -760.52, ['z'] = 30.09 },
	[2] = { ['x'] = 69.59, ['y'] = -974.80, ['z'] = 30.14 },
	[3] = { ['x'] = 95.00, ['y'] = -634.89, ['z'] = 45.02 },
	[4] = { ['x'] = 58.27, ['y'] = -283.32, ['z'] = 48.20 },
	[5] = { ['x'] = 47.74, ['y'] = -160.44, ['z'] = 56.03 },
	[6] = { ['x'] = 323.93, ['y'] = -267.58, ['z'] = 54.71 },
	[7] = { ['x'] = 443.75, ['y'] = 119.16, ['z'] = 100.41 },
	[8] = { ['x'] = 125.62, ['y'] = -4.42, ['z'] = 68.48 },
	[9] = { ['x'] = -524.08, ['y'] = 133.59, ['z'] = 63.91 },
	[10] = { ['x'] = -586.64, ['y'] = 268.39, ['z'] = 83.24 },
	[11] = { ['x'] = -640.38, ['y'] = -163.16, ['z'] = 38.49 },
	[12] = { ['x'] = -597.89, ['y'] = -361.27, ['z'] = 35.77 },
	[13] = { ['x'] = -646.06, ['y'] = -804.09, ['z'] = 25.78 },
	[14] = { ['x'] = -932.63, ['y'] = -1199.67, ['z'] = 5.91 },
	[15] = { ['x'] = -1234.65, ['y'] = -1080.87, ['z'] = 9.12 },
	[16] = { ['x'] = -1373.99, ['y'] = -793.23, ['z'] = 20.09 },
	[17] = { ['x'] = -2011.25, ['y'] = -160.04, ['z'] = 29.40 },
	[18] = { ['x'] = -2981.70, ['y'] = 404.50, ['z'] = 15.75 },
	[19] = { ['x'] = -3101.58, ['y'] = 1112.65, ['z'] = 21.28 },
	[20] = { ['x'] = -2556.10, ['y'] = 2322.01, ['z'] = 33.89 },
	[21] = { ['x'] = -1094.86, ['y'] = 2675.87, ['z'] = 20.08 },
	[22] = { ['x'] = -72.63, ['y'] = 2813.83, ['z'] = 54.60 },
	[23] = { ['x'] = 540.55, ['y'] = 2685.25, ['z'] = 43.20 },
	[24] = { ['x'] = 1119.93, ['y'] = 2682.04, ['z'] = 39.31 },
	[25] = { ['x'] = 1470.51, ['y'] = 2725.47, ['z'] = 38.48 },
	[26] = { ['x'] = 2002.62, ['y'] = 2603.65, ['z'] = 55.07 },
	[27] = { ['x'] = 379.58, ['y'] = -599.20, ['z'] = 29.58 },



	[28] = { ['x'] = -153.29, ['y'] = 6212.22, ['z'] = 32.04 }, 
	[29] = { ['x'] = -18.38, ['y'] = 6507.26, ['z'] = 32.11 }, 
	[30] = { ['x'] = 750.1, ['y'] = 6492.87, ['z'] = 26.96 }, 
	[31] = { ['x'] = 1605.67, ['y'] = 6382.96, ['z'] = 28.04 }, 
	[32] = { ['x'] = 2523.1, ['y'] = 5397.13, ['z'] = 43.79 }, 
	[33] = { ['x'] = 2417.2, ['y'] = 5146.35, ['z'] = 46.22 }, 
	[34] = { ['x'] = 2483.1, ['y'] = 4447.83, ['z'] = 34.72 }, 
	[35] = { ['x'] = 2009.0, ['y'] = 3754.48, ['z'] = 31.68 },
	[36] = { ['x'] = 1784.69, ['y'] = 3784.43, ['z'] = 34.56 }, 
	[37] = { ['x'] = 1645.95, ['y'] = 3594.46, ['z'] = 34.77 }, 
	[38] = { ['x'] = 2028.34, ['y'] = 3086.08, ['z'] = 46.26 }, 
	[39] = { ['x'] = 1243.86, ['y'] = 2685.01, ['z'] = 36.89 }, 
	[40] = { ['x'] = 301.27, ['y'] = 2643.21, ['z'] = 43.81 }, 
	[41] = { ['x'] = -457.07, ['y'] = 2854.16, ['z'] = 34.26 }, 
	[42] = { ['x'] = -1117.01, ['y'] = 2668.0, ['z'] = 17.46 }, 
	[43] = { ['x'] = -2220.02, ['y'] = 2304.25, ['z'] = 32.1 }, 
	[44] = { ['x'] = -2697.39, ['y'] = 2289.02, ['z'] = 18.42 }, 
	[45] = { ['x'] = -2542.61, ['y'] = 3416.97, ['z'] = 12.56 }, 
	[46] = { ['x'] = -2208.02, ['y'] = 4298.45, ['z'] = 47.47 }, 
	[47] = { ['x'] = -1530.62, ['y'] = 4954.68, ['z'] = 61.37 }, 
	[48] = { ['x'] = -1050.17, ['y'] = 5333.97, ['z'] = 44.0 }, 
	[49] = { ['x'] = -790.13, ['y'] = 5551.25, ['z'] = 32.34 }, 
	[50] = { ['x'] = -453.36, ['y'] = 6069.5, ['z'] = 30.66 }, 
	[51] = { ['x'] = -333.46, ['y'] = 6331.06, ['z'] = 29.42 }, 
	[52] = { ['x'] = -51.08, ['y'] = 6602.36, ['z'] = 29.08 }, 
	[53] = { ['x'] = -64.9, ['y'] = 6472.86, ['z'] = 30.68 }, 
	[54] = { ['x'] = -292.38, ['y'] = 6246.41, ['z'] = 30.71 },
}



local locs_ifood = {
	[1] = { ['x'] = 297.54025268555, ['y'] = -584.11859130859, ['z'] = 43.255554199219 },
	[2] = {['x'] = 315.34567260742, ['y'] = -127.63579559326, ['z'] = 69.977058410645},
	[3] = {['x'] = -1016.6528320313, ['y'] = -265.37048339844, ['z'] = 39.040435791016},
	[4] = {['x'] = -896.29455566406, ['y'] = -4.8841047286987, ['z'] = 43.798858642578},
	[5] = {['x'] = -686.2890625, ['y'] = 223.82417297363, ['z'] = 81.955230712891},
	[6] = {['x'] = 81.290367126465, ['y'] = 274.37554931641, ['z'] = 110.21020507813},
	[7] = {['x'] = 8.275429725647, ['y'] = -244.01760864258, ['z'] = 47.660564422607},
	[8] = {['x'] = -849.81915283203, ['y'] = -590.18414306641, ['z'] = 29.221643447876},
	[9] = {['x'] = 167.70367431641, ['y'] = -567.16180419922, ['z'] = 43.872871398926},
	[10] = {['x'] = 808.28729248047, ['y'] = -1630.6975097656, ['z'] = 31.165170669556},
	[11] = {['x'] = 980.04083251953, ['y'] = -627.46240234375, ['z'] = 59.235832214355},
	[12] = {['x'] = -1383.4761962891, ['y'] = 266.78927612305, ['z'] = 61.238792419434},
	[13] = {['x'] = -1297.443359375, ['y'] = -392.6233215332, ['z'] = 36.45735168457},
	[14] = {['x'] = -719.19226074219, ['y'] = 256.55465698242, ['z'] = 79.886039733887},
	[15] = {['x'] = -699.25549316406, ['y'] = -305.42642211914, ['z'] = 36.612106323242},
	[16] = {['x'] = 818.31774902344, ['y'] = 541.11767578125, ['z'] = 125.92018127441},
	[17] = {['x'] = -696.98748779297, ['y'] = -380.28305053711, ['z'] = 34.460159301758},
	[18] = {['x'] = 952.89965820313, ['y'] = -252.36277770996, ['z'] = 67.964668273926},
	[19] = {['x'] = -379.28204345703, ['y'] = 218.19515991211, ['z'] = 83.658271789551},
	[20] = {['x'] = -1116.8681640625, ['y'] = 304.21148681641, ['z'] = 66.521263122559},
	[21] = {['x'] = -1715.4060058594, ['y'] = -447.24935913086, ['z'] = 42.643898010254},
	[22] = {['x'] = -1539.7340087891, ['y'] = 421.88827514648, ['z'] = 110.01399993896},
	[23] = {['x'] = -931.54949951172, ['y'] = 691.00268554688, ['z'] = 153.46667480469},
	[24] = {['x'] = -765.11224365234, ['y'] = 650.87908935547, ['z'] = 145.50128173828},
	[25] = {['x'] = -669.07019042969, ['y'] = 637.97814941406, ['z'] = 149.52885437012},
	[26] = {['x'] = -962.64965820313, ['y'] = 813.48486328125, ['z'] = 177.56625366211},
	[27] = {['x'] = -1277.9051513672, ['y'] = 629.64178466797, ['z'] = 143.18620300293},
	[28] = {['x'] = -958.15301513672, ['y'] = 606.67150878906, ['z'] = 106.16480255127},
	[29] = {['x'] = -1074.4802246094, ['y'] = 468.06491088867, ['z'] = 77.798690795898},
	[30] = {['x'] = 222.68656921387, ['y'] = 373.35891723633, ['z'] = 106.39540100098},
	[31] = {['x'] = -597.32489013672, ['y'] = 851.93432617188, ['z'] = 211.41841125488},
	[32] = {['x'] = -419.37771606445, ['y'] = 221.52616882324, ['z'] = 83.397750854492},
	[33] = {['x'] = -170.90231323242, ['y'] = -347.06564331055, ['z'] = 34.582611083984},
	[34] = {['x'] = -1750.2807617188, ['y'] = -697.17449951172, ['z'] = 10.174647331238},
	[35] = {['x'] = -753.09338378906, ['y'] = 275.9430847168, ['z'] = 85.755798339844},
	[36] = {['x'] = 638.63275146484, ['y'] = 1.4795322418213, ['z'] = 82.786437988281},
	[37] = {['x'] = -228.71377563477, ['y'] = -78.723114013672, ['z'] = 49.807193756104},
	[38] = {['x'] = -368.81814575195, ['y'] = -101.86985015869, ['z'] = 39.543071746826},
	[39] = {['x'] = -657.34600830078, ['y'] = -678.76177978516, ['z'] = 31.482982635498},
	[40] = {['x'] = -219.0149230957, ['y'] = -1162.3131103516, ['z'] = 23.022527694702},
}
local locs_motoboy = {
	[1] = {['x'] = 561.53210449219, ['y'] = 93.05615234375, ['z'] = 96.097465515137},
	[2] = {['x'] = 4.7963643074036, ['y'] = 220.10743713379, ['z'] = 107.69703674316},
	[3] = {['x'] = -669.07019042969, ['y'] = 637.97814941406, ['z'] = 149.52885437012},
	[4] = {['x'] = -658.47686767578, ['y'] = 887.60876464844, ['z'] = 229.2488861084},
	[5] = {['x'] = 1015.9174804688, ['y'] = 177.10151672363, ['z'] = 80.855812072754},
	[6] = {['x'] = 930.79614257813, ['y'] = -245.92253112793, ['z'] = 69.003974914551},
	[7] = {['x'] = 736.67474365234, ['y'] = 132.24856567383, ['z'] = 80.709762573242},
	[8] = {['x'] = 39.344619750977, ['y'] = 361.03668212891, ['z'] = 116.04097747803},
	[9] = {['x'] = -715.70867919922, ['y'] = 303.6755065918, ['z'] = 85.304725646973},
	[10] = {['x'] = -848.77691650391, ['y'] = 508.71032714844, ['z'] = 90.817031860352},
	[11] = {['x'] = -1636.4560546875, ['y'] = 180.75524902344, ['z'] = 61.75732421875},
	[12] = {['x'] = -1010.0927734375, ['y'] = -731.77630615234, ['z'] = 21.529735565186},
	[13] = {['x'] = -849.09143066406, ['y'] = -589.62219238281, ['z'] = 29.221202850342},
	[14] = {['x'] = -58.614055633545, ['y'] = -91.87816619873, ['z'] = 57.769798278809},
	[15] = {['x'] = -729.37353515625, ['y'] = -879.90563964844, ['z'] = 22.710887908936},
	[16] = {['x'] = -115.96405029297, ['y'] = -1772.0961914063, ['z'] = 29.85964012146},
	[17] = {['x'] = 803.75555419922, ['y'] = -988.68591308594, ['z'] = 26.124607086182},
	[18] = {['x'] = 1386.0478515625, ['y'] = -570.95550537109, ['z'] = 74.338989257813},
	[19] = {['x'] = 965.33459472656, ['y'] = -542.43865966797, ['z'] = 59.359092712402},
	[20] = {['x'] = 1130.3624267578, ['y'] = -776.35034179688, ['z'] = 57.610145568848},
	[21] = {['x'] = 781.91485595703, ['y'] = -1278.4846191406, ['z'] = 26.493606567383},
	[22] = {['x'] = 435.31195068359, ['y'] = -2088.7687988281, ['z'] = 21.575340270996},
	[23] = {['x'] = 241.05842590332, ['y'] = -1379.0065917969, ['z'] = 33.741725921631},
	[24] = {['x'] = -40.751903533936, ['y'] = -1747.3150634766, ['z'] = 29.296154022217},
	[25] = {['x'] = -639.06988525391, ['y'] = -1250.1219482422, ['z'] = 11.810428619385},
	[26] = {['x'] = -1451.3137207031, ['y'] = -579.4111328125, ['z'] = 31.248828887939},
	[27] = {['x'] = -795.52319335938, ['y'] = -1027.1280517578, ['z'] = 13.311345100403},
	[28] = {['x'] = -1206.7659912109, ['y'] = -1134.5290527344, ['z'] = 7.7003793716431},
	[29] = {['x'] = -160.26139831543, ['y'] = -1431.9149169922, ['z'] = 31.27619934082},
	[30] = {['x'] = 225.46060180664, ['y'] = -1745.7231445313, ['z'] = 29.262004852295},
	[31] = {['x'] = 488.94125366211, ['y'] = -1002.1870117188, ['z'] = 27.986331939697},
	[32] = {['x'] = 232.07948303223, ['y'] = 364.80941772461, ['z'] = 105.98661804199},
	[33] = {['x'] = -419.44393920898, ['y'] = 221.48359680176, ['z'] = 83.397308349609},
	[34] = {['x'] = -840.39227294922, ['y'] = -25.080394744873, ['z'] = 40.200084686279},
	[35] = {['x'] = -570.36602783203, ['y'] = -323.33059692383, ['z'] = 35.071716308594},
	[36] = {['x'] = -582.14544677734, ['y'] = -1000.783203125, ['z'] = 22.329689025879},
	[37] = {['x'] = 15.03999042511, ['y'] = 543.35571289063, ['z'] = 176.01936340332},
	[38] = {['x'] = -597.62213134766, ['y'] = 852.22369384766, ['z'] = 211.38160705566},
	[39] = {['x'] = -1055.9946289063, ['y'] = 761.65576171875, ['z'] = 167.31707763672},
	[40] = {['x'] = -1675.0748291016, ['y'] = 265.64273071289, ['z'] = 62.390941619873},
}



local locs_mercado = {
	[1] = {['x'] = -171.03358459473, ['y'] = -1449.5111083984, ['z'] = 31.634181976318},
	[2] = {['x'] = 68.416023254395, ['y'] = -1569.7052001953, ['z'] = 29.597764968872},
	[3] = {['x'] = 377.1923828125, ['y'] = -1501.0217285156, ['z'] = 29.291648864746},
	[4] = {['x'] = 292.50741577148, ['y'] = -223.67100524902, ['z'] = 53.978324890137},
	[5] = {['x'] = 806.66558837891, ['y'] = -1074.2618408203, ['z'] = 28.913948059082},
	[6] = {['x'] = -357.56011962891, ['y'] = 16.753490447998, ['z'] = 47.854774475098},
	[7] = {['x'] = -556.35162353516, ['y'] = 274.18753051758, ['z'] = 83.019599914551},
	[8] = {['x'] = -766.0224609375, ['y'] = -157.64666748047, ['z'] = 37.578968048096},
	[9] = {['x'] = -214.35566711426, ['y'] = 399.57550048828, ['z'] = 111.30390930176},
	[10] = {['x'] = -970.88916015625, ['y'] = 122.55429077148, ['z'] = 57.048561096191},
	[11] = {['x'] = -728.52166748047, ['y'] = -880.25122070313, ['z'] = 22.710893630981},
	[12] = {['x'] = -1304.0986328125, ['y'] = -441.578125, ['z'] = 35.154655456543},
	[13] = {['x'] = -512.74951171875, ['y'] = -734.12701416016, ['z'] = 32.706470489502},
	[14] = {['x'] = -219.29235839844, ['y'] = -85.587493896484, ['z'] = 50.337017059326},
	[15] = {['x'] = -766.58074951172, ['y'] = -24.011138916016, ['z'] = 41.079906463623},
	[16] = {['x'] = -839.50579833984, ['y'] = -273.05047607422, ['z'] = 38.945014953613},
	[17] = {['x'] = -658.00634765625, ['y'] = -256.54327392578, ['z'] = 36.320384979248},
	[18] = {['x'] = -687.68096923828, ['y'] = 597.82849121094, ['z'] = 143.6420135498},
	[19] = {['x'] = -476.75094604492, ['y'] = 648.06805419922, ['z'] = 144.38203430176},
	[20] = {['x'] = -232.65330505371, ['y'] = 588.60198974609, ['z'] = 190.53633117676},
	[21] = {['x'] = 372.29547119141, ['y'] = 429.4909362793, ['z'] = 145.3671875},
	[22] = {['x'] = -788.39373779297, ['y'] = -6.9906015396118, ['z'] = 40.872852325439},
	[23] = {['x'] = -149.97346496582, ['y'] = 123.94016265869, ['z'] = 70.225471496582},
	[24] = {['x'] = 144.42350769043, ['y'] = -213.1382598877, ['z'] = 54.449893951416},
	[25] = {['x'] = 375.49374389648, ['y'] = -688.21966552734, ['z'] = 29.262935638428},
	[26] = {['x'] = 403.99362182617, ['y'] = -1417.9189453125, ['z'] = 29.435405731201},
	[27] = {['x'] = 131.52969360352, ['y'] = -1771.7526855469, ['z'] = 29.671886444092},
	[28] = {['x'] = -655.22552490234, ['y'] = -931.79248046875, ['z'] = 22.670469284058},
	[29] = {['x'] = -1459.2297363281, ['y'] = -414.31658935547, ['z'] = 35.713684082031},
	[30] = {['x'] = -1747.9792480469, ['y'] = -394.60568237305, ['z'] = 43.68350982666},
	[31] = {['x'] = -1274.3978271484, ['y'] = 315.49209594727, ['z'] = 65.511764526367},
	[32] = {['x'] = -654.66186523438, ['y'] = -414.21600341797, ['z'] = 35.421920776367},
	[33] = {['x'] = -535.03729248047, ['y'] = -165.72663879395, ['z'] = 38.324584960938},
	[34] = {['x'] = -648.51196289063, ['y'] = -276.43319702148, ['z'] = 35.724781036377},
	[35] = {['x'] = -766.73736572266, ['y'] = -23.556354522705, ['z'] = 41.080673217773},
	[36] = {['x'] = -766.73736572266, ['y'] = -23.556354522705, ['z'] = 41.080673217773},
	[37] = {['x'] = -502.99392700195, ['y'] = 31.882598876953, ['z'] = 44.717639923096},
	[38] = {['x'] = -271.63238525391, ['y'] = -692.97760009766, ['z'] = 34.273174285889},
	[39] = {['x'] = -592.74102783203, ['y'] = -892.85528564453, ['z'] = 25.921644210815},
	[40] = {['x'] = -639.06988525391, ['y'] = -1250.1219482422, ['z'] = 11.810428619385},
}



local locs_mecanico = {
	[1] = { ['x'] = 478.51, ['y'] = -1890.44, ['z'] = 26.09 },
	[2] = { ['x'] = 976.53, ['y'] = -1825.05, ['z'] = 31.15 },
	[3] = { ['x'] = 1200.32, ['y'] = -1384.76, ['z'] = 35.22 },
	[4] = { ['x'] = 1140.96, ['y'] = -776.02, ['z'] = 57.59 },
	[5] = { ['x'] = -561.63, ['y'] = 302.25, ['z'] = 83.17 },
	[6] = { ['x'] = -1151.40, ['y'] = -206.73, ['z'] = 37.95 },
	[7] = { ['x'] = -2091.83, ['y'] = -314.17, ['z'] = 13.02 },
	[8] = { ['x'] = -1608.39, ['y'] = -822.20, ['z'] = 10.04 },
	[9] = { ['x'] = -522.23, ['y'] = -1212.54, ['z'] = 18.18 },
	[10] = { ['x'] = -719.60, ['y'] = -933.34, ['z'] = 19.01 },
	[11] = { ['x'] = -314.40, ['y'] = -1472.76, ['z'] = 30.54 },
	[12] = { ['x'] = -75.83, ['y'] = -1763.12, ['z'] = 29.49 },
	[13] = { ['x'] = 490.07, ['y'] = -1312.75, ['z'] = 29.25 },
	[14] = { ['x'] = 717.47, ['y'] = -1089.01, ['z'] = 22.36 },
	[15] = { ['x'] = 1184.65, ['y'] = -334.11, ['z'] = 69.17 },
	[16] = { ['x'] = -744.50, ['y'] = -1503.57, ['z'] = 5.00 },
}



local macas = {
	{ ['x'] = -811.32189941406, ['y'] = -1224.7425537109, ['z'] = 7.3339848518372, ['x2'] = -812.28051757813, ['y2'] = -1224.3956298828, ['z2'] = 8.2539386749268, ['h'] = 150.0 },
	{ ['x'] = -808.525390625, ['y'] = -1227.0943603516, ['z'] = 7.3339757919312, ['x2'] = -809.53332519531, ['y2'] = -1226.6405029297, ['z2'] = 8.2539386749268, ['h'] = 150.0 },
	{ ['x'] = -805.76873779297, ['y'] = -1229.5275878906, ['z'] = 7.3339853286743, ['x2'] = -806.70758056641, ['y2'] = -1229.0413818359, ['z2'] = 8.2539262771606, ['h'] = 150.0 },
	{ ['x'] = -804.716796875, ['y'] = -1230.5133056641, ['z'] = 7.3339858055115, ['x2'] = -804.05236816406, ['y2'] = -1231.2034912109, ['z2'] = 8.2539386749268, ['h'] = 150.0 },
	{ ['x'] = -800.61437988281, ['y'] = -1233.8450927734, ['z'] = 7.3339862823486, ['x2'] = -799.99957275391, ['y2'] = -1234.6252441406, ['z2'] = 8.2539377212524, ['h'] = 150.0 },
	{ ['x'] = -798.05682373047, ['y'] = -1230.6359863281, ['z'] = 7.3339891433716, ['x2'] = -797.12182617188, ['y2'] = -1231.1823730469, ['z2'] = 8.2539377212524, ['h'] = 300.0 },
	{ ['x'] = -808.74969482422, ['y'] = -1221.7022705078, ['z'] = 7.3339858055115, ['x2'] = -809.22863769531, ['y2'] = -1220.8564453125, ['z2'] = 8.2539386749268, ['h'] = 300.0 },
	{ ['x'] = -804.83636474609, ['y'] = -1224.6799316406, ['z'] = 7.3339862823486, ['x2'] = -805.5888671875, ['y2'] = -1224.2464599609, ['z2'] = 8.2539386749268, ['h'] = 300.0 },
	{ ['x'] = -801.88928222656, ['y'] = -1227.3226318359, ['z'] = 7.3339886665344, ['x2'] = -800.96319580078, ['y2'] = -1227.9125976563, ['z2'] = 8.2539377212524, ['h'] = 300.0 },
}



Citizen.CreateThread(function()
	while true do
		sleep = 1000
		for k,v in pairs(macas) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			if distance <= 1.1 then
				sleep = 5
				drawTxt("~r~E~w~  DEITAR    ~g~G~w~  TRATAMENTO",4,0.5,0.90,0.50,255,255,255,200)
				if IsControlJustPressed(0,38) then
					SetEntityCoords(ped,v.x2,v.y2,v.z2)
					SetEntityHeading(ped,v.h)
					vRP._playAnim(false,{{"amb@world_human_sunbathe@female@back@idle_a","idle_a"}},true)
				end
				if IsControlJustPressed(0,47) then
					if emP.checkServices() then
						TriggerEvent('tratamento-macas')
						TriggerEvent('resetDiagnostic')
						TriggerEvent('resetWarfarina')
						SetEntityCoords(ped,v.x2,v.y2,v.z2)
						SetEntityHeading(ped,v.h)
						vRP._playAnim(false,{{"amb@world_human_sunbathe@female@back@idle_a","idle_a"}},true)
					else
						TriggerEvent("Notify","aviso","Existem paramédicos em serviço.")
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)



Citizen.CreateThread(function()
	while true do
		sleep = 1000
		if not servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(coordenadas[8]['x'],coordenadas[8]['y'],coordenadas[8]['z'])
			local distance = GetDistanceBetweenCoords(coordenadas[8]['x'],coordenadas[8]['y'],cdz,x,y,z,true)

			if distance <= 30.0 then
				sleep = 3
				DrawMarker(27,coordenadas[8]['x'],coordenadas[8]['y'],coordenadas[8]['z']-0.95,0,0,0,0,180.0,130.0,1.0,1.0,1.0,8, 8, 8,100,0,0,0,1)
				if distance <= 1.2 then
					drawTxt("PRESSIONE  ~b~E~w~  PARA INICIAR A ROTA DE COLETA",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) and emP.checkPermission(coordenadas[8]['perm']) then
						servico = true
						LocalPlayer.state:set('working', true, true)
						servico_mecanico = true
						selecionado = math.random(#locs_mecanico)
						CriandoBlip(locs_mecanico,selecionado)
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)



Citizen.CreateThread(function()
	while true do
		sleep = 1000
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local bowz,cdz = GetGroundZFor_3dCoord(coordenadas[9]['x'],coordenadas[9]['y'],coordenadas[9]['z'])
		local distance = GetDistanceBetweenCoords(coordenadas[9]['x'],coordenadas[9]['y'],cdz,x,y,z,true)

		if distance <= 30.0 then
			sleep = 3
			DrawMarker(23,coordenadas[9]['x'],coordenadas[9]['y'],coordenadas[9]['z']-0.97,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,20,0,0,0,0)
			if distance <= 1.2 then
				drawTxt("PRESSIONE  ~b~E~w~  PARA MONTAR UM KIT DE REPARO",4,0.5,0.93,0.50,255,255,255,180)
				if IsControlJustPressed(0,38) and emP.checkPermission(coordenadas[9]['perm']) then
					emP.criaKit()
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)



Citizen.CreateThread(function()
	while true do
		sleep = 1000
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local bowz,cdz = GetGroundZFor_3dCoord(coordenadas[10]['x'],coordenadas[10]['y'],coordenadas[10]['z'])
		local distance = GetDistanceBetweenCoords(coordenadas[10]['x'],coordenadas[10]['y'],cdz,x,y,z,true)

		if distance <= 30.0 then
			sleep = 3
			DrawMarker(23,coordenadas[10]['x'],coordenadas[10]['y'],coordenadas[10]['z']-0.97,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,20,0,0,0,0)
			if distance <= 1.2 then
				drawTxt("PRESSIONE  ~b~E~w~  PARA MONTAR UM PNEU",4,0.5,0.93,0.50,255,255,255,180)
				if IsControlJustPressed(0,38) and emP.checkPermission(coordenadas[10]['perm']) then
					emP.criaPneu()
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)



Citizen.CreateThread(function()
	while true do
		sleep = 1000
		if not servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(coordenadas[4]['x'],coordenadas[4]['y'],coordenadas[4]['z'])
			local distance = GetDistanceBetweenCoords(coordenadas[4]['x'],coordenadas[4]['y'],cdz,x,y,z,true)

			if distance <= 10 then
				sleep = 3
				DrawMarker(27,coordenadas[4]['x'],coordenadas[4]['y'],coordenadas[4]['z']-0.95,0,0,0,0,180.0,130.0,1.0,1.0,1.0,8, 8, 8,100,0,0,0,1)
				if distance <= 1.2 then
					drawTxt("PRESSIONE  ~r~E~w~  PARA ~y~INICIAR A ROTA",4,0.5,0.90,0.50,255,255,255,200)
					if IsControlJustPressed(0,38) and emP.checkPermission(coordenadas[4]['perm']) then
						servico = true
						LocalPlayer.state:set('working', true, true)

						servico_policia = true
						selecionado = math.random(1,42)
						CriandoBlip(locs_policia,selecionado)
						TriggerEvent("Notify","sucesso","Você entrou em serviço.")
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)



Citizen.CreateThread(function()
	while true do
		sleep = 1000
		if not servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(coordenadas[5]['x'],coordenadas[5]['y'],coordenadas[5]['z'])
			local distance = GetDistanceBetweenCoords(coordenadas[5]['x'],coordenadas[5]['y'],cdz,x,y,z,true)

			if distance <= 10 then
				sleep = 3
				DrawMarker(27,coordenadas[5]['x'],coordenadas[5]['y'],coordenadas[5]['z']-0.95,0,0,0,0,180.0,130.0,1.0,1.0,1.0,8, 8, 8,100,0,0,0,1)
				if distance <= 1.2 then
					drawTxt("PRESSIONE  ~r~E~w~  PARA ~y~INICIAR A ROTA",4,0.5,0.90,0.50,255,255,255,200)
					if IsControlJustPressed(0,38) and emP.checkPermission(coordenadas[5]['perm']) then
						servico = true
						LocalPlayer.state:set('working', true, true)

						servico_policia = true
						selecionado = math.random(43,82)
						CriandoBlip(locs_policia,selecionado)
						TriggerEvent("Notify","sucesso","Você entrou em serviço.")
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)



Citizen.CreateThread(function()
	while true do
		sleep = 1000
		if not servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(coordenadas[6]['x'],coordenadas[6]['y'],coordenadas[6]['z'])
			local distance = GetDistanceBetweenCoords(coordenadas[6]['x'],coordenadas[6]['y'],cdz,x,y,z,true)

			if distance <= 10 then
				sleep = 3
				DrawMarker(27,coordenadas[6]['x'],coordenadas[6]['y'],coordenadas[6]['z']-0.95,0,0,0,0,180.0,130.0,1.0,1.0,1.0,8, 8, 8,100,0,0,0,1)
				if distance <= 1.2 then
					drawTxt("PRESSIONE  ~r~E~w~  PARA ~y~INICIAR A ROTA",4,0.5,0.90,0.50,255,255,255,200)
					if IsControlJustPressed(0,38) and emP.checkPermission(coordenadas[6]['perm']) then
						servico = true
						LocalPlayer.state:set('working', true, true)

						servico_motorista = true
						selecionado = math.random(1,27)
						CriandoBlip(locs_motorista,selecionado)
						TriggerEvent("Notify","sucesso","Você entrou em serviço.")
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)



Citizen.CreateThread(function()
	while true do
		sleep = 1000
		if not servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(coordenadas[7]['x'],coordenadas[7]['y'],coordenadas[7]['z'])
			local distance = GetDistanceBetweenCoords(coordenadas[7]['x'],coordenadas[7]['y'],cdz,x,y,z,true)

			if distance <= 10 then
				sleep = 3
				DrawMarker(27,coordenadas[7]['x'],coordenadas[7]['y'],coordenadas[7]['z']-0.95,0,0,0,0,180.0,130.0,1.0,1.0,1.0,8, 8, 8,100,0,0,0,1)
				if distance <= 1.2 then
					drawTxt("PRESSIONE  ~r~E~w~  PARA ~y~INICIAR A ROTA",4,0.5,0.90,0.50,255,255,255,200)
					if IsControlJustPressed(0,38) and emP.checkPermission(coordenadas[7]['perm']) then
						servico = true
						servico_motorista = true
						LocalPlayer.state:set('working', true, true)

						selecionado = math.random(28,54)
						CriandoBlip(locs_motorista,selecionado)
						TriggerEvent("Notify","sucesso","Você entrou em serviço.")
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)



Citizen.CreateThread(function()
	while true do
		sleep = 1000
		if servico_policia then
				local ped = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(ped))
				local bowz,cdz = GetGroundZFor_3dCoord(locs_policia[selecionado].x,locs_policia[selecionado].y,locs_policia[selecionado].z)
				local distance = GetDistanceBetweenCoords(locs_policia[selecionado].x,locs_policia[selecionado].y,cdz,x,y,z,true)

			if distance <= 30.0 then
				sleep = 3
				DrawMarker(21,locs_policia[selecionado].x,locs_policia[selecionado].y,locs_policia[selecionado].z+0.20,0,0,0,0,180.0,130.0,2.0,2.0,1.0,255,230,100,100,1,0,0,1)
				if distance <= 4.5 then
					if emP.checkPermission(coordenadas[1]['perm']) then
						if IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("panto")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiasilverado")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiabmwr1200")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiatahoe")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiataurus")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiavictoria")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiamustanggt")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiaexplorer")) then
							RemoveBlip(blips)
							if selecionado <= 42 then
								selecionado_ant = selecionado
                                repeat
                                    selecionado = math.random(1,42)
                                until selecionado ~= selecionado_ant
							elseif selecionado >= 43 then
								selecionado_ant = selecionado
                                repeat
                                    selecionado = math.random(43,82)
                                until selecionado ~= selecionado_ant
							end							
							emP._secretFunc(math.random(coordenadas[4]['vmin'],coordenadas[4]['vmax']),GetCurrentResourceName())
							CriandoBlip(locs_policia,selecionado)
						end
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)
Citizen.CreateThread(function()
	while true do
		sleep = 1000
		if servico_motorista then
			local ped = PlayerPedId()
			if IsPedInAnyVehicle(ped) then
				local vehicle = GetVehiclePedIsIn(ped)
				local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),locs_motorista[selecionado].x,locs_motorista[selecionado].y,locs_motorista[selecionado].z,true)
				if distance <= 30 then
					sleep = 5
					DrawMarker(21,locs_motorista[selecionado].x,locs_motorista[selecionado].y,locs_motorista[selecionado].z+0.20,0,0,0,0,180.0,130.0,2.0,2.0,1.5,250,100,50,150,1,0,0,1)
					if distance <= 4 then
						if GetPedInVehicleSeat(vehicle,-1) == ped then
							if IsControlJustPressed(0,38) then
								if IsVehicleModel(GetVehiclePedIsUsing(ped),GetHashKey("coach")) or IsVehicleModel(GetVehiclePedIsUsing(ped),GetHashKey("bus")) then
									RemoveBlip(blips)
									if selecionado <= 27 then
										selecionado_ant = selecionado
										repeat
											selecionado = math.random(1,27)
										until selecionado ~= selecionado_ant
									elseif selecionado >= 28 then
										selecionado_ant = selecionado
										repeat
											selecionado = math.random(28,54)
										until selecionado ~= selecionado_ant
									end							
									emP._secretFunc(math.random(coordenadas[6]['vmin'],coordenadas[6]['vmax']),GetCurrentResourceName())
									CriandoBlip(locs_motorista,selecionado)
								end
							end
						end
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)



Citizen.CreateThread(function()
	while true do
		sleep = 1000
		if not servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(coordenadas[1]['x'],coordenadas[1]['y'],coordenadas[1]['z'])
			local distance = GetDistanceBetweenCoords(coordenadas[1]['x'],coordenadas[1]['y'],cdz,x,y,z,true)

			if distance <= 10 then
				sleep = 3
				DrawMarker(27,coordenadas[1]['x'],coordenadas[1]['y'],coordenadas[1]['z']-0.95,0,0,0,0,180.0,130.0,1.0,1.0,1.0,8, 8, 8,100,0,0,0,1)
				if distance <= 1.2 then
					drawTxt("PRESSIONE  ~r~E~w~  PARA ~y~ENTREGAR UMA PIZZA",4,0.5,0.90,0.50,255,255,255,200)
					if IsControlJustPressed(0,38) and emP.checkPermission(coordenadas[1]['perm']) then
						DisableControlAction(0,167,true)
						perm = coordenadas[1]['perm']
						servico = true
						LocalPlayer.state:set('working', true, true)

						servico_pizza = true
						statusobjeto['pizzanamao'] = true
						vRP._CarregarObjeto("anim@heists@box_carry@","idle","prop_pizza_box_02",49,28422)
						selecionado = math.random(#locs_ifood)
						CriandoBlip(locs_ifood,selecionado)
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)



Citizen.CreateThread(function()
	while true do
		sleep = 1000
		if servico_pizza then
			if statusobjeto['pizzanamao'] then
				local ped = PlayerPedId()
				local veh = GetStockPosition(10)
				local coordsStock = GetOffsetFromEntityInWorldCoords(veh, 0.0, -2.8, 0.0)
				local model = GetEntityModel(veh)
				local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),coordsStock.x,coordsStock.y,coordsStock.z,true)
				local displaytext = GetDisplayNameFromVehicleModel(model)
				local name = GetLabelText(displaytext)
				if distance <= 2 and not IsPedInAnyVehicle(ped) then
					sleep = 3
					if name == coordenadas[1]['vehicle'] and GetVehicleNumberPlateText(veh) == vRP.getRegistrationNumber() then
						drawTxt("PRESSIONE  ~r~E~w~  PARA ~y~GUARDAR A PIZZA",4,0.5,0.90,0.50,255,255,255,200)
						if IsControlJustPressed(0,38) and emP.checkPermission(coordenadas[1]['perm']) then
							statusobjeto = {}
							statusobjeto['pizzanamoto'] = true
							TriggerEvent("Notify","importante","Dirija-se até o destino da entrega.")
							vRP._stopAnim(source,false)
							vRP._DeletarObjeto(source)
							DisableControlAction(0,167,false)
						end
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)



Citizen.CreateThread(function()
	while true do
		sleep = 1000
		if servico_pizza then
			if statusobjeto['pizzanamoto'] then
				local ped = PlayerPedId()
				if not IsPedInAnyVehicle(ped) then
					local veh = GetStockPosition(10)
					local coordsStock = GetOffsetFromEntityInWorldCoords(veh, 0.0, -2.8, 0.0)
					local model = GetEntityModel(veh)
					local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),coordsStock.x,coordsStock.y,coordsStock.z,true)
					local displaytext = GetDisplayNameFromVehicleModel(model)
					local name = GetLabelText(displaytext)

					if distance <= 2 then
						sleep = 3
						if name == coordenadas[1]['vehicle'] and GetVehicleNumberPlateText(veh) == vRP.getRegistrationNumber() then
							drawTxt("PRESSIONE  ~r~E~w~  PARA ~y~RETIRAR A PIZZA",4,0.5,0.90,0.50,255,255,255,200)
							if IsControlJustPressed(0,38) and emP.checkPermission(coordenadas[1]['perm']) then
								DisableControlAction(0,167,true)
								statusobjeto = {}
								statusobjeto['pizzanamao'] = true
								vRP._CarregarObjeto("anim@heists@box_carry@","idle","prop_pizza_box_02",49,28422)
								TriggerEvent("Notify","importante","Entregue a pizza na porta do local.")
							end
						end
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)



Citizen.CreateThread(function()
	while true do
		sleep = 1000
		if servico_pizza then
				local ped = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(ped))
				local bowz,cdz = GetGroundZFor_3dCoord(locs_ifood[selecionado].x,locs_ifood[selecionado].y,locs_ifood[selecionado].z)
				local distance = GetDistanceBetweenCoords(locs_ifood[selecionado].x,locs_ifood[selecionado].y,cdz,x,y,z,true)

			if distance <= 30.0 then
				sleep = 3
				DrawMarker(21,locs_ifood[selecionado].x,locs_ifood[selecionado].y,locs_ifood[selecionado].z+0.20,0,0,0,0,180.0,130.0,2.0,2.0,1.0,255,230,100,100,1,0,0,1)
				if distance <= 4.5 then
					if IsControlJustPressed(0,38) and emP.checkPermission(perm) and statusobjeto['pizzanamao'] and not IsPedInAnyVehicle(ped) then
						servico = false
						LocalPlayer.state:set('working', false, true)

						servico_pizza = false
						statusobjeto = {}
						RemoveBlip(blips)				
						emP._secretFunc(math.random(coordenadas[1]['vmin'],coordenadas[1]['vmax']),GetCurrentResourceName())
						vRP._stopAnim(source,false)
						vRP._DeletarObjeto(source)
						DisableControlAction(0,167,false)
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)



Citizen.CreateThread(function()
	while true do
		sleep = 1000
		if not servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(coordenadas[3]['x'],coordenadas[3]['y'],coordenadas[3]['z'])
			local distance = GetDistanceBetweenCoords(coordenadas[3]['x'],coordenadas[3]['y'],cdz,x,y,z,true)

			if distance <= 10 then
				sleep = 3
				DrawMarker(27,coordenadas[3]['x'],coordenadas[3]['y'],coordenadas[3]['z']-0.95,0,0,0,0,180.0,130.0,1.0,1.0,1.0,8, 8, 8,100,0,0,0,1)
				if distance <= 1.2 then
					drawTxt("PRESSIONE  ~r~E~w~  PARA ~y~ENTREGAR UMA MALETA DE DOCUMENTOS",4,0.5,0.90,0.50,255,255,255,200)
					if IsControlJustPressed(0,38) and emP.checkPermission(coordenadas[3]['perm']) then
						DisableControlAction(0,167,true)
						perm = coordenadas[3]['perm']
						servico = true
						LocalPlayer.state:set('working', true, true)

						servico_motoboy = true
						statusobjeto['maletanamao'] = true
						vRP._CarregarObjeto("","","prop_ld_case_01_s",50,57005,0.16,0,0,0,260.0,60.0)
						selecionado = math.random(#locs_motoboy)
						CriandoBlip(locs_motoboy,selecionado)
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)



Citizen.CreateThread(function()
	while true do
		sleep = 1000
		if servico_motoboy then
			if statusobjeto['maletanamao'] then
				local ped = PlayerPedId()
				local veh = GetStockPosition(10)
				local coordsStock = GetOffsetFromEntityInWorldCoords(veh, 0.0, -2.8, 0.0)
				local model = GetEntityModel(veh)
				local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),coordsStock.x,coordsStock.y,coordsStock.z,true)
				local displaytext = GetDisplayNameFromVehicleModel(model)
				local name = GetLabelText(displaytext)

				if distance <= 2 and not IsPedInAnyVehicle(ped) then
					sleep = 3
					if name == coordenadas[3]['vehicle'] and GetVehicleNumberPlateText(veh) == vRP.getRegistrationNumber() then
						drawTxt("PRESSIONE  ~r~E~w~  PARA ~y~GUARDAR A MALETA",4,0.5,0.90,0.50,255,255,255,200)
						if IsControlJustPressed(0,38) and emP.checkPermission(coordenadas[1]['perm']) then
							statusobjeto = {}
							statusobjeto['maletanamoto'] = true
							TriggerEvent("Notify","importante","Dirija-se até o destino da entrega.")
							vRP._stopAnim(source,false)
							vRP._DeletarObjeto(source)
							DisableControlAction(0,167,false)
						end
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)



Citizen.CreateThread(function()
	while true do
		sleep = 1000
		if servico_motoboy then
			if statusobjeto['maletanamoto'] then
				local ped = PlayerPedId()
				if not IsPedInAnyVehicle(ped) then
					local veh = GetStockPosition(10)
					local coordsStock = GetOffsetFromEntityInWorldCoords(veh, 0.0, -2.8, 0.0)
					local model = GetEntityModel(veh)
					local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),coordsStock.x,coordsStock.y,coordsStock.z,true)
					local displaytext = GetDisplayNameFromVehicleModel(model)
					local name = GetLabelText(displaytext)

					if distance <= 2 then
						sleep = 3
						if name == coordenadas[3]['vehicle'] and GetVehicleNumberPlateText(veh) == vRP.getRegistrationNumber() then
							drawTxt("PRESSIONE  ~r~E~w~  PARA ~y~RETIRAR A MALETA",4,0.5,0.90,0.50,255,255,255,200)
							if IsControlJustPressed(0,38) and emP.checkPermission(coordenadas[1]['perm']) then
								DisableControlAction(0,167,true)
								statusobjeto = {}
								statusobjeto['maletanamao'] = true
								vRP._CarregarObjeto("","","prop_ld_case_01_s",50,57005,0.16,0,0,0,260.0,60.0)
								TriggerEvent("Notify","importante","Entregue a maleta na porta do local.")
							end
						end
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)



Citizen.CreateThread(function()
	while true do
		sleep = 1000
		if servico_motoboy then
				local ped = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(ped))
				local bowz,cdz = GetGroundZFor_3dCoord(locs_motoboy[selecionado].x,locs_motoboy[selecionado].y,locs_motoboy[selecionado].z)
				local distance = GetDistanceBetweenCoords(locs_motoboy[selecionado].x,locs_motoboy[selecionado].y,cdz,x,y,z,true)

			if distance <= 30.0 then
				sleep = 3
				DrawMarker(21,locs_motoboy[selecionado].x,locs_motoboy[selecionado].y,locs_motoboy[selecionado].z+0.20,0,0,0,0,180.0,130.0,2.0,2.0,1.0,255,230,100,100,1,0,0,1)
				if distance <= 4.5 then
					if IsControlJustPressed(0,38) and emP.checkPermission(perm) and statusobjeto['maletanamao'] and not IsPedInAnyVehicle(ped) then
						servico = false
						LocalPlayer.state:set('working', false, true)

						servico_motoboy = false
						statusobjeto = {}
						RemoveBlip(blips)				
						emP._secretFunc(math.random(coordenadas[3]['vmin'],coordenadas[3]['vmax']),GetCurrentResourceName())
						vRP._stopAnim(source,false)
						vRP._DeletarObjeto(source)
						DisableControlAction(0,167,false)
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)



Citizen.CreateThread(function()
	while true do
		sleep = 1000
		if not servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(coordenadas[2]['x'],coordenadas[2]['y'],coordenadas[2]['z'])
			local distance = GetDistanceBetweenCoords(coordenadas[2]['x'],coordenadas[2]['y'],cdz,x,y,z,true)

			if distance <= 10 then
				sleep = 3
				DrawMarker(27,coordenadas[2]['x'],coordenadas[2]['y'],coordenadas[2]['z']-0.95,0,0,0,0,180.0,130.0,1.0,1.0,1.0,8, 8, 8,100,0,0,0,1)
				if distance <= 1.2 then
					drawTxt("PRESSIONE  ~r~E~w~  PARA ~y~ENTREGAR AS COMPRAS",4,0.5,0.90,0.50,255,255,255,200)
					if IsControlJustPressed(0,38) and emP.checkPermission(coordenadas[2]['perm']) then
						if tempo == 0 then
							DisableControlAction(0,167,true)
							perm = coordenadas[2]['perm']
							compras_carregar = math.random(2,12)
							TriggerEvent("Notify","importante","Carregue as "..compras_carregar.." encomendas antes de sair para entrega.")
							servico = true
						LocalPlayer.state:set('working', true, true)

							servico_mercado = true
							statusobjeto['comprasnamao'] = true
							vRP._CarregarObjeto("anim@heists@box_carry@","idle","hei_prop_heist_box",49,28422)
						else
							TriggerEvent("Notify","negado","Você cancelou uma entrega recentemente e precisa esperar "..tempo.." para começar outra.")
						end
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)



Citizen.CreateThread(function()
	while true do
		sleep = 1000
		if servico and compras_carregar > 0 and not statusobjeto['comprasnamao'] then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(coordenadas[2]['x'],coordenadas[2]['y'],coordenadas[2]['z'])
			local distance = GetDistanceBetweenCoords(coordenadas[2]['x'],coordenadas[2]['y'],cdz,x,y,z,true)

			if distance <= 10 then
				sleep = 3
				DrawMarker(27,coordenadas[2]['x'],coordenadas[2]['y'],coordenadas[2]['z']-0.95,0,0,0,0,180.0,130.0,1.0,1.0,1.0,8, 8, 8,100,0,0,0,1)
				if distance <= 1.2 then
					drawTxt("PRESSIONE  ~r~E~w~  PARA ~y~PEGAR AS COMPRAS",4,0.5,0.90,0.50,255,255,255,200)
					if IsControlJustPressed(0,38) and emP.checkPermission(coordenadas[2]['perm']) then
						DisableControlAction(0,167,true)
						perm = coordenadas[2]['perm']
						servico = true

						LocalPlayer.state:set('working', true, true)

						servico_mercado = true
						statusobjeto['comprasnamao'] = true
						vRP._CarregarObjeto("anim@heists@box_carry@","idle","hei_prop_heist_box",49,28422)
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)



Citizen.CreateThread(function()
	while true do
		sleep = 1000
		if servico_mercado and compras_carregar > 0 then
			if statusobjeto['comprasnamao'] then
				local ped = PlayerPedId()
				local veh = GetStockPosition(10)
				local coordsStock = GetOffsetFromEntityInWorldCoords(veh, 0.0, -2.8, 0.0)
				local model = GetEntityModel(veh)
				local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),coordsStock.x,coordsStock.y,coordsStock.z,true)
				local displaytext = GetDisplayNameFromVehicleModel(model)
				local name = GetLabelText(displaytext)

				if distance <= 2 and not IsPedInAnyVehicle(ped) then
					sleep = 3
					if name == coordenadas[2]['vehicle'] and GetVehicleNumberPlateText(veh) == vRP.getRegistrationNumber() then
						local porta = IsVehicleDoorFullyOpen(veh, 3 )
						local porta2 = IsVehicleDoorFullyOpen(veh, 2 )
						if not porta and not porta2 then
							SetVehicleDoorOpen(veh, 3, false, false)
							SetVehicleDoorOpen(veh, 2, false, false)
						end
						drawTxt("PRESSIONE  ~r~E~w~  PARA ~y~GUARDAR A ENCOMENDA",4,0.5,0.90,0.50,255,255,255,200)
						if IsControlJustPressed(0,38) and emP.checkPermission(coordenadas[2]['perm']) then
							statusobjeto = {}
							statusobjeto['comprasnavan'] = true
							FreezeEntityPosition(ped,true)
							vRP._DeletarObjeto(source)
							RequestAnimDict("anim@heists@money_grab@briefcase")
							while not HasAnimDictLoaded("anim@heists@money_grab@briefcase") do
								Citizen.Wait(0) 
							end
							TaskPlayAnim(ped,"anim@heists@money_grab@briefcase","put_down_case",100.0,200.0,0.3,120,0.2,0,0,0)
							Wait(800)
							vRP._stopAnim(source,false)
							FreezeEntityPosition(ped,false)
							
							DisableControlAction(0,167,false)

							compras_carregar = compras_carregar - 1
							compras_entregar = compras_entregar + 1

							CaixaVan(veh,model)

							if compras_carregar == 0 then
								selecionado = math.random(#locs_mercado)
								CriandoBlip(locs_mercado,selecionado)
								SetVehicleDoorShut(veh, 3, false)
				        		SetVehicleDoorShut(veh, 2, false)
								TriggerEvent("Notify","importante","Dirija-se até o destino das entregas.")
							else
								TriggerEvent("Notify","importante","Ainda falta carregar "..compras_carregar.." encomendas.")
							end
						end
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)



Citizen.CreateThread(function()
	while true do
		sleep = 1000
		if servico_mercado and compras_carregar == 0 then
			if statusobjeto['comprasnavan'] then
				local ped = PlayerPedId()
				if not IsPedInAnyVehicle(ped) then
					local veh = GetStockPosition(10)
					local coordsStock = GetOffsetFromEntityInWorldCoords(veh, 0.0, -2.8, 0.0)
					local model = GetEntityModel(veh)
					local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),coordsStock.x,coordsStock.y,coordsStock.z,true)
					local displaytext = GetDisplayNameFromVehicleModel(model)
					local name = GetLabelText(displaytext)

					if distance <= 2 then
						sleep = 3
						if name == coordenadas[2]['vehicle'] and GetVehicleNumberPlateText(veh) == vRP.getRegistrationNumber() then
							drawTxt("PRESSIONE  ~r~E~w~  PARA ~y~RETIRAR A ENCOMENDA",4,0.5,0.90,0.50,255,255,255,200)
							if IsControlJustPressed(0,38) and emP.checkPermission(coordenadas[2]['perm']) then
								DisableControlAction(0,167,true)
								SetVehicleDoorOpen(veh, 3, false, false)
								SetVehicleDoorOpen(veh, 2, false, false)
								Wait(800)
								FreezeEntityPosition(ped,true)
								RequestAnimDict("pickup_object")
								while not HasAnimDictLoaded("pickup_object") do
									Citizen.Wait(0) 
								end
								TaskPlayAnim(ped,"pickup_object","pickup_low",100.0,200.0,0.3,120,0.2,0,0,0)
								Wait(700)
								ClearPedTasksImmediately(ped)
								FreezeEntityPosition(ped,false)
								vRP._CarregarObjeto("anim@heists@box_carry@","idle","hei_prop_heist_box",50,28422)
								TirarCaixa()
								statusobjeto = {}
								statusobjeto['comprasnamao'] = true
	
								TriggerEvent("Notify","importante","Entregue a encomenda na porta do local.")
								SetVehicleDoorShut(veh, 3, false)
				        		SetVehicleDoorShut(veh, 2, false)
								
								compras_entregar = compras_entregar - 1
							end
						end
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)



Citizen.CreateThread(function()
	while true do
		sleep = 1000
		if servico_mercado and compras_carregar == 0 then
			if statusobjeto['comprasnamao'] then
				local ped = PlayerPedId()
				if not IsPedInAnyVehicle(ped) then
					local veh = GetStockPosition(10)
					local coordsStock = GetOffsetFromEntityInWorldCoords(veh, 0.0, -2.8, 0.0)
					local model = GetEntityModel(veh)
					local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),coordsStock.x,coordsStock.y,coordsStock.z,true)
					local displaytext = GetDisplayNameFromVehicleModel(model)
					local name = GetLabelText(displaytext)

					if distance <= 2 then
						sleep = 3
						if name == coordenadas[2]['vehicle'] and GetVehicleNumberPlateText(veh) == vRP.getRegistrationNumber() then
							drawTxt("PRESSIONE  ~r~E~w~  PARA ~y~GUARDAR A ENCOMENDA",4,0.5,0.90,0.50,255,255,255,200)
							if IsControlJustPressed(0,38) and emP.checkPermission(coordenadas[2]['perm']) then
								statusobjeto = {}
								statusobjeto['comprasnavan'] = true
								SetVehicleDoorOpen(veh, 3, false, false)
								SetVehicleDoorOpen(veh, 2, false, false)
								Wait(800)
								FreezeEntityPosition(ped,true)
								vRP._DeletarObjeto(source)
								RequestAnimDict("anim@heists@money_grab@briefcase")
								while not HasAnimDictLoaded("anim@heists@money_grab@briefcase") do
									Citizen.Wait(0) 
								end
								TaskPlayAnim(ped,"anim@heists@money_grab@briefcase","put_down_case",100.0,200.0,0.3,120,0.2,0,0,0)
								Wait(800)
								vRP._stopAnim(source,false)
								FreezeEntityPosition(ped,false)
								
								DisableControlAction(0,167,false)

								compras_entregar = compras_entregar + 1

								CaixaVan(veh,model)
								vRP._DeletarObjeto(source)

								Citizen.Wait(500)
								SetVehicleDoorShut(veh, 3, false)
				        		SetVehicleDoorShut(veh, 2, false)
							end
						end
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)



Citizen.CreateThread(function()
	while true do
		sleep = 1000
		if servico_mercado and compras_entregar >= 0 and compras_carregar == 0 then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(locs_mercado[selecionado].x,locs_mercado[selecionado].y,locs_mercado[selecionado].z)
			local distance = GetDistanceBetweenCoords(locs_mercado[selecionado].x,locs_mercado[selecionado].y,cdz,x,y,z,true)

			if distance <= 30.0 then
				sleep = 3
				DrawMarker(21,locs_mercado[selecionado].x,locs_mercado[selecionado].y,locs_mercado[selecionado].z+0.20,0,0,0,0,180.0,130.0,2.0,2.0,1.0,255,230,100,100,1,0,0,1)
				if distance <= 4.5 then
					if IsControlJustPressed(0,38) and emP.checkPermission(perm) and statusobjeto['comprasnamao'] and not IsPedInAnyVehicle(ped) then
						RemoveBlip(blips)	
						statusobjeto = {}	
						statusobjeto['comprasnavan'] = true		
						emP._secretFunc(math.random(coordenadas[2]['vmin'],coordenadas[2]['vmax']),GetCurrentResourceName())
						selecionado_ant = selecionado
						if compras_entregar > 0 then
							repeat
								selecionado = math.random(#locs_mercado)
							until selecionado ~= selecionado_ant
							CriandoBlip(locs_mercado,selecionado)
						end
						vRP._stopAnim(source,false)
						vRP._DeletarObjeto(source)
						DisableControlAction(0,167,false)

						if compras_entregar == 0 then
							statusobjeto = {}	
							servico = false
							LocalPlayer.state:set('working', false, true)

							servico_mercado = false
							if blips then
								RemoveBlip(blips)
							end
							TriggerEvent("Notify","sucesso","Entregas finalizadas.")
						else
							TriggerEvent("Notify","importante","Ainda resta "..compras_entregar.." encomendas para entregar.")
						end
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)



Citizen.CreateThread(function()
	while true do
		sleep = 1000
		if servico_mecanico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(locs_mecanico[selecionado].x,locs_mecanico[selecionado].y,locs_mecanico[selecionado].z)
			local distance = GetDistanceBetweenCoords(locs_mecanico[selecionado].x,locs_mecanico[selecionado].y,cdz,x,y,z,true)

			if distance <= 30.0 then
				sleep = 3
				DrawMarker(21,locs_mecanico[selecionado].x,locs_mecanico[selecionado].y,locs_mecanico[selecionado].z+0.30,0,0,0,0,180.0,130.0,2.0,2.0,1.0,240,200,80,20,1,0,0,1)
				if distance <= 2.5 then
					drawTxt("PRESSIONE  ~b~E~w~  PARA PEGAR AS FERRAMENTAS",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) and emP.checkPermission() then
						if IsVehicleModel(GetVehiclePedIsUsing(ped),GetHashKey("rise-mclassx")) then
							if emP.checkPaymentMec() then
								RemoveBlip(blips)
								backentrega = selecionado
								while true do
									if backentrega == selecionado then
										selecionado = math.random(#locs_mecanico)
									else
										break
									end
									Citizen.Wait(1)
								end
								CriandoBlip(locs_mecanico,selecionado)
							end
						elseif IsVehicleModel(GetVehiclePedIsUsing(ped),GetHashKey("rise-mclassx")) then
							TriggerEvent("Notify","aviso","Você precisa estar dirigindo uma Mercedes Mecanica para realizar entregas!")	
						else
							TriggerEvent("Notify","aviso","Você precisa estar dirigindo um Mercedes Mecanica para realizar entregas!")
						end
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)



RegisterNetEvent('producaokit:animacao')
AddEventHandler('producaokit:animacao', function(head,isPlay)
    if isPlay then
		TriggerEvent('cancelando', true)
		SetEntityHeading(PlayerPedId(),head)
        vRP._playAnim(false, {
            {"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}
        }, true)
    else
        TriggerEvent('cancelando', false)
        ClearPedTasks(PlayerPedId())
    end
end)



Citizen.CreateThread(function()
	while true do
		sleep_cancel = 1000
		if servico then
			sleep_cancel = 3
			if IsControlJustPressed(0,168) then
				if servico_mercado then
					tempo = 60
				end
				servico = false
				LocalPlayer.state:set('working', false, true)

				servico_pizza = false
				servico_motoboy = false
				servico_mercado = false
				servico_mecanico = false
				statusobjeto = {}
				if blips then
					RemoveBlip(blips)
				end
				for k,v in pairs(propcaixa) do
					if DoesEntityExist(propcaixa[k]) then
						DetachEntity(propcaixa[k],false,false)
						FreezeEntityPosition(propcaixa[k],false)
						TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa[k]))
						propcaixa[k] = nil
					end
				end
				TriggerEvent("Notify","aviso","Você saiu de serviço.")
				vRP._stopAnim(source,false)
				vRP._DeletarObjeto(source)
				DisableControlAction(0,167,false)
			end
		end
		Citizen.Wait(sleep_cancel)
	end
end)



Citizen.CreateThread(function()
	while true do
		sleep = 1000
		if tempo > 0 then
			tempo = tempo -1
		end
		Citizen.Wait(sleep)
	end
end)



function GetStockPosition(radius)
	local ped = PlayerPedId()
	local coordsx = GetEntityCoords(ped, 1)
	local coordsy = GetOffsetFromEntityInWorldCoords(ped, 0.0, radius+0.00001, 0.0)
	local nearVehicle = GetStockDirection(coordsx, coordsy)
	if IsEntityAVehicle(nearVehicle) then
	    return nearVehicle
	else
		local x,y,z = table.unpack(coordsx)
	    if IsPedSittingInAnyVehicle(ped) then
	        local veh = GetVehiclePedIsIn(ped,true)
	        return veh
	    else
	        local veh = GetClosestVehicle(x+0.0001,y+0.0001,z+0.0001,radius+0.0001,0,8192+4096+4+2+1) 
	        if not IsEntityAVehicle(veh) then 
	        	veh = GetClosestVehicle(x+0.0001,y+0.0001,z+0.0001,radius+0.0001,0,4+2+1) 
	        end 
	        return veh
	    end
	end
end

function GetStockDirection(coordFrom,coordTo)
	local position = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, PlayerPedId(), 0)
	local a,b,c,d,vehicle = GetRaycastResult(position)
	return vehicle
end

function CaixaVan(veh,model)
	if  compras_entregar <= 12 then
		RequestModel(GetHashKey("hei_prop_heist_box"))
        while not HasModelLoaded(GetHashKey("hei_prop_heist_box")) do
            Citizen.Wait(10)
        end
	    local coords = GetOffsetFromEntityInWorldCoords(veh,0.0,0.0,-5.0)
		if compras_entregar == 12 and model == -1743316013 then
			propcaixa[12] = nil
			propcaixa[12] = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa[12],veh,0.0,-0.25,-2.1,-0.05,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa[12],true)
		elseif compras_entregar == 11 and model == -1743316013 then
			propcaixa[11] = nil
			propcaixa[11] = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa[11],veh,0.0,0.25,-2.1,-0.05,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa[11],true)
		elseif compras_entregar == 10 and model == -1743316013 then
			propcaixa[10] = nil
			propcaixa[10] = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa[10],veh,0.0,-0.25,-1.65,-0.05,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa[10],true)
		elseif compras_entregar == 9 and model == -1743316013 then
			propcaixa[9] = nil
			propcaixa[9] = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa[9],veh,0.0,0.25,-1.65,-0.05,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa[9],true)
		elseif compras_entregar == 8 and model == -1743316013 then
			propcaixa[8] = nil
			propcaixa[8] = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa[8],veh,0.0,-0.75,-1.2,-0.05,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa[8],true)
		elseif compras_entregar == 7 and model == -1743316013 then
			propcaixa[7] = nil
			propcaixa[7] = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa[7],veh,0.0,-0.25,-1.2,-0.05,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa[7],true)
		elseif compras_entregar == 6 and model == -1743316013 then
			propcaixa[6] = nil
			propcaixa[6] = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa[6],veh,0.0,0.25,-1.2,-0.05,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa[6],true)
		elseif compras_entregar == 5 and model == -1743316013 then
			propcaixa[5] = nil
			propcaixa[5] = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa[5],veh,0.0,0.75,-1.2,-0.05,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa[5],true)
		elseif compras_entregar == 4 and model == -1743316013 then
			propcaixa[4] = nil
			propcaixa[4] = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa[4],veh,0.0,-0.75,-0.75,-0.05,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa[4],true)
		elseif compras_entregar == 3 and model == -1743316013 then
			propcaixa[3] = nil
			propcaixa[3] = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa[3],veh,0.0,-0.25,-0.75,-0.05,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa[3],true)
		elseif compras_entregar == 2 and model == -1743316013 then
			propcaixa[2] = nil
			propcaixa[2] = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa[2],veh,0.0,0.25,-0.75,-0.05,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa[2],true)
		elseif compras_entregar == 1 and model == -1743316013 then
			propcaixa[1] = nil
			propcaixa[1] = CreateObject(GetHashKey("hei_prop_heist_box"),coords.x,coords.y,coords.z,true,true,true)
			AttachEntityToEntity(propcaixa[1],veh,0.0,0.75,-0.75,-0.05,0.0,0.0,0.0,false,false,true,false,2,true)
			FreezeEntityPosition(propcaixa[1],true)
		end
	end
end

function TirarCaixa()
	if compras_entregar == 1 then
        if DoesEntityExist(propcaixa[1]) then
			DetachEntity(propcaixa[1],false,false)
			FreezeEntityPosition(propcaixa[1],false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa[1]))
            propcaixa[1] = nil
        end
	elseif compras_entregar == 2 then
		if DoesEntityExist(propcaixa[2]) then
			DetachEntity(propcaixa[2],false,false)
			FreezeEntityPosition(propcaixa[2],false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa[2]))
            propcaixa[2] = nil
        end
	elseif compras_entregar == 3 then
		if DoesEntityExist(propcaixa[3]) then
			DetachEntity(propcaixa[3],false,false)
			FreezeEntityPosition(propcaixa[3],false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa[3]))
            propcaixa[3] = nil
        end
	elseif compras_entregar == 4 then
		if DoesEntityExist(propcaixa[4]) then
			DetachEntity(propcaixa[4],false,false)
			FreezeEntityPosition(propcaixa[4],false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa[4]))
            propcaixa[4] = nil
        end
	elseif compras_entregar == 5 then
		if DoesEntityExist(propcaixa[5]) then
			DetachEntity(propcaixa[5],false,false)
			FreezeEntityPosition(propcaixa[5],false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa[5]))
            propcaixa[5] = nil
        end
	elseif compras_entregar == 6 then
		if DoesEntityExist(propcaixa[6]) then
			DetachEntity(propcaixa[6],false,false)
			FreezeEntityPosition(propcaixa[6],false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa[6]))
            propcaixa[6] = nil
        end
    elseif compras_entregar == 7 then
		if DoesEntityExist(propcaixa[7]) then
			DetachEntity(propcaixa[7],false,false)
			FreezeEntityPosition(propcaixa[7],false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa[7]))
            propcaixa[7] = nil
        end
    elseif compras_entregar == 8 then
		if DoesEntityExist(propcaixa[8]) then
			DetachEntity(propcaixa[8],false,false)
			FreezeEntityPosition(propcaixa[8],false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa[8]))
            propcaixa[8] = nil
        end
    elseif compras_entregar == 9 then
		if DoesEntityExist(propcaixa[9]) then
			DetachEntity(propcaixa[9],false,false)
			FreezeEntityPosition(propcaixa[9],false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa[9]))
            propcaixa[9] = nil
        end
    elseif compras_entregar == 10 then
		if DoesEntityExist(propcaixa[10]) then
			DetachEntity(propcaixa[10],false,false)
			FreezeEntityPosition(propcaixa[10],false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa[10]))
            propcaixa[10] = nil
        end
	elseif compras_entregar == 11 then
		if DoesEntityExist(propcaixa[11]) then
			DetachEntity(propcaixa[11],false,false)
			FreezeEntityPosition(propcaixa[11],false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa[11]))
            propcaixa[11] = nil
        end
	elseif compras_entregar == 12 then
		if DoesEntityExist(propcaixa[12]) then
			DetachEntity(propcaixa[12],false,false)
			FreezeEntityPosition(propcaixa[12],false)
            TriggerServerEvent("trydeleteobj",ObjToNet(propcaixa[12]))
            propcaixa[12] = nil
        end
	end
end

function DrawText3D(x,y,z, text, scl, font) 
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

	local scale = (1/dist)*scl
	local fov = (1/GetGameplayCamFov())*100
	local scale = scale*fov
	if onScreen then
		SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 180)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
	end
end

function DrawText3Ds(x,y,z,text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.34, 0.34)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.001+ factor, 0.028, 0, 0, 0, 78)
end

function CriandoBlip(locs,selecionado)
	blips = AddBlipForCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
	SetBlipSprite(blips,1)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Rota")
	EndTextCommandSetBlipName(blips)
end

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