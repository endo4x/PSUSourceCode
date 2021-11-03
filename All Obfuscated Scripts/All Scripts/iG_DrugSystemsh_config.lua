--[[
	id: Ad3EY0QLKXpRhSwKMxbTB
	name: iG_DrugSystem (sh_config)
	description: iG_DrugSystem (sh_config)
	time1: 2021-05-18 08:15:13.95644+00
	time2: 2021-05-18 08:15:13.956441+00
	uploader: bTsSRni5qcY4hZaaTNjKGsQxVWCKNYtH90BPxpMa
	uploadersession: 43aYLc5iYf7j6R0rKItTrW7t06NBBD
	flag: f
--]]

Config = {}

Config.DrawDistance = 5.0
Config.Debug = false
Config.Drugs = {

    ---------------------------------------------------
    ------- Cocaine
    ---------------------------------------------------
    Coca_Leaves = {

        itemName = 'Coca Leaves',
        itemCoords = vector3(-1492.52, 4608.8, 44.16), -- Moved
        positiveItem = 'coca_leaves',
        negativeItem = 'damaged_leaves',

        requiredItems = {},
        negativeChance = 45,

        skillRequired = 'farming',
        levelRequired = 20,
        levelRewardPercent = 5,
        expPerAction = 12,
        autoFarm = true,
        displayText = 'Press [~b~E~w~] to harvest.',
        errorNotification = '',

        actionTime = 7,
        actionBarText = 'Farming: Coca Leaves (Level: 20)'
    },

    Dried_Leaves = {

        itemName = 'Dried Leaves',
        itemCoords = vector3(1486.44, 1132.12, 114.32), -- Moved
        positiveItem = 'dried_leaves',
        negativeItem = 'damaged_leaves',

        requiredItems = {
            {item = 'coca_leaves', amount = 4}
        },
        negativeChance = 30,

        skillRequired = 'herblore',
        levelRequired = 30,
        levelRewardPercent = 5,
        expPerAction = 35,
        autoFarm = false,
        displayText = 'Press [~b~E~w~] to begin drying.',
        errorNotification = '',

        actionTime = 9,
        actionBarText = 'Herblore: Dried Leaves (Level: 30)'
    },

    Solvent = {

        itemName = 'Solvent',
        itemCoords = vector3(1497.92, -2135.56, 76.32), -- Moved
        positiveItem = 'solvent',
        negativeItem = 'diluted_solvent',

        requiredItems = {},
        negativeChance = 30,

        skillRequired = 'thieving',
        levelRequired = 10,
        levelRewardPercent = 5,
        expPerAction = 48,
        autoFarm = false,
        displayText = 'Press [~b~E~w~] to steal solvent.',
        errorNotification = '',

        actionTime = 9,
        actionBarText = 'Thieving: Solvent (Level: 10)'

    },

    Mixed_Cocaine = {

        itemName = 'Mixed Cocaine',
        itemCoords = vector3(1092.96, -3196.56, -39.0), -- Moved
        positiveItem = 'mixed_cocaine',
        negativeItem = nil,

        requiredItems = {
            {item = 'dried_leaves', amount = 2},
            {item = 'solvent', amount = 1},
        },
        negativeChance = 30,

        skillRequired = 'herblore',
        levelRequired = 65,
        levelRewardPercent = 5,
        expPerAction = 165,
        autoFarm = false,
        displayText = 'Press [~b~E~w~] to mix cocaine.',
        errorNotification = '',

        actionTime = 35,
        actionBarText = 'Herblore: Mixed Cocaine (Level: 65)'

    },

    Bricked_Cocaine = {

        itemName = 'Bricked Cocaine',
        itemCoords = vector3(-593.32, -1607.2, 27.0),
        positiveItem = 'bricked_cocaine',
        negativeItem = nil,

        requiredItems = {
            {item = 'mixed_cocaine', amount = 2}
        },
        negativeChance = 30,

        skillRequired = 'herblore',
        levelRequired = 80,
        levelRewardPercent = 5,
        expPerAction = 320,
        autoFarm = false,
        displayText = 'Press [~b~E~w~] to brick cocaine.',
        errorNotification = '',

        actionTime = 45,
        actionBarText = 'Herblore: Bricked Cocaine (Level: 80)'

    },

    ---------------------------------------------------
    ------- Meth
    ---------------------------------------------------
    Hydrochloric_Acid = {

        itemName = 'Hydrochloric Acid',
        itemCoords = vector3(-924.8, -2948.96, 13.96), -- Moved
        positiveItem = 'hydrochloric_acid',
        negativeItem = nil,

        requiredItems = {},
        negativeChance = 30,

        skillRequired = 'thieving',
        levelRequired = 30,
        levelRewardPercent = 5,
        expPerAction = 22,
        autoFarm = false,
        displayText = 'Press [~b~E~w~] to siphon hydrochloric acid.',
        errorNotification = '',

        actionTime = 12,
        actionBarText = 'Thieving: Hydrochloric Acid (Level: 30)'

    },

    Sulfuric_Acid = {

        itemName = 'Sulfuric Acid',
        itemCoords = vector3(588.36, -3281.24, 6.08), -- Moved
        positiveItem = 'sulfuric_acid',
        negativeItem = nil,

        requiredItems = {},
        negativeChance = 30,

        skillRequired = 'thieving',
        levelRequired = 25,
        levelRewardPercent = 5,
        expPerAction = 35,
        autoFarm = false,
        displayText = 'Press [~b~E~w~] to siphon sulfuric acid.',
        errorNotification = '',

        actionTime = 12,
        actionBarText = 'Thieving: Sulfuric Acid (Level: 25)'

    },

    Liquid_Iodine = {

        itemName = 'Liquid Iodine',
        itemCoords = vector3(755.44, -2377.84, 15.36), -- Moved
        positiveItem = 'liquid_iodine',
        negativeItem = nil,

        requiredItems = {},
        negativeChance = 30,

        skillRequired = 'thieving',
        levelRequired = 15,
        levelRewardPercent = 5,
        expPerAction = 120,
        autoFarm = false,
        displayText = 'Press [~b~E~w~] to steal liquid iodine.',
        errorNotification = '',

        actionTime = 16,
        actionBarText = 'Thieving: Liquid Iodine (Level: 15)'

    },

    Red_Phosphorus = {

        itemName = 'Red Phosphorus',
        itemCoords = vector3(1443.28, 6331.88, 24.0),
        positiveItem = 'red_phosphorus',
        negativeItem = nil,

        requiredItems = {
            { item = 'hydrochloric_acid', amount = 4 },
            { item = 'sulfuric_acid', amount = 4 },
        },
        negativeChance = 30,

        skillRequired = 'herblore',
        levelRequired = 50,
        levelRewardPercent = 5,
        expPerAction = 230,
        autoFarm = false,
        displayText = 'Press [~b~E~w~] to boil red phosphorus ingredients.',
        errorNotification = '',

        actionTime = 35,
        actionBarText = 'Herblore: Red Phosphorus (Level: 50)'

    },

    Crystalised_Iodine = {

        itemName = 'Crystalised Iodine',
        itemCoords = vector3(-249.16, 6316.2, 32.4), -- Moved
        positiveItem = 'crystalised_iodine',
        negativeItem = nil,

        requiredItems = {
            { item = 'liquid_iodine', amount = 2 },
            { item = 'sulfuric_acid', amount = 4 },
        },
        negativeChance = 30,

        skillRequired = 'herblore',
        levelRequired = 55,
        levelRewardPercent = 5,
        expPerAction = 255,
        autoFarm = false,
        displayText = 'Press [~b~E~w~] to boil crystalised iodine ingredients.',
        errorNotification = '',

        actionTime = 35,
        actionBarText = 'Herblore: Crystalised Iodine (Level: 55)'

    },

    Crystal_Meth = {

        itemName = 'Crystal Meth',
        itemCoords = vector3(1012.24, -3194.88, -39.0), -- Moved.
        positiveItem = 'crystal_meth',
        negativeItem = nil,

        requiredItems = {
            { item = 'crystalised_iodine', amount = 1 },
            { item = 'red_phosphorus', amount = 1 },
        },
        negativeChance = 30,

        skillRequired = 'herblore',
        levelRequired = 75,
        levelRewardPercent = 5,
        expPerAction = 335,
        autoFarm = false,
        displayText = 'Press [~b~E~w~] to combine methylamine ingredients.',
        errorNotification = '',

        actionTime = 50,
        actionBarText = 'Herblore: Crystal Meth (Level: 75)'

    },

    ---------------------------------------------------
    ------- LSD
    ---------------------------------------------------
    MorningGlorySeeds = {

        itemName = 'Morning Glory Seeds',
        itemCoords = vector3(322.48, 6466.44, 30.08), -- Moved.
        positiveItem = 'morninggloryseeds',
        negativeItem = nil,

        requiredItems = {},
        negativeChance = 30,

        skillRequired = 'farming',
        levelRequired = 10,
        levelRewardPercent = 5,
        expPerAction = 22,
        autoFarm = false,
        displayText = 'Press [~b~E~w~] to dig up morning glory seeds.',
        errorNotification = '',

        actionTime = 7,
        actionBarText = 'Farming: Morning Glory Seeds (Level: 10)'

    },

    Ethanol = {

        itemName = 'Ethanol',
        itemCoords = vector3(1664.68, -45.68, 168.32), -- Moved
        positiveItem = 'ethanol',
        negativeItem = nil,

        requiredItems = {},
        negativeChance = 30,

        skillRequired = 'thieving',
        levelRequired = 15,
        levelRewardPercent = 5,
        expPerAction = 12,
        autoFarm = false,
        displayText = 'Press [~b~E~w~] to steal ethanol.',
        errorNotification = '',

        actionTime = 17,
        actionBarText = 'Thieving: Ethanol (Level: 15)'

    },

    Lysis = {

        itemName = 'Lysis',
        itemCoords = vector3(241.28, -1373.0, 39.52), -- Moved
        positiveItem = 'lysis',
        negativeItem = nil,

        requiredItems = {
            { item = 'morninggloryseeds', amount = 6 },
        },
        negativeChance = 30,

        skillRequired = 'herblore',
        levelRequired = 45,
        levelRewardPercent = 5,
        expPerAction = 120,
        autoFarm = false,
        displayText = 'Press [~b~E~w~] to extract the lysis.',
        errorNotification = '',

        actionTime = 47,
        actionBarText = 'Herblore: Lysis (Level: 45)'

    },

    Lysergic_Acid = {

        itemName = 'Lysergic Acid',
        itemCoords = vector3(254.12, -1342.96, 24.52), -- Moved
        positiveItem = 'lysergicacid',
        negativeItem = nil,

        requiredItems = {
            { item = 'water', amount = 4 },
            { item = 'lysis', amount = 2 },
        },
        negativeChance = 30,

        skillRequired = 'herblore',
        levelRequired = 55,
        levelRewardPercent = 5,
        expPerAction = 275,
        autoFarm = false,
        displayText = 'Press [~b~E~w~] to extract the lysis.',
        errorNotification = '',

        actionTime = 65,
        actionBarText = 'Herblore: Lysergic Acid (Level: 55)'

    },

    LSD = {

        itemName = 'LSD',
        itemCoords = vector3(3533.72, 3659.72, 28.12), -- Moved
        positiveItem = 'lsd',
        negativeItem = nil,

        requiredItems = {
            { item = 'lysergicacid', amount = 4 },
            { item = 'ethanol', amount = 2 },
        },
        negativeChance = 30,

        skillRequired = 'herblore',
        levelRequired = 70,
        levelRewardPercent = 5,
        expPerAction = 425,
        autoFarm = false,
        displayText = 'Press [~b~E~w~] to extract the lysis.',
        errorNotification = '',

        actionTime = 75,
        actionBarText = 'Herblore: LSD (Level: 70)'

    },

}
