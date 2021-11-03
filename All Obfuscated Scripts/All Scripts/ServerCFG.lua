--[[
	id: iieqtoVya3zRRsc4RjrNe
	name: Server CFG
	description: C
	time1: 2021-07-03 22:43:09.012149+00
	time2: 2021-07-03 22:43:09.012149+00
	uploader: endILJ7HNjVIZCz1DajtBSeklWVeOgx1J3h9pS6d
	uploadersession: pPgYfyAQ9sdYSqaqndOnhd6Gu11Uxe
	flag: f
--]]

set es_enableCustomData 1 
set mysql_connection_string "server=127.0.0.1;database=nexus;userid=root;password="
set onesync_enableInfinity 1

endpoint_add_tcp "0.0.0.0:30120" 
endpoint_add_udp "0.0.0.0:30120" 
sv_maxclients "361"




sv_hostname "[^3GERMAN^0]^5 🌌NEXUS Roleplay🌌 ^0| 🎤^0SaltyChat ^0| ^1🔥High-Performance ^0| ❌^5Keine Allowlist ^0| 🔥^0Performance ^0| 🛡️^1AntiCheat ^0| ^0hosted by Avoro ^0|

#dependencies
server_script '@async/async.lua'

add_ace resource.essentialmode command.add_principal allow

#Enable Defaults
set es_nativeMoneySystem 0
##FiveM##
start es_extended
start mapmanager
start chat
start spawnmanager
start sessionmanager
start fivem
start webAdmin3
start hardcap
start esx_extraitems
start instance
start cron

##Essential##
set mysql_debug "File"
start es_admin2
start el_bwh
start screenshot-basic
start discord-screenshot
start mercedesklassee
start esplugin_mysql
start essentialmode
start es_ui
start mysql-async
##Menu List

start JD_logs
start [esx]
start [extras]
start [NEXUS]
start [test2]
start [voice]
start [txadmin]
start [eupmenu]
##Maps

start rooftopflat
start rooftopgarage
start LMC
restart esx_extraitems

sv_scriptHookAllowed 0
rcon_password ldfhgjjkk46udgfj
sets tags "roleplay, german, German, onesync, esx, nexus, neuer server, custom scripts, saltychat, keine whitelist"


#EasyAdmin

setr ea_LanguageName "de"                # set our language to english
setr ea_alwaysShowButtons "false"	# we don't want to see buttons we can't even access, do we? default: "false"
set ea_moderationNotification "true"   # this can be either "false" or a discord webhook address, this will send a discord message if an admin takes actions against a player  ( such as banning and kicking )
set ea_custombanlist "false"            # read docs for this, dont touch it
set ea_enableCallAdminCommand "false" # enables "calladmin" command via webhook
set ea_enableReportCommand "false" # enables "report" command, see Configuration Wiki Page for More infos
setr ea_MenuButton "56"

add_ace group.Projektleiter easyadmin allow
add_ace group.Projektleiter command.setgroup allow

add_ace group.Manager easyadmin.kick allow							
add_ace group.Manager easyadmin.teleport allow			
add_ace group.Manager easyadmin.ban allow			
add_ace group.Manager easyadmin.freeze allow
add_ace group.Manager easyadmin.unban allow
add_ace group.Manager easyadmin.spectate allow

add_ace group.Superadmin easyadmin.kick allow							
add_ace group.Superadmin easyadmin.teleport allow			
add_ace group.Superadmin easyadmin.ban allow			
add_ace group.Superadmin easyadmin.freeze allow
add_ace group.Superadmin easyadmin.unban allow
add_ace group.Superadmin easyadmin.spectate allow

add_ace group.Admin easyadmin.kick allow							
add_ace group.Admin easyadmin.teleport allow			
add_ace group.Admin easyadmin.ban allow			
add_ace group.Admin easyadmin.freeze allow
add_ace group.Admin easyadmin.unban allow
add_ace group.Admin easyadmin.spectate allow

add_ace group.Moderator easyadmin.kick allow							
add_ace group.Moderator easyadmin.teleport allow			
add_ace group.Moderator easyadmin.ban allow			
add_ace group.Moderator easyadmin.unban allow
add_ace group.Moderator easyadmin.spectate allow

add_ace group.Supporter easyadmin.kick allow							
add_ace group.Supporter easyadmin.teleport allow			


##ServerSync

add_principal identifier.steam:11000013c4f2863 group.sync #2face

add_ace group.sync "changeWeather" allow
add_ace group.sync "changeTime" allow
add_ace group.sync "freezeTime" allow

add_ace group.sync command.weather allow
add_ace group.sync command.time allow
add_ace group.sync command.freezetime allow

add_ace identifier.steam:11000011914673b waveshieldbypass
add_ace identifier.steam:11000013d2a5ced waveshieldbypass



## Restliche Sachen

sets banner_detail "https://cdn.discordapp.com/attachments/824761396952432640/854072420637605939/qvodf-h1wru.gif"
#sets banner_connecting "https://media.discordapp.net/attachments/812365700596367400/817116031720882216/connectingbanner.png"
# Nested configs!
#exec server_internal.cfg

start EasyAdmin
setr ea_LanguageName "de"                # set our language to german
setr ea_MenuButton "244"			# set our menu button to M. default: "244"
setr ea_alwaysShowButtons "false"	# we don't want to see buttons we can't even access, do we? default: "false"
set ea_moderationNotification "true"   # this can be either "false" or a discord webhook address, this will send a discord message if an admin takes actions against a player  ( such as banning and kicking )
set ea_custombanlist "false"            # read docs for this, dont touch it
set ea_enableCallAdminCommand "false"
set ea_enableReportCommand "false"
setr ea_screenshoturl "https://discord.com/api/webhooks/810670370654912542/1wRdpmGVk1GM8y91ne2dq3XFP8kj0G0_nNOETRzvk2fCNxH30hV40Z0tJAYXxzdHCfcg"
setr ea_moderationNotification "https://discord.com/api/webhooks/809758089217179678/2i8hqrmrIqn93IHtkdQEtH-RuS8J0_Bk_ApuIgaQIHgLlyAMb0bTcwMYFxb3Wvmkf41f"
setr ea_screenshotfield "files[]"
add_ace group.Projektleiter easyadmin allow
add_ace group.Projektleiter command.setgroup allow
add_ace resource.essentialmode command.setgroup allow
add_ace resource.nexus_aduty command.setgroup allow

add_ace group.Manager easyadmin.kick allow							
add_ace group.Manager easyadmin.teleport allow			
add_ace group.Manager easyadmin.ban allow			
add_ace group.Manager easyadmin.freeze allow
add_ace group.Manager easyadmin.unban allow
add_ace group.Manager easyadmin.spectate allow

add_ace group.Superadmin easyadmin.kick allow							
add_ace group.Superadmin easyadmin.teleport allow			
add_ace group.Superadmin easyadmin.ban allow			
add_ace group.Superadmin easyadmin.freeze allow
add_ace group.Superadmin easyadmin.unban allow
add_ace group.Superadmin easyadmin.spectate allow

add_ace group.Admin easyadmin.kick allow							
add_ace group.Admin easyadmin.teleport allow			
add_ace group.Admin easyadmin.ban allow			
add_ace group.Admin easyadmin.freeze allow
add_ace group.Admin easyadmin.unban allow
add_ace group.Admin easyadmin.spectate allow

add_ace group.Moderator easyadmin.kick allow							
add_ace group.Moderator easyadmin.teleport allow			
add_ace group.Moderator easyadmin.ban allow			
add_ace group.Moderator easyadmin.freeze allow
add_ace group.Moderator easyadmin.unban allow
add_ace group.Moderator easyadmin.spectate allow

add_ace group.guide command.revive allow

# Loading a server icon (96x96 PNG file)
load_server_icon logo.png
#load_server_icon faceless.gif
# convars which can be used in scripts
set temp_convar ""


# Want to only allow players authenticated with a third-party provider like Steam?
# Don't forget Social Club is a third party provider too!
#sv_authMaxVariance 1
#sv_authMinTrust 5


# Hide player endpoints in extetput.
set sv_enforceGameBuild 2189
set sv_enforceGameBuild 2189
sv_endpointprivacy true
#sv_hostname "[^3GE^1RM^3AN^0] ^Nexus^0 RolePlay ^0| ^1🔐Keine-Allowlist ^0| 🔈 ^9SaltyChat ^0| ^2💸Startgeld
#50K💸 ^0| 🛡^1Anti-Cheat ^0| ^6🚗Echte Automarken🚗 ^0| 🌌discord.gg/weFZ94n | 🌌 Ts3: FacelessTS.de"
#sv_master1 "Faceless"
sets ⏳Farmrouten "🍊 Orangen | 🍇 Trauben | 🐸 Kroeten"
sets ⛔Drogen "🌿 Weed | 💨 Kokain | 💉 Meth"
sets gametype "Roleplay"
sets 📢Discord "https://discord.gg/Nexus-Roleplay"
sets 🎧Teamspeak "NEXUS-RP"
sets 🗣️VOIP "salty chat"
sets 🔰Hoster "Avoro"
restart sessionmanager
set steam_webApiKey "2AFCA430C4D35B6CADF15AFE25BF9C70"
sets locale "de-DE"
# License key for your server (https://keymaster.fivem.net)
sv_licenseKey "malf6l2vpxrtppuxltjj598mszrpgpyh"
