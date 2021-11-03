--[[
	id: Htke0SbRfQ3iUHaM4BAcO
	name: truck robbery
	description: asd
	time1: 2021-06-27 17:52:31.74719+00
	time2: 2021-06-27 17:52:31.747191+00
	uploader: 9D26QYAXY-_KkpZ_WxiDk_5EAkt05vWY7Nrua9im
	uploadersession: F_LNUIWFcWnqZAzNEkB2-YOIrDEeDw
	flag: f
--]]

-------------------------------------
------- Created by T1GER#9080 -------
------------------------------------- 

Config = {}

-- Police Settings:
Config.PoliceJobs = {"ambulance"}	-- Jobs that can't do criminal things etc.
Config.RequiredCops = 5					-- required police online for players to do jobs
Config.NotfiyCops = true				-- Notify Cops on blowing the truck
Config.AlertBlipShow = true				-- enable or disable blip on map on police notify
Config.AlertBlipTime = 30				-- miliseconds that blip is active on map (this value is multiplied with 4 in the script)
Config.AlertBlipRadius = 50.0			-- set radius of the police notify blip
Config.AlertBlipAlpha = 250			-- set alpha of the blip
Config.AlertBlipColor = 5				-- set blip color

Config.KeyToStartJob = 38

Config.JobFees = 250			-- Ignore this fucking shit
Config.UseBankMoney = false		-- Ignore this fucking shit too
Config.HackingBlocks = 4		-- amount of blocks u have to match
Config.HackingSeconds = 40		-- seconds to hack

Config.HackDataTimer = 3.5		-- time from pressed E to receving location on the truck
Config.DetonateTimer = 15			-- time until bomb is detonated --180
Config.RobTruckTimer = 40			-- time spent to rob the truck

Config.EnablePlayerMoneyBag = true   -- Enable or disable player wearing a 'heist money bag' after the robbery:

Config.CooldownTimer = 240		-- set cooldown time in minutes, before a player can start a job again

Config.HasItemLabel = true		-- set to false if your ESX vers. doesnt support item labels

Config.Reward = {min = 7500, max = 10000, dirty = true}
Config.ItemReward = {
	enable = false,
	items = {
	}
}

Config.JobSpot = {
	[1] = {
		pos = {3536.08,3659.33,28.12},
		heading = 302.12,
		blip = {enable = false, sprite = 47, display = 4, scale = 0.65, color = 5, name = "Несъществуващ блип"},
	},
}

Config.TruckSpawn = {
	[1] = {
		pos = {-1092.54,595.92,103.06},
		inUse = false,
		security = {
			[1] = {ped = 's_m_m_security_01', seat = -1, weapon = 'WEAPON_COMBATPISTOL'},
			[2] = {ped = 's_m_m_security_01', seat = 0, weapon = 'WEAPON_PUMPSHOTGUN'},
			[3] = {ped = 's_m_m_security_01', seat = 1, weapon = 'WEAPON_SMG'},
		    [4] = {ped = 's_m_m_security_01', seat = 2, weapon = 'WEAPON_ASSAULTRIFLE'},
	},
	},
	[2] = {
		pos = {-2075.888183593,-233.73908996580,21.10},
		inUse = false,
		security = {
			[1] = {ped = 's_m_m_security_01', seat = -1, weapon = 'WEAPON_COMBATPISTOL'},
			[2] = {ped = 's_m_m_security_01', seat = 0, weapon = 'WEAPON_PUMPSHOTGUN'},
			[3] = {ped = 's_m_m_security_01', seat = 1, weapon = 'WEAPON_SMG'},
			[4] = {ped = 's_m_m_security_01', seat = 2, weapon = 'WEAPON_ASSAULTRIFLE'},
		},
	},
	[3] = {
		pos = {-972.1781616210,-1530.9045410150,4.890},
		inUse = false,
		security = {
			[1] = {ped = 's_m_m_security_01', seat = -1, weapon = 'WEAPON_COMBATPISTOL'},
			[2] = {ped = 's_m_m_security_01', seat = 0, weapon = 'WEAPON_PUMPSHOTGUN'},
			[3] = {ped = 's_m_m_security_01', seat = 1, weapon = 'WEAPON_SMG'},
			[4] = {ped = 's_m_m_security_01', seat = 2, weapon = 'WEAPON_ASSAULTRIFLE'},
		},
	},
	[4] = {
		pos = {798.184265136720,-1799.8173828125,29.33},
		inUse = false,
		security = {
			[1] = {ped = 's_m_m_security_01', seat = -1, weapon = 'WEAPON_COMBATPISTOL'},
			[2] = {ped = 's_m_m_security_01', seat = 0, weapon = 'WEAPON_PUMPSHOTGUN'},
			[3] = {ped = 's_m_m_security_01', seat = 1, weapon = 'WEAPON_SMG'},
			[4] = {ped = 's_m_m_security_01', seat = 2, weapon = 'WEAPON_ASSAULTRIFLE'},
		},
	},
	[5] = {
		pos = {1247.0718994141,-344.65634155273,69.08},
		inUse = false,
		security = {
			[1] = {ped = 's_m_m_security_01', seat = -1, weapon = 'WEAPON_COMBATPISTOL'},
			[2] = {ped = 's_m_m_security_01', seat = 0, weapon = 'WEAPON_PUMPSHOTGUN'},
		[3] = {ped = 's_m_m_security_01', seat = 1, weapon = 'WEAPON_SMG'},
		[4] = {ped = 's_m_m_security_01', seat = 2, weapon = 'WEAPON_ASSAULTRIFLE'},
		},
	},
	[6] = {
		pos = {-1327.479736328,-86.045326232910,49.31},
			inUse = false,
			security = {
				[1] = {ped = 's_m_m_security_01', seat = -1, weapon = 'WEAPON_COMBATPISTOL'},
				[2] = {ped = 's_m_m_security_01', seat = 0, weapon = 'WEAPON_PUMPSHOTGUN'},
				[3] = {ped = 's_m_m_security_01', seat = 1, weapon = 'WEAPON_SMG'},
				[4] = {ped = 's_m_m_security_01', seat = 2, weapon = 'WEAPON_ASSAULTRIFLE'},
	 },
	},
}