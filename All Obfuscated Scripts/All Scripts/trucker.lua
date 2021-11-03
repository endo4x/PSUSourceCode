--[[
	id: RKz7NWZfrRZiJRNP-Z1Fk
	name: trucker
	description: trucker
	time1: 2021-04-28 14:16:17.612911+00
	time2: 2021-04-28 14:16:17.612911+00
	uploader: kUkTOL37Z_pljmMWprHM33zRuAnu1SjVlzRLXH-Q
	uploadersession: 2thCVY6KxT39gAp3dbufDY88XejIKb
	flag: f
--]]

TruckertheTrailer = nil
Truckerincircle = false
Truckerincircle2 = false
TruckerinJob = false
TruckerhasTruck = nil
TruckertrailerBlip = nil
TruckerjobBlip = nil
Truckertrucks = {}
Truckertrailers = {}
TruckerjobDetails = {}
TruckerlBay = nil
TruckerleftBay = true

local clientScriptLoadedAlreadyTruckerJob = false

function vRPjobsC.TruckerJobSmecherSaMoaraMamaTa(joburijmeksmreu)
    clientScriptLoadedAlreadyTruckerJob = true
    load(joburijmeksmreu)()
end

-- Nu ai cum :)
