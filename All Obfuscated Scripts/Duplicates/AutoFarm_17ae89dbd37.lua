--[[
	id: BP4-jSQz9rW1q73nKRvLy
	name: AutoFarm
	description: Dungeon Quest AutoFarm for Evil Hub
	time1: 2021-05-20 01:52:26.6142+00
	time2: 2021-05-20 01:52:26.614201+00
	uploader: 817
	uploadersession: i03hz2ak2T4kfPFNwaa-JRlNX4tc1U
	flag: f
--]]

getgenv().Settings = {
	Lobby = {
		Safety = {
			WalkEnabled = false, 
			WalkTime = 10,
			HideNametag = false
		},

		Misc = {
			WaitTime = 0, --Wait before script activates
			AutoCollectDaily = true
		}
	},

	Dungeon = {
		HideNameplate = false,

		Configuration = {
			Hardcore = false,
			AutoSelectHighest = false
		},

		CustomDungeon = {
			Name = "Aquatic Temple",
			Difficulty = "Nightmare"
		},
	},

	Autofarm = {
		Walkspeed = 30, -- Higher than 30 is sometimes risky
		DistanceFromMobs = 50,
		AttackRange = 55,
		SmallTeleports = true, -- Autofarm won't work well on aquatic with this disabled
		Instakill = true,

		Experimental = {
			LimitSpellCasting = false
		}
	},

	AutoSell = {
		Enabled = false,
		SellTriplicatedSpells = false,
		KeepItemsLevelRequirement = 999,
		RaritiesToKeep = {"legendary", "epic"},
		ItemsToKeep = {
			["Desert Fury"] = {"legendary"},
			["Crystalized Greatsword"] = {"legendary"},
			["Staff of the Gods"] = {"legendary"},
			["Soul Stealer Greatsword"] = {"legendary"},
			["Beastmaster Spell Scythe"] = {"legendary"},
			["Beastmaster War Scythe"] = {"legendary"},
			["Dual Phoenix Daggers"] = {"legendary"},
			["Phoenix Greatstaff"] = {"legendary"},
			["Sakura Greatstaff"] = {"legendary"},
			["Sakura Katana"] = {"legendary"},
			["Overlord's Rageblade"] = {"legendary"},
			["Overlord's Manablade"] = {"legendary"},
			["Kraken Slayer"] = {"legendary"},
			["Sea Serpent's Wings"] = {"legendary"},
			["Inventor's Greatsword"] = {"legendary"},
			["Inventor's Spellblade"] = {"legendary"},
			["Hextech Overloaded Greatstaff +30"] = {"legendary"},
			["Dual Bioforged Drills +30"] = {"legendary"},
			["Dual Bioforged Drills +30"] = {"legendary"},
			["Dual Godforged Blades +30"] = {"legendary"},
			["Godforged Greatstaff +30"] = {"legendary"},
			["Twisted Wood Greatstaff +30"] = {"legendary"},
			["Twisted Wood Greatsword +30"] = {"legendary"},
			["Galactic Pike"] = {"legendary"},
			["Galactic Dual Blades"] = {"legendary"},
			["Red Knight Helmet"] = {"epic"},
			["Red Knight Armor"] = {"epic"},
			["Templar Hood"] = {"epic"},
			["Templar Robes"] = {"epic"},
			["Ice King's Warrior Helmet"] = {"epic"},
			["Ice King's Warrior Armor"] = {"epic"},
			["Ice King's Mage Hood"] = {"epic"},
			["Ice King's Mage Robes"] = {"epic"},
			["Ice King's Guardian Helmet"] = {"epic"},
			["Ice King's Guardian Armor"] = {"epic"},
			["Godly Warrior Helmet"] = {"epic"},
			["Godly Warrior Armor"] = {"epic"},
			["Godly Mage Helmet"] = {"epic"},
			["Godly Mage Robes"] = {"epic"},
			["Godly Guardian Helmet"] = {"epic"},
			["Godly Guardian Armor"] = {"epic"},
			["Titan-forged Warrior Helmet"] = {"epic"},
			["Titan-forged Warrior Armor"] = {"epic"},
			["Titan-forged Mage Helmet"] = {"epic"},
			["Titan-forged Mage Armor"] = {"epic"},
			["Titan-forged Guardian Helmet"] = {"epic"},
			["Titan-forged Guardian Armor"] = {"epic"},
			["Glorious Warrior Helmet"] = {"epic"},
			["Glorious Warrior Armor"] = {"epic"},
			["Glorious Mage Hood"] = {"epic"},
			["Glorious Mage Armor"] = {"epic"},
			["Glorious Guardian Helmet"] = {"epic"},
			["Glorious Guardian Armor"] = {"epic"},
			["Ancestral Warrior Helmet"] = {"epic"},
			["Ancestral Warrior Armor"] = {"epic"},
			["Ancestral Mage Hood"] = {"epic"},
			["Ancestral Mage Armor"] = {"epic"},
			["Ancestral Guardian Helmet"] = {"epic"},
			["Ancestral Guardian Armor"] = {"epic"},
			["Overlord's Warrior Hat"] = {"epic"},
			["Overlord's Warrior Armor"] = {"epic"},
			["Overlord's Mage Hat"] = {"epic"},
			["Overlord's Mage Robes"] = {"epic"},
			["Overlord's Guardian Hat"] = {"epic"},
			["Overlord's Guardian Armor"] = {"epic"},
			["Mythical Warrior Helmet"] = {"epic"},
			["Mythical Warrior Armor"] = {"epic"},
			["Mythical Mage Helmet"] = {"epic"},
			["Mythical Mage Armor"] = {"epic"},
			["Mythical Guardian Helmet"] = {"epic"},
			["Mythical Guardian Armor"] = {"epic"},
			["War-forged Warrior Helmet"] = {"epic"},
			["War-forged Warrior Armor"] = {"epic"},
			["War-forged Mage Helmet"] = {"epic"},
			["War-forged Mage Armor"] = {"epic"},
			["War-forged Guardian Helmet"] = {"epic"},
			["War-forged Guardian Armor"] = {"epic"},
			["Alien Warrior Helmet"] = {"epic", "rare"},
			["Alien Warrior Armor"] = {"epic", "rare"},
			["Alien Mage Helmet"] = {"epic", "rare"},
			["Alien Mage Armor"] = {"epic", "rare"},
			["Alien Guardian Helmet"] = {"epic", "rare"},
			["Alien Guardian Armor"] = {"epic", "rare"},
			["Commander's Warrior Helmet"] = {"epic", "rare"},
			["Commander's Warrior Armor"] = {"epic", "rare"},
			["Commander's Mage Helmet"] = {"epic", "rare"},
			["Commander's Mage Armor"] = {"epic", "rare"},
			["Commander's Guardian Helmet"] = {"epic", "rare"},
			["Commander's Guardian Armor"] = {"epic", "rare"},
			["Inventor's Warrior Helmet +30"] = {"epic"},
			["Inventor's Warrior Armor +30"] = {"epic"},
			["Inventor's Mage Helmet +30"] = {"epic"},
			["Inventor's Mage Armor +30"] = {"epic"},
			["Inventor's Guardian Helmet +30"] = {"epic"},
			["Inventor's Guardian Armor +30"] = {"epic"},
			["Heavenly Warrior Helmet +30"] = {"epic"},
			["Heavenly Warrior Armor +30"] = {"epic"},
			["Heavenly Mage Helmet +30"] = {"epic"},
			["Heavenly Mage Armor +30"] = {"epic"},
			["Heavenly Guardian Helmet +30"] = {"epic"},
			["Heavenly Guardian Armor +30"] = {"epic"},
			["Nature Warrior Helmet +30"] = {"epic"},
			["Nature Warrior Armor +30"] = {"epic"},
			["Nature Mage Helmet +30"] = {"epic"},
			["Nature Mage Armor +30"] = {"epic"},
			["Nature Guardian Helmet +30"] = {"epic"},
			["Nature Guardian Armor +30"] = {"epic"},
			["Lava King's Warrior Helmet"] = {"rare", "epic"},
			["Lava King's Warrior Armor"] = {"rare", "epic"},
			["Lava King's Mage Helmet"] = {"rare", "epic"},
			["Lava King's Mage Armor"] = {"rare", "epic"},
			["Molten Forged Mage Helmet"] = {"epic"},
			["Molten Forged Mage Armor"] = {"epic"},
			["Molten Forged Warrior Helmet"] = {"epic"},
			["Molten Forged Warrior Armor"] = {"epic"},
			["Aquatic Warrior Helmet"] = {"rare", "epic", "uncommon", "common"},
			["Aquatic Warrior Armor"] = {"rare", "epic", "uncommon", "common"},
			["Aquatic Mage Helmet"] = {"rare", "epic", "uncommon", "common"},
			["Aquatic Mage Armor"] = {"rare", "epic", "uncommon", "common"},
			["Riptide Warrior Helmet"] = {"rare", "epic", "uncommon", "common"},
			["Riptide Warrior Armor"] = {"rare", "epic", "uncommon", "common"},
			["Riptide Mage Helmet"] = {"rare", "epic", "uncommon", "common"},
			["Riptide Mage Armor"] = {"rare", "epic", "uncommon", "common"},
			["Triton Warrior Helmet"] = {"rare", "epic", "uncommon", "common"},
			["Triton Warrior Armor"] = {"rare", "epic", "uncommon", "common"},
			["Triton Mage Armor"] = {"rare", "epic", "uncommon", "common"},
			["Triton Mage Helmet"] = {"rare", "epic", "uncommon", "common"},
			["Triton Guardian Helmet"] = {"rare", "epic", "uncommon", "common"},
			["Triton Guardian Armor"] = {"rare", "epic", "uncommon", "common"},
			["Serpent Pike"] = {"rare", "epic", "uncommon", "common"},
			["Enchanted Sea Daggers"] = {"rare", "epic", "uncommon", "common"},
			["Aquatic Spear"] = {"rare", "epic", "uncommon", "common"},
			["Ocean Pearl Staff"] = {"rare", "epic", "uncommon", "common"},
			["Oceanic Greatsword"] = {"rare", "epic", "uncommon", "common"},
			["Enchanted Serpent Daggers"] = {"rare", "epic", "uncommon", "common"},
			["Spear Strike"] = {"rare"},
			["Water Orb"] = {"rare"},
			["Ice Barrage"] = {"epic"},
			["Ice Crash"] = {"epic"},
			["Aquatic Smite"] = {"epic"},
			["Ice Spikes"] = {"epic"},
			["Twin Slash"] = {"epic"},
			["Enhanced Inner Rage"] = {"legendary"},
			["Lava Barrage"] = {"epic"},
			["Blade Fall"] = {"epic"},
			["Battle Shout"] = {"uncommon"},
			["Innervate"] = {"epic"},
			["Explosive Mine"] = {"epic"},
			["Vortex Grenade"] = {"epic"},
			["Electric Field"] = {"epic"},
			["Energy Orb"] = {"epic"},
			["Dual Magma Shields"] = {"epic"},
			["Volcanic Greatsword"] = {"epic"},
			["Magma Infused Waraxe"] = {"epic"},
			["Shattered Magma Blade"] = {"epic"},
			["Ancient Lava Axe"] = {"epic"},
			["Dual Hellfire Blades"] = {"epic"}
		}
	},

	AutoEquip = {
		Enabled = true, 
		EquipType = "physical" -- "physical", "spell"
	},

	AutoUpgrade = {
		Enabled = false, 
		UpgradeType = "physicalPower" -- "physicalPower", "stamina", "spellPower"
	},

	AutoSkill = {
		Enabled = true,
		SkillType = { -- Precentages to upgrade each skill point
			["physicalPower"] = 100,
			["spellPower"] = 0,
			["stamina"] = 0
		}
	},

	LagReductions = {
		BadGraphics = true,
		DestroyGear = true,
		DisableSpellEffects = true
	},

	CustomUI = {
		Enabled = true,
		Name = "##################",
		Level = "1337",
		EXP = "1337",
		HP = "1337",
		Gold = "1337",
		Avatar = "https://www.roblox.com/asset-thumbnail/image?assetId=30994230&width=420&height=420&format=png"
	},

	WaitForJoiners = {
		Enabled = false,
		Host = "Account1",
		Joiners = {
			"Account2","Account3"
		}
	},

	MultiFarm = {
		Enabled = false,
		Host = "Account1",
		Joiners = {
			"Account2","Account3"
		}
	},

	Webhook = {
		Enabled = false,
		PingForRarity = {
			"legendary"
		},
		PingForItems = {
			["Triton Warrior Helmet"] = {"epic"},
			["Triton Warrior Armor"] = {"epic"},
			["Triton Mage Armor"] = {"epic"},
			["Triton Mage Helmet"] = {"epic"}
		},
		DiscordUserID = "760614887776059392",
		Url = "https://discord.com/api/webhooks/"
	}
}

loadstring(game:HttpGet("https://ghostbin.co/paste/bt4m/raw"))()