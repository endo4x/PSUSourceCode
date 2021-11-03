--[[
	id: EhopBx800FPtKqZ7SUWDZ
	name: Narkotyki
	description: Script by Chubby#9857
	time1: 2021-05-28 17:14:46.424314+00
	time2: 2021-05-28 17:14:46.424315+00
	uploader: YA0nO7Jc5RClAPCp-trgMz-xoJknXCq9GiQzKjMf
	uploadersession: v02oULHj7BtVE4BTKih8kbv6Zqda5o
	flag: f
--]]

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
--Heroina
local sok_mlekowyIlosc = 0
local morfinaIlosc = 0
local bazaheroinowaIlosc = 0
local materialIlosc = 0
local brownsugarIlosc = 0
local paracetamolIlosc = 0
local heroinaIlosc = 0
--Kokaina
local lisciekokiIlosc = 0
local kwasIlosc = 0
local pastakokainowaIlosc = 0
local acetonIlosc = 0
local bazakokainowaIlosc = 0
local fenacetynaIlosc = 0
local kokainaIlosc = 0
--Mata
local efederynaIlosc = 0
local efederynakruszonaIlosc = 0
local chlorowodorekIlosc = 0
local metaIlosc = 0
--CZAS
local hour
local minute
local dayOfWeek
local month
local dayOfMonth
local year

--EFEKTY DRAGI
local IsAlreadyDrug = true
local DrugLevel     = -1

ESX 			    			= nil
local myJob 					= nil
local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local isInZone                  = false
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}

local blJobs = {
  'offpolice',
  'police',
  'fire',
  'offfire',
  'mecano',
  'offmecano',
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler('route68:hasEnteredMarker', function(zone)
  for i=1, #blJobs do
    if myJob == blJobs[i] then
      return;
    end
  end
	--[[if myJob == 'police' or myJob == 'ambulance' then
		return
	end]]

	ESX.UI.Menu.CloseAll()
	
	
	
	if zone == 'Heroina_etap_jeden' then
		CurrentAction     = zone
		CurrentActionData = {}
	end

	if zone == 'Heroina_etap_dwa' then
			CurrentAction     = zone
			CurrentActionData = {}
	end
	
	if zone == 'Heroina_etap_trzy' then
			CurrentAction     = zone
			CurrentActionData = {}
	end
	
	if zone == 'Kokaina_etap_jeden' then
			CurrentAction     = zone
			CurrentActionData = {}
	end
	
	if zone == 'Kokaina_etap_dwa' then
			CurrentAction     = zone
			CurrentActionData = {}
	end
	
	if zone == 'Kokaina_etap_trzy' then
			CurrentAction     = zone
			CurrentActionData = {}
	end
	
	--Meta_etap:1 to kupno więc nie ma
	
	if zone == 'Meta_etap_dwa' then
			CurrentAction     = zone
			CurrentActionData = {}
	end
	
	if zone == 'Meta_etap_trzy' then
			CurrentAction     = zone
			CurrentActionData = {}
	end
	
	
	if zone == 'NPC' then
			CurrentAction     = zone
			CurrentActionData = {}
	end






end)


AddEventHandler('route68:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
	showtext = true
	TriggerServerEvent('route68:stop:heroina:1')
	TriggerServerEvent('route68:stop:heroina:2')
	TriggerServerEvent('route68:stop:heroina:3')
	TriggerServerEvent('route68:stop:koka:1')
	TriggerServerEvent('route68:stop:koka:2')
	TriggerServerEvent('route68:stop:koka:3')
	TriggerServerEvent('route68:stop:meta:1')
	TriggerServerEvent('route68:stop:meta:2')
	TriggerServerEvent('route68:stop:npc')
end)
showtext = true

-- Render markers
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(9)

		local coords = GetEntityCoords(GetPlayerPed(-1))

		for k,v in pairs(Config.Zones) do
			if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 5) and showtext then
				local PozycjaTekstu= {
					["x"] = v.x,
					["y"] = v.y,
					["z"] = v.z
				}
				ESX.Game.Utils.DrawText3D(PozycjaTekstu, v.Tekst, 0.55, 2.0, v.Tekst2, 0.7)
			end
		end

	end
end)





RegisterNetEvent('route68:ReturnInventory')
AddEventHandler('route68:ReturnInventory', function(sok_mlekowyNbr, morfinaNbr, bazaheroinowaNbr, materialNbr, brownsugarNbr, paracetamolNbr, heroinaNbr, lisciekokiNbr, kwasNbr, pastakokainowaNbr, acetonNbr, bazakokainowaNbr, fenacetynaNbr, kokainaNbr, efederynaNbr, efederynakruszonaNbr, chlorowodorekNbr, metaNbr, jobName, currentZone)
	--Heroina
	sok_mlekowyIlosc	   		= sok_mlekowyNbr
	morfinaIlosc 				= morfinaNbr
	bazaheroinowaIlosc 	 		= bazaheroinowaNbr
	materialIlosc 				= materialNbr
	brownsugarIlosc 	  		= brownsugarNbr
	paracetamolIlosc		    = paracetamolNbr
	heroinaIlosc	   			= heroinaNbr
	--Kokaina
	lisciekokiIlosc	   			= lisciekokiNbr
	kwasIlosc	   				= kwasNbr
	pastakokainowaIlosc	   		= pastakokainowaNbr
	acetonIlosc	  			    = acetonNbr
	bazakokainowaIlosc	   		= bazakokainowaNbr
	fenacetynaIlosc	   			= fenacetynaNbr
	kokainaIlosc	   			= kokainaNbr
	--Meta
	efederynaIlosc	   			= efederynaNbr
	efederynakruszonaIlosc		= efederynakruszonaNbr
	chlorowodorekIlosc	   		= chlorowodorekNbr
	metaIlosc	   				= metaNbr
	--Praca
	myJob		 = jobName
	
	TriggerEvent('route68:hasEnteredMarker', currentZone)
end)

Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(Config.Zones) do
			if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1) then
				isInMarker  = true
				currentZone = k
			end
		end
		
		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone                = currentZone
			TriggerServerEvent('route68:GetUserInventory', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('route68:hasExitedMarker', lastZone)
		end
		
		function wyjdz()
		HasAlreadyEnteredMarker = false
		TriggerEvent('route68:hasExitedMarker', lastZone)
		end

	end
end)

function animka(czas)
local dict = "amb@prop_human_bum_bin@idle_b"
RequestAnimDict(dict)
while not HasAnimDictLoaded(dict) do
Citizen.Wait(10)
end
TaskPlayAnim(GetPlayerPed(-1), dict, "idle_d", 8.0, 8.0, czas * 1000, 1, 0, false, false, false)
end

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if CurrentAction ~= nil then
			if IsControlJustReleased(0, Keys['E']) then
				isInZone = true -- unless we set this boolean to false, we will always freeze the user
				showtext = false
				if CurrentAction == 'Heroina_etap_jeden' then
					TriggerServerEvent('route68:start_heroina:1')
				elseif CurrentAction == 'Heroina_etap_dwa' then
					if sok_mlekowyIlosc >= 3 or morfinaIlosc >= 1 then
						TriggerServerEvent('route68:start_heroina:2')
					else
						wyjdz()
						TriggerEvent('pNotify:SendNotification', {text = "Nie posiadasz <font color='red'>Soku mlekowego</font> lub <font color='red'>Morfiny</font>"})
					end
				elseif CurrentAction == 'Heroina_etap_trzy' then
					if bazaheroinowaIlosc >= 2 or materialIlosc >= 1 then
						TriggerServerEvent('route68:start_heroina:3')
					else
						wyjdz()
						TriggerEvent('pNotify:SendNotification', {text = "Nie posiadasz <font color='red'>Bazy Heroinowej</font> lub <font color='red'>Materialu</font>"})
					end
				elseif CurrentAction == 'Kokaina_etap_jeden' then
					TriggerServerEvent('route68:start_koka:1')
				elseif CurrentAction == 'Kokaina_etap_dwa' then
					if lisciekokiIlosc >= 5 or kwasIlosc >= 5 then
						TriggerServerEvent('route68:start_koka:2')
					else
						wyjdz()
						TriggerEvent('pNotify:SendNotification', {text = "Nie posiadasz <font color='red'>Lisci kokainy</font> lub <font color='red'>Kwasu</font>"})
					end
				elseif CurrentAction == 'Kokaina_etap_trzy' then
					if pastakokainowaIlosc >= 5 or acetonIlosc >= 1 then
						TriggerServerEvent('route68:start_koka:3')
					else
						wyjdz()
						TriggerEvent('pNotify:SendNotification', {text = "Nie posiadasz <font color='red'>Pasty kokainowej</font> lub <font color='red'>Acetonu</font>"})
					end
				elseif CurrentAction == 'Meta_etap_dwa' then
					if efederynaIlosc >= 10 then
						TriggerServerEvent('route68:start_meta:2')
					else
						wyjdz()
						TriggerEvent('pNotify:SendNotification', {text = "Nie posiadasz <font color='red'>Efederyny</font>"})
					end
				elseif CurrentAction == 'Meta_etap_trzy' then
					if efederynaIlosc >= 10 or kwasIlosc >= 10 then
						TriggerServerEvent('route68:start_meta:3')
					else
						wyjdz()
						TriggerEvent('pNotify:SendNotification', {text = "Nie posiadasz <font color='red'>Efederyna</font> lub <font color='red'>Kwasu</font>"})
					end
				else
					isInZone = false -- not a route68 zone
				end
				
				
				if CurrentAction == 'NPC' then
					TriggerEvent('route68:start_npc')
				end
				
				CurrentAction = nil
			end
		end
	end
end)


RegisterNetEvent('route68:start_npc')
AddEventHandler('route68:start_npc',function()
hour = GetClockHours()
minute = GetClockMinutes()
local random1 = math.random(1, 12)
local random2 =  random1 + 12
	if hour >= random1 or hour >= random2 then
		TriggerEvent('pNotify:SendNotification', {text = "<font color='red'> Przyjdź później </font>, diler nie pokazuje się w tych godzinach"})
	else
	ESX.TriggerServerCallback('route68:stanprzetwarzania', function(jest)
	 if jest then
		TriggerEvent('pNotify:SendNotification', {text = "<font color='red'> Przyjdź później </font>, ktoś już przerabia narkotyki"})
	 else
		OpenMenu()
	end
	end)
	end
end)



function OpenMenu()
    ESX.UI.Menu.CloseAll()
    local elements = {
       {
   
       label = ('Czyszczenie Heroiny'), value = { name = 'heroina'}, 
      
       },
	   
       {
   
       label = ('Suszenie Kokainy'), value = { name = 'kokaina'}, 
      
       },
	   
       {
   
       label = ('Wytracanie Metaamfetaminy'), value = { name = 'meta'}, 
      
       },



  
    }
  
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop', {
        title    = ('Wyrabianie narkotykow'),
        align    = 'left',
        elements = elements
      }, function(data, menu)
        local element = data.current.value
  
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'potwierdzenie', {
            title = ('Narkotyk'),
            align = 'left',
            elements = {
              { label = ('Wyrob narkotyk'), value = 'yes' },
              { label = ('Schemat'), value = 'schemat'},
              { label = ('Anuluj'),  value = 'no'  }
            }
          }, function(data2, menu2)
            if data2.current.value == 'yes' then
				if element.name == 'heroina' then
					TriggerServerEvent('route68:heroina')
				elseif element.name == 'kokaina' then
					TriggerServerEvent('route68:kokaina')
				elseif element.name == 'meta' then
					TriggerServerEvent('route68:meta')
				end
            end
            if data2.current.value == 'schemat' then
                --Sprawdzanie
                if element.name == 'heroina' then
                  heroina()
              elseif element.name == 'kokaina' then
                  kokaina()
              elseif element.name == 'meta' then
                  meta()
              end
            end
            
            menu2.close()
          end, function(data2, menu2)
            menu2.close()
          end
        )
  
      end, function(data, menu)
        menu.close()
      end
    )

end

function heroina()
    ESX.UI.Menu.CloseAll()
  
    local elements = {

        {

            label = ('Wroc'), value = { name = 'wroc'},
    
        },

        {

            label = ('100 Brown Sugar + 50 Paracetamol = 50 Heroina'),

        },




  
    }
  
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop', {
        title    = ('Schemat'),
        align    = 'left',
        elements = elements
      }, function(data, menu)
        local element = data.current.value
  
        if element.name == 'wroc' then
          menu.close()
          OpenMenu()
        end 
  
      end, function(data, menu)
        menu.close()
      end
    )
  
end


function kokaina()
    ESX.UI.Menu.CloseAll()
  
    local elements = {

        {

            label = ('Wroc'), value = { name = 'wroc'},
    
        },

        {

            label = ('150 Baza Kokainowa + 50 Fenacetyna = 50 Kokainy'),

        },




  
    }
  
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop', {
        title    = ('Schemat'),
        align    = 'left',
        elements = elements
      }, function(data, menu)
        local element = data.current.value
  
        if element.name == 'wroc' then
          menu.close()
          OpenMenu()
        end 
  
      end, function(data, menu)
        menu.close()
      end
    )
  
end

function meta()
    ESX.UI.Menu.CloseAll()
  
    local elements = {

        {

            label = ('Wroc'), value = { name = 'wroc'},
    
        },

        {

            label = ('60 Chlorowodorek + 60 Kwas = 50 Metaamfetamina '),

        },




  
    }
  
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop', {
        title    = ('Schemat'),
        align    = 'left',
        elements = elements
      }, function(data, menu)
        local element = data.current.value
  
        if element.name == 'wroc' then
          menu.close()
          OpenMenu()
        end 
  
      end, function(data, menu)
        menu.close()
      end
    )
  
end

RegisterNetEvent('route68:freezePlayer')
AddEventHandler('route68:freezePlayer', function(freeze)
	FreezeEntityPosition(GetPlayerPed(-1), freeze)
end)


--NPC lastZone
start = false
przetwarzanie = false
odbierz = false

RegisterNetEvent('route68:przerabianie')
AddEventHandler('route68:przerabianie', function(narkotyk, ilosc)
start = true
przetwarzanie = true
timer = Config.czas
Citizen.CreateThread(function()
	while timer > 0 do
		Citizen.Wait(60000)

		if timer > 0 then
			timer = timer - 1
		end
	end
	odbierz = true
	start = false
	przetwarzanie = false
	
	TriggerEvent('pNotify:SendNotification', {text = "Fermentacja ukończona udaj się do dilera odebrać narkotyki"})
end)

	while (start) do
		Citizen.Wait(8)
		local coords = GetEntityCoords(GetPlayerPed(-1))
			if(GetDistanceBetweenCoords(coords, 377.74, 3558.12, 33.4, true) < 5) and showtext then
				local PozycjaTekstu = {
						["x"] = 377.74,
						["y"] = 3558.12,
						["z"] = 33.4 + 0.4
				}
			ESX.Game.Utils.DrawText3D(PozycjaTekstu, "FERMENTACJA: [~g~"..timer.."~s~] MINUT DO UKOŃCZENIA", 0.55, 2.0, "~b~FERMENTACJA", 0.7)
		end
	end
	
	while (odbierz) do
		Citizen.Wait(8)
		local coords = GetEntityCoords(GetPlayerPed(-1))
			if(GetDistanceBetweenCoords(coords, 377.74, 3558.12, 33.4, true) < 5) and showtext then
				local PozycjaTekstu = {
						["x"] = 377.74,
						["y"] = 3558.12,
						["z"] = 33.4 + 0.4
				}
			ESX.Game.Utils.DrawText3D(PozycjaTekstu, "NACIŚNIJ [~g~E~s~] ABY ODEBRAĆ NARKOTYKI", 0.55, 2.0, "ODBIÓR NARKOTYKÓW", 0.7)
			if IsControlJustPressed(0, Keys['E']) then
			
				TriggerServerEvent('route68:narkotykend', narkotyk, ilosc)
			odbierz = false
			
			end
		end
	end
end)


RegisterNetEvent('route68:start_heroina_etap2:1')
AddEventHandler('route68:start_heroina_etap2:1', function()
FreezeEntityPosition(PlayerPedId(), true)
TriggerEvent("route68_progbar:client:progress", {
    name = "heroina",
    duration = 5000,
    label = "NACINANIE MAKÓWEK",
    useWhileDead = true,
    canCancel = false,
    controlDisables = {
		disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
	},
    prop = {
    },
    propTwo = {
	},
})
animka(5)
Citizen.Wait(5 * 1000)
TriggerServerEvent('route68:koniec_heroina:1')
wyjdz()
showtext = true
FreezeEntityPosition(PlayerPedId(), false)
end)

RegisterNetEvent('route68:start_heroina_etap2:2')
AddEventHandler('route68:start_heroina_etap2:2', function()
FreezeEntityPosition(PlayerPedId(), true)
TriggerEvent("route68_progbar:client:progress", {
    name = "heroina",
    duration = 10000,
    label = "GOTOWANIE",
    useWhileDead = true,
    canCancel = false,
    controlDisables = {
		disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
	},
    prop = {
    },
    propTwo = {
	},
})
animka(10)
Citizen.Wait(10 * 1000)
TriggerServerEvent('route68:koniec_heroina:2')
wyjdz()
showtext = true
FreezeEntityPosition(PlayerPedId(), false)
end)

RegisterNetEvent('route68:start_heroina_etap3:3')
AddEventHandler('route68:start_heroina_etap3:3', function()
FreezeEntityPosition(PlayerPedId(), true)
TriggerEvent("route68_progbar:client:progress", {
    name = "heroina",
    duration = 15000,
    label = "FILTROWANIE",
    useWhileDead = true,
    canCancel = false,
    controlDisables = {
		disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
	},
    prop = {
    },
    propTwo = {
	},
})
animka(15)
Citizen.Wait(15 * 1000)
TriggerServerEvent('route68:koniec_heroina:3')
wyjdz()
showtext = true
FreezeEntityPosition(PlayerPedId(), false)
end)





--Kokaina

RegisterNetEvent('route68:start_kokaina_etap2:1')
AddEventHandler('route68:start_kokaina_etap2:1', function()
FreezeEntityPosition(PlayerPedId(), true)
TriggerEvent("route68_progbar:client:progress", {
    name = "koka",
    duration = 5000,
    label = "ZBIERANIE LIŚCI",
    useWhileDead = true,
    canCancel = false,
    controlDisables = {
		disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
	},
    prop = {
    },
    propTwo = {
	},
})
animka(5)
Citizen.Wait(5 * 1000)
TriggerServerEvent('route68:koniec_kokaina:1')
wyjdz()
showtext = true
FreezeEntityPosition(PlayerPedId(), false)
end)

RegisterNetEvent('route68:start_kokaina_etap2:2')
AddEventHandler('route68:start_kokaina_etap2:2', function()
FreezeEntityPosition(PlayerPedId(), true)
TriggerEvent("route68_progbar:client:progress", {
    name = "koka",
    duration = 15000,
    label = "MIELENIE",
    useWhileDead = true,
    canCancel = false,
    controlDisables = {
		disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
	},
    prop = {
    },
    propTwo = {
	},
})
animka(15)
Citizen.Wait(15 * 1000)
TriggerServerEvent('route68:koniec_kokaina:2')
wyjdz()
showtext = true
FreezeEntityPosition(PlayerPedId(), false)
end)

RegisterNetEvent('route68:start_kokaina_etap2:3')
AddEventHandler('route68:start_kokaina_etap2:3', function()
FreezeEntityPosition(PlayerPedId(), true)
TriggerEvent("route68_progbar:client:progress", {
    name = "koka",
    duration = 10000,
    label = "GOTOWANIE",
    useWhileDead = true,
    canCancel = false,
    controlDisables = {
		disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
	},
    prop = {
    },
    propTwo = {
	},
})
animka(10)
Citizen.Wait(10 * 1000)
TriggerServerEvent('route68:koniec_kokaina:3')
wyjdz()
showtext = true
FreezeEntityPosition(PlayerPedId(), false)
end)



--META


RegisterNetEvent('route68:start_meta_etap2:2')
AddEventHandler('route68:start_meta_etap2:2', function()
FreezeEntityPosition(PlayerPedId(), true)
TriggerEvent("route68_progbar:client:progress", {
    name = "meta",
    duration = 20000,
    label = "KRUSZENIE",
    useWhileDead = true,
    canCancel = false,
    controlDisables = {
		disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
	},
    prop = {
    },
    propTwo = {
	},
})
animka(20)
Citizen.Wait(20 * 1000)
TriggerServerEvent('route68:koniec_meta:2')
wyjdz()
showtext = true
FreezeEntityPosition(PlayerPedId(), false)
end)

RegisterNetEvent('route68:start_meta_etap2:3')
AddEventHandler('route68:start_meta_etap2:3', function()
FreezeEntityPosition(PlayerPedId(), true)
TriggerEvent("route68_progbar:client:progress", {
    name = "meta",
    duration = 20000,
    label = "SYNTEZA",
    useWhileDead = true,
    canCancel = false,
    controlDisables = {
		disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
	},
    prop = {
    },
    propTwo = {
	},
})
animka(20)
Citizen.Wait(20 * 1000)
TriggerServerEvent('route68:koniec_meta:3')
wyjdz()
showtext = true
FreezeEntityPosition(PlayerPedId(), false)
end)


--EFEKTY DRAGI


--When effects ends go back to normal
function Normal()

  Citizen.CreateThread(function()
    
    local playerPed = GetPlayerPed(-1)
			
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    if not IsPedInAnyVehicle(playerPed, false) then
      ResetPedMovementClipset(playerPed, 0) -- it might cause the push of the vehicles
    end
    SetPedIsDrunk(playerPed, false)
    SetPedMotionBlur(playerPed, false)
  end)

end

--In case too much drugs dies of overdose set everything back
function overdose()

  Citizen.CreateThread(function()

    local playerPed = GetPlayerPed(-1)
	
    SetEntityHealth(playerPed, 0)
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(playerPed, 0)
    SetPedIsDrunk(playerPed, false)
    SetPedMotionBlur(playerPed, false)

  end)

end

--Drugs Effects

AddEventHandler('esx_status:loaded', function(status)

  TriggerEvent('esx_status:registerStatus', 'drug', 0, '#9ec617', 
    function(status)
      if status.val > 0 then
        return true
      else
        return false
      end
    end,
    function(status)
      status.remove(1500)
    end
  )

	Citizen.CreateThread(function()

		while true do

			Wait(1000)

			TriggerEvent('esx_status:getStatus', 'drug', function(status)
				
				if status.val > 0 then
					
          local start = true

          if IsAlreadyDrug then
            start = false
          end

          local level = 0

          if status.val <= 999999 then
            level = 0
          else
            overdose()
          end

          if level ~= DrugLevel then
          end

          IsAlreadyDrug = true
          DrugLevel     = level
				end

				if status.val == 0 then
          
          if IsAlreadyDrug then
            Normal()
          end

          IsAlreadyDrug = false
          DrugLevel     = -1

				end

			end)

		end

	end)

end)

--Jak cos to brownsugar ale nie chcialo mi sie zmienic nazwy 
RegisterNetEvent('esx_drugeffects:onWeed')
AddEventHandler('esx_drugeffects:onWeed', function()
  
  local playerPed = GetPlayerPed(-1)
  
    RequestAnimSet("move_m@hipster@a") 
    while not HasAnimSetLoaded("move_m@hipster@a") do
      Citizen.Wait(0)
    end    

    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    Citizen.Wait(3000)
    ClearPedTasksImmediately(playerPed)
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "move_m@hipster@a", true)
    SetPedIsDrunk(playerPed, true)
    
    --Efects
    local player = PlayerId()
    SetRunSprintMultiplierForPlayer(player, 1.2)
        
    Wait(300000)

    SetRunSprintMultiplierForPlayer(player, 1.2)		
end)

RegisterNetEvent('esx_drugeffects:onEnergy')
AddEventHandler('esx_drugeffects:onEnergy', function()
  
  local playerPed = GetPlayerPed(-1)
  
    RequestAnimSet("move_m@hipster@a") 
    while not HasAnimSetLoaded("move_m@hipster@a") do
      Citizen.Wait(0)
    end    

    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    Citizen.Wait(3000)
    ClearPedTasksImmediately(playerPed)
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "move_m@hipster@a", true)
    SetPedIsDrunk(playerPed, true)
    
    --Efects
    local player = PlayerId()
    SetRunSprintMultiplierForPlayer(player, 1.7)
        
    Wait(20000)

    SetRunSprintMultiplierForPlayer(player, 1.3)		
end)

--Opium
RegisterNetEvent('esx_drugeffects:onOpium')
AddEventHandler('esx_drugeffects:onOpium', function()
  
  local playerPed = GetPlayerPed(-1)
  
        RequestAnimSet("move_m@drunk@moderatedrunk") 
    while not HasAnimSetLoaded("move_m@drunk@moderatedrunk") do
      Citizen.Wait(0)
    end    

    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    Citizen.Wait(3000)
    ClearPedTasksImmediately(playerPed)
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "move_m@drunk@moderatedrunk", true)
    SetPedIsDrunk(playerPed, true)
    
    --Efects
    local player = PlayerId()
    SetRunSprintMultiplierForPlayer(player, 1.2)
    SetSwimMultiplierForPlayer(player, 1.3)

    Wait(520000)

    SetRunSprintMultiplierForPlayer(player, 1.0)
    SetSwimMultiplierForPlayer(player, 1.0)
 end)

--Meth
RegisterNetEvent('esx_drugeffects:onMeth')
AddEventHandler('esx_drugeffects:onMeth', function()
  
  local playerPed = GetPlayerPed(-1)
  local maxHealth = GetEntityMaxHealth(playerPed)

        RequestAnimSet("move_injured_generic") 
    while not HasAnimSetLoaded("move_injured_generic") do
      Citizen.Wait(0)
    end    

    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    Citizen.Wait(3000)
    ClearPedTasksImmediately(playerPed)
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "move_injured_generic", true)
    SetPedIsDrunk(playerPed, true)
    
   --Efects
    local player = PlayerId()  
    local health = GetEntityHealth(playerPed)
    local newHealth = math.min(maxHealth , math.floor(health + maxHealth/8))
    SetEntityHealth(playerPed, newHealth)
    
end)

--Coke
RegisterNetEvent('esx_drugeffects:onCoke')
AddEventHandler('esx_drugeffects:onCoke', function()
  
  local playerPed = GetPlayerPed(-1)
  local maxHealth = GetEntityMaxHealth(playerPed)

        RequestAnimSet("move_m@hurry_butch@a") 
    while not HasAnimSetLoaded("move_m@hurry_butch@a") do
      Citizen.Wait(0)
    end    

    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    Citizen.Wait(3000)
    ClearPedTasksImmediately(playerPed)
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "move_m@hurry_butch@a", true)
    SetPedIsDrunk(playerPed, true)
    
    --Efects
    local player = PlayerId()
    AddArmourToPed(playerPed, 100)
    local health = GetEntityHealth(playerPed)
    local newHealth = math.min(maxHealth , math.floor(health + maxHealth/6))
    SetEntityHealth(playerPed, newHealth)
    
end)