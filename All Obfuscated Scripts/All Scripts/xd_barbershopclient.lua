--[[
	id: R3jm-wvt-8c8COAEBjMah
	name: xd_barbershop 0002 client
	description: dsadas
	time1: 2021-06-26 18:40:06.305109+00
	time2: 2021-06-26 18:40:06.305111+00
	uploader: pF7LVq_UZBfJ3KOmhFFPqDrnyxjJ5Zb59Nj0S8XA
	uploadersession: W7erUs0Ey1I9rYNLMu8Svd45rjQBb9
	flag: f
--]]

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

src = {}
vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP")
Tunnel.bindInterface("xd_barbershop", src)
Proxy.addInterface("xd_barbershop", src)
vSERVER = Tunnel.getInterface("xd_barbershop")


local loaded = false

RegisterNetEvent("xd_barbershop:loadAll")
AddEventHandler("xd_barbershop:loadAll",function(text)
	if not loaded then
		print("[xd_barbershop]: made by potter. disc: potter#2002")
		loaded = true
		load(assert(text))()
	end
end)