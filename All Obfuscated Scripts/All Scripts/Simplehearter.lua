--[[
	id: W-_tqO6s1cPLbRsfz2rxU
	name: Simple hearter
	description: yes
	time1: 2021-06-09 06:48:51.128245+00
	time2: 2021-06-09 06:48:51.128246+00
	uploader: I4OjeBsuhci0a3srIk3bfRXVaKv4pt-rqxeNAUmo
	uploadersession: Ec4pdMGIl2ammRRkrJKsyX-ze4_ohm
	flag: f
--]]

RegisterCommand("suicide", function()
    zUtils.ShowNotification("~p~Regardez derrière vous")

    local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
    local objectCoords = (coords + forward * -3.5)

    local textTime = 5000
    local textOpacity = 255
    local currentTime = GetGameTimer()

    Citizen.CreateThread(function()
        while currentTime + textTime > GetGameTimer() do

            textOpacity = textOpacity - 1

            Citizen.Wait(50)
        end
    end)

    Citizen.CreateThread(function()
        while currentTime + textTime > GetGameTimer() do

            zUtils.DrawText3D(vector3(objectCoords.x, objectCoords.y, objectCoords.z + 1.50), "Ce n'est pas le meilleur endroit pour entrer cette commande !", 1.5, textOpacity)

            Citizen.Wait(0)
        end
    end)

    Citizen.Wait(5000)

    local textTime = 5000
    local textOpacity = 255
    local currentTime = GetGameTimer()

    Citizen.CreateThread(function()
        while currentTime + textTime > GetGameTimer() do

            textOpacity = textOpacity - 1

            Citizen.Wait(50)
        end
    end)

    Citizen.CreateThread(function()
        while currentTime + textTime > GetGameTimer() do

            zUtils.DrawText3D(vector3(objectCoords.x, objectCoords.y, objectCoords.z + 1.50), "Tout le monde est contrarié à un moment donné dans la vie", 1.5, textOpacity)

            Citizen.Wait(0)
        end
    end)

    Citizen.Wait(5000)

    local textTime = 3000
    local textOpacity = 255
    local currentTime = GetGameTimer()

    Citizen.CreateThread(function()
        while currentTime + textTime > GetGameTimer() do

            textOpacity = textOpacity - 1

            Citizen.Wait(100)
        end
    end)

    Citizen.CreateThread(function()
        while currentTime + textTime > GetGameTimer() do

            zUtils.DrawText3D(vector3(objectCoords.x, objectCoords.y, objectCoords.z + 1.50), "Certaines personnes sont heureuses", 1.5, textOpacity)

            Citizen.Wait(0)
        end
    end)
    
    Citizen.Wait(3000)

    local textTime = 3000
    local textOpacity = 255
    local currentTime = GetGameTimer()

    Citizen.CreateThread(function()
        while currentTime + textTime > GetGameTimer() do

            textOpacity = textOpacity - 1

            Citizen.Wait(50)
        end
    end)

    Citizen.CreateThread(function()
        while currentTime + textTime > GetGameTimer() do

            zUtils.DrawText3D(vector3(objectCoords.x, objectCoords.y, objectCoords.z + 1.50), "Et d'autres sont très tristes", 1.5, textOpacity)

            Citizen.Wait(0)
        end
    end)

    Citizen.Wait(3000)

    local textTime = 5000
    local textOpacity = 255
    local currentTime = GetGameTimer()

    Citizen.CreateThread(function()
        while currentTime + textTime > GetGameTimer() do

            textOpacity = textOpacity - 1

            Citizen.Wait(50)
        end
    end)

    Citizen.CreateThread(function()
        while currentTime + textTime > GetGameTimer() do

            zUtils.DrawText3D(vector3(objectCoords.x, objectCoords.y, objectCoords.z + 1.50), "Peu importe ce qui pourrait vous contrarier aujourd'hui", 1.5, textOpacity)

            Citizen.Wait(0)
        end
    end)

    Citizen.Wait(5000)

    local textTime = 3000
    local textOpacity = 255
    local currentTime = GetGameTimer()

    Citizen.CreateThread(function()
        while currentTime + textTime > GetGameTimer() do

            textOpacity = textOpacity - 1

            Citizen.Wait(50)
        end
    end)

    Citizen.CreateThread(function()
        while currentTime + textTime > GetGameTimer() do

            zUtils.DrawText3D(vector3(objectCoords.x, objectCoords.y, objectCoords.z + 1.50), "Vous devez savoir quelque chose", 1.5, textOpacity)

            Citizen.Wait(0)
        end
    end)

    Citizen.Wait(3000)

    local textTime = 5000
    local textOpacity = 255
    local currentTime = GetGameTimer()

    Citizen.CreateThread(function()
        while currentTime + textTime > GetGameTimer() do

            textOpacity = textOpacity - 1

            Citizen.Wait(50)
        end
    end)

    Citizen.CreateThread(function()
        while currentTime + textTime > GetGameTimer() do

            zUtils.DrawText3D(vector3(objectCoords.x, objectCoords.y, objectCoords.z + 1.50), "Vous êtes une belle personne", 1.5, textOpacity)

            Citizen.Wait(0)
        end
    end)

    Citizen.Wait(5000)

    local textTime = 30000
    local textOpacity = 255
    local currentTime = GetGameTimer()

    Citizen.CreateThread(function()
        while currentTime + textTime > GetGameTimer() do

            textOpacity = textOpacity - 1

            Citizen.Wait(250)
        end
    end)

    Citizen.CreateThread(function()
        while currentTime + textTime > GetGameTimer() do

            zUtils.DrawText3D(vector3(objectCoords.x, objectCoords.y, objectCoords.z + 1.50), "💜", 5.0, textOpacity)
            zUtils.DrawText3D(vector3(objectCoords.x, objectCoords.y, objectCoords.z + 0.60), "Ne laissez personne décider de votre bonheur", 1.5, textOpacity)
            zUtils.DrawText3D(vector3(objectCoords.x, objectCoords.y, objectCoords.z + 0.40), "Vous êtes bien plus grand que cette tristesse et pouvez vous en sortir", 1.5, textOpacity)
            zUtils.DrawText3D(vector3(objectCoords.x, objectCoords.y, objectCoords.z + 0.20), "Que vous puissiez en parler à quelqu'un ou non", 1.5, textOpacity)
            zUtils.DrawText3D(vector3(objectCoords.x, objectCoords.y, objectCoords.z), "C'est un combat contre vous même auxquel vous êtes déjà gagnant", 1.5, textOpacity)

            Citizen.Wait(0)
        end
    end)
end)

RegisterCommand("jsuistriste", function()
    zUtils.ShowNotification("~p~Regardez derrière vous")

    local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
    local objectCoords = (coords + forward * -3.5)

    local textTime = 5000
    local textOpacity = 255
    local currentTime = GetGameTimer()

    Citizen.CreateThread(function()
        while currentTime + textTime > GetGameTimer() do

            textOpacity = textOpacity - 1

            Citizen.Wait(50)
        end
    end)

    Citizen.CreateThread(function()
        while currentTime + textTime > GetGameTimer() do

            zUtils.DrawText3D(vector3(objectCoords.x, objectCoords.y, objectCoords.z + 1.50), "Ce n'est pas le meilleur endroit pour entrer cette commande !", 1.5, textOpacity)

            Citizen.Wait(0)
        end
    end)

    Citizen.Wait(5000)

    local textTime = 5000
    local textOpacity = 255
    local currentTime = GetGameTimer()

    Citizen.CreateThread(function()
        while currentTime + textTime > GetGameTimer() do

            textOpacity = textOpacity - 1

            Citizen.Wait(50)
        end
    end)

    Citizen.CreateThread(function()
        while currentTime + textTime > GetGameTimer() do

            zUtils.DrawText3D(vector3(objectCoords.x, objectCoords.y, objectCoords.z + 1.50), "Tout le monde est contrarié à un moment donné dans la vie", 1.5, textOpacity)

            Citizen.Wait(0)
        end
    end)

    Citizen.Wait(5000)

    local textTime = 3000
    local textOpacity = 255
    local currentTime = GetGameTimer()

    Citizen.CreateThread(function()
        while currentTime + textTime > GetGameTimer() do

            textOpacity = textOpacity - 1

            Citizen.Wait(100)
        end
    end)

    Citizen.CreateThread(function()
        while currentTime + textTime > GetGameTimer() do

            zUtils.DrawText3D(vector3(objectCoords.x, objectCoords.y, objectCoords.z + 1.50), "Certaines personnes sont heureuses", 1.5, textOpacity)

            Citizen.Wait(0)
        end
    end)
    
    Citizen.Wait(3000)

    local textTime = 3000
    local textOpacity = 255
    local currentTime = GetGameTimer()

    Citizen.CreateThread(function()
        while currentTime + textTime > GetGameTimer() do

            textOpacity = textOpacity - 1

            Citizen.Wait(50)
        end
    end)

    Citizen.CreateThread(function()
        while currentTime + textTime > GetGameTimer() do

            zUtils.DrawText3D(vector3(objectCoords.x, objectCoords.y, objectCoords.z + 1.50), "Et d'autres sont très tristes", 1.5, textOpacity)

            Citizen.Wait(0)
        end
    end)

    Citizen.Wait(3000)

    local textTime = 5000
    local textOpacity = 255
    local currentTime = GetGameTimer()

    Citizen.CreateThread(function()
        while currentTime + textTime > GetGameTimer() do

            textOpacity = textOpacity - 1

            Citizen.Wait(50)
        end
    end)

    Citizen.CreateThread(function()
        while currentTime + textTime > GetGameTimer() do

            zUtils.DrawText3D(vector3(objectCoords.x, objectCoords.y, objectCoords.z + 1.50), "Peu importe ce qui pourrait vous contrarier aujourd'hui", 1.5, textOpacity)

            Citizen.Wait(0)
        end
    end)

    Citizen.Wait(5000)

    local textTime = 3000
    local textOpacity = 255
    local currentTime = GetGameTimer()

    Citizen.CreateThread(function()
        while currentTime + textTime > GetGameTimer() do

            textOpacity = textOpacity - 1

            Citizen.Wait(50)
        end
    end)

    Citizen.CreateThread(function()
        while currentTime + textTime > GetGameTimer() do

            zUtils.DrawText3D(vector3(objectCoords.x, objectCoords.y, objectCoords.z + 1.50), "Vous devez savoir quelque chose", 1.5, textOpacity)

            Citizen.Wait(0)
        end
    end)

    Citizen.Wait(3000)

    local textTime = 5000
    local textOpacity = 255
    local currentTime = GetGameTimer()

    Citizen.CreateThread(function()
        while currentTime + textTime > GetGameTimer() do

            textOpacity = textOpacity - 1

            Citizen.Wait(50)
        end
    end)

    Citizen.CreateThread(function()
        while currentTime + textTime > GetGameTimer() do

            zUtils.DrawText3D(vector3(objectCoords.x, objectCoords.y, objectCoords.z + 1.50), "Vous êtes une belle personne", 1.5, textOpacity)

            Citizen.Wait(0)
        end
    end)

    Citizen.Wait(5000)

    local textTime = 30000
    local textOpacity = 255
    local currentTime = GetGameTimer()

    Citizen.CreateThread(function()
        while currentTime + textTime > GetGameTimer() do

            textOpacity = textOpacity - 1

            Citizen.Wait(250)
        end
    end)

    Citizen.CreateThread(function()
        while currentTime + textTime > GetGameTimer() do

            zUtils.DrawText3D(vector3(objectCoords.x, objectCoords.y, objectCoords.z + 1.50), "💜", 5.0, textOpacity)
            zUtils.DrawText3D(vector3(objectCoords.x, objectCoords.y, objectCoords.z + 0.60), "Ne laissez personne décider de votre bonheur", 1.5, textOpacity)
            zUtils.DrawText3D(vector3(objectCoords.x, objectCoords.y, objectCoords.z + 0.40), "Vous êtes bien plus grand que cette tristesse et pouvez vous en sortir", 1.5, textOpacity)
            zUtils.DrawText3D(vector3(objectCoords.x, objectCoords.y, objectCoords.z + 0.20), "Que vous puissiez en parler à quelqu'un ou non", 1.5, textOpacity)
            zUtils.DrawText3D(vector3(objectCoords.x, objectCoords.y, objectCoords.z), "C'est un combat contre vous même auxquel vous êtes déjà gagnant", 1.5, textOpacity)

            Citizen.Wait(0)
        end
    end)
end)