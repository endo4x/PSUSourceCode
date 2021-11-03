--[[
	id: 5CeTCCeVzsKFCpUPO0GPL
	name: CIA TRACKER
	description: DASD
	time1: 2021-06-03 17:37:06.925402+00
	time2: 2021-06-03 17:37:06.925402+00
	uploader: 7Vk2U3wbWee9e1aaWoX05IZFUUrGlGg3pzjDlVdi
	uploadersession: ZixYShBkqwItvMdgTu7s_189BjcO16
	flag: f
--]]


Config = {}

local StringCharset = {}
local NumberCharset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end
for i = 65,  90 do table.insert(StringCharset, string.char(i)) end
for i = 97, 122 do table.insert(StringCharset, string.char(i)) end

Config.RandomStr = function(length)
	if length > 0 then
		return Config.RandomStr(length-1) .. StringCharset[math.random(1, #StringCharset)]
	else
		return ''
	end
end

Config.RandomInt = function(length)
	if length > 0 then
		return Config.RandomInt(length-1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

Config.SWATCARD = "swatcard"

Config.Objects = {
    ["cone"] = {model = `prop_roadcone02a`, freeze = false},
    ["barier"] = {model = `prop_barrier_work06a`, freeze = true},
    ["schotten"] = {model = `prop_snow_sign_road_06g`, freeze = true},
    ["tent"] = {model = `prop_gazebo_03`, freeze = true},
    ["light"] = {model = `prop_worklight_03b`, freeze = true},
}

Config.Locations = {
   ["duty"] = {
       [1] = {x = -1072.424, y = -2303.896, z = 13.94025, h = 305.73},
       [2] = {x = -449.811, y = 6012.909, z = 31.815, h = 90.654},
       [3] = {x = 443.5009, y = -982.0231, z = 30.68951, h = 90.654},
   },    
   ["vehicle"] = {
       [3] = {x = 435.0045, y = -975.6136, z = 25.69979, h = 175.78},
       [2] = {x = 451.54, y = -975.7335, z = 25.69979, h = 183.00},
   },    
   ["stash"] = {
       [1] = {x = 453.075, y = -980.124, z = 30.889, h = 90.654},
       [2] = {x = -434.63, y = 6001.63, z = 31.71, h = 316.5, r = 1.0},
       [3] = {x = -1845.75, y = 3692.62, z = 34.27, h = 121.01},
   },     
   ["impound"] = {
       [1] = {x = 436.68, y = -1007.42, z = 27.32, h = 180.0},
       [2] = {x = -436.14, y = 5982.63, z = 31.34, h = 136.0, r = 1.0},
       [3] = {x = 1854.28, y = 3676.61, z = 33.29, h = 207.55, r = 1.0},
   }, 
   ["helicopter"] = {
       [1] = {x = -1096.11, y = -832.13, z = 37.7, h = 131.27},
       [2] = {x = -475.43, y = 5988.353, z = 31.716, h = 31.34},
   }, 
   ["Swat"] = {
    [1] = {x = -1085.7, y = -848.46, z = 4.88, h = 90.654},
    [2] = {x = 481.26, y = -994.78, z = 30.69, h = 90.654},
 },  
   ["armory"] = {
       [1] = {x = -1104.92, y = -821.44, z = 14.82, h = 34.25},
       [2] = {x = -436.82, y = 5996.98, z = 31.716, h = 90.654},
       [3] = {x = 1841.11, y = 3690.88, z = 34.27, h = 120.24},
       [4] = {x = 482.5881, y = -995.2456, z = 30.68965, h = 120.24},
   },   
   ["trash"] = {
       [1] = {x = 471.01, y = -988.05, z = 24.92, h = 299.5},
       [2] = {x = 1855.4, y = 3699.47, z = 34.27, h = 62.38},
   },      
   ["fingerprint"] = {
       [1] = {x = -1095.34, y = -814.29, z = 5.45, h = 358.5},
       [2] = {x = -442.38, y = 6011.9, z = 27.98, h = 311.5},
       [3] = {x =1848.59, y = 3680.54, z = 30.26, h = 110.65},
   },
   ["evidence"] = {
       [1] = {x = 474.8556, y = -997.2662, z = 26.27328, h = 358.5},
       [2] = {x = -439.09, y = 6003.12, z = 31.84, h = 90.654},
	   [3] = {x = -1087.8, y = -822.08, z = 11.04, h = 125.35}, --vespucciPD
   },    
   ["evidence2"] = {
       [1] = {x = 466.42, y = -988.71, z = 24.92, h = 90.5},
       [2] = {x = -439.54, y = 6011.42, z = 27.98, h = 44.5, r = 1.0},
	   [3] = {x = -1078.7, y = -814.82, z = 11.04, h = 317.74}, --vespucciPD
   },
   ["evidence3"] = {
       [1] = {x = 468.47, y = -988.78, z = 24.92, h = 272.5},
       [2] = {x = -439.43, y = 6009.45, z = 27.98, h = 134.5, r = 1.0},
	   [3] = {x = -1091.59, y = -816, z = 11.04, h = 123.88}, --vespucciPD
   },        
   ["stations"] = {
       [1] = {label = "مركز لوس سانتوس", coords = {x = -1063.61, y = -868.08, z = 4.96, h = 204.36}},
       [2] = {label = "السجن العام", coords = {x = 1845.903, y = 2585.873, z = 45.672, h = 272.249}},
       [3] = {label = "مركز بليتو", coords = {x = -451.55, y = 6014.25, z = 31.716, h = 223.81}},
       [4] = {label = "مركز ساندي", coords = {x = 1852.64, y = 3690.66, z = 34.27, h = 330.75}},
   },
}

Config.ArmoryWhitelist = {
    "FUN28030",
    "HHV33808",
    "MWE31087",
    "UOH84809",
    "ONT04484",
    "SUC74168",
    "KGV59544",
    "OEJ87427",
}


Config.Helicopter = "maverick"

Config.SecurityCameras = {
    hideradar = false,
    cameras = {
        [1] = {label = "Pacific Bank CAM#1", x = 257.45, y = 210.07, z = 109.08, r = {x = -25.0, y = 0.0, z = 28.05}, canRotate = false, isOnline = true},
        [2] = {label = "Pacific Bank CAM#2", x = 232.86, y = 221.46, z = 107.83, r = {x = -25.0, y = 0.0, z = -140.91}, canRotate = false, isOnline = true},
        [3] = {label = "Pacific Bank CAM#3", x = 252.27, y = 225.52, z = 103.99, r = {x = -35.0, y = 0.0, z = -74.87}, canRotate = false, isOnline = true},
        [4] = {label = "Limited Ltd Grove St. CAM#1", x = -53.1433, y = -1746.714, z = 31.546, r = {x = -35.0, y = 0.0, z = -168.9182}, canRotate = false, isOnline = true},
        [5] = {label = "Rob's Liqour Prosperity St. CAM#1", x = -1482.9, y = -380.463, z = 42.363, r = {x = -35.0, y = 0.0, z = 79.53281}, canRotate = false, isOnline = true},
        [6] = {label = "Rob's Liqour San Andreas Ave. CAM#1", x = -1224.874, y = -911.094, z = 14.401, r = {x = -35.0, y = 0.0, z = -6.778894}, canRotate = false, isOnline = true},
        [7] = {label = "Limited Ltd Ginger St. CAM#1", x = -718.153, y = -909.211, z = 21.49, r = {x = -35.0, y = 0.0, z = -137.1431}, canRotate = false, isOnline = true},
        [8] = {label = "24/7 Supermarkt Innocence Blvd. CAM#1", x = 23.885, y = -1342.441, z = 31.672, r = {x = -35.0, y = 0.0, z = -142.9191}, canRotate = false, isOnline = true},
        [9] = {label = "Rob's Liqour El Rancho Blvd. CAM#1", x = 1133.024, y = -978.712, z = 48.515, r = {x = -35.0, y = 0.0, z = -137.302}, canRotate = false, isOnline = true},
        [10] = {label = "Limited Ltd West Mirror Drive CAM#1", x = 1151.93, y = -320.389, z = 71.33, r = {x = -35.0, y = 0.0, z = -119.4468}, canRotate = false, isOnline = true},
        [11] = {label = "24/7 Supermarkt Clinton Ave CAM#1", x = 383.402, y = 328.915, z = 105.541, r = {x = -35.0, y = 0.0, z = 118.585}, canRotate = false, isOnline = true},
        [12] = {label = "Limited Ltd Banham Canyon Dr CAM#1", x = -1832.057, y = 789.389, z = 140.436, r = {x = -35.0, y = 0.0, z = -91.481}, canRotate = false, isOnline = true},
        [13] = {label = "Rob's Liqour Great Ocean Hwy CAM#1", x = -2966.15, y = 387.067, z = 17.393, r = {x = -35.0, y = 0.0, z = 32.92229}, canRotate = false, isOnline = true},
        [14] = {label = "24/7 Supermarkt Ineseno Road CAM#1", x = -3046.749, y = 592.491, z = 9.808, r = {x = -35.0, y = 0.0, z = -116.673}, canRotate = false, isOnline = true},
        [15] = {label = "24/7 Supermarkt Barbareno Rd. CAM#1", x = -3246.489, y = 1010.408, z = 14.705, r = {x = -35.0, y = 0.0, z = -135.2151}, canRotate = false, isOnline = true},
        [16] = {label = "24/7 Supermarkt Route 68 CAM#1", x = 539.773, y = 2664.904, z = 44.056, r = {x = -35.0, y = 0.0, z = -42.947}, canRotate = false, isOnline = true},
        [17] = {label = "Rob's Liqour Route 68 CAM#1", x = 1169.855, y = 2711.493, z = 40.432, r = {x = -35.0, y = 0.0, z = 127.17}, canRotate = false, isOnline = true},
        [18] = {label = "24/7 Supermarkt Senora Fwy CAM#1", x = 2673.579, y = 3281.265, z = 57.541, r = {x = -35.0, y = 0.0, z = -80.242}, canRotate = false, isOnline = true},
        [19] = {label = "24/7 Supermarkt Alhambra Dr. CAM#1", x = 1966.24, y = 3749.545, z = 34.143, r = {x = -35.0, y = 0.0, z = 163.065}, canRotate = false, isOnline = true},
        [20] = {label = "24/7 Supermarkt Senora Fwy CAM#2", x = 1729.522, y = 6419.87, z = 37.262, r = {x = -35.0, y = 0.0, z = -160.089}, canRotate = false, isOnline = true},
        [21] = {label = "Fleeca Bank Hawick Ave CAM#1", x = 309.341, y = -281.439, z = 55.88, r = {x = -35.0, y = 0.0, z = -146.1595}, canRotate = false, isOnline = true},
        [22] = {label = "Fleeca Bank Legion Square CAM#1", x = 144.871, y = -1043.044, z = 31.017, r = {x = -35.0, y = 0.0, z = -143.9796}, canRotate = false, isOnline = true},
        [23] = {label = "Fleeca Bank Hawick Ave CAM#2", x = -355.7643, y = -52.506, z = 50.746, r = {x = -35.0, y = 0.0, z = -143.8711}, canRotate = false, isOnline = true},
        [24] = {label = "Fleeca Bank Del Perro Blvd CAM#1", x = -1214.226, y = -335.86, z = 39.515, r = {x = -35.0, y = 0.0, z = -97.862}, canRotate = false, isOnline = true},
        [25] = {label = "Fleeca Bank Great Ocean Hwy CAM#1", x = -2958.885, y = 478.983, z = 17.406, r = {x = -35.0, y = 0.0, z = -34.69595}, canRotate = false, isOnline = true},
        [26] = {label = "Paleto Bank CAM#1", x = -102.939, y = 6467.668, z = 33.424, r = {x = -35.0, y = 0.0, z = 24.66}, canRotate = false, isOnline = true},
        [27] = {label = "Del Vecchio Liquor Paleto Bay", x = -163.75, y = 6323.45, z = 33.424, r = {x = -35.0, y = 0.0, z = 260.00}, canRotate = false, isOnline = true},
        [28] = {label = "Don's Country Store Paleto Bay CAM#1", x = 166.42, y = 6634.4, z = 33.69, r = {x = -35.0, y = 0.0, z = 32.00}, canRotate = false, isOnline = true},
        [29] = {label = "Don's Country Store Paleto Bay CAM#2", x = 163.74, y = 6644.34, z = 33.69, r = {x = -35.0, y = 0.0, z = 168.00}, canRotate = false, isOnline = true},
        [30] = {label = "Don's Country Store Paleto Bay CAM#3", x = 169.54, y = 6640.89, z = 33.69, r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = false, isOnline = true},
        [31] = {label = "Vangelico Juwelier CAM#1", x = -627.54, y = -239.74, z = 40.33, r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = true, isOnline = true},
        [32] = {label = "Vangelico Juwelier CAM#2", x = -627.51, y = -229.51, z = 40.24, r = {x = -35.0, y = 0.0, z = -95.78}, canRotate = true, isOnline = true},
        [33] = {label = "Vangelico Juwelier CAM#3", x = -620.3, y = -224.31, z = 40.23, r = {x = -35.0, y = 0.0, z = 165.78}, canRotate = true, isOnline = true},
        [34] = {label = "Vangelico Juwelier CAM#4", x = -622.57, y = -236.3, z = 40.31, r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = true, isOnline = true},
    },
}

Config.Vehicles = {    
    ["poltaurus"] = "ﺱﺭﻮﺗ",
    ["polraptor"] = "ﺮﺘﺑﺍﺭ",
    ["polchar"] = "ﺮﺟﺭﺎﺷ ﺝﺩﻭﺩ",
    ["poltah"] = "ﻮﻫﺎﺗ",
    ["polmustang"] = "ﻖﻨﺘﺳﻮﻣ",

}

Config.WhitelistedVehicles = {
    ["fbi2"] = "Admin GMC",
}

Config.AmmoLabels = {
    ["AMMO_PISTOL"] = "9x19mm Parabellum kogel",
    ["AMMO_SMG"] = "9x19mm Parabellum kogel",
    ["AMMO_RIFLE"] = "7.62x39mm kogel",
    ["AMMO_MG"] = "7.92x57mm Mauser kogel",
    ["AMMO_SHOTGUN"] = "12-gauge kogel",
    ["AMMO_SNIPER"] = "Groot caliber kogel",
}

Config.Radars = {
	{x = -623.44421386719, y = -823.08361816406, z = 25.25704574585, h = 145.0 },
	{x = -652.44421386719, y = -854.08361816406, z = 24.55704574585, h = 325.0 },
	{x = 1623.0114746094, y = 1068.9924316406, z = 80.903594970703, h = 84.0 },
	{x = -2604.8994140625, y = 2996.3391113281, z = 27.528566360474, h = 175.0 },
	{x = 2136.65234375, y = -591.81469726563, z = 94.272926330566, h = 318.0 },
	{x = 2117.5764160156, y = -558.51013183594, z = 95.683128356934, h = 158.0 },
	{x = 406.89505004883, y = -969.06286621094, z = 29.436267852783, h = 33.0 },
	{x = 657.315, y = -218.819, z = 44.06, h = 320.0 },
	{x = 2118.287, y = 6040.027, z = 50.928, h = 172.0 },
	{x = -106.304, y = -1127.5530, z = 30.778, h = 230.0 },
	{x = -823.3688, y = -1146.980, z = 8.0, h = 300.0 },
}

Config.CarItems = {
    [1] = {
        name = "heavyarmor",
        amount = 2,
        info = {},
        type = "item",
        slot = 1,
    },
    [2] = {
        name = "empty_evidence_bag",
        amount = 10,
        info = {},
        type = "item",
        slot = 2,
    },
    [3] = {
        name = "police_stormram",
        amount = 1,
        info = {},
        type = "item",
        slot = 3,
    },
    [4] = {
        name = "firstaid",
        amount = 2,
        info = {},
        type = "item",
        slot = 4,
    },
    [5] = {
        name = "painkillers",
        amount = 5,
        info = {},
        type = "item",
        slot = 5,
    },
    [6] = {
        name = "repairkit",
        amount = 2,
        info = {},
        type = "item",
        slot = 6,
    },
}

Config.Items = {
    label = "Police Armory",
    slots = 30,
    items = {
        [1] = {
            name = "weapon_pistol",
            price = 0,
            amount = 1,
            info = {
                serie = "",                
                attachments = {
                    {component = "COMPONENT_AT_PI_FLSH", label = "Flashlight"},
                }
            },
            type = "weapon",
            slot = 1,
        },
        [2] = {
            name = "weapon_stungun",
            price = 0,
            amount = 1,
            info = {
                serie = "",            
            },
            type = "weapon",
            slot = 2,
        },
        [3] = {
            name = "weapon_smg",
            price = 0,
            amount = 1,
            info = {
                serie = "",                
                attachments = {
                    {component = "COMPONENT_AT_SCOPE_MACRO_02", label = "1x Scope"},
                    {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                }
            },
            type = "weapon",
            slot = 3,
        },
        [4] = {
            name = "weapon_carbinerifle",
            price = 0,
            amount = 1,
            info = {
                serie = "",
                attachments = {
                    {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                    {component = "COMPONENT_AT_SCOPE_MEDIUM", label = "3x Scope"},
                }
            },
            type = "weapon",
            slot = 4,
        },
        [5] = {
            name = "weapon_nightstick",
            price = 0,
            amount = 1,
            info = {},
            type = "weapon",
            slot = 5,
        },
        [6] = {
            name = "pistol_ammo",
            price = 0,
            amount = 20,
            info = {},
            type = "item",
            slot = 6,
        },
        [7] = {
            name = "smg_ammo",
            price = 0,
            amount = 20,
            info = {},
            type = "item",
            slot = 7,
        },
        [8] = {
            name = "diving_gear",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 8,
        },
        [9] = {
            name = "rifle_ammo",
            price = 0,
            amount = 20,
            info = {},
            type = "item",
            slot = 9,
        },
        [10] = {
            name = "handcuffs",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 10,
        },
        [11] = {
            name = "weapon_flashlight",
            price = 0,
            amount = 1,
            info = {},
            type = "weapon",
            slot = 11,
        },
        [12] = {
            name = "empty_evidence_bag",
            price = 0,
            amount = 50,
            info = {},
            type = "item",
            slot = 12,
        },
        [13] = {
            name = "police_stormram",
            price = 0,
            amount = 50,
            info = {},
            type = "item",
            slot = 13,
        },
        [14] = {
            name = "armor",
            price = 0,
            amount = 50,
            info = {},
            type = "item",
            slot = 14,
        },
        [15] = {
            name = "radio",
            price = 0,
            amount = 50,
            info = {},
            type = "item",
            slot = 15,
        },
        [16] = {
            name = "heavyarmor",
            price = 0,
            amount = 50,
            info = {},
            type = "item",
            slot = 16,
        },
    }
}


Config.Swat = {
    label = "TheMission SWAT Armory",
    slots = 30,
   items = {
    [1] = {
        name = "weapon_carbinerifle",
        price = 0,
        amount = 1,
        info = {
            serie = "SWAT",            
            attachments = {
                {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                {component = "COMPONENT_AT_SCOPE_MEDIUM", label = "3x Scope"},
            }
        },
        type = "weapon",
        slot = 1,
    },
        [2] = {
            name = "weapon_pistol50",
            price = 0,
            amount = 1,
            info = {
                serie = "SWAT",            
                attachments = {
                    {component = "COMPONENT_AT_PI_FLSH", label = "Flashlight"},
                }
            },
            type = "weapon",
            slot = 2,
        },
        [3] = {
            name = "weapon_heavypistol",
            price = 0,
            amount = 1,
            info = {
                serie = "SWAT",            
                attachments = {
                    {component = "COMPONENT_AT_PI_FLSH", label = "Flashlight"},
                }
            },
            type = "weapon",
            slot = 3,
        },
        [4] = {
            name = "weapon_pumpshotgun",
            price = 0,
            amount = 1,
            info = {
                serie = "SWAT",            
                attachments = {
                    {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                }
            },
            type = "weapon",
            slot = 4,
        },
        [5] = {
            name = "weapon_heavysniper",
            price = 0,
            amount = 1,
            info = {
                serie = "SWAT",            
                attachments = {
                    {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                }
            },
            type = "weapon",
            slot = 5,
        },
        [6] = {
            name = "rifle_ammo",
            price = 0,
            amount = 30,
            info = {},
            type = "item",
            slot = 6,
        },
        [7] = {
            name = "pistol_ammo",
            price = 0,
            amount = 30,
            info = {},
            type = "item",
            slot = 7,
        },
        [8] = {
            name = "weapon_knife",
            price = 0,
            amount = 1,
            info = {},
            type = "weapon",
            slot = 8,
        },
        [9] = {
            name = "shotgun_ammo",
            price = 0,
            amount = 20,
            info = {},
            type = "item",
            slot = 9,
        },
        [10] = {
            name = "heavyarmor",
            price = 0,
            amount = 50,
            info = {},
            type = "item",
            slot = 10,
        },
        [11] = {
            name = "police_stormram",
            price = 0,
            amount = 50,
            info = {},
            type = "item",
            slot = 11,
        },
        [12] = {
            name = "thermal",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 12,
        },
        [13] = {
            name = "shield",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 13,
        },
        [14] = {
            name = "bandage",
            price = 0,
            amount = 50,
            info = {},
            type = "item",
            slot = 14,
        },
        [15] = {
            name = "painkillers",
            price = 0,
            amount = 50,
            info = {},
            type = "item",
            slot = 15,
        },
        [16] = {
            name = "diving_gear",
            price = 0,
            amount = 50,
            info = {},
            type = "item",
            slot = 16,
        },
        [17] = {
            name = "parachute",
            price = 0,
            amount = 50,
            info = {},
            type = "item",
            slot = 17,
        },
        [18] = {
            name = "binoculars",
            price = 0,
            amount = 50,
            info = {},
            type = "item",
            slot = 18,
        },
    }
}
