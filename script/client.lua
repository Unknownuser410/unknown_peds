ESX = exports["es_extended"]:getSharedObject()
spawned = false


--Set Ped via Command--
RegisterNetEvent("unknown_peds:setped", function(ped)
    if IsModelInCdimage(ped) and IsModelValid(ped) then

        RequestModel(ped)
        while not HasModelLoaded(ped) do
          Wait(100)
        end

        SetPlayerModel(PlayerId(), ped)
        SetModelAsNoLongerNeeded(ped)

        --Load Ped Clothes--
        TriggerEvent('skinchanger:getSkin', function(skin) 
            lastSkin = skin 
            TriggerEvent('skinchanger:loadSkin', lastSkin)
        end) 
        -----------------
    else
        print("Ped konnte nicht gefunden werden!")
    end
end)
-----------------------


--Load Ped on Spawn--
AddEventHandler('playerSpawned', function() 
    if not spawned then 
        spawned = true
        TriggerServerEvent("unknown_peds:getped")
    end
end)
------------------