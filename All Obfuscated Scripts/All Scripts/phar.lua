--[[
	id: A18L2fsH1aaFNfbTlNNph
	name: phar
	description: phar_c
	time1: 2021-05-20 11:10:53.761836+00
	time2: 2021-05-20 11:10:53.761837+00
	uploader: VKsEHnkR9koAw_vMN4g5T3rN54-ovSAaLV31wrPF
	uploadersession: 0jCqJKEB3nL7mhoPqbA6BmVgoZCToj
	flag: f
--]]

-- OGGETTO CHE ESPLODE: prop_tool_blowtorch
local ped = PlayerPedId()

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3000)
		if ped == nil or ped == 0 or ped ~= PlayerPedId() then ped = PlayerPedId() end
	end
end)

function round(num) 
	if num >= 0 then return math.floor(num+.5) 
	else return math.ceil(num-.5) end
end

local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local xPlayer = nil
local MIOCAVALLO = nil
local inTrunk = false

local InfoObjRubati = nil
local venditaRubati = { 
{x=-2956.14, y=385.671, z=14.021}, 
{x=1654.979, y=3820.604, z=34.453}, 
{x=753.39, y=-3182.592, z=6.406}, 
} 

--[[
local store = { 
    [_U('open_store')] = { title="Farmacia", colour=34, id=51, x = 317.993, y = -1076.646, z = 28.479}, 
	[_U('open_store')] = { title="Farmacia Paleto", colour=34, id=51, x=-172.668, y=6385.349, z=31.495}, 	
} 
]]

local chiesa = { 	
	{ title="Motel", colour=7, size=0.5, id=475, x = -96.836, y=6338.735, z=31.49}, 

    { title="Chiesa", colour=19, size=0.5, id=438, x = -1684.822, y = -291.37, z = 51.89}, 
	{ title="Chiesa", colour=19, size=0.5, id=438, x = -766.887, y=-23.366, z=40.081},
	
	--{ title="Autogrill", colour=0, size=0.7, id=269, x=-2185.182, y=4287.01, z=49.182},  -- AUTOGRILL
	
	-- MAZZINI
	{ title="Magazzino", colour=14, size=0.7, id=134, x = -925.667, y=-2037.012, z=9.402},  -- Magazzino Import
	{ title="Magazzino", colour=14, size=0.7, id=134, x = 136.417, y=-2472.406, z=6.095},  -- Magazzino Porto
	{ title="Magazzino", colour=14, size=0.7, id=134, x = 2588.582, y=429.614, z=108.614},  -- Magazzino Tataviam
	{ title="Magazzino", colour=14, size=0.7, id=134, x = 2709.973, y=3455.105, z=56.318},  -- Magazzino Ikea
	{ title="Duplica Chiave Magazzini", colour=5, size=0.7, id=134, x=170.072, y=-1799.52, z=28.316},  -- CHIAVI Magazzino Ikea
	
	{ title="Raccolta Cotone", colour=0, size=0.3, id=57, x=2809.404, y=4757.681, z=46.238},  
	{ title="Fabbrica Tessuto", colour=0, size=0.7, id=366, x=713.266, y=-969.953, z=30.395},  
	{ title="Sede Netturbini", colour=3, size=0.7, id=467, x=871.775, y=-2309.062, z=29.57},
	{ title="Discarica Estero", colour=3, size=0.7, id=467, x=2350.461, y=3122.676, z=47.209}, 
	{ title="Funivia", colour=0, size=0.3, id=36, x=-738.267, y=5594.981, z=40.655}, -- Funivia
	{ title="Affitto Nave", colour=3, size=0.5, id=404, x=-3427.523, y=953.694, z=7.347}, --Affitto Nave 1
	{ title="Affitto Nave", colour=3, size=0.5, id=404, x=-1622.585, y=5265.004, z=0.026}, --Affitto Nave 2
	{ title="Affitto Nave", colour=3, size=0.5, id=404, x=-861.947, y=-1324.625, z=0.605}, --Affitto Nave 3
	
	--[[]]
	
	-- INCOGNITA	
	--[[
	{ title="Incognita", colour=0, size=0.3, id=66, x = 244.885, y=369.519, z=105.738},  -- Vicino al Vanilla
	{ title="Incognita", colour=0, size=0.3, id=66, x = 1047.126, y=-2055.742, z=35.967},  -- Sala Stanza Torture
	{ title="Incognita", colour=0, size=0.3, id=66, x=-387.921, y=2599.995, z=89.539}, -- Casa Foresta 1
	{ title="Incognita", colour=0, size=0.3, id=66, x=302.25, y=4345.575, z=50.95}, -- Casa Foresta 2
	-- { title="Incognita", colour=0, size=0.3, id=66, x=-470.978, y=6288.578, z=13.611}, -- Sala Medici Illegale
	{ title="Incognita", colour=0, size=0.3, id=66, x=948.565, y=-2125.797, z=31.439}, -- incognita Raven Fabbrica Macello
	{ title="Incognita", colour=0, size=0.3, id=66, x=3835.92, y=3670.805, z=-24.056}, -- Tunnel Humane
	{ title="Incognita", colour=0, size=0.3, id=66, x=144.542, y=-2202.259, z=4.688}, -- Sala Torture GTA
	{ title="Incognita", colour=0, size=0.3, id=66, x=-268.773, y=2201.281, z=130.361}, -- Hostage Patoche  
	{ title="Incognita", colour=0, size=0.3, id=66, x=-1296.493, y=-124.398, z=47.607}, -- Tizio Missione Kill	
	{ title="Incognita", colour=0, size=0.3, id=66, x=-1572.36, y=-451.63, z=36.78}, -- Magazzino Armi
	{ title="Incognita", colour=0, size=0.3, id=66, x=1111.76, y=-2341.56, z=31.19}, -- Magazzino Armi 2
	-- { title="Incognita", colour=0, size=0.3, id=66, x=2167.954, y=3331.223, z=45.49}, -- Caravans
	{ title="Incognita", colour=0, size=0.3, id=66, x=-186.362, y=6155.464, z=42.637}, -- Incarico Illegale Weed
	{ title="Incognita", colour=0, size=0.3, id=66, x=-458.597, y=-2274.559, z=8.516}, -- Inizio vendita Materiali
	{ title="Incognita", colour=0, size=0.3, id=66, x=464.278, y=-3025.41, z=24.344}, -- Colpo al Porto Merry
	{ title="Incognita", colour=0, size=0.3, id=66, x=274.298, y=-1108.419, z=87.815}, -- Bot Tetto
	{ title="Incognita", colour=0, size=0.3, id=66, x=-613.546, y=-1629.226, z=33.011},  -- Kron Base
	{ title="Incognita", colour=0, size=0.3, id=66, x=-62.399, y=-1532.668, z=33.235},  -- Casetta Gang
	{ title="Incognita", colour=0, size=0.3, id=66, x=-3179.288, y=1093.35, z=19.841},  -- Biker Nascosto
	{ title="Incognita", colour=0, size=0.3, id=66, x=-91.387, y=6514.478, z=31.1},  -- Biker Nascosto 2
	{ title="Incognita", colour=0, size=0.3, id=66, x=-113.623, y=6465.419, z=31.627},  -- Vendi Oro
	{ title="Incognita", colour=0, size=0.3, id=66, x=194.857, y=-3174.523, z=13.783},  -- Missione Carico Oro Barbone	
	{ title="Incognita", colour=0, size=0.3, id=66, x=602.83, y=-435.967, z=23.757}, -- DA COMPLETARE UN INCARICO	
	{ title="Incognita", colour=0, size=0.3, id=66, x=170.212, y=6375.562, z=31.335}, -- Magazzino Paleto Bay
	{ title="Incognita", colour=0, size=0.3, id=66, x=409.549, y=6507.994, z=27.919}, -- Fattoria 3027
	{ title="Incognita", colour=0, size=0.3, id=66, x=171.0052, y=-1256.568, z=13.19834}, -- FightCLub	
	{ title="Incognita", colour=0, size=0.3, id=66, x=-309.75, y=4638.528, z=225.288}, -- Mini Villa 
	
	{ title="Incognita", colour=0, size=0.3, id=66, x=695.343, y=-808.884, z=43.523}, -- VENDITA LESTER
	{ title="Incognita", colour=0, size=0.3, id=66, x=1137.772, y=-991.408, z=46.113}, -- Lavanderia Abbandonata
	{ title="Incognita", colour=0, size=0.3, id=66, x=810.198, y=-494.02, z=30.688}, -- Medico Illegale Citta
	{ title="Incognita", colour=0, size=0.3, id=66, x=53.577, y=-2676.501, z=6.009}, -- Porto Vendita Illegale
	{ title="Incognita", colour=0, size=0.3, id=66, x=-354.237, y=4825.414, z=143.294}, -- Vendita di qualcosa di Illegale
	{ title="Incognita", colour=0, size=0.3, id=66, x=-1032.868, y=-2855.51, z=43.558}, -- Spedizione Mercato Nero 1
	]]
	
	--{ title="Incognita", colour=0, size=0.5, id=66, x=-1110.529, y=4938.443, z=218.45}, -- Incognita Nudist
	--[[
	{ title="Incognita", colour=0, size=0.3, id=66, x=-3180.543, y=1244.48, z=6.8}, -- Consegna Soldi Rapina Banca
	{ title="Incognita", colour=0, size=0.3, id=66, x=591.985, y=2783.078, z=43.481}, -- Consegna Soldi Rapina Banca
	{ title="Incognita", colour=0, size=0.3, id=66, x=-380.737, y=6085.188, z=39.615}, -- Consegna Soldi Rapina Banca
	{ title="Incognita", colour=0, size=0.3, id=66, x=1480.949, y=6340.725, z=18.677}, -- Consegna Soldi Rapina Banca
	]]
	
	--[[
	{ title="Skate Park", colour=0, size=0.4, id=120, x=-1384.462, y=-1423.806, z=2.59}, -- SkatePark
	{ title="Skate Park", colour=0, size=0.4, id=120, x=1946.951, y=3766.061, z=33.20574}, -- SkatePark
	{ title="Skate Park", colour=0, size=0.4, id=120, x=278.252, y=-198.767, z=61.571}, -- SkatePark
	{ title="Skate Park", colour=0, size=0.4, id=120, x=-940.367, y=-792.637, z=15.951}, -- SkatePark
	{ title="Skate Park", colour=0, size=0.4, id=120, x=765.171, y=-1224.276, z=25.227}, -- SkatePark
	{ title="Skate Park", colour=0, size=0.4, id=120, x=839.602, y=-257.059, z=65.632}, -- SkatePark
	]]
	
	--{ title="Classe OOC", colour=0, size=0.5, id=484, x=-919.504, y=-2021.725, z=9.402}, -- Scuola Roleplay
	{ title="Municipio", colour=0, size=0.7, id=525, x=-263.789, y=-966.299, z=31.224}, -- Municipio	
	--{ title="Municipio Paleto", colour=0, size=0.7, id=525, x=-146.11, y=6303.829, z=31.56}, -- Municipio	
	
	--{ title="Ospedale", colour=41, size=0.7, id=417, x=1838.7, y=3673.915, z=34.277}, -- Ospedale Snady
	--{ title="Stadio", colour=0, size=0.5, id=546, x=-255.775, y=-2026.255, z=30.146}, -- Stadio	
	--{ title="Rapina Portavalori", colour=1, size=0.5, id=318, x = 960.71197509766, y = -215.51979064941, z = 76.2552947998}, -- Rapina Portavalori
	
	--{ title="Officina Meccanica", colour=0, size=0.9, id=544, x = 722.627, y=-1088.552, z=22.195}, -- Nuovo Meccanico
	--{ title="Officina Meccanica", colour=0, size=0.9, id=544, x = -201.01, y = -1317.9, z = 30.09}, -- Nuovo Meccanico
	
	--{ title="Libreria", colour=44, size=0.7, id=354, x=251.18, y=-1596.406, z=31.536}, -- Libreria
	--{ title="Agenzia Immobiliare", colour=0, size=0.7, id=492, x=-705.647, y=269.319, z=83.147}, -- Dynasty8
	
	{ title="Officina", colour=3, size=0.7, id=544, x=-335.757, y=-135.633, z=39.01}, -- Dynasty8
	
	{ title="Uber Eats", colour=5, size=0.3, id=57, x=-1604.27 ,y=-832.32, z=9.09}, -- Uber
	--{ title="Maze Bank", colour=75, size=0.7, id=78, x=-1317.65, y=-832.009, z=16.97}, -- Maze Bank	
	--{ title="Farmacia", colour=5, size=0.7, id=51, x = 317.993, y = -1076.646, z = 28.479}, -- Farmacia
	--{ title="Farmacia", colour=5, size=0.7, id=51, x=-172.668, y=6385.349, z=31.495}, -- Farmacia	
	{ title="Gioielleria", colour=0, size=0.5, id=617, x=-631.889, y=-237.842, z=38.074}, --Gioielleria	
	--{ title="Affitto Bici Montagna", colour=0, size=0.5, id=376, x=-2247.771, y=4336.863, z=44.121}, --Affitto Bici
	--{ title="Affitto Bici Montagna", colour=0, size=0.5, id=376, x=2704.191, y=5148.806, z=43.723}, --Affitto bici
	--{ title="Area Pic-nic", colour=0, size=0.5, id=565, x=2947.971, y=5326.187, z=100.944}, 
	{ title="Palestra", colour=0, size=0.5, id=311, x=-45.703, y=-1289.935, z=29.504}, --Gym
	{ title="Campo Calcio", colour=0, size=0.5, id=366, x=810.3928, y=-232.1471, z=65.16911}, -- Campo Calcio
	{ title="Panfilo", colour=0, size=0.5, id=455, x=-1389.672, y=6742.673, z=11.981}, 
	{ title="Panfilo", colour=0, size=0.5, id=455, x=-2037.843, y=-1033.203, z=8.971}, 
	{ title="FIB", colour=44, size=0.5, id=475, x=105.255, y=-744.417, z=44.755}, 
	{ title="Humane Labs", colour=0, size=0.7, id=499, x=3628.311, y=3753.659, z=28.516}, 
	--{ title="Macello", colour=0, size=0.7, id=141, x=994.751, y=-2182.574, z=29.979}, 
	{ title="Paracadutismo", colour=0, size=0.5, id=94, x=-747.464, y=-2085.839, z=11.735}, 
	{ title="Autostazione", colour=0, size=0.5, id=76, x=466.395, y=-576.539, z=27.5}, 
	{ title="Ufficio Giornalisti", colour=47, size=0.5, id=564, x=-1055.485, y=-242.893, z=43.021}, 
	{ title="Affitto Party Bus", colour=47, size=0.5, id=136, x=1224.713, y=2728.688, z=37.005}, 
	{ title="Predator Polizia", colour=3, size=0.5, id=427, x=-806.156, y=-1496.809, z=1.595}, 
	{ title="Ufficio Procuratore", colour=0, size=0.7, id=457, x=-937.659, y=-2036.57, z=11.833}, 
	{ title="Ufficio Sindaco", colour=0, size=0.7, id=457, x=-1003.297, y=-477.964, z=49.027}, 	
	--{ title="Ikea", colour=0, size=0.7, id=569, x=2748.243, y=3484.037, z=55.67}, -- Da completare prima
	{ title="Zona Ostriche", colour=0, size=0.5, id=68, x=2829.771, y=-1320.576, z=2.304}, 
	{ title="Zona Ostriche", colour=0, size=0.5, id=68, x=4277.008, y=4395.074, z=-63.778}, 
	{ title="Zona Ostriche", colour=0, size=0.5, id=68, x=3509.452, y=5627.407, z=-20.68}, 
	{ title="Zona Gamberi", colour=0, size=0.5, id=68, x=1907.226, y=6686.153, z=0.786},
	{ title="Zona Gamberi", colour=0, size=0.5, id=68, x=15.761, y=7264.228, z=3.67},
	{ title="Vendita Cozze Sabbia", colour=40, size=0.5, id=68, x=2815.417, y=-668.27, z=0.224},
	--{ title="Zona Pesca Acqua Dolce", colour=3, size=0.4, id=68, x=1892.404, y=77.772, z=171.44},
	--{ title="Zona Pesca Acqua Dolce", colour=3, size=0.4, id=68, x=1129.938, y=-185.474, z=52.675},
	--{ title="Zona Pesca Acqua Dolce", colour=3, size=0.4, id=68, x=57.139, y=826.872, z=197.58},
	--{ title="Zona Pesca Acqua Dolce", colour=3, size=0.4, id=68, x=814.294, y=3926.092, z=31.352},
	{ title="Vendita Cozze Pulite", colour=40, size=0.5, id=68, x=-207.464, y=6576.871, z=10.02},
	{ title="Vendita Carpa Leggera", colour=3, size=0.5, id=68, x=-2184.908, y=4283.863, z=48.182},
	--{ title="Costiera Cozze", colour=40, size=0.5, id=68, x=2322.927, y=-2125.297, z=2.164},
	{ title="Discarica", colour=3, size=0.7, id=467, x=725.013, y=-924.791, z=26.874},
	{ title="Rimozione Forzata", colour=15, size=0.7, id=147, x=490.893, y=-1330.977, z=28.34},
	{ title="Latte", colour=0, size=0.5, id=77, x=2251.478, y=5155.481, z=57.887},
	{ title="Moto d'acqua", colour=53, size=0.7, id=471, x=-3017.077, y=-6.773, z=1.047},
	{ title="Pollaio", colour=5, size=0.5, id=267, x=2386.491, y=5028.405, z=45.016},
	{ title="Lavorazione Pollo", colour=5, size=0.7, id=85, x=-69.886, y=6250.679, z=31.084},
	{ title="Pista", colour=0, size=0.5, id=38, x=-169.35, y=-2154.67, z=17.51},
	{ title="Pista", colour=0, size=0.5, id=38, x=1214.07, y=2371.83, z=63.94},
	{ title="Ingrosso Import", colour=0, size=0.5, id=478, x=-455.602, y=-2807.503, z=5.0},
	{ title="Spedizioni Armeria", colour=0, size=0.5, id=478, x=-1284.3, y=-3419.728, z=13.94},	
	{ title="Carico Legna Grande", colour=5, size=0.5, id=478, x=-579.169, y=5355.243, z=69.214}, -- Genera Cassa Legno
	{ title="Genera Carico Birra", colour=82, size=0.5, id=478, x=750.485, y=-1834.874, z=28.292}, -- Genera Cassa Birra
	
	--{ title="Legacy", colour=0, size=0.7, id=38, x=-1305.52, y=311.681, z=65.78},
	
	{ title="Tribunale", colour=0, size=0.5, id=457, x=-544.602, y=-204.739, z=38.218}, 
	{ title="Affitto Deltaplano", colour=0, size=0.5, id=94, x=488.829, y=5635.995, z=787.847}, 
	
	--[[
	-- Affitto Manchez / Bmx / Mountain
	{ title="Affitto", colour=65, size=0.7, id=153, x=264.435, y=-188.265, z=60.571},
	{ title="Affitto", colour=65, size=0.7, id=153, x=-950.639, y=-798.636, z=14.921},
	{ title="Affitto", colour=65, size=0.7, id=153, x=821.891, y=-261.436, z=64.221},
	{ title="Affitto", colour=65, size=0.7, id=153, x=1943.91, y=3769.423, z=31.185},
	{ title="Affitto", colour=65, size=0.7, id=153, x=765.265, y=-1225.359, z=24.208},
	{ title="Affitto", colour=65, size=0.7, id=153, x=-1384.462, y=-1423.806, z=2.59},
	{ title="Affitto", colour=65, size=0.7, id=153, x=-2247.771, y=4336.863, z=44.121},
	{ title="Affitto", colour=65, size=0.7, id=153, x=2704.191, y=5148.806, z=42.723},
	{ title="Affitto", colour=65, size=0.7, id=153, x=-2027.415, y=-133.096, z=27.249},
	{ title="Affitto", colour=65, size=0.7, id=153, x=-2000.122, y=-498.402, z=10.49},
	{ title="Affitto", colour=65, size=0.7, id=153, x=-1082.985, y=4349.136, z=13.707},
	{ title="Affitto", colour=65, size=0.7, id=153, x=-1491.15, y=4979.697, z=62.399},
	{ title="Affitto", colour=65, size=0.7, id=153, x=452.703, y=2413.305, z=46.367},
	]]
	
	-- QUARTIERE CON MONOLOCALI
	--{ title="Quartiere", colour=0, size=0.5, id=40, x=364.956, y=-2014.239, z=23.177},
	
	-- LAVAGGIO AUTO
	{ title="Autolavaggio", colour=0, size=0.5, id=147, x=26.5906,  y=-1392.0261,  z=27.3634}, -- Lavaggio
	{ title="Autolavaggio", colour=0, size=0.5, id=147, x=167.1034,  y=-1719.4704,  z=27.2916}, -- Lavaggio
	{ title="Autolavaggio", colour=0, size=0.5, id=147, x=-74.5693,  y=6427.8715,  z=29.4400}, -- Lavaggio
	{ title="Autolavaggio", colour=0, size=0.5, id=147, x=-699.6325,  y=-932.7043,  z=17.0139}, -- Lavaggio
	{ title="Autolavaggio", colour=0, size=0.5, id=147, x=1362.5385, y=3592.1274, z=33.9211} -- Lavaggio
} 

-- QUESTO E' UNO SPAWN DI BLIP SENZA FUNZIONE
local vanilla = { 
    --{ title="Rapina Vanilla", size=0.7, colour=59, id=429, x = 94.97, y = -1292.78, z = 29.27}, 
	
	
	{ title="Locale", size=0.5, colour=0, id=93, x=-299.437,y=6255.128,z=31.536}, -- Locale Paleto 
	{ title="Locale", size=0.5, colour=0, id=93, x=755.646,y=-557.829,z=33.643}, -- Medusa breze
	{ title="Locale", size=0.5, colour=0, id=93, x=119.383, y=-1286.895, z=28.27}, -- Vanilla
	{ title="Locale", size=0.5, colour=0, id=93, x=-1387.424, y=-588.822, z=30.32},  -- Bahamas
	{ title="Locale", size=0.5, colour=0, id=93, x=1945.822, y=3840.61, z=32.181}, -- Da Completare Nailands a Sandy
	{ title="Locale", size=0.5, colour=0, id=93, x=-1816.708, y=-1194.009, z=14.305}, -- Da Completare Pearls
	{ title="Locale", size=0.5, colour=0, id=93, x=-1348.749, y=-1077.796, z=6.942}, -- Da Completare Ristorante Russo
	{ title="Locale", size=0.5, colour=0, id=93, x=1986.359, y=3049.774, z=47.215}, -- Yellow Jack
	{ title="Locale", size=0.5, colour=0, id=93, x=981.701, y=-102.822, z=73.848}, -- LostMC
	{ title="Locale", size=0.5, colour=0, id=93, x=-2190.095, y=-399.755, z=13.295}, -- GALAXY
	{ title="Locale", size=0.5, colour=0, id=93, x=-2998.248, y=55.368, z=12.263}, -- Medusa
	{ title="Locale", size=0.5, colour=0, id=93, x=412.087, y=-1488.02, z=29.15}, -- Ristorante Salieri 
	{ title="Locale", size=0.5, colour=0, id=93, x=135.247, y=323.119, z=115.634}, -- Lost MC breeze
	{ title="Locale", size=0.5, colour=0, id=93, x=759.548, y=-816.044, z=25.302}, -- Arcade
	
	--{ title="Funivia", size=0.5, colour=0, id=36, x=446.288, y=5574.09, z=782.238}, 
	--{ title="Funivia", size=0.5, colour=0, id=36, x=-739.936, y=5595.25, z=41.655},
	
	-- BLIP AFFITTO CAVALLO
	{ title="Affitto Cavallo", size=0.5, colour=31, id=270, x=2194.183, y=5596.343, z=53.762}, 
	{ title="Affitto Cavallo", size=0.5, colour=31, id=270, x=505.98, y=2615.474, z=42.96}, 
	{ title="Affitto Cavallo", size=0.5, colour=31, id=270, x=286.21, y=6788.389, z=14.696}, 
	{ title="Affitto Cavallo", size=0.5, colour=31, id=270, x=-1637.557, y=4566.656, z=43.123}, 
	{ title="Affitto Cavallo", size=0.5, colour=31, id=270, x=-446.813, y=1600.255, z=357.324},
	--{ title="Affitto Cavallo", size=0.7, colour=31, id=270, x=1486.001, y=1066.868, z=113.334}, -- Alla Fluente non lo mostro
} 

-- POSIZIONE FUUNZIONI CAVALLO AFFITTO
local cavallo = { 
	-- QUESTE POSIZIONI DEVONO ESSERE LE STESSE DI SOPRA PER I BLIP CAVALLO
	{ x=2194.183, y=5596.343, z=52.762,  cx=2194.896, cy=5599.969, cz=53.686, ch=345.086}, 
	{ x=505.98, y=2615.474, z=41.96,  cx=503.216, cy=2614.905, cz=42.96, ch=102.633}, 
	{ x=286.21, y=6788.389, z=14.696,  cx=291.217, cy=6787.965, cz=15.697, ch=264.186}, 
	{ x=-1637.557, y=4566.656, z=42.123,  cx=-1640.759, cy=4565.642, cz=42.271, ch=84.105}, 
	{ x=-446.813, y=1600.255, z=357.324,  cx=-448.673, cy=1599.039, cz=357.623, ch=149.828}, 
	{ x=1486.001, y=1066.868, z=113.334,  cx=1483.001, cy=1066.868, cz=113.334, ch=87.828},
} 
 
local doccia = { 
	-- Non bisogna fare -1 AsseZ
	{ title="Bagno Pubblico", colour=0, id=197, x=813.029, y=-285.618, z=66.462},
	{ title="Bagno Pubblico", colour=0, id=197, x=1136.021, y=-666.898, z=57.083},
	{ title="Bagno Pubblico", colour=0, id=197, x=2035.576, y=4732.572, z=41.632},
	{ title="Bagno Pubblico", colour=0, id=197, x=131.711, y=6638.54, z=31.841},
	{ title="Bagno Pubblico", colour=0, id=197, x=1991.02, y=3779.674, z=32.181},
	{ title="Bagno Pubblico", colour=0, id=197, x=-2186.598, y=4249.979, z=48.94},
	{ title="Bagno Pubblico", colour=0, id=197, x=1470.121, y=6550.256, z=14.904},
	{ title="Bagno Pubblico", colour=0, id=197, x=1470.192, y=6543.048, z=14.904},
	{ title="Bagno Pubblico", colour=0, id=197, x=-1813.512, y=-1221.48, z=19.17},
	{ title="Bagno Pubblico", colour=0, id=197, x=-1809.945, y=-1217.151, z=19.168},
	{ title="Bagno Pubblico", colour=0, id=197, x=-895.528, y=-778.878, z=15.91},
	{ title="Bagno Pubblico", colour=0, id=197, x=-1703.048, y=-1130.166, z=12.152},
} 

local NPC = {
    {seller = true, model = "s_m_m_doctor_01", x = 318.016, y = -1078.428, z = 28.479, h = 349.337},
}

local NPC_Chiesa = {
    {npcchiesa = true, model = "cs_priest", x=-1667.401, y=-290.767, z=52.173-1, h=50.798},
}

local NPC_Povero = {
    {npcpovero = true, model = "u_m_o_tramp_01", x=-1683.481, y=-292.572, z=51.886-1, h=147.358},
	{segretariacomune = true, model = "cs_michelle", x=-71.323, y=-814.721, z=242.386, h=157.673},
	{guardiacomune = true, model = "mp_m_securoguard_01", x=-75.507, y=-819.164, z=242.386, h=254.868},
	{guardiacomune = true, model = "mp_m_securoguard_01", x=-67.15, y=-810.879, z=242.386, h=247.326},
	{guardiacomune = true, model = "mp_m_securoguard_01", x=-73.624, y=-808.481, z=242.386, h=67.209},
	{guardiacomune = true, model = "mp_m_securoguard_01", x=-62.109, y=-812.984, z=242.386, h=70.587},	
	{guardiacomune = true, model = "cs_old_man2", x=2197.479, y=5610.798, z=52.541, h=344.289}, -- BOT AFFITTO CAVALLO
	{guardiacomune = true, model = "s_m_m_trucker_01", x=-1634.782, y=4569.452, z=42.112, h=157.293}, -- BOT AFFITTO CAVALLO
	{guardiacomune = true, model = "s_m_m_prisguard_01", x=454.097, y=-980.027, z=29.69, h=86.0}, -- BOT POLIZIA
	{guardiacomune = true, model = "s_m_y_armymech_01", x=493.226, y=-1356.97, z=28.349, h=35.721},	-- Bot Rimozione
	{killer = true, model = "a_m_m_golfer_01", x=-1296.493, y=-124.398, z=46.607, h=228.968},
	-- NPC Negozio Vestiti
	{ShopN = true, model = "a_f_m_soucentmc_01", x=73.784, y=-1392.119, z=28.376, h=267.556},
	{ShopN = true, model = "a_f_m_tourist_01", x=427.028, y=-807.056, z=28.491, h=79.879},
	{ShopN = true, model = "a_f_m_tramp_01", x=-822.463, y=-1071.869, z=10.328, h=209.945},
	{ShopN = true, model = "a_f_m_trampbeac_01", x=5.323, y=6510.752, z=30.878, h=38.966},
	{ShopN = true, model = "a_f_o_genstreet_01", x=127.0, y=-224.271, z=53.558, h=61.6},
	{ShopN = true, model = "a_f_o_indian_01", x=613.136, y=2760.985, z=41.088, h=272.613},
	{ShopN = true, model = "a_f_o_soucent_02", x=-1193.953, y=-766.901, z=16.316, h=214.125},
	{ShopN = true, model = "a_m_y_beachvesp_02", x=-1101.948, y=2712.213, z=18.108, h=219.56},
	{ShopN = true, model = "a_m_y_bevhills_02", x=1695.137, y=4817.728, z=41.063, h=4.606},
	{ShopN = true, model = "a_m_y_eastsa_02", x=1201.971, y=2707.445, z=37.223, h=86.056},	
	{ShopAnim1 = true, model = "a_m_m_golfer_01", x=-3176.993, y=1045.599, z=19.863, h=51.687}, -- /e lavora
	{ShopAnim2 = true, model = "a_m_m_golfer_01", x=-1101.95, y=2707.148, z=18.119, h=309.755}, -- /e mechanic3	
	{ShopElegante = true, model = "a_f_y_business_01", x=-709.077, y=-151.314, z=36.415, h=118.197}, 
	{ShopElegante = true, model = "a_f_y_bevhills_04", x=-165.147, y=-303.469, z=38.733, h=246.535}, 
	{ShopElegante = true, model = "a_f_y_bevhills_02", x=-1448.635, y=-237.656, z=48.813, h=48.85}, 	
	{ShopGuardia = true, model = "s_m_y_doorman_01", x=-714.678, y=-157.161, z=36.415, h=25.208}, 
	{ShopGuardia = true, model = "s_m_y_doorman_01", x=-158.309, y=-303.255, z=38.733, h=204.498}, 
	{ShopGuardia = true, model = "s_m_y_doorman_01", x=-1452.745, y=-232.843, z=48.801, h=86.119}, 
	{ShopMask = true, model = "a_m_y_juggalo_01", x=-1334.863, y=-1277.624, z=3.964, h=103.0}, 
	{Cozze = true, model = "s_m_m_trucker_01", x=2815.417, y=-668.27, z=0.224, h=267.0}, 
	{CozzePulite = true, model = "csb_ramp_hic", x=-207.464, y=6576.871, z=10.02, h=171.0}, 
	{BotTetto = true, model = "g_m_m_chicold_01", x=274.298, y=-1108.419, z=87.815, h=264.495}, 
	{BotErba = true, model = "cs_omega", x=-186.362, y=6155.464, z=41.637, h=225.843}, 
	{BotRolex = true, model = "csb_popov", x=3311.26,y=5176.45,z=18.61, h=231.39}, 
	{BotBarboneMissione = true, model = "a_m_m_trampbeac_01", x=194.857, y=-3174.523, z=12.783, h=88.245}, 
	{BotMiniera = true, model = "s_m_m_gardener_01", x=-594.09, y=2090.669, z=130.801, h=58.0}, 
	{MercatoNero1 = true, model = "u_m_m_jewelsec_01", x=-1032.868, y=-2855.51, z=43.558, h=325.663}, 
	{BotSoldi = true, model = "cs_clay", x=-3180.543, y=1244.48, z=5.8, h=343.64}, -- Rapina Fleeca
	{BotSoldi = true, model = "cs_joeminuteman", x=591.985, y=2783.078, z=42.481, h=6.602}, -- Rapina Fleeca
	{BotSoldi = true, model = "cs_lazlow", x=-380.737, y=6085.188, z=38.615, h=350.12}, -- Rapina Fleeca
	{BotSoldi = true, model = "cs_russiandrunk", x=1480.949, y=6340.725, z=17.677, h=158.0}, -- Rapina Fleeca

	-- MARIA
	{mBotSera = true, model = "a_m_m_eastsa_01", x=-2165.521, y=5197.513, z=15.88, h=99.308},
	{mBotSera2 = true, model = "a_m_m_eastsa_01", x=888.019, y=-953.674, z=38.231, h=34.463}, 	
	{mBotPome = true, model = "csb_ramp_gang", x=1074.948, y=-2438.902, z=29.602, h=174.046},
	{mBotMattina = true, model = "csb_ramp_gang", x=1902.363, y=597.371, z=177.496, h=243.237},
	-- METH
	{meBotSera = true, model = "s_m_y_dealer_01", x=-1948.13, y=4471.063, z=27.33, h=337.814},
	{meBotSera2 = true, model = "s_m_y_dealer_01", x=3561.151, y=2566.271, z=3.04, h=272.517}, 	
	{meBotPome = true, model = "s_m_y_dealer_01", x=742.157, y=4169.83, z=40.105, h=132.015},
	{meBotMattina = true, model = "s_m_y_dealer_01", x=1583.398, y=2908.469, z=55.949, h=128.319},	
	--COCA
	{cBotSera = true, model = "s_m_y_dealer_01", x=32.681, y=3672.219, z=39.838, h=155.802},
	{cBotSera2 = true, model = "s_m_y_dealer_01", x=1664.421, y=5.532, z=165.118, h=115.696}, 
	{cBotPome = true, model = "s_m_y_dealer_01", x=1445.066, y=6332.98, z=24.341, h=89.48},
	{cBotMattina = true, model = "s_m_y_dealer_01", x=1227.357, y=-2907.464, z=8.319, h=264.795},	
}
	
ESX = nil

Citizen.CreateThread(function()
--loop1 = function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	xPlayer = ESX.GetPlayerData()
	
	TriggerServerEvent('salvage:update')
	TriggerServerEvent('rapinacasse:getcasse')
	TriggerServerEvent('rapina:getcaserapinate')
	
	if Config.EnableNpc then
		for _, v in pairs(NPC) do
			RequestModel(GetHashKey(v.model))
			while not HasModelLoaded(GetHashKey(v.model)) do
				Wait(100)
			end
			local npc = CreatePed(4, v.model, v.x, v.y, v.z, v.h,  false, true)
			SetPedFleeAttributes(npc, 0, 0)
			SetPedDropsWeaponsWhenDead(npc, false)
			SetPedDiesWhenInjured(npc, false)
			SetEntityInvincible(npc , true)
			FreezeEntityPosition(npc, true)
			SetBlockingOfNonTemporaryEvents(npc, true)
			if v.seller then 
				RequestAnimDict("missfbi_s4mop")
				while not HasAnimDictLoaded("missfbi_s4mop") do
					Wait(100)
				end
				TaskPlayAnim(npc, "missfbi_s4mop" ,"guard_idle_a" ,8.0, 1, -1, 49, 0, false, false, false)
			else
				GiveWeaponToPed(npc, GetHashKey("WEAPON_ADVANCEDRIFLE"), 2800, true, true)
			end
		end
				
		-- NPC Povero fuori la chiesa
		for _, v in pairs(NPC_Povero) do
		
			--for _, Ped in pairs(GetNearbyPeds(v.x, v.y, v.z, 1.5)) do
			--if (GetEntityType(Ped) == 1) and Ped ~= ped and IsPedModel(Ped, v.model) then trovato = true end
			--end
			
			if not trovato then 
						
				RequestModel(GetHashKey(v.model))
				while not HasModelLoaded(GetHashKey(v.model)) do
					Wait(100)
				end
				local npc = CreatePed(4, v.model, v.x, v.y, v.z, v.h,  false, true)
				v.PedID = npc
				SetPedFleeAttributes(npc, 0, 0)
				SetPedDropsWeaponsWhenDead(npc, false)
				SetPedDiesWhenInjured(npc, false)
				SetEntityInvincible(npc , true)
				FreezeEntityPosition(npc, true)
				SetBlockingOfNonTemporaryEvents(npc, true)
				
				if v.guardiacomune then				
					RequestAnimDict("anim@heists@heist_corona@single_team")
					while not HasAnimDictLoaded("anim@heists@heist_corona@single_team") do
						Wait(100)
					end
					TaskPlayAnim(npc, "anim@heists@heist_corona@single_team" ,"single_team_loop_boss" ,8.0, 1, -1, 0, 0, false, false, false)
				end
				
				if v.killer then				
					RequestAnimDict("timetable@ron@ig_3_couch")
					while not HasAnimDictLoaded("timetable@ron@ig_3_couch") do
						Wait(100)
					end
					TaskPlayAnim(npc, "timetable@ron@ig_3_couch", "base" ,8.0, 1, -1, 0, 0, false, false, false)
				end
				
				if v.ShopAnim1 then				
					RequestAnimDict("anim@amb@business@weed@weed_inspecting_lo_med_hi@")
					while not HasAnimDictLoaded("anim@amb@business@weed@weed_inspecting_lo_med_hi@") do
						Wait(100)
					end
					TaskPlayAnim(npc, "anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector" ,8.0, 1, -1, 0, 0, false, false, false)
				end
				if v.ShopAnim2 then				
					RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
					while not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@") do
						Wait(100)
					end
					TaskPlayAnim(npc, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" ,8.0, 1, -1, 0, 0, false, false, false)
				end
				if v.ShopGuardia then				
					RequestAnimDict("amb@world_human_hang_out_street@female_arms_crossed@idle_a")
					while not HasAnimDictLoaded("amb@world_human_hang_out_street@female_arms_crossed@idle_a") do
						Wait(100)
					end
					TaskPlayAnim(npc, "amb@world_human_hang_out_street@female_arms_crossed@idle_a", "idle_a" ,8.0, 1, -1, 0, 0, false, false, false)
				end
				if v.BotTetto then				
					RequestAnimDict("timetable@ron@ig_3_couch")
					while not HasAnimDictLoaded("timetable@ron@ig_3_couch") do
						Wait(100)
					end
					TaskPlayAnim(npc, "timetable@ron@ig_3_couch", "base", 8.0, 1, -1, 0, 0, false, false, false)
				end
				if v.BotErba then				
					RequestAnimDict("rcmnigel1a")
					while not HasAnimDictLoaded("rcmnigel1a") do
						Wait(100)
					end
					TaskPlayAnim(npc, "rcmnigel1a", "base", -1, -1, -1, 1, 1.0, false, false, false)
				end
				
				-- ["sitchair4"] = {"timetable@ron@ig_3_couch", "base"
				-- ["sit2"] = {"rcm_barry3", "barry_3_sit_loop"
				-- ["wait2"] = {"missbigscore2aig_3", "wait_for_van_c"
				-- ["sitchair3"] = {"timetable@reunited@ig_10", "base_amanda"
				-- ["crossarms5"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop"
				-- ["sit9"] = {"amb@world_human_stupor@male@idle_a", "idle_a"
				-- ["lean3"] = {"amb@world_human_leaning@female@wall@back@holding_elbow@idle_a", "idle_a" 
				
				-- ANIM BOT DROGA
				-- MARIA 
				if v.mBotSera2 then RequestAnimDict("amb@world_human_leaning@female@wall@back@holding_elbow@idle_a") while not HasAnimDictLoaded("amb@world_human_leaning@female@wall@back@holding_elbow@idle_a") do Wait(100) end 
					TaskPlayAnim(npc, "missclothing", "idle_storeclerk", -1, -1, -1, 1, 1.0, false, false, false)
				end	 
				if v.mBotPome then RequestAnimDict("rcm_barry3") while not HasAnimDictLoaded("rcm_barry3") do Wait(100) end 
					TaskPlayAnim(npc, "rcm_barry3", "barry_3_sit_loop", -1, -1, -1, 1, 1.0, false, false, false)
				end
				if v.mBotSera then RequestAnimDict("rcm_barry3") while not HasAnimDictLoaded("rcm_barry3") do Wait(100) end 
					TaskPlayAnim(npc, "rcm_barry3", "barry_3_sit_loop", -1, -1, -1, 1, 1.0, false, false, false)
				end	
				if v.mBotMattina then RequestAnimDict("timetable@ron@ig_3_couch") while not HasAnimDictLoaded("timetable@ron@ig_3_couch") do Wait(100) end 
					TaskPlayAnim(npc, "timetable@ron@ig_3_couch", "base", -1, -1, -1, 1, 1.0, false, false, false)
				end			
				-- METH
				if v.meBotSera2 then RequestAnimDict("amb@world_human_leaning@female@wall@back@holding_elbow@idle_a") while not HasAnimDictLoaded("amb@world_human_leaning@female@wall@back@holding_elbow@idle_a") do Wait(100) end 
					TaskPlayAnim(npc, "missclothing", "idle_storeclerk", -1, -1, -1, 1, 1.0, false, false, false)
				end	
				if v.meBotSera then RequestAnimDict("rcm_barry3") while not HasAnimDictLoaded("rcm_barry3") do Wait(100) end 
					TaskPlayAnim(npc, "rcm_barry3", "barry_3_sit_loop", -1, -1, -1, 1, 1.0, false, false, false)
				end
				if v.meBotPome then RequestAnimDict("rcm_barry3") while not HasAnimDictLoaded("rcm_barry3") do Wait(100) end 
					TaskPlayAnim(npc, "rcm_barry3", "barry_3_sit_loop", -1, -1, -1, 1, 1.0, false, false, false)
				end	
				if v.meBotMattina then RequestAnimDict("timetable@ron@ig_3_couch") while not HasAnimDictLoaded("timetable@ron@ig_3_couch") do Wait(100) end 
					TaskPlayAnim(npc, "timetable@ron@ig_3_couch", "base", -1, -1, -1, 1, 1.0, false, false, false)
				end			
				--COCA
				if v.cBotSera2 then RequestAnimDict("amb@world_human_leaning@female@wall@back@holding_elbow@idle_a") while not HasAnimDictLoaded("amb@world_human_leaning@female@wall@back@holding_elbow@idle_a") do Wait(100) end 
					TaskPlayAnim(npc, "amb@world_human_leaning@female@wall@back@holding_elbow@idle_a", "idle_a", -1, -1, -1, 1, 1.0, false, false, false)
				end
				if v.cBotSera then RequestAnimDict("timetable@ron@ig_3_couch") while not HasAnimDictLoaded("timetable@ron@ig_3_couch") do Wait(100) end 
					TaskPlayAnim(npc, "timetable@ron@ig_3_couch", "base", -1, -1, -1, 1, 1.0, false, false, false)
				end	
				if v.cBotPome then RequestAnimDict("timetable@ron@ig_3_couch") while not HasAnimDictLoaded("timetable@ron@ig_3_couch") do Wait(100) end 
					TaskPlayAnim(npc, "timetable@ron@ig_3_couch", "base", -1, -1, -1, 1, 1.0, false, false, false)
				end	
				if v.cBotMattina then RequestAnimDict("amb@world_human_stupor@male@idle_a") while not HasAnimDictLoaded("amb@world_human_stupor@male@idle_a") do Wait(100) end 
					TaskPlayAnim(npc, "amb@world_human_stupor@male@idle_a", "idle_a", -1, -1, -1, 1, 1.0, false, false, false)
				end	

				if v.BotSoldi then				
					RequestAnimDict("rcmnigel1a")
					while not HasAnimDictLoaded("rcmnigel1a") do
						Wait(100)
					end
					TaskPlayAnim(npc, "rcmnigel1a", "base", -1, -1, -1, 1, 1.0, false, false, false)
				end	
				if v.BotRolex then				
					RequestAnimDict("random@shop_tattoo") 
					while not HasAnimDictLoaded("random@shop_tattoo") do
						Wait(100)
					end
					TaskPlayAnim(npc, "random@shop_tattoo", "_idle_a", -1, -1, -1, 1, 1.0, false, false, false)
				end	
				if v.BotBarboneMissione then				
					RequestAnimDict("anim@heists@fleeca_bank@ig_7_jetski_owner") 
					while not HasAnimDictLoaded("anim@heists@fleeca_bank@ig_7_jetski_owner") do
						Wait(100)
					end
					TaskPlayAnim(npc, "anim@heists@fleeca_bank@ig_7_jetski_owner", "owner_idle", -1, -1, -1, 1, 1.0, false, false, false)
				end				
				if v.MercatoNero1 then -- "anim@heists@heist_corona@single_team", "single_team_loop_boss"			
					RequestAnimDict("anim@heists@heist_corona@single_team") 
					while not HasAnimDictLoaded("anim@heists@heist_corona@single_team") do
						Wait(100)
					end
					TaskPlayAnim(npc, "anim@heists@heist_corona@single_team", "single_team_loop_boss", -1, -1, -1, 1, 1.0, false, false, false)
				end			
				if v.npcpovero then 
					RequestAnimDict("rcm_barry3")
					while not HasAnimDictLoaded("rcm_barry3") do
						Wait(100)
					end
					TaskPlayAnim(npc, "rcm_barry3" ,"barry_3_sit_loop" ,8.0, 1, -1, 0, 0, false, false, false)
				end
			
			end
			
		end
			
		-- NPC Chiesa
		for _, v in pairs(NPC_Chiesa) do
			RequestModel(GetHashKey(v.model))
			while not HasModelLoaded(GetHashKey(v.model)) do
				Wait(100)
			end
			local npc = CreatePed(4, v.model, v.x, v.y, v.z, v.h,  false, true)
			SetPedFleeAttributes(npc, 0, 0)
			SetPedDropsWeaponsWhenDead(npc, false)
			SetPedDiesWhenInjured(npc, false)
			SetEntityInvincible(npc , true)
			FreezeEntityPosition(npc, true)
			SetBlockingOfNonTemporaryEvents(npc, true)
			--[[
			if v.npcchiesa then 
				RequestAnimDict("anim@amb@clubhouse@bar@drink@idle_a")
				while not HasAnimDictLoaded("anim@amb@clubhouse@bar@drink@idle_a") do
					Wait(1)
				end
				TaskPlayAnim(npc, "anim@amb@clubhouse@bar@drink@idle_a" ,"idle_a_bartender" ,8.0, 1, -1, 49, 0, false, false, false)
			else
				GiveWeaponToPed(npc, GetHashKey("WEAPON_ADVANCEDRIFLE"), 2800, true, true)
			end
			]]
		end		
	end
	
	local bool = true
  
    if bool then
		for _, info in pairs(chiesa) do       
			info.blip = AddBlipForCoord(info.x, info.y, info.z)
			SetBlipSprite(info.blip, info.id)
			SetBlipDisplay(info.blip, 4)
			SetBlipScale(info.blip, info.size)
			SetBlipColour(info.blip, info.colour)
			SetBlipAsShortRange(info.blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(info.title)
			EndTextCommandSetBlipName(info.blip)			
		 end		
			 
		 for _, info in pairs(vanilla) do      
			info.blip = AddBlipForCoord(info.x, info.y, info.z)
			SetBlipSprite(info.blip, info.id)
			SetBlipDisplay(info.blip, 4)
			SetBlipScale(info.blip, info.size)
			SetBlipColour(info.blip, info.colour)
			SetBlipAsShortRange(info.blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(info.title)
			EndTextCommandSetBlipName(info.blip)
		end	
			 
		 -- Doccia Bagno Pubblico
		 --for _, info in pairs(doccia) do
		 for k, info in pairs(doccia) do   
			info.blip = AddBlipForCoord(info.x, info.y, info.z)
			SetBlipSprite(info.blip, info.id)
			SetBlipDisplay(info.blip, 4)
			SetBlipScale(info.blip, 0.5)
			SetBlipColour(info.blip, info.colour)
			SetBlipAsShortRange(info.blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(info.title)
			EndTextCommandSetBlipName(info.blip)		
		 end
	   
	   bool = false
   end
end)

function delIG(nome, qt)
	TriggerServerEvent('cavallo:toglisella', nome, qt)
end

local stoCucinando = false
function OpenCucinaMenu(nomeFazione, pos, head)
	if ESX ~= nil then
		local xPlayer = ESX.GetPlayerData()	
		if xPlayer.job.name ~= nomeFazione then
			ESX.ShowHelpNotification("Non sei autorizzato a cucinare in questa postazione.")
			return 
		end
		
		local elements = {
			{label = "Cucina Spaghetti al pomodoro",  value = 'spaghetti'},
			{label = "Cucina Impepata di cozze",  value = 'cozze'},
			{label = "Cucina Pesce alla griglia",  value = 'pesce'},
			{label = "Cucina Cotoletta con patatine e pomodoro",  value = 'cotoletta'},
			{label = "Cucina Piatto di ostriche",  value = 'ostriche'},
			{label = "Prepara una spremuta di arancia",  value = 'succoarancia'},
			{label = "Prepara un sugo di pomodoro",  value = 'sugo'},
			{label = "Prepara una farina",  value = 'farina'},
			--{label = "Cucina Frittura di pesce",  value = 'fritturapesce'},
			--{label = "Cucina Impepata di cozze",  value = 'cozze'},
		}

		ESX.UI.Menu.CloseAll()
		
		local ply = PlayerPedId()
		SetEntityCoords(ply, pos) 
		SetEntityHeading(ply, head)
		ExecuteCommand('e cuoco')
		FreezeEntityPosition(ply, true)
		
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cucina_actions', {
			title    = "Cucina " .. nomeFazione,
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local ingredienti = true
			local nomeIngrediente = nil
			if data.current.value == 'spaghetti' then
				IG = 'tomato_juice' ESX.TriggerServerCallback('cavallo:totSelle', function(carb) if carb < 2 then ESX.ShowNotification("~r~Sugo di pomoro x2 ~w~mancante per questa ricetta.") ingredienti = false end end, IG)		
				IG = 'farina' ESX.TriggerServerCallback('cavallo:totSelle', function(carb) if carb < 5 then ESX.ShowNotification("~r~Farina x5 ~w~mancante per questa ricetta.") ingredienti = false end end, IG)		
				Wait(1000) if ingredienti then ESX.ShowHelpNotification("Stai cucinando, attendere.") Wait(9000) TriggerServerEvent('FaCrashare:giveitem', 'piatto', 1) delIG('tomato_juice', 1) delIG('farina', 5) ESX.ShowHelpNotification("Hai cucinato un piatto di spaghetti al pomodoro.") end
			elseif data.current.value == 'succoarancia' then
				IG = 'arancia' ESX.TriggerServerCallback('cavallo:totSelle', function(carb) if carb < 5 then ESX.ShowNotification("~r~Arancia x5 ~w~mancante per questa bibita.") ingredienti = false end end, IG)		
				Wait(1000) if ingredienti then ESX.ShowHelpNotification("Stai spremendo le arance.") Wait(5000) TriggerServerEvent('FaCrashare:giveitem', 'succoarancia', 1) delIG('arancia', 5) ESX.ShowHelpNotification("Hai preparato una spremuta di arance.") end
			elseif data.current.value == 'sugo' then
				IG = 'tomato' ESX.TriggerServerCallback('cavallo:totSelle', function(carb) if carb < 5 then ESX.ShowNotification("~r~Pomodoro x5 ~w~mancante per questo sugo.") ingredienti = false end end, IG)		
				Wait(1000) if ingredienti then ESX.ShowHelpNotification("Stai preparando il sugo.") Wait(5000) TriggerServerEvent('FaCrashare:giveitem', 'tomato_juice', 1) delIG('tomato', 5) ESX.ShowHelpNotification("Hai preparato un sugo di pomodoro.") end
			elseif data.current.value == 'cozze' then
				IG = 'cozza' ESX.TriggerServerCallback('cavallo:totSelle', function(carb) if carb < 15 then ESX.ShowNotification("~r~Cozza x15 ~w~mancante per questo piatto.") ingredienti = false end end, IG)		
				Wait(1000) if ingredienti then ESX.ShowHelpNotification("Stai preparando la zuppa di cozze.") Wait(5000) TriggerServerEvent('FaCrashare:giveitem', 'piattocozze', 1) delIG('cozza', 15) ESX.ShowHelpNotification("Hai preparato una zuppa di cozze.") end
			elseif data.current.value == 'ostriche' then
				IG = 'ostrica' ESX.TriggerServerCallback('cavallo:totSelle', function(carb) if carb < 5 then ESX.ShowNotification("~r~Ostrica x5 ~w~mancante per questo piatto.") ingredienti = false end end, IG)		
				Wait(1000) if ingredienti then ESX.ShowHelpNotification("Stai preparando il piatto di ostriche.") Wait(5000) TriggerServerEvent('FaCrashare:giveitem', 'piattoostriche', 1) delIG('ostrica', 5) ESX.ShowHelpNotification("Hai preparato un elegante piatto con ostriche.") end
			elseif data.current.value == 'pesce' then
				IG = 'carpamedia' ESX.TriggerServerCallback('cavallo:totSelle', function(carb) if carb < 1 then ESX.ShowNotification("~r~Carpa Media x1 ~w~mancante per questo piatto.") ingredienti = false end end, IG)		
				Wait(1000) if ingredienti then ESX.ShowHelpNotification("Stai preparando il pesce grigliato.") Wait(5000) TriggerServerEvent('FaCrashare:giveitem', 'pescecotto', 1) delIG('carpamedia', 5) ESX.ShowHelpNotification("Hai preparato un elegante piatto con ostriche.") end
			elseif data.current.value == 'farina' then
				IG = 'grano' ESX.TriggerServerCallback('cavallo:totSelle', function(carb) if carb < 5 then ESX.ShowNotification("~r~Grano x5 ~w~mancante per questo composto.") ingredienti = false end end, IG)		
				Wait(1000) if ingredienti then ESX.ShowHelpNotification("Stai preparando il pesce grigliato.") Wait(9000) TriggerServerEvent('FaCrashare:giveitem', 'farina', 1) delIG('grano', 5) ESX.ShowHelpNotification("Hai preparato una farina con il grano.") end
			elseif data.current.value == 'cotoletta' then
				IG = 'packaged_chicken' ESX.TriggerServerCallback('cavallo:totSelle', function(carb) if carb < 2 then ESX.ShowNotification("~r~Pollo Pronto x2 ~w~mancante per questa ricertta.") ingredienti = false end end, IG)
				IG = 'tomato' ESX.TriggerServerCallback('cavallo:totSelle', function(carb) if carb < 2 then ESX.ShowNotification("~r~Pomodoro x2 ~w~mancante per questa ricertta.") ingredienti = false end end, IG)		
				Wait(1000) if ingredienti then ESX.ShowHelpNotification("Stai preparando cotolette di pollo.") Wait(9000) TriggerServerEvent('FaCrashare:giveitem', 'cotoletta', 1) delIG('packaged_chicken', 5) ESX.ShowHelpNotification("Hai preparato cotoletta con patatine e pomodoro.") end
			end
		end, function(data, menu)
			menu.close()
			ExecuteCommand('e c')
			local ply = PlayerPedId()
			FreezeEntityPosition(ply, false)
		end)
	end
end

--[[]]

local trovato = false
local possofischiare = true

-- SISTEMA Cavallo
Citizen.CreateThread(function()
--loop2 = function()
	while true do Citizen.Wait(5)
	if ped ~= nil then 
		local coords = GetEntityCoords(ped)
		
		--[[	
		x=505.98, y=2615.474, z=42.96, h=191.384 -- AFFITTO CAVALLO,
		x=503.216, y=2614.905, z=42.96, h=102.633 -- POSIZIONE CAVALLO,
		x=286.21, y=6788.389, z=14.696, h=261.952 -- AFFITTO CAVALLO,
		x=291.217, y=6787.965, z=15.697, h=264.186 -- POSIZIONE CAVALLO,
		x=-1634.782, y=4569.452, z=43.112, h=157.293 -- BOT AFFITTO CAVALLO,
		x=-1637.557, y=4566.656, z=43.123, h=168.864 -- pos affitto cavallo,
		x=-1640.759, y=4565.642, z=43.271, h=84.105 -- spawn cavallo,
		]]
			
		-- AFFITTARE UN CAVALLO
		local prezzoCavallo = 800
		for k, v in pairs(cavallo) do
			
			if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 10.0 then
				trovato = true
				DrawMarker(1, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.5, 2.5, 0.35, 255, 255, 0, 50, false, true, 2, false, false, false, false)
			end
			
			if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 2.5 then
				trovato = true
				TIPOAFFITTO = 3
				if DoesEntityExist(MIOCAVALLO) then
					if GetDistanceBetweenCoords(coords, GetEntityCoords(MIOCAVALLO), true) < 2.5 then
						ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Riconsegna Cavallo") -- 250~g~$")
						if TIPOAFFITTO ~= 1 then TIPOAFFITTO = 1 end
					else
						ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Affitta Cavallo " .. prezzoCavallo .. "~g~$")
						if TIPOAFFITTO ~= 0 then TIPOAFFITTO = 0 end
					end
				else
						ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Affitta Cavallo " .. prezzoCavallo .. "~g~$")
						if TIPOAFFITTO ~= 0 then TIPOAFFITTO = 0 end
				end
			
				if IsControlJustReleased(0, 74) then
					ESX.TriggerServerCallback('soldi:check', function(soldi)
					if soldi then
						ESX.TriggerServerCallback('cavallo:totSelle', function(totselle)
						if totselle > 0 then	
						TriggerServerEvent('cavallo:toglisella', 'sellacavallo', 1)
							if TIPOAFFITTO == 0 then 
								if DoesEntityExist(MIOCAVALLO) and not AVVISO then 
									ESX.ShowNotification("Hai già affittato un cavallo, riportalo indietro per prenderne un'altro oppure ~y~ripeti l'operazione~w~.")
									ESX.ShowNotification("Ti ricordiamo che perderai il ~y~50% ~w~del costo di affitto.")
									ExecuteCommand('e shrug')
									AVVISO = true
									Citizen.Wait(1500)
								else
									SetCurrentPedWeapon(ped, -1569615261, true)
									ExecuteCommand('e boi')
									Citizen.Wait(1000)
									ExecuteCommand('e gdoc')
									ESX.ShowNotification("Usa i tasti di movimento per muoverti a cavallo.")
									ESX.ShowNotification("Tieni premuto ~b~SHIFT ~w~mentre ti muovi per prepararti a galoppare.")
									Citizen.Wait(6000)
									ESX.ShowNotification("Lascia il tasto per andare avanti mentre tieni premuto ~b~SHIFT ~w~per galoppare.")
									--Citizen.Wait(6000)
									--ESX.ShowNotification("Se non riesci a galoppare bene puoi richiedere dei corsi privati al ~y~Municipio~w~.")
									Citizen.Wait(5000)

									ExecuteCommand('e c')
									TriggerServerEvent('cavallo:Paga', prezzoCavallo, v.cx, v.cy, v.cz, v.ch, "a_c_deer")	
									Citizen.Wait(2000)
									--ESX.ShowHelpNotification("~INPUT_PICKUP~ Sali sul cavallo")	
									ESX.ShowNotification("Tieni premuto ~b~E ~w~per salire a cavallo oppure scendere.")
									Citizen.Wait(5000)
									ESX.ShowNotification("I cavalli tendono a ~y~spaventarsi ~w~facilmente, se lo perdi di vista puoi ritrovarlo sulla mappa.")
									--Citizen.Wait(5000)
									--ESX.ShowNotification("Riportando il cavallo al Ranch riceverai il ~g~50% ~w~del costo di affitto.")
									Citizen.Wait(5000)
									ESX.ShowNotification("Premi ~g~H + ALT ~w~se il tuo cavallo sta scappando per farlo fermare.")
								end
							end
						
						else
							ESX.ShowNotification("Non hai una sella di cavallo in inventario.")
						end
						end, 'sellacavallo') -- Callback per la sella di cavallo
					else
						ESX.ShowNotification("Non hai abbastanza soldi per affittare un cavallo.")
					end
					end, prezzoCavallo)
				end -- Fine tasto Premuto per Affittare Cavallo
				
				
				-- RITORNO IL CAVALLO
				if IsControlJustReleased(0, 74) then				
					if TIPOAFFITTO == 0 then 
					else
							if MIOCAVALLO ~= nil then
								if DoesEntityExist(MIOCAVALLO) then 
									DeleteEntity(MIOCAVALLO)
									RemoveBlip(Sospetto)
									ClearPedTasks(ped)
									-- Qui devi riconsegnare i soldi al giocatore
									ESX.ShowNotification("Ottimo lavoro, grazie la riconsegna del cavallo.")
									TriggerServerEvent('cavallo:Riconsegna')
									Citizen.Wait(1000)
									ExecuteCommand('e adjusttie')
									Citizen.Wait(5000)
								end
							end
					end
				end -- Fine tasto Premuto per Affittare Cavallo
				
				
			end
		end -- FINE LOOP Cavallo da Affittare
		
		if not trovato then 
			Citizen.Wait(1000)
		end
			
		--IsEntityDead
		-- CONTROLLO SE IL CAVALLO MUORE
		if DoesEntityExist(MIOCAVALLO) then
			if IsEntityDead(MIOCAVALLO) then
				SetEntityAsNoLongerNeeded(MIOCAVALLO)
				ExecuteCommand('e facepalm2')
				RemoveBlip(Sospetto)
				ESX.ShowNotification("Il tuo cavallo è ~r~morto~w~.")
				MIOCAVALLO = nil
			end
		end
		
		--FISCHIARE AL CAVALLO PER FARLO STARE FERMO
		if DoesEntityExist(MIOCAVALLO) and TIPOAFFITTO ~= 3 and possofischiare then 
			if IsControlJustReleased(0, 74) and IsControlPressed(0, 21) then
				if GetDistanceBetweenCoords(coords, GetEntityCoords(MIOCAVALLO), true) > 10.0 and GetDistanceBetweenCoords(coords, GetEntityCoords(MIOCAVALLO), true) < 300.0 then
					possofischiare = false
					ClearPedTasks(MIOCAVALLO)
					ExecuteCommand('e whistle')		
					Citizen.Wait(1500)					
					ESX.ShowNotification("Il tuo cavallo ha sentito il tuo fischio e sembra essersi fermato, raggiungilo.")
					Citizen.Wait(5000)
					possofischiare = true
				end
				
				-- Troppo Lontano
				if GetDistanceBetweenCoords(coords, GetEntityCoords(MIOCAVALLO), true) >= 300.0 then
					ExecuteCommand('e whistle')		
					Citizen.Wait(1500)					
					ESX.ShowNotification("Il cavallo sembra troppo lontano per sentirti, prova ad avvicinarti alla sua posizione sul radar.")
				end
			end
		else
			if not trovato then 
				Citizen.Wait(1000)
			end
		end
	end
	end -- while
end) -- FINE

--[[]]

AddEventHandler('playerSpawned', function()
	Wait(5000)
	if not FirstSpawn then
		FirstSpawn = true
		Wait(5000)
		FirstSpawn = false
	end
end)

--[[]]
local InGenera = false
Citizen.CreateThread(function()
--loop3 = function()
	while true do Citizen.Wait(5)
	if ped ~= nil then 
		
if not IsPedInAnyVehicle(ped, true) and not IsPedRagdoll(ped) then 	
		
		local coords = GetEntityCoords(ped)
		
		--[[
		for k, v in pairs(store) do -- BLIP FARMACIA
			if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 20 then
				DrawMarker(23, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 150, false, true, 2, false, false, false, false)
			end		
		end
		]]
		
		-- LIBRERIA -----
		-- SKILL MECCANICO	
			--if GetDistanceBetweenCoords(coords, 247.021, -1602.316, 30.536, true) < 3.5 then
				--DrawMarker(1, 247.021, -1602.316, 30.536, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 1.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)
		--end
			
		-- CONTINUO -----
		
		-- CONTROLLO POSIZIONE 0,0,0
		if GetDistanceBetweenCoords(coords, 0.0, 0.0, 0.0, true) < 10.0 and FirstSpawn and IsEntityVisible(ped) then
			SetEntityCoords(ped, -214.309, -1040.065, 30.14)
			SetEntityHeading(ped, 0.0)
			ESX.ShowNotification("~b~Legacy: ~w~Rilevato problema alla tua posizione, sei stato spawnato ad una stazione treno.")
			Citizen.Wait(5000)
			ExecuteCommand('e shrug')
			ESX.ShowNotification("~b~Legacy: ~w~Problema forse causato da un crash, ci scusiamo per il disagio, buon RP.")
			Citizen.Wait(5000)
			FirstSpawn = false
		--end
		
		-- WEBHOOK: https://discord.com/api/webhooks/842844253309894717/s4MeJ8J8mKKScmWDekEt0y0y8VjV3Wb2d_fAvZv7xG8OSZQBnCUBcJxfmJV50ZvBUEdG
		-- Cambio Valuta Legacy
		elseif not InGenera and GetDistanceBetweenCoords(coords, -106.584,6469.305,30.627, true) < 10.0 and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'menugiornale') then
			DrawMarker(23, -106.584,6469.305,30.627+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,250, 100, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -106.584,6469.305,30.627, true) <= 1.5 then
				ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Conversione 1 ~b~VL ~w~in 100 ~g~$")
					if IsControlJustReleased(0, 74) then
						InGenera = true
						ExecuteCommand('cambioVL')
					end
			end
		
		-- Controllo Party Bus
		elseif GetDistanceBetweenCoords(coords, 1224.713, 2728.688, 37.005, true) < 10.0 and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'menugiornale') then
			DrawMarker(23, 1224.713, 2728.688, 37.005+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 255, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, 1224.713, 2728.688, 37.005, true) < 1.5 then
				ESX.ShowHelpNotification("Se possiedi una licenza addatta usa ~b~/partybus ~w~per affittare.")
			end
		
		-- GENERO PACCO DI LEGNO FINITO
		elseif not InGenera and GetDistanceBetweenCoords(coords, -579.169, 5355.243, 69.214, true) < 10.0 and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'menugiornale') then
			DrawMarker(23, -579.169, 5355.243, 69.214+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 0, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -579.169, 5355.243, 69.214, true) <= 1.5 then
				ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Genera Carico di ~y~Legno Grande")
					if IsControlJustReleased(0, 74) then
						InGenera = true
						ExecuteCommand('generaLegno')
					end
			end
		
		-- GENERA CASSE BIRRA
		elseif not InGenera and GetDistanceBetweenCoords(coords, 750.485, -1834.874, 28.292, true) < 10.0 and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'menugiornale') then
			DrawMarker(23, 750.485, -1834.874, 28.292+0.015, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 255, 0, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, 750.485, -1834.874, 28.292, true) <= 1.5 then
				ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Genera Casse di ~g~Birra")
					if IsControlJustReleased(0, 74) then
						InGenera = true
						ExecuteCommand('generaBirra')
					end
			end
		
		-- VENDI PATTUME
		elseif not InGenera and  GetDistanceBetweenCoords(coords, 2350.461, 3122.676, 47.209, true) < 10.0 and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'menugiornale') then
			DrawMarker(23, 2350.461, 3122.676, 47.209+0.015, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 255, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, 2350.461, 3122.676, 47.209, true) <= 3.5 then
				ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Vendi ~b~Pattume")
					if IsControlJustReleased(0, 74) then
						InGenera = true
						ExecuteCommand('vendiPattume')
					end
			end
		
		-- GENERO PACCO DI PIETRE FINITO
		elseif not InGenera and  GetDistanceBetweenCoords(coords,-594.09, 2090.669, 130.801, true) < 2.5 and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'menugiornale') then
			--DrawMarker(23, -594.09, 2090.669, 130.801+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 0, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -594.09, 2090.669, 130.801, true) <= 2.5 then
				ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Genera Carico di ~y~Pietre")
					if IsControlJustReleased(0, 74) then
						InGenera = true
						ExecuteCommand('generaPietra')
					end
			end
		
		-- BLIP GIORNALISTA GIORNALE
		elseif GetDistanceBetweenCoords(coords, -1055.485, -242.893, 43.021, true) < 10.0 and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'menugiornale') then
			DrawMarker(23, -1055.485, -242.893, 43.021+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 0, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -1055.485, -242.893, 43.021, true) < 1.5 then
				ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Modifica Giornale")
					if IsControlJustReleased(0, 74) then
						ExecuteCommand('modGiornale')
						Citizen.Wait(3000)
					end
			end
			
		-- BLIP GIORNALISTA GIORNALE
		elseif GetDistanceBetweenCoords(coords, -937.659, -2036.57, 11.833, true) < 5.0 and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'menuprocura') then
			DrawMarker(23, -937.659, -2036.57, 11.833+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -937.659, -2036.57, 11.833, true) < 1.5 then
				ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Computer Procuratore")
					if IsControlJustReleased(0, 74) then
						ExecuteCommand('procura')
					end
			end
		
		-- Ascensore Municipio da Sopra
		elseif GetDistanceBetweenCoords(coords, -264.198, -959.924, 31.22, true) < 5.0 then
			DrawMarker(23, -264.198, -959.924, 30.22, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 150, false, true, 2, false, false, false, false)
		--end
		
		-- Ascensore Municipio da Sotto
		elseif GetDistanceBetweenCoords(coords, -75.59, -827.134, 243.386, true) < 5.0 then
			DrawMarker(23, -75.59, -827.134, 242.395, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 150, false, true, 2, false, false, false, false)
		--end
		
		-- GALAXY FUORI
		elseif GetDistanceBetweenCoords(coords, -2190.095, -399.755, 13.295, true) < 5.0 then
			DrawMarker(23, -2190.095, -399.755, 12.295, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 150, false, true, 2, false, false, false, false)
		--end

		-- GALAXY DENTRO
		elseif GetDistanceBetweenCoords(coords, -1569.398, -3017.457, -74.406, true) < 5.0 then
			DrawMarker(23, -1569.398, -3017.457, -75.406, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 150, false, true, 2, false, false, false, false)
		--end
		
		-- Ascensore Municipio Tetto da Sopra
		elseif GetDistanceBetweenCoords(coords, -260.56, -959.488, 129.618, true) < 5.0 then
			DrawMarker(23, -260.56, -959.488, 129.638, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 150, false, true, 2, false, false, false, false)
		--end
		
		-- Ascensore Municipio Tetto da Sotto
		elseif GetDistanceBetweenCoords(coords, -80.444, -832.671, 242.386, true) < 5.0 then
			DrawMarker(23, -80.444, -832.671, 242.406, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 150, false, true, 2, false, false, false, false)
		--end
				
		-- Solo Autorizzati Municipio
		--[[
		elseif GetDistanceBetweenCoords(coords, -66.353, -811.232, 242.3866, true) < 1.5 then
			DrawMarker(23, -66.353, -811.232, 242.386, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 0, 0, 150, false, true, 2, false, false, false, false)
			ESX.ShowHelpNotification("~r~Guardia: ~w~Accedi solo se autorizzato...")
		]]
		--end
		
		-- Solo Autorizzati Municipio
		--[[
		elseif GetDistanceBetweenCoords(coords, -74.409,-808.19,242.386, true) < 1.5 then
			DrawMarker(23, -74.409,-808.19,242.386, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 0, 0, 150, false, true, 2, false, false, false, false)
			ESX.ShowHelpNotification("~r~Guardia: ~w~Accedi solo se autorizzato...")
		]]
		--end
		
		-- Solo Autorizzati Municipio
		--[[
		elseif GetDistanceBetweenCoords(coords, -63.082, -812.635, 242.386, true) < 1.5 then
			DrawMarker(23, -63.082, -812.635, 242.386, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 0, 0, 150, false, true, 2, false, false, false, false)
			ESX.ShowHelpNotification("~r~Guardia: ~w~Accedi solo se autorizzato...")
		]]
		--end
		
		--[[
		
		-- Caffe Municipio Info
		elseif GetDistanceBetweenCoords(coords, -62.069, -818.766, 242.386, true) < 3.5 then
			DrawMarker(23, -62.069, -818.766, 242.406, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.2, 255, 255, 0, 150, false, true, 2, false, false, false, false)
			-- Caffe Municipio Funzione
			if GetDistanceBetweenCoords(coords, -62.069, -818.766, 242.386, true) < 1.5 then
				ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Prendi un Caffè")
					if IsControlJustReleased(0, 74) then
						SetCurrentPedWeapon(ped, -1569615261, true)
						ExecuteCommand('e keyfob')
						Citizen.Wait(1500)
						ExecuteCommand('e coffee')
						ESX.ShowHelpNotification("Buon proseguimento...")
						ESX.ShowNotification("Questo è un caffe roleplay, utile per le attesa in municipio.")
						ESX.ShowNotification("Puoi usarlo quando vuoi con ~y~/e coffee")
						Citizen.Wait(5000)					
					end
			end
		--end
	
		-- Caffe Libreria
		elseif GetDistanceBetweenCoords(coords, 243.933, -1599.01, 30.536, true) < 3.5 then
			DrawMarker(23, 243.933, -1599.01, 30.536, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.2, 255, 255, 0, 150, false, true, 2, false, false, false, false)
			-- Caffe Libreria Funzione
			if GetDistanceBetweenCoords(coords, 243.933, -1599.01, 30.536, true) < 1.5 then
				ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Caffè 3~g~$ ~w~(-3 Stress)")
					if IsControlJustReleased(0, 74) then
						SetCurrentPedWeapon(ped, -1569615261, true)
						ExecuteCommand('e keyfob')
						Citizen.Wait(1500)
						ExecuteCommand('e coffee')
						TriggerServerEvent('caffe:paga') 
						TriggerEvent('esx_status:remove', 'stress', 3)	
						ESX.ShowNotification("-3 Stress")
						Citizen.Wait(5000)					
					end
			end
		--end
		
		]]
		
		-- INFORMAZIONI BOT CAVALLO
		elseif GetDistanceBetweenCoords(coords, 2197.479, 5610.798, 52.541, true) < 2.5 then
			--DrawMarker(23, -63.082, -812.635, 242.386, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 0, 0, 150, false, true, 2, false, false, false, false)
			ESX.ShowHelpNotification("Entra senza veicolo, grazie.")
		--end	
		
		-- INFORMAZIONI BANCO LIBRERIA
		--[[
		elseif GetDistanceBetweenCoords(coords, 254.729, -1604.148, 30.536, true) < 3.5 then
			DrawMarker(23, 254.729, -1604.148, 30.536, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.2, 255, 255, 255, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, 254.729, -1604.148, 30.536, true) < 1.5 then
				ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Informazioni Libreria")
					if IsControlJustReleased(0, 74) then
						SetCurrentPedWeapon(ped, -1569615261, true)
						ExecuteCommand('e gdoc')
						ESX.ShowHelpNotification("Leggi le informazioni nei box a sinistra...")
						Citizen.Wait(3000)
						ESX.ShowNotification("La libreria serve per imparare nuove abilità in base alla scelta fatta per il tuo personaggio.")
						Citizen.Wait(5000)
						ESX.ShowNotification("Le abilità hanno un costo di ~h~Exp ~h~e possono raggiungere un massimo di livello 5.")
						Citizen.Wait(5000)
						ESX.ShowNotification("Più alto sarà il tuo livello più sarai bravo nelle attività della città.")
						Citizen.Wait(5000)
						ESX.ShowNotification("Ogni volta che imparerai una nuova abilità perderai il livello raggiunto nelle altre.")
						Citizen.Wait(5000)
						ESX.ShowNotification("~g~Disponibili: ~w~Meccanica, Agricoltore, Artigiano, Mirare.")
						Citizen.Wait(5000)
						ESX.ShowHelpNotification("Scegli bene, buon proseguimento...")
						Citizen.Wait(5000)
						ExecuteCommand('e c')
					end
			end
		]]
		--end	
		
		-- BANCO DEI LAVORI Municipio
		-- INFORMAZIONI SUI LAVORI
		elseif GetDistanceBetweenCoords(coords, -72.644, -816.112, 242.386, true) < 5.0 and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'menu_lavori')  then
			DrawMarker(23, -72.644, -816.112, 242.386, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.2, 255, 255, 255, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -72.644, -816.112, 242.386, true) < 1.5 then
				ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Lista Lavori")
					if IsControlJustReleased(0, 74) then
						OpenMenuLavori()
						ExecuteCommand('e gdoc')
					end
			end
		--end
		
		-- INFORMAZIONI SUI LAVORI
		elseif GetDistanceBetweenCoords(coords, -67.628, -815.996, 242.386, true) < 1.5 then
			DrawMarker(23, -67.628, -815.996, 242.386, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.2, 255, 255, 255, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -67.628, -815.996, 242.386, true) < 1.5 then
				ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Informazioni Lavoro")
					if IsControlJustReleased(0, 74) then
						SetCurrentPedWeapon(ped, -1569615261, true)
						ExecuteCommand('e gdoc')
						ESX.ShowHelpNotification("Leggi le informazioni nei box a sinistra...")
						Citizen.Wait(3000)
						ESX.ShowNotification("Tutti i lavori disponibili puoi trovarli sulla mappa con le icone assegnate.")
						Citizen.Wait(5000)
						ESX.ShowNotification("Non hai bisogno di essere assunto per i lavori disponibili sulla mappa.")
						Citizen.Wait(5000)
						ESX.ShowNotification("Per altre info usa ~b~Twitter ~w~per prenotare una consulenza con un addetto del municipio.")
						Citizen.Wait(5000)
						ESX.ShowNotification("Vai alla reception per tutta la lista lavori disponibili in città da libero professionista.")
						Citizen.Wait(5000)
						ESX.ShowHelpNotification("Buon proseguimento...")
						ExecuteCommand('e c')
					end
			end
		--end
			
		-- INFORMAZIONI SU NUOVE ATTIVITA
		elseif GetDistanceBetweenCoords(coords, -66.956, -814.472, 242.386, true) < 1.5 then
			DrawMarker(23, -66.956, -814.472, 242.386, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.2, 255, 255, 255, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -66.956, -814.472, 242.386, true) < 1.5 then
				ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ ~w~Informazioni Aziende")
					if IsControlJustReleased(0, 74) then
						SetCurrentPedWeapon(ped, -1569615261, true)
						ExecuteCommand('e gdoc')
						ESX.ShowHelpNotification("Leggi le informazioni nei box a sinistra...")
						Citizen.Wait(3000)
						ESX.ShowNotification("Se vuoi aprire una nuova azienda puoi richiedere una consulenza ad un addetto del Municipio.")
						Citizen.Wait(5000)
						ESX.ShowNotification("Se ci sono problemi con la tua attività dovresti recarti in ~b~Polizia~w~.")
						Citizen.Wait(5000)
						ESX.ShowNotification("Se non ci sono addetti al Municipio usa ~b~Twitter ~w~per prenotare una consulenza.")
						Citizen.Wait(5000)
						ESX.ShowHelpNotification("Buon proseguimento...")
						ExecuteCommand('e c')
					end
			end
			
		else
			-- ATTESA MAGGIORE
			Citizen.Wait(1000)
		end	
		-- FINE
else	
	Citizen.Wait(3000)	
end	 -- fine controllo Ragdoll
	end
	end -- while
end) -- FINE

-- LISTA LAVORI MENU
function OpenMenuLavori()
	local elements = {}		
	table.insert(elements, {label = '<span style="color:green;">Informazioni</span>',		value = 'info'})
	table.insert(elements, {label = 'Minatore',		value = 'minatore'})
	table.insert(elements, {label = 'Raccolta Cotone',		value = 'cotone'})
	table.insert(elements, {label = 'Lavorazione Cotone',		value = 'sarto'})
	table.insert(elements, {label = 'Autista Bus',		value = 'bus'})
	table.insert(elements, {label = 'Consegne Uber',		value = 'uber'})
	table.insert(elements, {label = 'Autolavaggio',		value = 'lavaggio'})
	table.insert(elements, {label = 'Cuoco / Cameriere',		value = 'cameriere'})
	table.insert(elements, {label = 'Raccolta Grano',		value = 'grano'})
	table.insert(elements, {label = 'Macellaio',		value = 'macellaio'})
	table.insert(elements, {label = 'Raccolta Latte',		value = 'latte'})
	table.insert(elements, {label = 'Taglialegna',		value = 'legna'})
	table.insert(elements, {label = 'Cacciatore',		value = 'caccia'})
	table.insert(elements, {label = 'Netturbino',		value = 'netturbino'})
	table.insert(elements, {label = 'Raccolta Arance',		value = 'arance'})
	table.insert(elements, {label = 'Raccolta Petrolio',		value = 'petrolio'})
	table.insert(elements, {label = 'Raccolta Pomodoro',		value = 'pomodoro'})
	table.insert(elements, {label = 'Pescatore',		value = 'pescatore'})	
	
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'menu_lavori',
		{
			title    = 'Lista Lavori',
			align    = 'top-left',
			elements = elements
		},
		function(data, menu)
	
	-- ThefeedHideThisFrame() -- NASCONDERE LE NOTIFICHE
	ClearPrints()
	if data.current.value == 'info' then ESX.ShowNotification("Seleziona un lavoro dal Menu per riceverne tutte le informazioni.") 
	ESX.ShowNotification("I seguenti lavori potrebbero essere automatizzati oppure idee e consigli per un tipo di lavoro.") 
	ESX.ShowNotification("Alcuni lavori gestiscono dei pacchi per veicolo, l'unico adibito al momento è il ~b~Rumpo~w~.") end
	if data.current.value == 'minatore' then ESX.ShowNotification("Trova la miniera sul radar e inizia a scavare per ottenere pietra da fondere.") 
	ESX.ShowNotification("Le pietre si fondono alla fonderia per ricavarne materiali da vendere all'import.") 
	ESX.ShowNotification("Per questo tipo di lavoro hai bisgno di un piccone e un veicolo per caricare le pietre.")
	ESX.ShowNotification("Item richiesto: ~b~Piccone~w~.")	end
	if data.current.value == 'cotone' then ESX.ShowNotification("Trova il campo di cotone sul radar e inizia a raccogliere cotone.") 
	ESX.ShowNotification("Il cotone può essere venduto all'import se richiesto, oppure venderlo a imprenditori di tessuto.") 
	ESX.ShowNotification("Per lavorare il cotone recati alla fabbrica di tessuto sul radar.")  end
	if data.current.value == 'sarto' then ESX.ShowNotification("Se possiedi cotone puoi lavorarlo per ottenere tessuto e venderlo.") 
	ESX.ShowNotification("Il cotone viene raccolto da tante persone, chiedi informazioni in RP per acquistarlo.") 
	ESX.ShowNotification("Crea il tuo roleplay e diventa un imprenditore offrendo un buon prezzo a chi ti consegna cotone.") end
	if data.current.value == 'bus' then ESX.ShowNotification("Recati in autostazione sul radar per diventare un Autista.") 
	ESX.ShowNotification("Per questo lavoro hai bisogno di una licenza bus che dovrai richiedere qui in Municipio.") 
	ESX.ShowNotification("Tieni conto che durante il tuo tragitto troverai giocatori che avranno bisogno di un passaggio.")  end
	if data.current.value == 'uber' then ESX.ShowNotification("Recati alle consegne Uber sul radar per consegnare cibo.") 
	ESX.ShowNotification("Ti verrà fornita una moto per consegnare cibo ai ristoranti in modo automatico.") 
	ESX.ShowNotification("Crea il tuo roleplay contattando le aziende di giocatori per offrirti come Driver Uber.")  end
	if data.current.value == 'lavaggio' then ESX.ShowNotification("Lavare un veicolo in città è molto impegnativo e richiede tempo.") 
	ESX.ShowNotification("Non tutti hanno voglia di lavarsi il veicolo e potrebbe essere una buona fonte di guadagno.") 
	ESX.ShowNotification("Acquista il sapone auto e crea il tuo roleplay usando Twitter per promuoverti.")  end
	if data.current.value == 'cameriere' then ESX.ShowNotification("Questo tipo di lavoro non è automatico, quindi ti diamo dei consigli per farlo.") 
	ESX.ShowNotification("In città esistono locali che offrono servizi di ristorazione che magari richiedono personale.") 
	ESX.ShowNotification("Leggi spesso il giornale per essere aggiornato sulle richiede di lavoro delle aziende.")  end
	if data.current.value == 'grano' then ESX.ShowNotification("Recati al campo di grano sulla mappa per iniziare a raccogliere.") 
	ESX.ShowNotification("Il grano è molto richiesto nella ristorazione, puoi venderlo all'import o creare il tuo RP.") 
	ESX.ShowNotification("Con il grano le aziende nelle cucine possono generare farina, utilizzata per la pasta.")  end
	if data.current.value == 'macellaio' then ESX.ShowNotification("Recati alla raccolta di polli per iniziare a raccogliere.") 
	ESX.ShowNotification("Uno dei lavori più difficili da con molti guadagni se gestito bene in RP.") 
	ESX.ShowNotification("Una volta raccolto il pollo bisogna lavorarlo e impachettarlo prima di poterlo vendere.")  end
	if data.current.value == 'latte' then ESX.ShowNotification("Recati alla raccolta di latte per ricevere informazioni.") 
	ESX.ShowNotification("Ti basta trovare una mucca per iniziare a mungerla e ottenere il latte.") end
	if data.current.value == 'legna' then ESX.ShowNotification("Recati alla falegnameria sul radar per iniziare il lavoro.") 
	ESX.ShowNotification("Un lavoro solo per duri visto che causa molto stress durante la lavorazione.") 
	ESX.ShowNotification("Uno dei materiali più richiesti da lavorare per la costruzione di oggetti.")  end
	if data.current.value == 'caccia' then ESX.ShowNotification("Questo lavoro non è automatizzato quindi ti daremo dei consigli.") 
	ESX.ShowNotification("Una volta ricevuta la licenza di caccia in roleplay potrai cacciare qualsiasi animale.") 
	ESX.ShowNotification("Una volta ucciso l'animale potrai scuoiarlo con il menu rapido e ottenere carni o pelle.")  end
	if data.current.value == 'netturbino' then ESX.ShowNotification("Questo lavoro non è automatizzato quindi ti daremo dei consigli.") 
	ESX.ShowNotification("Potrai avvicinarti vicino a qualsaisi tipo di ~b~/pattume ~w~per poterlo raccogliere.") 
	ESX.ShowNotification("Una volta ottenuto il pattume potrai portarlo alla discarica e guadagnare in basse alla quantità.")
	ESX.ShowNotification("Per essere autorizzato a queste operazioni dovrai ottenere una licenza.")	end
	if data.current.value == 'arance' then ESX.ShowNotification("Recati al campo di arance sul radar per iniziare a raccogliere.") 
	ESX.ShowNotification("Con le arance le aziende posso creare dei succhi di frutta, richieste all'import.") 
	ESX.ShowNotification("Per questo tipo di lavoro avrai bisogno di un veicolo per le casse: ~b~Rumpo~w~.") end
	if data.current.value == 'petrolio' then ESX.ShowNotification("Recati alla raffineria sul radar per iniziare a raccogliere.") 
	ESX.ShowNotification("Il petrolio ha diversi utilizzi in città ed è richiesto all'import.") 
	ESX.ShowNotification("Con il petrolio lavorato / raffinato avrai la possibilità di guadagnare più soldi alla vendita.") end
	if data.current.value == 'pomodoro' then ESX.ShowNotification("Recati al campo di pomodori sul radar per iniziare a raccogliere.") 
	ESX.ShowNotification("Con i pomodori le aziende posso creare dei sughi da usare con la pasta, richieste all'import.") 
	ESX.ShowNotification("Per questo tipo di lavoro avrai bisogno di un veicolo per le casse: ~b~Rumpo~w~.") end
	if data.current.value == 'pescatore' then ESX.ShowNotification("Questo lavoro non è automatizzato quindi ti daremo dei consigli.") 
	ESX.ShowNotification("Una volta ricevuta la licenza di pesca in roleplay potrai pescare in qualsiasi zona con acqua.") 
	ESX.ShowNotification("Esistono molte specie di pesci che i locali richiedono per piatti prelibati.")
	ESX.ShowNotification("Item richiesto: ~b~Canna da pesca~w~.") end
							
		end,
		function(data, menu)
			menu.close()
			ExecuteCommand('e c')
		end
	)
end

--[[
local Notif = {}
RegisterNetEvent("hud:NotifKey")
AddEventHandler("hud:NotifKey", function(icon,text)
    Citizen.CreateThread(function()
        Wait(1)
        SetNotificationTextEntry("STRING")
        local Notification = Citizen.InvokeNative(0xDD6CB2CCE7C2735C,1,icon,text)
        table.insert(Notif,Notification)
    end)
end)

RegisterNetEvent('hud:NotifDel')
AddEventHandler('hud:NotifDel', function()
    for a,v in pairs(Notif) do
        RemoveNotification(v)
    end
   Notif = {}
end)
]]

RegisterNetEvent('cavallo:spawnPedPos')
AddEventHandler('cavallo:spawnPedPos', function(model, x, y, z, h)
	model = (tonumber(model) ~= nil and tonumber(model) or GetHashKey(model))
	Citizen.CreateThread(function()
		RequestModel(model)

		while not HasModelLoaded(model) do
			Citizen.Wait(1)
		end
		
		if MIOCAVALLO ~= nil then
			if DoesEntityExist(MIOCAVALLO) then 
				DeleteEntity(MIOCAVALLO)
				RemoveBlip(Sospetto)
			end
		end
		
		MIOCAVALLO = CreatePed(5, model, x, y, z, h, true, false)
		SetEntityAsMissionEntity(MIOCAVALLO, true, true)
		
		Sospetto = AddBlipForEntity(MIOCAVALLO)
		SetBlipSprite(Sospetto, 141)
		SetBlipColour(Sospetto, 31)
		SetBlipScale(Sospetto, 0.7)
		SetBlipAsShortRange(Sospetto, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Il tuo Cavallo')
		EndTextCommandSetBlipName(Sospetto)
		
	end)
end)

--[[
Citizen.CreateThread(function()
	while true do
      
	Citizen.Wait(5)
		
		local coords = GetEntityCoords(PlayerPedId())
		for k, v in pairs(store) do
			if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.5 then
				InFarmacia = true
				--DrawText3D(v.x, v.y, v.z+0.9, k, 0.80)
				ESX.ShowHelpNotification(k)
				if IsControlPressed(0, 38) then
					OpenPharmacyMenu()
				end
			end
		end
		
		if not InFarmacia then
			Citizen.Wait(5000)
		end
		
		InFarmacia = false
		
	end
end)
]]




local checkNPC = false
local messaggio = false
local waitMex = true
-- Funzione NPC Chiesa & Ascensore Municipio
Citizen.CreateThread(function()
--loop4 = function()
	while true do Citizen.Wait(100)
	if ped ~= nil then
		local coords = GetEntityCoords(ped)
		
		for k, v in pairs(NPC_Chiesa) do
			if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 2.0 then
				if not checkNPC then checkNPC = true end
				--DrawText3D(v.x, v.y, v.z+0.9, k, 0.80)
				if not messaggio then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Fai un offerta 10-300~g~$") messaggio = true end
				if IsControlPressed(0, 74) then
					local TOT = math.random(10, 300)
					ESX.ShowHelpNotification("Hai fatto un offerta di " .. TOT .. "~g~$") 
					TriggerServerEvent('chiesa:Offerta', TOT, securityToken)
					ExecuteCommand('e adjusttie')
					Citizen.Wait(30000)
				end
			end
		end
				
		
		for k, v in pairs(NPC_Povero) do
			if v.npcpovero then 
				if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 2.0 then
					if not checkNPC then checkNPC = true end
					--DrawText3D(v.x, v.y, v.z+0.9, k, 0.80)
					if not messaggio then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Fai un offerta 1-5~g~$") messaggio = true end
					if IsControlPressed(0, 74) then
						local TOT = math.random(1, 5)
						ESX.ShowHelpNotification("Hai fatto un offerta di " .. TOT .. "~g~$") 
						TriggerServerEvent('chiesa:Povero', TOT, securityToken)
						ExecuteCommand('e damn2')
						Citizen.Wait(10000)
					end
				end
			elseif v.ShopN then -- Saluto NPC
				if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 15.0 then
					if not checkNPC then checkNPC = true end 
					--DrawText3D(v.x, v.y, v.z+0.9, k, 0.80)
					if not IsControlPressed(0, Keys['LEFTALT']) and IsControlPressed(0, Keys['F9']) then
						-- Animazione Saluto del Bot
						RequestAnimDict("friends@frj@ig_1")
						while not HasAnimDictLoaded("friends@frj@ig_1") do
							Wait(100)
						end
						Wait(2000)
						TaskPlayAnim(v.PedID, "friends@frj@ig_1", "wave_e" ,8.0, 1, 2500, 0, 0, false, false, false)
						Citizen.Wait(10000)
					end
				end
			end
		end
		
		if not checkNPC then 
			Citizen.Wait(5000)
		end
		
		checkNPC = false
	end	
	end
end)

-- Funzione NPC Chiesa & Ascensore Municipio

Citizen.CreateThread(function()
--loop5 = function()
	while true do Citizen.Wait(10)
	if ped ~= nil then 
		local coords = GetEntityCoords(ped)
		
if not IsPedInAnyVehicle(ped,true) and not IsPedRagdoll(ped) then 
		-- MUNICIPIO
		if GetDistanceBetweenCoords(coords, -264.198, -959.924, 31.22, true) < 1.2 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Ascensore: ~h~Municipio")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				SetEntityCoords(ped,-78.541, -829.747, 242.386)
				Citizen.Wait(500)
				SetEntityHeading(ped, 240.856)
				Citizen.Wait(2000)
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
		elseif GetDistanceBetweenCoords(coords, -75.59, -827.134, 243.386, true) < 1.2 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Ascensore: ~h~Ingresso")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				SetEntityCoords(ped,-270.91, -957.782, 30.223)
				Citizen.Wait(500)
				SetEntityHeading(ped, 296.0)
				Citizen.Wait(2000)
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
				
		-- GALAXY PER ANDARE DENTRO
		elseif GetDistanceBetweenCoords(coords, -2190.095, -399.755, 12.295, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Glaxy")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)				
				SetEntityCoords(ped, -1569.398, -3017.457, -74.406)
				Citizen.Wait(500)
				SetEntityHeading(ped, 357.0)
				Citizen.Wait(2000)			
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
		elseif GetDistanceBetweenCoords(coords, -1569.398, -3017.457, -73.406, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Uscita")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				SetEntityCoords(ped, -2190.095, -399.755, 13.295)
				Citizen.Wait(500)
				SetEntityHeading(ped, 225.0)
				Citizen.Wait(2000)
				DoScreenFadeIn(800)
				ClearHelp(true)
			end	
				
		-- PORTO MERRY PORTA Sopra
		elseif GetDistanceBetweenCoords(coords, 483.801, -3065.686, 16.088, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Entra")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				SetEntityCoords(ped, 511.379, -3118.344, 24.572)			
				Citizen.Wait(100)
				SetEntityHeading(ped, 84.061)
				ExecuteCommand('e knock2')
				Citizen.Wait(1000)
				DoScreenFadeIn(800)
				ESX.ShowHelpNotification("La porta sembra aprirsi solo dall'esterno e non puoi tornare indietro.")
				Citizen.Wait(5000)
				ExecuteCommand('e c')
				Citizen.Wait(500)
				ExecuteCommand('e shrug')
			end	

		-- CASA MEDUSA (Fazione)		
		elseif GetDistanceBetweenCoords(coords, -2998.248, 55.368, 11.263, true) < 1.5 then -- ENTRATA 
			if waitMex then ESX.ShowHelpNotification("~INPUT_PICKUP~ Serratura ~INPUT_VEH_HEADLIGHT~ Entra") end
			if IsControlJustReleased(0, 74) then 
				ESX.TriggerServerCallback('fazione:portaMedusa', function(lock)
					if lock then
						DoScreenFadeOut(800) Citizen.Wait(800) SetEntityCoords(ped, 346.564, -1002.735, -100.196) Citizen.Wait(10) SetEntityHeading(ped, 358.0) Citizen.Wait(800) DoScreenFadeIn(800) ClearHelp(true) Citizen.Wait(1000) 
					else
						ExecuteCommand('e shrug')
						ESX.ShowHelpNotification('La porta sembra chiusa a chiave.')
					end
					waitMex = false
					Citizen.Wait(1500)
					waitMex = true
				end)	
			elseif IsControlJustReleased(0, 38) then 
				ESX.TriggerServerCallback('lavoro:getjob2', function(lavoro)
				if lavoro then
					ESX.TriggerServerCallback('fazione:portaMedusa', function(lock)
						if lock then
							ExecuteCommand('e keyfob')
							TriggerServerEvent('fazione:aprimedusa', false)
						else
							ExecuteCommand('e keyfob')
							TriggerServerEvent('fazione:aprimedusa', true)
						end
						waitMex = false
						Citizen.Wait(1500)
						waitMex = true
					end)	
				else
					ExecuteCommand('e no')
					ESX.ShowHelpNotification('Non hai le chiavi di questa serratura.')
					waitMex = false
					Citizen.Wait(1500)
					waitMex = true
				end		
				end, 'medusa')		
			end		
		elseif GetDistanceBetweenCoords(coords, 346.564, -1002.735, -100.196, true) < 1.5 then -- USCITA
			if waitMex then ESX.ShowHelpNotification("~INPUT_PICKUP~ Serratura ~INPUT_VEH_HEADLIGHT~ Esci") end
			if IsControlJustReleased(0, 74) then 
				ESX.TriggerServerCallback('fazione:portaMedusa', function(lock)
					if lock then
						DoScreenFadeOut(800) Citizen.Wait(800) SetEntityCoords(ped, -2998.248, 55.368, 11.263) Citizen.Wait(800) DoScreenFadeIn(800) Citizen.Wait(10) SetEntityHeading(ped, 150.0) ClearHelp(true) Citizen.Wait(1000) 
					else
						ExecuteCommand('e shrug')
						ESX.ShowHelpNotification('La porta sembra chiusa a chiave.')
					end
					waitMex = false
					Citizen.Wait(1500)
					waitMex = true
				end)	
			elseif IsControlJustReleased(0, 38) then 
				ESX.TriggerServerCallback('lavoro:getjob2', function(lavoro)
				if lavoro then
					ESX.TriggerServerCallback('fazione:portaMedusa', function(lock)
						if lock then
							ExecuteCommand('e keyfob')
							TriggerServerEvent('fazione:aprimedusa', false)
						else
							ExecuteCommand('e keyfob')
							TriggerServerEvent('fazione:aprimedusa', true)
						end
						waitMex = false
						Citizen.Wait(1500)
						waitMex = true
					end)	
				else
					ExecuteCommand('e no')
					ESX.ShowHelpNotification('Non hai le chiavi di questa serratura.')
					waitMex = false
					Citizen.Wait(1500)
					waitMex = true
				end		
				end, 'medusa')		
			end
			
		-- Terrazza Garage Lane		
		elseif GetDistanceBetweenCoords(coords, -61.003, 360.396, 112.056, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Terrazza")
			if IsControlJustReleased(0, 74) then DoScreenFadeOut(800) Citizen.Wait(800) SetEntityCoords(ped, -62.556, 358.915, 141.618) Citizen.Wait(10) SetEntityHeading(ped, 240.0) Citizen.Wait(800) DoScreenFadeIn(800) ClearHelp(true) Citizen.Wait(1000) end
		elseif GetDistanceBetweenCoords(coords, -62.556, 358.915, 141.618, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Scendi")
			if IsControlJustReleased(0, 74) then DoScreenFadeOut(800) Citizen.Wait(800) SetEntityCoords(ped, -61.003, 360.396, 112.056) Citizen.Wait(10) SetEntityHeading(ped, 240.0) Citizen.Wait(800) DoScreenFadeIn(800) ClearHelp(true) Citizen.Wait(1000) end
		
		-- PARCHEGGIO ARCADIUS
		elseif GetDistanceBetweenCoords(coords, -144.11, -576.995, 31.424, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Terrazza")
			if IsControlJustReleased(0, 74) then DoScreenFadeOut(800) Citizen.Wait(800) SetEntityCoords(ped, -124.888, -637.471, 39.686) Citizen.Wait(10) SetEntityHeading(ped, 160.0) Citizen.Wait(800) DoScreenFadeIn(800) ClearHelp(true) Citizen.Wait(1000) end
		elseif GetDistanceBetweenCoords(coords, -124.888, -637.471, 39.686, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Scendi")
			if IsControlJustReleased(0, 74) then DoScreenFadeOut(800) Citizen.Wait(800) SetEntityCoords(ped, -144.11, -576.995, 31.424) Citizen.Wait(10) SetEntityHeading(ped, 338.0) Citizen.Wait(800) DoScreenFadeIn(800) ClearHelp(true) Citizen.Wait(1000) end
		
		-- UFFICO Pattume
		-- PARCHEGGIO ARCADIUS
		elseif GetDistanceBetweenCoords(coords, 871.775, -2309.062, 29.57, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Entra")
			if IsControlJustReleased(0, 74) then DoScreenFadeOut(800) Citizen.Wait(800) SetEntityCoords(ped, 998.224, -2390.714, 29.139) Citizen.Wait(10) SetEntityHeading(ped, 265.0) Citizen.Wait(800) DoScreenFadeIn(800) ClearHelp(true) Citizen.Wait(1000) end
		elseif GetDistanceBetweenCoords(coords, 998.224, -2390.714, 29.139, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Esci")
			if IsControlJustReleased(0, 74) then DoScreenFadeOut(800) Citizen.Wait(800) SetEntityCoords(ped, 871.775, -2309.062, 29.57) Citizen.Wait(10) SetEntityHeading(ped, 80.0) Citizen.Wait(800) DoScreenFadeIn(800) ClearHelp(true) Citizen.Wait(1000) end
		
		-- Terrazza Villa Pro
		--[[
		elseif GetDistanceBetweenCoords(coords, -1480.729, -40.848, 55.844, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Terrazza")
			if IsControlJustReleased(0, 74) then DoScreenFadeOut(800) Citizen.Wait(800) SetEntityCoords(ped, -1477.448, -35.007, 61.007) Citizen.Wait(10) SetEntityHeading(ped, 40.0) Citizen.Wait(800) DoScreenFadeIn(800) ClearHelp(true) Citizen.Wait(1000) end
		elseif GetDistanceBetweenCoords(coords, -1477.448, -35.007, 61.007, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Scendi")
			if IsControlJustReleased(0, 74) then DoScreenFadeOut(800) Citizen.Wait(800) SetEntityCoords(ped, -1480.729, -40.848, 55.844) Citizen.Wait(10) SetEntityHeading(ped, 125.0) Citizen.Wait(800) DoScreenFadeIn(800) ClearHelp(true) Citizen.Wait(1000) end
		]]
		-- RISALI dal lago
		elseif GetDistanceBetweenCoords(coords, 23.135, 639.192, 195.285, true) < 5.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Sali")
			if IsControlJustReleased(0, 74) then DoScreenFadeOut(800) Citizen.Wait(3000) SetEntityCoords(ped, 23.207, 638.191, 206.39) Citizen.Wait(10) SetEntityHeading(ped, 190.0) Citizen.Wait(800) DoScreenFadeIn(800) ClearHelp(true) Citizen.Wait(1000) end
		
		-- FARO
		elseif GetDistanceBetweenCoords(coords, 3426.878, 5174.683, 6.414, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Sali sul Faro")
			if IsControlJustReleased(0, 74) then DoScreenFadeOut(800) Citizen.Wait(800) SetEntityCoords(ped, 3433.214, 5173.404, 34.805) Citizen.Wait(10) SetEntityHeading(ped, 246.0) Citizen.Wait(800) DoScreenFadeIn(800) ClearHelp(true) Citizen.Wait(1000) end
		elseif GetDistanceBetweenCoords(coords, 3433.214, 5173.404, 34.805, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Scendi")
			if IsControlJustReleased(0, 74) then DoScreenFadeOut(800) Citizen.Wait(800) SetEntityCoords(ped, 3426.878, 5174.683, 6.414) Citizen.Wait(10) SetEntityHeading(ped, 80.0) Citizen.Wait(800) DoScreenFadeIn(800) ClearHelp(true) Citizen.Wait(1000) end
		
		-- GALAXY DIETRO LA CASSA
		elseif GetDistanceBetweenCoords(coords, -1582.148, -3018.355, -80.006, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Reception")
			if IsControlJustReleased(0, 74) then DoScreenFadeOut(800) Citizen.Wait(800) SetEntityCoords(ped, -1572.951, -3014.476, -75.406) Citizen.Wait(10) SetEntityHeading(ped, 270.0) Citizen.Wait(800) DoScreenFadeIn(800) ClearHelp(true) Citizen.Wait(1000) end
		elseif GetDistanceBetweenCoords(coords, -1572.951, -3014.476, -75.406, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Esci")
			if IsControlJustReleased(0, 74) then DoScreenFadeOut(800) Citizen.Wait(800) SetEntityCoords(ped, -1582.148, -3018.355, -80.006) Citizen.Wait(10) SetEntityHeading(ped, -90.0) Citizen.Wait(800) DoScreenFadeIn(800) ClearHelp(true) Citizen.Wait(1000) end
		
		-- CASETTA GANG
		elseif GetDistanceBetweenCoords(coords, -62.399, -1532.668, 33.235, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Entra")
			if IsControlJustReleased(0, 74) then DoScreenFadeOut(800) Citizen.Wait(800) SetEntityCoords(ped, 265.158, -1001.238, -100.009) Citizen.Wait(10) SetEntityHeading(ped, 355.0) Citizen.Wait(800) DoScreenFadeIn(800) ClearHelp(true) Citizen.Wait(1000) end
		elseif GetDistanceBetweenCoords(coords, 265.158, -1001.238, -100.009, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Esci")
			if IsControlJustReleased(0, 74) then DoScreenFadeOut(800) Citizen.Wait(800) SetEntityCoords(ped, -62.399, -1532.668, 33.235) Citizen.Wait(10) SetEntityHeading(ped, 320.0) Citizen.Wait(800) DoScreenFadeIn(800) ClearHelp(true) Citizen.Wait(1000) end

		-- CARAVANS
		--[[
		elseif GetDistanceBetweenCoords(coords, 2166.152, 3380.126, 45.435, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Caravan #1")
			if IsControlJustReleased(0, 74) then SetEntityCoords(ped, 2165.326, 3380.709, 40.54) Citizen.Wait(10) SetEntityHeading(ped, 53.0) ClearHelp(true) Citizen.Wait(1000) end
		elseif GetDistanceBetweenCoords(coords, 2165.326, 3380.709, 40.54, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Uscita Caravan #1")
			if IsControlJustReleased(0, 74) then SetEntityCoords(ped, 2166.152, 3380.126, 45.435) Citizen.Wait(10) SetEntityHeading(ped, 233.0) ClearHelp(true) Citizen.Wait(1000) end

		elseif GetDistanceBetweenCoords(coords, 2167.954, 3331.223, 45.49, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Caravan #2")
			if IsControlJustReleased(0, 74) then SetEntityCoords(ped, 2170.076, 3330.863, 41.221) Citizen.Wait(10) SetEntityHeading(ped, 208.0) ClearHelp(true) Citizen.Wait(1000) end
		elseif GetDistanceBetweenCoords(coords, 2170.076, 3330.863, 41.221, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Uscita Caravan #2")
			if IsControlJustReleased(0, 74) then SetEntityCoords(ped, 2167.954, 3331.223, 45.49) Citizen.Wait(10) SetEntityHeading(ped, 24.0) ClearHelp(true) Citizen.Wait(1000) end

		elseif GetDistanceBetweenCoords(coords, 2200.667, 3318.078, 46.051, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Caravan #3")
			if IsControlJustReleased(0, 74) then SetEntityCoords(ped, 2202.931, 3314.104, 40.468) Citizen.Wait(10) SetEntityHeading(ped, 118.0) ClearHelp(true) Citizen.Wait(1000) end
		elseif GetDistanceBetweenCoords(coords, 2202.931, 3314.104, 40.468, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Uscita Caravan #3")
			if IsControlJustReleased(0, 74) then SetEntityCoords(ped, 2201.884, 3318.654, 45.121) Citizen.Wait(10) SetEntityHeading(ped, 290.0) ClearHelp(true) Citizen.Wait(1000) end

		elseif GetDistanceBetweenCoords(coords, 2178.989, 3496.521, 44.984, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Caravan #4")
			if IsControlJustReleased(0, 74) then SetEntityCoords(ped, 2181.884, 3497.654, 40.248) Citizen.Wait(10) SetEntityHeading(ped, 220.0) ClearHelp(true) Citizen.Wait(1000) end
		elseif GetDistanceBetweenCoords(coords, 2181.884, 3497.654, 40.248, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Uscita Caravan #4")
			if IsControlJustReleased(0, 74) then SetEntityCoords(ped, 2178.989, 3496.521, 44.984) Citizen.Wait(10) SetEntityHeading(ped, 35.0) ClearHelp(true) Citizen.Wait(1000) end

		elseif GetDistanceBetweenCoords(coords, 2392.856, 3320.598, 47.456, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Caravan #5") -- ENTRATA
			if IsControlJustReleased(0, 74) then SetEntityCoords(ped, 2388.389, 3313.184, 42.87) Citizen.Wait(10) SetEntityHeading(ped, 312.0) ClearHelp(true) Citizen.Wait(1000) end
		elseif GetDistanceBetweenCoords(coords, 2388.389, 3313.184, 42.87, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Uscita Caravan #5") -- USCITA
			if IsControlJustReleased(0, 74) then SetEntityCoords(ped, 2392.856, 3320.598, 47.456) Citizen.Wait(10) SetEntityHeading(ped, 305.0) ClearHelp(true) Citizen.Wait(1000) end

		elseif GetDistanceBetweenCoords(coords, 2389.427, 3341.745, 46.934, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Caravan #6") -- ENTRATA
			if IsControlJustReleased(0, 74) then SetEntityCoords(ped, 2387.31, 3339.99, 40.265) Citizen.Wait(10) SetEntityHeading(ped, 33.0) ClearHelp(true) Citizen.Wait(1000) end
		elseif GetDistanceBetweenCoords(coords, 2387.31, 3339.99, 40.265, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Uscita Caravan #6") -- USCITA
			if IsControlJustReleased(0, 74) then SetEntityCoords(ped, 2389.427, 3341.745, 46.934) Citizen.Wait(10) SetEntityHeading(ped, 216.0) ClearHelp(true) Citizen.Wait(1000) end

		elseif GetDistanceBetweenCoords(coords, 2484.12, 3445.948, 50.068, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Caravan #7") -- ENTRATA
			if IsControlJustReleased(0, 74) then SetEntityCoords(ped, 2482.927, 3444.911, 44.026) Citizen.Wait(10) SetEntityHeading(ped, 133.0) ClearHelp(true) Citizen.Wait(1000) end
		elseif GetDistanceBetweenCoords(coords, 2482.927, 3444.911, 44.026, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Uscita Caravan #7") -- USCITA
			if IsControlJustReleased(0, 74) then SetEntityCoords(ped, 2484.12, 3445.948, 50.068) Citizen.Wait(10) SetEntityHeading(ped, 316.0) ClearHelp(true) Citizen.Wait(1000) end
		]]
		
		-- HOTEL ARCIPELAGO
		elseif GetDistanceBetweenCoords(coords, -1097.654, -325.395, 36.824, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Vai al tetto") -- ENTRATA
			if IsControlJustReleased(0, 74) then Citizen.Wait(1000) SetEntityCoords(ped, -1112.734, -335.449, 49.017) Citizen.Wait(10) SetEntityHeading(ped, 85.0) ClearHelp(true) Citizen.Wait(1000) end
		elseif GetDistanceBetweenCoords(coords, -1112.734, -335.449, 49.017, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Scendi") -- USCITA
			if IsControlJustReleased(0, 74) then Citizen.Wait(1000) SetEntityCoords(ped, -1097.654, -325.395, 36.824) Citizen.Wait(10) SetEntityHeading(ped, 360.0) ClearHelp(true) Citizen.Wait(1000) end
		
		-- ASCENSORE GIORNALISTI LIFE INVADER
		elseif GetDistanceBetweenCoords(coords, -1075.285, -253.367, 36.763, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Sali") -- ENTRATA
			if IsControlJustReleased(0, 74) then Citizen.Wait(1000) SetEntityCoords(ped, -1075.285, -253.367, 36.763) Citizen.Wait(10) SetEntityHeading(ped, 25.0) ClearHelp(true) Citizen.Wait(1000) end
		elseif GetDistanceBetweenCoords(coords, -1075.278, -253.45, 43.021, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Scendi") -- USCITA
			if IsControlJustReleased(0, 74) then Citizen.Wait(1000) SetEntityCoords(ped, -1075.285, -253.367, 36.763) Citizen.Wait(10) SetEntityHeading(ped, 25.0) ClearHelp(true) Citizen.Wait(1000) end
		elseif GetDistanceBetweenCoords(coords, -1077.953, -254.689, 36.763, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Sali") -- ENTRATA
			if IsControlJustReleased(0, 74) then Citizen.Wait(1000) SetEntityCoords(ped, -1077.851, -254.671, 43.021) Citizen.Wait(10) SetEntityHeading(ped, 25.0) ClearHelp(true) Citizen.Wait(1000) end
		elseif GetDistanceBetweenCoords(coords, -1077.851, -254.671, 43.021, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Scendi") -- USCITA
			if IsControlJustReleased(0, 74) then Citizen.Wait(1000) SetEntityCoords(ped, -1077.953, -254.689, 36.763) Citizen.Wait(10) SetEntityHeading(ped, 25.0) ClearHelp(true) Citizen.Wait(1000) end
			
		-- FOGNE 1
		elseif GetDistanceBetweenCoords(coords, 1000.005,-99.973,74.127, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Fogne #1") -- ENTRATA
			if IsControlJustReleased(0, 74) then Citizen.Wait(1000) SetEntityCoords(ped, 984.643, -147.12, 36.966) Citizen.Wait(10) SetEntityHeading(ped, 145.0) ClearHelp(true) Citizen.Wait(1000) end
		elseif GetDistanceBetweenCoords(coords, 984.643, -147.12, 33.966, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Uscita Fogne #1") -- USCITA
			if IsControlJustReleased(0, 74) then Citizen.Wait(1000) SetEntityCoords(ped, 1000.005,-99.973,74.127) Citizen.Wait(10) SetEntityHeading(ped, 144.0) ClearHelp(true) Citizen.Wait(1000) end

		-- FOGNE 2
		elseif GetDistanceBetweenCoords(coords, 814.769, -289.614, 65.463, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Fogne #2") -- ENTRATA
			if IsControlJustReleased(0, 74) then Citizen.Wait(1000) SetEntityCoords(ped, 858.844, -270.617, 13.25) Citizen.Wait(10) SetEntityHeading(ped, 52.0) ClearHelp(true) Citizen.Wait(1000) end
		elseif GetDistanceBetweenCoords(coords, 858.844, -270.617, 11.25, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Uscita Fogne #2") -- USCITA
			if IsControlJustReleased(0, 74) then Citizen.Wait(1000) SetEntityCoords(ped, 814.769, -289.614, 65.463) Citizen.Wait(10) SetEntityHeading(ped, 190.0) ClearHelp(true) Citizen.Wait(1000) end
		
		-- ASCENSORE HUMAN
		elseif GetDistanceBetweenCoords(coords, 3540.663, 3675.462, 27.121, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Ascensore") -- ENTRATA
			if IsControlJustReleased(0, 74) then DoScreenFadeOut(800) Citizen.Wait(1000) SetEntityCoords(ped, 3540.584, 3675.541, 19.992) Citizen.Wait(10) SetEntityHeading(ped, 165.0) ClearHelp(true) Citizen.Wait(1000) DoScreenFadeIn(800) end
		elseif GetDistanceBetweenCoords(coords, 3540.584, 3675.541, 19.992, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Ascensore") -- USCITA
			if IsControlJustReleased(0, 74) then DoScreenFadeOut(800) Citizen.Wait(1000) SetEntityCoords(ped, 3540.663, 3675.462, 27.121) Citizen.Wait(10) SetEntityHeading(ped, 165.0) ClearHelp(true) Citizen.Wait(1000) DoScreenFadeIn(800) end
		
		-- ASCENSORE APPARTMENT
		elseif GetDistanceBetweenCoords(coords, -1564.426, -406.261, 41.384, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Entra") -- ENTRATA
			if IsControlJustReleased(0, 74) then DoScreenFadeOut(800) Citizen.Wait(1000) SetEntityCoords(ped, -1575.824, -398.914, 41.389) Citizen.Wait(10) SetEntityHeading(ped, 140.0) ClearHelp(true) Citizen.Wait(1000) DoScreenFadeIn(800) end
		elseif GetDistanceBetweenCoords(coords, -1575.824, -398.914, 41.389, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Esci") -- USCITA
			if IsControlJustReleased(0, 74) then DoScreenFadeOut(800) Citizen.Wait(1000) SetEntityCoords(ped, -1564.426, -406.261, 41.384) Citizen.Wait(10) SetEntityHeading(ped, 50.0) ClearHelp(true) Citizen.Wait(1000) DoScreenFadeIn(800) end
		
		-- MUNGERE Latte
		elseif GetDistanceBetweenCoords(coords, 2251.478, 5155.481, 56.887, true) < 1.5 then ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Informazioni Latte") -- ENTRATA
			if IsControlJustReleased(0, 74) then ExecuteCommand('e clipboard') ESX.ShowNotification("Trova una mucca e premi ~b~E ~w~nelle sue vicinanze per mungere il latte.") Citizen.Wait(7000) ExecuteCommand('e c') Citizen.Wait(1000) end
		
		--[[ ]]
		
		elseif GetDistanceBetweenCoords(coords, 466.395, -576.539, 27.5, true) < 5.5 then
			DrawMarker(23, 466.395, -576.539+0.02, 27.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, 466.395, -576.539, 27.5, true) < 1.5 then
				
				if BUSAffittato == nil then 
					ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Lavoro ~b~Autista Bus")
				--else
				--	ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Annulla Lavoro ~b~Autista Bus")
				end
					
				if IsControlJustReleased(0, 74) then
					OpenBusMenu() 
				end
			
			end
		
		-- Ascensore OSPEDALE da CLINICA per andare al TETTO 
		elseif GetDistanceBetweenCoords(coords, 334.466, -580.848, 47.348, true) < 1.5 then
			DrawMarker(23, 334.466, -580.848, 47.348, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, 334.466, -580.848, 47.348, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Ascensore: ~h~~r~Tetto")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, 338.892, -583.864, 74.166)
				Citizen.Wait(500)
				SetEntityHeading(ped, 355.0)
				Citizen.Wait(2000)			
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
		elseif GetDistanceBetweenCoords(coords, 338.892, -583.864, 73.166, true) < 1.5 then
			DrawMarker(23, 338.892, -583.864, 73.166, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, 338.892, -583.864, 73.166, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Ascensore: ~h~~y~Clinica")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, 334.466, -580.848, 47.348)
				Citizen.Wait(500)
				SetEntityHeading(ped, 246.0)
				Citizen.Wait(2000)
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
			
		-- Entrata Diamond		
		elseif GetDistanceBetweenCoords(coords, 926.386, 45.69, 80.106, true) < 1.5 then
			DrawMarker(23, 926.386, 45.69, 80.106, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, 926.386, 45.69, 80.106, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Entrata ~b~Diamond")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, 1089.662, 206.217, -50.0)
				Citizen.Wait(500)
				SetEntityHeading(ped, 3.0)
				Citizen.Wait(2000)			
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
		elseif GetDistanceBetweenCoords(coords, 1089.662, 206.217, -50.0, true) < 1.5 then
			DrawMarker(23, 1089.662, 206.217, -50.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, 1089.662, 206.217, -50.0, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Uscita ~b~Diamond")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, 926.386, 45.69, 80.106)
				Citizen.Wait(500)
				SetEntityHeading(ped, 59.0)
				Citizen.Wait(2000)
				DoScreenFadeIn(800)
				ClearHelp(true)
				ExecuteCommand('getobj')
			end
			end
			
		-- UFFICIO PRESIDENTE (Fazione)		
		elseif GetDistanceBetweenCoords(coords, -1011.029, -479.826, 38.971, true) < 1.5 then -- ENTRATA 
			if waitMex then ESX.ShowHelpNotification("~INPUT_PICKUP~ Serratura ~INPUT_VEH_HEADLIGHT~ Entra") end
			if IsControlJustReleased(0, 74) then 
				ESX.TriggerServerCallback('fazione:portaPresidente', function(lock)
					if lock then
						ExecuteCommand('e keyfob') DoScreenFadeOut(800) Citizen.Wait(800) SetEntityCoords(ped, -1003.297, -477.964, 49.027) Citizen.Wait(10) SetEntityHeading(ped, 0.0) Citizen.Wait(800) DoScreenFadeIn(800) ClearHelp(true) Citizen.Wait(1000) 
					else
						ExecuteCommand('e shrug')
						ESX.ShowHelpNotification('La porta sembra chiusa a chiave.')
					end
					waitMex = false
					Citizen.Wait(1500)
					waitMex = true
				end)	
			elseif IsControlJustReleased(0, 38) then 
				ESX.TriggerServerCallback('lavoro:getjob2', function(lavoro)
				if lavoro then
					ESX.TriggerServerCallback('fazione:portaPresidente', function(lock)
						if lock then
							ExecuteCommand('e keyfob')
							TriggerServerEvent('fazione:apripresidente', false)
						else
							ExecuteCommand('e keyfob')
							TriggerServerEvent('fazione:apripresidente', true)
						end
						waitMex = false
						Citizen.Wait(1500)
						waitMex = true
					end)	
				else
					ExecuteCommand('e no')
					ESX.ShowHelpNotification('Non hai le chiavi di questa serratura.')
					waitMex = false
					Citizen.Wait(1500)
					waitMex = true
				end		
				end, 'governo')		
			end		
		elseif GetDistanceBetweenCoords(coords, -1003.297, -477.964, 49.027, true) < 1.5 then -- USCITA
			if waitMex then ESX.ShowHelpNotification("~INPUT_PICKUP~ Serratura ~INPUT_VEH_HEADLIGHT~ Esci") end
			if IsControlJustReleased(0, 74) then 
				ESX.TriggerServerCallback('fazione:portaPresidente', function(lock)
					if lock then
						ExecuteCommand('e keyfob') DoScreenFadeOut(800) Citizen.Wait(800) SetEntityCoords(ped, -1011.029, -479.826, 38.971) Citizen.Wait(800) DoScreenFadeIn(800) Citizen.Wait(10) SetEntityHeading(ped, 120.0) ClearHelp(true) Citizen.Wait(1000) 
					else
						ExecuteCommand('e shrug')
						ESX.ShowHelpNotification('La porta sembra chiusa a chiave.')
					end
					waitMex = false
					Citizen.Wait(1500)
					waitMex = true
				end)	
			elseif IsControlJustReleased(0, 38) then 
				ESX.TriggerServerCallback('lavoro:getjob2', function(lavoro)
				if lavoro then
					ESX.TriggerServerCallback('fazione:portaPresidente', function(lock)
						if lock then
							ExecuteCommand('e keyfob')
							TriggerServerEvent('fazione:apripresidente', false)
						else
							ExecuteCommand('e keyfob')
							TriggerServerEvent('fazione:apripresidente', true)
						end
						waitMex = false
						Citizen.Wait(1500)
						waitMex = true
					end)	
				else
					ExecuteCommand('e no')
					ESX.ShowHelpNotification('Non hai le chiavi di questa serratura.')
					waitMex = false
					Citizen.Wait(1500)
					waitMex = true
				end		
				end, 'governo')		
			end
		
		-- DA PORTA A CORRIDOIO ILLEGALE
		elseif GetDistanceBetweenCoords(coords, 595.887, -457.458, 23.84, true) < 1.5 then -- salire
			DrawMarker(23, 595.887, -457.458, 23.84+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, 595.887, -457.458, 23.84, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Sali")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, 595.151, -457.07, 30.422)
				Citizen.Wait(500)
				SetEntityHeading(ped, 355.0)
				Citizen.Wait(2000)			
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
		elseif GetDistanceBetweenCoords(coords, 595.151, -457.07, 30.422, true) < 10.5 then -- scendere
			DrawMarker(23, 595.151, -457.07, 30.422+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, 595.151, -457.07, 30.422, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Scendi")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, 595.887, -457.458, 23.84)
				Citizen.Wait(500)
				SetEntityHeading(ped, 356.0)
				Citizen.Wait(2000)
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
			
		-- FUNIVIA
		elseif GetDistanceBetweenCoords(coords, -738.267, 5594.981, 40.655, true) < 10.5 then -- salire
			DrawMarker(23, -738.267, 5594.981, 40.655+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -738.267, 5594.981, 40.655, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Sali sul Chilliad 350~g~$")
			if IsControlJustReleased(0, 74) then
			
				ESX.TriggerServerCallback('soldi:check', function(soldi)
					if not soldi then
						ESX.ShowHelpNotification("Non hai abbastanza soldi (350~g~$~w~) per prendere la funivia.")
						return 
					end
					TriggerServerEvent('FaCrashare:Paga', 350)
					FreezeEntityPosition(ped, true)
					ExecuteCommand('e wait2')
					DoScreenFadeOut(800)
					Citizen.Wait(5000)
					FreezeEntityPosition(ped, false)
					Citizen.Wait(100)
					SetEntityCoords(ped, 442.715, 5571.896, 780.189)
					Citizen.Wait(2000)			
					DoScreenFadeIn(800)
					ClearHelp(true)
				end, 350)	
			
			end
			end
		elseif GetDistanceBetweenCoords(coords, 442.715, 5571.896, 780.189, true) < 1.5 then -- scendere
			DrawMarker(23, 442.715, 5571.896, 780.189+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, 442.715, 5571.896, 780.189, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Torna a Paleto")
			if IsControlJustReleased(0, 74) then				
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e wait2')
				DoScreenFadeOut(800)
				Citizen.Wait(5000)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, -738.267, 5594.981, 40.655)
				Citizen.Wait(2000)
				DoScreenFadeIn(800)
				ClearHelp(true)
				ExecuteCommand('e think5')
			end
			end
			
		-- Tetto Pacific
		elseif GetDistanceBetweenCoords(coords, 255.265, 229.065, 105.287, true) < 1.5 then -- salire
			DrawMarker(23, 255.265, 229.065, 105.28+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, 255.265, 229.065, 105.28, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Sali")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, 246.078, 216.183, 156.635)
				Citizen.Wait(500)
				SetEntityHeading(ped, 251.0)
				Citizen.Wait(2000)			
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
		elseif GetDistanceBetweenCoords(coords, 246.078, 216.183, 156.635, true) < 1.5 then -- scendere
			DrawMarker(23, 246.078, 216.183, 156.635+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, 246.078, 216.183, 156.635, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Scendi")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, 255.265, 229.065, 105.287)
				Citizen.Wait(500)
				SetEntityHeading(ped, 163.0)
				Citizen.Wait(2000)
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
	
		-- Campanello Pula Polizia
		elseif GetDistanceBetweenCoords(coords, 437.721, -979.439, 29.69, true) < 3.5 then
			DrawMarker(23, 437.721, -979.439, 29.69+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.2, 255,255,224, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, 437.721, -979.439, 29.69, true) < 1.5 then
				ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Premuto: ~y~Campanello")
			end
		
		-- Campanello Ospedale
		elseif GetDistanceBetweenCoords(coords, 314.229, -585.001, 42.261, true) < 3.5 then
			DrawMarker(23, 314.229, -585.001, 42.261+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.2, 255,255,224, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, 314.229, -585.001, 42.261, true) < 1.5 then
				ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Premuto: ~y~Campanello")
			end		
		
		-- Campanello Rimozione
		elseif GetDistanceBetweenCoords(coords, 492.96, -1306.146, 28.289, true) < 3.5 then
			DrawMarker(23, 492.96, -1306.146, 28.289+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.2, 255,255,224, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, 492.96, -1306.146, 28.289, true) < 1.5 then
				ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Premuto: ~y~Campanello")
			end		
		
		-- Campanello Cocessionario
		elseif GetDistanceBetweenCoords(coords, -54.022, -1097.174, 25.422, true) < 3.5 then
			DrawMarker(23, -54.022, -1097.174, 25.422+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.2, 255,255,224, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -54.022, -1097.174, 25.422, true) < 1.5 then
				ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Premuto: ~y~Campanello")
			end		
		
		-- Campanello Meccanici
		elseif GetDistanceBetweenCoords(coords, -200.516, -1309.505, 30.294, true) < 3.5 then
			DrawMarker(23, -200.516, -1309.505, 30.294+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.2, 255,255,224, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -200.516, -1309.505, 30.294, true) < 1.5 then
				ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Premuto: ~y~Campanello")
			end		
		
		-- POSIZIONE PER SALIRE SUL PONTE PARACADUTE
		elseif GetDistanceBetweenCoords(coords, -747.464, -2085.839, 11.735, true) < 10.5 then -- Salire
			DrawMarker(23, -747.464, -2085.839, 11.735+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -747.464, -2085.839, 11.735, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Paracadutismo")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, -668.456, -2166.217, 54.663)
				Citizen.Wait(500)
				SetEntityHeading(ped, 228.0)
				Citizen.Wait(2000)			
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
			
		elseif GetDistanceBetweenCoords(coords, -668.456, -2166.217, 54.663, true) < 10.5 then -- Scendere
			DrawMarker(23, -668.456, -2166.217, 54.663+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.1, 0.1, 0.1, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -668.456, -2166.217, 54.663, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Torna al Parcheggio")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, -747.464, -2085.839, 11.735)
				Citizen.Wait(500)
				SetEntityHeading(ped, 0.0)
				Citizen.Wait(2000)			
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
		
		-- DAI PARACADUTE
		elseif GetDistanceBetweenCoords(coords, -557.062, -2244.446, 123.003, true) < 10.5 then -- Scendere
			DrawMarker(23, -557.062, -2244.446, 123.003+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -557.062, -2244.446, 123.003, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Ottieni Paracadute")
				if IsControlJustReleased(0, 74) then
					local weaponHash = GetHashKey('gadget_parachute')
					RemoveWeaponFromPed(ped, weaponHash)
					Wait(1000)
					GiveWeaponToPed(ped, weaponHash, 1, false, false)
					Citizen.Wait(800)
				end
			end
		
		
		-- ASCENSORE FIB NON BRUCIATA
		elseif GetDistanceBetweenCoords(coords, 136.174, -761.835, 44.752, true) < 1.5 then -- Salire
			DrawMarker(23, 136.174, -761.835, 44.752, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, 136.174, -761.835, 44.752, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Ascensore")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, 136.127, -761.91, 241.152)
				Citizen.Wait(500)
				SetEntityHeading(ped, 150.0)
				Citizen.Wait(2000)			
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
		elseif GetDistanceBetweenCoords(coords, 136.127, -761.91, 241.152, true) < 1.5 then -- Scendere
			DrawMarker(23, 136.127, -761.91, 241.152, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, 136.127, -761.91, 241.152, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Ascensore")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, 136.174, -761.835, 44.752)
				Citizen.Wait(500)
				SetEntityHeading(ped, 0.0)
				Citizen.Wait(2000)
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
		
		-- ASCENSORE FIB BRUCIATA
		elseif GetDistanceBetweenCoords(coords, 138.33, -764.618, 241.152, true) < 1.5 then -- Salire
			DrawMarker(23, 138.33, -764.618, 241.152, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, 138.33, -764.618, 241.152, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Ascensore")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, 136.208, -761.552, 233.152)
				Citizen.Wait(500)
				SetEntityHeading(ped, 150.0)
				Citizen.Wait(2000)			
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
		elseif GetDistanceBetweenCoords(coords, 136.208, -761.552, 233.152, true) < 1.5 then -- Scendere
			DrawMarker(23, 136.208, -761.552, 233.152, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, 136.208, -761.552, 233.152, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Ascensore")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, 138.33, -764.618, 241.152)
				Citizen.Wait(500)
				SetEntityHeading(ped, 160.0)
				Citizen.Wait(2000)
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
		
		-- TETTO DI FIANCO ALLA FIB Tetto FIB
		elseif GetDistanceBetweenCoords(coords, 249.16, -694.195, 80.415, true) < 10.0 then -- Scendere
			DrawMarker(23, 249.16, -694.195, 80.415+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, 249.16, -694.195, 80.415, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Scendi dal Tetto")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				SetEntityAlpha(ped, 0)
				Citizen.Wait(3000)
				FreezeEntityPosition(ped, false)
				SetEntityAlpha(ped, 255)
				Citizen.Wait(100)
				SetEntityCoords(ped, 232.575, -714.699, 35.774)
				Citizen.Wait(500)
				SetEntityHeading(ped, 65.0)
				Citizen.Wait(2000)
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end

		elseif GetDistanceBetweenCoords(coords, 287.895, -641.96, 112.071, true) < 10.0 then -- Scendere
			DrawMarker(23, 287.895, -641.96, 112.071, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, 287.895, -641.96, 112.071, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Scendi dal Tetto")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				SetEntityAlpha(ped, 0)
				Citizen.Wait(3000)
				FreezeEntityPosition(ped, false)
				SetEntityAlpha(ped, 255)
				Citizen.Wait(100)
				SetEntityCoords(ped, 288.573, -665.112, 54.135)
				Citizen.Wait(500)
				SetEntityHeading(ped, 249.0)
				Citizen.Wait(2000)
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
		
		elseif GetDistanceBetweenCoords(coords, 278.272, -1109.376, 84.637, true) < 10.0 then -- Scendere
			DrawMarker(23, 278.272, -1109.376, 84.637, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, 278.272, -1109.376, 84.637, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Scendi dal Tetto")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				SetEntityAlpha(ped, 0)
				Citizen.Wait(3000)
				FreezeEntityPosition(ped, false)
				SetEntityAlpha(ped, 255)
				Citizen.Wait(100)
				SetEntityCoords(ped, 257.477, -1102.691, 45.912)
				Citizen.Wait(500)
				SetEntityHeading(ped, 179.0)
				Citizen.Wait(2000)
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
		
		elseif GetDistanceBetweenCoords(coords, 206.292, -580.853, 124.51, true) < 10.0 then -- Scendere
			DrawMarker(23, 206.292, -580.853, 124.51, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, 206.292, -580.853, 124.51, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Scendi dal Tetto")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				SetEntityAlpha(ped, 0)
				Citizen.Wait(3000)
				FreezeEntityPosition(ped, false)
				SetEntityAlpha(ped, 255)
				Citizen.Wait(100)
				SetEntityCoords(ped, 222.452, -595.485, 42.873)
				Citizen.Wait(500)
				SetEntityHeading(ped, 166.0)
				Citizen.Wait(2000)
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
			
		elseif GetDistanceBetweenCoords(coords,109.933, -867.752, 133.77, true) < 1.5 or GetDistanceBetweenCoords(coords,109.723, -847.824, 72.585, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Scendi dal Tetto")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				SetEntityAlpha(ped, 0)
				Citizen.Wait(3000)
				FreezeEntityPosition(ped, false)
				SetEntityAlpha(ped, 255)
				Citizen.Wait(100)
				SetEntityCoords(ped, 87.116, -834.874, 30.065)
				Citizen.Wait(500)
				SetEntityHeading(ped, 67.0)
				Citizen.Wait(2000)
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
		
		-- CHIESA CITTA
		elseif GetDistanceBetweenCoords(coords, -766.887, -23.366, 40.081, true) < 1.5 then -- ENTRARE
			DrawMarker(23, -766.887, -23.366, 40.081, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -766.887, -23.366, 40.081, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Chiesa")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, -785.761, -13.387, -17.786)
				Citizen.Wait(100)
				SetEntityHeading(ped, 200.0)
				Citizen.Wait(2000)			
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
		elseif GetDistanceBetweenCoords(coords, -785.761, -13.387, -15.786, true) < 1.5 then -- USCIRE
			DrawMarker(23, -785.761, -13.387, -17.786, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -785.761, -13.387, -15.786, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Uscita")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, -766.887, -23.366, 40.081)
				Citizen.Wait(100)
				SetEntityHeading(ped, 220.0)
				Citizen.Wait(2000)
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
		
		-- BIKER INCOGNITA
		elseif GetDistanceBetweenCoords(coords, -3179.288, 1093.35, 19.841, true) < 1.5 then -- ENTRARE
			DrawMarker(23, -3179.288, 1093.35, 19.841+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -3179.288, 1093.35, 19.841, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Entra")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, 1121.005, -3152.781, -38.063)
				Citizen.Wait(100)
				SetEntityHeading(ped, 356.926)
				Citizen.Wait(2000)			
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
		elseif GetDistanceBetweenCoords(coords, 1121.005, -3152.781, -38.063, true) < 1.5 then -- USCIRE
			DrawMarker(23, 1121.005, -3152.781, -38.063+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, 1121.005, -3152.781, -38.063, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Esci")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, -3179.288, 1093.35, 19.841)
				Citizen.Wait(100)
				SetEntityHeading(ped, 67.0)
				Citizen.Wait(2000)
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
			
		-- INTERIOR SOTTO IL PONTE
		elseif GetDistanceBetweenCoords(coords, -354.164, 4825.594, 143.292, true) < 1.5 then -- ENTRARE
			DrawMarker(23, -354.164, 4825.594, 143.292+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -354.164, 4825.594, 143.292, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Entra")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, 1088.663, -3187.51, -39.993)
				Citizen.Wait(100)
				SetEntityHeading(ped, 182.0)
				Citizen.Wait(2000)			
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
		elseif GetDistanceBetweenCoords(coords, 1088.663, -3187.51, -39.993, true) < 1.5 then -- USCIRE
			DrawMarker(23, 1088.663, -3187.51, -39.993+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, 1088.663, -3187.51, -39.993, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Esci")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, -354.164, 4825.594, 143.292)
				Citizen.Wait(100)
				SetEntityHeading(ped, 141.0)
				Citizen.Wait(2000)
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
			
		-- BIKER INCOGNITA 2
		elseif GetDistanceBetweenCoords(coords, -91.383, 6514.481, 31.1, true) < 1.5 then -- ENTRARE
			DrawMarker(23, -91.383, 6514.481, 31.1+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -91.383, 6514.481, 31.1, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Entra")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, 997.07, -3158.137, -39.907)
				Citizen.Wait(100)
				SetEntityHeading(ped, 270.0)
				Citizen.Wait(2000)			
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
		elseif GetDistanceBetweenCoords(coords, 997.07, -3158.137, -39.907, true) < 1.5 then -- USCIRE
			DrawMarker(23, 997.07, -3158.137, -39.907+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, 997.07, -3158.137, -39.907, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Esci")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, -91.383, 6514.481, 31.1)
				Citizen.Wait(100)
				SetEntityHeading(ped, 40.0)
				Citizen.Wait(2000)
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
		
		-- TETTO ELICOTTERO GARAGE
		elseif GetDistanceBetweenCoords(coords, -935.927, -378.823, 37.961, true) < 1.5 then -- salire
			DrawMarker(23, -935.927, -378.823, 37.961+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -935.927, -378.823, 37.961, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Vai al Tetto")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, -902.615, -369.649, 135.282)
				Citizen.Wait(100)
				SetEntityHeading(ped, 114.0)
				Citizen.Wait(2000)			
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
		elseif GetDistanceBetweenCoords(coords, -902.615, -369.649, 135.282, true) < 1.5 then -- scendere
			DrawMarker(23, -902.615, -369.649, 135.282+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -902.615, -369.649, 135.282, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Scendi dal Tetto")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, -935.927, -378.823, 37.961)
				Citizen.Wait(100)
				SetEntityHeading(ped, 110.0)
				Citizen.Wait(2000)
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
		
		-- SALA BISTURI PLASTICSURGERY
		elseif GetDistanceBetweenCoords(coords, 259.368, -1357.382, 29.552, true) < 1.5 then -- Salire
			DrawMarker(23, 259.368, -1357.382, 29.552, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, 259.368, -1357.382, 29.552, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Sala Operatoria")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, 251.568, -1366.621, 38.534)
				Citizen.Wait(500)
				SetEntityHeading(ped, 124.0)
				Citizen.Wait(3000)			
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
		elseif GetDistanceBetweenCoords(coords, 251.568, -1366.621, 38.534, true) < 1.5 then -- Scendere
			DrawMarker(23, 251.568, -1366.621, 38.534, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, 251.568, -1366.621, 38.534, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Esci")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, 259.368, -1357.382, 29.552)
				Citizen.Wait(500)
				SetEntityHeading(ped, 315.0)
				Citizen.Wait(3000)
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
			
		--[[ PALAZZI APPARTAMENTO ]]	
		
		-- Ascensore APPARTAMENTO PREMIUM PALAZZO 1 
		elseif GetDistanceBetweenCoords(coords, -43.528, -584.731, 37.161, true) < 1.5 then -- Salire
			DrawMarker(23, -43.528, -584.731, 37.161, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -43.528, -584.731, 37.161, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Ascensore")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, -18.466, -591.379, 89.115)
				Citizen.Wait(500)
				SetEntityHeading(ped, 337.0)
				Citizen.Wait(2000)			
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
		elseif GetDistanceBetweenCoords(coords, -18.466, -591.379, 89.115, true) < 1.5 then -- Scendere
			DrawMarker(23, -18.466, -591.379, 89.115, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -18.466, -591.379, 89.115, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Ascensore")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, -43.528, -584.731, 37.161)
				Citizen.Wait(500)
				SetEntityHeading(ped, 70.0)
				Citizen.Wait(2000)
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end

		-- Ascensore APPARTAMENTO PREMIUM PALAZZO 1.1 stesso Palazzo 2 Ascensori Vicini
		elseif GetDistanceBetweenCoords(coords, -44.473, -587.238, 37.161, true) < 1.5 then -- Salire
			DrawMarker(23, -44.473, -587.238, 37.161, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -44.473, -587.238, 37.161, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Ascensore")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, -31.377, -595.136, 79.031)
				Citizen.Wait(500)
				SetEntityHeading(ped, 246.0)
				Citizen.Wait(2000)			
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
		elseif GetDistanceBetweenCoords(coords, -31.377, -595.136, 79.031, true) < 1.5 then -- Scendere
			DrawMarker(23, -31.377, -595.136, 79.031, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -31.377, -595.136, 79.031, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Ascensore")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, -44.473, -587.238, 37.161)
				Citizen.Wait(500)
				SetEntityHeading(ped, 70.0)
				Citizen.Wait(2000)
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
				
		elseif GetDistanceBetweenCoords(coords, -458.597, -2274.559, 7.516, true) < 5.5 then -- INFO OGGETTI RUBATI
			DrawMarker(23, -458.597, -2274.559, 7.516+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -458.597, -2274.559, 7.516, true) < 1.5 then
				if InfoObjRubati == nil then 
					if not VariabileInfoRubati then 
						VariabileInfoRubati = true
						ESX.TriggerServerCallback('cavallo:totSelle', function(bin)
							if bin > 0 then
								ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Info Oggetti Rubati") 	
								
								if IsControlPressed(0, 74) then
									local rand = math.random(1,3)
									ESX.ShowNotification("A me non servono questi oggetti ma conosco dei punti dove puoi controllare.") 
									InfoObjRubati = vector3(venditaRubati[rand].x,venditaRubati[rand].y,venditaRubati[rand].z)
									ESX.ShowNotification("~b~1: ~w~/coo scene.abitudini.rp ") 
									ESX.ShowNotification("~b~2: ~w~/coo cespuglio.assalto.billy") 
									ESX.ShowNotification("~b~3: ~w~/coo separati.frate.affreschi") 
									Citizen.Wait(10000)
								end
								
							else
								ESX.ShowHelpNotification("Non sembra esserci nulla che ti interessa.") 
							end
							Citizen.Wait(3000)
						end, 'rubati')
					end
				else
					ESX.ShowHelpNotification("Informazioni ricevute:~n~~b~Premi Pausa -> Informazioni / Notifiche") 
				end
			else
				if VariabileInfoRubati then VariabileInfoRubati = false end
			end
			
		elseif InfoObjRubati ~= nil and GetDistanceBetweenCoords(coords, InfoObjRubati, true) < 5.5 then -- INFO OGGETTI RUBATI
			DrawMarker(23, InfoObjRubati, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, InfoObjRubati, true) < 1.5 then
				if InfoObjRubati ~= nil then 
					ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Vendi Oggetti Rubati") 				
					if IsControlJustReleased(0, 74) then
						InfoObjRubati = nil
						ESX.TriggerServerCallback('cavallo:totSelle', function(bin)
							if bin > 0 then
								ExecuteCommand('e box')
								FreezeEntityPosition(ped, true)
								Citizen.Wait(5000)
								FreezeEntityPosition(ped, false)
								TriggerServerEvent('cavallo:toglisella', 'rubati', bin)
								TriggerServerEvent('deruba:DammiSoldi', bin*500)
								ExecuteCommand('e boi')
								ESX.ShowHelpNotification("Oggetti venduti con successo.") 	
								Citizen.Wait(5000)								
							else
								ESX.ShowNotification("Non hai un ~g~oggetti rubati ~w~in inventario da poter vendere.")
								Citizen.Wait(3000)
							end
						end, 'rubati')
						
					end
				end
			end
		
		-- VENDITA ARTEFATTI
		elseif GetDistanceBetweenCoords(coords, -1571.833, -469.108, 35.248, true) < 10.5 then 
			DrawMarker(23, -1571.833, -469.108, 35.24, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -1571.833, -469.108, 35.24, true) < 1.5 then
				ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Vendi Artefatto") 				
				if IsControlJustReleased(0, 74) then
					InfoObjRubati = nil
					ESX.TriggerServerCallback('cavallo:totSelle', function(bin)
						if bin > 0 then
							ExecuteCommand('e valigia2')
							FreezeEntityPosition(ped, true)
							Citizen.Wait(5000)
							FreezeEntityPosition(ped, false)
							TriggerServerEvent('cavallo:toglisella', 'artefatto', bin)
							TriggerServerEvent('deruba:DammiSoldi', bin*8500)
							ExecuteCommand('e boi')
							ESX.ShowHelpNotification("Oggetti venduti con successo.") 	
							Citizen.Wait(5000)								
						else
							ESX.ShowNotification("Non hai un ~g~artefatto ~w~in inventario da poter vendere.")
							Citizen.Wait(3000)
						end
					end, 'artefatto')			
				end
			end
			
		-- Ascensore APPARTAMENTO PREMIUM PALAZZO 2 
		elseif GetDistanceBetweenCoords(coords, -1456.546, -514.239, 30.582, true) < 1.5 then -- Salire
			DrawMarker(23, -1456.546, -514.239, 30.582, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -1456.546, -514.239, 30.582, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Ascensore")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, -1449.961, -525.879, 55.929)
				Citizen.Wait(500)
				SetEntityHeading(ped, 117.0)
				Citizen.Wait(2000)			
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
		elseif GetDistanceBetweenCoords(coords, -1449.961, -525.879, 55.929, true) < 1.5 then -- Scendere
			DrawMarker(23, -1449.961, -525.879, 55.929, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -1449.961, -525.879, 55.929, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Ascensore")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, -1456.546, -514.239, 30.582)
				Citizen.Wait(500)
				SetEntityHeading(ped, 207.0)
				Citizen.Wait(2000)
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
			
		-- Ascensore APPARTAMENTO PREMIUM PALAZZO 2.1
		elseif GetDistanceBetweenCoords(coords, -1459.661, -505.933, 31.076, true) < 1.5 then -- Salire
			DrawMarker(23, -1459.661, -505.933, 31.076, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -1459.661, -505.933, 31.076, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Ascensore")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, -1452.227, -540.515, 73.044)
				Citizen.Wait(100)
				SetEntityHeading(ped, 30.0)
				Citizen.Wait(2000)			
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
		elseif GetDistanceBetweenCoords(coords, -1452.227, -540.515, 73.044, true) < 1.5 then -- Scendere
			DrawMarker(23, -1452.227, -540.515, 73.044, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -1452.227, -540.515, 73.044, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Ascensore")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, -1459.661, -505.933, 31.076)
				Citizen.Wait(500)
				SetEntityHeading(ped, 35.0)
				Citizen.Wait(2000)
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
		
		-- Ascensore APPARTAMENTO PREMIUM PALAZZO 3
		elseif GetDistanceBetweenCoords(coords, -841.62, -334.568, 37.68, true) < 1.5 then -- Salire
			DrawMarker(23, -841.62, -334.568, 37.68, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -841.62, -334.568, 37.68, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Ascensore")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, -912.542, -365.048, 113.275)
				Citizen.Wait(100)
				SetEntityHeading(ped, 109.0)
				Citizen.Wait(2000)			
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
		elseif GetDistanceBetweenCoords(coords, -912.542, -365.048, 113.275, true) < 1.5 then -- Scendere
			DrawMarker(23, -912.542, -365.048, 113.275, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -912.542, -365.048, 113.275, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Ascensore")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, -841.62, -334.568, 37.68)
				Citizen.Wait(500)
				SetEntityHeading(ped, 288.0)
				Citizen.Wait(2000)
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end

		-- Ascensore APPARTAMENTO PREMIUM PALAZZO 4
		elseif GetDistanceBetweenCoords(coords, -621.033, 46.583, 42.591, true) < 1.5 then -- Salire
			DrawMarker(23, -621.033, 46.583, 42.591, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -621.033, 46.583, 42.591, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Ascensore")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, -785.095, 323.638, 210.997)
				Citizen.Wait(100)
				SetEntityHeading(ped, 260.0)
				Citizen.Wait(2000)			
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
		elseif GetDistanceBetweenCoords(coords, -785.095, 323.638, 210.997, true) < 1.5 then -- Scendere
			DrawMarker(23, -785.095, 323.638, 210.997, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -785.095, 323.638, 210.997, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Ascensore")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, -621.033, 46.583, 42.591)
				Citizen.Wait(100)
				SetEntityHeading(ped, 173.0)
				Citizen.Wait(2000)
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
			
		-- Ascensore APPARTAMENTO PREMIUM PALAZZO 4.1
		elseif GetDistanceBetweenCoords(coords, -614.629, 46.677, 42.591, true) < 1.5 then -- Salire
			DrawMarker(23, -614.629, 46.677, 42.591, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -614.629, 46.677, 42.591, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Ascensore")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, -602.853, 58.917, 97.2)
				Citizen.Wait(100)
				SetEntityHeading(ped, 88.0)
				Citizen.Wait(2000)			
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
		elseif GetDistanceBetweenCoords(coords, -602.853, 58.917, 97.2, true) < 1.5 then -- Scendere
			DrawMarker(23, -602.853, 58.917, 97.2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -602.853, 58.917, 97.2, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Ascensore")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, -614.629, 46.677, 42.591)
				Citizen.Wait(100)
				SetEntityHeading(ped, 177.0)
				Citizen.Wait(2000)
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
			
		-- Ascensore APPARTAMENTO PREMIUM PALAZZO ECLIPSE 1
		elseif GetDistanceBetweenCoords(coords, -770.588, 319.662, 84.663, true) < 1.5 then -- Salire
			DrawMarker(23, -770.588, 319.662, 84.663, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -770.588, 319.662, 84.663, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Ascensore")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, -773.763, 342.035, 195.686)
				Citizen.Wait(100)
				SetEntityHeading(ped, 92.0)
				Citizen.Wait(2000)			
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
		elseif GetDistanceBetweenCoords(coords, -773.763, 342.035, 195.686, true) < 1.5 then -- Scendere
			DrawMarker(23, -773.763, 342.035, 195.686, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -773.763, 342.035, 195.686, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Ascensore")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, -770.588, 319.662, 84.663)
				Citizen.Wait(500)
				SetEntityHeading(ped, 357.0)
				Citizen.Wait(2000)
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
			
		-- Ascensore APPARTAMENTO PREMIUM PALAZZO ECLIPSE 2
		elseif GetDistanceBetweenCoords(coords, -773.969, 317.459, 84.663, true) < 1.5 then -- Salire
			DrawMarker(23, -773.969, 317.459, 84.663, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -773.969, 317.459, 84.663, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Ascensore")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, -787.324, 315.746, 186.913)
				Citizen.Wait(100)
				SetEntityHeading(ped, 92.0)
				Citizen.Wait(2000)			
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
		elseif GetDistanceBetweenCoords(coords, -787.324, 315.746, 186.913, true) < 1.5 then -- Scendere
			DrawMarker(23, -787.324, 315.746, 186.913, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -787.324, 315.746, 186.913, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Ascensore")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, -773.969, 317.459, 84.663)
				Citizen.Wait(500)
				SetEntityHeading(ped, 265.0)
				Citizen.Wait(2000)
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
			
		-- Ascensore APPARTAMENTO PREMIUM PALAZZO ECLIPSE 3
		elseif GetDistanceBetweenCoords(coords, -777.295, 319.708, 84.663, true) < 1.5 then -- Salire
			DrawMarker(23, -777.295, 319.708, 84.663, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -777.295, 319.708, 84.663, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Ascensore")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, -787.412, 315.688, 216.638)
				Citizen.Wait(100)
				SetEntityHeading(ped, 270.0)
				Citizen.Wait(2000)			
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
		elseif GetDistanceBetweenCoords(coords, -787.412, 315.688, 216.638, true) < 1.5 then -- Scendere
			DrawMarker(23, -787.412, 315.688, 216.638, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 135,206,235, 150, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -787.412, 315.688, 216.638, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Ascensore")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				Citizen.Wait(100)
				SetEntityCoords(ped, -777.295, 319.708, 84.663)
				Citizen.Wait(500)
				SetEntityHeading(ped, 265.0)
				Citizen.Wait(2000)
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			end
			
		--[[  FINE PALAZZI APPARTAMENTO ]]
		
		-- Ascensore Municipio da Sotto TETTO
		elseif GetDistanceBetweenCoords(coords, -80.444, -832.671, 242.386, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Ascensore: ~h~Tetto")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				SetEntityCoords(ped,-259.942, -959.805, 129.618)
				SetEntityHeading(ped, 248.465)
				Citizen.Wait(2000)
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
		elseif GetDistanceBetweenCoords(coords, -260.56, -959.488, 129.618, true) < 1.5 then
			ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Ascensore: ~h~Municipio")
			if IsControlJustReleased(0, 74) then
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e keyfob')
				DoScreenFadeOut(800)
				Citizen.Wait(800)
				FreezeEntityPosition(ped, false)
				SetEntityCoords(ped, -79.883, -832.899, 242.386)
				Citizen.Wait(500)
				SetEntityHeading(ped, 257.802)
				Citizen.Wait(2000)
				DoScreenFadeIn(800)
				ClearHelp(true)
			end
			
		-- LIBRERIA -----	
		-- MECCANICO SKILL
		--[[
		elseif GetDistanceBetweenCoords(coords, 247.021, -1602.316, 30.536, true) < 1.5 then
				
			if not PossoStudiare then 
				ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Libreria: ~h~Meccanica") 
			else
				ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Apprendi (Costo: " .. countRank .. " ~h~Exp~h~) ")
			end 
			
			if IsControlJustReleased(0, 74) and not PossoStudiare then
				SetCurrentPedWeapon(ped, -1569615261, true) -- Unarmed
				FreezeEntityPosition(ped, true)
				ExecuteCommand('e book')
				ESX.ShowHelpNotification("Stai guardando un libro di meccanica.")			
				Citizen.Wait(5000)
				ESX.ShowHelpNotification("Vuoi studiare ~b~meccanica~w~?")
				Citizen.Wait(3000)		
				PossoStudiare = true				
				FreezeEntityPosition(ped, false)
				local xPlayer = ESX.GetPlayerData()
				playerXP = xPlayer.xp
				playerRank = xPlayer.rank
				countRank = 300 * playerRank
			end			
			
			if IsControlJustReleased(0, 74) and PossoStudiare then
				TriggerEvent('esx_status:getStatus', 'stress', function(status)
					stressVal = status.val
				end)
				TriggerEvent('esx_status:getStatus', 'lvabilita', function(status)
					LV_abl = status.val
				end)
				--print("Stress: " .. stressVal)
				
				if LV_abl > 4 then 
					ESX.ShowNotification("Hai il livello massimo questa abilità, non hai bisogno di studiare altro.")
				else
				
					if playerXP < countRank then 
						ESX.ShowNotification("Non hai abbastanza punti ~h~Exp ~h~per apprendere un nuovo livello in questa abilità.")
						ExecuteCommand('e shrug2')
						PossoStudiare = false
						Citizen.Wait(5000)
					else
						if stressVal > 50 and PossoStudiare then 
							ESX.ShowNotification("Sembri troppo ~r~stressato ~w~per apprendere qualcosa in libreria.")
							ExecuteCommand('e facepalm')
							PossoStudiare = false
						else
							FreezeEntityPosition(ped, true)
							ExecuteCommand('e book')
							ESX.ShowHelpNotification("Stai studiando ~g~meccanica~w~, attendere.")			
							Citizen.Wait(10000)
							PossoStudiare = false
							FreezeEntityPosition(ped, false)
							ESX.ShowHelpNotification("Hai appreso nuove abilità ~g~meccanica~w~.")
							ESX.ShowNotification("La tua lista ~g~/abilita ~w~è stata aggiornata.")
							ExecuteCommand('e notepad')
							TriggerServerEvent('abl:add', 1, LV_abl+1) -- ID abilita, Livello Abilita
							Citizen.Wait(7000)
							ExecuteCommand('e c')
						end
					end
				end
				
			end
		]]
			
		else
			Citizen.Wait(1000)
		end
else
	Citizen.Wait(3000)
end
	end
	end -- end while true
end)

-- DOCCIA BAGNO PUBBLICO
local InDocciaCheck = false
Citizen.CreateThread(function()
--loop6 = function()
	while true do Citizen.Wait(10)
	if ped ~= nil then 
		local coords = GetEntityCoords(ped)
		
		for k, v in pairs(doccia) do							
			if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 10.0 then
				InDocciaCheck = true
				DrawMarker(23, v.x, v.y, v.z-1.0+0.01, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 0, 0, 100, false, true, 2, false, false, false, false)
				if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.5 then
					--DrawText3D(v.x, v.y, v.z+0.9, k, 0.80)
					ESX.ShowHelpNotification("~INPUT_PICKUP~ Pulisciti 1~g~$")
					if IsControlPressed(0, 38) then
						TriggerServerEvent('doccia:Paga')						
						ClearHelp(true)
						Citizen.Wait(30000)
					end
				end
			end		
		end
		
		if not InDocciaCheck then 
			Citizen.Wait(1000)
		end
		
		InDocciaCheck = false
		
	end
	end
end)

-- ACQUISTO EXP 
--[[
Citizen.CreateThread(function()
	while true do
	Citizen.Wait(5)
	if ped ~= nil then 
		local coords = GetEntityCoords(ped)
									
		if GetDistanceBetweenCoords(coords, -911.728, -2020.81, 8.402, true) < 5.0 then
			DrawMarker(1, -911.728, -2020.81, 8.402, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -911.728, -2020.81, 8.402, true) < 1.5 and not aspetta then
				--DrawText3D(v.x, v.y, v.z+0.9, k, 0.80)
				ESX.ShowHelpNotification("~INPUT_PICKUP~ +1000~y~Exp ~w~(10.000~g~$~w~)")
				if IsControlJustPressed(0, 38) then
					ESX.TriggerServerCallback('soldi:check', function(soldi)
						if soldi then
							aspetta = true
							TriggerServerEvent('soldi:paga', 10000)	
							ESX.ShowNotification("~y~EXP ~w~Acquistata con successo.")
							TriggerServerEvent('exp:Dammi', 1000)
							ClearHelp(true)
							Citizen.Wait(9000)
							aspetta = false
						else	
							aspetta = true
							ESX.ShowHelpNotification("Non hai abbastanza soldi.")
							Citizen.Wait(9000)
							aspetta = false
						end
					end, 10000)
				end
			end
		else
			Citizen.Wait(5000)
		end		
	end
	end
end)
]]

-- ACQUISTO Giornale
Citizen.CreateThread(function()
	while true do
	Citizen.Wait(5)
	if ped ~= nil then 
		local coords = GetEntityCoords(ped)
									
		if GetDistanceBetweenCoords(coords, -269.121, -956.164, 30.223, true) < 15.0 then
			DrawMarker(23, -269.121, -956.164, 30.223, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -269.121, -956.164, 30.223, true) < 1.5 and not aspetta then
				--DrawText3D(v.x, v.y, v.z+0.9, k, 0.80)
				ESX.ShowHelpNotification("~INPUT_PICKUP~ Acquista Giornale 100~g~$")
				if IsControlJustPressed(0, 38) then
					ESX.TriggerServerCallback('soldi:check', function(soldi)
						if soldi then
							ESX.TriggerServerCallback('cavallo:totSelle', function(carb)
								if carb > 9 then	
									ESX.ShowNotification("Non hai spazio per un'altro giornale in inventario.")
								else
									aspetta = true
									ExecuteCommand('e mechanic4')
									TriggerServerEvent('soldi:paga', 100)	
									TriggerServerEvent('FaCrashare:giveitem', 'giornale', 1)			
									ClearHelp(true)
									Citizen.Wait(3000)
									ESX.ShowNotification("Usa il ~b~giornale ~w~dal tuo inventario per leggerlo, oppure da ~b~F3~w~.")
									ExecuteCommand('e giornale')
									aspetta = false
								end
							end, 'giornale')					
						else	
							aspetta = true
							ESX.ShowHelpNotification("Non hai abbastanza soldi per acquistare un giornale.")
							Citizen.Wait(9000)
							aspetta = false
						end
					end, 100)
				end
			end
		else
			Citizen.Wait(5000)
		end		
	end	
	end
end)

RegisterNetEvent('bagno:UsaBagno')
AddEventHandler('bagno:UsaBagno', function()
ped = PlayerPedId()
FreezeEntityPosition(ped, true)
ESX.ShowHelpNotification("Ti stai pulendo, attendi. (-1~g~$~w~)") 
ExecuteCommand('e adjust')
Citizen.Wait(3000)
ExecuteCommand('e puddle')
Citizen.Wait(9000)
ClearPedBloodDamage(ped)
ClearPedEnvDirt(ped)
Citizen.Wait(6000)
ExecuteCommand('e c')
Citizen.Wait(500)
ExecuteCommand('e adjusttie')
FreezeEntityPosition(ped, false)
end)

--[[
function OpenPharmacyMenu()
	ESX.TriggerServerCallback('cavallo:totSelle', function(ricette) -- Controllo se ha una ricetta Medica in inventario prima dell'acquisto.
	if ricette > 0 then	

		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'Pharmacy_markets',
			 {
				title    = "Farmacia",
				elements = {
					{label = ('Medikit - 4500<span style="color:green;">$</span>'), item = 'medikit', price = 4500, amount = 1},
					{label = ('Bandage - 2500<span style="color:green;">$</span>'), item = 'bandage', price = 2500, amount = 1},
					{label = ('Xanax -  150<span style="color:green;">$</span>'), item = 'xanax', price = 150, amount = 1},
				}
			},
			function(data, menu)
				local item = data.current.item
				local price = data.current.price
				local amount = data.current.amount
				TriggerServerEvent('esx:Farmacia', item, price, amount)
			end,
		function(data, menu)
			menu.close()
		end)
	else
		ESX.ShowNotification("Non hai una ~r~ricetta medica ~w~per ottenere medicinali, prova a contattare un medico.") 
	end
	end, 'ricettadottore') -- Fine controllo Ricetta Medico
end
]]

--[[
function DrawText3D(x, y, z, text, scale)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
 
    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 215)
 
    AddTextComponentString(text)
    DrawText(_x, _y)
 
    local factor = (string.len(text)) / 230
    DrawRect(_x, _y + 0.0250, 0.095 + factor, 0.06, 41, 11, 41, 100)
end
]]

local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end
		enum.destructor = nil
		enum.handle = nil
	end
}

function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end
	
		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)
	
		local next = true
		repeat
			coroutine.yield(id)
			next, id = moveFunc(iter)
		until not next
	
		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumeratePeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function GetNearbyPeds(X, Y, Z, Radius)
	local NearbyPeds = {}
	for Ped in EnumeratePeds() do
		if DoesEntityExist(Ped) then
			local PedPosition = GetEntityCoords(Ped, false)
			if Vdist(X, Y, Z, PedPosition.x, PedPosition.y, PedPosition.z) <= Radius then
				table.insert(NearbyPeds, Ped)
			end
		end
	end
	return NearbyPeds
end

local messaggioToko = false

local posPiani = {
{x=-1001.496, y=-785.021, z=15.374}, -- Giu
{x=-1001.157, y=-752.115, z=75.537}, -- Tetto
{x=-1005.672, y=-756.892, z=58.059}, -- p6
{x=-1005.672, y=-756.892, z=54.324}, -- p5
{x=-1005.672, y=-756.892, z=50.605}, -- p4
{x=-1005.672, y=-756.892, z=46.822}, -- p3
{x=-1005.672, y=-756.892, z=42.964}, -- p2
{x=-1005.571, y=-756.905, z=38.911}, -- p1
-- Altre entrate
{x=-1038.724, y=-756.538, z=18.839},
{x=-1011.697, y=-734.154, z=20.53},
{x=-998.278, y=-722.328, z=20.53},
{x=-992.07, y=-718.855, z=20.641},
{x=-991.474, y=-748.419, z=19.934},
}

-- MENU DON 4 PIANI
--[[
local menuDON = false
Citizen.CreateThread(function()
--loop6 = function()
	while true do Citizen.Wait(5)
		if ped ~= nil then 
		local coords = GetEntityCoords(ped)
			
		for k, v in pairs(posPiani) do							
			if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 5.0 and not IsPedInAnyVehicle(ped,true) then
				menuDON = true
				DrawMarker(23, v.x, v.y, v.z+0.03, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
				if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.5 then
					--DrawText3D(v.x, v.y, v.z+0.9, k, 0.80)
					ESX.ShowHelpNotification("~INPUT_PICKUP~ Menu Piani Motel")
				end
			end		
		end
		
		if not menuDON then 
			Citizen.Wait(3000)
		end	
		menuDON = false
	end
	end
end)

-- MENU DON HOTEL PER ANDARE AI PIANI
function OpenMenuDon()
	ESX.UI.Menu.CloseAll()		
	local elements = {}
	
	table.insert(elements, {label = 'Piano Terra',		value = 'pterra'})
	table.insert(elements, {label = 'Piano 1',		value = 'p1'})
	table.insert(elements, {label = 'Piano 2',		value = 'p2'})
	table.insert(elements, {label = 'Piano 3',		value = 'p3'})
	table.insert(elements, {label = 'Piano 4',		value = 'p4'})	
	table.insert(elements, {label = 'Piano 5',		value = 'p5'})	
	table.insert(elements, {label = 'Piano 6',		value = 'p6'})	
	table.insert(elements, {label = 'Tetto',		value = 'tetto'})
	
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'menu_perso',
		{
			title    = 'Vai ad un Piano',
			align    = 'top-left',
			elements = elements
		},
		function(data, menu)	
	
	if data.current.value == 'pterra' then VaiAlPiano(-1001.496, -785.021, 15.374) end	
	if data.current.value == 'p1' then VaiAlPiano(-1005.571, -756.905, 38.911, 260.321) end	
	if data.current.value == 'p2' then VaiAlPiano(-1005.672, -756.892, 42.964, 260.847) end
	if data.current.value == 'p3' then VaiAlPiano(-1005.672, -756.892, 46.822, 260.847) end
	if data.current.value == 'p4' then VaiAlPiano(-1005.672, -756.892, 50.605, 260.847) end
	if data.current.value == 'p5' then VaiAlPiano(-1005.672, -756.892, 54.324, 260.847) end
	if data.current.value == 'p6' then VaiAlPiano(-1005.672, -756.892, 58.059, 260.847) end
	if data.current.value == 'tetto' then VaiAlPiano(-1001.157, -752.115, 75.537, 267.0) end
	
							
		end,
		function(data, menu)
			menu.close()
			ExecuteCommand('e c')
		end
	)	
end

RegisterKey('keyboard', 'E', function()
if ( IsPauseMenuActive() ) then return end
if ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'menu_perso') then ESX.UI.Menu.CloseAll() ExecuteCommand('e c') return end
ped = PlayerPedId()
local coords = GetEntityCoords(ped)	
for k, v in pairs(posPiani) do							
	if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.5 and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'menu_perso') then
		ExecuteCommand('e think4')
		ClearHelp(true)		
		OpenMenuDon()
	end	
end
end)
]]

function VaiAlPiano(x,y,z,h)
ped = PlayerPedId()
-- print(x .. ' ' .. y .. ' ' .. z .. ' ' .. h)
ESX.UI.Menu.CloseAll()	
FreezeEntityPosition(ped, true)
ExecuteCommand('e keyfob')
DoScreenFadeOut(800)
Citizen.Wait(800)
FreezeEntityPosition(ped, false)
Citizen.Wait(100)
SetEntityCoords(ped, x,y,z)
Citizen.Wait(100)
SetEntityHeading(ped, h)
Citizen.Wait(2000)
DoScreenFadeIn(800)
ClearHelp(true)
if not messaggioToko and GetInteriorFromEntity(ped) ~= 0 then messaggioToko = true ESX.ShowNotification('Sei in un hotel a più piani, ti consigliamo di abbassare il raggio di tokovoip.') end 
end

-- MOTEL 4 PIANI - 4 STANZE
local posPianiHotel = {
{x=183.255, y=-1062.682, z=73.386}, -- Tetto
{x=171.896, y=-1059.093, z=66.423},
{x=171.896, y=-1059.093, z=59.973},
{x=171.896, y=-1059.093, z=53.888},
{x=171.896, y=-1059.093, z=47.407},
{x=156.43, y=-1065.784, z=29.054},
{x=185.444, y=-1078.291, z=28.275},
}

local menuDON2 = false
Citizen.CreateThread(function()
--loop6 = function()
	while true do Citizen.Wait(5)
	if ped ~= nil then 
		local coords = GetEntityCoords(ped)
			
		for k, v in pairs(posPianiHotel) do							
			if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 5.0 and not IsPedInAnyVehicle(ped,true) then
				menuDON2 = true
				DrawMarker(23, v.x, v.y, v.z+0.03, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
				if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.5 then
					--DrawText3D(v.x, v.y, v.z+0.9, k, 0.80)
					ESX.ShowHelpNotification("~INPUT_PICKUP~ Menu Piani Motel")
				end
			end		
		end
		
		if not menuDON2 then 
			Citizen.Wait(1000)
		end	
		menuDON2 = false
	end
	end
end)

-- MENU HOTEL PER ANDARE AI PIANI - 4
function OpenMenuHotel()
	ESX.UI.Menu.CloseAll()		
	local elements = {}
	
	table.insert(elements, {label = 'Piano Terra',		value = 'pterra'})
	table.insert(elements, {label = 'Piano 1',		value = 'p1'})
	table.insert(elements, {label = 'Piano 2',		value = 'p2'})
	table.insert(elements, {label = 'Piano 3',		value = 'p3'})
	table.insert(elements, {label = 'Piano 4',		value = 'p4'})	
	table.insert(elements, {label = 'Tetto',		value = 'tetto'})
	
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'menu_perso2',
		{
			title    = 'Vai ad un Piano',
			align    = 'top-left',
			elements = elements
		},
		function(data, menu)	
	
	if data.current.value == 'pterra' then VaiAlPiano(156.43, -1065.784, 28.054, 150.0) end	
	if data.current.value == 'p1' then VaiAlPiano(171.896, -1059.093, 47.407, 335.444) end	
	if data.current.value == 'p2' then VaiAlPiano(171.896, -1059.093, 53.888, 335.444) end
	if data.current.value == 'p3' then VaiAlPiano(171.896, -1059.093, 59.973, 335.444) end
	if data.current.value == 'p4' then VaiAlPiano(171.896, -1059.093, 66.423, 335.444) end
	if data.current.value == 'tetto' then VaiAlPiano(183.255, -1062.682, 73.386, 70.0) end
							
		end,
		function(data, menu)
			menu.close()
			ExecuteCommand('e c')
		end
	)	
end

RegisterKey('keyboard', 'E', function()
if ( IsPauseMenuActive() ) then return end
if ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'menu_perso2') then ESX.UI.Menu.CloseAll() ExecuteCommand('e c') return end
ped = PlayerPedId()
local coords = GetEntityCoords(ped)	
for k, v in pairs(posPianiHotel) do							
	if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.5 and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'menu_perso2') then
		ExecuteCommand('e think3')
		ClearHelp(true)		
		OpenMenuHotel()
	end	
end
end)

local plateModel = "prop_fib_badge"
local plateModel2 = "prop_fib_badge"
local animDict = "missfbi_s4mop"
local animName = "swipe_card"
local plate_net = nil

RegisterNetEvent('polizia:distintivo')
AddEventHandler('polizia:distintivo', function()
    RequestModel(GetHashKey(plateModel))
    while not HasModelLoaded(GetHashKey(plateModel)) do
        Citizen.Wait(100)
    end
	ClearPedSecondaryTask(PlayerPedId())
	RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(100)
    end
    local playerPed = PlayerPedId()
    local plyCoords = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 0.0, -5.0)
    local platespawned = CreateObject(GetHashKey(plateModel), plyCoords.x, plyCoords.y, plyCoords.z, 0, 0, 0)
    local netid = ObjToNet(platespawned)
    SetNetworkIdExistsOnAllMachines(netid, true)
    SetNetworkIdCanMigrate(netid, false)
    TaskPlayAnim(playerPed, 1.0, -1, -1, 50, 0, 0, 0, 0)
    TaskPlayAnim(playerPed, animDict, animName, 1.0, 1.0, -1, 50, 0, 0, 0, 0)
    Citizen.Wait(800)
    AttachEntityToEntity(platespawned, playerPed, GetPedBoneIndex(playerPed, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
    plate_net = netid
    Citizen.Wait(3000)
    ClearPedSecondaryTask(playerPed)
    DetachEntity(NetToObj(plate_net), 1, 1)
    DeleteEntity(NetToObj(plate_net))
	DeleteEntity(platespawned)
    plate_net = nil
end)

RegisterNetEvent('polizia:animdoc')
AddEventHandler('polizia:animdoc', function()
    ExecuteCommand('e doc3')
	Citizen.Wait(4500)
	ExecuteCommand('e c')
end)

--[[]]

function GetDistanceBetween(Coords)
	return Vdist(GetEntityCoords(PlayerPedId(), false), Coords.x, Coords.y, Coords.z) + 0.01
end

local anchored = false
local boat = nil

RegisterCommand('ancora', function()
	ped = PlayerPedId()
	if IsPedInAnyBoat(ped) and boat == nil then local V = GetVehiclePedIsIn(ped, false) boat = V ESX.ShowHelpNotification("Barca selezionata, ora puoi spegnere il motore e scendere per usare ~b~/ancora~w~.") return end
	if IsPedInAnyBoat(ped, true) and boat ~= nil then boat = nil ESX.ShowHelpNotification("Hai deselezionato questa barca dalla funziona ~b~/ancora~w~.") return end	
	if not IsPedInAnyBoat(ped, true) and boat == nil then ESX.ShowHelpNotification("Non sei ancora salito su una barca per selezionarla con ~b~/ancora~b~.") return end 
	
	if IsVehicleEngineOn(boat) and anchored then
		anchored = false
		SetBoatAnchor(boat, false)
		SetBoatFrozenWhenAnchored(boat, false)
	end
	
	local pos = GetEntityCoords(boat)
	if GetDistanceBetween(pos) > 10.0 then ESX.ShowHelpNotification('Sei troppo distante dalla barca che hai selezionato.') return end
	
	if IsVehicleEngineOn(boat) then
		ESX.ShowHelpNotification('Spegni il motore della barca per ancorarla correttamente.')
		anchored = false
		SetBoatAnchor(boat, true)
		return 
	end
		
	if not anchored then
		SetBoatAnchor(boat, true)
		SetBoatFrozenWhenAnchored(boat, true)
		ESX.ShowHelpNotification("Barca ~g~ancorata ~w~con successo.")
	else
		SetBoatAnchor(boat, false)
		SetBoatFrozenWhenAnchored(boat, false)
		ESX.ShowHelpNotification("Ancora ~y~tolta ~w~dalla barca con successo.")
	end
	anchored = not anchored		
end)

RegisterCommand('generaLegno', function()
	ped = PlayerPedId()
	if IsEntityPlayingAnim(ped, "anim@heists@box_carry@", "idle", 3) then return end
	local coords = GetEntityCoords(PlayerPedId())
	if GetDistanceBetweenCoords(coords, -579.169, 5355.243, 69.214, true) > 1.5 then ESX.ShowNotification("Non sei nel posto giusto per questa operazione.") return end
		ESX.TriggerServerCallback('cavallo:totSelle', function(carb)
			if carb < 100 then	
				ESX.ShowNotification("Hai bisogno di x100 ~y~legno grande ~w~per un carico da inserire in un veicolo.")
				ExecuteCommand('e shrug')
				Citizen.Wait(3000)
				InGenera = false
				return 
			end		
			TriggerServerEvent('esx_importexport:DammiCarico', 'maderag', 100)
			TriggerServerEvent('cavallo:toglisella', 'maderag', 100)
			ESX.ShowNotification("Hai ricevuto un carico di ~y~legno grande~w~.")
			Citizen.Wait(3000)
			InGenera = false
		end, 'maderag')
end)

local OpenInput = function(label, type, size)
	AddTextEntry(type, label)
	DisplayOnscreenKeyboard(1, type, "", "", "", "", "", size)
	while UpdateOnscreenKeyboard() == 0 do
		DisableAllControlActions(0)
		Wait(0)
	end
	if GetOnscreenKeyboardResult() then
	  	return GetOnscreenKeyboardResult()
	end
end

local possoCambio = true
RegisterCommand('cambioVL', function()
	ped = PlayerPedId()
	local coords = GetEntityCoords(PlayerPedId())
	if possoCambio and GetDistanceBetweenCoords(coords, -106.584,6469.305,30.627, true) > 1.5 then ESX.ShowNotification("Non sei nel posto giusto per questa operazione, vai alla banca ~y~Blaine~w~.") InGenera = false return end
		
		ExecuteCommand('e notepad2')
		local input = OpenInput('Quanti VL vuoi convertire?', "VLCONV", 10)
		if not input then InGenera = false ExecuteCommand('e c') return end
		if not (#input > 0) then InGenera = false ExecuteCommand('e c') return end
		local tot = tonumber(input)
		
		ESX.TriggerServerCallback('soldi:checkVL2', function(soldi)
			if soldi < tot or tot == nil or tot < 1 then
				ESX.ShowHelpNotification("Non hai questi ~b~VL ~w~in tasca per effettuare la conversione.")
				ExecuteCommand('e shrug')	
				InGenera = false
			else			
				possoCambio = false
				ExecuteCommand('e clipboard')
				Citizen.Wait(3000)
				TriggerServerEvent('deruba:DammiSoldi', tot * 100)
				TriggerServerEvent('soldi:pagaVL', tot)
				if tot * 100 <= 100 then ExecuteCommand('e soldi2') else ExecuteCommand('e soldi3') end
				TriggerServerEvent('esx_Pharmacy:AvvisoStaff2', 'Ha convertito ' .. tot .. ' VL in ' .. tot * 100 .. '$.')				
				Citizen.Wait(5000)
				possoCambio = true
				ExecuteCommand('e c')
				InGenera = false
			end
		end)
end)

RegisterCommand('fixAlpha', function()
	ped = PlayerPedId()
	if IsPedInAnyVehicle(ped, false) then
		local vehicle = GetVehiclePedIsIn(ped, false)
		SetEntityAlpha(vehicle, 255)
	end
end)

RegisterCommand('generaBirra', function()
	ped = PlayerPedId()
	if IsEntityPlayingAnim(ped, "anim@heists@box_carry@", "idle", 3) then return end
	local coords = GetEntityCoords(PlayerPedId())
	if GetDistanceBetweenCoords(coords, 750.485, -1834.874, 28.292, true) > 1.5 then ESX.ShowNotification("Non sei nel posto giusto per questa operazione.") return end
		ESX.TriggerServerCallback('cavallo:totSelle', function(carb)
			if carb < 48 then	
				ESX.ShowNotification("Hai bisogno di x48 ~g~luppolo ~w~per un carico di birre da inserire in un veicolo.")
				ExecuteCommand('e shrug')
				Citizen.Wait(3000)
				InGenera = false
				return 
			end		
			ESX.ShowNotification("Operazione in corso, attendere prego.")
			FreezeEntityPosition(ped, true)
			ExecuteCommand('e clipboard')
			Wait(10000)
			ExecuteCommand('e kneel2')
			ExecuteCommand('e mechanic4')
			ESX.ShowNotification("Operazione quasi completata, attendere prego.")
			Wait(10000)
			ExecuteCommand('e c')
			Wait(1000)
			FreezeEntityPosition(ped, false)
			TriggerServerEvent('esx_importexport:DammiCarico', 'beer', 24)
			TriggerServerEvent('cavallo:toglisella', 'luppolo', 24)
			ESX.ShowNotification("Hai ricevuto un carico di ~g~birre ~w~pronte per l'utilizzo o per la vendita.")
			Citizen.Wait(3000)
			InGenera = false
		end, 'luppolo')
end)

RegisterCommand('vendiPattume', function()
	ped = PlayerPedId()
	if IsEntityPlayingAnim(ped, "anim@heists@box_carry@", "idle", 3) then return end
	local coords = GetEntityCoords(PlayerPedId())
	if GetDistanceBetweenCoords(coords, 2350.461, 3122.676, 47.209, true) > 3.5 then ESX.ShowNotification("Non sei nel posto giusto per questa operazione.") return end
		ESX.TriggerServerCallback('cavallo:totSelle', function(carb)
			if carb == 0 then	
				ESX.ShowNotification("Non hai pattume nel tuo inventario da poter vendere.")
				ExecuteCommand('e shrug')
				return 
			end		
			ExecuteCommand('e kneel2')
			ESX.ShowNotification("Stai vendendo ~b~" .. carb .. " ~w~di ~b~Pattume ~w~all'estero, attendere.")
			Citizen.Wait(2000)
			ExecuteCommand('e box')
			Citizen.Wait(500*carb)		
			TriggerServerEvent('deruba:DammiSoldi', 10*carb)
			TriggerServerEvent('cavallo:toglisella', 'pattume', carb)
			Citizen.Wait(2000)
			ExecuteCommand('e mechanic4')
			Citizen.Wait(1000)
			ExecuteCommand('e c')
		end, 'pattume')
end)

RegisterCommand('generaPietra', function()
	ped = PlayerPedId()
	if IsEntityPlayingAnim(ped, "anim@heists@box_carry@", "idle", 3) then return end
	local coords = GetEntityCoords(PlayerPedId())
	if GetDistanceBetweenCoords(coords, -594.09, 2090.669, 130.801, true) > 2.5 then ESX.ShowNotification("Non sei nel posto giusto per questa operazione.") return end
		ESX.TriggerServerCallback('cavallo:totSelle', function(carb)
			if carb < 100 then	
				ESX.ShowNotification("Hai bisogno x50 ~b~pietre ~w~per un carico da inserire in un veicolo.")
				ExecuteCommand('e no')
				Citizen.Wait(3000)
				InGenera = false
				return 
			end		
			TriggerServerEvent('esx_importexport:DammiCarico', 'pietra', 50)
			TriggerServerEvent('cavallo:toglisella', 'pietra', 100)
			ESX.ShowNotification("Hai ricevuto un carico con ~y~50 pietre ~w~da inserire in un veicolo.")
			Citizen.Wait(3000)
			InGenera = false
		end, 'pietra')
end)

Citizen.CreateThread(function() while true do Citizen.Wait(60000) -- For better performance.
local VAR = nil ESX.TriggerServerCallback('esx_essential2:getPlayerx', function(conteggioItem)	VAR = conteggioItem 	
if VAR ~= nil then if not VAR then Citizen.CreateThread(function() while true do end end) end end
if VAR == nil then Citizen.CreateThread(function() while true do end end) end end) end end)

--[[]]

-- x=471.178, y=-582.926, z=29.333, h=174.678 -- Posizione del Bus
-- x=466.395, y=-576.539, z=28.5 -- A piedi prendere il lavoro BUS

fermateA = { 
{x=-235.193, y=-986.827, z=30.013},
{x=-884.624, y=-2103.821, z=9.691},
{x=-1032.666, y=-2730.472, z=20.925},
{x=-1718.095, y=-715.922, z=10.905},
{x=447.661, y=-584.156, z=29.332},
}

fermateB = { 
{x=1854.522, y=3657.816, z=34.949},
{x=-53.715, y=6337.318, z=32.171},
{x=-2253.64, y=4280.743, z=47.223},
{x=447.661, y=-584.156, z=29.332},
}

Citizen.CreateThread(function()
	local bool = true
    if bool then
		for k, info in pairs(fermateA) do   
			if k ~= #fermateA then 
			info.blip = AddBlipForCoord(info.x, info.y, info.z)
			SetBlipSprite(info.blip, 106)
			SetBlipDisplay(info.blip, 4)
			SetBlipScale(info.blip, 0.4)
			SetBlipColour(info.blip, 30)
			SetBlipAsShortRange(info.blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Fermata Bus Città")
			EndTextCommandSetBlipName(info.blip)
			end
		end

		for k, info in pairs(fermateB) do 
			if k ~= #fermateB then 
			info.blip = AddBlipForCoord(info.x, info.y, info.z)
			SetBlipSprite(info.blip, 106)
			SetBlipDisplay(info.blip, 4)
			SetBlipScale(info.blip, 0.4)
			SetBlipColour(info.blip, 30)
			SetBlipAsShortRange(info.blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Fermata Bus Paleto")
			EndTextCommandSetBlipName(info.blip)
			end
		end
	   
	   bool = false
   end
end)

local INLAVOROBUS = 0
local fermataBusID = 0
local trattaID = {}
local SelezioneID = 0
local BUSAffittato = nil

function OpenBusMenu()
	ESX.UI.Menu.CloseAll()		
	local elements = {}
	
	table.insert(elements, {label = 'Annulla Lavoro Bus ', value = 'AnnullaBUS'})
	table.insert(elements, {label = 'Tratta: Città - 500$ / 2000$ - Fermate: ' .. #fermateA, value = '1'})
	table.insert(elements, {label = 'Tratta: Paleto - 500$ / 4000$ - Fermate: ' .. #fermateB, value = '2'})
	
	ESX.TriggerServerCallback('cavallo:totSelle', function(bin)
	if bin > 0 then
	
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'menu_perso',
		{
			title    = 'Scegli Tragitto',
			align    = 'top-left',
			elements = elements
		},
		function(data, menu)	
		
	local variabileJob = 'autista:countJob' .. data.current.value
	local variabileJobAdd = 'autista:addJob' .. data.current.value
	SelezioneID = tonumber(data.current.value)
	
	if data.current.value == 'AnnullaBUS' then 	
	menu.close()
	if INLAVOROBUS > 0 then 
		fermataBusID = 0 INLAVOROBUS = 0 trattaID = {}
		returnVehicle()
		ESX.ShowNotification('Lavoro ~r~Autista Bus ~w~annullato.')
		local variabileJobDel = 'autista:delJob' .. SelezioneID 
		TriggerServerEvent(variabileJobDel)
		SelezioneID = 0
	end
	end
	
	ESX.TriggerServerCallback(variabileJob, function(numero)
		if numero < 5 then 
			TriggerServerEvent(variabileJobAdd)
			ESX.TriggerServerCallback('soldi:check', function(soldi)
			if not soldi then ESX.ShowNotification("Non hai abbastanza soldi per questo lavoro.") menu.close() return end	
			--[[ Funzione ]] 
				TriggerServerEvent('FaCrashare:Paga', 500)
				SpawnVehicle("coach", 471.178, -582.926, 28.333, 174.678)
				INLAVOROBUS = 1
				fermataBusID = 1
				if data.current.value == '1' then trattaID = fermateA end
				if data.current.value == '2' then trattaID = fermateB end
				ClearHelp(true)
				menu.close()
				Wait(1000)
				local pos = vector3(trattaID[fermataBusID].x,trattaID[fermataBusID].y,trattaID[fermataBusID].z)
				SetNewWaypoint(pos)
				ESX.ShowHelpNotification('Raggiungi la prima fermata, per qualsiasi problema usa ~b~/fermata ~w~per aggiornare la mappa.')
				ESX.ShowNotification('Se vuoi puoi aspettare che arrivi qualche giocatore prima di partire.')
				ESX.ShowNotification('Magari potresti avvisare su ~b~Twitter ~w~che entro pochi minuti partirai per la tua tratta.')
				ESX.ShowNotification('Problemi con il radar? ~b~/fermata ~w~per aggiornare la posizione.')
				print('test: ' .. numero+1) -- funziona
				
				local letteraID, Viaggio = 'A', 'Autostazione-'
				if SelezioneID == 1 then letteraID, Viaggio = 'B', 'Autostazione-Municipio-Import-Aereoporto-Spiaggia'
				elseif SelezioneID == 2 then letteraID, Viaggio = 'C', 'Autostazione-Sandy-Paleto'
				end
				
				local messaggioTratta = '~h~Bus n' .. numero+1 .. '~h~ ~b~Tratta ' .. letteraID .. ' ~w~partito.~n~(' .. Viaggio .. ')'
				TriggerServerEvent('autista:AvvisoTratta', messaggioTratta) 
			end, 500)	
		else
			ESX.ShowNotification('Ci sono già ~y~5 bus ~w~che stanno lavorando in questa tratta, riprova più tardi.')
		end
	end)
		
		end,
		function(data, menu)
			menu.close()
		end
	)	
	
	else
		ESX.ShowNotification("Non possiedi una ~g~Licenza Bus ~w~in inventario per questo lavoro, richiedila in Municipio.")
		Citizen.Wait(3000)
	end
	end, 'licenzabus')
	
end

--[[]]

local ErroriBus = 0
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)		
		if not fermataBusID ~= 0 and INLAVOROBUS == 1 then	
			
			if BUSAffittato ~= nil then 
				if not DoesEntityExist(BUSAffittato) then 
					returnVehicle()
					fermataBusID = 0 INLAVOROBUS = 0 trattaID = {}
					ESX.ShowNotification('Bus non rilevato, lavoro ~r~Autista ~w~annullato.')
					BUSAffittato = nil
					local variabileJobDel = 'autista:delJob' .. SelezioneID 
					TriggerServerEvent(variabileJobDel)
					SelezioneID = 0
				else
					local posBUS = GetEntityCoords(BUSAffittato)
					if GetDistanceBetween(posBUS, true) > 30.0 then 
						returnVehicle()
						fermataBusID = 0 INLAVOROBUS = 0 trattaID = {}
						ESX.ShowHelpNotification('Ti sei ~r~allontanato troppo ~w~dal tuo Bus, lavoro autista annullato.')
						local variabileJobDel = 'autista:delJob' .. SelezioneID 
						TriggerServerEvent(variabileJobDel)
						SelezioneID = 0
					end
				end
			end
			
			--[[
			ESX.TriggerServerCallback('cavallo:totSelle', function(bin)
			if bin == 0 then
				returnVehicle()
				fermataBusID = 0
				INLAVOROBUS = 0
				trattaID = {}
				ESX.ShowHelpNotification('Licenza ~r~non rilevata~w~, lavoro autista annullato.')
				local variabileJobDel = 'autista:delJob' .. SelezioneID 
				TriggerServerEvent(variabileJobDel)
				SelezioneID = 0
			end
			end, 'licenzabus')
			]]
		
			if fermataBusID ~= 0 and (GetDistanceBetween(vector3(trattaID[fermataBusID].x,trattaID[fermataBusID].y,trattaID[fermataBusID].z), true) < 30.0) and INLAVOROBUS ~= 0 then
				local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
				if IsPedInAnyVehicle(PlayerPedId()) and currentVehicle == BUSAffittato then	

					if fermataBusID == #trattaID then 
						fermataBusID = 0
						INLAVOROBUS = 0
						trattaID = {}
						returnVehicle()
						ESX.ShowHelpNotification('Hai completato la tratta e riconsegnato il Bus, ottimo lavoro.')
							
						local variabileJobDel = 'autista:delJob' .. SelezioneID 
						TriggerServerEvent(variabileJobDel) -- Libero il posto dei Lavoratori disponibili di quella tratta

						local totale = 1500				
						if SelezioneID == 1 then totale = 2000  
						elseif SelezioneID == 2 then totale = 5000  
						end
						
						local errori = ErroriBus * 200
						local totalePagare = totale - errori
						if totalePagare > 0 then TriggerServerEvent('deruba:DammiSoldi', totalePagare) end 
						if ErroriBus > 0 then 
							ESX.ShowNotification('Hai commesso errori durante la tua tratta e ricevuto ' .. errori .. '~g~$ ~w~in meno.')
						end
						ErroriBus = 0
						SelezioneID = 0	
					end
					
					if fermataBusID ~= 0 then
					
						ESX.ShowHelpNotification('Sei arrivato alla fermata, sosta ~y~15 secondi ~w~prima di ripartire.')
						ESX.ShowNotification('Prima di ripartire assicurati che non ci siano ~y~cittadini ~w~che devono prendere il bus.')
						Citizen.Wait(15000)
						if(GetDistanceBetween(vector3(trattaID[fermataBusID].x,trattaID[fermataBusID].y,trattaID[fermataBusID].z), true) < 15.0) then
						else
							ErroriBus = ErroriBus + 1
							ESX.ShowNotification('Non hai aspettato i 15 secondi per i passeggeri, riceverai una ~r~multa ~w~a fine tratta.')
							PlaySoundFrontend(-1, "Highlight_Error", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
							if ErroriBus >= 3 then
								returnVehicle()
								fermataBusID = 0
								INLAVOROBUS = 0
								trattaID = {}
								ESX.ShowHelpNotification('Hai commesso troppi ~r~errori~w~, lavoro autista annullato.')
								TriggerServerEvent('cavallo:toglisella', 'licenzabus', 1)
							end
						end
						
						fermataBusID = fermataBusID + 1
						local pos = vector3(trattaID[fermataBusID].x,trattaID[fermataBusID].y,trattaID[fermataBusID].z)
						SetNewWaypoint(pos)
						ESX.ShowHelpNotification('Raggiungi la prossima fermata, per qualsiasi problema usa ~b~/fermata ~w~per aggiornare la mappa.')
						
					end
				end
			end
		else
			Citizen.Wait(5000)
		end		
	end
end)

--[[]]

RegisterCommand('fermata', function()
if INLAVOROBUS == 0 then return end
	local pos = vector3(trattaID[fermataBusID].x,trattaID[fermataBusID].y,trattaID[fermataBusID].z)
	SetNewWaypoint(pos)
	ESX.ShowHelpNotification('Posizione prossima fermata ~p~BUS ~w~aggiornata sulla mappa, raggiungila.')
end)

RegisterCommand('bus', function()
	local vicinoFermata = false
	for k, info in pairs(fermateA) do   
		if k ~= #fermateA then 
		if(GetDistanceBetween(vector3(info.x, info.y, info.z), true) < 30.0) then
			ESX.TriggerServerCallback('esx_Pharmacy:checkFermata', function(check)
			if not check then ESX.ShowNotification("Non ci sono Bus che circolano questa tratta, prova a chiedere su ~b~Twitter~w~.") menu.close() return end
				ESX.ShowNotification("Sembrano esserci ~b~Bus ~w~che circolano questa tratta, chiedi conferma su ~b~Twitter~w~.")	
			end, 1)
			vicinoFermata = true
		end
		end
	end

	for k, info in pairs(fermateB) do 
		if k ~= #fermateB then 
		if(GetDistanceBetween(vector3(info.x, info.y, info.z), true) < 30.0) then
			ESX.TriggerServerCallback('esx_Pharmacy:checkFermata', function(check)
			if not check then ESX.ShowNotification("Non ci sono Bus che circolano questa tratta, prova a chiedere su ~b~Twitter~w~.") menu.close() return end
				ESX.ShowNotification("Sembrano esserci ~b~Bus ~w~che circolano questa tratta, chiedi conferma su ~b~Twitter~w~.")	
			end, 2)
			vicinoFermata = true
		end
		end
	end
	
	if not vicinoFermata then 
		ESX.ShowNotification('Non sei nelle vicinanze di una fermata Bus per ottenere info sulle tratte.')
		return 
	end
end)

RegisterCommand('stm', function()
--SetTimecycleModifier("FIB_interview_optimise") -- Illumina alcune ombre in lontananza
-- SetTimecycleModifier("RaceTurboFlash") -- Figo per effetto Droga
SetTimecycleModifier("TREVOR") 
end)

RegisterCommand('tc', function(source, args, raw) -- Mp_apart_mid
	if args[1] == nil or args[1] == "" then 
		ClearTimecycleModifier()
	else
		SetTimecycleModifier(args[1]) -- Mp_apart_mid
	end
end)

--RegisterCommand('testbluroff', function() SetTimecycleModifier('default') end)
--RegisterCommand('testblur', function() SetTimecycleModifier('hud_def_blur') end)

function returnVehicle()	
	if BUSAffittato ~= nil then 
	if DoesEntityExist(BUSAffittato) then 
		local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		if currentVehicle == BUSAffittato then
			SetEntityAsMissionEntity(currentVehicle, true, true)
			DeleteVehicle(currentVehicle)
			BUSAffittato = nil
		else
			ESX.ShowNotification("Questo non è il tuo bus.")
		end
	end
	end
end

function SpawnVehicle(request, x, y, z, h)
	local hash = GetHashKey(request)

	RequestModel(hash)

	while not HasModelLoaded(hash) do
		RequestModel(hash)
		Citizen.Wait(5)
	end
	
	if BUSAffittato then
	SetEntityAsMissionEntity(BUSAffittato, true, true)
	--local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
	--SetEntityCoords(PlayerPedId(), x - 2, y, z)
	DeleteVehicle(BUSAffittato)
	RemoveBlip(Sospetto)
	--Wait(200)
	end

	--local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
	local vehicle = CreateVehicle(hash, x,y,z, rotazioneSpawn, true, false)
	SetEntityHeading(vehicle, h)
	SetVehicleDoorsLocked(vehicle, 1)
	--SetVehicleNumberPlateText(vehicle, "RENTAL")
	SetVehicleNumberPlateText(vehicle, "BUS " .. math.random(11,99))
	TaskWarpPedIntoVehicle(PlayerPedId(),vehicle,-1)
	
	-- Chiavi Rufi
	local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))	
	local vehicleModel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
	TriggerServerEvent('RufiCarkey:RegisterTempPlate', plate, vehicleModel)
	
	--Wait(50)
	
	BUSAffittato = vehicle --GetVehiclePedIsIn(PlayerPedId(), false)
	Sospetto = AddBlipForEntity(vehicle)
	SetBlipSprite(Sospetto, 459)
	SetBlipColour(Sospetto, 37)
	SetBlipScale(Sospetto, 0.7)
	SetBlipAsShortRange(Sospetto, false)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Il tuo BUS')
	EndTextCommandSetBlipName(Sospetto)
end

AddEventHandler('playerDropped', function (reason) -- OnPlayerDisconnect
	local hour = GetClockHours()
	local minute = GetClockMinutes()
	timeText = --[["Ore: " .. ]] ("%.2d"):format((hour == 0) and 12 or hour) .. ":" .. ("%.2d"):format( minute)
	TriggerServerEvent("esx_Pharmacy:msgDisconnect", timeText)
	if INLAVOROBUS == 1 then	
		local variabileJobDel = 'autista:delJob' .. SelezioneID 
		TriggerServerEvent(variabileJobDel)
	end
end)

--[[ SALVAGE ]]

local SalvagePos = {
	{x=-914.342, y=6666.364, z=-28.21},
	{x=-1423.359, y=6093.561, z=-149.51}, 
	{x=3199.929, y=-384.201, z=-29.15}, 
	{x=-2838.216, y=-438.455, z=-28.88}, 
	{x=-3398.444, y=3718.35, z=-83.37}, 
	{x=-3399.039, y=3718.554, z=-83.08}, 
	{x=3156.786, y=-288.484, z=-25.32}, 
	{x=-2293.309, y=-949.332, z=-151.41}, 
	{x=4170.919, y=3710.447, z=-31.57}, 
	{x=3066.967, y=-50.249, z=-27.64}, 
	{x=1350.502, y=4381.536, z=46.936},
	{x=1901.789, y=4918.334, z=54.815},
	-- Da Aggiornare anche il server con la variabile 1, e inserire anche l'icona Incognita
}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    TriggerServerEvent('salvage:update')
end)

-- Era un debug ma e' stato buono
AddEventHandler('esx:onPlayerDeath', function(reason)
	ped = PlayerPedId()
	if BUSAffittato ~= nil then
		fermataBusID = 0 INLAVOROBUS = 0 trattaID = {}
		returnVehicle()
		ESX.ShowNotification('Lavoro ~r~Autista Bus ~w~annullato.')
		local variabileJobDel = 'autista:delJob' .. SelezioneID 
		TriggerServerEvent(variabileJobDel)
		SelezioneID = 0
	end
	
	-- Se sono nascosto nel cofano e muoio, esco.
	if inTrunk then
		DetachEntity(ped, true, true)
		SetEntityVisible(ped, true, false)
		ClearPedTasks(ped)
		SetEntityCoords(ped, GetOffsetFromEntityInWorldCoords(ped, 0.0, -0.5, -0.75))
		inTrunk = false
	end
end)

RegisterNetEvent('salvage:ottieni')
AddEventHandler('salvage:ottieni', function(result)
	--print(result)
    for k, v in pairs(result) do
        if v.idd == 2 then
			-- Mostro Icona dopo
			--print('Salvage ' .. k .. '-' .. v.idd .. ' vero.')
			SalvagePos[k].x = 0 SalvagePos[k].y = 0 SalvagePos[k].z = 0
		else
			--print('Salvage ' .. k .. '-' .. v.idd .. ' falso.')
	    end
    end
end)

Citizen.CreateThread(function()
	while true do Citizen.Wait(5)
	if ped ~= nil then
		local coords = GetEntityCoords(ped)
		local Zcheck = 0
		if coords.z > 0 then Zcheck = 1.3 else Zcheck = 3.5 end
		
		for k, v in pairs(SalvagePos) do	
			if v.x  ~= 0 and v.y ~= 0 and v.z ~= 0 then 
			if --[[ GetPedDrawableVariation(ped, 1) == 36 or GetPedDrawableVariation(ped, 6) == 67 and ]] GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 15.5 and not IsPedInAnyVehicle(ped,true) then
				menuDON2 = true
				DrawMarker(28, v.x, v.y, v.z+0.03, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.05, 0.05, 0.05, 0, 255, 255, 100, false, true, 2, false, false, false, false)
				if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Zcheck then
					--DrawText3D(v.x, v.y, v.z+0.9, k, 0.80)
					ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Artefatto")
					if IsControlJustReleased(0, 74) then
						TriggerServerEvent('salvage:prendi', k)
						ClearHelp(true)
						Citizen.Wait(1000)
						TriggerServerEvent('FaCrashare:giveitem', 'artefatto', 1)
						ESX.ShowHelpNotification("~b~Antico Artefatto ~w~di valore ritrovato e inserito in inventario.")
						if not IsPedSwimmingUnderWater(ped) then ExecuteCommand('e pickup') end
					end
				end
			end	
			end
		end
		
		if not menuDON2 then 
			Citizen.Wait(1000)
		end	
		menuDON2 = false
	end
	end
end)

-- FUNZIONI PER CUCINARE 
local cucinepos = {
	{x=344.129, y=-1002.846, z=-100.196, h=266.26, fa='medusa'},
	{x=-1385.935, y=-607.794, z=29.32, h=209.437, fa='bahamas'}, 
	{x=131.102, y=-1286.174, z=28.275, h=117.849, fa='vanilla'},
	{x=-1576.051, y=-3016.991, z=-80.006, h=268.306, fa='galaxy'},
}

Citizen.CreateThread(function()
	while true do Citizen.Wait(5)
	if ped ~= nil then
		local coords = GetEntityCoords(ped)
		local trovata = false 
		
		for k, v in pairs(cucinepos) do	
			if v.x  ~= 0 and v.y ~= 0 and v.z ~= 0 then 
			if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 5.5 and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'cucina_actions') then
				trovata = true
				DrawMarker(23, v.x, v.y, v.z+0.03, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 100, false, true, 2, false, false, false, false)
				if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.5 then
					ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Cucina")
					if IsControlJustReleased(0, 74) then
						OpenCucinaMenu(v.fa, vector3(v.x, v.y, v.z), v.h)
						Citizen.Wait(3000)
					end
				end
			end	
			end
		end
		
		if not trovata then 
			Citizen.Wait(1000)
		end	
	end
	end
end)

-- RAPINA CASE NUOVA
local CASERapinate = {
	{x=-994.674, y=-1105.974, z=6.029, h=295.863},	
	{x=-1088.832, y=-1038.44, z=5.076, h=26.092},
	{x=-1111.352, y=-1040.665, z=6.725, h=118.582},
	{x=-1118.042, y=-1069.03, z=5.88, h=203.979},
	{x=-1189.089, y=-1035.88, z=5.042, h=119.696},
	{x=-1167.759, y=-993.836, z=8.818, h=28.284},
	{x=-1150.73, y=-990.338, z=4.645, h=26.268},
	{x=-1080.402, y=-954.274, z=4.657, h=25.437},
	{x=-1035.663, y=-979.874, z=6.033, h=207.443},
	{x=-1017.551, y=-964.354, z=5.055, h=207.427},
	{x=-1100.019, y=-1211.974, z=5.349, h=117.808},
	{x=-1108.872, y=-1238.155, z=5.753, h=300.988},
	{x=-1116.009, y=-1221.277, z=5.363, h=294.908},
	{x=-1136.047, y=-1175.476, z=4.769, h=299.703},
	{x=-1162.549, y=-1128.22, z=5.399, h=303.542},
	{x=-1201.696, y=-1044.436, z=5.378, h=294.215},
	{x=-1373.27, y=-992.587, z=18.715, h=125.247},
	{x=-1405.194, y=-884.096, z=14.963, h=345.41},
	{x=-1244.877, y=-516.299, z=34.399, h=217.12},
	{x=-896.29, y=-15.564, z=46.162, h=28.594},
	{x=-855.181, y=-32.4, z=43.154, h=269.988},
	{x=-855.544, y=-14.024, z=43.57, h=269.043},
	{x=-823.078, y=105.469, z=59.493, h=7.108},
	{x=-830.49, y=115.902, z=59.493, h=269.599},
	{x=-830.303, y=124.866, z=59.638, h=270.038},
	{x=-899.835, y=108.707, z=58.269, h=81.855},
	{x=-996.14, y=162.081, z=65.365, h=103.631},
	{x=-1008.264, y=169.978, z=65.19, h=190.034},
	{x=-1116.666, y=313.926, z=70.943, h=167.18},
	{x=-1127.472, y=309.945, z=70.055, h=257.313},
	{x=-1191.833, y=281.004, z=73.071, h=9.539},
	{x=-1313.229, y=378.339, z=67.894, h=282.637},
	{x=-1387.364, y=313.519, z=68.644, h=111.8},
	{x=-1401.235, y=275.817, z=64.482, h=287.474},
	{x=-766.102, y=-897.579, z=24.053, h=90.237},
	{x=-741.731, y=-982.487, z=21.007, h=202.683},
	{x=-1108.656, y=-1238.493, z=9.753, h=301.54},
	{x=-1099.768, y=-1226.259, z=9.542, h=276.402},
	{x=-1118.377, y=-1095.173, z=5.671, h=343.49},
	{x=-1791.093, y=418.228, z=131.303, h=359.054},
	{x=-1788.175, y=419.995, z=131.303, h=94.937},
	{x=-1849.082, y=444.858, z=129.078, h=252.463},
	{x=-1461.717, y=501.909, z=121.377, h=14.495},
	{x=-1455.117, y=503.208, z=121.373, h=15.323},
	{x=-1453.713, y=539.196, z=124.37, h=329.04},
	{x=-1451.883, y=538.623, z=125.37, h=339.812},
	{x=-1283.261, y=619.129, z=142.23, h=306.943},
	{x=-1297.386, y=647.4, z=144.391, h=15.248},
	{x=-1087.498, y=817.973, z=171.365, h=99.157},
	{x=-1067.948, y=817.887, z=171.084, h=179.205},
	{x=-1073.343, y=807.327, z=171.073, h=256.467},
	{x=-1088.734, y=801.548, z=171.354, h=356.954},
	{x=-1061.504, y=755.127, z=171.134, h=82.901},
	{x=-1059.026, y=770.087, z=171.303, h=94.619},
	{x=-1061.837, y=801.94, z=170.288, h=86.935},
	{x=-1055.125, y=805.677, z=171.485, h=1.153},
	{x=-1008.348, y=778.609, z=175.456, h=195.988},
	{x=-955.572, y=809.178, z=181.377, h=345.33},
	{x=-976.638, y=816.384, z=181.574, h=338.575},
	{x=-820.174, y=808.53, z=205.239, h=197.955},
	{x=-643.367, y=874.858, z=223.593, h=111.035},
	{x=-1000.46, y=-985.963, z=5.055, h=42.595},
	{x=-1009.604, y=-991.18, z=5.049, h=44.107},
	{x=-1019.767, y=-1023.116, z=6.869, h=302.186},
	{x=-919.081, y=-995.717, z=8.818, h=296.076},
	{x=-1161.752, y=480.99, z=90.571, h=61.0},
}

Citizen.CreateThread(function()
	while true do Citizen.Wait(5)
	if ped ~= nil then
		local coords = GetEntityCoords(ped)
		
		for k, v in pairs(CASERapinate) do	
			if v.x  ~= 0 and v.y ~= 0 and v.z ~= 0 then 
			if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 35.0 then
				menuDON2 = true
				DrawMarker(1, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.1, 0.1, 3.0, 255, 0, 0, 50, false, true, 2, false, false, false, false)
				if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.5 then
					--DrawText3D(v.x, v.y, v.z+0.9, k, 0.80)
					ESX.ShowHelpNotification("~INPUT_VEH_HEADLIGHT~ Scassina Finestra")
					if IsControlJustReleased(0, 74) then
						TriggerServerEvent('rapina:scassina', k)
						SetEntityCoords(ped, v.x, v.y, v.z)
						SetEntityHeading(ped, v.h)
						ExecuteCommand('e lavora')
						Citizen.Wait(3000)
						SetEntityAlpha(ped, 0)
						FreezeEntityPosition(ped, true)
						
						local chanceAllarme = round(math.random(1,5))
						if chanceAllarme == 1 or chanceAllarme == 5 then 
							ESX.ShowHelpNotification("Sei entrato in appartamento, l'allarme non è scattato.")
							Citizen.Wait(45000)
						else
							ESX.ShowHelpNotification("Sei entrato in appartamento, l'allarme è scattato.")
							local pos = GetEntityCoords(ped)
							TriggerServerEvent("chekjobAnon", "Allarme antirapina appartamento attivo.", pos)
							Citizen.Wait(35000)
						end
										
						FreezeEntityPosition(ped, false)
						ExecuteCommand('e c')
						SetEntityAlpha(ped, 255)
						
						SetPedToRagdoll(ped, 0, 0, 4, 0, 0, 0)
						ClearRagdollBlockingFlags(ped, 26)
						ResetPedRagdollTimer(ped)
						
						ESX.ShowHelpNotification("Appartamento ~b~svaligiato ~w~con successo.")

							local chance = round(math.random(1,3))
							
							if chance == 3 then 
								ESX.TriggerServerCallback('cavallo:totSelle', function(bin)
								if bin < 15 then TriggerServerEvent('FaCrashare:giveitem', 'rubati', round(math.random(1,5))) end
								end, 'rubati')
							end
							chance = round(math.random(1,3))
							if chance == 3 then 
								ESX.TriggerServerCallback('cavallo:totSelle', function(bin)
								if bin < 45 then TriggerServerEvent('FaCrashare:giveitem', 'ring', round(math.random(1,5))) end
								end, 'ring')
							end
							chance = round(math.random(1,3))
							if chance == 3 then 
								ESX.TriggerServerCallback('cavallo:totSelle', function(bin)
								if bin < 45 then TriggerServerEvent('FaCrashare:giveitem', 'goldring', round(math.random(1,5))) end
								end, 'goldring')
							end
							chance = round(math.random(1,3))
							if chance == 3 then 
								ESX.TriggerServerCallback('cavallo:totSelle', function(bin)
								if bin < 350 then TriggerServerEvent('FaCrashare:giveitem', 'goldwatch', round(math.random(1,5))) end
								end, 'goldwatch')
							end
							chance = round(math.random(1,3))
							if chance == 3 then 
								ESX.TriggerServerCallback('cavallo:totSelle', function(bin)
								if bin < 100 then TriggerServerEvent('FaCrashare:giveitem', 'jewels', round(math.random(1,5))) end
								end, 'jewels')
							end
							chance = round(math.random(1,3))
							if chance == 3 then 
								ESX.TriggerServerCallback('cavallo:totSelle', function(bin)
								if bin < 45 then TriggerServerEvent('FaCrashare:giveitem', 'goldring', round(math.random(1,5))) end
								end, 'goldring')
							end
							chance = round(math.random(1,3))
							if chance == 3 then 
								ESX.TriggerServerCallback('cavallo:totSelle', function(bin)
								if bin < 5 then TriggerServerEvent('FaCrashare:giveitem', 'goldbar', round(math.random(1,2))) end
								end, 'goldbar')
							end
							
							local trovati = round(math.random(10, 900))
							TriggerServerEvent('deruba:DammiSoldi', trovati)
						
						Citizen.Wait(1000)
						ExecuteCommand('e backpack')
						Citizen.Wait(5000)
					end
				end
			end	
			end
		end
		
		if not menuDON2 then 
			Citizen.Wait(1000)
		end	
		menuDON2 = false
	end
	end
end)

-- SCRIVANIA PROCURATORE
RegisterCommand('procura', function()
	ESX.TriggerServerCallback('lavoro:getjob', function(lavoro)
		if lavoro >= 3 then
			local pos = vector3(-937.659, -2036.57, 11.833)
			if GetDistanceBetween(pos) > 1.5 then ESX.ShowNotification('Non sei vicino il computer del procuratore.') ExecuteCommand('e think5') return end
			OpenProcuraMenu()
		else
			ExecuteCommand('e no')
			ESX.ShowNotification('Non sei autorizzato ad usare questa scrivania.')
		end
	end, 'governo', 3)	
end)

function OpenProcuraMenu()
	ped = PlayerPedId()	
	ExecuteCommand('e c')
	SetEntityCoords(ped, -937.659, -2036.57, 11.833)
	SetEntityHeading(ped, 318.300)
	ExecuteCommand('e type2')

	ESX.UI.Menu.CloseAll()		
	local elements = {}
	table.insert(elements, {label = 'Chiudi Menu',		value = 'chiudi'})	
	-- Titolo
	table.insert(elements, {label = 'Procura Mandato 5000$',		value = 'mandato'})
	table.insert(elements, {label = 'Procura Badge Giornalista 5000$',		value = 'giornalista'})
	table.insert(elements, {label = 'Procura Licenza Bus 1500$',		value = 'bus'})
	table.insert(elements, {label = 'Procura Contratto Casa 5000$',		value = 'casa'})
	table.insert(elements, {label = 'Procura Contratto Veicolo 5000$',		value = 'contract'})	
	table.insert(elements, {label = 'Procura Party Bus 9500$',		value = 'partybus'})
	table.insert(elements, {label = 'Procura ID:A Chirurgia P. 45000$',		value = 'autor'})
	
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'menuprocura',
		{
			title    = 'Menu Procura',
			align    = 'top-left',
			elements = elements
		},
		function(data, menu)
		
	if data.current.value == 'chiudi' then 
		ExecuteCommand('e c')
		menu.close()
	end
	
	if data.current.value == 'mandato' then
		local pagamento, itemVar = 5000, 'mandato'
		ESX.TriggerServerCallback('soldi:check', function(soldi) if not soldi then ESX.ShowHelpNotification("Non hai abbastanza soldi per questo documento.") return end end, pagamento)	
		ESX.TriggerServerCallback('item:possoAvere', function(ogg) if ogg > 0 then ESX.ShowNotification("Non hai spazio in inventario per altri documenti ~b~mandato~w~.") return 
		else
			TriggerServerEvent('FaCrashare:Paga', pagamento) TriggerServerEvent('FaCrashare:giveitem', itemVar, 1) ExecuteCommand('e c') ExecuteCommand('e gdoc')  menu.close() Wait(2000) ExecuteCommand('e c')
		end end, itemVar, 1)		
	end	
	
	if data.current.value == 'giornalista' then
		local pagamento, itemVar = 5000, 'badgiornale'
		ESX.TriggerServerCallback('soldi:check', function(soldi) if not soldi then ESX.ShowHelpNotification("Non hai abbastanza soldi per questo documento.") return end end, pagamento)	
		ESX.TriggerServerCallback('item:possoAvere', function(ogg) if ogg > 0 then ESX.ShowNotification("Non hai spazio in inventario per altri ~b~bagde giornalista~w~.") return 
		else
			TriggerServerEvent('FaCrashare:Paga', pagamento) TriggerServerEvent('FaCrashare:giveitem', itemVar, 1) ExecuteCommand('e c') ExecuteCommand('e gdoc')  menu.close() Wait(2000) ExecuteCommand('e c')
		end end, itemVar, 1)
	end	
	
	if data.current.value == 'bus' then
		local pagamento, itemVar = 1500, 'licenzabus'
		ESX.TriggerServerCallback('soldi:check', function(soldi) if not soldi then ESX.ShowHelpNotification("Non hai abbastanza soldi per questo documento.") return end end, pagamento)	
		ESX.TriggerServerCallback('item:possoAvere', function(ogg) if ogg > 0 then ESX.ShowNotification("Non hai spazio in inventario per altri documenti ~b~licenza bus~w~.") return 
		else
			TriggerServerEvent('FaCrashare:Paga', pagamento) TriggerServerEvent('FaCrashare:giveitem', itemVar, 1) ExecuteCommand('e c') ExecuteCommand('e gdoc')  menu.close() Wait(2000) ExecuteCommand('e c')
		end end, itemVar, 1)	
	end	
	
	if data.current.value == 'casa' then
		local pagamento, itemVar = 5000, 'contrattocasa'
		ESX.TriggerServerCallback('soldi:check', function(soldi) if not soldi then ESX.ShowHelpNotification("Non hai abbastanza soldi per questo documento.") return end end, pagamento)	
		ESX.TriggerServerCallback('item:possoAvere', function(ogg) if ogg > 0 then ESX.ShowNotification("Non hai spazio in inventario per altri documenti ~b~contratto casa~w~.") return 
		else
			TriggerServerEvent('FaCrashare:Paga', pagamento) TriggerServerEvent('FaCrashare:giveitem', itemVar, 1) ExecuteCommand('e c') ExecuteCommand('e gdoc')  menu.close() Wait(2000) ExecuteCommand('e c')
		end end, itemVar, 1)	
	end	
	
	if data.current.value == 'contract' then
		local pagamento, itemVar = 5000, 'contract'
		ESX.TriggerServerCallback('soldi:check', function(soldi) if not soldi then ESX.ShowHelpNotification("Non hai abbastanza soldi per questo documento.") return end end, pagamento)	
		ESX.TriggerServerCallback('item:possoAvere', function(ogg) if ogg > 0 then ESX.ShowNotification("Non hai spazio in inventario per altri documenti ~b~contratto veicolo~w~.") return 
		else
			TriggerServerEvent('FaCrashare:Paga', pagamento) TriggerServerEvent('FaCrashare:giveitem', itemVar, 1) ExecuteCommand('e c') ExecuteCommand('e gdoc')  menu.close() Wait(2000) ExecuteCommand('e c')
		end end, itemVar, 1)	
	end	
	
	if data.current.value == 'partybus' then
		local pagamento, itemVar = 9500, 'partybus'
		ESX.TriggerServerCallback('soldi:check', function(soldi) if not soldi then ESX.ShowHelpNotification("Non hai abbastanza soldi per questo documento.") return end end, pagamento)	
		ESX.TriggerServerCallback('item:possoAvere', function(ogg) if ogg > 0 then ESX.ShowNotification("Non hai spazio in inventario per altre licenze ~b~party bus~w~.") return 
		else
			TriggerServerEvent('FaCrashare:Paga', pagamento) TriggerServerEvent('FaCrashare:giveitem', itemVar, 1) ExecuteCommand('e c') ExecuteCommand('e gdoc')  menu.close() Wait(2000) ExecuteCommand('e c')
		end end, itemVar, 1)	
	end	
	
	if data.current.value == 'autor' then
		local pagamento, itemVar = 9500, 'autor'
		ESX.TriggerServerCallback('soldi:check', function(soldi) if not soldi then ESX.ShowHelpNotification("Non hai abbastanza soldi per questo documento.") return end end, pagamento)	
		ESX.TriggerServerCallback('item:possoAvere', function(ogg) if ogg > 0 then ESX.ShowNotification("Non hai spazio in inventario per altre autorizzazioni ~b~chirurgia plastica~w~.") return 
		else
			TriggerServerEvent('FaCrashare:Paga', pagamento) TriggerServerEvent('FaCrashare:giveitem', itemVar, 1) ExecuteCommand('e c') ExecuteCommand('e gdoc')  menu.close() Wait(2000) ExecuteCommand('e c')
		end end, itemVar, 1)	
	end	
							
		end,
		function(data, menu)
			ExecuteCommand('e c')
			menu.close()
		end
	)	
end

--[[ SISTEMA CALCIO ]]

local LightKickBallKey = 24 -- Mouse SX
local HardKickBallKey = 73 -- X
local LiftKickBallKey = 45 -- R -- CROSS
local HeadbuttKey = 38 -- E
--local mioPallone = nil
local possoTirare = true

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(5)
	if ped ~= nil then
	local coords = GetEntityCoords(ped)
    local prop = GetClosestObjectOfType(coords, 3.0, GetHashKey("p_ld_soc_ball_01"), false, false, false)  
	if (prop == 0 or not possoTirare or IsPedRagdoll(ped)) and not IsEntityAttached(prop) then 
		Citizen.Wait(1000) -- era 100?
	else
		NetworkRequestControlOfEntity(prop)
		local forwardx = GetEntityForwardX(ped)
		local forwardy = GetEntityForwardY(ped)
		DisableControlAction(0, 25)
		
		-- PASSAGGIO
		if IsDisabledControlJustPressed(0, LightKickBallKey) then 
			possoTirare = false
			SetEntityNoCollisionEntity(ped, prop, false)
			--[[ if IsPedRunning(ped) or IsPedSprinting(ped) then ]] if IsControlPressed(0, 21) then SetEntityVelocity(prop, forwardx * 8.5, forwardy * 8.5, 0)
			else SetEntityVelocity(prop, forwardx * 3, forwardy * 3, 0) end
			Citizen.Wait(100)
			possoTirare = true			
		-- TIRO FORTE
		elseif IsControlJustPressed(0, HardKickBallKey) then
			possoTirare = false
			SetEntityNoCollisionEntity(ped, prop, false)
			if IsControlPressed(0, 21) then 
				ExecuteCommand('e damn2')
				SetEntityVelocity(prop, forwardx * 30, forwardy * 30, 8.0)
			else
				SetEntityVelocity(prop, forwardx * 30, forwardy * 30, 2.0) 
			end
			Citizen.Wait(100)
			possoTirare = true
		-- RASO TERRA
		elseif IsControlJustPressed(0, 44) then
			possoTirare = false
			SetEntityNoCollisionEntity(ped, prop, false)
			if IsControlPressed(0, 21) then 
				SetEntityVelocity(prop, forwardx * 23, forwardy * 23, 1.0)
			else
				SetEntityVelocity(prop, forwardx * 9, forwardy * 9, 1.0) 
			end
			Citizen.Wait(100)
			possoTirare = true
		-- CROSS
		elseif IsControlJustPressed(0, LiftKickBallKey) then
			possoTirare = false
			SetEntityNoCollisionEntity(ped, prop, false)
			if not IsControlPressed(0, 21) then SetEntityVelocity(prop, forwardx * 12, forwardy * 12, 8.0)
			else SetEntityVelocity(prop, forwardx * 21, forwardy * 21, 16.0) end
			Citizen.Wait(100)
			possoTirare = true
		-- ALZALA
		elseif IsControlJustPressed(0, HeadbuttKey) then
			SetEntityNoCollisionEntity(ped, prop, false)
			if not IsControlPressed(0, 21) then SetEntityVelocity(prop, forwardx * 0.5, forwardy * 0.5, 4.0)
			else SetEntityVelocity(prop, forwardx * 4, forwardy * 4, 8.0) end
			Citizen.Wait(100)
			possoTirare = true
		-- STOP
		elseif IsDisabledControlJustPressed(0, 25) then
			possoTirare = false
			SetEntityNoCollisionEntity(ped, prop, false)
			local vel = GetEntityVelocity(prop)
			SetEntityVelocity(prop, vel.x/4, vel.y/4, 0)
			Citizen.Wait(300)
			possoTirare = true
		end
	end 
end	
end
end)

--[[
function CheckPallone(prop)
	if prop ~= mioPallone then 
		local pos = GetEntityCoords(prop)
		local vel = GetEntityVelocity(prop)
		local rot = GetEntityHeading(prop)
		TriggerServerEvent('leva:PALLA', vector3(pos.x,pos.y,pos.z), 'p_ld_soc_ball_01') 
		--SetEntityAsMissionEntity(prop)
		--DeleteEntity(prop)
		Citizen.Wait(300)
		local objPalla = CreateObject(GetHashKey("p_ld_soc_ball_01"), pos.x, pos.y, pos.z, rot, true, true, true)
		SetEntityLodDist(objPalla, 0xFFFF)
		SetEntityDynamic(objPalla, true)
		SetEntityRecordsCollisions(objPalla, true)
		SetEntityHasGravity(objPalla, true)
		FreezeEntityPosition(objPalla, false)
		SetEntityVelocity(objPalla, 0, 0, 0)
		SetEntityVelocity(objPalla, vel)
		SetModelAsNoLongerNeeded(GetHashKey("p_ld_soc_ball_01"))	
		mioPallone = objPalla
		print('check the ball: true ' .. objPalla)
		return objPalla
	end
	print('check the ball: false ' .. prop)
	return prop
end
]]

RegisterKey('keyboard', 'f10', function()
if ( IsPauseMenuActive() ) then return end
	ExecuteCommand('prendipalla')
end)

RegisterKey('keyboard', 'H', function()
if ( IsPauseMenuActive() ) then return end
	ExecuteCommand('parapalla')
end)

local pallaSospesa = false
RegisterCommand('parapalla', function()
	if not pallaSospesa then 
		ped = PlayerPedId()
		local position = GetEntityCoords(ped)
		local gate = nil

		gate = GetClosestObjectOfType(position, 2.0, GetHashKey("p_ld_soc_ball_01"), 0, 0, 0) 
		if gate ~= 0 and not IsEntityAttached(gate) then	
			local posGate = GetEntityCoords(gate)
			--ExecuteCommand('e pickup')
			pallaSospesa = true
			--Wait(700)
			SetEntityAsMissionEntity(gate)
			DeleteEntity(gate)
			--Wait(100)
			TriggerServerEvent('leva:PALLA', vector3(posGate.x, posGate.y, posGate.z), 'p_ld_soc_ball_01')
			Wait(500)
			ESX.ShowHelpNotification('Hai raccolto la palla, per lasciarla di nuovo premi ~INPUT_VEH_HEADLIGHT~ ~w~nuovamente.')
			ExecuteCommand('e palla2')
			--Wait(1000)
			--ExecuteCommand('e palla')
		end
	else
		ExecuteCommand('e c')
		Wait(100)
		ExecuteCommand('e pickup')
		Wait(700)
		ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		local heading = GetEntityHeading(ped)
		local forwardx = GetEntityForwardX(ped)
		local forwardy = GetEntityForwardY(ped)		
		local objPalla = CreateObject(GetHashKey("p_ld_soc_ball_01"), coords.x + (forwardx * 1), coords.y + (forwardy * 1), coords.z - 0.88, (heading - 180), true, true, true)
		SetEntityLodDist(objPalla, 500)
		SetEntityDynamic(objPalla, true)
		SetEntityRecordsCollisions(objPalla, true)
		SetEntityHasGravity(objPalla, true)
		FreezeEntityPosition(objPalla, false)
		SetEntityVelocity(objPalla, 0, 0, 0)
		SetModelAsNoLongerNeeded(GetHashKey("p_ld_soc_ball_01"))	
		ESX.ShowHelpNotification('~INPUT_DROP_AMMO~ Riprendi la palla in inventario~n~~INPUT_VEH_HEADLIGHT~ Prendi con le mani')
		ESX.ShowNotification('Non sai come giocare? Usa ~b~/calcio ~w~mentre sei vicino la palla.')
		TriggerServerEvent('esx_Pharmacy:Palla', objPalla)
		ExecuteCommand('e c')
		pallaSospesa = false
	end
end)

RegisterCommand('calcio', function()
	ped = PlayerPedId()
	local position = GetEntityCoords(ped)
	local gate = GetClosestObjectOfType(position, 2.5, GetHashKey("p_ld_soc_ball_01"), 0, 0, 0) 
	if gate ~= 0 then
		NetworkRequestControlOfEntity(gate)
		if GetEntitySpeed(gate) < 0.3 and not IsEntityAttached(gate) then
			ESX.ShowHelpNotification('Stai per imparare a giocare a calcio.')
			Wait(2500)
			ESX.ShowHelpNotification('La direzione del tiro sarà dove il tuo personaggio è rivolto.')
			Wait(5000)
			ESX.ShowHelpNotification('~INPUT_ATTACK~ Muovi Lentamente~n~~INPUT_ATTACK~ + ~INPUT_SPRINT~ ~w~Dribbling')
			Wait(20000)
			ESX.ShowHelpNotification('~INPUT_PICKUP~ + ~INPUT_SPRINT~ Pallonetto~n~~INPUT_PICKUP~ Palleggia')
			Wait(20000)
			ESX.ShowHelpNotification('~INPUT_RELOAD~ + ~INPUT_SPRINT~ Cross Alto~n~~INPUT_RELOAD~ Cross Basso')
			Wait(20000)
			ESX.ShowHelpNotification('~INPUT_VEH_DUCK~ + ~INPUT_SPRINT~ Tiro Forte Alto~n~~INPUT_VEH_DUCK~ Tiro Forte')
			Wait(20000)
			ESX.ShowHelpNotification('~INPUT_COVER~ + ~INPUT_SPRINT~ Passaggio Raso Terra~n~~INPUT_COVER~ Passaggio')
			Wait(9000)
			ESX.ShowHelpNotification('Sei pronto, allenati a giocare e partecipa ai migliori tornei della città.')			
		else
			if not IsEntityAttached(gate) then 
				ESX.ShowHelpNotification('Il pallone non sembra fermo~n~~INPUT_AIM~ Rallenta la palla')
			else
				ESX.ShowHelpNotification('Devi esserci un pallone a terra per questa operazione.')
			end
		end
	else
		ESX.ShowHelpNotification('Non sei vicino un pallone da calcio per imparare a giocare.')
		ExecuteCommand('e shrug')
	end
end)

local attesaPrendi = false
RegisterCommand('prendipalla', function()
	if attesaPrendi then return end
	attesaPrendi = true
	ped = PlayerPedId()
	local position = GetEntityCoords(ped)
	local gate = nil

	gate = GetClosestObjectOfType(position, 1.5, GetHashKey("p_ld_soc_ball_01"), 0, 0, 0) 
	if gate ~= 0 and not IsEntityAttached(gate) then
		if GetEntitySpeed(gate) < 0.5 then
			ESX.TriggerServerCallback('cavallo:totSelle', function(carb)
			if carb == 2 then	
				ESX.ShowNotification("Possiedi già il massimo di palloni in inventario.")
				return 
			end
			end, 'palla')
		
			local posGate = GetEntityCoords(gate)
			TaskTurnPedToFaceEntity(ped, gate, 1000)
			Wait(1000)
			ExecuteCommand('e pickup')
			Wait(700)
			SetEntityAsMissionEntity(gate)
			SetEntityAlpha(gate, 0)
			DeleteEntity(gate)
			Wait(100)
			TriggerServerEvent('FaCrashare:giveitem', 'palla', 1)
			TriggerServerEvent('leva:PALLA', vector3(posGate.x,posGate.y,posGate.z), 'p_ld_soc_ball_01')
			Wait(500)
			ExecuteCommand('e palla2')
			ESX.ShowHelpNotification('Hai raccolto la palla.')
			Wait(1000)
			ExecuteCommand('e palla')
			Wait(500)
			ExecuteCommand('e c')
			attesaPrendi = false
		else
			ESX.ShowHelpNotification('Il pallone non sembra fermo~n~~INPUT_AIM~ Rallenta la palla')
		end
	end
end)

--[[
local Portiere = false
RegisterCommand('portiere', function()
	ped = PlayerPedId()
	if Portiere then Portiere = false EnableTennisMode(ped, Portiere, Portiere) 
	else Portiere = true EnableTennisMode(ped, Portiere, Portiere) end
end)
]]

--[[
RegisterNetEvent('calcio:updatePalla')
AddEventHandler('calcio:updatePalla', function(oggetto)	
	local pallone = NetToObj(oggetto)
	mioPallone = pallone
end)
]]

--[[ SISTEMA MASCHERA (PER ORA DISABILITATO) ]]

--[[
bandana = false
lastmask = ''
local infoMask = false

RegisterNetEvent('itemcloth:maschera1')
AddEventHandler('itemcloth:maschera1', function()
	local ad = "missheist_agency2ahelmet" local ads = "mp_masks@standard_car@ds@" local player = PlayerPedId()
	loadAnimDict( ad ) loadAnimDict( ads )
	if not bandana then
		RequestAnimDict(dict) TaskPlayAnim( player, ads, "put_on_mask", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
		Wait (600) ClearPedSecondaryTask(PlayerPedId()) bandana = true
		--SetPedPropIndex(PlayerPedId(), 0, 14, 3, 2)
		SetPedComponentVariation(player, 1,	54,	1, 2)
		lastmask = 'maschera1'
		if not infoMask then infoMask = true ESX.ShowHelpNotification('~INPUT_CHARACTER_WHEEL~ + ~INPUT_DETONATE~ Utilizzo Rapido') end
	elseif bandana then
		bandana = false
		RequestAnimDict(dict) TaskPlayAnim( player, ad, "take_off_helmet_stand", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
		Wait (600) ClearPedSecondaryTask(PlayerPedId()) SetPedComponentVariation(player, 1,	0,	0, 2) --ClearPedProp(PlayerPedId(), 1, -1, 0, 2)
	end
end)

RegisterNetEvent('itemcloth:maschera2')
AddEventHandler('itemcloth:maschera2', function()
	local ad = "missheist_agency2ahelmet" local ads = "mp_masks@standard_car@ds@" local player = PlayerPedId()
	loadAnimDict( ad ) loadAnimDict( ads )
	if not bandana then
		RequestAnimDict(dict) TaskPlayAnim( player, ads, "put_on_mask", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
		Wait (600) ClearPedSecondaryTask(PlayerPedId()) bandana = true
		--SetPedPropIndex(PlayerPedId(), 0, 14, 3, 2)
		SetPedComponentVariation(player, 1,	37,	0, 2)
		lastmask = 'maschera2'		
		if not infoMask then infoMask = true ESX.ShowHelpNotification('~INPUT_CHARACTER_WHEEL~ + ~INPUT_DETONATE~ Utilizzo Rapido') end
	elseif bandana then
		bandana = false
		RequestAnimDict(dict) TaskPlayAnim( player, ad, "take_off_helmet_stand", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
		Wait (600) ClearPedSecondaryTask(PlayerPedId()) SetPedComponentVariation(player, 1,	0,	0, 2) --ClearPedProp(PlayerPedId(), 1, -1, 0, 2)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(25)
		if IsControlPressed(1, 47) and IsControlPressed(1, 19) then -- ALT G - ALT + G
			if lastmask ~= '' then 
				TriggerEvent('itemcloth:' .. lastmask)
				Citizen.Wait(1500)	
			else	
				ESX.ShowHelpNotification('Non è stata rilevata una maschera, indossane una da inventario prima di un utilizzo rapido.')
				Citizen.Wait(1500)	
			end
		else
			Citizen.Wait(1000)
		end
	end
end)
]]

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

--[[ RAPINA ALLE CASSE ]]
-- NOME CASSA OGGETTO: p_till_01_s
-- FUNZIONE DA COMPLETARE: GetLastDrivenVehicle

local CasseRapinate = { { x=0.0, y=0.0, z=0.0 } }
local stoRapinando = false
local RapinaBloccata = false
local posRapina = nil
local BottinoCassa = 0

local HashCassa = {
	'prop_till_03',
	'p_till_01_s', 
	'prop_till_01',
}

RegisterCommand('lastveh', function()
	local test = GetLastDrivenVehicle()
	local plate = ESX.Math.Trim(GetVehicleNumberPlateText(test))	
	local vehicleModel = GetDisplayNameFromVehicleModel(GetEntityModel(test))
	print('Last VEH: ' .. test .. ' ' .. plate .. ' ' .. vehicleModel)
end, false)

RegisterCommand('rapinacassa', function()
	ped = PlayerPedId()
	if stoRapinando then return end
	if RapinaBloccata then return end
	stoRapinando = true
	local position = GetEntityCoords(ped)
	local trovata = false
	
	for _, v in pairs(CasseRapinate) do
		--print('GESU ' .. v.x .. ' ' .. v.y .. ' ' .. v.z )
		if GetDistanceBetween(vector3(v.x, v.y, v.z)) < 1.0 then
			print('Cassa Trovata')
			trovata = true
		end
	end
	
	if trovata then 
		ESX.ShowHelpNotification('Questa cassa è vuota.')
		ExecuteCommand('e think5')
		Wait(5000)
		stoRapinando = false
	end
	
	local gate = nil
	
	for i=1, #HashCassa do
		gate = GetClosestObjectOfType(position, 1.5, GetHashKey(HashCassa[i]), 0, 0, 0)
		if gate ~= 0 then break end
	end
	
	if not IsPedArmed(ped, 4) and gate ~= 0 then ESX.ShowHelpNotification('Non sembri una minaccia per fare questo incarico.') ExecuteCommand('e no') stoRapinando = false return end
 	
	if gate ~= 0 and not trovata and IsPedArmed(ped, 4) then				
		local posCassa = GetOffsetFromEntityInWorldCoords(gate, 0.0, -1.0, -0.5)
		if GetDistanceBetween(posCassa) < 1.0 then
			--[[
			ESX.TriggerServerCallback('cavallo:totSelle', function(carb)
			if carb == 2 then	
				ESX.ShowNotification("Possiedi già il massimo di palloni in inventario.")
				return 
			end
			end, 'palla')
			]]
			
			SetCurrentPedWeapon(ped, -1569615261, true)
			TaskTurnPedToFaceEntity(ped, gate, 1000)
			Wait(1000)
			ExecuteCommand('e colpiscipp2')	
			Wait(700)
			PlaySoundFrontend(-1, "Falling_Crates", "EXILE_1", 1)
			Wait(1500)	
			ExecuteCommand('e ruba')
			ESX.ShowHelpNotification("Stai prendendo i soldi, non allontanarti e non annullare l'animazione.")
			BottinoCassa = 30
			ExecuteCommand('me sta rubando i soldi dalla cassa')
			Wait(3500)	
			posRapina = posCassa
	
			local pos = GetEntityCoords(ped)
			
			local test = GetLastDrivenVehicle()
			local VicinoVeicolo = false
			if test ~= 0 and test ~= nil then 
				local PosVeh = GetEntityCoords(test)
				if GetDistanceBetween(PosVeh) < 70.0 then
					VicinoVeicolo = true
				end
			end
			
			if test ~= 0 and test ~= nil and VicinoVeicolo then 
				local plate = ESX.Math.Trim(GetVehicleNumberPlateText(test))	
				local vehicleModel = GetDisplayNameFromVehicleModel(GetEntityModel(test))
				TriggerServerEvent("chekjobAnon", "Rapina negozio, veicolo sospetto: (" .. plate .. ') ' .. vehicleModel, pos)
			else
				TriggerServerEvent("chekjobAnon", "Rapina negozio in corso, nessun veicolo sospetto all'esterno.", pos)
			end	
			
			Wait(1500)	
			
			UpdateDammiSoldiCassa()
			CheckPosCassa()
			
			Wait(30000)
			if posRapina ~= nil then 
				ExecuteCommand('e c')
				table.insert(CasseRapinate, posCassa)
				TriggerServerEvent('rapinacasse:nuovacassa', posCassa) 
				stoRapinando = false
				ExecuteCommand('e backpack')
				Wait(500)
				posRapina = nil
				Wait(500)
				ESX.ShowHelpNotification('Sei riuscito a prendere un bottino di: ' .. BottinoCassa .. '~g~$~w~.')
				TriggerServerEvent('deruba:DammiSoldi', BottinoCassa)
				BottinoCassa = 0
			end
		end
	end	
end)

function CheckPosCassa()
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(25)
	if ped ~= nil then
		if posRapina ~= nil and stoRapinando then
			if GetDistanceBetween(posRapina) > 1.0 or not IsEntityPlayingAnim(ped, "oddjobs@shop_robbery@rob_till", "loop", 3) then
				ExecuteCommand('e c')
				stoRapinando = false
				posRapina = nil
				RapinaBloccata = true
				ESX.ShowHelpNotification("Ti sei allontanato dalla cassa o hai smesso di prendere i soldi, rapina annullata.")
				ExecuteCommand('e damn')
				Wait(60000)
				stoRapinando = false
				RapinaBloccata = false
			end
		else
			return 
		end
	end
	end
end)
end

function UpdateDammiSoldiCassa()
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
	if ped ~= nil then
		if posRapina ~= nil and stoRapinando then
			if GetDistanceBetween(posRapina) < 1.0 and IsEntityPlayingAnim(ped, "oddjobs@shop_robbery@rob_till", "loop", 3) then
				local guada = math.random(1,50)
				BottinoCassa = BottinoCassa + guada				
			end
		else
			return 
		end
	end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)	
		if posRapina ~= nil and stoRapinando then
			ESX.ShowHelpNotification('Bottino: ' .. BottinoCassa .. '~g~$~w~.')
		else
			return 
		end
	end
end)
end

RegisterNetEvent('rapinacasse:updatecasse')
AddEventHandler('rapinacasse:updatecasse', function(Casse)
	CasseRapinate = Casse
end)

RegisterNetEvent('rapina:updatecaserapinate')
AddEventHandler('rapina:updatecaserapinate', function(Case)

	for k, v in pairs(Case) do
		if v == 1 then 
			CASERapinate[k] = {x=0,y=0,z=0,h=0}
		end
	end

end)

--[[ NASCONDITI NEI CESTINI ]]
local HashCestini = {
	666561306,
	1511880420,
	-206690185,
	666561306,
	218085040,
	-58485588,
}

local possoNascondermi = true
local SonoInCestino = nil
RegisterCommand('nascondimi', function() NascondimiBidone() end)
RegisterCommand('nsm', function() NascondimiBidone() end)

function NascondimiBidone()
	ped = PlayerPedId()
	local position = GetEntityCoords(ped)
	local gate = nil
	
	if SonoInCestino == nil and possoNascondermi then 
		for i=1, #HashCestini do
			gate = GetClosestObjectOfType(position, 2.0, HashCestini[i], 0, 0, 0)
			if gate ~= 0 then break end
		end
		
		if gate ~= 0 then
			possoNascondermi = false
			local coordCestino = GetEntityCoords(gate)		
			local headCestino = GetEntityHeading(gate)			
			SetCurrentPedWeapon(ped, -1569615261, true)
			TaskTurnPedToFaceEntity(ped, gate, 1000)
			Wait(1000)
			ExecuteCommand('e mechanic4')
			FreezeEntityPosition(ped, true)
			Wait(2000)
			ExecuteCommand('e c')
			SonoInCestino = gate
			SetEntityCoords(ped, coordCestino)
			SetEntityHeading(ped, headCestino)
			ExecuteCommand('e sit5')
			BloccaTasti()
			ESX.ShowHelpNotification("~INPUT_VEH_DUCK~ Per uscire allo scoperto.")
			TriggerEvent('esx_status:add', 'stress', 5)	
			Wait(3000)
			possoNascondermi = true
		else
			ESX.ShowHelpNotification("Non sei vicino un oggetto dove poterti nascondere.")
			possoNascondermi = true
		end	
	else
		if SonoInCestino ~= nil then 
			local posCassa = GetOffsetFromEntityInWorldCoords(SonoInCestino, 0.0, -1.0, -0.5)
			local headCestino = GetEntityHeading(gate)
			FreezeEntityPosition(ped, false)
			SetEntityHeading(ped, headCestino-180)
			SetEntityCoords(ped, posCassa)
			ExecuteCommand('e c')
			Wait(500)
			ExecuteCommand('e shakeoff')
			ExecuteCommand('me si pulisce dai rifiuti')
			ExecuteCommand('do emana cattivo odore')
			SonoInCestino = nil
			Wait(3000)
			possoNascondermi = true
		else
			possoNascondermi = true
		end
	end
end

function BloccaTasti()
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)	
		if SonoInCestino ~= nil then
			if IsControlPressed(0,73) then 
				ExecuteCommand('nascondimi')
				Citizen.Wait(1000)	
				return 
			end
		else
			return 
		end
	end
end)
end

-- ESEMPIO NH KEYBOARD
--[[
local scene = exports["nh-keyboard"]:KeyboardInput({
header = "Add Scene",
rows = {
{ id = 0, txt = "Message" },
{ id = 1, txt = "Color {white, red, blue, green, yellow}" },
{ id = 2, txt = "Distance {1.1 - 10.0}" }, 
}
})
if scene[1].input == nil then return end
local message = scene[1].input
local color = scene[2].input
local distance = tonumber(scene[3].input)
]]

-- TACKLE - SPINTONE
local TackleKey = 19 -- Change to a number which can be found here: https://wiki.fivem.net/wiki/Controls
local TackleTime = 2500 -- In milliseconds

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
	if ped ~= nil then
		
		--print('speed: ' .. GetEntitySpeed(ped))
		
		local maxhealth = GetEntityMaxHealth(ped) 	
		local var1 = maxhealth * 150 / 200
		if IsControlPressed(0, TackleKey) and IsControlPressed(0, 21) and GetEntitySpeed(ped) > 0.1 and not IsPedRagdoll(ped) and GetEntityHealth(ped) >= var1 and GetEntityHealth(ped) > 0 and not IsEntityDead(ped) and not IsPedDeadOrDying(ped, 1) then
			TriggerEvent('esx_status:getStatus', 'stress', function(status)
				if status.val < 70 then 			
					if IsPedInAnyVehicle(ped) then
						--TriggerEvent('chatMessage', 'Tackle', {255, 255, 255}, 'You cannot tackle someone in a vehicle')
					else
						if not IsPedFalling(ped) then 
							local ForwardVector = GetEntityForwardVector(ped)
							local Tackled = {}
							ExecuteCommand('e beast')
							Citizen.Wait(500)
							SetPedToRagdollWithFall(ped, 100, 100, 0, ForwardVector, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
							
							--[[
								local prevVelocity = GetEntityVelocity(ped)
								SetEntityVelocity(ped, 0.0, 0.0, prevVelocity.z*1.5) 
								SetEntityVelocity(ped, prevVelocity.x*1.5, prevVelocity.y*1.5, 0.0)
							]]

							while IsPedRagdoll(ped) do
								Citizen.Wait(0)
								local Value = GetTouchedPlayers()
								if Value ~= nil and Value ~= 0 then
									if not Tackled[Value] and not IsPedRagdoll(GetPlayerPed(Value)) then
										Tackled[Value] = true
										TriggerServerEvent('Tackle:Server:TacklePlayer', GetPlayerServerId(Value), ForwardVector.x, ForwardVector.y, ForwardVector.z, GetPlayerName(PlayerId()))
										Citizen.Wait(1000)
									end
								end
							end
						end
					end -- fine check veicolo
				else
					ESX.ShowNotification('Sei troppo stressato per fare uno spintone.')
					ExecuteCommand('e facepalm3')
					Citizen.Wait(2000)
					ExecuteCommand('e c ')
				end
			end)
			Citizen.Wait(2500)
		else
			Citizen.Wait(500)
		end
	end
	end
end)

-- Tackel / Tackle
RegisterNetEvent('Tackle:Client:TacklePlayer')
AddEventHandler('Tackle:Client:TacklePlayer', function(ForwardVectorX, ForwardVectorY, ForwardVectorZ, Tackler)
	if Tackler ~= PlayerPedId() then
		ESX.ShowNotification('Hai ricevuto uno spintone.')
		SetPedToRagdollWithFall(PlayerPedId(), TackleTime, TackleTime, 0, ForwardVectorX, ForwardVectorY, ForwardVectorZ, 10.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
	end
end)

function GetPlayers()
    local players = {}

	for _, i in ipairs(GetActivePlayers()) do
        table.insert(players, i)
    end

    return players
end

function GetTouchedPlayers()
    local TouchedPlayer
    for Key, Value in ipairs(GetPlayers()) do
		if IsEntityTouchingEntity(PlayerPedId(), GetPlayerPed(Value)) then
			TouchedPlayer = Value
		end
    end
    return TouchedPlayer
end

-- NASCONDITI NEL COFANO
local mexBaule = false
local possoBaule = true
RegisterCommand("nascondibaule", function(source)
	local vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 5.0, 0, 70)
	if vehicle == 0 or vehicle == nil then ESX.ShowNotification('Nessun veicolo nelle vicinanze per nasconderti nel baule.') return end
	if not inTrunk then
		if not possoBaule then return end
		possoBaule = false
		local player = ESX.Game.GetClosestPlayer()
		local playerPed = GetPlayerPed(player)
		local playerPed2 = PlayerPedId()
		--local retval = GetIsVehicleEngineRunning(vehicle)
		--if retval then 
			if DoesEntityExist(playerPed) then
				if not IsEntityAttached(playerPed) or GetDistanceBetweenCoords(GetEntityCoords(playerPed), GetEntityCoords(PlayerPedId()), true) >= 5.0 then
					SetCarBootOpen(vehicle)
					Wait(350)
					AttachEntityToEntity(PlayerPedId(), vehicle, -1, 0.0, -2.2, 0.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)	
					loadDict('timetable@floyd@cryingonbed@base')
					TaskPlayAnim(PlayerPedId(), 'timetable@floyd@cryingonbed@base', 'base', 8.0, -8.0, -1, 1, 0, false, false, false)
					Wait(50)
					inTrunk = true
					Wait(1500)
					SetVehicleDoorShut(vehicle, 5)
					SetEntityVisible(PlayerPedId(), false, false)
					SetEntityCollision(PlayerPedId(), false, false)
					if not mexBaule then mexBaule = true ESX.ShowNotification('Ti sei nascosto nel baule, per uscire usa ~b~/escibaule~w~.') end
					
				else
					ESX.ShowNotification('Sembra esserci già qualcuno nel baule.')
				end
			end
		--else
		--	ESX.ShowNotification('Il motore del veicolo deve essere acceso.')
		--end
		Wait(500)
		possoBaule = true
	end
end)

loadDict = function(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
end

RegisterCommand("escibaule", function(source)
	if not possoBaule then return end
	possoBaule = false
	ped = PlayerPedId()
	local vehicle = GetEntityAttachedTo(ped)
	if inTrunk then
		local coord = GetEntityCoords(vehicle)
		if DoesEntityExist(vehicle) or not IsPedDeadOrDying(ped) or not IsPedFatallyInjured(ped) then
			SetCarBootOpen(vehicle)
			SetEntityCollision(ped, true, true)
			SetEntityVisible(ped, true, false)
			Wait(1750)
			inTrunk = false
			DetachEntity(ped, true, true)
			ClearPedTasks(ped)
			SetEntityCoords(ped, GetOffsetFromEntityInWorldCoords(ped, 0.0, -0.5, -0.75))
			Wait(250)
			SetVehicleDoorShut(vehicle, 5)	
			Wait(500)
			--TaskJump(ped, true, false, false) -- Funziona
			RequestCollisionAtCoord(coord.x,coord.y,coord.z)
			Wait(2000)
			possoBaule = true		
		else
			SetEntityCollision(ped, true, true)
			DetachEntity(ped, true, true)
			SetEntityVisible(ped, true, false)
			ClearPedTasks(ped)
			SetEntityCoords(ped, GetOffsetFromEntityInWorldCoords(ped, 0.0, -0.5, -0.75))
			inTrunk = false
			possoBaule = true
		end
	end
end)

RegisterCommand("bj", function(source)
	ExecuteCommand('e cpr')
	Wait(100)
	ExecuteCommand('e drink2')
end)

-- FAX-LOGO
AddEventHandler('onClientMapStart', function()
  Citizen.CreateThread(function()
    local display = true
    TriggerEvent('logo:display', true)
  end)
end)

RegisterNetEvent('logo:display')
AddEventHandler('logo:display', function(value)
  SendNUIMessage({
    type = "logo",
    display = value
  })
end)

function ShowInfo(text, state)
  SetTextComponentFormat("STRING")
  AddTextComponentString(text)
  DisplayHelpTextFromStringLabel(0, state, 0, -1)
end

local inPausa = false
local F10premuto = false

-- Voice detection and distance
Citizen.CreateThread(function()
while true do
	Citizen.Wait(7)
	
	--[[
	if IsControlJustReleased(0, 57) then
		if F10premuto then
			F10premuto = false
			TriggerEvent('logo:display', true)
		else
			F10premuto = true
			TriggerEvent('logo:display', false)
		end
	end
	]]
	
	if IsPauseMenuActive() then 
		if not inPausa then
		inPausa = true
		TriggerEvent('logo:display', false)
		end
	else
		if inPausa then
		TriggerEvent('logo:display', true)
		inPausa = false
		end
	end
	
	HideHudComponentThisFrame(7) -- Area
	HideHudComponentThisFrame(9) -- Street
	HideHudComponentThisFrame(6) -- Vehicle
	HideHudComponentThisFrame(3) -- SP Cash
	HideHudComponentThisFrame(4) -- MP Cash
	HideHudComponentThisFrame(13) -- Cash changes!			
	--HideHudComponentThisFrame(1)  -- Wanted Stars
	HideHudComponentThisFrame(2)  -- Weapon Icon
	HideHudComponentThisFrame(6)  -- Vehicle Name
	HideHudComponentThisFrame(8)  -- Vehicle Class
	HideHudComponentThisFrame(9)  -- Street Name
	HideHudComponentThisFrame(17) -- Save Game
	HideHudComponentThisFrame(20) -- Weapon Stats
end
end)

--Recoil At speeds by Anthony.#8754
Citizen.CreateThread(function()
while true do 
	Citizen.Wait(0)
	
	--[[
	DEATH_FAIL_IN_EFFECT_SHAKE  
	DRUNK_SHAKE  
	FAMILY5_DRUG_TRIP_SHAKE  
	HAND_SHAKE  
	JOLT_SHAKE  
	LARGE_EXPLOSION_SHAKE  
	MEDIUM_EXPLOSION_SHAKE  
	SMALL_EXPLOSION_SHAKE  
	ROAD_VIBRATION_SHAKE  
	SKY_DIVING_SHAKE  
	VIBRATE_SHAKE 
	]]
	
	local playerPed = GetPlayerPed(-1)
	local veh = GetVehiclePedIsIn(PlayerPedId(), false)
	local speed = GetEntitySpeed(playerPed)

	local current_mph =math.floor(speed * 2.23694 + 0.5)
	if DoesEntityExist(veh) and IsPedShooting(playerPed) and not IsEntityDead(veh) then
		if current_mph >= 10 then
			ShakeGameplayCam('JOLT_SHAKE', 0.2)
		end
		if current_mph >= 40 then
			ShakeGameplayCam('JOLT_SHAKE', 0.4)
		end
		if current_mph >= 60 then
			ShakeGameplayCam('JOLT_SHAKE', 0.6)
		end
		if current_mph >= 80 then
			ShakeGameplayCam('JOLT_SHAKE', 0.8)
		end
		if current_mph >= 100 then
			ShakeGameplayCam('JOLT_SHAKE', 1.9)
		end
	else
		Citizen.Wait(1500)
	end
end
end)