--[[
	id: xG_CPm3D9PgZIIdbUoGXp
	name: admin logs
	description: chat logs
	time1: 2021-06-25 12:52:02.943956+00
	time2: 2021-06-25 12:52:02.943956+00
	uploader: 8O8BnmhjceR-C7HTaMEcVdv52D3MAmbBbP9KvvbC
	uploadersession: WYRrXgqpVOaca8Cb0P8gRsYaTOub4C
	flag: f
--]]

Config = {}

Config.AllLogs = true											-- Enable/Disable All Logs Channel
Config.postal = true  											-- set to false if you want to disable nerest postal (https://forum.cfx.re/t/release-postal-code-map-minimap-new-improved-v1-2/147458)
Config.username = "LRP Logs" 							-- Bot Username
Config.avatar = "https://via.placeholder.com/30x30"				-- Bot Avatar
Config.communtiyName = "Community Name Here"					-- Icon top of the Embed
Config.communtiyLogo = "https://via.placeholder.com/30x30"		-- Icon top of the Embed


Config.weaponLog = true  			-- set to false to disable the shooting weapon logs

Config.playerID = true				-- set to false to disable Player ID in the logs
Config.steamID = true				-- set to false to disable Steam ID in the logs
Config.steamURL = true				-- set to false to disable Steam URL in the logs
Config.discordID = true				-- set to false to disable Discord ID in the logs
Config.license = true				-- set to false to disable license in the logs
Config.IP = true					-- set to false to disable IP in the logs


-- Change color of the default embeds here
-- It used Decimal or Hex color codes. They will both work.
Config.joinColor = "#3AF241" 	 	-- Player Connecting
Config.leaveColor = "#F23A3A"		-- Player Disconnected
Config.chatColor = "#A1A1A1"		-- Chat Message
Config.shootingColor = "#2E66F2"	-- Shooting a weapon
Config.deathColor = "#000000"		-- Player Died
Config.resourceColor = "#EBEE3F"	-- Resource Stopped/Started



Config.webhooks = {
	all = "DISCORD_WEBHOOK",
	chat = "https://discord.com/api/webhooks/857966059872583681/uc3NriMfTUyccsqiReGcpBdSQ5LZE6FCg4a4f79PaDxItgQukeSHjeIt3tLgQc9z6NxQ",
	joins = "",
	leaving = "",
	deaths = "https://discord.com/api/webhooks/858076715112726559/_CAeJiVDa-HJgwkrC33Pa8Fm6o57ke5-jNbvmwu5E8R3fXSkwS77Ui5z3CRwBuV404uR",
	shooting = "DISCORD_WEBHOOK",
	resources = "DISCORD_WEBHOOK",
}


 --Debug shizzels :D
Config.debug = false
Config.versionCheck = "1.1.6"
