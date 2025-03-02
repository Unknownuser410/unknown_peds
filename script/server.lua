ESX = exports["es_extended"]:getSharedObject()


--Give Ped--
RegisterCommand("setped", function(source,args,rawcommand)
    local xPlayer = ESX.GetPlayerFromId(args[1])
    local ped = args[2]

    if ped == "male" or ped == "female" then 
        MySQL.Async.execute("UPDATE `users` SET `ped` = NULL WHERE `identifier` = ?", {xPlayer.identifier})

        if ped == "male" then 
            TriggerClientEvent("unknown_peds:setped", args[1], "mp_m_freemode_01")
        else
            TriggerClientEvent("unknown_peds:setped", args[1], "mp_f_freemode_01")
        end
    else
        MySQL.Async.execute('UPDATE `users` SET `ped` = @ped WHERE `identifier` = @identifier', {['@ped'] = ped, ['@identifier'] = xPlayer.identifier})
        TriggerClientEvent("unknown_peds:setped", args[1], ped)
    end
end, true)
--------------------


--Load Ped on Serverestart--
RegisterNetEvent("unknown_peds:getped", function()
    xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll('SELECT ped FROM users WHERE identifier = @identifier', { ['@identifier'] = xPlayer.identifier}, function(result)
        local ped = result[1].ped
        if ped then 
            TriggerClientEvent("unknown_peds:setped", ped)
        end
    end)
end)
------------------------------

--Version Check--
Citizen.CreateThread(function()
    local resourceName = GetCurrentResourceName()
    local currentVersion = GetResourceMetadata(resourceName, 'version', 0)

    PerformHttpRequest('https://api.github.com/repos/Unknownuser410/unknown_peds/releases/latest', function(error, result, headers)
        if error == 200 then
            local data = json.decode(result)  -- JSON antwort decodieren
            local latestVersion = data.tag_name  -- Die neueste Version vom GitHub Release
            local changelog = data.body or ""
            latestVersion = latestVersion:match("^v?(.*)") -- Entferne das 'v' von der GitHub-Version, falls vorhanden
            changelog = changelog:gsub("#", "") -- Entferne das '#' vom Changelog, falls vorhanden

            if latestVersion ~= currentVersion then
                print("Es gibt eine neue Version! ^1Aktuelle Version: " ..currentVersion.. "^0 | ^2Neueste Version: " ..latestVersion.."^0", "\n^2Changelog:^0\n" ..changelog)
            end
        else
            print("Fehler beim Abrufen der GitHub-Daten: " .. error)
        end
    end, 'GET')
end)
---------------------
